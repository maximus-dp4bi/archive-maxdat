grant select on QC_SKILL_GROUP to maxdat_read_only;
grant select on QC_SKILL_GROUP to maxdat_reports;
grant select on QC_SKILL_GROUP to maxdatread;

grant select on QC_SKILL_GROUP_SV to maxdat_read_only;
grant select on QC_SKILL_GROUP_SV to maxdat_reports;
grant select on QC_SKILL_GROUP_SV to maxdatread;

create or replace view qc_random_sample_sv as
select
AGENT_ID   
,USER_NAME  
,USER_LAST_NAME 
,USER_FIRST_NAME    
,EMPLOYEE_ID      
,SUPERVISOR     
,SKILL        
,LANGUAGE
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
, SG.SAMPLE_GROUP DEPARTMENT
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
LEFT JOIN (select distinct tx_eb_skill_group, sample_group from maxdat.QC_SKILL_GROUP) SG ON sG.tx_eb_skill_group = RS.tx_eb_skill_group
;

grant select on QC_RANDOM_SAMPLE_SV to maxdat_read_only;
grant select on QC_RANDOM_SAMPLE_SV to maxdat_reports;
grant select on QC_RANDOM_SAMPLE_SV to maxdatread;
