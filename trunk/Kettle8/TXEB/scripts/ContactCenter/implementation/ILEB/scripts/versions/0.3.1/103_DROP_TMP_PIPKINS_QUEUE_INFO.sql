drop table cc_s_tmp_pipkins_queue_info;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.3.1','103','103_DROP_TMP_PIPKINS_QUEUE_INFO');
commit;