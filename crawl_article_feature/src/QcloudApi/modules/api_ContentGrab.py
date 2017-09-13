#!/usr/bin/python
# -*- coding: utf-8 -*-
import json
from base import Base

class Wenzhi(Base):
    requestHost = 'wenzhi.api.qcloud.com'

def ContentGrab_api():
    action = 'ContentGrab'
    config = {
        'Region': 'sh',
        'secretId': 'AKIDnOjodAwaS6WigQAEMGxQfgT3PZWFf27y',
        'secretKey': 'lJdjbFfsrc9f194mGWbR2RaU9ZjvueAR',
        'method': 'post'
    }
    params = {
        "url" : "http://chuansong.me/n/1894528352619",
    }
    service = Wenzhi(config)
    text=service.call(action, params)

def TextClassify_api(content):
    action = 'TextClassify'
    config = {
        'Region': 'sh',
        'secretId': 'AKIDnOjodAwaS6WigQAEMGxQfgT3PZWFf27y',
        'secretKey': 'lJdjbFfsrc9f194mGWbR2RaU9ZjvueAR',
        'method': 'post'
    }
    params = {
        "content" : content,
    }
    service = Wenzhi(config)
    print service.call(action, params)

if (__name__ == '__main__'):
    # ContentGrab_api()
    content=u"根据HTTP规范"
    content=content.encode('utf-8')
    print TextClassify_api(content)
