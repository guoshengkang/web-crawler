ALTER TABLE idl_recom_article_norm_hot_score_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_recom_article_norm_hot_score_agg DROP PARTITION (ds="{p0}");
INSERT INTO idl_recom_article_norm_hot_score_agg PARTITION (ds="{p0}")
SELECT
t1.article_id,
IF(t2.max_score=0.0, 0.0, t1.hot_score/t2.max_score) AS hot_score
FROM
    (SELECT *
    FROM idl_recom_article_hot_score_agg
    WHERE ds="{p0}"
    ) t1
LEFT JOIN
    (SELECT
    MAX(hot_score) AS max_score
    FROM idl_recom_article_hot_score_agg
    WHERE ds="{p0}"
    ) t2;
       

