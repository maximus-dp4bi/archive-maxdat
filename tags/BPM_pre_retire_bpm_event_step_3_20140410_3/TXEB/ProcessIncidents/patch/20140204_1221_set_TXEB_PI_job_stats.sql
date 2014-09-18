--Step 1 run this, save results to a sql file. This will be the update script to run in step-3.
select 'update  corp_etl_job_statistics js set job_start_date = to_date('''|| to_char(job_start_date,'mm/dd/yyyy hh24:mi:ss')||''',''mm/dd/yyyy hh24:mi:ss'') where job_id = '||job_id||';'
 from corp_etl_job_statistics js
where job_name = 'Process_Incidents_RUN_ALL';

-- Step 2 run this.
 update corp_etl_job_statistics js
 set job_start_date = to_date('09/01/2013','mm/dd/yyyy')
where job_name = 'Process_Incidents_RUN_ALL';
commit;

-- ***********   step 3: Wait for a TXEB PI SUCCESSFUL ETL RUN; then run update script built in step-1. COMMIT after. ***********
commit;