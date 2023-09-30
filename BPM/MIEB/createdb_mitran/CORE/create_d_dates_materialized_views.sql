CREATE MATERIALIZED VIEW d_weeks
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT d_week,d_week_num, CASE WHEN d_week_num = 1 THEN MAX(d_year) ELSE MIN(d_year) END d_year      
     ,MIN(d_date) d_week_start, MAX(d_date) d_week_end
from bpm_d_dates
group by d_week,d_week_num;

GRANT SELECT ON d_weeks TO &role_name;

CREATE MATERIALIZED VIEW d_months
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT d_month, d_month_num, d_year,d_month_short_name, d_month_name, d_month_name||' '||d_year month_name_year,MIN(d_date) d_month_start, MAX(d_date) d_month_end
FROM bpm_d_dates
GROUP BY d_month, d_month_num, d_year,d_month_short_name, d_month_name;

GRANT SELECT ON d_months TO &role_name;

CREATE MATERIALIZED VIEW d_years
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT d_year, MIN(d_date) d_year_start, MAX(d_date) d_year_end
FROM bpm_d_dates
GROUP BY d_year;

GRANT SELECT ON d_years TO &role_name;

CREATE OR REPLACE PROCEDURE refresh_d_dates_views
AS
BEGIN
  dbms_mview.refresh('D_YEARS','?');
  dbms_mview.refresh('D_MONTHS','?');
  dbms_mview.refresh('D_WEEKS','?');
END;
/

BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'REFRESH_DATES_VIEWS',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'REFRESH_D_DATES_VIEWS',
   start_date         =>  '01-AUG-19 12.00.00 AM',
   repeat_interval    =>  'FREQ=DAILY;BYHOUR=0;BYMINUTE=5;BYSECOND=0',
   end_date           =>  '01-AUG-35 12.00.00 AM',
   auto_drop          =>   FALSE,
 --  job_class          =>  'batch_update_jobs',
   comments           =>  'To refresh the d_dates materialized views');
END;
/

begin
dbms_scheduler.enable('REFRESH_DATES_VIEWS');
end;
/