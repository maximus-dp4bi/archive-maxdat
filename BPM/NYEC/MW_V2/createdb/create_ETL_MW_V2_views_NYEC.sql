/*
Created on 05/11/2015 by Raj A.
Description: IDR Incidents and Appeals process does not exist for NYEC project. So, removed from the view and making this a project view.
*/
create or replace view D_MW_V2_INCIDENT_CURR_SV as
select 
  MW.SOURCE_REFERENCE_ID as INCIDENT_ID,
  CMP.INCIDENT_TRACKING_NUMBER as INCIDENT_TRACKING_NUMBER,
  MW.MW_BI_ID,                       
  MW.AGE_IN_BUSINESS_DAYS,           
  MW.AGE_IN_CALENDAR_DAYS,           
  MW.CANCELLED_BY_STAFF_ID,          
  MW.CANCEL_METHOD,                  
  MW.CANCEL_REASON,                  
  MW.CANCEL_WORK_DATE,               
  MW.CASE_ID,                        
  MW.CLIENT_ID,                      
  MW.COMPLETE_DATE,                  
  MW.CREATE_DATE,                    
  MW.CURR_CREATED_BY_STAFF_ID,	 
  MW.ESCALATED_FLAG,            
  MW.CURR_ESCALATED_TO_STAFF_ID,	 
  MW.CURR_FORWARDED_BY_STAFF_ID,	 
  MW.FORWARDED_FLAG,            
  MW.CURR_BUSINESS_UNIT_ID,
  MW.INSTANCE_START_DATE,            
  MW.INSTANCE_END_DATE,              
  MW.JEOPARDY_FLAG,                  
  MW.CURR_LAST_UPD_BY_STAFF_ID,	 
  MW.CURR_LAST_UPDATE_DATE,
  MW.CURR_OWNER_STAFF_ID,	         
  MW.PARENT_TASK_ID,     
  MW.CURR_STATUS_DATE,               
  MW.STATUS_AGE_IN_BUS_DAYS,         
  MW.STATUS_AGE_IN_CAL_DAYS,     
  MW.STAGE_DONE_DATE,                
  MW.TASK_ID,                        
  MW.TASK_PRIORITY,                  
  MW.CURR_TASK_STATUS,               
  MW.TASK_TYPE_ID,              
  MW.CURR_TEAM_ID,
  MW.TIMELINESS_STATUS,              
  MW.UNIT_OF_WORK,                   
  MW.CURR_WORK_RECEIPT_DATE,
  MW.SOURCE_PROCESS_ID,
  MW.SOURCE_PROCESS_INSTANCE_ID
  from D_MW_V2_CURRENT MW, D_COMPLAINT_CURRENT CMP
where MW.SOURCE_REFERENCE_TYPE = 'Incident ID'
   and MW.SOURCE_REFERENCE_ID = CMP.INCIDENT_ID;
   
create or replace public synonym D_MW_V2_INCIDENT_CURR_SV for D_MW_V2_INCIDENT_CURR_SV;
grant select on D_MW_V2_INCIDENT_CURR_SV to MAXDAT_READ_ONLY;