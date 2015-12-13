################################################################################
#
# Copyright (c)2011, Loggly, Inc.
# "Leave it to the Beaver."
#
# View for calls that will fill the dashboard.
# These calls are made after the main welcome view loads.
# Deferred AJAX calls will then pull from these views and just blast the
# returned HTML fragments into their respective DIVs
#
################################################################################

import logging

from django.template import Template, Context

from app.notifications.models import Notification
from app.loggly.decorators import set_login_page_header
from django.contrib import messages
from django.conf import settings
from app.billing.schedules import Schedule
from app.customer.models import Customer

from app.account.auto_login import retrieve_user_id
from app.account.backends import CustomerOverage, CustomerOverageException
from app.account.backends import daily_usage_backend_cb, daily_usage_backend_cotd
from app.registration.forms import LogglyLoginForm
from django.contrib import auth
from django.contrib.auth import views as auth_views, authenticate, REDIRECT_FIELD_NAME
from django.core.validators import email_re
from django.contrib.auth.models import User
from django.core.exceptions import MultipleObjectsReturned
from django.http import HttpResponseRedirect, HttpResponse, HttpResponseNotFound
from django.views.decorators.csrf import csrf_protect
from django.contrib.auth.decorators import login_required
import requests

def impersonate_owner(request, customer, username, password):
    """
        Given a Customer and a valid login, return the User
        object representing the owner of the Customer.

        Returns None if authentication fails.
    """
    user = None

    log_obj = {'object':'login', 'action':'root_login',
               'status':'successful', 'source':request.META.get('REMOTE_ADDR') }
    if not isinstance(customer, Customer):
        customer = Customer.objects.get(subdomain=customer)
    if authenticate(username=username, password=password):
        # owner for the subdomain in question. That's the guy we
        # want to impersonate
        user = customer.owner
        user.backend = 'django.contrib.auth.backends.ModelBackend'

        log_obj.update({'status':'successful'})
        logging.info(log_obj)
    else:
        log_obj.update({'status':'failed'})
        logging.critical(log_obj)

    return user

def check_email_or_username(request, customer, username):
    """Check if the username is an email,
    Return a username string.
    """

    if email_re.match(username):
        try:
            username = User.objects.get(email=username, profile__customer=customer).username
        except User.DoesNotExist:
            m = "Your login failed. Email or password may be incorrect. Please give it another shot."
            messages.add_message(request, messages.INFO, m)
        except MultipleObjectsReturned:
            m = "Multiple email addresses found for : " + username
            messages.add_message(request, messages.INFO, m)
    else:
        username = "%s_%s" % (customer.subdomain, username)

    return username

def handle_subdomain(request):
    '''returns either a customer object or a response'''
    host = request.META.get('HTTP_HOST', '')
    subdomain = host.split('.')[0]

    if subdomain == 'www':
        return HttpResponseRedirect('/login')

    if settings.FORCE_HTTPS and not request.is_secure():
        path = request.path
        qs = request.META['QUERY_STRING']
        qs = qs and ('?' + qs)
        return HttpResponseRedirect('https://%s%s%s' % (host, path, qs))

    customer = None

    # First verify that we hit a registered subdomain
    if subdomain in settings.RESERVED_DOMAINS:
        logging.error({'object':'login', 'action':'login',
               'reason':'invalid subdomain access',
               'sub_reason': 'loggly domain', 'subdomain':subdomain})
        return HttpResponseRedirect(
            "%s://%s" % ('https' if request.is_secure() else 'http', 'www.loggly.com')
        )

    try:
        customer = Customer.objects.get(subdomain=subdomain)
    except Customer.DoesNotExist:

        logging.error({'object':'login', 'action':'login',
            'reason':'invalid subdomain access', 'subdomain':subdomain})
        return HttpResponseRedirect('/accounts/invalid')

    # TODO: unhardcode this deprecated Gen1 behaviour
    if not 'forcelogin' in request.GET and customer.provisioner.name == 'Heroku':
        return ('registration/backtoheroku.html', {})

    return customer

def attempt_user_login(request, user, redirect_to, url_hash):
    '''
        helper method to log user in
    '''

    if user.is_active:
        auth.login(request, user)

        # show the login trackers if this is the  initial login for this session.
        request.session['show_login_trackers'] = True

        return HttpResponseRedirect(redirect_to + url_hash)
    else:
        m = "This user has been disabled. Please contact support@loggly.com"
        messages.add_message(request, messages.INFO, m)

    return False


