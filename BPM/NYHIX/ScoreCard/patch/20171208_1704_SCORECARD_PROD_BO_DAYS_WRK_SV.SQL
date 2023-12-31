DROP VIEW DP_SCORECARD.SCORECARD_PROD_BO_DAYS_WRK_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_PROD_BO_DAYS_WRK_SV
(SUPERVISOR_STAFF_ID, DEPARTMENT, BUILDING, DATES_MONTH_NUM, DATES_YEAR, 
 EVENT_NAME, UNIQUE_DAYS_WORKED)
AS 
SELECT
SUPERVISOR_STAFF_ID, DEPARTMENT, BUILDING,
   DATES_MONTH_NUM, DATES_YEAR,
   EVENT_NAME,
   METRIC AS UNIQUE_DAYS_WORKED
FROM DP_SCORECARD.SC_SUMMARY_BO_ROLLUP
WHERE EVENT_NAME = 'Unique Days Worked'
ORDER BY SUPERVISOR_STAFF_ID, DEPARTMENT, BUILDING,
   DATES_MONTH_NUM;


GRANT SELECT ON DP_SCORECARD.SCORECARD_PROD_BO_DAYS_WRK_SV TO MAXDAT_READ_ONLY;

