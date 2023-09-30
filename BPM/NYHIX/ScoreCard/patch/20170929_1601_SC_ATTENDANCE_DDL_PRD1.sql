----------------------------------------------------

-- Alter table dp_scorecard.SC_ATTENDANCE_ABSENCE_LKUP 
-- add PERFECT_ATTENDANCE_FLAG  VARCHAR2(1 BYTE);
-- 
-- UPDATE dp_scorecard.SC_ATTENDANCE_ABSENCE_LKUP
-- SET PERFECT_ATTENDANCE_FLAG = 'Y'
-- WHERE SC_ALL_ID IN (
-- SELECT SC_ALL_ID FROM dp_scorecard.SC_ATTENDANCE_ABSENCE_LKUP
-- WHERE ABSENCE_TYPE LIKE 'Perfect Attendance%' 
-- );
-- 
-- Commit;
--  
-------------------------------------------------

-- ALTER TABLE DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE 
-- drop CONSTRAINT SYS_C002460955;

ALTER TABLE DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE ADD (
  PRIMARY KEY
  (STAFF_ID, START_DATE)
  USING INDEX
    TABLESPACE MAXDAT_INDX
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);

-------------------------------------------------
-- DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY
-------------------------------------------------

drop index SC_ATTEN_MTHLY_STAFF_MNTH_NDX;

CREATE UNIQUE INDEX DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY_PK ON DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY
(STAFF_STAFF_ID, DATES_MONTH_NUM)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

ALTER TABLE DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY ADD (
  CONSTRAINT SCORECARD_ATTENDANCE_MTHLY_PK
  PRIMARY KEY
  (STAFF_STAFF_ID, DATES_MONTH_NUM)
  USING INDEX DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY_PK
  ENABLE VALIDATE);

		   
-------------------------------------------------

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV
(MANAGER_STAFF_ID, MANAGER_NAME, SUPERVISOR_STAFF_ID, SUPERVISOR_NAME, STAFF_STAFF_ID, 
 STAFF_STAFF_NAME, STAFF_NATID, DATES, ABSENCE_TYPE, POINT_VALUE, 
 BALANCE, INCENTIVE_BALANCE, TOTAL_BALANCE, INCENTIVE_FLAG, SC_ATTENDANCE_ID, 
 CREATE_DATETIME, CREATE_BY, LAST_UPDATED_BY, LAST_UPDATED_DATETIME)
