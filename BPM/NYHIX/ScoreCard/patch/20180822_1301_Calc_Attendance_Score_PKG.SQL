CREATE OR REPLACE PACKAGE DP_SCORECARD.Calc_Attendance_Score_PKG AS 
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/patch/20170623_PP_WFM_BACK_OFFICE_LOAD_PKG.sql $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 20489 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-07-03 14:31:06 -0500 (Mon, 03 Jul 2017) $'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';

Procedure Calc_Attendance_Score  --<< This is the only procedure exposed to SQL 
   ( IN_STAFF_ID IN NUMBER, IN_SYSDTE DATE DEFAULT SYSDATE );  
   
END CALC_ATTENDANCE_SCORE_PKG;
/

show errors

CREATE OR REPLACE PACKAGE BODY DP_SCORECARD.Calc_Attendance_Score_PKG AS

    GV_IN_SYSDTE                	DATE 			:= SYSDATE;
	GV_LIMIT_58_CUTOVER_DATE    	DATE
		:= TO_DATE('20170901 00:00:00','YYYYMMDD HH24:MI:SS');	--- << USE FoR TESTING
	GV_ROLLING_MONTHS   			NUMBER(12) 		:= -12;           --- << Change to -12 for Production USE -3 month rolling FOR TESTING
	GV_STARTING_POINT_DATE          DATE      		:= TO_DATE('20171001','YYYYMMDD');
	GV_ATTENDANCE_LIMIT     		NUMBER(5)  		:= 58;
	GV_CUTOVER_MONTHS_NUM			VARCHAR2(10) 	:= TO_CHAR(GV_LIMIT_58_CUTOVER_DATE,'YYYYMM');
	GV_ATTENDANCE_COUNT 			number(5)		:=	0;

	-- These CALC values are derrived by the procedure
	-- and UPDATED to SC_ATTENDANCE.
	-- On a 'Month Break' They are also used to update
	-- SCORECARD_ATTENDANCE_MTHLY
	-- only  CALC_ATTENDANCE_TOTAL, CALC_INCENTIVE_TOTAL
	-- and CALC_TOTAL_TOTAL  are Currently used by Microstrategy

	CALC_ATTENDANCE_BALANCE         	NUMBER := 0;
	CALC_INCENTIVE_BALANCE          	NUMBER := 0;
	CALC_TOTAL_BALANCE              	NUMBER := 0;

	-- The POINT_VALUE from the cursor is calssified into
	-- one of these 3 varriables

	CURR_REC_PERF_ATT_PTS			NUMBER := 0;
	CURR_REC_INCTV_PTS				NUMBER := 0;
	CURR_REC_OTHR_PTS				NUMBER := 0;

	-- This is USED BY CALC_BALANCES
	CURR_REC_SPLIT_PTS			NUMBER := 0;

    -- These are used for the EOM break ( End of Month - Last record for the month )
	GV_HOLD_DATES_MONTH_NUM       	VARCHAR2(10 BYTE) := NULL;
	GV_HOLD_SC_ATTENDANCE_ID     	NUMBER := 0;
