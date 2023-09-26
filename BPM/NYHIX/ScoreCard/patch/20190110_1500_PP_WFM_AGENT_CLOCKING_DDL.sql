-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

DROP TABLE DP_SCORECARD.PP_WFM_AGENT_CLOCKING_STAGE CASCADE CONSTRAINTS;

CREATE TABLE DP_SCORECARD.PP_WFM_AGENT_CLOCKING_STAGE
(
  EXTRACT_TIMESTAMP  TIMESTAMP(6),
  SRC                CHAR(2 BYTE),
  SRC_TIMESTAMP_GMT  TIMESTAMP(6),
  STAFF_ID           NUMBER(10),
  SRC_TYPE           NUMBER(3),
  EVENT_ID           NUMBER(10),
  TASK_START         DATE,
  TASK_END           DATE,
  DURATION_SEC       NUMBER(20,5)
)
TABLESPACE MAXDAT_DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;


GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_STAGE TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_STAGE TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_STAGE TO DP_SCORECARD_READ_ONLY;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

DROP TABLE DP_SCORECARD.PP_WFM_AGENT_CLOCKING CASCADE CONSTRAINTS;

CREATE TABLE DP_SCORECARD.PP_WFM_AGENT_CLOCKING
(
  EXTRACT_TIMESTAMP     TIMESTAMP(6),
  SRC                   CHAR(2 BYTE),
  SRC_TIMESTAMP_GMT     TIMESTAMP(6),
  STAFF_ID              NUMBER(10),
  SRC_TYPE              NUMBER(3),
  EVENT_ID              NUMBER(10),
  TASK_START            DATE,
  TASK_END              DATE,
  DURATION_SEC          NUMBER(20,5),
  DELETE_DETECTED_DATE  DATE
)
TABLESPACE MAXDAT_DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING TO DP_SCORECARD_READ_ONLY;


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

DROP TABLE DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY CASCADE CONSTRAINTS;

CREATE TABLE DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY
(
  STAFF_ID                    NUMBER(10),
  WORK_DAY                    DATE,
  SCHEDULED_START             DATE,
  SCHEDULED_END               DATE,
  TOTAL_SCHEDULED_MINUTES     NUMBER(20,5),
  LOG_START                   DATE,
  LOG_END                     DATE,
  LOG_DURATION_SEC            NUMBER(20,5),
  ACTUALS_START               DATE,
  ACTUALS_END                 DATE,
  ACTUALS_TOTAL_SEC           NUMBER(20,5),
  ACTUALS_BREAK_DURATION_SEC  NUMBER(20,5),
  ACTUALS_LUNCH_DURATION_SEC  NUMBER(20,5),
  DELETE_DETECTED_DATE        DATE,
  CREATED_DATE                DATE,
  LAST_UPDATED_DATE           DATE
)
TABLESPACE MAXDAT_DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING;

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY TO DP_SCORECARD_READ_ONLY;


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

DROP VIEW DP_SCORECARD.PP_WFM_AGENT_CLOCKING_STAGE_2_HIST_V;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.PP_WFM_AGENT_CLOCKING_STAGE_2_HIST_V
(STAFF_ID, WORK_DAY, SCHEDULED_START, SCHEDULED_END, TOTAL_SCHEDULED_MINUTES, 
 LOG_START, LOG_END, LOG_DURATION_SEC)
BEQUEATH DEFINER
AS 
WITH SCHEDULE_START AS
( -- THE 'RT_TASK_DATA' TAKES PRECIDENCE OVER THE 'TASK' DATA
	SELECT 	STAFF_ID                                             	AS STAFF_ID, 
            TRUNC(TASK_START)                                   AS WORK_DAY,
			TASK_START 	                                          	AS SCHEDULED_START 
    FROM PP_WFM_AGENT_CLOCKING  
    WHERE SRC = 'RT'
    AND SRC_TYPE = '0'  -- SCHEDULED
    AND EVENT_ID = '1' --<< '1' is 'Beginning of Attendance'
    AND DELETE_DETECTED_DATE IS NULL
    UNION
	SELECT 	STAFF_ID                                             	AS STAFF_ID, 
            TRUNC(TASK_START)                                   AS WORK_DAY,
			TASK_START 	                                          	AS SCHEDULED_START 
    FROM PP_WFM_AGENT_CLOCKING  
    WHERE SRC = 'T'
    AND SRC_TYPE = '1'
    AND EVENT_ID = '1' --<< '1' is 'Beginning of Attendance'
    AND DELETE_DETECTED_DATE IS NULL
    AND (STAFF_ID,TRUNC(TASK_START))
    IN ( SELECT STAFF_ID,TRUNC(TASK_START)
        FROM PP_WFM_AGENT_CLOCKING
        WHERE SRC = 'T' AND SRC_TYPE = 1 
        AND DELETE_DETECTED_DATE IS NULL
        MINUS
        SELECT STAFF_ID,TRUNC(TASK_START)
        FROM PP_WFM_AGENT_CLOCKING
        WHERE SRC = 'RT' AND SRC_TYPE = 0
        AND DELETE_DETECTED_DATE IS NULL
    )    
),
SCHEDULE_END AS
(	SELECT STAFF_ID                                 AS STAFF_ID, 
        TRUNC(TASK_START)                           AS WORK_DAY,
		TASK_START                                  AS SCHEDULED_END
    FROM PP_WFM_AGENT_CLOCKING
    WHERE SRC = 'RT' 
    AND SRC_TYPE = '0' --<< SRC_TYPE 0 is scheduledfor SRC = 'RT'
    AND EVENT_ID = '2' --<< '2' is 'End of Attendance'
    AND DELETE_DETECTED_DATE IS NULL
    UNION
	SELECT 	STAFF_ID                                             	AS STAFF_ID, 
            TRUNC(TASK_END)                                   AS WORK_DAY,
			TASK_END 	                                          	AS SCHEDULED_END 
    FROM PP_WFM_AGENT_CLOCKING  
    WHERE SRC = 'T'
    AND SRC_TYPE = '1'
    AND EVENT_ID = '2' --<< '1' is 'Beginning of Attendance'
    AND DELETE_DETECTED_DATE IS NULL
    AND (STAFF_ID,TRUNC(TASK_START))
    IN ( SELECT STAFF_ID,TRUNC(TASK_START)
        FROM PP_WFM_AGENT_CLOCKING
        WHERE SRC = 'T' AND SRC_TYPE = 1 
        AND DELETE_DETECTED_DATE IS NULL
        MINUS
        SELECT STAFF_ID,TRUNC(TASK_START)
        FROM PP_WFM_AGENT_CLOCKING
        WHERE SRC = 'RT' AND SRC_TYPE = 0
        AND DELETE_DETECTED_DATE IS NULL
    )    
),
SCHEDULED AS
(   SELECT 
        T.STAFF_ID, 
        TRUNC(MIN(SCHEDULED_START))             AS WORK_DAY,
		MIN(SCHEDULED_START)                    AS SCHEDULED_START,
		MAX(SCHEDULED_END) 	                    AS SCHEDULED_END,
		round(SUM(SCHEDULED_END - SCHEDULED_START)*(24*60),0)    AS TOTAL_SCHEDULED_MINUTES
	FROM SCHEDULE_START T
	JOIN SCHEDULE_END X	
        ON T.STAFF_ID = X.STAFF_ID
        AND T.WORK_DAY = X.WORK_DAY
		AND TRUNC(T.SCHEDULED_START) = TRUNC(X.SCHEDULED_END)
	GROUP BY T.STAFF_ID, T.SCHEDULED_START
 ),
