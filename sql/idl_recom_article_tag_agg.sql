ALTER TABLE idl_recom_article_tag_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_recom_article_tag_agg DROP PARTITION (ds="{p0}" );
INSERT INTO idl_recom_article_tag_agg PARTITION (ds="{p0}")
SELECT
t2.article_id,
str_to_map(concat_ws("\073",collect_list(concat_ws('\072', t3.tag,CAST(t2.attribute_value*t3.weight AS STRING)))),"\073","\072") AS tags
FROM
    (SELECT
    article_id,
    attribute,
    CAST(attribute_value AS FLOAT) AS attribute_value
    FROM
        (SELECT
        article_id,
        classes
        FROM idl_recom_result_article_feature_agg
        WHERE ds='{p0}'
        ) t1
    LATERAL VIEW OUTER explode(t1.classes) mytable1 as attribute,attribute_value
    ) t2
LEFT JOIN config_recom_class2tag_score_log t3
ON t2.attribute=t3.class
WHERE t3.class IS NOT NULL
GROUP BY article_id;