--	GV_HOLD_EOM_FLAG              	VARCHAR2(1 BYTE) := NULL;
    GV_HOLD_STAFF_ID            	NUMBER := NULL;


    CURSOR STAFF_ATTENDANCE_CSR(IN_STAFF_ID IN NUMBER) IS
	WITH
		---------------------------------------------
		-- The first part of the cursor is used to --
		-- DETERMINE A DATE RANGE FOR THE STAFF_ID --
		---------------------------------------------
	HIRE AS
		( SELECT MAX(HIRE_DATE)                 AS MAX_HIRE_DATE
		FROM DP_SCORECARD.SCORECARD_HIERARCHY
		WHERE STAFF_STAFF_ID = IN_STAFF_ID
		),
	TERM AS
		( SELECT MAX(nvl(TERMINATION_DATE,SYSDATE))  AS MAX_TERM_DATE
		FROM DP_SCORECARD.SCORECARD_HIERARCHY
		WHERE STAFF_STAFF_ID = IN_STAFF_ID
		),
	ATND AS	-- GET THE FIRST SC_ATTENDANCE_RECORD
		( SELECT MIN(ENTRY_DATE)                AS MIN_ENTRY_DATE
				FROM DP_SCORECARD.SC_ATTENDANCE
				WHERE STAFF_ID = IN_STAFF_ID
		),
	INIT AS	-- GET THE FIRST INITIALIZATION RECORD
		( SELECT MIN(START_DATE)                AS MIN_START_DATE
          FROM DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE
		  WHERE STAFF_ID = IN_STAFF_ID
		),
	STAFF_START_STOP AS
		(
		SELECT
		TO_CHAR(GREATEST(MAX_HIRE_DATE,
                    NVL(MIN_ENTRY_DATE,MAX_HIRE_DATE),
                    NVL(MIN_START_DATE,MAX_HIRE_DATE)),'YYYYMM')    AS START_MONTH_NUM,
        TO_CHAR(MAX_TERM_DATE,'YYYYMM')                             AS TERM_MONTH_NUM
		FROM HIRE
		LEFT OUTER JOIN TERM ON 1=1
		LEFT OUTER JOIN ATND ON 1=1
		LEFT OUTER JOIN INIT ON 1=1
		),
	ALL_MONTHS AS
		( SELECT D.DATES_MONTH_NUM
            FROM  STAFF_START_STOP
            JOIN
            ( SELECT
                TO_CHAR(ADD_MONTHS (TRUNC (TO_DATE('01/01/2012','MM/DD/YYYY'), 'MM'), 1*LEVEL -1), 'YYYYMM') AS DATES_MONTH_NUM
                FROM DUAL
                CONNECT BY LEVEL <= MONTHS_BETWEEN(TRUNC(SYSDATE), TO_DATE('01/01/2012','MM/DD/YYYY')) + 1
            ) D
            ON 1=1
            WHERE D.DATES_MONTH_NUM BETWEEN START_MONTH_NUM AND TERM_MONTH_NUM
		),
	STAFF_MONTHS AS
		( SELECT IN_STAFF_ID AS STAFF_STAFF_ID,
			ALL_MONTHS.DATES_MONTH_NUM,
			TO_DATE(ALL_MONTHS.DATES_MONTH_NUM,'YYYYMM') AS DATES
		FROM ALL_MONTHS
		--WHERE ALL_MONTHS.DATES_MONTH_NUM
		--BETWEEN STAFF_START_STOP.ATTND_DATES_MONTH_NUM AND STAFF_START_STOP.TERM_MONTH_NUM
		),
		-- Done Determing dates
		-- Start getting data
	STAFF_INITIAL_BALANCES AS
		(
		SELECT
			AIS.STAFF_ID															AS STAFF_STAFF_ID,
			AIS.START_DATE															AS DATES,
			ais.start_date 														AS CREATE_DATETIME,
			0 																		AS SC_ATTENDANCE_ID,
			TO_CHAR(ais.start_date
			--		GV_STARTING_POINT_DATE,
					--to_date(to_char(add_months(sysdate,-12),'YYYYMM'),'YYYYmm')
					,'YYYYMM')                                   					AS DATES_MONTH_NUM,
			'** Initial Balance - '
			||TO_CHAR(AIS.START_DATE,'MONTH')||' '||TO_CHAR(AIS.START_DATE,'YYYY')
			||' **' 																AS ABSENCE_TYPE,
 			-- 'Starting Balance' 													AS ABSENCE_TYPE,
			0			 															AS POINT_VALUE,
			NVL(AIS.ATTENDANCE_POINTS,0)                   							AS BALANCE,
			NVL(AIS.INCENTIVE_POINTS,0) 											AS INCENTIVE_BALANCE,
			NULL 																	AS INCENTIVE_FLAG,
			NULL 																	AS LAST_UPDATED_DATETIME,
			NULL 																	AS PERFECT_ATTENDANCE_FLAG
		FROM ( select * from DP_SCORECARD.SCORECARD_HIERARCHY
				WHERE STAFF_STAFF_ID = IN_STAFF_ID
			 ) S
		JOIN DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE AIS
			ON S.STAFF_STAFF_ID = AIS.STAFF_ID
		WHERE S.STAFF_STAFF_ID = IN_STAFF_ID
		),
	STAFF_STARTING_BALANCE AS
		(  	-- Do not create this recored if there is
			-- an 'Initial Balance' for the same date
		SELECT DISTINCT
			H.STAFF_STAFF_ID													AS STAFF_STAFF_ID,
			GV_STARTING_POINT_DATE												AS DATES,
			GV_STARTING_POINT_DATE 												AS CREATE_DATETIME,
			0 																	AS SC_ATTENDANCE_ID,
			TO_CHAR(greatest(h.hire_date,GV_STARTING_POINT_DATE ),'YYYYMM')		AS DATES_MONTH_NUM,
			'** Starting Balance - '||to_char(sysdate,'Month')||' '
				||to_char(sysdate,'YYYY')||' **' 								AS ABSENCE_TYPE,
			-- 'Starting Balance' 												AS ABSENCE_TYPE,
			0 																	AS POINT_VALUE,
			40 																	AS BALANCE,
			0 																	AS INCENTIVE_BALANCE,
			NULL 																AS INCENTIVE_FLAG,
			NULL 																AS LAST_UPDATED_DATETIME,
			NULL 																AS PERFECT_ATTENDANCE_FLAG
		FROM ( SELECT * FROM DP_SCORECARD.SCORECARD_HIERARCHY
				WHERE STAFF_STAFF_ID = IN_STAFF_ID
			 ) H
		LEFT OUTER JOIN DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE AIS
			ON H.STAFF_STAFF_ID = AIS.STAFF_ID
			AND AIS.START_DATE = TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE,GV_ROLLING_MONTHS),'YYYYMM'),'YYYYMM')
		WHERE AIS.STAFF_ID IS NULL
		),
	SC_ATTEND_ENTRIES AS
		(
		SELECT
			SCA.STAFF_ID 							AS STAFF_STAFF_ID,
			SCA.ENTRY_DATE 							AS DATES,
			SCA.CREATE_DATETIME,
			SCA.SC_ATTENDANCE_ID,
			TO_CHAR(SCA.ENTRY_DATE,'YYYYMM') 		AS DATES_MONTH_NUM,
			SCA.ABSENCE_TYPE,
			SCA.POINT_VALUE							AS POINT_VALUE,
			0 										AS BALANCE,
			0 										as INCENTIVE_BALANCE,
			SCA.INCENTIVE_FLAG,
			SCA.LAST_UPDATED_DATETIME,
			LKP.PERFECT_ATTENDANCE_FLAG												AS PERFECT_ATTENDANCE_FLAG
		FROM DP_SCORECARD.SC_ATTENDANCE SCA
		LEFT OUTER JOIN DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP LKP
		ON LKP.SC_ALL_ID = SCA.SC_ALL_ID
		WHERE SCA.STAFF_ID = IN_STAFF_ID
		),
	EOM_BALANCE_REC AS
	-- Be sure there is at least one an entry for each month
	(	SELECT
			STAFF_STAFF_ID,
            -- SET THE DATE TO THE LAST SECOND OF THE LAST DAY OF THE MONTH
			EOM_DATE                                AS DATES,
			SYSDATE 								AS CREATE_DATETIME,
			-1 										AS SC_ATTENDANCE_ID,
			TO_CHAR(EOM_DATE,'YYYYMM')			    AS DATES_MONTH_NUM,
			'*** End of Month Balance' 				AS ABSENCE_TYPE,
			0 										AS POINT_VALUE,
			0 										AS BALANCE,
			0 										AS INCENTIVE_BALANCE,
			NULL 									AS INCENTIVE_FLAG,
			SYSDATE 								AS LAST_UPDATED_DATETIME,
			NULL 									AS PERFECT_ATTENDANCE_FLAG
		FROM
		( SELECT STAFF_STAFF_ID,
                TRUNC(LAST_DAY(DATES))+((60*60*24)-1)/(60*60*24)  AS EOM_DATE
          FROM STAFF_MONTHS
          WHERE STAFF_STAFF_ID = IN_STAFF_ID
		  MINUS -- PREVENT DUPS
		  SELECT STAFF_ID,
               ENTRY_DATE
		  FROM SC_ATTENDANCE
          WHERE STAFF_ID = IN_STAFF_ID
        )
        WHERE STAFF_STAFF_ID = IN_STAFF_ID
    )
