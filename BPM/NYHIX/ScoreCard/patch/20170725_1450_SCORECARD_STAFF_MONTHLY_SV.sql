CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_STAFF_MONTHLY_SV
(SUPERVISOR_STAFF_ID, SUPERVISOR_NATID, STAFF_STAFF_ID, STAFF_NATID, DATES_MONTH_NUM, 
 DATES_MONTH, DATES_YEAR, STAFF_STAFF_NAME)
AS 
SELECT SUPERVISOR_STAFF_ID, SUPERVISOR_NATID, STAFF_STAFF_ID, STAFF_NATID, DATES_MONTH_NUM, DATES_MONTH, DATES_YEAR, STAFF_STAFF_NAME
FROM (
WITH JUST_MONTHS AS
(
      SELECT
      TO_CHAR(ADD_MONTHS (TRUNC (ADD_MONTHS (SYSDATE, -12), 'MM'), 1*LEVEL -1), 'MM/DD/YYYY') AS DATES,
      TO_CHAR(ADD_MONTHS (TRUNC (ADD_MONTHS (SYSDATE, -12), 'MM'), 1*LEVEL -1), 'Month') AS DATES_MONTH,
      TO_CHAR(ADD_MONTHS (TRUNC (ADD_MONTHS (SYSDATE, -12), 'MM'), 1*LEVEL -1), 'YYYYMM') AS DATES_MONTH_NUM,
      TO_CHAR(ADD_MONTHS (TRUNC (ADD_MONTHS (SYSDATE, -12), 'MM'), 1*LEVEL -1), 'Month YYYY') AS DATES_YEAR
    FROM DUAL
    CONNECT BY LEVEL <= MONTHS_BETWEEN(TRUNC(SYSDATE), TRUNC (ADD_MONTHS (SYSDATE, -12), 'MM')) + 1
)
SELECT --min(dates_month_num), max(dates_month_num) 
        SUPERVISOR_STAFF_ID, SUPERVISOR_NATID, STAFF_STAFF_ID, STAFF_NATID, DATES_MONTH_NUM, 1  AS STAFF_COUNT,
         DATES_MONTH, DATES_YEAR, STAFF_STAFF_NAME
FROM DP_SCORECARD.SCORECARD_HIERARCHY
JOIN JUST_MONTHS ON JUST_MONTHS.DATES_MONTH_NUM 
    BETWEEN TO_CHAR(TRUNC(HIRE_DATE,'MM'),'YYYYMM') 
    AND TO_CHAR(TRUNC(NVL(TERMINATION_DATE,SYSDATE),'MM'),'YYYYMM)')
ORDER BY 2 DESC, 1
);


GRANT SELECT ON DP_SCORECARD.SCORECARD_STAFF_MONTHLY_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_STAFF_MONTHLY_SV TO DP_SCORECARD_READ_ONLY;
