
create table maxdat_support.wr_c_time_period_config
(D_INTERVAL_ID integer
 ,INTERVAL_START_DATE timestamp
 ,INTERVAL_END_DATE timestamp
 ,AM_PM varchar
 ,INTERVAL_START_HOUR integer
 ,INTERVAL_START_MINUTE integer
 ,INTERVAL_END_HOUR integer
 ,INTERVAL_END_MINUTE integer
 ,INTERVAL_SECONDS integer
 ,INTERVAL_START_TIME_OF_DAY12 varchar
 ,INTERVAL_START_TIME_OF_DAY24 varchar
 ,INTERVAL_END_TIME_OF_DAY12 varchar
 ,INTERVAL_END_TIME_OF_DAY24 varchar
 ,RECORD_EFF_DT date
 ,RECORD_END_DT date
 ,"version" integer
 ,CREATE_DATE timestamp
 ,UPDATE_DATE timestamp
 ,CREATED_BY varchar
 ,UPDATED_BY varchar
);

ALTER TABLE maxdat_support.wr_c_time_period_config OWNER TO maxdat_support;
GRANT ALL ON TABLE maxdat_support.wr_c_time_period_config TO maxdat_support;
GRANT SELECT ON TABLE maxdat_support.wr_c_time_period_config TO maxdat_reports;

CREATE INDEX wrc_timeperiod_idx1 ON wr_c_time_period_config(interval_start_date,interval_end_date);

drop view maxdat_support.wr_c_time_period_config_sv;

create or replace view maxdat_support.wr_c_time_period_config_sv
as
select D_INTERVAL_ID 
 ,INTERVAL_START_DATE
 ,INTERVAL_END_DATE
 ,AM_PM
 ,INTERVAL_START_HOUR 
 ,INTERVAL_START_MINUTE
 ,INTERVAL_END_HOUR 
 ,INTERVAL_END_MINUTE
 ,INTERVAL_SECONDS
 ,INTERVAL_START_TIME_OF_DAY12
 ,INTERVAL_START_TIME_OF_DAY24
 ,INTERVAL_END_TIME_OF_DAY12
 ,INTERVAL_END_TIME_OF_DAY24
 ,CONCAT(TRIM(LEADING '0' FROM INTERVAL_START_TIME_OF_DAY12),AM_PM,'-',TRIM(LEADING '0' FROM INTERVAL_END_TIME_OF_DAY12),AM_PM) time_period
 ,RECORD_EFF_DT 
 ,RECORD_END_DT 
 ,"version" 
 ,CREATE_DATE
 ,UPDATE_DATE
 ,CREATED_BY 
 ,UPDATED_BY 
from maxdat_support.wr_c_time_period_config;

ALTER TABLE maxdat_support.wr_c_time_period_config_sv OWNER TO maxdat_support;
GRANT ALL ON TABLE maxdat_support.wr_c_time_period_config_sv TO maxdat_support;
GRANT SELECT ON TABLE maxdat_support.wr_c_time_period_config_sv TO maxdat_reports;
