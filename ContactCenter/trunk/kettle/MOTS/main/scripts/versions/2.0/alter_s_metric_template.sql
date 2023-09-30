-- add PROGRAM_NAME and GEOGRAPHY_NAME columns
alter table S_METRIC_TEMPLATE
add (
  PROGRAM_NAME varchar(50),
  GEOGRAPHY_NAME varchar(100),
  ACTUAL_TREND_INDICATOR number(1,0),
  ACTUAL_FORECAST_VARIANCE_FRMT number(1,0)  
);
  
-- recreate UK to include PROGRAM_NAME and GEOGRAPHY_NAME
alter table S_METRIC_TEMPLATE
  drop constraint S_METRIC_TEMPLATE_UN;
ALTER TABLE S_METRIC_TEMPLATE 
  ADD CONSTRAINT S_METRIC_TEMPLATE_UN UNIQUE ( FILE_NAME , METRIC , REPORTING_PERIOD , PROGRAM_NAME , PROJECT_NAME , GEOGRAPHY_NAME , CREATE_DATE );
  