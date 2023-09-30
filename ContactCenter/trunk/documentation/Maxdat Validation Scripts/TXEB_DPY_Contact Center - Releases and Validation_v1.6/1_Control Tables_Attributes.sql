select 'Control Tables 1' as test_num, 'Non-null:  ADHOC_JOB_ID' as test_name, case when exists(select 1 from CC_A_ADHOC_JOB where ADHOC_JOB_ID is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 2' as test_num, 'Non-null:  START_DATETIME_PARAM' as test_name, case when exists(select 1 from CC_A_ADHOC_JOB where START_DATETIME_PARAM is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 3' as test_num, 'Non-null:  END_DATETIME_PARAM' as test_name, case when exists(select 1 from CC_A_ADHOC_JOB where END_DATETIME_PARAM is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 4' as test_num, 'Non-null:  IS_PENDING' as test_name, case when exists(select 1 from CC_A_ADHOC_JOB where IS_PENDING is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 5' as test_num, 'Non-null:  JOB_START_DATE' as test_name, case when exists(select 1 from CC_A_ADHOC_JOB where JOB_START_DATE is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 6' as test_num, 'Non-null:  SUCCESS' as test_name, case when exists(select 1 from CC_A_ADHOC_JOB where SUCCESS is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 7' as test_num, 'Non-null:  CREATION_DATE' as test_name, case when exists(select 1 from CC_A_ADHOC_JOB where CREATION_DATE is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 8' as test_num, 'Non-null:  SCHEDULED_JOB_ID' as test_name, case when exists(select 1 from CC_A_SCHEDULED_JOB where SCHEDULED_JOB_ID is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 9' as test_num, 'Non-null:  START_DATETIME_PARAM' as test_name, case when exists(select 1 from CC_A_SCHEDULED_JOB where START_DATETIME_PARAM is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 10' as test_num, 'Non-null:  END_DATETIME_PARAM' as test_name, case when exists(select 1 from CC_A_SCHEDULED_JOB where END_DATETIME_PARAM is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 11' as test_num, 'Non-null:  JOB_START_DATE' as test_name, case when exists(select 1 from CC_A_SCHEDULED_JOB where JOB_START_DATE is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 12' as test_num, 'Non-null:  SUCCESS' as test_name, case when exists(select 1 from CC_A_SCHEDULED_JOB where SUCCESS is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 13' as test_num, 'Non-null:  ID' as test_name, case when exists(select 1 from CC_L_ERROR where ID is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 14' as test_num, 'Non-null:  MESSAGE' as test_name, case when exists(select 1 from CC_L_ERROR where MESSAGE is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 15' as test_num, 'Non-null:  ERROR_FILE_PATH' as test_name, case when exists(select 1 from CC_L_ERROR where ERROR_FILE_PATH is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 16' as test_num, 'Non-null:  ERROR_DATE' as test_name, case when exists(select 1 from CC_L_ERROR where ERROR_DATE is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 17' as test_num, 'Non-null:  JOB_NAME' as test_name, case when exists(select 1 from CC_L_ERROR where JOB_NAME is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 18' as test_num, 'Non-null:  TRANSFORM_NAME' as test_name, case when exists(select 1 from CC_L_ERROR where TRANSFORM_NAME is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 19' as test_num, 'Non-null:  PATCH_LOG_ID' as test_name, case when exists(select 1 from CC_L_PATCH_LOG where PATCH_LOG_ID is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 20' as test_num, 'Non-null:  PATCH_VERSION' as test_name, case when exists(select 1 from CC_L_PATCH_LOG where PATCH_VERSION is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 21' as test_num, 'Non-null:  SCRIPT_SEQUENCE' as test_name, case when exists(select 1 from CC_L_PATCH_LOG where SCRIPT_SEQUENCE is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 22' as test_num, 'Non-null:  SCRIPT_NAME' as test_name, case when exists(select 1 from CC_L_PATCH_LOG where SCRIPT_NAME is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 23' as test_num, 'Non-null:  SCRIPT_RUN_DATE' as test_name, case when exists(select 1 from CC_L_PATCH_LOG where SCRIPT_RUN_DATE is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 24' as test_num, 'Non-null:  ID_BATCH' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where ID_BATCH is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 25' as test_num, 'Non-null:  CHANNEL_ID' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where CHANNEL_ID is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 26' as test_num, 'Non-null:  TRANSNAME' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where TRANSNAME is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 27' as test_num, 'Non-null:  STATUS' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where STATUS is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 28' as test_num, 'Non-null:  LINES_READ' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where LINES_READ is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 29' as test_num, 'Non-null:  LINES_WRITTEN' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where LINES_WRITTEN is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 30' as test_num, 'Non-null:  LINES_UPDATED' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where LINES_UPDATED is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 31' as test_num, 'Non-null:  LINES_INPUT' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where LINES_INPUT is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 32' as test_num, 'Non-null:  LINES_OUTPUT' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where LINES_OUTPUT is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 33' as test_num, 'Non-null:  LINES_REJECTED' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where LINES_REJECTED is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 34' as test_num, 'Non-null:  ERRORS' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where ERRORS is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 35' as test_num, 'Non-null:  STARTDATE' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where STARTDATE is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 36' as test_num, 'Non-null:  ENDDATE' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where ENDDATE is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 37' as test_num, 'Non-null:  LOGDATE' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where LOGDATE is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 38' as test_num, 'Non-null:  DEPDATE' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where DEPDATE is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 39' as test_num, 'Non-null:  REPLAYDATE' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where REPLAYDATE is not null) then 'PASS' else 'FAIL' end as test_result from dual;
select 'Control Tables 40' as test_num, 'Non-null:  LOG_FIELD' as test_name, case when exists(select 1 from CC_L_TRANSFORMATION where LOG_FIELD is not null) then 'PASS' else 'FAIL' end as test_result from dual;