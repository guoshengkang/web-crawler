hive -e "alter table leesdata.idl_recom_result_article_feature_log drop partition(ds='{p0}')"; 

/data1/cloudera/parcels/CDH/bin/sqoop-import --table result_article_feature_log --connect jdbc:mysql://172.31.6.180:3306/addition_profit_db --password mCdlUmm3thna5ttup --username dc --delete-target-dir --target-dir /user/hive/warehouse/leesdata.db/idl_recom_result_article_feature_log/ds={p0};

hive -e "load data inpath '/user/hive/warehouse/leesdata.db/idl_recom_result_article_feature_log/ds={p0}' into table leesdata.idl_recom_result_article_feature_log partition(ds='{p0}')";
