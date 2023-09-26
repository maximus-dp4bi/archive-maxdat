

delete from cc_f_agent_by_date a
where rowid < ( 
  select max(rowid) from cc_f_agent_by_date b
  where a.d_date_id=b.d_date_id
  and a.d_agent_id=b.d_agent_id
);

update cc_a_adhoc_job 
set is_pending = 1, is_running = 0, job_start_date = null, job_end_date = null, success = null 
where adhoc_job_id = 1017;

commit;