AS 
WITH STAFF AS
(
SELECT
       MANAGER_STAFF_ID,
       MANAGER_NAME,
       SUPERVISOR_STAFF_ID,
       SUPERVISOR_NAME,
       STAFF_STAFF_ID,
       STAFF_STAFF_NAME,
       STAFF_NATID,
       HIRE_DATE,
       0 AS SC_ATTENDANCE_ID,
       HIRE_DATE AS CREATE_DATETIME
  FROM DP_SCORECARD.SCORECARD_HIERARCHY
)
, 
STAFF_INITIAL_BALANCES AS
( 
SELECT S.MANAGER_STAFF_ID,
       S.MANAGER_NAME,
       S.SUPERVISOR_STAFF_ID,
       S.SUPERVISOR_NAME,
       S.STAFF_STAFF_ID,
       S.STAFF_STAFF_NAME,
       S.STAFF_NATID,
       AIS.START_DATE                              	AS DATES,
       '** Initial Balance - '
			||TO_CHAR(AIS.START_DATE,'MONTH')
			||' '||TO_CHAR(AIS.START_DATE,'YYYY')
			||' **' 								AS ABSENCE_TYPE,
       0			 		                        AS POINT_VALUE,
        NVL(AIS.ATTENDANCE_POINTS,0)                AS BALANCE,
       NVL(AIS.INCENTIVE_POINTS,0) 			        AS INCENTIVE_BALANCE,
       (NVL(AIS.ATTENDANCE_POINTS,0) + NVL(AIS.INCENTIVE_POINTS,0)) AS TOTAL_BALANCE,
       NULL                             AS INCENTIVE_FLAG,
       NULL                             AS COMMENTS,
       NULL								AS CREATE_DATETIME,
       NULL                             AS CREATE_BY,
       NULL                             AS LAST_UPDATED_BY,
       NULL                             AS LAST_UPDATED_DATETIME,
       0                                AS SC_ATTENDANCE_ID
  FROM STAFF S
  JOIN DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE AIS 
	ON S.STAFF_STAFF_ID = AIS.STAFF_ID
),
STAFF_STARTING_BALANCE AS
(
SELECT MANAGER_STAFF_ID,
       MANAGER_NAME,
       SUPERVISOR_STAFF_ID,
       SUPERVISOR_NAME,
       STAFF_STAFF_ID,
       STAFF_STAFF_NAME,
       STAFF_NATID,
       --HIRE_DATE AS DATES,
       GREATEST(HIRE_DATE,
                TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE,-12),'YYYYMM'),'YYYYMM')               
               )                                    AS DATES,
       '** Starting Balance - '||to_char(sysdate,'Month')||' '||to_char(sysdate,'YYYY')||' **' as absence_type,
       0 								AS POINT_VALUE,
       40 								AS BALANCE,
       0 								AS INCENTIVE_BALANCE,
       40 								AS TOTAL_BALANCE,
       NULL AS INCENTIVE_FLAG,
       NULL AS COMMENTS,
       TO_DATE('19010101','YYYYMMDD')								AS CREATE_DATETIME,
       NULL AS CREATE_BY,
       NULL AS LAST_UPDATED_BY,
       NULL AS LAST_UPDATED_DATETIME,
       SC_ATTENDANCE_ID
  FROM STAFF S
  LEFT OUTER JOIN ( SELECT * FROM DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE 
					WHERE TO_CHAR(START_DATE,'YYYYMM') >= TO_CHAR(ADD_MONTHS(SYSDATE,-12),'YYYYMM')
				)AIS 
				ON S.STAFF_STAFF_ID = AIS.STAFF_ID 
				AND AIS.START_DATE = TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE,-12),'YYYYMM'),'YYYYMM')
   WHERE AIS.STAFF_ID IS NULL				
),
SC_ATTEND_ENTRIES AS
(
SELECT S.MANAGER_STAFF_ID,
       S.MANAGER_NAME,
       S.SUPERVISOR_STAFF_ID,
       S.SUPERVISOR_NAME,
       S.STAFF_STAFF_ID,
       S.STAFF_STAFF_NAME,
       S.STAFF_NATID,
       SCA.ENTRY_DATE AS DATES,
       SCA.ABSENCE_TYPE,
       SCA.POINT_VALUE,
       SCA.BALANCE,
       SCA.INCENTIVE_BALANCE,
       SCA.TOTAL_BALANCE,
       SCA.INCENTIVE_FLAG,
       SCA.SC_ATTENDANCE_ID,
       SCA.CREATE_DATETIME,
       SCA.CREATE_BY,
       SCA.LAST_UPDATED_BY,
       SCA.LAST_UPDATED_DATETIME
  FROM STAFF S
INNER JOIN DP_SCORECARD.SC_ATTENDANCE SCA
    ON S.STAFF_STAFF_ID = SCA.STAFF_ID
),
COMBINED AS
( SELECT MANAGER_STAFF_ID,
       MANAGER_NAME,
       SUPERVISOR_STAFF_ID,
       SUPERVISOR_NAME,
       STAFF_STAFF_ID,
       STAFF_STAFF_NAME,
       STAFF_NATID,
       DATES,
       ABSENCE_TYPE,
       POINT_VALUE,
       BALANCE,
       INCENTIVE_BALANCE,
       TOTAL_BALANCE,
       INCENTIVE_FLAG,
       SC_ATTENDANCE_ID,
       CREATE_DATETIME,
       CREATE_BY,
       LAST_UPDATED_BY,
       LAST_UPDATED_DATETIME
  FROM STAFF_INITIAL_BALANCES
UNION ALL
SELECT MANAGER_STAFF_ID,
       MANAGER_NAME,
       SUPERVISOR_STAFF_ID,
       SUPERVISOR_NAME,
       STAFF_STAFF_ID,
       STAFF_STAFF_NAME,
       STAFF_NATID,
       DATES,
       ABSENCE_TYPE,
       POINT_VALUE,
       BALANCE,
       INCENTIVE_BALANCE,
       TOTAL_BALANCE,
       INCENTIVE_FLAG,
       SC_ATTENDANCE_ID,
       CREATE_DATETIME,
       CREATE_BY,
       LAST_UPDATED_BY,
       LAST_UPDATED_DATETIME
  FROM STAFF_STARTING_BALANCE
UNION ALL
SELECT MANAGER_STAFF_ID,
       MANAGER_NAME,
       SUPERVISOR_STAFF_ID,
       SUPERVISOR_NAME,
       STAFF_STAFF_ID,
       STAFF_STAFF_NAME,
       STAFF_NATID,
       DATES,
       ABSENCE_TYPE,
       POINT_VALUE,
       BALANCE,
       INCENTIVE_BALANCE,
       TOTAL_BALANCE,
       INCENTIVE_FLAG,
       SC_ATTENDANCE_ID,
       CREATE_DATETIME,
       CREATE_BY,
       LAST_UPDATED_BY,
       LAST_UPDATED_DATETIME
  FROM SC_ATTEND_ENTRIES
)
SELECT
	MANAGER_STAFF_ID, MANAGER_NAME, SUPERVISOR_STAFF_ID, SUPERVISOR_NAME, STAFF_STAFF_ID, 
	STAFF_STAFF_NAME, STAFF_NATID, DATES, ABSENCE_TYPE, POINT_VALUE, 
	BALANCE, INCENTIVE_BALANCE, TOTAL_BALANCE, INCENTIVE_FLAG, SC_ATTENDANCE_ID, 
	CREATE_DATETIME, CREATE_BY, LAST_UPDATED_BY, LAST_UPDATED_DATETIME
