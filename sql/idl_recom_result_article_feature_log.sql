alter table idl_recom_result_article_feature_log drop partition(ds='test');
-- 删除所有分区
alter table idl_recom_result_article_feature_log drop partition(ds>'0'); 

DROP table  idl_recom_result_article_feature_log;
CREATE TABLE if not exists idl_recom_result_article_feature_log
(
id              STRING,
title           STRING,
classes         STRING,
keywords        STRING,
abstract        STRING,
insertdt        STRING
) 
comment "subroots"
PARTITIONED BY (ds STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE;

-- 注:若不是分区表,则不用加载分区或数据

-- 放在分区目录,然后加载分区
/data1/cloudera/parcels/CDH/bin/sqoop-import --table result_article_feature_log --connect jdbc:mysql://172.31.6.180:3306/addition_profit_db --password mCdlUmm3thna5ttup --username dc --delete-target-dir --target-dir /user/hive/warehouse/leesdata.db/idl_recom_result_article_feature_log/ds=test;
hive -e "alter table leesdata.idl_recom_result_article_feature_log add partition(ds='test')";

-- 放在分区目录,然后加载分区 (待测试)
/data1/cloudera/parcels/CDH/bin/sqoop-import --table idl_recom_result_article_feature_log --connect jdbc:mysql://172.31.6.180:3306/addition_profit_db --password mCdlUmm3thna5ttup --username dc --delete-target-dir --target-dir /user/hive/warehouse/leesdata.db/idl_recom_result_article_feature_log/ds={p0};
hive -e "alter table leesdata.idl_recom_result_article_feature_log add partition(ds='{p0}')";

-- 放在任意目录,然后指定分区加载数据
-- 重复load,数据将重复
/data1/cloudera/parcels/CDH/bin/sqoop-import --table idl_recom_result_article_feature_log --connect jdbc:mysql://172.31.6.180:3306/addition_profit_db --password mCdlUmm3thna5ttup --username dc --delete-target-dir --target-dir /user/hive/warehouse/leesdata.db/idl_recom_result_article_feature_log/tmp;
hive -e "load data inpath '/user/hive/warehouse/leesdata.db/idl_recom_result_article_feature_log/tmp' into table leesdata.idl_recom_result_article_feature_log partition(ds='test')";

-- 查询结果放在分区目录,然后加载分区
/data1/cloudera/parcels/CDH/bin/sqoop-import -m 1 --query "SELECT id,title,keywords,abstract,date(insertdt) FROM idl_recom_result_article_feature_log where \$CONDITIONS" --connect jdbc:mysql://172.31.6.180:3306/addition_profit_db --password mCdlUmm3thna5ttup --username dc --delete-target-dir --target-dir /user/hive/warehouse/leesdata.db/idl_recom_result_article_feature_log/ds=test;
hive -e "alter table leesdata.idl_recom_result_article_feature_log add partition(ds='test')";
-- 注意：$CONDITIONS条件必须有，query子句若用双引号，则$CONDITIONS需要使用\转义，若使用单引号，则不需要转义。 
    
/data1/cloudera/parcels/CDH/bin/sqoop-import --table idl_recom_result_article_feature_log --connect jdbc:mysql://172.31.6.180:3306/addition_profit_db --password mCdlUmm3thna5ttup --username dc --delete-target-dir --target-dir /user/hive/warehouse/leesdata.db/idl_recom_result_article_feature_log/tmp;

/data1/cloudera/parcels/CDH/bin/sqoop list-databases --connect jdbc:mysql://172.31.6.180:3306 --username dc --password mCdlUmm3thna5ttup
/data1/cloudera/parcels/CDH/bin/hadoop fs -ls /user/hive/warehouse/leesdata.db/idl_recom_result_article_feature_log/

-- 查看文件目录或查看文件内容
/data1/cloudera/parcels/CDH/bin/hadoop fs -ls /user/hive/warehouse/leesdata.db/idl_recom_result_article_feature_log/ds=test
/data1/cloudera/parcels/CDH/bin/hadoop fs -cat /user/hive/warehouse/leesdata.db/idl_recom_result_article_feature_log/ds=test/part-m-00000
