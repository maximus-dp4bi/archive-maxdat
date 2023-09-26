/*
 2 Packages were created to load Forecast and MW data
 
 For loading MW, Actuals and Process Instance data, the package is LOAD_MW_AND_ACTUALS_PKG
 For loading Forecast data, the package is LOAD_DEMO_DATA_PKG

The scheduled job to refresh the dates runs everyday but it checks the CORP_ETL_CONTROL variable 'REFRESH_DEMO_DATA_RUNDATE' to determine if it needs to do the date updates or not

To see all scheduled jobs:

SELECT * FROM dba_jobs;

/*
To reload original data to MW tables
*/

drop table arena_task_data;
create table arena_task_data as select * from arena_task_data_orig;

begin
 LOAD_MW_AND_ACTUALS_PKG.LOAD_MW_SIM_DATA;
 LOAD_MW_AND_ACTUALS_PKG.LOAD_ACTUALS_DATA;
 LOAD_MW_AND_ACTUALS_PKG.POPULATE_PROCESS_INSTANCE;
 end;
 /
 
 /* 
 To reload original data to Forecast tables
 */

--Truncate tables and remove horizon start/end records first
EXECUTE LOAD_DEMO_DATA_PKG.TRUNCATE_PP_TABLE ;

DELETE FROM PP_CFG_HORIZON
WHERE cfg_horizon_id > 72; --this is to remove all date ranges inserted by the refresh procs

TRUNCATE TABLE PP_F_FORECAST;

DELETE FROM pp_d_production_plan_horizon
WHERE pph_id > 72;

--Since there where 2 files loaded, update the process date for the first file then execute LOAD_FORECAST_DATA
--Update the process date for the second file then execute LOAD_FORECAST_DATA again

UPDATE pp_fcst_volume_data_ffile
SET process_date = NULL
WHERE trunc(horizon_start_date) = to_date('04/29/2019','mm/dd/yyyy')
AND trunc(horizon_end_date) = to_date('05/12/2019','mm/dd/yyyy');

UPDATE pp_fcst_inventory_data_ffile
SET process_date = NULL
WHERE trunc(horizon_start_date) = to_date('04/29/2019','mm/dd/yyyy')
AND trunc(horizon_end_date) = to_date('05/12/2019','mm/dd/yyyy');

--commit;
execute LOAD_DEMO_DATA_PKG.LOAD_FORECAST_DATA;

UPDATE pp_fcst_volume_data_ffile
SET process_date = NULL
WHERE trunc(horizon_start_date) = to_date('05/13/2019','mm/dd/yyyy')
AND trunc(horizon_end_date) = to_date('05/26/2019','mm/dd/yyyy');

UPDATE pp_fcst_inventory_data_ffile
SET process_date = NULL
WHERE trunc(horizon_start_date) = to_date('05/13/2019','mm/dd/yyyy')
AND trunc(horizon_end_date) = to_date('05/26/2019','mm/dd/yyyy');

--commit;
execute LOAD_DEMO_DATA_PKG.LOAD_FORECAST_DATA;

/*
To execute the update dates procedure manually
*/

--Make sure the variables are set correctly
 select * from corp_etl_control
 where name like 'REFR%';
 
 /*
 --Remember to set this correctly after running the procedure manually
 update corp_etl_control
 set value = --<<set to current date>>
 where name = 'REFRESH_DEMO_DATA_RUNDATE';
 commit;
 */
 
 /*
 Update statement if the number of days to add needs to be changed.  Remember to put it back to what it was before 
 update corp_etl_control
 SET value = '7'
 where name = 'REFRESH_DEMO_DATA_NUMDAYS';
 commit;
 */
 
 execute LOAD_DEMO_DATA_PKG.REFRESH_ALL_DEMO_DATA;
 
 /*
 Update statement if the number of days to add needs to be changed.  Remember to put it back to what it was before 
 Remember to add 28 more days for MW/Actuals data since it is 4 weeks behind the PP Forecast data provided (Original MW dates were in Mar/Apr.  Original Forecast data were in Apr/May)
 update corp_etl_control
 SET value = '28'
 where name = 'REFRESH_DEMO_DATA_NUMDAYS';
 commit;
 */
 
 --Run the refresh only for MW/Actuals to make it synchronized with Forecast data
 exec LOAD_MW_AND_ACTUALS_PKG.REFRESH_MW_DATA;
 
  /*
  Put back to the value to 7 afterwards
 update corp_etl_control
 SET value = '7'
 where name = 'REFRESH_DEMO_DATA_NUMDAYS';
 commit;
 */
 