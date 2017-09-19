baidu热搜网址
input:http://top.baidu.com/buzz?b=42&c=513&fr=topbuzz_b342_c513
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

注意:
1.提前查看网页的字符编码charset=gb2312,供使用正确的字符解码
2.python正则,编译时设置re.S,使.匹配包括换行在内的所有字符