drop table qc_random_sample;
create table qc_random_sample (
AGENT_ID   number(18)
,USER_NAME  varchar2(100)
,USER_LAST_NAME varchar2(50)
,USER_FIRST_NAME  varchar2(50)
,EMPLOYEE_ID  number(18)
,SUPERVISOR varchar2(100)
,SKILL    varchar2(100)
,LOCATION varchar2(50)
,LOCAL_START_TIME varchar2(100)
,LOCAL_END_TIME   varchar2(100)
,local_start_time_dt  date
,local_end_time_dt  date
,CALL_DURATION    varchar2(100)
,call_duration_secs number(18)
,CALL_ID    number(20)
,CALL_DATE    date
,VIDEO_FLAG   varchar2(10)
,CREF     varchar2(100)
,CREATE_DATE    varchar2(100)
,create_date_dt date
,CREATED_BY   varchar2(100)
,TX_EB_SKILL_GROUP  varchar2(100)
,WRAPUP_TIME    varchar2(20)
, wrapup_time_secs  number(18)
,SESS_DURATION    varchar2(20)
, sess_duration_secs  number(18)
,survey_header_info_id  number(32)
,survey_id    number(32)
,job_id     number(32)
, filename  varchar2(1000)
,row_num    number(32)
);

create or replace view qc_random_sample_sv as
select
AGENT_ID   
,USER_NAME  
,USER_LAST_NAME 
,USER_FIRST_NAME    
,EMPLOYEE_ID      
,SUPERVISOR     
,SKILL        
,LOCATION     
,LOCAL_START_TIME   
,LOCAL_END_TIME     
,local_start_time_dt  
,local_end_time_dt    
,CALL_DURATION      
,call_duration_secs   
,CALL_ID        
,CALL_DATE        
,VIDEO_FLAG       
,CREF         
,CREATE_DATE      
,create_date_dt   
,CREATED_BY       
,rs.TX_EB_SKILL_GROUP 
, SG.SAMPLE_GROUP
,WRAPUP_TIME      
, wrapup_time_secs    
,SESS_DURATION      
, sess_duration_secs  
,survey_header_info_id  
,survey_id        
,job_id         
, filename      
,row_num        
FROM QC_RANDOM_SAMPLE RS
LEFT JOIN (select distinct tx_eb_skill_group, sample_group from QC_SKILL_GROUP) SG ON sG.tx_eb_skill_group = RS.tx_eb_skill_group
;


grant select on QC_RANDOM_SAMPLE_SV to maxdat_read_only;
grant select on QC_RANDOM_SAMPLE_sv to maxdat_reports;
