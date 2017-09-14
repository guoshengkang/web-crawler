drop table idl_recom_hot_search_keywords_log;
CREATE TABLE idl_recom_hot_search_keywords_log
(keyword STRING COMMENT '关键词',
hot_degree FLOAT COMMENT '搜索热度'
)
comment "每天的热搜词"
PARTITIONED BY (ds STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE;
