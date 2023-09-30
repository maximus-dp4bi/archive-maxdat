--alter session set current_schema = MOTS;

/*
  create an actuals report in s_project_report
  for any distinct combinations of project, program, geo, and reporting period
  that exist in f_metric but do not currently exist in s_project_report where
  the report type is actuals
*/
insert into s_project_report (
  S_PROJECT_REPORT_ID
  , D_PROJECT_ID
  , D_PROGRAM_ID
  , D_GEOGRAPHY_MASTER_ID
  , D_REPORTING_PERIOD_ID
  , APPROVED_DATE
  , CREATE_DATE
  , CREATED_BY
  , LAST_MODIFIED_DATE
  , UPDATED_BY
  , APPROVED
  , REPORT_TYPE
  , STATUS
  , IS_ACTUALS_TREND_PROCESSED
  , IS_FUTURE_TRENDS_PROCESSED
  , IS_ERROR
  , FUNCTIONAL_AREA
)
with t as (
  select 
    D_PROJECT_ID
    , D_PROGRAM_ID
    , D_GEOGRAPHY_MASTER_ID
    , D_REPORTING_PERIOD_ID
  from f_metric f
  inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
  WHERE (ACTUAL_VALUE IS NOT NULL OR ACTUAL_VALUE_NOT_SUPPLIED IS NOT NULL)
  and actual_value_provided_by = 'Web'
  and mp.actual_eff_dt IS NOT NULL 
  GROUP BY 
    D_PROJECT_ID
    , D_PROGRAM_ID
    , D_GEOGRAPHY_MASTER_ID
    , D_REPORTING_PERIOD_ID
  MINUS
  select 
  	D_PROJECT_ID
  	, D_PROGRAM_ID
  	, D_GEOGRAPHY_MASTER_ID
  	, D_REPORTING_PERIOD_ID
  from s_project_report
  where report_type = 'actuals'
), t2 as (
  select     
    mp.D_PROJECT_ID
    , mp.D_PROGRAM_ID
    , mp.D_GEOGRAPHY_MASTER_ID
    , f.D_REPORTING_PERIOD_ID
    , MIN(TRUNC(f.CREATE_DATE)) AS CREATE_DATE -- set the create_date to the first metric create_date
    , MAX(TRUNC(f.LAST_MODIFIED_DATE)) AS LAST_MODIFIED_DATE -- set the last_modified_date to the last metric last_modified_date
  from t 
  inner join d_metric_project mp 
    on t.d_project_id = mp.d_project_id
    and t.d_program_id = mp.d_program_id
    and t.d_geography_master_id = mp.d_geography_master_id
  inner join d_reporting_period rp on t.d_reporting_period_id = rp.d_reporting_period_id
  inner join f_metric f on mp.d_metric_project_id = f.d_metric_project_id
    and rp.d_reporting_period_id = f.d_reporting_period_id
  group by 
    mp.D_PROJECT_ID
    , mp.D_PROGRAM_ID
    , mp.D_GEOGRAPHY_MASTER_ID
    , f.D_REPORTING_PERIOD_ID
)
select 
  SEQ_S_PROJECT_REPORT.NEXTVAL,
  D_PROJECT_ID
  , D_PROGRAM_ID
  , D_GEOGRAPHY_MASTER_ID
  , D_REPORTING_PERIOD_ID
  , CREATE_DATE AS APPROVED_DATE 
  , CREATE_DATE 
  , 'SYSTEM' AS CREATED_BY
  , LAST_MODIFIED_DATE 
  , 'SYSTEM' AS UPDATED_BY
  , 1 AS APPROVED
  , 'actuals' AS REPORT_TYPE
  , 'Approved' AS STATUS
  , 'Y' AS IS_ACTUALS_TREND_PROCESSED
  , 'Y' AS IS_FUTURE_TRENDS_PROCESSED
  , 'N' AS IS_ERROR
  , 'Contact Center' AS FUNCTIONAL_AREA  
from t2
;



