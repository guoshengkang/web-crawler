淘宝热搜网址:
https://top.taobao.com/index.php?topId=TR_FS&leafId=50010850
......
搜索热门排行
https://top.taobao.com/index.php?topId=TR_FS&leafId=50010850&rank=search&type=hot&s=0
https://top.taobao.com/index.php?topId=TR_FS&leafId=50010850&rank=search&type=hot&s=20
......
output:cid_hot_keywords.txt


------------------方法----------------------------
【step1】:手动提取商品一级类别,保存至roots.txt文件

【step2】:读取roots.txt文件,爬取每个root下面的二级类别
code:craw_taobao_cids.py
output:root_subroot_cids.txt
输出字段:(root,subroot,cid,cid_no)

【step3】:读取root_subroot_cids.txt文件,根据cid_no生成搜索热门排行url
code:craw_taobao_hot_keywords.py
output:cid_hot_keywords.txt
输出字段:(cid_no,keyword,rank,hot_index)

