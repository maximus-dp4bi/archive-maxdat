use role SYSADMIN;
use warehouse DECISIONPOINT_UAT_WH;
use database DECISIONPOINT_UAT;
use schema CONFIG;

SELECT 
	ph.projectid,
	ph.holidayid,
	h.holidayname,
	ph.holidaydate,
	ph.holidaystartdate,
	ph.holidayenddate
FROM 
	c_project_holidays_sv  ph,
	c_holidays_sv  h
WHERE 
	ph.projectid = 7 
AND ph.holidaydate >= '2023-01-01' 
AND ph.holidayid = h.holidayid
ORDER BY ph.holidaystartdate;
