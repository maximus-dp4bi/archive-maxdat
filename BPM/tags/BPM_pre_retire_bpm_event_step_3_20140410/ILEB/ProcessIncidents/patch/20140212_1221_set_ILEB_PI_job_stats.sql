
 update corp_etl_job_statistics js
 set job_start_date = to_date('02/01/2013','mm/dd/yyyy'),
  job_end_date = to_date('02/01/2013','mm/dd/yyyy')
where job_name = 'Process_Incidents_RUN_ALL'
and job_id = 9242;

commit;
