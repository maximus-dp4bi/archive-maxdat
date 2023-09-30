CREATE OR REPLACE VIEW PP_WFM_SCHEDULE_MONITOR_SV AS
SELECT TASK_START
 ,STAFF_ID	
 ,EVENT_ID	
 ,TASK_END	
 ,TASK_ROWID
 ,MESSAGE_SENT
 ,EXTRACT_DT     
 ,LAST_UPDATE_DT 
 ,LAST_UPDATED_BY
FROM PP_WFM_SCHEDULE_MONITOR
WITH READ ONLY;




CREATE OR REPLACE VIEW PP_WFM_STAFF_SV AS
SELECT STAFF_ID	      
,NATIONAL_ID	      
,LAST_NAME	      
,FIRST_NAME	      
,MIDDLE_NAME	      
,SUFFIX	              
,HIRE_DATE	      
,TERMINATION_DATE     
,SCHEDULE_TYPE	      
,DELETE_DATE	      
,SENIORITY_EFFECTIVE_DATE		
,OWNER_USER	      
,MODIFY_USER	      
,OWNER_DATE	      
,MODIFY_DATE	      
,EMAIL_ADDRESS	      
,COMMAND_SCRIPT	      
,MESSAGE_BUFFER	      
,SECONDARY_ID	      
,ADDRESS	      
,WORK_PHONE	      
,HOME_PHONE	      
,TERMINATION_POLICY_ID
,TERMINATION_REASON   
,PIP_ADDRESS	      
,TEXT_ADDRESS	      
,CELL_PHONE
,EXTRACT_DT     
,LAST_UPDATE_DT 
,LAST_UPDATED_BY
FROM PP_WFM_STAFF
WITH READ ONLY;




CREATE OR REPLACE VIEW PP_WFM_STAFF_GROUP_SV AS
SELECT STAFF_GROUP_ID	
,PFUSER_ID	
,NAME	        
,CATEGORY	
,DESCRIPTION	
,OWNER_USER	
,MODIFY_USER	
,OWNER_DATE	
,MODIFY_DATE	
,DELETE_DATE
,EXTRACT_DT     
,LAST_UPDATE_DT 
,LAST_UPDATED_BY
FROM PP_WFM_STAFF_GROUP
WITH READ ONLY;



CREATE OR REPLACE VIEW PP_WFM_STAFF_GROUP_TO_STAFF_SV AS
SELECT STAFF_ID	
,STAFF_GROUP_ID	
,END_DATE	
,START_DATE
,EXTRACT_DT     
,LAST_UPDATE_DT 
,LAST_UPDATED_BY
FROM PP_WFM_STAFF_GROUP_TO_STAFF
WHERE END_DATE IS NULL
WITH READ ONLY;




CREATE OR REPLACE VIEW PP_WFM_TASK_SV AS
SELECT  STAFF_ID	 
,TASK_START	 
,TASK_END	 
,TASK_CATEGORY_ID
,DURATION	 
,EVENT_ID	 
,SUPERVISOR	 
,TASK_MODIFICATION_REQUEST_REF
,TASK_ID
,SCENARIO_GROUP_ID
,EXTRACT_DT     
,LAST_UPDATE_DT 
,LAST_UPDATED_BY
FROM PP_WFM_TASK
WITH READ ONLY;



CREATE OR REPLACE VIEW PP_WFM_TASK_CATEGORY_SV AS
SELECT  TASK_CATEGORY_ID
,NAME	          
,DESCRIPTION	  
,CATEGORY	  
,PAID	          
,SEQUENCE
,EXTRACT_DT     
,LAST_UPDATE_DT 
,LAST_UPDATED_BY
FROM PP_WFM_TASK_CATEGORY
WITH READ ONLY;

CREATE OR REPLACE VIEW PP_WFM_SUPERVISOR_TO_STAFF_SV AS
SELECT 
  STAFF_ID	
 ,SUPERVISOR_ID	
 ,EFFECTIVE_DATE 
 ,END_DATE	
 ,PRIORITY
 ,EXTRACT_DT     
 ,LAST_UPDATE_DT 
 ,LAST_UPDATED_BY
FROM PP_WFM_SUPERVISOR_TO_STAFF
WHERE END_DATE IS NULL
WITH READ ONLY;

CREATE OR REPLACE VIEW PP_WFM_SUPERVISOR_SV AS
SELECT
 STAFF_ID	
,DESCRIPTION	
,RANK	        
,SUPERVISOR_ID	
,DELETE_DATE	
,EXTRACT_DT     
,LAST_UPDATE_DT 
,LAST_UPDATED_BY
FROM PP_WFM_SUPERVISOR
WITH READ ONLY;

CREATE OR REPLACE VIEW PP_WFM_EVENT_SV AS
SELECT
 EVENT_ID             
,NAME                 
,EVENT_TYPE_GROUP_ID  
,EVENT_TYPE_ID        
,DELETE_DATE          
,DESCRIPTION          
,MODIFY_USER          
,OWNER_DATE           
,MODIFY_DATE          
,EXTRACT_DT           
,LAST_UPDATE_DT       
,LAST_UPDATED_BY      
FROM PP_WFM_EVENT
WITH READ ONLY;

CREATE OR REPLACE VIEW PP_WFM_EVENT_TYPE_GROUP_SV AS
SELECT
EVENT_TYPE_GROUP_ID  
,NAME                
,DESCRIPTION         
,EVENT_TYPE_ID       
,DELETE_DATE         
,EXTRACT_DT          
,LAST_UPDATE_DT      
,LAST_UPDATED_BY     
FROM PP_WFM_EVENT_TYPE_GROUP
WITH READ ONLY;

CREATE OR REPLACE VIEW PP_WFM_EVENT_TYPE_SV AS
SELECT
EVENT_TYPE_ID     
,NAME             
,DESCRIPTION      
,WORK_TYPE        
,EXTRACT_DT       
,LAST_UPDATE_DT   
,LAST_UPDATED_BY  
FROM PP_WFM_EVENT_TYPE
WITH READ ONLY;



grant select on PP_WFM_SCHEDULE_MONITOR_SV to MAXDAT_READ_ONLY;
grant select on PP_WFM_STAFF_SV to MAXDAT_READ_ONLY;
grant select on PP_WFM_STAFF_GROUP_SV to MAXDAT_READ_ONLY;
grant select on PP_WFM_STAFF_GROUP_TO_STAFF_SV to MAXDAT_READ_ONLY;
grant select on PP_WFM_TASK_SV to MAXDAT_READ_ONLY;
grant select on PP_WFM_TASK_CATEGORY_SV to MAXDAT_READ_ONLY;
grant select on PP_WFM_SUPERVISOR_TO_STAFF_SV to MAXDAT_READ_ONLY;
grant select on PP_WFM_SUPERVISOR_SV to MAXDAT_READ_ONLY;
grant select on PP_WFM_EVENT_SV to MAXDAT_READ_ONLY;
grant select on PP_WFM_EVENT_TYPE_GROUP_SV to MAXDAT_READ_ONLY;
grant select on PP_WFM_EVENT_TYPE_SV to MAXDAT_READ_ONLY;