 alter session set current_schema = cisco_enterprise_cc;
 
 update cc_a_schedule
 set job_type = 'load_interval_data'
 where job_type = 'load_production_planning';
 
 commit;