insert into Assgined_dt_fix_09032014 
select task_id Assignment_id, source_reference_id Tracking_ID, 'Y' mw_processed
  from corp_etl_manage_work a
where parent_Task_id is null 
and exists ( select 1 from corp_etl_manage_work b
              where b.task_id < a.task_id
                and b.source_reference_id = a.source_reference_id);

commit;

delete from BPM_UPDATE_EVENT_QUEUE where identifier in (select to_char(Assignment_id) from Assgined_dt_fix_09032014 where mw_processed = 'Y');

commit;

delete from BPM_UPDATE_EVENT_QUEUE_ARCHIVE where identifier in (select to_char(Assignment_id) from Assgined_dt_fix_09032014 where mw_processed = 'Y');

commit;

delete from f_mw_by_date where mw_bi_id in ( select mw_bi_id from d_mw_current where "Task ID" in (select Assignment_id from Assgined_dt_fix_09032014 where mw_processed = 'Y'));

commit;
 
delete from d_mw_current where "Task ID" in (select Assignment_id from Assgined_dt_fix_09032014 where mw_processed = 'Y');

commit;

delete from Corp_Etl_Manage_Work where Task_ID in (select Assignment_id from Assgined_dt_fix_09032014 where mw_processed = 'Y');

commit;

update cadir_maxdat_stg set mw_processed = 'N' where Assignment_id in (select Assignment_id from Assgined_dt_fix_09032014 where mw_processed = 'Y');
  
commit;

	 
