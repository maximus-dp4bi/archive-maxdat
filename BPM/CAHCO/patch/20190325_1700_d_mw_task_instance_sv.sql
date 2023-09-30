CREATE OR REPLACE VIEW D_MW_TASK_INSTANCE_SV
AS
SELECT 
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
  CASE WHEN complete_date IS NOT NULL AND CURR_CLAIM_DATE IS NOT NULL THEN curr_claim_date
       WHEN curr_task_status != 'CLAIMED' THEN NULL
       WHEN curr_task_status = 'CLAIMED' THEN curr_last_update_date
  ELSE NULL END curr_claim_date,
  c.SLA_DAYS,
  d.sla_jeopardy_days,
  e.sla_days_type,
  a.DCN,
  a.DOCUMENT_RECEIVED_DATE
from D_MW_TASK_INSTANCE a
LEFT JOIN (SELECT out_var SLA_DAYS, ref_id FROM CORP_ETL_LIST_LKUP b WHERE b.name = 'ManageWork_SLA_Days') c
ON a.TASK_TYPE_ID = c.ref_id
LEFT JOIN (SELECT out_var sla_jeopardy_days, ref_id FROM CORP_ETL_LIST_LKUP b WHERE b.name = 'ManageWork_SLA_Jeopardy_Days') d
ON a.TASK_TYPE_ID = d.ref_id
LEFT JOIN (SELECT out_var sla_days_type, ref_id FROM CORP_ETL_LIST_LKUP b WHERE b.name = 'ManageWork_SLA_Days_Type') e
ON a.TASK_TYPE_ID = e.ref_id
with read only;
/
--add or update dummy records for staff and team supervisor for when value is null/0 in case statements in view above
--insert into pa_ieb.d_staff (staff_id) values(0);
--update pa_ieb.d_teams set team_supervisor_staff_id = 0 where team_id = 0;

GRANT SELECT ON D_MW_TASK_INSTANCE_SV TO MAXDAT_READ_ONLY;

