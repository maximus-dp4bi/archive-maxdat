CREATE MATERIALIZED VIEW d_weeks
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT d_week,d_week_num, CASE WHEN d_week_num = 1 THEN MAX(d_year) ELSE MIN(d_year) END d_year      
     ,MIN(d_date) d_week_start, MAX(d_date) d_week_end
from bpm_d_dates
group by d_week,d_week_num;

grant select on d_weeks to MAXDAT_REPORTS;

CREATE MATERIALIZED VIEW d_months
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT d_month, d_month_num, d_year,d_month_short_name, d_month_name, d_month_name||' '||d_year month_name_year,MIN(d_date) d_month_start, MAX(d_date) d_month_end
FROM bpm_d_dates
GROUP BY d_month, d_month_num, d_year,d_month_short_name, d_month_name;

grant select on d_months to MAXDAT_REPORTS;

CREATE MATERIALIZED VIEW d_years
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT d_year, MIN(d_date) d_year_start, MAX(d_date) d_year_end
FROM bpm_d_dates
GROUP BY d_year;

grant select on d_years to MAXDAT_REPORTS;