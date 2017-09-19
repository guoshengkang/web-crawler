#!/usr/bin/python
# -*- coding: utf-8 -*-
import time
from crawler_html import *
from logger import logger
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

def main():
  try:
    html=get_html("http://top.baidu.com/buzz?b=42&c=513&fr=topbuzz_b342_c513")
  except Exception as e:
    logger.error("get HTML document error: %s"%e)

  output_filename="idl_recom_hot_search_keywords_log.csv"
  try:
    process(html,output_filename)
  except Exception as e:
    logger.error("process HTML document error: %s"%e)

  try:
    partition=sys.argv[1] #分区p{0}
    # partition=time.strftime('%Y-%m-%d')
    drop_partition_command='''hive -e \
    "alter table leesdata.idl_recom_hot_search_keywords_log drop partition(ds='%s')"'''%partition
    load_data_command='''hive -e \
    "load data local inpath '/data1/shell/job_control/task_file/recom_daily/python_code/idl_recom_hot_search_keywords_log.csv' \
    into table leesdata.idl_recom_hot_search_keywords_log partition(ds='%s')"'''%partition
  except Exception as e:
    logger.error("get sys.argv[1] error: %s"%e)

  try:
    drop_partition_result=os.system(drop_partition_command) #删除分区
    if drop_partition_result==1:
      logger.error("execute drop_partition_command error!!!")
      
    load_data_result=os.system(load_data_command) #加载分区数据
    if load_data_result==1:
      logger.error("execute load_data_command error!!!")
  except Exception as e:
    logger.error("execute HIVE script error: %s"%e)
    
if __name__ == '__main__':
  main()
