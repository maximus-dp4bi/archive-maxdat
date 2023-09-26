/*
Load files through SQL Developer

1.  Save the files as .csv
2.  Right click on Tables folder
3.  Choose Import Data
4.  Choose the file to upload (Choose "none" on the left/right enclosures), hit next
5.  Enter the table name PP_FORECAST_VOL_STG for the PP_PROJECT_VOL_INI file, hit next
6.  Enter the table name PP_FORECAST_INV_STG for the PP_PROJECT_INV_INI file, hit next
7.  Leave the selected fields, hit next
8.  Leave all the datatypes to varchar2 but fix the size/precision (should be big enough for the values), hit next
9.  After the load, run the insert script below then drop the stage table
10. Run the 2 check queries below.
11. If the queries return the expected results, then execute LOAD_DEMO_DATA_PKG.LOAD_FORECAST_DATA
*/

select * from pp_forecast_inv_stg;
select * from pp_forecast_vol_stg;

--if there are multiple files to load, execute the truncate table statements only the first time.  Do NOT execute these truncate table statements if loading the next file
TRUNCATE TABLE pp_fcst_volume_data_ffile;
TRUNCATE TABLE pp_fcst_inventory_data_ffile;

INSERT INTO pp_fcst_volume_data_ffile(HORIZON_START_DATE
,HORIZON_END_DATE
,DAY_OF_PLAN
,FORECAST_HOUR
,UNIT_OF_WORK_NAME
,ARRIVAL_VOLUME
,COMPLETION_VOLUME
,STAFF_HOURS
,HANDLE_TIME_AVG
,HANDLE_TIME_MIN
,HANDLE_TIME_MAX
,CFG_PRODUCTION_PLAN_ID)
SELECT to_date(plan_start_date,'mm/dd/yyyy')
,to_date(plan_end_date,'mm/dd/yyyy')
,to_number(sim_day)
,to_number(placeholder)
,trim(unit_of_work) 
,to_number(tasks_created)
,to_number(tasks_completed)
,to_number(assigned_hours)
,to_number(aht)
,to_number(min_ht)
,to_number(max_ht)
,1
FROM pp_forecast_vol_stg;


INSERT INTO pp_fcst_inventory_data_ffile(
HORIZON_START_DATE
,HORIZON_END_DATE
,DAY_OF_PLAN
,FORECAST_HOUR
,UNIT_OF_WORK_NAME
,INVENTORY_AGE
,INVENTORY_VOLUME
,CFG_PRODUCTION_PLAN_ID)
SELECT to_date(plan_start_date,'mm/dd/yyyy')
,to_date(plan_end_date,'mm/dd/yyyy')
,to_number(sim_day)
,to_number(placeholder)
,trim(unit_of_work)
,to_number(age)
,to_number(number_of_tasks)
,1
FROM pp_forecast_inv_stg;

UPDATE pp_fcst_volume_data_ffile
   SET FORECAST_DATE = TRUNC(HORIZON_START_DATE + (DAY_OF_PLAN - 1)) WHERE FORECAST_DATE IS NULL;

UPDATE pp_fcst_inventory_data_ffile
   SET FORECAST_DATE = TRUNC(HORIZON_START_DATE + (DAY_OF_PLAN - 1)) WHERE FORECAST_DATE IS NULL;
COMMIT;

--Drop stage tables if files were successfully loaded
DROP TABLE pp_forecast_vol_stg;
DROP TABLE pp_forecast_inv_stg;

/* Note :  If unit of work query returns data, do not load the file.  Raise the issue.
           If the horizon start/end date query does not return any data, do not load the file.  Raise the issue.  This means that there are start/end dates that do not cover the forecast date*/
           
--Check if there is any invalid unit of work after loading data from the file
SELECT DISTINCT SFI.CFG_PRODUCTION_PLAN_ID, TRIM(SFI.UNIT_OF_WORK_NAME) AS UNIT_OF_WORK_NAME
  FROM PP_STG_FCST_BY_INV_AGE SFI
 WHERE CFG_PRODUCTION_PLAN_ID=1 AND PROCESS_DATE IS NULL AND NOT EXISTs
 (SELECT TRIM(UOW.UNIT_OF_WORK_NAME)
          FROM PP_CFG_UNIT_OF_WORK UOW
         WHERE CFG_PRODUCTION_PLAN_ID=1 AND TRIM(SFI.UNIT_OF_WORK_NAME) = TRIM(UOW.UNIT_OF_WORK_NAME));

select * from  PP_STG_FCST_BY_INV_AGE
 WHERE CFG_PRODUCTION_PLAN_ID = 1
   AND PROCESS_DATE IS NULL;

--Check if forecast dates are within the horizon start/end dates
WITH FORECAST_HORIZON AS
(
SELECT DISTINCT CFG_PRODUCTION_PLAN_ID,
                HORIZON_START_DATE,
                HORIZON_END_DATE
  from PP_STG_FCST_BY_INV_AGE
 WHERE CFG_PRODUCTION_PLAN_ID = 1
   AND PROCESS_DATE IS NULL
)
,MIN_MAX_FORECAST_DATES AS (
SELECT MIN(X.FORECAST_DATE) AS MIN_FORECAST_DATE, MAX(X.FORECAST_DATE) AS MAX_FORECAST_DATE FROM PP_STG_FCST_BY_INV_AGE X WHERE CFG_PRODUCTION_PLAN_ID = 1
   AND PROCESS_DATE IS NULL
   )
SELECT 1 AS CNT
  FROM FORECAST_HORIZON FH, MIN_MAX_FORECAST_DATES MMFD
 WHERE FH.HORIZON_START_DATE = MMFD.MIN_FORECAST_DATE
   AND FH.HORIZON_END_DATE = MMFD.MAX_FORECAST_DATE       ;



--if there are multiple files to load, execute the truncate_pp_table proc only the first time.  
--Do NOT execute truncate_pp_table proc if loading the next file
EXECUTE LOAD_DEMO_DATA_PKG.TRUNCATE_PP_TABLE ;

--Do NOT execute these delete/truncate statements if loading the next file
DELETE FROM PP_CFG_HORIZON
WHERE cfg_horizon_id >= 42; --this is to remove all date ranges inserted by the refresh procs

TRUNCATE TABLE PP_F_FORECAST;

DELETE FROM pp_d_production_plan_horizon
WHERE pph_id >= 42;
----

--Load to Forecast table  
execute LOAD_DEMO_DATA_PKG.LOAD_FORECAST_DATA;   