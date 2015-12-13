from functools import wraps
from app.loggly.http import HttpResponseUnauthorized
from django import http
from django.conf import settings
from django.contrib.admin.forms import AdminAuthenticationForm
from django.http import HttpResponse
from django.utils.translation import ugettext_lazy, ugettext as _
from django.contrib.auth import REDIRECT_FIELD_NAME
import logging

ERROR_MESSAGE = ugettext_lazy("Please enter a correct username and password. "
                              "Note that both fields are case-sensitive.")
LOGIN_FORM_KEY = 'this_is_the_login_form'

def api_handler_oauth_forbidden( api_handler_method ):
    """
        Forbid OAuth authenticated users from accessing the decorated
        Piston handler method.
    """
    def decorator(handler_self, *args, **kwargs):
        request = args[0]
        if hasattr(request, 'oauth') and request.oauth:
            return http.HttpResponseForbidden(
                '%s on %s is forbidden via OAuth authentication.\n' % (request.method, request.path)
            )
        else:
            return api_handler_method(handler_self, *args, **kwargs)

    decorator.__doc__ = api_handler_method.__doc__
    decorator.__name__ = api_handler_method.__name__

    return decorator

def unauthed_ajax_forbidden( status=401 ):
    '''
        Decorator for view functions.
        If the wrapped function is invoked by an XmlHttpRequest
        _and_ is not authenticated, simply return a 403 status code
        instead of redirecting to the login page as the
        @login_required decorator does.

        You can wrap this around a view that is already wrapped
        with @login_required. This has no effect on non-XmlHttpRequests
    '''
    def new_func(view_func):
        def decorator( request, *args, **kwargs):
            if request.is_ajax() and not request.user.is_authenticated():
                logging.debug({"Unauth'd XHR request": "%s" % request.path})
                return HttpResponse('Forbidden XHR request %s: User not authenticated.' %
                                                request.path, status=status)
            else:
                return view_func( request, *args, **kwargs)

        decorator.__doc__ = view_func.__doc__
        decorator.__name__ = view_func.__name__
        return decorator
    return new_func

def set_csrf_cookie( view_func ):
    '''
        Ensures that the CSRF cookie set for the decorated view.
    '''

    def decorator( request, *args, **kwargs):
        request.META["CSRF_COOKIE_USED"] = True
        return view_func( request, *args, **kwargs)

    decorator.__doc__ = view_func.__doc__
    decorator.__name__ = view_func.__name__
    return decorator

def set_login_page_header( view_func ):
    '''
        Sets the X-Loggly-page header to 'login', which the modal
        code watches for. If it sees 'login' it will know that it should
        redirect the user to the login page
    '''

    def decorator( request, *args, **kwargs):
        view_response = view_func( request, *args, **kwargs)
        if isinstance( view_response, http.HttpResponse ):
            view_response['X-Loggly-page'] = 'login'
        return view_response

    decorator.__doc__ = view_func.__doc__
    decorator.__name__ = view_func.__name__
    return decorator

def dev_only(view_func):
    if settings.DEV:
        return view_func
    def not_there(request):
        # pylint:disable=W0613
        return http.HttpResponseNotFound()
    return not_there

def ignore_request(view_func):
    def new_func(request, *args, **kwargs):
        # pylint:disable=W0613
        return view_func(*args, **kwargs)
    return wraps(view_func)(new_func)

def add_no_cache_header(view_func):
    """ We know that there is a Django never_cache decorator, but this one is
        stricter and handles the issues where Safari 7.1+ doesn't respect
        "max-age: 0" cache declarations.
    """

    k = settings.SET_NO_CACHE_HEADER_KEY

    def decorator( request, *args, **kwargs):
        request.META[k] = True
        return view_func( request, *args, **kwargs)

    decorator.__doc__ = view_func.__doc__
    decorator.__name__ = view_func.__name__

    return decorator

