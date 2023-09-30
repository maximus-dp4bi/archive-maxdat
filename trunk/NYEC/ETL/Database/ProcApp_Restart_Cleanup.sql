-- DATABASE SET UP FOR INITIAL LOAD
-- -----------------------------------------------
--set up for initial process app load
SELECT COUNT(*) FROM  nyec_etl_process_app;
-- delete bpm stage table
TRUNCATE TABLE nyec_etl_process_app;
SELECT COUNT(*) FROM  nyec_etl_process_app;

SELECT COUNT(*) FROM  process_app_stg;
-- delete  system stage table
TRUNCATE TABLE process_app_stg;
SELECT COUNT(*) FROM  process_app_stg;

-- update process control variables, Please not a value of 999 is for initial load only
UPDATE corp_etl_control
SET VALUE = '999'
WHERE NAME = 'AP_PROCESS_DAYS';

UPDATE corp_etl_control
SET VALUE = '1'
WHERE NAME = 'AP_LAST_APPLICATION_ID';   
COMMIT;
