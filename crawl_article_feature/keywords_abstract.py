#-*- encoding:utf-8 -*-
from __future__ import print_function
import os,sys
try:
    reload(sys)
    sys.setdefaultencoding('utf-8')
except:
    pass

import codecs
from textrank4zh import TextRank4Keyword, TextRank4Sentence

def fetch_keywords_abstrct(text):
  tr4w = TextRank4Keyword()
  tr4w.analyze(text=text, lower=True, window=2)   # py2中text必须是utf8编码的str或者unicode对象，py3中必须是utf8编码的bytes或者str对象

  # print( '关键词：' )
  keyword_list=[]
  for item in tr4w.get_keywords(20, word_min_len=2):
      # print(item.word, item.weight) #关键词的长度>=1
      # print(type(item.word)) #<type 'unicode'>
      keyword_list.append(item.word)
  keywords='，'.join(keyword_list).encode("utf-8")

  # print( '关键短语：' )
  # for phrase in tr4w.get_keyphrases(keywords_num=20, min_occur_num= 2):
  #     print(phrase)

  tr4s = TextRank4Sentence()
  tr4s.analyze(text=text, lower=True, source = 'all_filters')
  setences=[]
  # print() #若没有这个语句,后面打印看不见???
  # print( '摘要：' )
  for item in tr4s.get_key_sentences(num=3):
      # print(item.index, item.weight, item.sentence)
      setences.append(item.sentence)
  abstract='。'.join(setences)+'。'
  abstract=abstract.encode("utf-8")
  return keywords,abstract