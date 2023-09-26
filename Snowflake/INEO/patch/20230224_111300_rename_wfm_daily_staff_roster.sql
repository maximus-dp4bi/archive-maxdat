
update file_load_lkup
set load_file = 'N'
where filename_prefix = 'WFM_DAILY_STAFF_ATTENDANCE_ROSTER';

INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('WFM_STAFF_ROSTER','INEO_WFM_DAILY_STAFF_ATTENDANCE_ROSTER_HISTORY','INEO',
       'wfm_attendance_id,attendance_status,attendance_substatus,checked_in,date,employee_id,employee_name,employee_status,employee_type,filename,manager,modified,points_accrued_to_date,points_earned,position_title,region,supervisor,time,time_zone,timestamp,training_status,regions_supporting',
      'TRIM(CONCAT(TO_CHAR(TRY_CAST(modified AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]'')))  wfm_attendance_id,attendance_status,attendance_substatus,
 checked_in,TRY_CAST(date AS DATE),employee_id,employee_name,employee_status,employee_type,filename,manager,TRY_CAST(modified AS TIMESTAMP_NTZ),TRY_CAST(points_accrued_to_date AS NUMBER),TRY_CAST(points_earned AS NUMBER),position_title,region,supervisor,time,time_zone,TRY_CAST(timestamp AS TIMESTAMP_NTZ),training_status,regions_supporting',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_WFM_DAILY_STAFF_ATTENDANCE_ROSTER','WFM_ATTENDANCE_ID','WFM_ATTENDANCE_HISTORY_ID'); 

update file_load_lkup
set load_file = 'N'
where filename_prefix = 'ARCHIVED_DAILY_CHECK_INS';


INSERT INTO file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,derive_timestamp_stmt,file_day_received,current_table_name,current_table_primary_key,full_load_table_primary_key)
VALUES('WFM_DAILY_CHECK_IN_ARCHIVES__X','INEO_ARCHIVED_DAILY_CHECK_INS_HISTORY','INEO',
       'archived_daily_checkin_id,attendance_status,created,date,department,employee_id,employee_name,employee_status,filename,maximus_email,position_title,region,submitted_employee_name,training_status',
      'TRIM(CONCAT(TO_CHAR(TRY_CAST(created AS TIMESTAMP_NTZ),''yyyymmddhh24miss''),REGEXP_REPLACE(UPPER(employee_id),''[^A-Za-z0-9]''))),attendance_status,TRY_CAST(created AS TIMESTAMP_NTZ),TRY_CAST(date AS DATE),department,employee_id,employee_name,employee_status,filename,maximus_email,position_title,region,submitted_employee_name,training_status',
      'WHERE 1=1','Y', 'SELECT TO_CHAR(TO_TIMESTAMP(TRIM(SUBSTR(<filename>,LENGTH(<filename>)-13)),''yyyymmddhh24miss''),''mm/dd/yyyy hh24:mi:ss'') file_date,''Y'' with_timestamp FROM dual','PREVIOUS_BUSINESS_DAY',
      'INEO_ARCHIVED_DAILY_CHECK_INS','ARCHIVED_DAILY_CHECKIN_ID','ARCHIVE_CHECKIN_HISTORY_ID');      

DROP VIEW INEO_D_WFM_DAILY_STAFF_ATTENDANCE_ROSTER_HISTORY_SV;
DROP VIEW INEO_D_WFM_DAILY_STAFF_ATTENDANCE_ROSTER_SV;

CREATE OR REPLACE VIEW INEO_D_WFM_STAFF_ROSTER_HISTORY_SV
AS
SELECT * FROM ineo.ineo_wfm_daily_staff_attendance_roster_history;

CREATE OR REPLACE VIEW INEO_D_WFM_STAFF_ROSTER_SV
AS
SELECT * FROM ineo.ineo_wfm_daily_staff_attendance_roster;      