AGENT_LOG_TIME
AS (
	------------------------------------------------------------------ 
	--AGENT_CLOCK_IN_OUT_TIME -- ( UNION OF MRTA FROM TASK AND MRTA FROM RT_TASK_DATA )
	------------------------------------------------------------------
    SELECT STAFF_ID, WORK_DAY,
        MIN(LOG_START)                      AS LOG_START,
        MAX(LOG_END)                        AS LOG_END,
        SUM(LOG_DUARATION)                  AS LOG_DURATION
    FROM ( 
        SELECT STAFF_ID, 
		TRUNC(LOG_START)                AS WORK_DAY,
		LOG_START                       AS LOG_START,
		LOG_END                         AS LOG_END,
		(LOG_END - LOG_START )          AS LOG_DUARATION
        FROM 
        ( 	
            (SELECT STAFF_ID, 
                        TRUNC(LOG_START)    AS WORK_DAY,
				--	EVENT_ID, 
                    LOG_START     		    AS LOG_START, 
					LOG_END              	AS LOG_END 
                FROM (  SELECT STAFF_ID,  
								EVENT_ID, 
								TASK_START                          AS  LOG_START, 
								LEAD ( TASK_END )  
--								LAG ( TASK_END )  
                                OVER ( PARTITION BY STAFF_ID 
									 ORDER BY TASK_START 
									)  								AS LOG_END
                        FROM PP_WFM_AGENT_CLOCKING 
						WHERE SRC = 'T'
                        AND SRC_TYPE in ('5', '6' ) --<< MRTA = 6 PHONE = 5 
                        AND EVENT_ID IN ('1','2')
                        AND DELETE_DETECTED_DATE IS NULL
                        )
                    WHERE EVENT_ID = 1    
            )
            UNION
            (
            SELECT STAFF_ID, 
            TRUNC(LOG_START)             AS WORK_DAY,
                    LOG_START     		AS LOG_START, 
					LOG_END              	AS LOG_END 
                FROM (  SELECT STAFF_ID,  
								EVENT_ID, 
								TASK_START                          AS  LOG_START, 
								LEAD ( TASK_END )  
--								Lag ( TASK_END )  
                                OVER ( PARTITION BY STAFF_ID 
									 ORDER BY STAFF_ID, TASK_START 
									)  								AS LOG_END
                        FROM (
                            SELECT STAFF_ID, EVENT_ID, TASK_START, TASK_END 
                            FROM PP_WFM_AGENT_CLOCKING 
                            WHERE SRC = 'RT'
                            AND SRC_TYPE = 4 -- SCHEDULED
                            AND EVENT_ID IN ('1','2')
                            AND DELETE_DETECTED_DATE IS NULL
                            MINUS 
                            SELECT STAFF_ID, EVENT_ID, TASK_START, TASK_END 
                            FROM PP_WFM_AGENT_CLOCKING 
                            WHERE SRC = 'T'
                            AND SRC_TYPE = '1'
                            AND EVENT_ID IN ('1','2')
                            AND DELETE_DETECTED_DATE IS NULL
                             ) 
						WHERE 1=1 --SRC = 'RT'
--                        AND SRC_TYPE = '6' --<< MRTA 
                        AND EVENT_ID IN ('1','2')
                        )
                    WHERE EVENT_ID = 1    
            )
        )
    )        
 GROUP BY STAFF_ID, WORK_DAY
    ),
result as (    
SELECT SCHEDULED.STAFF_ID, SCHEDULED.WORK_DAY, SCHEDULED_START, SCHEDULED_END, TOTAL_SCHEDULED_MINUTES, LOG_START, 
    CASE WHEN LOG_END IS NULL 
        OR LOG_END < LOG_START 
    THEN NULL 
    ELSE LOG_END END                        AS LOG_END, 
    CASE WHEN LOG_DURATION IS NULL
        OR LOG_DURATION < 0 
    THEN NULL
    ELSE ROUND(LOG_DURATION*(60*24*60),0) END           AS LOG_DURATION_SEC
    --, 
----ACTUALS_START, ACTUALS_END, 
--ACTUALS_TOTAL_sec, 
--round(ACTUALS_BREAK_DURATION*(60*60*24),0) as  ACTUALS_BREAK_DURATION_sec,
--round(ACTUALS_LUNCH_DURATION*(60*60*24),0) as  ACTUALS_LUNCH_DURATION_sec
FROM SCHEDULED
LEFT OUTER JOIN AGENT_LOG_TIME
ON SCHEDULED.STAFF_ID = AGENT_LOG_TIME.STAFF_ID
AND SCHEDULED.WORK_DAY =   AGENT_LOG_TIME.WORK_DAY
--LEFT OUTER JOIN AGENT_ACTUALS
--ON SCHEDULED.STAFF_ID = AGENT_ACTUALS.STAFF_ID
--AND SCHEDULED.WORK_DAY =   AGENT_ACTUALS.WORK_DAY
)
select STAFF_ID,    WORK_DAY,   SCHEDULED_START,    SCHEDULED_END,  TOTAL_SCHEDULED_MINUTES,
    LOG_START,  LOG_END,    LOG_DURATION_SEC--,
   -- ACTUALS_TOTAL_SEC,  ACTUALS_BREAK_DURATION_SEC, ACTUALS_LUNCH_DURATION_SEC 
    from result --agent_log_time --result
