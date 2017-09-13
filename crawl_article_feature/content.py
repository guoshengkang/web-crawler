#!/usr/bin/python
# -*- coding: utf-8 -*-
import json
import random, time
from logger import logger
from src.QcloudApi.qcloudapi import QcloudApi
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

def fetch_content(url):
  module = 'wenzhi'
  secretId='AKIDnOjodAwaS6WigQAEMGxQfgT3PZWFf27y' # config
  secretKey='lJdjbFfsrc9f194mGWbR2RaU9ZjvueAR'    # config

  config = {
      'Region': 'sh',
      'secretId': secretId,
      'secretKey': secretKey,
      'method': 'post'
      }
  service = QcloudApi(module, config)  #通过

  status=-1 #调用状态,初始化为失败状态-1

  try:
    params1={
        'Action' : 'ContentGrab',
        'Nonce' : random.randint(1, 10000000),
        'Region' : 'sh',
        'SecretId' : secretId,
        'Timestamp' : int(time.time()),
        'url': url
        }
    result=service.call('ContentGrab', params1) #返回json格式的字符串,可能会报错
    text = json.loads(result) #导入json格式的字符串,生成字典
    if text[u'code']==0 and text[u'title']!='': #错误码, 0: 成功, 其他值: 失败
      # 400-HTTP Method不正确;401-HTTP请求参数不符合要求;503-调用额度已超出限制;504-服务故障
      title=text[u'title'].encode("utf-8")
      content=text[u'content'].encode("utf-8")
      status=2 #api调用成功
      logger.info("call ContentGrab api success!!!") 
    else:
      status=-1
      logger.info("call ContentGrab api failure!!!") 
      logger.info('code:%s;codeDesc:%s;message:%s'%(text[u'code'],text[u'codeDesc'],text[u'message']))
  except Exception as e:
    status=-1
    logger.error("call ContentGrab api error: %s" % e)

  if status==2:
    try:
      params2={
      'Action' : 'TextClassify',
      'Nonce' : random.randint(1, 10000000),
      'Region' : 'sh',
      'SecretId' : secretId,
      'Timestamp' : int(time.time()),
      'content': content}
      result2=service.call('TextClassify', params2) #返回json格式的字符串,可能会报错
      text2 = json.loads(result2) #导入json格式的字符串,生成字典
      if text2[u'code']==0:
        line=["%s:%f"%(x["class"],x["conf"]) for x in text2[u'classes']]
        article_type=";".join(line).encode("utf-8")
        status=2 #api调用成功
        logger.info("call TextClassify api success!!!") 
      else:
        status=-1
        logger.info("call TextClassify api failure!!!") 
        logger.info('code:%s;codeDesc:%s;message:%s'%(text2[u'code'],text2[u'codeDesc'],text2[u'message']))
    except Exception as e: 
      status=-1
      logger.error("call TextClassify api error: %s" % e)


  if status==2:
    return status,title,content,article_type
  else:
    return status,"","",""

# 测试
# url='http://s.weibo.com/top/summary?cate=total&key=all'
# status,title,content,article_type=fetch_content(url)
# print status,title,content,article_type
