#!/usr/bin/python
# -*- coding: utf-8 -*-
import MySQLdb
from content import *
from keywords_abstract import *
from logger import logger

def run_task(db):
  # 使用cursor()方法获取操作游标 
  cursor = db.cursor()
  query_sql = "SELECT id,url FROM task_article_feature_view"

  try:
    cursor.execute(query_sql) # 执行SQL语句
    row = cursor.fetchone() # 获取一条记录
  except Exception as e:
    row = None
    logger.error("fail to execute SQL: %s, or unable to fecth data: %s" % (query_sql,e))

  if row:
    id = row[0]
    url = row[1]
    logger.info("id=%d,url=%s" % (id,url)) #记录调用的url

    #正在处理状态...
    update_sql = "UPDATE task_article_log SET feature_status=%d,updatedt=now() WHERE id=%d" % (1,id)
    try:
      cursor.execute(update_sql)
      db.commit()
      status_tag = 1
    except Exception as e:
      db.rollback()
      status_tag = -1
      logger.error("fail to execute SQL: %s, reason: %s" % (update_sql,e))

    if status_tag == 1:
      status,title,content,article_type=fetch_content(url) #返回utf-8的str
    else:
      status = -1

    if status == 2: # api调用成功
      try:
        keywords,abstract = fetch_keywords_abstrct(content) #返回utf-8的str
      except Exception as e:
        status_tag = -1
        logger.error("fail to call function: fetch_keywords_abstrct(), reason: %s" % e)
    else:
        status_tag = -1

    try:
      db.ping()
    except:
      db=connect_mysql()
      cursor = db.cursor()

    if status_tag == 1:
      insert_sql="INSERT INTO result_article_feature_log (id,title,classes,keywords,abstract,insertdt) VALUES (%d,'%s','%s','%s','%s',now())" % (id,title,article_type,keywords,abstract)
      update_sql="UPDATE task_article_log SET feature_status=%d,feature_times=feature_times+1,updatedt=now() WHERE id=%d" % (status,id)
      try:
        cursor.execute(insert_sql) # 执行SQL语句
        cursor.execute(update_sql) # 执行SQL语句
        db.commit() # 提交到数据库执行
      except Exception as e:
        db.rollback() # 发生错误时回滚
        status_tag = -1
        logger.error("fail to execute insert SQL(%s) or update SQL(%s), reason: %s" % (insert_sql,update_sql,e))

    if status_tag == -1:
      update_sql="UPDATE task_article_log SET feature_status=%d,feature_times=feature_times+1,updatedt=now() WHERE id=%d" % (-1,id)
      try:
        cursor.execute(update_sql) # 执行SQL语句
        db.commit() # 提交到数据库执行
      except Exception as e:
        db.rollback() # 发生错误时回滚
        logger.error("fail to execute SQL: %s, reason: %s" % (update_sql,e))

  db.close() # 关闭数据库连接

# for test
# db=connect_mysql()
# run_task(db)
