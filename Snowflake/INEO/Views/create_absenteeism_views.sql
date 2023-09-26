CREATE OR REPLACE VIEW INEO_D_JAN_ABSENTEEISM_SV
AS
SELECT * FROM ineo_jan_absenteeism;

CREATE OR REPLACE VIEW INEO_D_JAN_ABSENTEEISM_BY_REGION_SV
AS
SELECT * FROM ineo_jan_absenteeism_region;

SELECT * FROM INEO_D_JAN_ABSENTEEISM_SV;

CREATE OR REPLACE VIEW ineo_d_absenteeism_by_day_sv
AS
WITH t1 AS 
(
SELECT 
     --DATE(t.sf_create_ts) AS date
      DATE(ll.file_date)-1 AS date
     , SUM (CASE WHEN t.attendance_status = 'Approved Time Off' THEN 1 ELSE 0 END)                 AS ato
     , SUM (CASE WHEN t.attendance_status = 'Checked In' THEN 1 ELSE 0 END)                        AS ci
     , SUM (CASE WHEN t.attendance_status = 'NCNS' THEN 1 ELSE 0 END)                              AS ncns  
     , SUM (CASE WHEN (t.attendance_status = 'Not Checked In' or t.attendance_status IS NULL) THEN 1 ELSE 0 END) AS nci    
     , SUM (CASE WHEN t.attendance_status = 'Unscheduled Absence - Full Day' THEN 1 ELSE 0 END)    AS uafd
     , SUM (CASE WHEN t.attendance_status = 'Unscheduled Absence - Partial Day' THEN 1 ELSE 0 END) AS uapd
     , SUM (CASE WHEN t.attendance_status = 'Unscheduled Absence' THEN 1 ELSE 0 END)               AS ua
FROM INEO.ineo_wfm_daily_staff_attendance_roster_history t
  JOIN file_load_log ll ON UPPER(t.filename) = UPPER(ll.filename)
WHERE t.sf_create_ts >= CAST('02/01/2023' AS DATE)
AND   t.employee_status = 'Active'
GROUP BY DATE(ll.file_date)-1
UNION ALL  
SELECT tt.date, tt.approved_time_off as ato
, tt.checked_in as ci
, tt.ncns
, tt.not_checked_in as nci
, tt.unscheduled_absence_full_day as uafd
, tt.unscheduled_absence_part_day as uapd
, tt.unscheduled_absence as ua
FROM INEO.INEO_JAN_ABSENTEEISM tt 
)
SELECT t1.date
      ,t1.ato AS approved_time_off
      ,t1.ci AS checked_in
      ,t1.ncns AS ncns
      ,t1.nci AS not_checked_in
      ,t1.uafd + t1.ua AS unsched_full_day
      ,t1.uapd AS unsched_part_day
      ,t1.ato + t1.ci + t1.ncns + t1.nci + t1.uafd + t1.uapd + t1.ua AS total_staff
      ,t1.ncns + t1.nci + t1.uafd + t1.ua AS absent
      ,t1.ato + t1.ci + t1.ncns + t1.nci + t1.uafd + t1.uapd + t1.ua - t1.ato AS headcount
      ,((t1.ncns + t1.nci + t1.uafd + t1.ua) / (t1.ato + t1.ci + t1.ncns + t1.nci + t1.uafd + t1.uapd + t1.ua - t1.ato)) AS abs_rate
FROM t1;

CREATE OR REPLACE VIEW ineo_d_absenteeism_by_day_region_sv
AS
WITH t1 AS 
(
SELECT --DATE(t.sf_create_ts) AS date
     DATE(ll.file_date)-1 AS date
    ,  t.region AS region
     , SUM (CASE WHEN t.attendance_status = 'Approved Time Off' THEN 1 ELSE 0 END)                 AS ato
     , SUM (CASE WHEN t.attendance_status = 'Checked In' THEN 1 ELSE 0 END)                        AS ci
     , SUM (CASE WHEN t.attendance_status = 'NCNS' THEN 1 ELSE 0 END)                              AS ncns  
     , SUM (CASE WHEN (t.attendance_status = 'Not Checked In' or t.attendance_status IS NULL) THEN 1 ELSE 0 END) AS nci    
     , SUM (CASE WHEN t.attendance_status = 'Unscheduled Absence - Full Day' THEN 1 ELSE 0 END)    AS uafd
     , SUM (CASE WHEN t.attendance_status = 'Unscheduled Absence - Partial Day' THEN 1 ELSE 0 END) AS uapd
     , SUM (CASE WHEN t.attendance_status = 'Unscheduled Absence' THEN 1 ELSE 0 END)               AS ua
FROM INEO.ineo_wfm_daily_staff_attendance_roster_history t
  JOIN file_load_log ll ON UPPER(t.filename) = UPPER(ll.filename)
WHERE t.sf_create_ts >= CAST('02/01/2023' AS DATE)
AND t.employee_status = 'Active'
GROUP BY DATE(ll.file_date)-1, t.region
UNION ALL
SELECT tt.date
     , tt.region
     , nvl(tt.approved_time_off,0) as ato
     , nvl(tt.checked_in,0) as ci
     , nvl(tt.ncns,0) as ncns
     , nvl(tt.not_checked_in,0) as nci
     , nvl(tt.unscheduled_absence_full_day,0) as uafd
     , nvl(tt.unscheduled_absence_part_day,0) as uapd
     , nvl(tt.unscheduled_absence,0) as ua
FROM INEO.INEO_JAN_ABSENTEEISM_REGION tt 
)
SELECT t1.date
      ,t1.region
      ,t1.ato AS approved_time_off
      ,t1.ci AS checked_in
      ,t1.ncns AS ncns
      ,t1.nci AS not_checked_in
      ,t1.uafd + t1.ua AS unsched_full_day
      ,t1.uapd AS unsched_part_day
      ,t1.ato + t1.ci + t1.ncns + t1.nci + t1.uafd + t1.uapd + t1.ua AS total_staff
      ,t1.ncns + t1.nci + t1.uafd + t1.ua AS absent
      ,t1.ato + t1.ci + t1.ncns + t1.nci + t1.uafd + t1.uapd + t1.ua - t1.ato AS headcount
      ,((t1.ncns + t1.nci + t1.uafd + t1.ua) / (t1.ato + t1.ci + t1.ncns + t1.nci + t1.uafd + t1.uapd + t1.ua - t1.ato)) AS abs_rate
FROM t1
;