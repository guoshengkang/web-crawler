微博热搜网址
input:http://s.weibo.com/top/summary?cate=total&key=all
output:idl_recom_hot_search_keywords_log.csv

方法:
step1:抓取HTML文档
step2:根据正则查找表格,表格行,单元格
step3:采用结巴分词将热词进行分词
step4:将热词得分进行归一化

日志：
将文件logger.py和logger.conf和源代码文件放在同一目录
导入格式：from logger import logger
新建logs空文件夹

注：
table标签中不包含'\n'