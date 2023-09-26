UPDATE file_load_log
SET load_date = dateadd(HOUR,-8,load_date)
WHERE upper(filename) = 'WFM_STAFF_ROSTER20230307010752';

UPDATE INEO_WFM_DAILY_STAFF_ATTENDANCE_ROSTER_HISTORY
SET sf_create_ts = dateadd(HOUR,-8,sf_create_ts)
WHERE upper(filename) = 'WFM_STAFF_ROSTER20230307010752';

UPDATE INEO_WFM_DAILY_STAFF_ATTENDANCE_ROSTER
SET sf_create_ts = dateadd(HOUR,-8,sf_create_ts)
WHERE upper(filename) = 'WFM_STAFF_ROSTER20230307010752';

UPDATE file_load_log
SET load_date = dateadd(HOUR,-11,load_date)
WHERE upper(filename) = 'WFM_STAFF_ROSTER20230302124656';

UPDATE INEO_WFM_DAILY_STAFF_ATTENDANCE_ROSTER_HISTORY
SET sf_create_ts = dateadd(HOUR,-11,sf_create_ts)
WHERE upper(filename) = 'WFM_STAFF_ROSTER20230302124656';

UPDATE INEO_WFM_DAILY_STAFF_ATTENDANCE_ROSTER
SET sf_create_ts = dateadd(HOUR,-11,sf_create_ts)
WHERE upper(filename) = 'WFM_STAFF_ROSTER20230302124656';

--Turn off ingestion for some files
UPDATE file_load_lkup
SET load_file = 'N'
WHERE filename_prefix in('QUALITY_SCORES','INEO_PT_STAFF_ROSTER','WFM_DAILY_CHECK_IN_ARCHIVES__X','ARCHIVED_TIME_OFF_REQUESTS','ARCHIVED_UNSCHEDULED_ABSENCES_PRODUCTION',
                        'PIONEER_TEAM_COMS_LOG_ARCHIVE','QUALITY_APP_PROCESS_SCORECARD_ACTIVE','QUALITY_APP_PROCESSING_SCORECARD_ARCHIVE','QUALITY_CHANGE_PROCESSING_SCORECARD_ACTIVE',
                        'QUALITY_REDETS_SCORECARD_ACTIVE','QUALITY_TASK_NOTIFICATIONS_ARCHIVE');