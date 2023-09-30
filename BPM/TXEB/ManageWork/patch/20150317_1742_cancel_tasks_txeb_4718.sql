UPDATE corp_etl_manage_work
SET asf_cancel_work = 'Y'
    ,cancel_work_flag = 'Y'
    ,cancel_work_date = sysdate
    ,cancel_method = 'Exception'
    ,cancel_reason = 'Clean-up effort, old, invalid task'
    ,cancel_by = 'TXEB-4718'
    ,stage_done_date = sysdate  
    ,task_status = 'COMPLETED'  
WHERE task_id in(77911209,62171109,62173350
                ,62175386,62176598,62209287
                ,11011759,13179854,191486435
                ,40908560,40907849,40983170
                ,45410406,44811232,44813114
                ,45080129,45080198,11919407
                ,167187461);    

UPDATE corp_etl_process_incidents
SET instance_status = 'Complete'
    ,complete_dt = sysdate
    ,stage_done_dt = sysdate
    ,cancel_dt = sysdate
    ,cancel_by = 'TXEB-4718'
    ,cancel_reason = 'Clean-up effort, old, invalid task'
    ,cancel_method = 'Exception'
WHERE incident_id in(26066394,
26144812,
27380846,
27370671,
27384040,
27375963,
27379061,
28551978,
28552085,
28582922,
30712187,
30712209,
30712230,
30712269,
29794854,
32773886,
45449826)
and instance_status = 'Active';    

UPDATE corp_etl_manage_work w
SET asf_complete_work = 'Y'
    ,complete_date = sysdate
    ,complete_flag = 'Y'
    ,cancel_by = 'TXEB-4718'
    ,stage_done_date = sysdate
    ,CASE WHEN task_status NOT IN('COMPLETED','CLOSED','INVALID','TERMINATED') THEN 'COMPLETED' ELSE task_status END
WHERE  asf_cancel_work = 'N'
and asf_complete_work = 'N'
and source_reference_type = 'Incident ID'   
and not exists(select 1 from step_instance_stg s where w.task_id = s.step_instance_id and hist_status in('COMPLETED','TERMINATED'))
and exists(select 1 from corp_etl_process_incidents p where w.source_reference_id = p.incident_id and instance_status = 'Complete');

commit;