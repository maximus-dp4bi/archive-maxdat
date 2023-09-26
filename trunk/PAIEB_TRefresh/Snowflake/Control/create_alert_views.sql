create or replace view control.paieb_monitor_full_load_tasklist as
select name, schema_name,state,error_message, query_start_time, completed_time, return_value
  from table(information_schema.task_history())
  where (name like 'FULL%'or name like 'INFER%' or name like 'LIST%'or name like 'MERGE%')
  and scheduled_time > dateadd('day',-1, current_date())
  order by completed_time desc;

create or replace view control.paieb_monitor_full_jobstatus as
select jobid, jobname, status,starttime, endtime
from control.paieb_job_ctrl where jobname like 'FULL%' 
order by jobid desc
limit 10;

create or replace view control.paieb_monitor_reccount as
select source_table_name, primary_key_column, primary_key_limit, row_count_est
, source_row_count
, target_row_count
, case when source_row_count- target_row_count >= 0 then source_row_count- target_row_count else null end source_minus_target
, case when target_row_count - source_row_count >= 0 then target_row_count - source_row_count else null end target_minus_source
, case when (source_row_count - target_row_count) > 1000 or (target_row_count - source_row_count) > 1000 then 'Difference exists more than 1000' else null end Record_diff_1000
from control.paieb_awsdms_tables_list
order by source_table_name;

create or replace view control.paieb_monitor_s3contents_latest as
select 
 first_value(last_modified_ntz) over(partition by (stage_name, aws_folder, folder_name) order by last_modified_ntz desc) latest 
, first_value(full_path) over(partition by (stage_name, aws_folder, folder_name) order by last_modified_ntz desc) latest_path
, first_value(folder_name) over(partition by (stage_name, aws_folder, folder_name) order by last_modified_ntz desc) latest_folder
, stage_name, aws_folder, folder_name
from control.paieb_current_s3_contents
where create_ntz >= current_date()
order by last_modified_ntz desc, stage_name, aws_folder, folder_name
limit 100
;

create or replace view control.paieb_monitor_latest_committime as
select 'APP_CASE_LINK' as table_name , max(committimestamp) max_committimestamp from paieb_prd.APP_CASE_LINK union select 'APP_DOC_DATA' as table_name , max(committimestamp) max_committimestamp from paieb_prd.APP_DOC_DATA union select 'APP_ELIG_OUTCOME' as table_name , max(committimestamp) max_committimestamp from paieb_prd.APP_ELIG_OUTCOME union select 'APP_HEADER' as table_name , max(committimestamp) max_committimestamp from paieb_prd.APP_HEADER union select 'APP_HEADER_EXT' as table_name , max(committimestamp) max_committimestamp from paieb_prd.APP_HEADER_EXT union select 'APP_INDIVIDUAL' as table_name , max(committimestamp) max_committimestamp from paieb_prd.APP_INDIVIDUAL union select 'APP_MISSING_INFO' as table_name , max(committimestamp) max_committimestamp from paieb_prd.APP_MISSING_INFO union select 'APP_STATUS_HISTORY' as table_name , max(committimestamp) max_committimestamp from paieb_prd.APP_STATUS_HISTORY union select 'DOC_FLEX_FIELD' as table_name , max(committimestamp) max_committimestamp from paieb_prd.DOC_FLEX_FIELD union select 'DOC_LINK' as table_name , max(committimestamp) max_committimestamp from paieb_prd.DOC_LINK union select 'DOCUMENT' as table_name , max(committimestamp) max_committimestamp from paieb_prd.DOCUMENT union select 'DOCUMENT_SET' as table_name , max(committimestamp) max_committimestamp from paieb_prd.DOCUMENT_SET union select 'LETTER_REQUEST' as table_name , max(committimestamp) max_committimestamp from paieb_prd.LETTER_REQUEST union select 'LETTER_REQUEST_LINK' as table_name , max(committimestamp) max_committimestamp from paieb_prd.LETTER_REQUEST_LINK union select 'NOTIFICATION_REQUEST' as table_name , max(committimestamp) max_committimestamp from paieb_prd.NOTIFICATION_REQUEST union select 'STEP_INSTANCE' as table_name , max(committimestamp) max_committimestamp from paieb_prd.STEP_INSTANCE union select 'ADDRESS' as table_name , max(committimestamp) max_committimestamp from paieb_prd.ADDRESS union select 'CLIENT' as table_name , max(committimestamp) max_committimestamp from paieb_prd.CLIENT union select 'PHONE_NUMBER' as table_name , max(committimestamp) max_committimestamp from paieb_prd.PHONE_NUMBER union select 'ASSESSMENT' as table_name , max(committimestamp) max_committimestamp from paieb_prd.ASSESSMENT union select 'APP_ADV_PLAN_SELECTION' as table_name , max(committimestamp) max_committimestamp from paieb_prd.APP_ADV_PLAN_SELECTION union select 'CALENDAR_ITEM' as table_name , max(committimestamp) max_committimestamp from paieb_prd.CALENDAR_ITEM union select 'SELECTION_TXN' as table_name , max(committimestamp) max_committimestamp from paieb_prd.SELECTION_TXN union select 'SELECTION_SEGMENT' as table_name , max(committimestamp) max_committimestamp from paieb_prd.SELECTION_SEGMENT union select 'ASSESSMENT_HIST' as table_name , max(committimestamp) max_committimestamp from paieb_prd.ASSESSMENT_HIST;

create or replace view control.paieb_alert_list as 
with p1 as (
  select 'Commit TimeStamp of tables' alert_criteria
, 'Max Commit Time:' || to_char(max_committime,'mm/dd/yyyy hh24:mi:ss') alert_info
,  case when max_committime < current_date() then 'Alert: Latest committed record is too old' else 'Success' end alert_status
from (
select max(max_committimestamp) max_committime from control.paieb_monitor_latest_committime
  )
  )
  ,
p2 as (  
select 'Record count match' alert_criteria
 , 'Table with most mismatch:' || first_value(source_table_name) over(order by abs(source_minus_target) desc) alert_info
 , 'Alert: ' || first_value(record_diff_1000) over(order by abs(source_minus_target) desc) alert_status
from control.paieb_monitor_reccount
limit 1
)
select alert_criteria, alert_info, alert_status from p1
union all
select alert_criteria, alert_info, alert_status from p2
;
