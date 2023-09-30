
Update PP_WFM_JOB_CLASSIFICATION
set end_date = NULL
, delete_flag = 'N'
WHERE STAFF_ID = 7599 
START_DATE = to_date('16-SEP-16', 'dd-MON-yy')
AND JOB_CLASSIFICATION_CODE_ID = 1050; 

commit;