@set_login_page_header
def login(request, redirect_field_name=REDIRECT_FIELD_NAME, **kwargs):
    '''
    This will redirect to the main home page if the subdomain is not registered
    '''
    template_name = 'login/login.html'
    login_form = LogglyLoginForm

    customer_or_response = handle_subdomain(request)

    if not isinstance(customer_or_response, Customer):
        return customer_or_response

    customer = customer_or_response

    # Where are they going?
    redirect_to = request.REQUEST.get(redirect_field_name, '')
    url_hash = request.REQUEST.get('url_hash', '')
    token = request.REQUEST.get('token', '')

    if not redirect_to or '//' in redirect_to or ' ' in redirect_to:
        redirect_to = settings.LOGIN_REDIRECT_URL

    # This should only be triggered upon the initial login immediately after
    # a new account signup, whence a one-time-use login token is generated to use as
    # a proxy for login credentials.
    if token and customer:
        user_id = retrieve_user_id(token)
        user = customer.owner

        if user.id == user_id:

            user.backend = 'django.contrib.auth.backends.ModelBackend'
            login_redirect = attempt_user_login(request, user, redirect_to, url_hash)

            if login_redirect:
                # The standard Django login behaviour is to set the initial
                # CSRF at posting the login form. With auto-login tokens, the
                # login is processed via a GET, so this behaviour is not triggered
                # We must manually set the cookie here...
                login_redirect.set_cookie(settings.CSRF_COOKIE_NAME,
                        request.META["CSRF_COOKIE"], max_age = 60 * 60 * 24 * 7 * 52,
                        domain=settings.CSRF_COOKIE_DOMAIN)

                return login_redirect

    # take them to their destination if they're already logged in
    if request.user.is_authenticated():
        return HttpResponseRedirect(redirect_to)

    if request.method == "POST":
        user = None

        username = request.POST['username']
        password = request.POST['password']

        # One can log in with the root user to gain access to any
        # subdomain's owner
        if username == settings.ROOT_USER_NAME:
            authuser = settings.ROOT_USER_NAME
            user = impersonate_owner(request, customer, username, password)
        else:
            authuser = check_email_or_username(request, customer, username)
            user = authenticate(username=authuser, password=password)

        if user:
            login_redirect = attempt_user_login(request, user, redirect_to, url_hash)
            if login_redirect:
                return login_redirect
        else:
            logging.error({'object':'login', 'action':'authentication', 'user':authuser})

    from_signup = request.GET.get('signup')

    # defer the rest of the work to Django's built-in login method
    return auth_views.login(request, template_name,
        authentication_form=login_form,
        extra_context={'show_signup_trackers': from_signup},
        **kwargs)

@login_required
def overview(request):
    section = 'account'
    user = request.user
    profile = user.get_profile()
    customer = profile.customer
    account_overages = None

    page = 'overview'

    sub = customer.current_subscription
    subscription_plan = {
        'volume_bytes': str(sub.volume_bytes),
        'retention_days': str(sub.retention_days),
        'billing_period': str(sub.billing_period),
        'subscription_rate': str(sub.subscription_rate),
    }
    try:
        if settings.COTD_CAPPING_OVERVIEW:
            start = settings.COTD_CAPPING_OVERVIEW_START
            end = settings.COTD_CAPPING_OVERVIEW_END
            customer_cid = getattr(settings, "COTD_CUST_ID_OVERRIDE", customer.cid)
            customer_overage = CustomerOverage(customer_cid, start, end)
            account_overages = customer_overage.usage_table_formatted_events()
            # sort by latest overage instance being first
            account_overages = reversed(sorted(account_overages, key=lambda x: x['instance']))
        else:
            account_overages = []

    except CustomerOverageException, e:
        msg = 'customer overage table exception: %s' % e
        logging.error(msg)

    context = {
        'has_footer': True,
        'section': section,
        'page': page,
        'subscription_plan': subscription_plan,
        'is_use_crystalball': settings.DAILY_USAGE_USE_CRYSTAL_BALL,
        'account_overages': account_overages,
        'CUSTOMER_CAPPING_OVERVIEW': settings.COTD_CAPPING_OVERVIEW,
        'CUSTOMER_CAPPING_HEADER_STRING': getattr(settings, 'CUSTOMER_CAPPING_HEADER_STRING', '')
    }

    return ('account/overview/overview.html', context)

@login_required
def daily_usage(request):
    """ Handles both Crystal Ball and CotD daily  volume
        usage graph data requests
    """

    customer = request.user.get_profile().customer

    if settings.DAILY_USAGE_USE_CRYSTAL_BALL:
        series_data =  daily_usage_backend_cb(customer)

    elif settings.DAILY_USAGE_USE_COTD:
        series_data = daily_usage_backend_cotd(customer)

    else:
        return HttpResponseNotFound("Daily Usage graph backend not configured.")

    return HttpResponse(series_data)