--where staff_id = 10183 
--and work_day = to_date('20181229','yyyymmdd')
;
/

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_STAGE_2_HIST_V TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_STAGE_2_HIST_V TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_STAGE_2_HIST_V TO DP_SCORECARD_READ_ONLY;


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

DROP VIEW DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY_SV
(MANAGER_NATIONAL_ID, MANAGER, SUPERVISOR_NATIONAL_ID, SUPERVISOR, STAFF_NATIONAL_ID, 
 STAFF, TERMINATION_DATE, STAFF_ID, WORK_DATE, SCHEDULE_START, 
 ACTUAL_START_TIME, START_TIME_VARIANCE, START_TIME_VARIANCE_FLAG, SCHEDULE_END_TIME, ACTUAL_END_TIME, 
 END_TIME_VARIANCE, END_TIME_VARIANCE_FLAG)
BEQUEATH DEFINER
AS 
SELECT 
    HIER.MANAGER_NATID                                            AS MANAGER_NATIONAL_ID,    
    HIER.MANAGER_NAME                                               AS MANAGER,
    HIER.SUPERVISOR_NATID                                          AS SUPERVISOR_NATIONAL_ID,
    HIER.SUPERVISOR_NAME                                            AS SUPERVISOR,
    HIER.STAFF_NATID                                               AS STAFF_NATIONAL_ID,
    HIER.STAFF_STAFF_NAME                                                 AS STAFF,
    staff.termination_date                                          as termination_date,
    HIST.STAFF_ID                                                 	AS 	STAFF_ID,
	HIST.WORK_DAY								          		  	AS 	WORK_DATE,
    HIST.SCHEDULED_START											AS	SCHEDULE_START,
    -----------------------------------------------      
    HIST.LOG_START													AS	ACTUAL_START_TIME,
    -----------------------------------------------
    case when (
        HIST.SCHEDULED_START is null
        or HIST.LOG_START is null
    )
    then null
    else
        to_char(abs(extract ( hour from (cast(HIST.SCHEDULED_START as timestamp) - cast(HIST.LOG_START as timestamp))) ), 'FM00') ||':'||  
        to_char(abs(extract ( minute from (cast(HIST.SCHEDULED_START as timestamp) - cast(HIST.LOG_START as timestamp))) ), 'FM00') ||':'||  
        to_char(abs(extract ( second from (cast(HIST.SCHEDULED_START as timestamp) - cast(HIST.LOG_START as timestamp))) ), 'FM00')   
    end AS START_TIME_VARIANCE,
    ---------------------------------
        CASE WHEN  HIST.SCHEDULED_START IS NULL OR HIST.LOG_START IS NULL THEN 0
            WHEN ROUND(ABS(HIST.SCHEDULED_START - HIST.LOG_START)*(24*60),0) <= 8 THEN 0 
            ELSE 1 END AS START_TIME_VARIANCE_FLAG,
    -----------------------------------------------            
	HIST.SCHEDULED_END												AS	SCHEDULE_END_TIME,
	-----------------------------------------------      
	HIST.LOG_END													AS	ACTUAL_END_TIME,
    -----------------------------------------------            
     CASE WHEN HIST.SCHEDULED_END IS NULL 
		OR HIST.LOG_END IS NULL
		THEN NULL
        ELSE
--            CASE WHEN (HIST.LOG_END - HIST.SCHEDULED_END) <= 0 
--				THEN ' ' 
--                ELSE '-'  END  
			to_char(abs(extract( hour from cast(HIST.LOG_END as timestamp) - cast(HIST.SCHEDULED_END as timestamp))), 'FM00') || ':' ||
			to_char(abs(extract( minute from cast(HIST.LOG_END as timestamp) - cast(HIST.SCHEDULED_END as timestamp))), 'FM00') || ':' ||
			to_char(abs(extract( second from cast(HIST.LOG_END as timestamp) - cast(HIST.SCHEDULED_END as timestamp))), 'FM00') 
        END                                         												AS END_TIME_VARIANCE, 
        CASE 
            WHEN HIST.SCHEDULED_END IS NULL OR HIST.LOG_END IS NULL THEN 0
            WHEN  ROUND(ABS(HIST.SCHEDULED_END - HIST.LOG_END)*(24*60),0) <= 8 THEN 0 
            ELSE 1 END AS END_TIME_VARIANCE_FLAG
            --,          
    -----------------------------------------------            
--	ROUND(HIST.TOTAL_SCHEDULED_MINUTES,0)									AS TOTAL_SCHEDULED_MINUTES, 
	------------------------------------------------------------
--	CASE WHEN HIST.TOTAL_SCHEDULED_MINUTES >= 466 THEN 30 ELSE 15 END  	                AS 	BREAK_ALLOWANCE,  
--    ROUND(HIST.ACTUALS_BREAK_DURATION_sec/60,0)											AS	BREAK_DURATION,
--    ROUND(HIST.ACTUALS_LUNCH_DURATION_sec/60,0)											AS 	LUNCH_DURATION
  --  ROUND((HIST.ACTUALS_END - HIST.ACTUALS_START )*(60*24),0)								AS	RT_ACTUALS_SHIFT_DURATION,
    -----------------------------------------------
  --  HIST.LOG_DURATION*(60*24),
  --  HIST.ACTUALS_BREAK_DURATION*(60*24),
  --  HIST.ACTUALS_LUNCH_DURATION*(60*24),