FROM COMBINED	
ORDER BY  STAFF_STAFF_ID, DATES, SC_ATTENDANCE_ID, CREATE_DATETIME;


GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV TO MAXDAT_REPORTS;

-------------------------------------------------

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY_SV
(MANAGER_STAFF_ID, MANAGER_NAME, SUPERVISOR_STAFF_ID, SUPERVISOR_NAME, STAFF_STAFF_ID, 
 STAFF_STAFF_NAME, STAFF_NATID, DATES_MONTH, DATES_MONTH_NUM, DATES_YEAR, 
 BALANCE, TOTAL_BALANCE, SC_ATTENDANCE_ID)
AS 
select a11.MANAGER_STAFF_ID
,a11.MANAGER_NAME
,a11.SUPERVISOR_STAFF_ID
,a11.SUPERVISOR_NAME
,a11.STAFF_STAFF_ID
,a11.STAFF_STAFF_NAME
,a10.STAFF_NATID
,a11.DATES_MONTH
,a11.DATES_MONTH_NUM
,a11.DATES_YEAR
,a11.BALANCE
,a11.TOTAL_BALANCE
,a11.SC_ATTENDANCE_ID
 from dp_scorecard.scorecard_attendance_mthly a11
 join DP_SCORECARD.SCORECARD_HIERARCHY_SV a10 on a10.staff_staff_id=a11.staff_staff_id
 WHERE DATES_MONTH_NUM >= TO_CHAR(ADD_MONTHS(SYSDATE,-12),'YYYYMM')
with read only;


GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK, MERGE VIEW ON DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY_SV TO MAXDAT_REPORTS;

-------------------------------------------------