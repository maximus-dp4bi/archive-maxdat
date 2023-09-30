-- Insert script for CORP_ETL_CLEAN_TABLE

insert into CORP_ETL_CLEAN_TABLE
select * from (select '' as CECT_ID_1,
'step_instance_stg' as TABLE_NAME,
null as COLUMN_NAME,
'where trunc(stage_create_ts) < trunc(sysdate-120)
and ref_type = '||'''APP_HEADER'''|| '
and ref_id not in (
select app_id from nyec_etl_process_app pa 
where stage_done_date is null or trunc(stage_done_date) > trunc(sysdate-120))
and ref_id not in (
select app_id from nyec_etl_process_mi pm 
where stage_done_date is null or trunc(stage_done_date) > trunc(sysdate-120))
and ref_id not in (
select app_id from nyec_etl_state_review sr 
where stage_done_date is null or trunc(stage_done_date) > trunc(sysdate-120))' as DELETE_WHERE_CLAUSE,
null as DAYS_TILL_DELETE ,
sysdate -1 as START_DATE,
'07-JUL-7777' as END_DATE,
sysdate as CREATED_TS,
sysdate  as LAST_UPDATE_TS,
'Y' as ARC_FLAG ,
'step_instance_stg_arc' as ARC_TABLE
from dual


union all

select '' as CECT_ID_1,
'step_instance_stg' as TABLE_NAME,
null as COLUMN_NAME,
'where trunc(stage_create_ts) < trunc(sysdate-120)
and ref_type <> '||'''APP_HEADER'''|| ' ' as DELETE_WHERE_CLAUSE,
null as DAYS_TILL_DELETE ,
sysdate-1 as START_DATE,
'07-JUL-7777' as END_DATE,
sysdate as CREATED_TS,
sysdate  as LAST_UPDATE_TS,
'Y' as ARC_FLAG ,
'step_instance_stg_arc' as ARC_TABLE
from dual

union all

select '' as CECT_ID_1,
'letters_stg' as TABLE_NAME,
null as COLUMN_NAME,
'where trunc(letter_create_ts) < trunc(sysdate-120)
and letter_app_id is not null 
and letter_app_id not in (
select app_id from nyec_etl_process_app pa 
where stage_done_date is null or trunc(stage_done_date) > trunc(sysdate-120))
and letter_app_id not in (
select app_id from nyec_etl_process_mi pm 
where stage_done_date is null or trunc(stage_done_date) > trunc(sysdate-120))
and letter_app_id not in (
select app_id from nyec_etl_state_review sr 
where stage_done_date is null or trunc(stage_done_date) > trunc(sysdate-120))' as DELETE_WHERE_CLAUSE,
null as DAYS_TILL_DELETE ,
sysdate-1 as START_DATE,
'07-JUL-7777' as END_DATE,
sysdate as CREATED_TS,
sysdate  as LAST_UPDATE_TS,
'Y' as ARC_FLAG ,
'letters_stg_arc' as ARC_TABLE
from dual

union all

select '' as CECT_ID_1,
'cc_event_stg' as TABLE_NAME,
null as COLUMN_NAME,
'where trunc(ces.update_ts) < trunc(sysdate-120)
and ref_id is not null 
and ref_id not in (
select app_id from nyec_etl_process_app pa 
where stage_done_date is null or trunc(stage_done_date) > trunc(sysdate-120))
and ref_id not in (
select app_id from nyec_etl_process_mi pm 
where stage_done_date is null or trunc(stage_done_date) > trunc(sysdate-120))
and ref_id not in (
select app_id from nyec_etl_state_review sr 
where stage_done_date is null or trunc(stage_done_date) > trunc(sysdate-120))' as DELETE_WHERE_CLAUSE,
null as DAYS_TILL_DELETE ,
sysdate-1 as START_DATE,
'07-JUL-7777' as END_DATE,
sysdate as CREATED_TS,
sysdate  as LAST_UPDATE_TS,
'Y' as ARC_FLAG ,
'cc_event_stg_arc' as ARC_TABLE
from dual
);
commit;