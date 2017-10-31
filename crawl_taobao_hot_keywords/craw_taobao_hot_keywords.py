#!/usr/bin/python
# -*- coding: utf-8 -*-
import re
import os
import time
import json
import requests
from bs4 import BeautifulSoup
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

'''
#运行前删除文件cid_keyword_hot.txt,程序会自动创建该文件
input:root_subroot_cids.txt
output:cid_keyword_hot.txt
'''
def find_cid_hot_keyword(cid_no='50010167'):
  '''
  input:cid_no
  output:{keyword:[rank,hot_index],...} #rank:int,hot_index:unicode
  2个页面的url:https://top.taobao.com/index.php?topId=TR_FS&leafId=50012047&rank=search&type=hot&s=0
  '''
  keyword_dict={}
  url='https://top.taobao.com/index.php?spm=a1z5i.3.4.4.mfQLL2&topId=TR_FS&leafId=%s&rank=search&type=hot&s='%cid_no
  for page_num in range(0,100,20): #[0, 20, 40, 60, 80]
    page_url=url+str(page_num) #注:并不是每个url都有5个page
    kv={'user-agent':'Mozilla/5.0'}
    r = requests.get(page_url,headers=kv) #最基本的GET请求
    # print r.status_code #打印返回的状态码
    r.raise_for_status()    #如果响应状态码(r.status_code)不是 200，就主动抛出异常
    r.encoding=r.apparent_encoding
    soup=BeautifulSoup(r.text,"lxml")
    scripts=soup.find_all("script")
    needed_script=scripts[4].text.strip() #g_page_config = {...};g_srp_loadCss();g_srp_init();
    # find_json=needed_script.split(";")[0] #如果中间有分号就出问题,故不采用这种方式匹配
    json_reg = r'g_page_config = ({.+})'
    json_reg = re.compile(unicode(json_reg,'utf-8'),re.S)
    json_text = re.search(json_reg,needed_script).group(1)
    text = json.loads(json_text)
    row_list=text["mods"]["wbang"]["data"]["list"]
    if row_list is None: #说明该page不存在,则退出循环
      break
    for row in row_list:
      rank=row["col1"]["text"] #int
      keyword=row["col2"]["text"]
      hot_index=row["col4"]["num"] ##字符串
      keyword_dict[keyword]=[rank,hot_index]
  return keyword_dict

# test function find_cid_hot_keyword:
# find_cid_hot_keyword(cid_no='50012908')
#########################################################

fout_file_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "cid_hot_keywords.txt")
fout=open(fout_file_path,"w")
fout.close()

fin_file_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "root_subroot_cids.txt")
with open(fin_file_path, "r") as fin:
  line_no=0
  for line in fin.readlines():
    line_no+=1
    line=unicode(line.strip(), "utf-8")
    root,subroot,cid,cid_no=line.split(',')
    print "line_no:%d ... crawing hot keywords for cid: %s ..."%(line_no,cid) #正在爬取的类别热词
    keyword_dict=find_cid_hot_keyword(cid_no)
    items=sorted(keyword_dict.items(),key=lambda x:x[1][0],reverse=False)
    for x in items: 
      # print x[0],x[1][0],x[1][1] #keyword,rank,hot_index
      new_line=','.join([cid_no,x[0],str(x[1][0]),x[1][1]])
      fout=open(fout_file_path,"a")
      fout.write(new_line.encode('utf-8')+'\n')
      fout.close()
    # time.sleep(10) #隔10秒钟爬一个类别,没必要
