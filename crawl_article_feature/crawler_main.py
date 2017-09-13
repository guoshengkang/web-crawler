#!/usr/bin/python
# -*- coding: utf-8 -*-
from connect_mysql import *
from running_task import *
from logger import logger
import threading
import time

def runmysql(mysql_conn):
  cur = mysql_conn.cursor() 
  try:
    cur.callproc("proc_integrate_article")
    mysql_conn.commit()
  except Exception as e:
    logger.error("fail to callproc, reason: %s" % e)
  cur.close()
  mysql_conn.close()

def main():
  while True:
    conn1 = connect_mysql() # from connect_mysql
    conn2 = connect_mysql() # from connect_mysql

    time.sleep(10)
    t0 = threading.Thread(target=runmysql, args=(conn1,))
    t0.start()

    time.sleep(20)
    t1 = threading.Thread(target=run_task, args=(conn2,))
    t1.start()

if __name__ == '__main__':
    main()