------------------------
SELECT 	STAFF_STAFF_ID,
		DATES,
		CREATE_DATETIME,
		SC_ATTENDANCE_ID,
		DATES_MONTH_NUM,
		ABSENCE_TYPE,
		POINT_VALUE,
		BALANCE,
		INCENTIVE_BALANCE,
		INCENTIVE_FLAG,
		LAST_UPDATED_DATETIME,
		PERFECT_ATTENDANCE_FLAG
FROM
	(
	SELECT * FROM STAFF_INITIAL_BALANCES
	UNION ALL
	SELECT * FROM STAFF_STARTING_BALANCE
	UNION ALL
	SELECT * FROM SC_ATTEND_ENTRIES
	UNION ALL
	SELECT * FROM EOM_BALANCE_REC
	)
WHERE 1=1
--AND TO_CHAR(DATES,'YYYYMM') BETWEEN TO_CHAR(GV_STARTING_POINT_DATE,'YYYYMM') AND TO_CHAR(GV_IN_SYSDTE,'YYYYMM')
ORDER BY STAFF_STAFF_ID, DATES, CREATE_DATETIME, SC_ATTENDANCE_ID;

STAFF_REC   STAFF_ATTENDANCE_CSR%ROWTYPE;

HIERARCHY_REC  SCORECARD_HIERARCHY%ROWTYPE;

