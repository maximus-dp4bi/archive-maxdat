DROP materialized view d_weeks;

CREATE MATERIALIZED VIEW d_weeks
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT d_week,d_week_num, CASE WHEN d_week_num = 1 THEN MAX(d_year) ELSE MIN(d_year) END d_year      
     ,MIN(d_date) d_week_start, MAX(d_date) d_week_end
from bpm_d_dates
group by d_week,d_week_num;

GRANT SELECT ON D_WEEKS TO MAXDAT_READ_ONLY;
GRANT SELECT ON D_MONTHS TO MAXDAT_READ_ONLY;
GRANT SELECT ON D_YEARS TO MAXDAT_READ_ONLY;