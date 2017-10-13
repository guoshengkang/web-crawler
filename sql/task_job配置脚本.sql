-- idl_recom_result_article_feature_log
-- idl_recom_hot_search_keywords_log
-- idl_recom_result_article_feature_agg
-- idl_recom_article_hot_score_agg
-- idl_recom_article_norm_hot_score_agg
-- idl_recom_article_tag_agg
-- idl_recom_article_feature_info_agg
-- idl_recom_article_keyword_agg
-- idl_recom_similarity_article_to_article_agg
-- idl_recom_result_article_feature_agg_export2mysql


-- idl_recom_result_article_feature_log
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_recom_result_article_feature_log",
     "./task_file/recom_daily/idl_recom_result_article_feature_log.sh",
      now(),
      now(),
     "shell_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_recom_result_article_feature_log",
    "idl_recom_result_article_feature_log",
     0,
     now()); 

-- idl_recom_hot_search_keywords_log
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_recom_hot_search_keywords_log",
     "./task_file/recom_daily/idl_recom_hot_search_keywords_log.sh",
      now(),
      now(),
     "shell_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_recom_hot_search_keywords_log",
    "idl_recom_hot_search_keywords_log",
     0,
     now());
     
-- idl_recom_result_article_feature_agg
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_recom_result_article_feature_agg",
     "./task_file/recom_daily/idl_recom_result_article_feature_agg.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_recom_result_article_feature_agg",
    "idl_recom_result_article_feature_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_recom_result_article_feature_agg",
    "idl_recom_result_article_feature_log",
     now());  
     
-- idl_recom_article_hot_score_agg
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_recom_article_hot_score_agg",
     "./task_file/recom_daily/idl_recom_article_hot_score_agg.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_recom_article_hot_score_agg",
    "idl_recom_article_hot_score_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_recom_article_hot_score_agg",
    "idl_recom_article_keyword_agg",
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_recom_article_hot_score_agg",
    "idl_recom_hot_search_keywords_log",
     now());      

-- idl_recom_article_norm_hot_score_agg
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_recom_article_norm_hot_score_agg",
     "./task_file/recom_daily/idl_recom_article_norm_hot_score_agg.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_recom_article_norm_hot_score_agg",
    "idl_recom_article_norm_hot_score_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_recom_article_norm_hot_score_agg",
    "idl_recom_article_hot_score_agg",
     now());
     
-- idl_recom_article_tag_agg
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_recom_article_tag_agg",
     "./task_file/recom_daily/idl_recom_article_tag_agg.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_recom_article_tag_agg",
    "idl_recom_article_tag_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_recom_article_tag_agg",
    "idl_recom_result_article_feature_agg",
     now());
-- idl_recom_article_feature_info_agg
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_recom_article_feature_info_agg",
     "./task_file/recom_daily/idl_recom_article_feature_info_agg.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_recom_article_feature_info_agg",
    "idl_recom_article_feature_info_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_recom_article_feature_info_agg",
    "idl_recom_result_article_feature_agg",
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_recom_article_feature_info_agg",
    "idl_recom_article_tag_agg",
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_recom_article_feature_info_agg",
    "idl_recom_article_norm_hot_score_agg",
     now());

-- idl_recom_article_keyword_agg
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_recom_article_keyword_agg",
     "./task_file/recom_daily/idl_recom_article_keyword_agg.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_recom_article_keyword_agg",
    "idl_recom_article_keyword_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_recom_article_keyword_agg",
    "idl_recom_result_article_feature_agg",
     now());

-- idl_recom_similarity_article_to_article_agg
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_recom_similarity_article_to_article_agg",
     "./task_file/recom_daily/idl_recom_similarity_article_to_article_agg.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_recom_similarity_article_to_article_agg",
    "idl_recom_similarity_article_to_article_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_recom_similarity_article_to_article_agg",
    "idl_recom_article_keyword_agg",
     now());
     
-- idl_recom_result_article_feature_agg_export2mysql
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_recom_result_article_feature_agg_export2mysql",
     "./task_file/recom_daily/idl_recom_result_article_feature_agg_export2mysql.sh",
      now(),
      now(),
     "shell_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_recom_result_article_feature_agg_export2mysql",
    "idl_recom_result_article_feature_agg_export2mysql",
     0,
     now()); 
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_recom_result_article_feature_agg_export2mysql",
    "idl_recom_article_feature_info_agg",
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_recom_result_article_feature_agg_export2mysql",
    "idl_recom_similarity_article_to_article_agg ",
     now());
  
-----------------------------------------------------------------------------------     
INSERT INTO plan_job_config (job_name,job_type,PARAMETER,par_end,PARALLEL,begin_time,insertdt,updatedt,job_status,is_debug)
VALUES ("recom_daily",
     "daily",
     "2017-08-30",
     "2017-01-01",
      2,
     "00:00:00",
      now(),
      now(),
      0,
      1);
-- idl_recom_result_article_feature_log
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("recom_daily",
    "idl_recom_result_article_feature_log",
     now());
-- idl_recom_hot_search_keywords_log
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("recom_daily",
    "idl_recom_hot_search_keywords_log",
     now());
-- idl_recom_result_article_feature_agg
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("recom_daily",
    "idl_recom_result_article_feature_agg",
     now());
-- idl_recom_article_hot_score_agg
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("recom_daily",
    "idl_recom_article_hot_score_agg",
     now());
-- idl_recom_article_norm_hot_score_agg
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("recom_daily",
    "idl_recom_article_norm_hot_score_agg",
     now());
-- idl_recom_article_tag_agg
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("recom_daily",
    "idl_recom_article_tag_agg",
     now());
-- idl_recom_article_feature_info_agg
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("recom_daily",
    "idl_recom_article_feature_info_agg",
     now());
-- idl_recom_article_keyword_agg
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("recom_daily",
    "idl_recom_article_keyword_agg",
     now());
-- idl_recom_similarity_article_to_article_agg
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("recom_daily",
    "idl_recom_similarity_article_to_article_agg",
     now());
-- idl_recom_result_article_feature_agg_export2mysql
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("recom_daily",
    "idl_recom_result_article_feature_agg_export2mysql",
     now());