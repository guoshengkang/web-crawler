#!/bin/bash

original_path=`pwd`

# 转到主程序目录
cd /data1/shell/job_control/task_file/recom_daily/python_code/

# 执行程序
python /data1/shell/job_control/task_file/recom_daily/python_code/crawler_main.py {p0}

# 返回脚本目录
cd ${original_path}