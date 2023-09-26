CREATE OR REPLACE VIEW PP_BO_SUPERVISOR_SV AS
SELECT
 STAFF_ID	
,DESCRIPTION	
,RANK	        
,SUPERVISOR_ID	
,DELETE_DATE	
,EXTRACT_DT     
,LAST_UPDATE_DT 
,LAST_UPDATED_BY
FROM PP_BO_SUPERVISOR
WITH READ ONLY;

grant select on PP_BO_SUPERVISOR_SV to MAXDAT_READ_ONLY;

create or replace public synonym PP_BO_SUPERVISOR_SV for PP_BO_SUPERVISOR_SV;