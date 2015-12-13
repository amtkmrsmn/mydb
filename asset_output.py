#############################################
#
# Tag for gathering and outputting tags for  JS and CSS assets
#
# Copyright (c)2010 Loggly Inc.
# "Leave it to the Beaver."
#
from django.template import Library, Node, TemplateSyntaxError
from django.conf import settings

import os, hashlib, stat

from app.assets.models import Asset

register = Library()

class MediaAssetTag(Node):
    '''
    Take a type of media asset (.js, .css) and
    either set it up for dev mode or for production
    production applies minification for better page
    weight  and file-merging to
    reduce GETs from the browser.
    '''
    media_dir  = settings.MEDIA_ROOT
    merged_dir = settings.MERGED_MEDIA_ROOT
    rel_path = settings.MERGED_MEDIA_RELATIVE_PATH

    file_extension = None
    tag_template = None

    def __init__(self, **kwargs):
        super(MediaAssetTag, self).__init__()
        self.name = kwargs.get('name','')

        self.src_attr_dir = "%s/%s/" % (self.rel_path, self.name)

        self.force_merge = kwargs.get('force_merge') or\
            getattr(settings, 'MEDIA_MIN_MERGE', True)

    def render(self, context):
        if self.force_merge or not os.path.exists(self.asset.path):
            return self.render_modified()
        else:
            return self.render_unmodified()

    def render_modified(self):
        if not os.path.isdir(self.asset.path):
            raise ValueError('We have our JS Asset Tag merge_path but it is a file not a directory')

        ls = os.listdir(self.asset.path)
        src_attr_file = sorted(
            [ (os.path.getmtime(self.asset.path + f), f) for f in ls ],
            key=lambda x: x[0])[-1][1]

        return self.tag_template % (self.src_attr_dir, src_attr_file)

    def render_unmodified(self):
        tag = []
        for f in self.asset.files:
            tag.append( self.tag_template % (settings.MEDIA_RELATIVE_PATH, f) )
        return "".join(tag)
       

class JSAssetTag(MediaAssetTag):

    tag_template = '<script defer type="text/javascript" src="%s/%s"></script>'

    def __init__(self, **kwargs):
        super(JSAssetTag, self).__init__(**kwargs)
        self.asset = Asset(self.name)
            

class CSSAssetTag(MediaAssetTag):

    tag_template = '<link rel="stylesheet" type="text/css" media="screen" href="%s/%s" />'

    def __init__(self, **kwargs):
        super(CSSAssetTag, self).__init__(**kwargs) 
        self.asset = Asset(self.name)


@register.tag
def asset_output(parser, token):
    '''
    Outputs our asset in different environments
    '''
    #pylint: disable=W0613
    tokens = token.contents.split()
    media_type = None
    force_merge = False

    if len(tokens) < 3:
        raise TemplateSyntaxError(u'''Please specify media type followed by asset name.'
            u' ie. js preload || css merged.''')
    else:
        media_type = tokens[1].lower()
        name = tokens[2].lower()
        if len(tokens) > 3:
            force_merge = tokens[3] == 'force_merge'

    if media_type == 'js':
        return JSAssetTag(name=name, force_merge=force_merge)
    elif media_type == 'css':
        return CSSAssetTag(name=name, force_merge=force_merge)
    else:
        raise TemplateSyntaxError(u'Only css and js supported.')
