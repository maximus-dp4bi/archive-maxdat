update maxdat.d_mw_task_instance set task_claimed_time = (nvl(INSTANCE_END_DATE,sysdate) - CURR_CLAIM_DATE)*24;
update maxdat.d_mw_task_instance set task_unclaimed_time = (nvl(CURR_CLAIM_DATE,sysdate) - CREATE_DATE)*24;

commit;