--    round((HIST.LOG_DURATION_sec 
--        -  HIST.ACTUALS_BREAK_DURATION_sec + HIST.ACTUALS_LUNCH_DURATION_sec   
--        +  ( CASE WHEN HIST.LOG_DURATION_sec >= 466*60 THEN 30*60 
--            ELSE 15*60 END ))/(60*60),2)  
--                        					AS TOTAL_WORKED_TIME_hrs
--                 -----------------------------------------------
 FROM PP_WFM_agent_CLOCKING_HISTORY HIST
 JOIN SCORECARD_HIERARCHY HIER
 ON HIER.STAFF_STAFF_ID = HIST.STAFF_ID 
 JOIN sc_hierarchy_staff staff
 on staff.staff_id = hist.staff_id
 WHERE HIST.DELETE_DETECTED_DATE IS NULL;
/


GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY_SV TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY_SV TO MAXDAT_MSTR_TRX_RPT;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
 
CREATE OR REPLACE Package DP_SCORECARD.PP_WFM_AGENT_CLOCKING_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    Procedure Insert_PP_WFM_AGENT_CLOCKING;
    Procedure Update_PP_WFM_AGENT_CLOCKING;
    Procedure Delete_PP_WFM_AGENT_CLOCKING;
	Procedure MERGE_PP_WFM_AGENT_CLOCKING_WORK_DATE;
	Procedure MERGE_PP_WFM_AGENT_CLOCKING;

--	PP_WFM_AGENT_CLOCKING_STAGE
	
END PP_WFM_AGENT_CLOCKING_PKG;
/

show errros

CREATE OR REPLACE PACKAGE BODY DP_SCORECARD.PP_WFM_AGENT_CLOCKING_PKG AS

    CURSOR STAGE_WORK_DATE_CSR IS
        SELECT distinct TRUNC(TASK_START) AS WORK_DATE
        FROM PP_WFM_AGENT_CLOCKING_STAGE
 --       GROUP BY TRUNC(TASK_START)
        ORDER BY TRUNC(TASK_START) DESC;

    STAGE_WORK_DATE_REC		STAGE_WORK_DATE_CSR%ROWTYPE;


	CURSOR JOIN_STAGE_CSR IS
		SELECT
			STAGE.ROWID								AS 	STAGE_ROW_ID,
			TARGET.ROWID							AS 	TARGET_ROW_ID,
			-------------------------------------------------
			STAGE.EXTRACT_TIMESTAMP                  AS STAGE_EXTRACT_TIMESTAMP,
			STAGE.SRC                                AS STAGE_SRC,
			STAGE.SRC_TIMESTAMP_GMT                  AS STAGE_SRC_TIMESTAMP_GMT,
			STAGE.STAFF_ID                           AS STAGE_STAFF_ID,
			STAGE.SRC_TYPE                           AS STAGE_SRC_TYPE,
			STAGE.EVENT_ID                           AS STAGE_EVENT_ID,
	--		STAGE.TASK_ID                           AS STAGE_TASK_ID,
			STAGE.TASK_START                         AS STAGE_TASK_START,
			STAGE.TASK_END                           AS STAGE_TASK_END,
			stage.duration_sec                           as stage_duration_sec,
			TARGET.EXTRACT_TIMESTAMP                 AS TARGET_EXTRACT_TIMESTAMP,
			TARGET.SRC                               AS TARGET_SRC,
			TARGET.SRC_TIMESTAMP_GMT                 AS TARGET_SRC_TIMESTAMP_GMT,
			TARGET.STAFF_ID                          AS TARGET_STAFF_ID,
			TARGET.SRC_TYPE                 AS TARGET_SRC_TYPE,
			TARGET.EVENT_ID                          AS TARGET_EVENT_ID,
--			TARGET.TASK_ID                           AS TARGET_TASK_ID,
			TARGET.TASK_START                        AS TARGET_TASK_START,
			TARGET.TASK_END                          AS TARGET_TASK_END,
			target.duration_sec                           as target_duration_sec
		FROM ( SELECT *
                FROM DP_SCORECARD.PP_WFM_AGENT_CLOCKING_STAGE
                WHERE TRUNC(TASK_START) = STAGE_WORK_DATE_REC.WORK_DATE
              ) STAGE
		FULL OUTER JOIN
		( SELECT *
            FROM DP_SCORECARD.PP_WFM_AGENT_CLOCKING
            WHERE TRUNC(TASK_START) = STAGE_WORK_DATE_REC.WORK_DATE
            and delete_detected_date is null
        ) TARGET
		ON STAGE.SRC 							= TARGET.SRC
		AND STAGE.STAFF_ID                      = TARGET.STAFF_ID
		AND STAGE.SRC_TYPE             = TARGET.SRC_TYPE
		AND STAGE.EVENT_ID                      = TARGET.EVENT_ID
		AND STAGE.TASK_START                    = TARGET.TASK_START;

--	AND nvl(stage.task_end,sysdate)         = nvl(target.task_end,sysdate)
--  WHERE TRUNC(STAGE.TASK_START) = STAGE_WORK_DATE_REC.WORK_DATE;
--   AND TRUNC(TARGET.TASK_START) = STAGE_WORK_DATE_REC.WORK_DATE;


	JOIN_STAGE_REC   JOIN_STAGE_CSR%ROWTYPE;

-----------------------------------------------------
Procedure MERGE_PP_WFM_AGENT_CLOCKING IS
-----------------------------------------------------
BEGIN

		IF (STAGE_WORK_DATE_CSR%ISOPEN)
		THEN
			CLOSE STAGE_WORK_DATE_CSR;
		END IF;

		OPEN STAGE_WORK_DATE_CSR;

		LOOP

			FETCH STAGE_WORK_DATE_CSR INTO STAGE_WORK_DATE_REC;

			EXIT WHEN STAGE_WORK_DATE_CSR%NOTFOUND;

			DBMS_OUTPUT.PUT_LINE('STARTING '||STAGE_WORK_DATE_REC.WORK_DATE);

			MERGE_PP_WFM_AGENT_CLOCKING_WORK_DATE;

        END LOOP;

		IF (STAGE_WORK_DATE_CSR%ISOPEN)
		THEN
			CLOSE STAGE_WORK_DATE_CSR;
		END IF;

        COMMIT;


    EXCEPTION

        WHEN NO_DATA_FOUND
            THEN NULL;

        WHEN OTHERS THEN 
        ROLLBACK;
        RAISE;

    END MERGE_PP_WFM_AGENT_CLOCKING;