/*
  create a forecasts report in s_project_report
  for any distinct combinations of project, program, geo, and reporting period
  that exist in f_metric but do not currently exist in s_project_report where
  the report type is forecasts
*/
insert into s_project_report (
  S_PROJECT_REPORT_ID
  , D_PROJECT_ID
  , D_PROGRAM_ID
  , D_GEOGRAPHY_MASTER_ID
  , D_REPORTING_PERIOD_ID
  , APPROVED_DATE
  , CREATE_DATE
  , CREATED_BY
  , LAST_MODIFIED_DATE
  , UPDATED_BY
  , APPROVED
  , REPORT_TYPE
  , STATUS
  , IS_ACTUALS_TREND_PROCESSED
  , IS_FUTURE_TRENDS_PROCESSED
  , IS_ERROR
  , FUNCTIONAL_AREA
)
with t as (
  select 
    D_PROJECT_ID
    , D_PROGRAM_ID
    , D_GEOGRAPHY_MASTER_ID
    , D_REPORTING_PERIOD_ID
  from f_metric f
  inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
  WHERE (FORECAST_VALUE IS NOT NULL OR FORECAST_VALUE_NOT_SUPPLIED IS NOT NULL)
  and forecast_value_provided_by = 'Web'
  and mp.forecast_eff_dt IS NOT NULL 
  GROUP BY 
    D_PROJECT_ID
    , D_PROGRAM_ID
    , D_GEOGRAPHY_MASTER_ID
    , D_REPORTING_PERIOD_ID
  MINUS
  select 
  	D_PROJECT_ID
  	, D_PROGRAM_ID
  	, D_GEOGRAPHY_MASTER_ID
  	, D_REPORTING_PERIOD_ID
  from s_project_report
  where report_type = 'forecasts'
), t2 as (
  select     
    mp.D_PROJECT_ID
    , mp.D_PROGRAM_ID
    , mp.D_GEOGRAPHY_MASTER_ID
    , f.D_REPORTING_PERIOD_ID
    , MIN(TRUNC(f.CREATE_DATE)) AS CREATE_DATE -- set the create_date to the first metric create_date
    , MAX(TRUNC(f.LAST_MODIFIED_DATE)) AS LAST_MODIFIED_DATE -- set the last_modified_date to the last metric last_modified_date
  from t 
  inner join d_metric_project mp 
    on t.d_project_id = mp.d_project_id
    and t.d_program_id = mp.d_program_id
    and t.d_geography_master_id = mp.d_geography_master_id
  inner join d_reporting_period rp on t.d_reporting_period_id = rp.d_reporting_period_id
  inner join f_metric f on mp.d_metric_project_id = f.d_metric_project_id
    and rp.d_reporting_period_id = f.d_reporting_period_id
  group by 
    mp.D_PROJECT_ID
    , mp.D_PROGRAM_ID
    , mp.D_GEOGRAPHY_MASTER_ID
    , f.D_REPORTING_PERIOD_ID
) 
select 
  SEQ_S_PROJECT_REPORT.NEXTVAL,
  D_PROJECT_ID
  , D_PROGRAM_ID
  , D_GEOGRAPHY_MASTER_ID
  , D_REPORTING_PERIOD_ID
  , CREATE_DATE AS APPROVED_DATE 
  , CREATE_DATE 
  , 'SYSTEM' AS CREATED_BY
  , LAST_MODIFIED_DATE
  , 'SYSTEM' AS UPDATED_BY
  , 1 AS APPROVED
  , 'forecasts' AS REPORT_TYPE
  , 'Approved' AS STATUS
  , 'Y' AS IS_ACTUALS_TREND_PROCESSED
  , 'Y' AS IS_FUTURE_TRENDS_PROCESSED
  , 'N' AS IS_ERROR
  , 'Contact Center' AS FUNCTIONAL_AREA  
from t2
;

