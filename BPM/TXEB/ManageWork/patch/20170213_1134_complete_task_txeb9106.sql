UPDATE step_instance_stg
SET completed_ts = to_date('09/12/2016 12:46:57','mm/dd/yyyy hh24:mi:ss')
    ,mw_processed = 'N'
WHERE step_instance_id = 262228070
AND hist_status = 'COMPLETED';  

UPDATE corp_etl_manage_work
SET asf_complete_work = 'Y'
,complete_date =  to_date('09/12/2016 12:46:57','mm/dd/yyyy hh24:mi:ss')
,complete_flag = 'Y'
,stage_done_date = sysdate
WHERE task_id in (262228070) ;

commit;