-----------------------------------------------------
-----------------------------------------------------
PROCEDURE Update_SC_ATTENDANCE IS
-----------------------------------------------------
-----------------------------------------------------

	BEGIN

        IF STAFF_REC.sc_attendance_id = -1    --<< 'EOM_BALANCE_REC'
        OR STAFF_REC.sc_attendance_id = -2    --<<  'CUTOVER_BLANCE'
		OR STAFF_REC.sc_attendance_id = 0		-- INITIALIZATION RECORD
		THEN
			NULL;
--			DBMS_OUTPUT.PUT_LINE('ID: '||STAFF_REC.sc_attendance_id||' '||STAFF_REC.ABSENCE_TYPE||' DATES: '||STAFF_REC.DATES||' DATES_MONTH NUM: '||STAFF_REC.DATES_MONTH_NUM);
		ELSE
			BEGIN
				UPDATE DP_SCORECARD.SC_ATTENDANCE
					SET BALANCE                     = CALC_ATTENDANCE_BALANCE,
						INCENTIVE_BALANCE			= CALC_INCENTIVE_BALANCE,
						TOTAL_BALANCE				= CALC_TOTAL_BALANCE
					WHERE STAFF_ID = GV_HOLD_STAFF_ID
					AND SC_ATTENDANCE_ID = STAFF_REC.SC_ATTENDANCE_ID;

				EXCEPTION
					WHEN OTHERS
					THEN RAISE;

			END;

        END IF;

	END Update_SC_ATTENDANCE;