/*
  create a metric record in s_metric and set its actual values
  for any distinct combinations of metric definition, project, program, geo, and reporting period
  that exist in f_metric with a non null actual value but do not currently exist in s_metric 
*/
INSERT INTO S_METRIC (
	S_METRIC_ID
	, D_METRIC_DEFINITION_ID
	, S_ACTUALS_PROJECT_REPORT_ID
	, APPROVED
	, APPROVED_DATE
	, ACTUAL_VALUE
	, ACTUAL_RECEIVED_DATE
	, ACTUAL_TREND_INDICATOR
	, ACTUAL_FORECAST_VARIANCE_FRMT
	, COMMENTS
	, CREATE_DATE
	, CREATED_BY
	, LAST_MODIFIED_DATE
	, UPDATED_BY
	, ACTUAL_VALUE_NOT_SUPPLIED
) 
with t as (
  select 
    D_PROJECT_ID
    , D_PROGRAM_ID
    , D_GEOGRAPHY_MASTER_ID
    , D_REPORTING_PERIOD_ID
    , D_METRIC_DEFINITION_ID
  from f_metric f
  inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
  WHERE 
    (ACTUAL_VALUE IS NOT NULL OR ACTUAL_VALUE_NOT_SUPPLIED IS NOT NULL)
    and actual_value_provided_by = 'Web' 
    and mp.actual_eff_dt IS NOT NULL 
  minus
  select 
    COALESCE(ar.D_PROJECT_ID, fr.D_PROJECT_ID)
    , COALESCE(ar.D_PROGRAM_ID, fr.D_PROGRAM_ID)
    , COALESCE(ar.D_GEOGRAPHY_MASTER_ID, FR.D_GEOGRAPHY_MASTER_ID)
    , COALESCE(ar.D_REPORTING_PERIOD_ID, fr.D_REPORTING_PERIOD_ID)
    , D_METRIC_DEFINITION_ID
  from s_metric s
  left outer join s_project_report ar on s.s_actuals_project_report_id = ar.s_project_report_id
  left outer join s_project_report fr on s.s_forecasts_project_report_id = fr.s_project_report_id
)
select 
  SEQ_S_METRIC.NEXTVAL, 
  mp.D_METRIC_DEFINITION_ID 
  , (
      SELECT S_PROJECT_REPORT_ID 
      FROM S_PROJECT_REPORT 
      WHERE D_PROJECT_ID = MP.D_PROJECT_ID 
      AND D_PROGRAM_ID = MP.D_PROGRAM_ID 
      AND D_GEOGRAPHY_MASTER_ID = MP.D_GEOGRAPHY_MASTER_ID 
      AND D_REPORTING_PERIOD_ID = F.D_REPORTING_PERIOD_ID 
      AND REPORT_TYPE = 'actuals'
  ) AS S_ACTUALS_PROJECT_REPORT_ID
  , 'true' as APPROVED
  , f.CREATE_DATE
  , f.ACTUAL_VALUE
  , f.ACTUAL_RECEIVED_DATE
  , f.ACTUAL_TREND_INDICATOR
  , f.ACTUAL_FORECAST_VARIANCE_FRMT
  , f.COMMENTS
  , f.CREATE_DATE
  , 'SYSTEM' AS CREATED_BY
  , f.LAST_MODIFIED_DATE
  , 'SYSTEM' AS UPDATED_BY
  , f.ACTUAL_VALUE_NOT_SUPPLIED
from f_metric f
inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
inner join t 
  on f.d_reporting_period_id = t.d_reporting_period_id
  and mp.d_metric_definition_id = t.d_metric_definition_id
  and mp.d_project_id = t.d_project_id
  and mp.d_program_id = t.d_program_id
  and mp.d_geography_master_id = t.d_geography_master_id
;

