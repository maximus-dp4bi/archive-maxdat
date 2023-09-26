CREATE MATERIALIZED VIEW d_weeks
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT d_week,d_week_num, CASE WHEN d_week_num = 1 THEN MAX(d_year) ELSE MIN(d_year) END d_year      
     ,MIN(d_date) d_week_start, MAX(d_date) d_week_end
from bpm_d_dates
group by d_week,d_week_num;

CREATE MATERIALIZED VIEW d_months
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT d_month, d_month_num, d_year,d_month_short_name, d_month_name, d_month_name||' '||d_year month_name_year,MIN(d_date) d_month_start, MAX(d_date) d_month_end
FROM bpm_d_dates
GROUP BY d_month, d_month_num, d_year,d_month_short_name, d_month_name;


CREATE MATERIALIZED VIEW d_years
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT d_year, MIN(d_date) d_year_start, MAX(d_date) d_year_end
FROM bpm_d_dates
GROUP BY d_year;


CREATE OR REPLACE PROCEDURE refresh_d_dates_views
AS
BEGIN
  dbms_mview.refresh('D_YEARS','?');
  dbms_mview.refresh('D_MONTHS','?');
  dbms_mview.refresh('D_WEEKS','?');
END;
/

declare
  v_jobnum number := null;
begin
  dbms_job.submit(
    job => v_jobnum,
    what => 'REFRESH_D_DATES_VIEWS;',
    next_date => sysdate,
    interval => 'trunc(sysdate + 1)');
  commit;
end;
/