-----------------------------------------------------
-----------------------------------------------------
PROCEDURE MERGE_PP_WFM_AGENT_CLOCKING_WORK_DATE IS
-----------------------------------------------------
    LV_TASK_TIMESTAMP_GMT           TIMESTAMP := SYSDATE - 999;
    LV_RT_TASK_TIMESTAMP_GMT        TIMESTAMP := SYSDATE - 999;
    LV_RT_ACTUALS_TIMESTAMP_GMT     TIMESTAMP := SYSDATE - 999;

	BEGIN



		IF (JOIN_STAGE_CSR%ISOPEN)
		THEN
			CLOSE JOIN_STAGE_CSR;
		END IF;

		OPEN JOIN_STAGE_CSR;

		LOOP

			FETCH JOIN_STAGE_CSR INTO JOIN_STAGE_REC;

			EXIT WHEN JOIN_STAGE_CSR%NOTFOUND;

			IF JOIN_STAGE_REC.STAGE_ROW_ID IS NOT NULL
			AND JOIN_STAGE_REC.TARGET_ROW_ID IS NOT NULL
                --then null;
				THEN UPDATE_PP_WFM_AGENT_CLOCKING;
			ELSIF JOIN_STAGE_REC.STAGE_ROW_ID IS NOT NULL
			AND JOIN_STAGE_REC.TARGET_ROW_ID IS NULL
                --then null;
				THEN INSERT_PP_WFM_AGENT_CLOCKING;
			ELSIF JOIN_STAGE_REC.STAGE_ROW_ID IS NULL
			AND JOIN_STAGE_REC.TARGET_ROW_ID IS NOT NULL
                --then null;
				THEN DELETE_PP_WFM_AGENT_CLOCKING;
			ELSE
				NULL;
			END IF;

		END LOOP;

		COMMIT;

		IF (JOIN_STAGE_CSR%ISOPEN)
		THEN
			CLOSE JOIN_STAGE_CSR;
		END IF;


    EXCEPTION

        WHEN NO_DATA_FOUND
        THEN NULL;

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('cursor fail'||' '
            ||JOIN_STAGE_REC.STAGE_STAFF_ID||' '
            ||JOIN_STAGE_REC.STAGE_ROW_ID);

        RAISE;

    END MERGE_PP_WFM_AGENT_CLOCKING_WORK_DATE;
-----------------------------------------------------
PROCEDURE UPDATE_PP_WFM_AGENT_CLOCKING IS
-----------------------------------------------------

	BEGIN

		IF NVL(JOIN_STAGE_REC.TARGET_EXTRACT_TIMESTAMP,SYSDATE - 93333)	  <>  	NVL(JOIN_STAGE_REC.STAGE_EXTRACT_TIMESTAMP,SYSDATE - 93333)
		OR NVL(JOIN_STAGE_REC.TARGET_SRC_TIMESTAMP_GMT,SYSDATE - 93333)	  <>  	NVL(JOIN_STAGE_REC.STAGE_SRC_TIMESTAMP_GMT,SYSDATE - 93333)
--		OR NVL(JOIN_STAGE_REC.TARGET_TASK_START,SYSDATE - 93333)	  <>  	NVL(JOIN_STAGE_REC.STAGE_TASK_START,SYSDATE - 93333)
		OR NVL(JOIN_STAGE_REC.TARGET_TASK_END,SYSDATE - 93333)	  <>  	NVL(JOIN_STAGE_REC.STAGE_TASK_END,SYSDATE - 93333)
		or nvl(JOIN_STAGE_REC.target_duration_sec,-999999)            <>  nvl(JOIN_STAGE_REC.stage_duration_sec,-999999)
	THEN
	UPDATE DP_SCORECARD.PP_WFM_AGENT_CLOCKING
		SET
			EXTRACT_TIMESTAMP                         =  JOIN_STAGE_REC.STAGE_EXTRACT_TIMESTAMP,
			SRC_TIMESTAMP_GMT                         =  JOIN_STAGE_REC.STAGE_SRC_TIMESTAMP_GMT,
			TASK_START                                =  JOIN_STAGE_REC.STAGE_TASK_START,
			TASK_END                                  =  JOIN_STAGE_REC.STAGE_TASK_END,
			DURATION_sec                                  =  JOIN_STAGE_REC.STAGE_duration_sec
	WHERE ROWID = JOIN_STAGE_REC.TARGET_ROW_ID;

	ELSE
		NULL;
	END IF;

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('update fail'||' '
            ||JOIN_STAGE_REC.STAGE_STAFF_ID||' '
            ||JOIN_STAGE_REC.STAGE_ROW_ID);

        ROLLBACK;
        
        RAISE;


END UPDATE_PP_WFM_AGENT_CLOCKING;


-----------------------------------------------------
PROCEDURE INSERT_PP_WFM_AGENT_CLOCKING IS
-----------------------------------------------------

	BEGIN

		INSERT INTO DP_SCORECARD.PP_WFM_AGENT_CLOCKING
		(
			EXTRACT_TIMESTAMP,
			SRC,
			SRC_TIMESTAMP_GMT,
			STAFF_ID,
			SRC_TYPE,
			EVENT_ID,
--			TASK_ID,
			TASK_START,
			TASK_END,
			duration_sec
		)
		VALUES (
				JOIN_STAGE_REC.STAGE_EXTRACT_TIMESTAMP,
				JOIN_STAGE_REC.STAGE_SRC,
				JOIN_STAGE_REC.STAGE_SRC_TIMESTAMP_GMT,
				JOIN_STAGE_REC.STAGE_STAFF_ID,
				JOIN_STAGE_REC.STAGE_SRC_TYPE,
				JOIN_STAGE_REC.STAGE_EVENT_ID,
--				JOIN_STAGE_REC.STAGE_TASK_ID,
				JOIN_STAGE_REC.STAGE_TASK_START,
				JOIN_STAGE_REC.STAGE_TASK_END,
				JOIN_STAGE_REC.STAGE_duration_sec
				);


	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('insert fail'||' '
            ||JOIN_STAGE_REC.STAGE_STAFF_ID||' '
            ||JOIN_STAGE_REC.STAGE_ROW_ID);

        ROLLBACK;
        
        RAISE;