/*
  create a metric record in s_metric and set its forecast values
  for any distinct combinations of metric definition, project, program, geo, and reporting period
  that exist in f_metric with a non null forecast value but do not currently exist in s_metric 
*/
INSERT INTO S_METRIC (
	S_METRIC_ID
	, D_METRIC_DEFINITION_ID
	, S_FORECASTS_PROJECT_REPORT_ID
	, APPROVED
	, APPROVED_DATE
	, ACTUAL_FORECAST_VARIANCE_FRMT
	, FORECAST_VALUE
	, FORECAST_RECEIVED_DATE
	, FORECAST_COMMENTS
	, CREATE_DATE
	, CREATED_BY
	, LAST_MODIFIED_DATE
	, UPDATED_BY
	, FORECAST_VALUE_NOT_SUPPLIED
) 
with t as (
  select 
    D_PROJECT_ID
    , D_PROGRAM_ID
    , D_GEOGRAPHY_MASTER_ID
    , D_REPORTING_PERIOD_ID
    , D_METRIC_DEFINITION_ID
  from f_metric f
  inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
  WHERE 
    (FORECAST_VALUE IS NOT NULL OR FORECAST_VALUE_NOT_SUPPLIED IS NOT NULL)
    and forecast_value_provided_by = 'Web'
    and mp.forecast_eff_dt IS NOT NULL 
  minus
  select 
    COALESCE(ar.D_PROJECT_ID, fr.D_PROJECT_ID)
    , COALESCE(ar.D_PROGRAM_ID, fr.D_PROGRAM_ID)
    , COALESCE(ar.D_GEOGRAPHY_MASTER_ID, FR.D_GEOGRAPHY_MASTER_ID)
    , COALESCE(ar.D_REPORTING_PERIOD_ID, fr.D_REPORTING_PERIOD_ID) AS D_REPORTING_PERIOD_ID
    , D_METRIC_DEFINITION_ID
  from s_metric s
  left outer join s_project_report ar on s.s_actuals_project_report_id = ar.s_project_report_id
  left outer join s_project_report fr on s.s_forecasts_project_report_id = fr.s_project_report_id
)
select 
  SEQ_S_METRIC.NEXTVAL, 
  mp.D_METRIC_DEFINITION_ID 
  , (
      SELECT S_PROJECT_REPORT_ID 
      FROM S_PROJECT_REPORT 
      WHERE D_PROJECT_ID = MP.D_PROJECT_ID 
      AND D_PROGRAM_ID = MP.D_PROGRAM_ID 
      AND D_GEOGRAPHY_MASTER_ID = MP.D_GEOGRAPHY_MASTER_ID 
      AND D_REPORTING_PERIOD_ID = F.D_REPORTING_PERIOD_ID 
      AND REPORT_TYPE = 'forecasts'
  ) AS S_FORECASTS_PROJECT_REPORT_ID
  , 'true' as APPROVED
  , f.CREATE_DATE
  , f.ACTUAL_FORECAST_VARIANCE_FRMT
  , f.FORECAST_VALUE
  , f.FORECAST_RECEIVED_DATE
  , f.FORECAST_COMMENTS
  , f.CREATE_DATE
  , 'SYSTEM' AS CREATED_BY
  , f.LAST_MODIFIED_DATE
  , 'SYSTEM' AS UPDATED_BY
  , f.FORECAST_VALUE_NOT_SUPPLIED
from f_metric f
inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
inner join t 
  on f.d_reporting_period_id = t.d_reporting_period_id
  and mp.d_metric_definition_id = t.d_metric_definition_id
  and mp.d_project_id = t.d_project_id
  and mp.d_program_id = t.d_program_id
  and mp.d_geography_master_id = t.d_geography_master_id
;

/*
  update s_metric actual values 
  where the f_metric actual value is not null 
  and the actual report id is null
*/
MERGE INTO S_METRIC sm
USING (
  select 
    s.s_metric_id
   , (
        SELECT S_PROJECT_REPORT_ID 
        FROM S_PROJECT_REPORT 
        WHERE D_PROJECT_ID = MP.D_PROJECT_ID 
        AND D_PROGRAM_ID = MP.D_PROGRAM_ID 
        AND D_GEOGRAPHY_MASTER_ID = MP.D_GEOGRAPHY_MASTER_ID 
        AND D_REPORTING_PERIOD_ID = F.D_REPORTING_PERIOD_ID 
        AND REPORT_TYPE = 'actuals'
    ) AS S_ACTUALS_PROJECT_REPORT_ID
    , f.ACTUAL_VALUE
    , f.ACTUAL_RECEIVED_DATE
    , f.ACTUAL_TREND_INDICATOR
    , f.ACTUAL_FORECAST_VARIANCE_FRMT
    , f.COMMENTS
    , f.LAST_MODIFIED_DATE
    , 'SYSTEM' AS UPDATED_BY
    , f.ACTUAL_VALUE_NOT_SUPPLIED
  from f_metric f
    inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
    inner join s_project_report pr 
      on f.d_reporting_period_id = pr.d_reporting_period_id
      and mp.d_project_id = pr.d_project_id
      and mp.d_program_id = pr.d_program_id
      and mp.d_geography_master_id = pr.d_geography_master_id
    inner join s_metric s on pr.s_project_report_id = s.s_forecasts_project_report_id
      and mp.d_metric_definition_id = s.d_metric_definition_id
  WHERE (f.ACTUAL_VALUE IS NOT NULL OR f.ACTUAL_VALUE_NOT_SUPPLIED IS NOT NULL)
    and mp.actual_value_provided_by = 'Web'
    and mp.actual_eff_dt IS NOT NULL 
    and s.s_actuals_project_report_id is null
) t
ON (sm.s_metric_id = t.s_metric_id)
WHEN MATCHED THEN UPDATE SET
  sm.S_ACTUALS_PROJECT_REPORT_ID = t.S_ACTUALS_PROJECT_REPORT_ID
  , sm.ACTUAL_VALUE = t.ACTUAL_VALUE
  , sm.ACTUAL_RECEIVED_DATE = t.ACTUAL_RECEIVED_DATE
  , sm.ACTUAL_TREND_INDICATOR = t.ACTUAL_TREND_INDICATOR
  , sm.ACTUAL_FORECAST_VARIANCE_FRMT = t.ACTUAL_FORECAST_VARIANCE_FRMT
  , sm.COMMENTS = t.COMMENTS
  , sm.LAST_MODIFIED_DATE = t.LAST_MODIFIED_DATE
  , sm.UPDATED_BY = 'SYSTEM'
  , sm.ACTUAL_VALUE_NOT_SUPPLIED = t.ACTUAL_VALUE_NOT_SUPPLIED
