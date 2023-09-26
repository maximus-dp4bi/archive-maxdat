
Update PP_WFM_JOB_CLASSIFICATION
set end_date = null
, delete_flag = 'N'
WHERE STAFF_ID = 5357
AND DELETE_FLAG = 'Y';

commit;
