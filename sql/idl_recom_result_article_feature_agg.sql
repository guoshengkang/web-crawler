ALTER TABLE idl_recom_result_article_feature_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_recom_result_article_feature_agg DROP PARTITION (ds="{p0}");
INSERT INTO idl_recom_result_article_feature_agg PARTITION (ds="{p0}")
SELECT
t1.article_id,
t1.title,     
t3.classes,
t1.keywords,  
t1.abstract,  
t1.insertdt
FROM
    (SELECT
    id AS article_id,
    title,
    keywords,
    abstract,
    to_date(insertdt) AS insertdt
    FROM idl_recom_result_article_feature_log
    WHERE ds="{p0}" 
    ) t1
LEFT JOIN
    (SELECT
    s2.article_id,
    str_to_map(concat_ws("\073",collect_list(concat_ws('\072', s2.attribute,CAST(s2.attribute_value AS STRING)))),"\073","\072") AS classes
    FROM
        (SELECT
        article_id,
        attribute,
        CAST(attribute_value AS FLOAT) AS attribute_value
        FROM
            (SELECT
            id AS article_id,
            str_to_map(classes,'\073','\072') AS class_map
            FROM idl_recom_result_article_feature_log
            WHERE ds="{p0}"
            ) s1
        LATERAL VIEW OUTER explode(s1.class_map) mytable as attribute,attribute_value
        ) s2
    WHERE attribute_value>0.0
    GROUP BY s2.article_id
    ) t3
ON t1.article_id=t3.article_id;