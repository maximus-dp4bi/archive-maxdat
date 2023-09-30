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
,SCENARIO_GROUP_ID
FROM PP_BO_TASK
WITH READ ONLY;