END INSERT_PP_WFM_AGENT_CLOCKING;

-----------------------------------------------------
PROCEDURE DELETE_PP_WFM_AGENT_CLOCKING IS
-----------------------------------------------------

	BEGIN

        update DP_SCORECARD.PP_WFM_AGENT_CLOCKING
        set delete_detected_date = SYSDATE
        where rowid = JOIN_STAGE_REC.target_row_id;
        

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('delete fail'||' '
             ||JOIN_STAGE_REC.STAGE_STAFF_ID||' '
            ||JOIN_STAGE_REC.STAGE_ROW_ID);

        ROLLBACK;
        
        RAISE;


END DELETE_PP_WFM_AGENT_CLOCKING;


-----------------------------------------------------
-----------------------------------------------------

END PP_WFM_AGENT_CLOCKING_PKG;
/

show erors 

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

CREATE OR REPLACE Package DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    PROCEDURE INSERT_PP_WFM_AGENT_CLOCKING_HISTORY;
    PROCEDURE UPDATE_PP_WFM_AGENT_CLOCKING_HISTORY;
    PROCEDURE DELETE_PP_WFM_AGENT_CLOCKING_HISTORY;
	PROCEDURE MERGE_PP_WFM_AGENT_CLOCKING_HISTORY_WORK_DATE;
	PROCEDURE MERGE_PP_WFM_AGENT_CLOCKING_HISTORY;

END PP_WFM_AGENT_CLOCKING_HISTORY_PKG;
/

show errors

CREATE OR REPLACE PACKAGE BODY DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY_PKG AS

    CURSOR STAGE_WORK_DATE_CSR IS
        SELECT distinct TRUNC(TASK_START) AS WORK_DATE
        FROM PP_WFM_AGENT_CLOCKING_STAGE
        WHERE TRUNC(TASK_START) <= TRUNC(SYSDATE)
     --   GROUP BY TRUNC(TASK_START)
        ORDER BY TRUNC(TASK_START);

    STAGE_WORK_DATE_REC		STAGE_WORK_DATE_CSR%ROWTYPE;
    
    -- NOTE: To run 'back dates' you can force a run by 
    -- doing this:
    
    --insert into pp_wfm_agent_clocking_stage(task_start)
    --select distinct trunc(task_start)
    --from pp_wfm_agent_clocking

    ---------------------------------------------------------------
    
	CURSOR JOIN_STAGE_CSR IS
	SELECT
	--	STAGE.ROWID							 AS STAGE_ROW_ID,
		TARGET.ROWID							 AS TARGET_ROW_ID,
		-----------------------------------------------------------
		STAGE.STAFF_ID                           AS STAGE_STAFF_ID,
		STAGE.WORK_DAY                           AS STAGE_WORK_DAY,
		STAGE.SCHEDULED_START                    AS STAGE_SCHEDULED_START,
		STAGE.SCHEDULED_END                      AS STAGE_SCHEDULED_END,
		STAGE.TOTAL_SCHEDULED_MINUTES            AS STAGE_TOTAL_SCHEDULED_MINUTES,
		STAGE.LOG_START                          AS STAGE_LOG_START,
		STAGE.LOG_END                            AS STAGE_LOG_END,
		STAGE.LOG_DURATION_sec                       AS STAGE_LOG_DURATION_sec,
--		STAGE.ACTUALS_START                      AS STAGE_ACTUALS_START,
--		STAGE.ACTUALS_END                        AS STAGE_ACTUALS_END,
--		STAGE.ACTUALS_TOTAL_sec                      AS STAGE_ACTUALS_TOTAL_sec,
--		STAGE.ACTUALS_BREAK_DURATION_sec             AS STAGE_ACTUALS_BREAK_DURATION_sec,
--		STAGE.ACTUALS_LUNCH_DURATION_sec             AS STAGE_ACTUALS_LUNCH_DURATION_sec,
		TARGET.STAFF_ID                          AS TARGET_STAFF_ID,
		TARGET.WORK_DAY                          AS TARGET_WORK_DAY,
		TARGET.SCHEDULED_START                   AS TARGET_SCHEDULED_START,
		TARGET.SCHEDULED_END                     AS TARGET_SCHEDULED_END,
		TARGET.TOTAL_SCHEDULED_MINUTES           AS TARGET_TOTAL_SCHEDULED_MINUTES,
		TARGET.LOG_START                         AS TARGET_LOG_START,
		TARGET.LOG_END                           AS TARGET_LOG_END,
		TARGET.LOG_DURATION_sec                      AS TARGET_LOG_DURATION_sec,
		TARGET.ACTUALS_START                     AS TARGET_ACTUALS_START,
		TARGET.ACTUALS_END                       AS TARGET_ACTUALS_END,
		TARGET.ACTUALS_TOTAL_sec                    AS TARGET_ACTUALS_TOTAL_sec,
		TARGET.ACTUALS_BREAK_DURATION_sec           AS TARGET_ACTUALS_BREAK_DURATION_sec,
		TARGET.ACTUALS_LUNCH_DURATION_sec           AS TARGET_ACTUALS_LUNCH_DURATION_sec
	-------------------------------------------------------
	FROM ( SELECT * FROM PP_WFM_AGENT_CLOCKING_STAGE_2_HIST_V
           WHERE TRUNC(WORK_DAY) = STAGE_WORK_DATE_REC.WORK_DATE
           ) STAGE
	FULL OUTER JOIN
        ( SELECT * FROM PP_WFM_AGENT_CLOCKING_HISTORY
          WHERE TRUNC(WORK_DAY) = STAGE_WORK_DATE_REC.WORK_DATE
          and delete_detected_date is null
          )TARGET
	ON STAGE.STAFF_ID = TARGET.STAFF_ID
        AND STAGE.WORK_DAY = TARGET.WORK_DAY
        AND TARGET.DELETE_DETECTED_DATE IS NULL;
