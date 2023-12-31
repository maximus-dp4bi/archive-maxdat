 CREATE OR REPLACE VIEW D_MW_V2_CURRENT_SV AS
  SELECT
  MW_BI_ID,                       
  AGE_IN_BUSINESS_DAYS,           
  AGE_IN_CALENDAR_DAYS,           
  CANCELLED_BY_STAFF_ID,          
  CANCEL_METHOD,                  
  CANCEL_REASON,                  
  CANCEL_WORK_DATE,               
  mw.CASE_ID,                        
  mw.CLIENT_ID,                      
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
  cc.clnt_cin RECIPIENT_ID  
FROM D_MW_V2_CURRENT mw
 LEFT JOIN client_stg cc ON mw.client_id = cc.client_id    
with read only;  

grant select on D_MW_V2_CURRENT_SV to MAXDAT_READ_ONLY;