----------------------------------------
----------------------------------------
PROCEDURE CALC_BALANCES
----------------------------------------
----------------------------------------
IS
    BEGIN
	------------------------------------
	-- CALCULATE THE BALANCES
	-- NOT AN INITIALIZATION RECORD
	-- or Employee (40)*
	------------------------------------

	-----------------------------------
	-- Classify the point value and
	-----------------------------------

    CURR_REC_INCTV_PTS	 	:= 0;
    CURR_REC_PERF_ATT_PTS	:= 0;
    CURR_REC_OTHR_PTS		:= 0;

    IF STAFF_REC.INCENTIVE_FLAG = 'Y'
		THEN
			CURR_REC_INCTV_PTS	 		:= NVL(STAFF_REC.POINT_VALUE,0);
    ELSIF STAFF_REC.PERFECT_ATTENDANCE_FLAG = 'Y'
		THEN
			CURR_REC_PERF_ATT_PTS	:=  NVL(STAFF_REC.point_value,0);
    ELSE -- NOTE THESE ARE EXPECTED TO BE NEGITIVE BUT EMPLOYEE 40 IS NOT
			CURR_REC_OTHR_PTS		:= NVL(STAFF_REC.point_value,0);
    END IF;


		-- ************************************************************************
		-- CALCULATE THE SCORE
		-- ************************************************************************

		-----------------------------------------------------------
		-- Note Only points with the INCENTIVE_FLAG = 'Y' get added to the INCENTIVE BALANCE
		-- and only if the Balance limit has been reached.
		-- All ponts get subtracted ( add the negative NUMBERS ) from the INCENTIVE BALANCE
		-- but the INCENTIVE BALANCE cannot go below ZERO.
		-----------------------------------------------------------

		CURR_REC_SPLIT_PTS :=  0;

		-- PROCESS ICENTIVE POINTS
		IF CURR_REC_INCTV_PTS > 0
		AND CALC_ATTENDANCE_BALANCE >= GV_ATTENDANCE_LIMIT
		THEN -- ALREADY GREATER THAN THE LIMIT
			 -- ALL THE POINTS ALL GO TO THE INCENTIVE BALANCE
			CALC_INCENTIVE_BALANCE := CALC_INCENTIVE_BALANCE + CURR_REC_INCTV_PTS;
		ELSE
			IF 	CALC_ATTENDANCE_BALANCE + CURR_REC_INCTV_PTS <= GV_ATTENDANCE_LIMIT
			THEN 	-- The POINTS + CURRENT ATTENDANCE BALANCE will be LESS THAN THE LIMIT
					-- All the INCENTIVE POINTS GO TO THE ATTENDANCE BALANCE NONE GO TH THE INCENTIVE BALANCE
				CALC_ATTENDANCE_BALANCE := CALC_ATTENDANCE_BALANCE + CURR_REC_INCTV_PTS;
			ELSE
					-- THE ATTANDANCE BALANCE + THE INCENTIVE POINTS will be over the limit
					-- SOME OF THE INCENTIVE GOES TO THE ATTENDANCE_BALANCE
					-- The ATTENDANCE_BALANCE is set to the limit
				CURR_REC_SPLIT_PTS := (CALC_ATTENDANCE_BALANCE + CURR_REC_INCTV_PTS) - GV_ATTENDANCE_LIMIT;
				CALC_INCENTIVE_BALANCE  :=   CALC_incentive_BALANCE + CURR_REC_SPLIT_PTS;
				CALC_ATTENDANCE_BALANCE := GV_ATTENDANCE_LIMIT;
			END IF;
		END IF;

		-- PROCESS 'OTHER' POINTS
		IF CURR_REC_OTHR_PTS <> 0
		THEN -- Note these points are usually negative
			IF NVL(CALC_INCENTIVE_BALANCE,0) <= 0
			THEN
				CALC_ATTENDANCE_BALANCE := CALC_ATTENDANCE_BALANCE + CURR_REC_OTHR_PTS;
			ELSE
				IF CALC_INCENTIVE_BALANCE + CURR_REC_OTHR_PTS >= 0
				THEN -- All of the points are taken from the Incentive Balance
					CALC_INCENTIVE_BALANCE := CALC_incentive_BALANCE + CURR_REC_OTHR_PTS;
				ELSE
				-- SPLIT THE POINTS BETWEEN CALC_ATTENDANCE_BALANCE AND CALC_incentive_BALANCE
					CURR_REC_SPLIT_PTS := CALC_INCENTIVE_BALANCE + CURR_REC_OTHR_PTS;
					CALC_ATTENDANCE_BALANCE := CALC_ATTENDANCE_BALANCE + CURR_REC_SPLIT_PTS;
					CALC_incentive_BALANCE := 0;
				END IF;
			END IF;
		END IF;

		-- PROCESS_PERFECT ATTENDANCE
		IF CURR_REC_PERF_ATT_PTS > 0
		THEN  -- Note Perfect Attendance Points Do not increase the
			  -- Attendance Balance over the limit
			IF CALC_ATTENDANCE_BALANCE >= GV_ATTENDANCE_LIMIT
			THEN -- DO NOT PROCESS CURR_REC_PERF_ATT_PTS
				NULL;
			ELSE
				IF CALC_ATTENDANCE_BALANCE + CURR_REC_PERF_ATT_PTS <= GV_ATTENDANCE_LIMIT
				THEN  -- All the points go to the Attendance Balance
					CALC_ATTENDANCE_BALANCE := CALC_ATTENDANCE_BALANCE + CURR_REC_PERF_ATT_PTS;
				ELSE -- Split the Points
					-- SET THE ATTENDANCE BALANCE TO THE LIMIT
					CURR_REC_SPLIT_PTS :=  (CALC_ATTENDANCE_BALANCE + CURR_REC_PERF_ATT_PTS) - GV_ATTENDANCE_LIMIT;
					-- The CURR_REC_SPLIT_PTS are actually 'lost'
					CALC_ATTENDANCE_BALANCE := GV_ATTENDANCE_LIMIT;
				END IF;
			END IF;
		END IF;

		-- Final check to adjust Incentive Points
		-- Prior to the cutover date someone could have
		-- an Attendance balance of 40 and some number of Incentive POINTS
		-- If the incentive points are positive split the points to make
		-- the Attendance Balance equal to the Limit;

		-- Reset the Balance limit based ONLY on the Entry_Date
		-- Note the Balance limit could have been reset due to the
		-- 'special processing for 'Employee *40'

		IF STAFF_REC.DATES >= GV_LIMIT_58_CUTOVER_DATE
		THEN
			GV_ATTENDANCE_LIMIT := 58;
		ELSE
			GV_ATTENDANCE_LIMIT := 40;
		END IF;

        IF NVL(CALC_INCENTIVE_BALANCE,0) > 0
        AND NVL(CALC_ATTENDANCE_BALANCE,0) < GV_ATTENDANCE_LIMIT
        THEN
            CURR_REC_SPLIT_PTS := LEAST(CALC_INCENTIVE_BALANCE,( GV_ATTENDANCE_LIMIT - CALC_ATTENDANCE_BALANCE ));
            CALC_ATTENDANCE_BALANCE := CALC_ATTENDANCE_BALANCE + CURR_REC_SPLIT_PTS;
            CALC_INCENTIVE_BALANCE := CALC_INCENTIVE_BALANCE - CURR_REC_SPLIT_PTS;
        END IF;

		dbms_output.put_line('DATE: '||STAFF_REC.DATES||' ID: '||STAFF_REC.sc_attendance_id||' I='||CURR_REC_INCTV_PTS||' P='||CURR_REC_PERF_ATT_PTS||' O='||CURR_REC_OTHR_PTS||' S='||CURR_REC_SPLIT_PTS);


		CALC_TOTAL_BALANCE  := CALC_ATTENDANCE_BALANCE + CALC_INCENTIVE_BALANCE;

END CALC_BALANCES;

