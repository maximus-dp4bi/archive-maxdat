CREATE OR REPLACE VIEW PP_BO_ACTUALS_SV AS
SELECT PP_BOA_ID 
,STAFF_ID 
,EVENT_ID 
,TASK_START 
,TASK_END 
,TASK_CATEGORY_ID 
,HANDLE_TIME 
,CREATE_DATE 
FROM PP_BO_ACTUALS
WITH READ ONLY;




CREATE OR REPLACE VIEW PP_BO_SCHEDULE_MONITOR_SV AS
SELECT TASK_START
 ,STAFF_ID	
 ,EVENT_ID	
 ,TASK_END	
 ,TASK_ROWID
 ,MESSAGE_SENT
FROM PP_BO_SCHEDULE_MONITOR
WITH READ ONLY;




CREATE OR REPLACE VIEW PP_BO_STAFF_SV AS
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
FROM PP_BO_STAFF
WITH READ ONLY;




CREATE OR REPLACE VIEW PP_BO_STAFF_GROUP_SV AS
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
FROM PP_BO_STAFF_GROUP
WITH READ ONLY;



CREATE OR REPLACE VIEW PP_BO_STAFF_GROUP_TO_STAFF_SV AS
SELECT STAFF_ID	
,STAFF_GROUP_ID	
,END_DATE	
,START_DATE	
FROM PP_BO_STAFF_GROUP_TO_STAFF
WITH READ ONLY;




CREATE OR REPLACE VIEW PP_BO_TASK_SV AS
SELECT  STAFF_ID	 
,TASK_START	 
,TASK_END	 
,TASK_CATEGORY_ID
,DURATION	 
,EVENT_ID	 
,SUPERVISOR	 
,TASK_MODIFICATION_REQUEST_REF
,TASK_ID	
FROM PP_BO_TASK
WITH READ ONLY;



CREATE OR REPLACE VIEW PP_BO_TASK_CATEGORY_SV AS
SELECT  TASK_CATEGORY_ID
,NAME	          
,DESCRIPTION	  
,CATEGORY	  
,PAID	          
,SEQUENCE	  
FROM PP_BO_TASK_CATEGORY
WITH READ ONLY;



grant select on PP_BO_ACTUALS_SV to MAXDAT_READ_ONLY;
grant select on PP_BO_SCHEDULE_MONITOR_SV to MAXDAT_READ_ONLY;
grant select on PP_BO_STAFF_SV to MAXDAT_READ_ONLY;
grant select on PP_BO_STAFF_GROUP_SV to MAXDAT_READ_ONLY;
grant select on PP_BO_STAFF_GROUP_TO_STAFF_SV to MAXDAT_READ_ONLY;
grant select on PP_BO_TASK_SV to MAXDAT_READ_ONLY;
grant select on PP_BO_TASK_CATEGORY_SV to MAXDAT_READ_ONLY;



create or replace public synonym PP_BO_ACTUALS_SV for PP_BO_ACTUALS_SV;
create or replace public synonym PP_BO_SCHEDULE_MONITOR_SV for PP_BO_SCHEDULE_MONITOR_SV;
create or replace public synonym PP_BO_STAFF_SV for PP_BO_STAFF_SV;
create or replace public synonym PP_BO_STAFF_GROUP_SV for PP_BO_STAFF_GROUP_SV;
create or replace public synonym PP_BO_STAFF_GROUP_TO_STAFF_SV for PP_BO_STAFF_GROUP_TO_STAFF_SV;
create or replace public synonym PP_BO_TASK_SV for PP_BO_TASK_SV;
create or replace public synonym PP_BO_TASK_CATEGORY_SV for PP_BO_TASK_CATEGORY_SV;