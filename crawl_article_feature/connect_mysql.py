#!/usr/bin/python
# -*- coding: utf-8 -*-
import MySQLdb
from logger import logger

def connect_mysql():
  config={'user':'dc',
          'passwd':'mCdlUmm3thna5ttup',
          'host':'54.223.25.73',
          'db':'addition_profit_db'
          }
  try:
    db=MySQLdb.connect(user=config['user'],passwd=config['passwd'],host=config['host'],db=config['db'],charset="utf8")
  except Exception as e:
    logger.error("fail to connect mysql database, reason: %s" % e)
    return None
  return db

# 测试
# db=connect_mysql()
# print "OK"