;

/*
  update s_metric forecast values 
  where the f_metric forecast value is not null 
  and the forecast report id is null
*/
MERGE INTO S_METRIC sm
USING (
  select 
    s.s_metric_id
   , (
        SELECT S_PROJECT_REPORT_ID 
        FROM S_PROJECT_REPORT 
        WHERE D_PROJECT_ID = MP.D_PROJECT_ID 
        AND D_PROGRAM_ID = MP.D_PROGRAM_ID 
        AND D_GEOGRAPHY_MASTER_ID = MP.D_GEOGRAPHY_MASTER_ID 
        AND D_REPORTING_PERIOD_ID = F.D_REPORTING_PERIOD_ID 
        AND REPORT_TYPE = 'forecasts'
    ) AS S_FORECASTS_PROJECT_REPORT_ID
    , f.FORECAST_VALUE
    , f.FORECAST_RECEIVED_DATE
    , f.ACTUAL_FORECAST_VARIANCE_FRMT
    , f.FORECAST_COMMENTS
    , f.LAST_MODIFIED_DATE
    , 'SYSTEM' AS UPDATED_BY
    , f.FORECAST_VALUE_NOT_SUPPLIED
  from f_metric f
    inner join d_metric_project mp on f.d_metric_project_id = mp.d_metric_project_id
    inner join s_project_report pr 
      on f.d_reporting_period_id = pr.d_reporting_period_id
      and mp.d_project_id = pr.d_project_id
      and mp.d_program_id = pr.d_program_id
      and mp.d_geography_master_id = pr.d_geography_master_id
    inner join s_metric s on pr.s_project_report_id = s.s_actuals_project_report_id
      and mp.d_metric_definition_id = s.d_metric_definition_id
  WHERE (f.FORECAST_VALUE IS NOT NULL OR f.FORECAST_VALUE_NOT_SUPPLIED IS NOT NULL)
    and forecast_value_provided_by = 'Web'
    and mp.forecast_eff_dt IS NOT NULL 
    and s.s_forecasts_project_report_id is null
) t
ON (sm.s_metric_id = t.s_metric_id)
WHEN MATCHED THEN UPDATE SET
  sm.S_FORECASTS_PROJECT_REPORT_ID = t.S_FORECASTS_PROJECT_REPORT_ID
  , sm.FORECAST_VALUE = t.FORECAST_VALUE
  , sm.FORECAST_RECEIVED_DATE = t.FORECAST_RECEIVED_DATE
  , sm.ACTUAL_FORECAST_VARIANCE_FRMT = t.ACTUAL_FORECAST_VARIANCE_FRMT
  , sm.FORECAST_COMMENTS = t.FORECAST_COMMENTS
  , sm.LAST_MODIFIED_DATE = t.LAST_MODIFIED_DATE
  , sm.UPDATED_BY = 'SYSTEM'
  , sm.FORECAST_VALUE_NOT_SUPPLIED = t.FORECAST_VALUE_NOT_SUPPLIED
;


COMMIT;


