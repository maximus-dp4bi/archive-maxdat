CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT"."D_CES_LOGIN_FIRST_LAST_SV" ("FIRST_NAME", "LAST_NAME", "EXT_STAFF_NUM", "STAFF_TYPE_CODE",  "SEC_USER_ID", "STAFF_NUMBER", "AGENT_WFM_ID", "EMPLOYEE_ID", "MANAGEMENT_UNIT_DATE", "SCHEDULE_START_MU_DATETIME", "AGENT_FIRST_LOGIN_TIME","SCHEDULE_END_MU_DATETIME", "AGENT_LAST_LOGOUT_TIME","RECORD_STATUS") AS 
  (
SELECT DISTINCT d1.FIRST_NAME, 
	d1.LAST_NAME , 
	d1.EXT_STAFF_NUM , 
	d1.STAFF_TYPE_CODE , 
	d1.SEC_USER_ID, 
    d1.STAFF_NUMBER, 
	d1.AGENT_WFM_ID , 
	d1.EMPLOYEE_ID, 
	COALESCE(d1.management_unit_date, l1.management_unit_date, l0.management_unit_date) management_unit_date, 
	d1.SCHEDULE_START_MU_DATETIME,
    l1.AGENT_FIRST_LOGIN_TIME,
	d1.SCHEDULE_END_MU_DATETIME, 
    l0.agent_last_logout_time,
    CASE WHEN d1.Employee_id IS NULL THEN 'Not a Current Employee'
	     WHEN d1.management_unit_date IS NULL THEN 'No Valid Schedule'
	     WHEN nvl(l1.AGENT_FIRST_LOGIN_TIME, to_date('2021/01/01','yyyy/mm/dd')) NOT BETWEEN d1.SCHEDULE_START_MU_DATETIME AND d1.SCHEDULE_END_MU_DATETIME
	       OR nvl(l0.AGENT_last_LOGout_TIME, to_date('2021/01/01','yyyy/mm/dd')) NOT BETWEEN d1.SCHEDULE_START_MU_DATETIME AND d1.SCHEDULE_END_MU_DATETIME
	     THEN 'Login/Logout Violation'
	     ELSE 'Valid Logon/Logout'
	END Record_Status
FROM D_CES_LOGIN d1
LEFT JOIN (SELECT ext_staff_num, TRUNC(create_ts) management_unit_date, min(create_ts) AGENT_FIRST_LOGIN_TIME FROM D_CES_LOGIN WHERE ACTION = 'Logon Sucessful' GROUP BY EXT_STAFF_NUM, TRUNC(create_ts)) l1 ON d1.EXT_STAFF_NUM = l1.EXT_STAFF_NUM AND COALESCE(d1.management_unit_date, l1.management_unit_date) = l1.MANAGEMENT_UNIT_DATE 
LEFT JOIN (SELECT ext_staff_num, TRUNC(create_ts) management_unit_date, max(create_ts) agent_last_logout_time FROM D_CES_LOGIN WHERE ACTION = 'Logout' GROUP BY EXT_STAFF_NUM, TRUNC(create_ts)) l0 ON d1.EXT_STAFF_NUM = l0.EXT_STAFF_NUM AND COALESCE(d1.management_unit_date, l1.management_unit_date) = l0.MANAGEMENT_UNIT_DATE 
);

GRANT SELECT ON MAXDAT.D_CES_LOGIN_FIRST_LAST_SV TO MAXDAT_READ_ONLY;
   