----------------------------------------
----------------------------------------
PROCEDURE UPDATE_MTHLY
----------------------------------------
----------------------------------------
IS
        LV_DATE 	DATE := NULL;
		lv_count	number := 0;

	BEGIN

			LV_DATE := TO_DATE(GV_HOLD_DATES_MONTH_NUM,'YYYYMM');
            LV_COUNT := 0;
        
			SELECT COUNT(*) INTO LV_COUNT
			FROM DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY
			WHERE STAFF_STAFF_ID = GV_HOLD_STAFF_ID
			AND DATES_MONTH_NUM = GV_HOLD_DATES_MONTH_NUM;

			DBMS_OUTPUT.PUT_LINE('lv_count: '||lv_count||' UPDATE_MTHLY FOR: '||HIERARCHY_REC.STAFF_STAFF_ID||' ON '||LV_DATE);

			IF HIERARCHY_REC.STAFF_STAFF_ID IS NULL
                THEN
                    NULL;
                    
			ELSIF LV_COUNT = 1
			THEN
				BEGIN
					-- TRY THE UPDATE FIRST (IT IS THE MOST COMMON )

					UPDATE DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY
						SET BALANCE         = CALC_ATTENDANCE_BALANCE,
						TOTAL_BALANCE       = CALC_TOTAL_BALANCE,
                        MANAGER_STAFF_ID    = HIERARCHY_REC.MANAGER_STAFF_ID,
                        MANAGER_NAME        = HIERARCHY_REC.MANAGER_NAME,
                        SUPERVISOR_STAFF_ID = HIERARCHY_REC.SUPERVISOR_STAFF_ID,
                        SUPERVISOR_NAME     = HIERARCHY_REC.SUPERVISOR_NAME,
                        STAFF_STAFF_NAME    = HIERARCHY_REC.STAFF_STAFF_NAME
					WHERE STAFF_STAFF_ID    = GV_HOLD_STAFF_ID
					AND DATES_MONTH_NUM     = GV_HOLD_DATES_MONTH_NUM;

					COMMIT;

				EXCEPTION
					WHEN OTHERS
					THEN RAISE;
				END;

			ELSIF nvl(LV_COUNT,0) = 0
			AND HIERARCHY_REC.STAFF_STAFF_ID IS NOT null
			THEN
                    BEGIN

                        INSERT INTO DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY (
                        MANAGER_STAFF_ID, MANAGER_NAME,
                        SUPERVISOR_STAFF_ID, SUPERVISOR_NAME,
                        STAFF_STAFF_ID, STAFF_STAFF_NAME,
                        DATES_MONTH,
						DATES_MONTH_NUM,
						DATES_YEAR,
                        BALANCE, TOTAL_BALANCE, SC_ATTENDANCE_ID)
                        VALUES ( HIERARCHY_REC.MANAGER_STAFF_ID,
                        HIERARCHY_REC.MANAGER_NAME,
                        HIERARCHY_REC.SUPERVISOR_STAFF_ID,
                        HIERARCHY_REC.SUPERVISOR_NAME,
                        HIERARCHY_REC.STAFF_STAFF_ID,
                        HIERARCHY_REC.STAFF_STAFF_NAME,
						to_char(LV_DATE, 'Month'),          -- dates_month,
						to_char(LV_DATE, 'YYYYMM'),         -- dates_month_num,
						to_char(LV_DATE, 'Month YYYY'),     -- dates_year,
                        CALC_ATTENDANCE_BALANCE,
                        CALC_TOTAL_BALANCE,
                        GV_HOLD_SC_ATTENDANCE_ID
                        );

                        DBMS_OUTPUT.PUT_LINE(HIERARCHY_REC.STAFF_STAFF_ID||' INSERTED FOR: '||lv_date);

					EXCEPTION
						WHEN OTHERS THEN RAISE;

                    END;
            ELSE

				Raise_Application_Error (-20343, 'COUNT > 1 FOR : '||GV_HOLD_STAFF_ID||' '||GV_HOLD_DATES_MONTH_NUM||' COUNT: '||LV_COUNT);

			END IF;
			
    END UPDATE_MTHLY;
----------------------------------------
-- *************************************
-- **** MAIN PROCEDURE  ****************
-- *************************************
----------------------------------------
PROCEDURE CALC_ATTENDANCE_SCORE
   ( IN_STAFF_ID IN NUMBER, IN_SYSDTE DATE DEFAULT SYSDATE )
----------------------------------------
----------------------------------------

IS

	-- Note the IN_SYSDTE parameter can be used to simulate
	-- calcualtions on a specific date

	LV_STAFF_COUNT   NUMBER(5)  := 0;

BEGIN

	GV_IN_SYSDTE := NVL(IN_SYSDTE,SYSDATE);

	GV_STARTING_POINT_DATE := TO_DATE(TO_CHAR(ADD_MONTHS(GV_IN_SYSDTE,GV_ROLLING_MONTHS),'YYYYMM'),'YYYYMM');

