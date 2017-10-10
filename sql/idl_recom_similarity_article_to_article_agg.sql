add jar hdfs://172.31.6.206:8020/user/dc/func/hive-third-functions-2.1.1-shaded.jar;
create temporary function array_intersect as 'cc.shanruifeng.functions.array.UDFArrayIntersect';
ALTER TABLE idl_recom_similarity_article_to_article_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_recom_similarity_article_to_article_agg DROP PARTITION (ds="{p0}");
INSERT INTO idl_recom_similarity_article_to_article_agg PARTITION (ds="{p0}")
SELECT
t1.article_id AS article_id1,
t2.article_id AS article_id2,
size(array_intersect(t1.keywords,t2.keywords))/(sqrt(size(t1.keywords))*sqrt(size(t2.keywords))) AS similarity
FROM 
    (SELECT article_id,keywords
    FROM idl_recom_result_article_feature_agg
    WHERE ds="{p0}"
    ) t1
LEFT JOIN 
    (SELECT article_id,keywords
    FROM idl_recom_result_article_feature_agg
    WHERE ds="{p0}"
    ) t2
WHERE t1.article_id!=t2.article_id;
