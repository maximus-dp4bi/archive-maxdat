Insert into DP_SCORECARD.SC_HIERARCHY_JOB_LEVEL_LKUP 
( JOB_LEVEL, JOB_CODE, OWNER_DATE, EFFECTIVE_DATE)
select 1 as job_level, 1084 as JOB_CODE, 
 to_date('20190506','yyyymmdd') as owner_date, 
 to_date('20190506','yyyymmdd') as effective_date
  from dual;

commit; 