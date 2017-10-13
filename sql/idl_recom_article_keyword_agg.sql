ALTER TABLE idl_recom_article_keyword_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_recom_article_keyword_agg DROP PARTITION (ds="{p0}");
INSERT INTO idl_recom_article_keyword_agg PARTITION (ds="{p0}")
SELECT
article_id,
attribute AS keyword,
CAST(attribute_value AS FLOAT) AS weight
FROM
    (SELECT
    article_id,
    str_to_map(keywords,'\073','\072') AS keywords_map
    FROM idl_recom_result_article_feature_agg
    WHERE ds="{p0}"
    ) s1
LATERAL VIEW OUTER explode(s1.keywords_map) mytable as attribute,attribute_value;