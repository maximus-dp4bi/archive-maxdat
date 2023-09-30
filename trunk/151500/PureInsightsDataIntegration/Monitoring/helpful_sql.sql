PROD EC2 Server IP = 10.118.40.75

-- Show any projects that have an entry in the log that indicates the ingestion started, yet there is no log entry indicating success
select DISTINCT projectid from raw.ingest_pi_data_det_log l1 where  convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ts))) >= '2022-04-22' AND object_category LIKE 'INGESTION STARTED%'
AND NOT exists (SELECT 1 FROM raw.ingest_pi_data_det_log l2 WHERE object_category LIKE 'INGESTION COMPLETED%' AND msg LIKE 'Succeeded%' AND l2.projectid = l1.projectid AND l2.TS > l1.ts);


-- Get total row count for project
SELECT sum(to_number(trim(substring(msg, 10))))  FROM (select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ts))) as tstamp, * from raw.ingest_pi_data_det_log where projectid in ('3333') and msg LIKE 'rowcount%' AND tstamp >= '2022-01-12' order by ts DESC);

-- Show log entries for project(s)
select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ts))) as tstamp, * from raw.ingest_pi_data_det_log where projectid in ('740', '741') and tstamp >= '2021-10-20' order by ts desc;


-- Check to see if there are any projects that have not completed.
select * from public.admin_pi_ingestion_status_by_project_vw where status_date = current_date() and status not like '%INGESTION COMPLETED%' order by projectid;

-- Check to see if we are waiting on any success files.
select to_timestamp_ltz(to_varchar(l1.ts)) as status_time_lt1, l1.* from raw.ingest_pi_data_det_log l1 where 
status_time_lt1 >= current_date() and object_category = 'S3 DATA' and object_name = '_SUCCESS FILE' and status_string = 'WAITING' and 
not exists (select to_timestamp_ltz(to_varchar(l2.ts)) as status_time_lt2 from raw.ingest_pi_data_det_log l2 where 
status_time_lt2 >= to_timestamp_ltz(to_varchar(l1.ts)) and object_category = 'S3 DATA' and object_name = '_SUCCESS FILE' and status_string = 'SUCCEEDED');

-- Issue Missing Grants (change environment as needed)

use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema PUBLIC;

SHOW GRANTS ON TABLE F_PI_SESSION_SUMMARY_VW;
SHOW GRANTS ON TABLE D_PI_QUEUE_MEMBERSHIP_VW;

-- Needed grants on objects
grant select on F_PI_SESSION_SUMMARY_VW to role PI_DATA_INGEST_PRD_ALERT_USER;
grant select, insert, update, delete, references, rebuild on F_PI_SESSION_SUMMARY_VW to role PUREINSIGHTS_GEN_DP4BI_PRD;
grant select, references on F_PI_SESSION_SUMMARY_VW to role PUREINSIGHTS_PROD_READ;
grant select, references on F_PI_SESSION_SUMMARY_VW to role MARS_DP4BI_PROD_READ;
grant select, references on F_PI_SESSION_SUMMARY_VW to role PUREINSIGHTS_DEV_POC;
grant select, references on F_PI_SESSION_SUMMARY_VW to role BI_PRODUCT_DEV;

-- Compare table record counts between environments
select uat.projectid,
       coalesce(uat.num_records, 0) uat_num_records,
       coalesce(prd.num_records, 0) prd_num_records
 from
  (select projectid, count(*) num_records from pureinsights_uat.raw.conversations group by projectid) uat
   full outer join
  (select projectid, count(*) num_records from pureinsights_prd.raw.conversations group by projectid) prd
  on (uat.projectid = prd.projectid);

-- Reingest project(s) (change environment as needed)
use role PI_DATA_INGEST_UAT_ALERT_USER;
use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema RAW;

--call raw.ingestUningestedPIData('551', true, false, true, false);


-- Last time (UTC) a change to an object was committed
select dateadd('ms', SYSTEM$LAST_CHANGE_COMMIT_TIME('F_PI_SESSION_SUMMARY_VW'),'1970-01-01') from dual;

-- Change ownership of objects from ACCOUNTADMIN to SYSADMIN

use ROLE accountadmin;
USE SCHEMA CONNECTIONPOINT;