--	DBMS_OUTPUT.PUT_LINE('STAFF: '||IN_STAFF_ID||' START: '||GV_STARTING_POINT_DATE||' END: '||GV_IN_SYSDTE);

	BEGIN
		-- THE HIERARCHY DATA IS NEEDED FOR THE UPDATE OF SCORECARD_ATTENDANCE_MTHLY
		-- AND TO STOP PROCESSING ON TERMINATED	EMPLOYEES

        SELECT COUNT(*) INTO LV_STAFF_COUNT
		FROM DP_SCORECARD.SCORECARD_HIERARCHY
		WHERE STAFF_STAFF_ID = in_staff_id;

		IF LV_STAFF_COUNT > 1
		THEN
            RETURN;
        END IF;

		SELECT * INTO HIERARCHY_REC
		FROM DP_SCORECARD.SCORECARD_HIERARCHY
		WHERE STAFF_STAFF_ID = in_staff_id;
		
		-- If there is NOT a record in SC_ATTENDANCE_INITIAL_SCORE
		-- for the HIRE_DATE of the Staff member then create one.
		
		IF LV_STAFF_COUNT = 1
		THEN
			INSERT INTO DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE
			( STAFF_ID, START_DATE, ATTENDANCE_POINTS )
			SELECT STAFF_STAFF_ID, HIRE_DATE, 40
			FROM  
                (  SELECT 
                            HIERARCHY_REC.STAFF_STAFF_ID as staff_staff_id, 
                            TRUNC(HIERARCHY_REC.HIRE_DATE) as HIRE_DATE
                    FROM DUAL
                  --  SELECT STAFF_STAFF_ID,  TRUNC(HIRE_DATE) AS HIRE_DATE
                  --  FROM SCORECARD_HIERARCHY
                  --  WHERE STAFF_STAFF_ID = HIERARCHY_REC.staff_staff_id
                    WHERE HIERARCHY_REC.STAFF_STAFF_ID 
                        IN ( SELECT STAFF_ID FROM SC_ATTENDANCE )
                    MINUS
                    SELECT STAFF_ID, TRUNC(START_DATE)
                    FROM SC_ATTENDANCE_INITIAL_SCORE
                );	
                		
			COMMIT;
			
		END IF;
		
		IF IN_SYSDTE > HIERARCHY_REC.TERMINATION_DATE
		THEN  -- DO NOT PROCESS STAFF AFTER THE TERMINATION DATE
         --   NULL;
            RETURN;
        END IF;

	EXCEPTION
		WHEN NO_DATA_FOUND
		THEN

            RETURN;

		WHEN OTHERS THEN RAISE;

	END;

	IF (staff_attendance_csr%ISOPEN)
		THEN
			CLOSE staff_attendance_csr;
	END IF;

	OPEN staff_attendance_csr(in_staff_id);

	LOOP

		FETCH staff_attendance_csr INTO STAFF_REC;

		EXIT WHEN staff_attendance_csr%NOTFOUND;

		DBMS_OUTPUT.PUT_LINE('ROW 1: ID= '||STAFF_REC.SC_ATTENDANCE_ID||' DATE: '||STAFF_REC.DATES);

	-- set up the 'Monthly Break values'

    IF STAFF_ATTENDANCE_CSR%ROWCOUNT = 1
    THEN
        GV_HOLD_DATES_MONTH_NUM 	:= STAFF_REC.DATES_MONTH_NUM;
        GV_HOLD_SC_ATTENDANCE_ID 	:= STAFF_REC.SC_ATTENDANCE_ID;
		GV_HOLD_STAFF_ID			:= STAFF_REC.STAFF_STAFF_ID;
		DBMS_OUTPUT.PUT_LINE('ROW 1: ID= '||STAFF_REC.SC_ATTENDANCE_ID);
	END IF;

	-----------------------------------
	-- Test for a 'Month Break' and
	-- Set the EOM_FLAG of the prior record
	-----------------------------------

    IF GV_HOLD_DATES_MONTH_NUM = STAFF_REC.DATES_MONTH_NUM
        THEN  -- NOT A BREAK
			NULL;
        ELSE -- A MONTH BREAK HAS OCCURRED
			-- Update SCORECARD_ATTENDANCE_MTHLY
			-- with the current CALC_ values

			UPDATE_MTHLY;

			-- RESET THE BREAK VALUES
			GV_HOLD_DATES_MONTH_NUM     := STAFF_REC.DATES_MONTH_NUM;
			GV_HOLD_SC_ATTENDANCE_ID    := STAFF_REC.SC_ATTENDANCE_ID;
			GV_HOLD_STAFF_ID			:= STAFF_REC.STAFF_STAFF_ID;
			GV_ATTENDANCE_COUNT 		:=	0;

    END IF;

	----------------------------------------------------------------
	-- Note STARTING BALANCE ( INITAILAIZATION RECORDS ) records are
	-- in the cursor but NOT in the SC_ATTENDANCE table
	----------------------------------------------------------------

	-- INITIALIZATION RECORDS
    IF STAFF_REC.SC_ATTENDANCE_ID = 0 	--<< This is an INITIALIZATION record
										-- Note: SC_ATTENDANCE_INITIAL_SCORE only has attendance points and incentive points
	THEN
        CALC_ATTENDANCE_BALANCE := nvl(STAFF_REC.BALANCE,0); --CALC_attendance_total; --+ NVL(CSR_point_value,0);
        CALC_INCENTIVE_BALANCE  := nvl(STAFF_REC.INCENTIVE_BALANCE,0); -- CALC_incentive_total + nvl(CSR_incentive_balance,0);
        CALC_TOTAL_BALANCE  	:= CALC_ATTENDANCE_BALANCE + CALC_INCENTIVE_BALANCE;