--    WHERE TRUNC(STAGE.WORK_DAY) = STAGE_WORK_DATE_REC.WORK_DATE
--    AND TRUNC(TARGET.WORK_DAY) = STAGE_WORK_DATE_REC.WORK_DATE;


	JOIN_STAGE_REC   JOIN_STAGE_CSR%ROWTYPE;

-----------------------------------------------------
-------------------------------------------------

PROCEDURE MERGE_PP_WFM_AGENT_CLOCKING_HISTORY IS

    BEGIN

		IF (STAGE_WORK_DATE_CSR%ISOPEN)
		THEN
			CLOSE STAGE_WORK_DATE_CSR;
		END IF;

		OPEN STAGE_WORK_DATE_CSR;

		LOOP

			FETCH STAGE_WORK_DATE_CSR INTO STAGE_WORK_DATE_REC;

			EXIT WHEN STAGE_WORK_DATE_CSR%NOTFOUND;

			DBMS_OUTPUT.PUT_LINE('STARTING '||STAGE_WORK_DATE_REC.WORK_DATE);

			MERGE_PP_WFM_AGENT_CLOCKING_HISTORY_WORK_DATE;

        END LOOP;

		IF (STAGE_WORK_DATE_CSR%ISOPEN)
		THEN
			CLOSE STAGE_WORK_DATE_CSR;
		END IF;


        COMMIT;


    EXCEPTION

        WHEN NO_DATA_FOUND
            THEN NULL;

        WHEN OTHERS THEN 
        ROLLBACK;
        RAISE;

    END MERGE_PP_WFM_AGENT_CLOCKING_HISTORY;
-----------------------------------------------------
-----------------------------------------------------

PROCEDURE MERGE_PP_WFM_AGENT_CLOCKING_HISTORY_WORK_DATE IS
-----------------------------------------------------
    LV_WORK_DAY   VARCHAR2(20) := NULL;
    LV_ROW_COUNT NUMBER(10)     := 0;
	BEGIN

        LV_ROW_COUNT := 0;

   		IF (JOIN_STAGE_CSR%ISOPEN)
		THEN
			CLOSE JOIN_STAGE_CSR;
		END IF;

		OPEN JOIN_STAGE_CSR;

		LOOP

			FETCH JOIN_STAGE_CSR INTO JOIN_STAGE_REC;

			EXIT WHEN JOIN_STAGE_CSR%NOTFOUND;

            LV_ROW_COUNT := LV_ROW_COUNT+1;

			IF JOIN_STAGE_REC.STAGE_STAFF_ID IS NOT NULL
			AND JOIN_STAGE_REC.TARGET_STAFF_ID IS NOT NULL
				THEN Update_PP_WFM_AGENT_CLOCKING_HISTORY;
			ELSIF JOIN_STAGE_REC.STAGE_STAFF_ID IS NOT NULL
			AND JOIN_STAGE_REC.TARGET_STAFF_ID IS NULL
				THEN INSERT_PP_WFM_AGENT_CLOCKING_HISTORY;
			ELSIF JOIN_STAGE_REC.STAGE_STAFF_ID IS NULL
			AND JOIN_STAGE_REC.TARGET_STAFF_ID IS NOT NULL
				THEN DELETE_PP_WFM_AGENT_CLOCKING_HISTORY;
			ELSE
				NULL;
			END IF;

		END LOOP;

		COMMIT;


        DBMS_OUTPUT.PUT_LINE('WORK_DAY = '||STAGE_WORK_DATE_REC.WORK_DATE||' ROWS = '||LV_ROW_COUNT);


        IF STAGE_WORK_DATE_REC.WORK_DATE IS NOT NULL
        THEN

            UPDATE MAXDAT.CORP_ETL_CONTROL
            SET VALUE = to_char(LEAST(STAGE_WORK_DATE_REC.WORK_DATE,TRUNC(SYSDATE)),'YYYY/MM/DD')
            WHERE NAME = 'PP_WFM_AGENT_CLOCKING_WORK_DAY';
        ELSE
            NULL;
        END IF;

        COMMIT;

		IF (JOIN_STAGE_CSR%ISOPEN)
		THEN
			CLOSE JOIN_STAGE_CSR;
		END IF;



	EXCEPTION

	    WHEN NO_DATA_FOUND
        THEN NULL;

        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('CURSOR FAIL'||' '
            ||JOIN_STAGE_REC.STAGE_STAFF_ID||' '
            ||JOIN_STAGE_REC.STAGE_WORK_DAY);
            
            ROLLBACK;
            
            RAISE;

END MERGE_PP_WFM_AGENT_CLOCKING_HISTORY_WORK_DATE;

-----------------------------------------------------
PROCEDURE UPDATE_PP_WFM_AGENT_CLOCKING_HISTORY IS
-----------------------------------------------------

	BEGIN

	--  JOIN ON
	--	TARGET_STAFF_ID
	--	TARGET_WORK_DAY

		IF NVL(JOIN_STAGE_REC.TARGET_SCHEDULED_START,SYSDATE - 93333)	<> NVL(JOIN_STAGE_REC.STAGE_SCHEDULED_START,SYSDATE - 93333)
		OR NVL(JOIN_STAGE_REC.TARGET_SCHEDULED_END,SYSDATE - 93333)	 	<> NVL(JOIN_STAGE_REC.STAGE_SCHEDULED_END,SYSDATE - 93333)
		OR NVL(JOIN_STAGE_REC.TARGET_TOTAL_SCHEDULED_MINUTES, -93333)	<> NVL(JOIN_STAGE_REC.STAGE_TOTAL_SCHEDULED_MINUTES, -93333)
		OR NVL(JOIN_STAGE_REC.TARGET_LOG_START,SYSDATE - 93333)	  		<> NVL(JOIN_STAGE_REC.STAGE_LOG_START,SYSDATE - 93333)
		OR NVL(JOIN_STAGE_REC.TARGET_LOG_END,SYSDATE - 93333)	  		<> NVL(JOIN_STAGE_REC.STAGE_LOG_END,SYSDATE - 93333)
		OR NVL(JOIN_STAGE_REC.TARGET_LOG_DURATION_sec, -93333)	  		<> NVL(JOIN_STAGE_REC.STAGE_LOG_DURATION_sec, -93333)
