alter session set current_schema = maxdat_cc;
alter session set nls_date_format="dd-mon-yy hh24:mi:ss";


update cc_a_adhoc_job
  set is_running=0
where adhoc_job_id=3141;

commit;