--			DBMS_OUTPUT.PUT_LINE('ID: '||STAFF_REC.sc_attendance_id||' '||STAFF_REC.ABSENCE_TYPE||' DATES: '||STAFF_REC.DATES||' DATES_MONTH NUM: '||STAFF_REC.DATES_MONTH_NUM);
		DBMS_OUTPUT.PUT_LINE('Initialized: A='||CALC_ATTENDANCE_BALANCE||' I='||CALC_INCENTIVE_BALANCE||' T='||CALC_TOTAL_BALANCE);
		CONTINUE;  --<< done with the INITIALIZATION RECORD(S)

	end if;

	---------------------------------
	-- DETERMINE THE BALANCE_LIMIT
	---------------------------------
    IF TO_CHAR(STAFF_REC.DATES,'YYYYMM') < TO_CHAR(GV_LIMIT_58_CUTOVER_DATE,'YYYYMM')
    THEN
		GV_ATTENDANCE_LIMIT := 40;
    ELSE
        GV_ATTENDANCE_LIMIT := 58;
    END IF;

	---------------------------
	-- SPECIAL PROCESSING ( ADJUSTS BALANCE LIMITS )
	---------------------------

		IF STAFF_REC.ABSENCE_TYPE = 'Employee (40)*'
		THEN
		-- CR 1994 - SC Attendance Calculation Issue
		--	CALC_ATTENDANCE_BALANCE     := GREATEST(40,CALC_ATTENDANCE_BALANCE);
		--	CALC_INCENTIVE_BALANCE      := CALC_INCENTIVE_BALANCE;
			CALC_ATTENDANCE_BALANCE     := 40;
			CALC_INCENTIVE_BALANCE      := 0;
			CALC_TOTAL_BALANCE          := CALC_ATTENDANCE_BALANCE + CALC_INCENTIVE_BALANCE;
			UPDATE_SC_ATTENDANCE;
--			DBMS_OUTPUT.PUT_LINE('ID: '||STAFF_REC.sc_attendance_id||' '||STAFF_REC.ABSENCE_TYPE||' DATES: '||STAFF_REC.DATES||' DATES_MONTH NUM: '||STAFF_REC.DATES_MONTH_NUM);
			CONTINUE;
		END IF;

		IF STAFF_REC.ABSENCE_TYPE LIKE 'Perfect Attendance |%'
		THEN
		-- Independant of the Entry_Date, The 'old' Perfect Attendance
		-- CANNOT raise the Attendance Balance above 40
		-- records set the balance_limit to 40 unless it is already >= 40
			GV_ATTENDANCE_LIMIT := GREATEST(CALC_ATTENDANCE_BALANCE,40);
		END IF;

		-- TEST TAHT NO MORE THAN 3 PERFECT ATTENDAVE RECORDS
		-- CAN BE APPLIED IN THE SAME MONTH

		IF STAFF_REC.ABSENCE_TYPE LIKE 'Perfect Attendance%'
		THEN GV_ATTENDANCE_COUNT := GV_ATTENDANCE_COUNT + 1;
			IF GV_ATTENDANCE_COUNT <= 3
			THEN
				NULL;
			ELSE -- THE POINTS DON'T COUNT
				STAFF_REC.POINT_VALUE := 0;
			END IF;
		END IF;


		-- *******************************************************
		-- NOT AN INITIALIZATION RECORD
		-- or Employee (40)*
		-- *******************************************************

		CALC_BALANCES;

		UPDATE_SC_ATTENDANCE;

--	END IF;

	END LOOP;

	COMMIT;


	UPDATE_MTHLY;

	COMMIT;

END Calc_Attendance_Score;

END Calc_Attendance_Score_PKG;
/

show errors
