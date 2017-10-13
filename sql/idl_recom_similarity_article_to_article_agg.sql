ALTER TABLE idl_recom_similarity_article_to_article_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_recom_similarity_article_to_article_agg DROP PARTITION (ds="{p0}");
INSERT INTO idl_recom_similarity_article_to_article_agg PARTITION (ds="{p0}")
SELECT
t1.article_id1,
t1.article_id2,
t1.inner_product/(t2.norm*t3.norm) AS similarity
FROM 
    (SELECT
    s1.article_id AS article_id1,
    s2.article_id AS article_id2,
    sum(s1.weight*s2.weight) AS inner_product
    FROM idl_recom_article_keyword_agg s1
    LEFT JOIN idl_recom_article_keyword_agg s2
    ON s1.keyword=s2.keyword
    WHERE s1.ds="{p0}" AND s2.ds="{p0}"
    GROUP BY s1.article_id, s2.article_id
    ) t1
LEFT JOIN
    (SELECT
    s3.article_id,
    sqrt(sum(s3.weight*s3.weight)) AS norm
    FROM idl_recom_article_keyword_agg s3
    WHERE ds="{p0}"
    GROUP BY s3.article_id
    ) t2
ON t1.article_id1=t2.article_id
LEFT JOIN
    (SELECT
    s4.article_id,
    sqrt(sum(s4.weight*s4.weight)) AS norm
    FROM idl_recom_article_keyword_agg s4
    WHERE ds="{p0}"
    GROUP BY s4.article_id
    ) t3
ON t1.article_id2=t3.article_id
WHERE t2.article_id IS NOT NULL
AND t3.article_id IS NOT NULL;