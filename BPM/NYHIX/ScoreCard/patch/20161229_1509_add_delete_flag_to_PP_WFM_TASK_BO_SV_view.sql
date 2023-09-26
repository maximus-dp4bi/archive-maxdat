CREATE OR REPLACE VIEW DP_SCORECARD.PP_WFM_TASK_BO_SV
AS
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
,SCHEDULE_INSTANCE_ID 
,TASK_EDIT_ID
,EDIT_STATE 
,ALT_TASK_EDIT_ID 
,NATIONAL_ID
,MAKE_DATE_TIME 
,EXTRACT_DT     
,LAST_UPDATE_DT 
,LAST_UPDATED_BY
FROM PP_WFM_TASK_BO
WHERE DELETE_FLAG = 'N'
WITH READ ONLY;

GRANT SELECT ON DP_SCORECARD.PP_WFM_TASK_BO_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.PP_WFM_TASK_BO_SV TO MAXDAT_READ_ONLY;