GRANT ownership ON VIEW d_program_dates_sv TO sysadmin COPY CURRENT grants;
GRANT ownership ON VIEW d_program_hours_sv TO sysadmin COPY CURRENT grants;
GRANT ownership ON VIEW d_project_dates_sv TO sysadmin COPY CURRENT grants;
GRANT ownership ON VIEW d_project_holidays_sv TO sysadmin COPY CURRENT grants;
GRANT ownership ON VIEW d_project_hours_sv TO sysadmin COPY CURRENT grants;

-- Change warehouse of task
ALTER task UPDATE_D_PI_PROJECTS_HISTORY_DEV SUSPEND;
ALTER task UPDATE_D_PI_PROJECTS_HISTORY_DEV SET WAREHOUSE = 'PUREINSIGHTS_DEV_LOAD_DAILY_WH';
ALTER task UPDATE_D_PI_PROJECTS_HISTORY_DEV RESUME;

-- Reingest failures (change environment)
use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CALL ingestUningestedPIDataFailures();   
select projectid from public.admin_pi_ingestion_status_by_project_vw where status_date = current_date() and status like '%ERROR%' order by projectid;

use role SYSADMIN;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

SELECT DISTINCT projectid, projectname from (
	select    hour(a11.PROJECTSESSIONSTARTTIME)  PROJECTSESSIONSTARTTIMEHR,
	        a11.PROJECTID  PROJECTID,
	        p.projectname,
	        a11.PROJECTSESSIONSTARTDATE  DATE,
	        count(distinct case when a11.ABANDONED = 1 then a11.CONVERSATIONID end)  calls_abandoned,
	        count(distinct case when a11.USERHANDLED = 1 then a11.CONVERSATIONID end)  Calls_Handled,
	        count(distinct case when a11.OFFERED = 1 then a11.CONVERSATIONID end)  Calls_Offered
	    from    PUBLIC.F_PI_SESSION_SUMMARY_VW    a11,
	    	    PUBLIC.D_PI_PROJECTS p
	    where    (a11.projectid = p.projectid AND a11.PROJECTSESSIONSTARTDATE >=  '2022-07-10'
	     and a11.PROJECTSESSIONSTARTDATE <=  '2022-07-10')
	     AND a11.projectid = '3333'
	    group by    hour(a11.PROJECTSESSIONSTARTTIME),
	        a11.PROJECTID,
	        p.projectname,
	        a11.PROJECTSESSIONSTARTDATE      
)
WHERE calls_abandoned > 0 OR calls_handled > 0 OR calls_offered > 0;

SELECT conversationid, projectsessionstartdate FROM f_pi_session_summary_vw WHERE projectsessionstartdate >= '2022-07-09' AND projectsessionstartdate <= '2022-07-09'
AND offered = 1;

SELECT * FROM d_pi_projects WHERE projectid = '3333';


use role PI_DATA_INGEST_PRD_ALERT_USER;
use warehouse PUREINSIGHTS_PRD_LOAD_DAILY_WH;
use database PUREINSIGHTS_PRD;
use schema RAW;

CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('3333', true, true, true, false, 'session_summary', '20220711');   -- done
CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('101', true, true, true, false, 'session_summary', '20220711');    -- done
CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('4444', true, true, true, false, 'session_summary', '20220711');  --done
CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('5555', true, true, true, false, 'session_summary', '20220711');  -- done
CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('551', true, true, true, false, 'session_summary', '20220711');  -- done
CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('701', true, true, true, false, 'session_summary', '20220711'); -- done
CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('2001', true, true, true, false, 'session_summary', '20220711'); --done
CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('6666', true, true, true, false, 'session_summary', '20220711'); --done

CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('3333', true, true, true, false, 'conversation_attributes', '20220711');   -- done
CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('101', true, true, true, false, 'conversation_attributes', '20220711');    -- done
CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('4444', true, true, true, false, 'conversation_attributes', '20220711');  --done
CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('5555', true, true, true, false, 'conversation_attributes', '20220711');  -- done
CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('551', true, true, true, false, 'conversation_attributes', '20220711');  -- done
CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('701', true, true, true, false, 'conversation_attributes', '20220711'); -- done
CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('2001', true, true, true, false, 'conversation_attributes', '20220711'); --done
CALL RAW.INGESTUNINGESTEDPIDATABYTABLE('6666', true, true, true, false, 'conversation_attributes', '20220711'); --done


SELECT count(*) FROM PUREINSIGHTS_DEV.raw.conversation_attributes WHERE projectid = '101';
SELECT count(*) FROM raw.conversation_attributes WHERE projectid = '101';