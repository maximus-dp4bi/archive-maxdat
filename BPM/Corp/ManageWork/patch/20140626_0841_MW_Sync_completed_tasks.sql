--************************************************************
--Pre fix counts and records
SELECT sis2.step_instance_id
        ,mw.task_status
        ,mw.stage_done_date
        ,sis2.step_instance_history_id
        ,sis2.status
        ,sis2.hist_status
        ,"Current Task Status"
        ,sis2.completed_ts
        ,sis2.hist_create_ts
        ,mw.cancel_work_flag
        ,mw.asf_cancel_work
        ,mw.asf_complete_work
    FROM corp_etl_manage_work mw
        ,step_instance_stg    sis2,
        d_mw_current mwd
   WHERE mw.task_status not in ( 'COMPLETED', 'TERMINATED')
   and mw.task_id = sis2.step_instance_id
   AND mw.task_status <> sis2.status
   AND sis2.status = sis2.hist_status
   and sis2.step_instance_id = "Task ID"
-- AND sis2.hist_create_ts IN (SELECT MAX(hist_create_ts)
--                             FROM step_instance_stg sis_m
--                            WHERE sis_m.step_instance_id = sis2.step_instance_id
--                              and sis_m.status = sis2.status)
   AND sis2.hist_status in ( 'COMPLETED', 'TERMINATED')
   AND sis2.mw_processed = 'Y'
   order by sis2.step_instance_id,sis2.hist_create_ts;

   
nyhix UAT Count = 1
nyhix PRD Count = 1008
NYEC UAT Count = 11,768
NYEC PRD Count = 11,768
ILEB UAT Count = 
ILEB PRD Count = 
TXEB UAT Count = 
TXEB PRD Count = 
   
select * from CORP_ETL_CONTROL
where name in ('MW_BATCH_MISMATCH_LAST_UPDATE','MW_BATCH_MISMATCH_DAY') ;


--   **********
-- Update scehdule so nightly fix does not  step on these fixed records
update CORP_ETL_CONTROL
set value ='NONE'
where name ='MW_BATCH_MISMATCH_DAY';
commit;



declare
begin
  for temp_cur in (SELECT sis2.step_instance_id
        ,mw.task_status
        ,mw.stage_done_date
        ,sis2.step_instance_history_id
        ,sis2.status
        ,sis2.hist_status
        ,sis2.completed_ts
        ,sis2.hist_create_ts
        ,mw.cancel_work_flag
        ,mw.asf_cancel_work
        ,mw.asf_complete_work
    FROM corp_etl_manage_work mw
        ,step_instance_stg    sis2
   WHERE mw.task_status not in ( 'COMPLETED', 'TERMINATED')
   and mw.task_id = sis2.step_instance_id
   AND mw.task_status <> sis2.status
   AND sis2.status = sis2.hist_status
-- AND sis2.hist_create_ts IN (SELECT MAX(hist_create_ts)
--                             FROM step_instance_stg sis_m
--                            WHERE sis_m.step_instance_id = sis2.step_instance_id
--                              and sis_m.status = sis2.status)
   AND sis2.hist_status in ( 'COMPLETED', 'TERMINATED')
   AND sis2.mw_processed = 'Y'
   order by sis2.step_instance_id,sis2.hist_create_ts)
   
   Loop
     update step_instance_stg
     set mw_processed = 'N'
     where step_instance_history_id = temp_cur.step_instance_history_id;
     --
     if temp_cur.stage_done_date is not null and temp_cur.cancel_work_flag = 'Y' then
       Update corp_etl_manage_work
       set stage_done_date   = null ,
           cancel_work_flag  = 'N',   
           asf_cancel_work   = 'N',
           asf_complete_work = 'N'
       where task_id = temp_cur.step_instance_id;
     else
       if temp_cur.stage_done_date is not null then
         Update corp_etl_manage_work
         set stage_done_date   = null, 
             asf_complete_work = 'N'   
         where task_id = temp_cur.step_instance_id;
       end if;  
       if temp_cur.cancel_work_flag = 'Y' then
         Update corp_etl_manage_work
         set cancel_work_flag  = 'N',   
             asf_cancel_work   = 'N', 
             asf_complete_work = 'N'
         where task_id = temp_cur.step_instance_id;
       end if;
     end if;     
     --
     COMMIT;
     corp_etl_stage_pkg.log_etl_msg(in_job_name => 'Adhoc_fix',
                                    in_process_name => 'Complete_tasks',
                                    in_nr_of_error => 1,
                                    in_error_desc => temp_cur.hist_status||' Task '||temp_cur.step_instance_id,
                                    in_error_field => 'TASK_ID',
                                    in_error_codes => to_char(temp_cur.step_instance_id),
                                    in_driver_table_name => 'step_instance_stg.step_instance_history_id',
                                    in_driver_key_number => temp_cur.step_instance_history_id);
   COMMIT;                                    
   end loop;
--   commit;
end;   

--Vadiate after next mange work run
select * from d_mw_current
where "Task ID" in (select error_codes from corp_etl_error_log where  process_name = 'Complete_tasks')-- and error_desc like 'TERMINATED%')

select task_status from corp_etl_manage_work
where task_id in (select error_codes from corp_etl_error_log where process_name = 'Complete_tasks' )

select  count(*) from step_instance_stg where mw_processed = 'N'

select count(*) from corp_etl_error_log where process_name = 'Complete_tasks'

--***********************************************************************************************************

select * from corp_etl_error_log where process_name = 'Complete_tasks' and error_codes = '10501433'; --'24069224'

select * from step_instance_stg
where step_instance_id = 10501433;

select * from corp_etl_manage_work
where task_id in 10501433;