--		OR NVL(JOIN_STAGE_REC.TARGET_ACTUALS_START,SYSDATE - 93333)	 	<> NVL(JOIN_STAGE_REC.STAGE_ACTUALS_START,SYSDATE - 93333)
--		OR NVL(JOIN_STAGE_REC.TARGET_ACTUALS_END,SYSDATE - 93333)	 	<> NVL(JOIN_STAGE_REC.STAGE_ACTUALS_END,SYSDATE - 93333)
--		OR NVL(JOIN_STAGE_REC.TARGET_ACTUALS_TOTAL_sec, -93333)	  			<> NVL(JOIN_STAGE_REC.STAGE_ACTUALS_TOTAL_sec, -93333)
--		OR NVL(JOIN_STAGE_REC.TARGET_ACTUALS_BREAK_DURATION_sec, -93333)  	<> NVL(JOIN_STAGE_REC.STAGE_ACTUALS_BREAK_DURATION_sec, -93333)
--		OR NVL(JOIN_STAGE_REC.TARGET_ACTUALS_LUNCH_DURATION_sec, -93333)	<> NVL(JOIN_STAGE_REC.STAGE_ACTUALS_LUNCH_DURATION_sec, -93333)
	THEN
	UPDATE DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY
		SET
			SCHEDULED_START                           =  JOIN_STAGE_REC.STAGE_SCHEDULED_START,
			SCHEDULED_END                             =  JOIN_STAGE_REC.STAGE_SCHEDULED_END,
			TOTAL_SCHEDULED_MINUTES                   =  JOIN_STAGE_REC.STAGE_TOTAL_SCHEDULED_MINUTES,
			LOG_START                                 =  JOIN_STAGE_REC.STAGE_LOG_START,
			LOG_END                                   =  JOIN_STAGE_REC.STAGE_LOG_END,
			LOG_DURATION_sec                              =  JOIN_STAGE_REC.STAGE_LOG_DURATION_sec,
--			ACTUALS_START                             =  JOIN_STAGE_REC.STAGE_ACTUALS_START,
--			ACTUALS_END                               =  JOIN_STAGE_REC.STAGE_ACTUALS_END,
--			ACTUALS_TOTAL_sec                             =  JOIN_STAGE_REC.STAGE_ACTUALS_TOTAL_sec,
--			ACTUALS_BREAK_DURATION_sec                    =  JOIN_STAGE_REC.STAGE_ACTUALS_BREAK_DURATION_sec,
--			ACTUALS_LUNCH_DURATION_sec                   =  JOIN_STAGE_REC.STAGE_ACTUALS_LUNCH_DURATION_sec,
			last_updated_date                           = sysdate
	WHERE ROWID = JOIN_STAGE_REC.TARGET_ROW_ID;

	ELSE
		NULL;
	END IF;

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('UPDATE FAIL'||' '
            ||JOIN_STAGE_REC.STAGE_STAFF_ID||' '
            ||JOIN_STAGE_REC.STAGE_WORK_DAY);

        ROLLBACK;
            
        RAISE;


END UPDATE_PP_WFM_AGENT_CLOCKING_HISTORY;


-----------------------------------------------------
PROCEDURE INSERT_PP_WFM_AGENT_CLOCKING_HISTORY IS
-----------------------------------------------------

	BEGIN

		INSERT INTO DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY
		(
			STAFF_ID,
			WORK_DAY,
			SCHEDULED_START,
			SCHEDULED_END,
			TOTAL_SCHEDULED_MINUTES,
			LOG_START,
			LOG_END,
			LOG_DURATION_sec,
--			ACTUALS_START,
--			ACTUALS_END,
--			ACTUALS_TOTAL_sec,
--			ACTUALS_BREAK_DURATION_sec,
--			ACTUALS_LUNCH_DURATION_sec,
			created_date
		)
		VALUES (
				JOIN_STAGE_REC.STAGE_STAFF_ID,
				JOIN_STAGE_REC.STAGE_WORK_DAY,
				JOIN_STAGE_REC.STAGE_SCHEDULED_START,
				JOIN_STAGE_REC.STAGE_SCHEDULED_END,
				JOIN_STAGE_REC.STAGE_TOTAL_SCHEDULED_MINUTES,
				JOIN_STAGE_REC.STAGE_LOG_START,
				JOIN_STAGE_REC.STAGE_LOG_END,
				JOIN_STAGE_REC.STAGE_LOG_DURATION_sec,
--				JOIN_STAGE_REC.STAGE_ACTUALS_START,
--				JOIN_STAGE_REC.STAGE_ACTUALS_END,
--				JOIN_STAGE_REC.STAGE_ACTUALS_TOTAL_sec,
--				JOIN_STAGE_REC.STAGE_ACTUALS_BREAK_DURATION_sec,
--				JOIN_STAGE_REC.STAGE_ACTUALS_LUNCH_DURATION_sec,
				sysdate
				);


	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('INSERT FAIL'||' '
            ||JOIN_STAGE_REC.STAGE_STAFF_ID||' '
            ||JOIN_STAGE_REC.STAGE_WORK_DAY);

        ROLLBACK;

        RAISE;


END INSERT_PP_WFM_AGENT_CLOCKING_HISTORY;

-----------------------------------------------------
PROCEDURE DELETE_PP_WFM_AGENT_CLOCKING_HISTORY IS
-----------------------------------------------------

	BEGIN

		UPDATE DP_SCORECARD.PP_WFM_AGENT_CLOCKING_HISTORY
		SET DELETE_DETECTED_DATE = SYSDATE
		WHERE ROWID = JOIN_STAGE_REC.TARGET_ROW_ID;

	exception

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('DELETE FAIL'||' '
             ||JOIN_STAGE_REC.STAGE_STAFF_ID||' '
            ||JOIN_STAGE_REC.STAGE_WORK_DAY);

        ROLLBACK;
            
        RAISE;


END DELETE_PP_WFM_AGENT_CLOCKING_HISTORY;


-----------------------------------------------------
-----------------------------------------------------

END PP_WFM_AGENT_CLOCKING_HISTORY_PKG;
/

show errors