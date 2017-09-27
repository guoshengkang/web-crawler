ALTER TABLE idl_recom_article_hot_score_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_recom_article_hot_score_agg DROP PARTITION (ds="{p0}" );
INSERT INTO idl_recom_article_hot_score_agg PARTITION (ds="{p0}")
SELECT 
t1.article_id,
COALESCE(SUM(t2.hot_degree),0)  AS hot_score
FROM
    (SELECT
    article_id,
    keyword
    FROM idl_recom_result_article_feature_agg
    LATERAL VIEW OUTER explode(keywords) mytable as keyword
    WHERE ds='{p0}'
    ) t1
LEFT JOIN
    (SELECT *
    FROM idl_recom_hot_search_keywords_log
    WHERE ds='{p0}'
    ) t2
ON t1.keyword=t2.keyword
GROUP BY t1.article_id;

