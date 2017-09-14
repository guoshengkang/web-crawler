#!/usr/bin/python
# -*- coding: utf-8 -*-
import urllib
import time
import re
import os
import json
from jieba_cut import *
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

def get_html(url):
  page = urllib.urlopen(url)
  html = page.read()
  return html

def find_table(html):
  table_reg = r'(<table.*/table>)' #找到表格
  table_reg = re.compile(unicode(table_reg,'utf8'))
  table = re.search(table_reg,html).group(1)
  return table
def find_rows(table):
  row_reg = r'(<tr.*?/tr>)' #找到表格的行
  row_reg = re.compile(unicode(row_reg,'utf8'))
  rows = re.findall(row_reg,table)
  return rows
def find_cells(row):
  cell_reg = r'(<td.*?/td>)' #找到单元格
  cell_reg = re.compile(unicode(cell_reg,'utf8'))
  cells = re.findall(cell_reg,row)
  return cells

def find_rank(cell):
  rank_reg = r'\<em\>(\d+?)\<\\/em\>' #找到排名
  rank_reg = re.compile(unicode(rank_reg,'utf8'))
  rank=re.search(rank_reg,cell).group(1)
  return rank
def find_keyword(cell):
  keyword_reg=r'key=tblog_search_list&value=list_all\\"\>(.+?)\<'
  keyword_reg = re.compile(unicode(keyword_reg,'utf8'))
  keyword=re.search(keyword_reg,cell).group(1)
  return keyword
def find_search(cell):
  search_reg=r'\<span\>(\d+?)\<\\/span\>'
  search_reg = re.compile(unicode(search_reg,'utf8'))
  search=re.search(search_reg,cell).group(1)
  return search

def process(html,output_filename):
  if type(html).__name__!="unicode":
    html=unicode(html,'utf-8')
  table=find_table(html)
  rows=find_rows(table)
  keyword_dict=dict() #{keyword:(appear_times,hot_value)}
  for row in rows[1:]:
    cells=find_cells(row)
    keyword=find_keyword(cells[1])
    keyword=keyword.decode('unicode_escape') #字符串转汉字
    search=find_search(cells[2])
    seg=seg_sentence(keyword).strip() #去掉空格
    keyword_list=seg.split(unicode(' ','utf-8'))
    digit_reg=r'^(\d+\.?\d*)$' #数字正则
    digit_reg=re.compile(unicode(digit_reg,'utf8'))
    for keyword in keyword_list:
      is_digit=re.search(digit_reg,keyword)
      if is_digit is None:
        if keyword in keyword_dict:
          keyword_dict[keyword][0]+=1 #出现次数+1
          if int(search)>keyword_dict[keyword][1]:
            keyword_dict[keyword][1]=int(search)
        else:
          keyword_dict[keyword]=[1,int(search)]

  filter_dict=dict()
  for key in keyword_dict:
    if keyword_dict[key][0]<=5: #过滤掉出现超过5次的词语
      filter_dict[key]=keyword_dict[key][1]

  rank_dict=sorted(filter_dict.iteritems(),key=lambda d:d[1], reverse = True)
  max_hot=rank_dict[0][1]
  dict_path = os.path.join(os.path.split(os.path.realpath(__file__))[0], output_filename)
  fout=open(dict_path,'w')
  for tup in rank_dict:
    hot_degree="%.9f"%(tup[1]/float(max_hot))
    line=tup[0]+','+hot_degree
    fout.write(line.encode("utf-8")+'\n')
  fout.close()