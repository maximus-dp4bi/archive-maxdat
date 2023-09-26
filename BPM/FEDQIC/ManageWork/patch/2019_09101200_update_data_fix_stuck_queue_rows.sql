update maxdat.d_mw_task_instance set handle_time = (complete_date - curr_claim_date)*24;
update maxdat.d_mw_task_instance ti set ti.previous_task_type_id = (select ti2.task_type_id from maxdat.d_mw_task_instance ti2 where ti.source_reference_id = ti2.source_reference_id and ti.parent_task_id = ti2.task_id);
update maxdat.d_mw_task_instance set task_claimed_time = (nvl(INSTANCE_END_DATE,sysdate) - CURR_CLAIM_DATE)*24;
update maxdat.d_mw_task_instance set task_unclaimed_time = (nvl(CURR_CLAIM_DATE,sysdate) - CREATE_DATE)*24;  
   
update maxdat.corp_etl_appeal set cancelled_date = null where cancelled_date is not null;

commit;













