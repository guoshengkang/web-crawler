#!/usr/bin/python
# -*- coding: utf-8 -*-
import re
import os
import json
import requests
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
'''
该程序根据爬取https://top.taobao.com/index.php?topId=TR_FS&leafId=50010850网上商品类别
具体爬取的信息:商品的二级三级类别及三级类别的编号,即(surroot,cid,cid_no)
一级类别手动保存在文件roots.txt中
input:roots.txt
output:root_subroot_cids.txt
'''
def crwal_taobao_cids(root,url,fout_file_path):
  if not os.path.exists(fout_file_path):
    result_data=open(fout_file_path,"w")
    result_data.close()
  kv={'user-agent':'Mozilla/5.0'}
  r = requests.get(url,headers=kv) #最基本的GET请求
  r.raise_for_status()    #如果响应状态码不是 200，就主动抛出异常
  r.encoding=r.apparent_encoding
  # print type(r.text) #<type 'unicode'>
  # print r.request.headers #头部信息
  html=r.text
  title_reg = r'g_page_config = ({.+?});' #直到匹配;
  title_reg = re.compile(unicode(title_reg,'utf-8'),re.S)
  title = re.search(title_reg,html).group(1)
  if title is not None:
    text = json.loads(title)
    for subroot in text[u'mods'][u'nav'][u'data'][u'common']: #列表
      for cid in subroot[u'sub']: #列表
        new_line=','.join([root,subroot[u'text'],cid[u'text'],cid[u'value']])
        fout=open(fout_file_path,'a')
        fout.write(new_line.encode('utf-8')+'\n')
        fout.close()


#追加写入的文件
fout_file_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "root_subroot_cids.txt")
fout=open(fout_file_path,"w")
fout.close()

fin_file_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], "roots.txt")
fin=open(fin_file_path,'r')
raw_url=r'https://top.taobao.com/index.php?topId=TR_FS&leafId='
for line in fin:
  line=unicode(line.strip(),'utf-8')
  root,root_id=line.split(unicode(',','utf-8'))
  url=raw_url+root_id #url=r'https://top.taobao.com/index.php?topId=TR_FS&leafId=50010850'
  crwal_taobao_cids(root,url,fout_file_path)
