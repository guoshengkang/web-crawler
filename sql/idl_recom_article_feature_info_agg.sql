ALTER TABLE idl_recom_article_feature_info_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_recom_article_feature_info_agg DROP PARTITION (ds="{p0}" );
INSERT INTO idl_recom_article_feature_info_agg PARTITION (ds="{p0}")
SELECT
t1.article_id,
t1.keywords,
t1.classes,
t2.tags,
t3.hot_score
FROM 
    (SELECT
    article_id,
    classes,
    keywords
    FROM idl_recom_result_article_feature_agg
    WHERE ds="{p0}"
    ) t1
LEFT JOIN
    (SELECT *
    FROM idl_recom_article_tag_agg
    WHERE ds="{p0}"
    ) t2
ON t1.article_id=t2.article_id
LEFT JOIN
    (SELECT *
    FROM idl_recom_article_norm_hot_score_agg
    WHERE ds="{p0}"
    ) t3
ON t1.article_id=t3.article_id
WHERE t2.article_id IS NOT NULL
AND t3.article_id IS NOT NULL;

