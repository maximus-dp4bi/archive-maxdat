UPDATE corp_etl_manage_work
SET task_status = 'COMPLETED'
    ,complete_date = sysdate
    ,complete_flag = 'Y'
    ,stg_last_update_date = sysdate
    ,stage_done_date = sysdate
    ,asf_complete_work = 'Y'
    ,last_update_by_name = 'TXEB-4676'
    ,cancel_reason = 'Closed - cleanup effort JIRA TXEB-4676'
WHERE task_id IN(select step_instance_id from tmp_mw_complete_tasks);

UPDATE corp_etl_process_incidents
SET instance_status = 'Complete',
    complete_dt = sysdate,
    cancel_by = 'TXEB-4676',
    cancel_dt = sysdate,
    cancel_reason = 'Closed - cleanup effort JIRA TXEB-4676',
    cancel_method = 'Exception'
WHERE incident_id in(40595517,
41660999,
41661426,
41661449,
41661553,
41662267,
41662476);

commit;