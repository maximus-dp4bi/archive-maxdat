CREATE OR REPLACE PACKAGE DP_SCORECARD.Calc_Attendance_Score_PKG AS 
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

Procedure Calc_Attendance_Score  --<< This is the only procedure exposed to SQL 
   ( IN_STAFF_ID IN NUMBER, IN_SYSDTE DATE DEFAULT SYSDATE );  
   
END CALC_ATTENDANCE_SCORE_PKG;
/

show errors

create or replace PACKAGE BODY              Calc_Attendance_Score_PKG AS

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

			SELECT COUNT(*) INTO LV_COUNT
			FROM DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY
			WHERE STAFF_STAFF_ID = GV_HOLD_STAFF_ID
			AND DATES_MONTH_NUM = GV_HOLD_DATES_MONTH_NUM;

			DBMS_OUTPUT.PUT_LINE('lv_count: '||lv_count||' UPDATE_MTHLY FOR: '||HIERARCHY_REC.STAFF_STAFF_ID||' ON '||LV_DATE);

			IF LV_COUNT = 1
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

			ELSIF LV_COUNT = 0
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

				Raise_Application_Error (-20343, 'COUNT > 1 FOR : '||GV_HOLD_STAFF_ID||' '||GV_HOLD_DATES_MONTH_NUM);

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

grant execute on dp_scorecard.Calc_Attendance_Score_PKG to MAXDAT;

grant execute on dp_scorecard.Calc_Attendance_Score_PKG to MAXDAT_REPORTS;

grant DEBUG on dp_scorecard.Calc_Attendance_Score_PKG to MAXDAT_READ_ONLY;

grant DEBUG on dp_scorecard.Calc_Attendance_Score_PKG to DP_SCORECARD_READ_ONLY;

set serveroutput off;

exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10023);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10024);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10025);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10030);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10031);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10032);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10045);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10047);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10051);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10052);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10053);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10058);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10174);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10188);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10197);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10201);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10203);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10204);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10206);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10208);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10209);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10212);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10220);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10229);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10230);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10235);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10237);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10238);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10244);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10247);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10249);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10250);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10257);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10263);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10267);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10268);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10270);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10273);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10278);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10283);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10288);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10293);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10296);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10297);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10298);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10299);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10300);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10305);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10307);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10309);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10314);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10317);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10318);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10320);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10321);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10325);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10326);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10328);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10329);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10330);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10335);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10338);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10346);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10349);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10352);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10356);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10357);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10359);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10370);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10372);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10384);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10387);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10391);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10397);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10399);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10449);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10450);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10451);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10462);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10468);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10469);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10472);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10475);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10476);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10477);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10478);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10485);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10488);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10491);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10492);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10497);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10500);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10503);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10509);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10510);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10511);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10516);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10517);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10519);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10520);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10526);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10531);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10533);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10540);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10546);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10553);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10560);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10572);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10573);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10574);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10575);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10576);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10579);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10582);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10584);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10585);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10588);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10591);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10593);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10596);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10599);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10601);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10609);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10610);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10611);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10614);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10628);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10639);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10641);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10643);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10646);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10656);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10657);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10662);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10665);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10671);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10674);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10684);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10686);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10690);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10691);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10694);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10701);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10702);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10703);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10704);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10705);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10709);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10710);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10721);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10724);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10728);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10734);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10741);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10744);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10750);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10751);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10753);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10754);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10757);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10765);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10767);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10773);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10774);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10775);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10788);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10792);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10795);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10801);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10804);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10807);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10824);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10827);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10829);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10830);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10836);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10849);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10850);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10854);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10855);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10857);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10862);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10863);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10865);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10869);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10878);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10880);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10881);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10884);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10889);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10892);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10895);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10898);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10899);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10907);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10908);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10910);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10912);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10913);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10916);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10917);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10919);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10920);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10933);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10938);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10942);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10943);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10945);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10946);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10948);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10954);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10956);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10957);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10960);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10961);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10965);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10966);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10971);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10995);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(10999);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11000);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11002);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11005);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11010);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11013);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11015);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11019);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11029);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11033);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11036);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11038);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11039);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11042);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11052);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11053);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11057);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11060);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11072);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11074);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11075);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11076);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11077);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11078);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11082);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11085);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11086);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11091);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11093);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11094);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11096);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11104);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11105);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11107);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11114);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11116);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11118);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11121);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11125);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11130);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11134);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11145);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11150);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11157);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11161);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11163);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11171);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11178);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11179);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11181);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11187);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11188);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11192);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11195);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11197);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11199);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11200);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11206);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11209);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11212);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11215);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11217);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11220);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11221);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11222);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11223);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11224);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11228);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11238);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11244);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11247);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11248);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11251);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11257);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11258);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11260);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11265);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11267);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11269);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11271);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11273);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11274);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11276);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11280);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11291);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11296);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11297);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11299);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11300);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11302);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11306);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11311);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11312);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11314);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11315);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11316);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11318);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11323);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11327);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11334);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11336);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11338);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11339);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11344);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11347);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11348);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11350);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11353);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11363);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11365);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11366);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11369);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11392);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11393);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11402);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11404);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11406);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11407);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11409);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11418);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11423);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11435);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11438);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11439);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11441);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11444);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11447);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11449);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11452);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11453);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11454);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11458);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11467);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11482);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11489);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11491);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11494);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11499);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11501);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11514);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11523);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11529);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11536);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11542);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11548);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11552);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11555);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11563);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11578);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11581);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11584);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11595);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11596);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11599);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11601);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11613);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11625);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11634);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11635);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11644);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11647);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11648);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11649);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11657);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11659);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11660);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11677);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11678);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11681);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11685);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11686);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11690);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11691);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11694);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11698);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11703);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11712);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11722);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11733);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11735);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11736);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11740);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11746);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11748);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11758);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11763);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11771);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11772);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11778);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11780);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11781);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11784);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11785);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11787);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11789);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11791);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11792);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11795);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11798);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11803);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11812);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11813);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11814);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11815);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11818);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11821);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11822);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11824);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11827);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11835);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11844);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11845);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11849);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11858);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11860);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11866);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11871);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11873);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11877);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11878);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11879);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11883);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11884);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11885);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11889);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11901);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11903);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11907);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11912);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11917);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11919);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11923);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11924);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11932);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11935);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11940);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11947);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11949);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11971);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11980);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11984);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11989);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11990);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(11995);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12012);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12015);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12022);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12026);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12033);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12046);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12049);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12060);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12062);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12067);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12070);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12080);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12093);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12097);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12102);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12103);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12110);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12130);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12140);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12141);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12147);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12149);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12151);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12157);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12164);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12167);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12173);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12191);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12228);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12232);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12233);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12239);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12240);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12241);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12243);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12247);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12248);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12251);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12262);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12263);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12268);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12273);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12275);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12292);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12293);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12320);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12323);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12329);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12337);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12339);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12353);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12356);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12358);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12364);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12367);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12371);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12376);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12382);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12383);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12387);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12389);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12410);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12413);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12414);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12415);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12420);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12425);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12431);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12432);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12436);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12440);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12444);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12451);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12453);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12456);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12459);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12461);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12464);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12465);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12466);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12468);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12471);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12472);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12475);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12482);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12484);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12490);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12491);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12492);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12493);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12495);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12498);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12500);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12512);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12518);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12538);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12539);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12541);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12545);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12546);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12558);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12566);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12571);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12574);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12575);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12584);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12585);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12589);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12594);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12607);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12622);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12623);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12625);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12627);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12636);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12640);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12641);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12642);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12645);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12661);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12663);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12665);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12671);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12672);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12677);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12682);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12686);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12706);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12712);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12739);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12741);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12746);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12777);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12790);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12793);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12794);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12820);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12845);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12854);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12880);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12883);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12884);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12893);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12897);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12901);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12910);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12911);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12912);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12913);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12914);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12926);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12928);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12930);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12931);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12932);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12943);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12950);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12952);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12953);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12973);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12975);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12976);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12978);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12986);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(12992);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13001);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13005);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13008);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13019);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13020);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13026);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13028);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13031);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13032);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13034);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13036);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13037);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13043);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13044);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13047);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13057);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13058);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13068);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13072);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13083);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13084);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13085);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13087);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13095);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13096);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13099);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13106);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13108);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13112);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13113);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13114);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13116);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13117);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13118);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13131);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13132);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13134);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13150);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13169);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13175);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13181);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13214);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13217);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13225);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13227);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13230);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13231);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13249);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13253);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13258);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13260);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13261);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13268);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13273);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13274);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13276);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13282);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13283);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13285);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13287);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13293);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13329);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13342);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13343);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13346);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13347);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13356);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13358);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13363);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13401);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13402);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13404);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13405);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13407);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13409);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13411);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13412);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13430);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13439);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13440);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13444);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13459);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13468);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13471);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13472);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13473);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13475);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13482);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13489);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13490);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13491);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13495);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13509);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13514);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13535);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13537);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13540);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13543);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13547);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13554);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13571);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13573);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13584);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13618);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13630);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13632);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13647);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13649);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13657);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13658);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13663);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13689);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13690);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13691);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13712);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13714);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13725);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13735);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13744);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13745);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13747);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13748);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13754);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13755);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13756);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13760);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13761);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13765);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13771);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13773);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13776);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13783);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13784);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13816);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13838);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13840);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13846);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13866);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13889);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13891);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13901);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13906);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13920);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13925);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13928);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13930);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13937);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13941);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13945);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13950);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13955);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13956);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13960);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(13963);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14000);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14007);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14030);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14031);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14112);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14114);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14115);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14119);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14165);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14175);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14180);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14192);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14197);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14205);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14217);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14247);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14249);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14250);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14990);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(14992);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(1508);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(3452);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(3828);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(4316);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(6077);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(6606);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(6962);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(7182);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(7479);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(7886);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(7948);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(8111);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(8212);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(8242);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(8273);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(8286);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(8287);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(8292);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9153);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9155);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9161);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9163);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9184);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9188);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9202);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9212);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9215);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9219);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9221);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9232);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9238);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9251);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9268);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9269);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9275);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9280);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9284);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9285);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9289);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9290);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9291);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9292);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9302);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9304);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9307);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9309);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9310);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9318);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9320);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9322);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9404);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9406);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9407);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9409);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9410);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9412);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9887);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9888);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9896);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9899);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9900);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9901);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9902);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9909);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9910);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9914);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9917);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9919);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9924);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9926);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9929);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9931);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9932);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9934);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9938);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9939);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9942);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9943);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9945);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9951);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9954);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9955);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9970);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9973);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9976);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9979);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9981);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9986);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9987);
exec DP_SCORECARD.Calc_Attendance_Score_PKG.Calc_Attendance_Score(9988);

