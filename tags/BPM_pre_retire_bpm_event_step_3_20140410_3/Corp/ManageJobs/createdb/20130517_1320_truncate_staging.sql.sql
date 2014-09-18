truncate table corp_etl_manage_jobs;

update corp_etl_control set value = '0' 
where name = 'LAST_JOB_ID';


commit;