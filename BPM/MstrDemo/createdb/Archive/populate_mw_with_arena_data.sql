select count(1) from arena_task_data
WHERE TRUNC(stg_create_date) = TRUNC(sysdate)
--AND stg_file_num = 6
;

select count(1) from corp_etl_mw_wip;

truncate table corp_etl_mw_wip;
INSERT INTO corp_etl_mw_wip (task_id,task_type_id,task_status,create_date,complete_date,instance_start_date,instance_end_date,stage_done_date,status_date,last_update_date,work_receipt_date,claim_date,source_process_instance_id,owner_staff_id)
SELECT task_id
  ,task_type_id
  ,task_status
  ,create_date
  ,complete_date
  ,instance_start_date
  ,complete_date instance_end_date
  ,complete_date stage_done_date
  ,status_date
  ,last_update_date
  ,work_receipt_date
  ,claim_date
  ,source_process_instance_id
  ,COALESCE(owner_staff_id,0) owner_staff_id
FROM arena_task_data
WHERE TRUNC(stg_create_date) = TRUNC(sysdate)
AND stg_file_num = 1; --replace with file_num loaded

INSERT INTO corp_etl_mw (cemw_id,task_id,task_type_id,task_status,create_date,complete_date,instance_start_date,instance_end_date,stage_done_date,status_date,last_update_date,work_receipt_date,claim_date,source_process_instance_id,owner_staff_id)
SELECT cemw_id
  ,task_id
  ,task_type_id
  ,task_status
  ,create_date
  ,complete_date
  ,instance_start_date
  ,complete_date instance_end_date
  ,complete_date stage_done_date
  ,status_date
  ,last_update_date
  ,work_receipt_date
  ,claim_date
  ,source_process_instance_id
  ,owner_staff_id
FROM corp_etl_mw_wip;

commit;

BEGIN
FOR x IN(SELECT data_version,new_data,old_data
         FROM bpm_update_event_queue
         WHERE bsl_id = 2002)
LOOP         
  MW.INSERT_BPM_SEMANTIC(x.data_version ,x.new_data );

--  MW.UPDATE_BPM_SEMANTIC (x.data_version ,x.old_data,x.new_data );
END LOOP;
END;
/

delete from bpm_update_event_queue
where bsl_id = 2002;

commit;

select count(1) from corp_etl_mw;

select count(1) from D_MW_TASK_INSTANCE;

select count(1) from D_MW_TASK_history;

select * from bpm_update_event_queue;



