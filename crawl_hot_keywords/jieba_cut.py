#!/usr/bin/python
# -*- coding: utf-8 -*-
import re
import sys
import string
reload(sys)
sys.setdefaultencoding('utf-8')
import jieba

# 如果有一些词语需要合并可以添加个人词典
# jieba.load_userdict('userdict.txt')
# 创建停用词列表
def creadstoplist(stopwordspath):
    stwlist = [line.strip() for line in open(stopwordspath, 'r').readlines()]
    return stwlist

# 对句子进行分词
def seg_sentence(sentence):
    wordList = jieba.cut(sentence.strip())
    #停用词文件由用户自己建立,注意路径必须和源文件放在一起
    stwlist = creadstoplist('stopwords.txt') #这里加载停用词的路径
    outstr = ''
    for word in wordList:
        if word not in stwlist:
            if len(word) > 1:  # 去掉长度为1的词
                if word != '\t':
                    outstr += word
                    outstr += " "
    return outstr

