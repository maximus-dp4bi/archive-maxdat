CREATE OR REPLACE VIEW PP_BO_SUPERVISOR_TO_STAFF_SV AS
SELECT 
  STAFF_ID	
 ,SUPERVISOR_ID	
 ,EFFECTIVE_DATE 
 ,END_DATE	
 ,PRIORITY	
FROM PP_BO_SUPERVISOR_TO_STAFF
WHERE END_DATE IS NULL
WITH READ ONLY;

CREATE OR REPLACE VIEW PP_BO_STAFF_GROUP_TO_STAFF_SV AS
SELECT STAFF_ID	
,STAFF_GROUP_ID	
,END_DATE	
,START_DATE	
FROM PP_BO_STAFF_GROUP_TO_STAFF
WHERE END_DATE IS NULL
WITH READ ONLY;