ALTER TABLE d_mw_task_instance modify case_id VARCHAR2(20 CHAR);

alter table d_mw_task_instance add (ROLE VARCHAR2(50 BYTE));

alter table d_mw_task_instance add (PART VARCHAR2(255 BYTE));

alter table d_mw_task_instance add (RECEIVED_DATE date);

create or replace view D_MW_TASK_INSTANCE_SV as
  select
  MW_BI_ID,                       
  AGE_IN_BUSINESS_DAYS,           
  AGE_IN_CALENDAR_DAYS,           
  CANCELLED_BY_STAFF_ID,          
  CANCEL_METHOD,                  
  CANCEL_REASON,                  
  CANCEL_WORK_DATE,               
  CASE_ID,                        
  CLIENT_ID,                      
  COMPLETE_DATE,                  
  CREATE_DATE,                    
  CURR_CREATED_BY_STAFF_ID,	 
  ESCALATED_FLAG,            
  CURR_ESCALATED_TO_STAFF_ID,	 
  CURR_FORWARDED_BY_STAFF_ID,	 
  FORWARDED_FLAG,            
  CURR_BUSINESS_UNIT_ID,
  INSTANCE_START_DATE,            
  INSTANCE_END_DATE,              
  JEOPARDY_FLAG,                  
  CURR_LAST_UPD_BY_STAFF_ID,	 
  CURR_LAST_UPDATE_DATE,
  CURR_OWNER_STAFF_ID,	         
  PARENT_TASK_ID,                 
  SOURCE_REFERENCE_ID,            
  SOURCE_REFERENCE_TYPE,          
  CURR_STATUS_DATE,               
  STATUS_AGE_IN_BUS_DAYS,         
  STATUS_AGE_IN_CAL_DAYS,         
  STG_EXTRACT_DATE,               
  STG_LAST_UPDATE_DATE,           
  STAGE_DONE_DATE,                
  TASK_ID,                        
  TASK_PRIORITY,                  
  CURR_TASK_STATUS,               
  TASK_TYPE_ID,              
  CURR_TEAM_ID,
  TIMELINESS_STATUS,              
  UNIT_OF_WORK,                   
  CURR_WORK_RECEIPT_DATE,
  SOURCE_PROCESS_ID, 
  SOURCE_PROCESS_INSTANCE_ID,
  curr_claim_date,
ROLE,
PART,
RECEIVED_DATE  
 from D_MW_TASK_INSTANCE
with read only;  

grant select on D_MW_TASK_INSTANCE_SV to MAXDAT_READ_ONLY;

