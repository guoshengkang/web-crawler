load data local inpath '/home/kangguosheng/filetransfer/idl_recom_class2tag_score.csv' 
overwrite into table config_recom_class2tag_score_log;

drop table config_recom_class2tag_score_log;
CREATE TABLE config_recom_class2tag_score_log
(class STRING COMMENT '文章类别',
tag STRING COMMENT '人的标签',
weight FLOAT COMMENT '对应权重'
)
comment "class2tag_score"
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;