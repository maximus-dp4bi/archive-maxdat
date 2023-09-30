create or replace Package              LOAD_SC_HIERARCHY_PKG_628 AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $';
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    Procedure LD_SC_HIERARCHY_STAFF;
    Procedure LD_SC_HIERARCHY_Staff_2_JOB;
    Procedure LD_SC_HIERARCHY_Supv_2_Staff;
	Procedure LD_SC_HIERARCHY_STAFF_2_OFFICE;
	Procedure LD_SC_HIERARCHY_STAFF_2_DEPT;
	Procedure LD_SC_HIERARCHY_SERVING_TEAM;
	Procedure Get_top_level;
	Procedure Process_Staff_id;
	Procedure Insert_Flat_Hierarchy;
	Procedure Fill_In_Values(P_STAFF_ID NUMBER, P_EFFECTIVE_DATE DATE);
	Procedure Replace_One_Record;
	Procedure Flag_Rehires;
	Procedure Delete_Promoted_Staff;
	Procedure Delete_Transferred_Staff;
	Procedure Set_Termination_date;
	Procedure Remove_ReHires;
	Procedure Load_SC_Hierarchy;

END LOAD_SC_HIERARCHY_PKG_628;
/

show errors

create or replace Package Body              LOAD_SC_HIERARCHY_PKG_628 AS

	GV_FLAT_REC       DP_SCORECARD.SCORECARD_HIERARCHY%ROWTYPE;

---------------------------------------------------
---------------------------------------------------
	Procedure Load_SC_Hierarchy IS
-----------------------------------------------------
-- This is the main procedure which runs all the others and
-- updates the SC_HIERARCHY table
-----------------------------------------------------
	BEGIN
        LD_SC_HIERARCHY_STAFF;
        LD_SC_HIERARCHY_Staff_2_Job;
        LD_SC_HIERARCHY_Supv_2_Staff;
        LD_SC_HIERARCHY_STAFF_2_OFFICE;
        LD_SC_HIERARCHY_STAFF_2_DEPT;
        LD_SC_HIERARCHY_SERVING_TEAM;
        Get_top_level;
        Process_Staff_id;
        Insert_Flat_Hierarchy;
		Delete_Promoted_Staff;
		Set_Termination_date;
		Delete_Transferred_Staff;
		Remove_ReHires;
	END;

---------------------------------------------------
---------------------------------------------------
    Procedure LD_SC_HIERARCHY_STAFF IS

	BEGIN
	---------------------------------------------------------------------------
	-- the MAXDAT.PP_WFM_STAFF table is not really 'clean'
	-- This procedure produces a cleadned up version of the staff_table
	-- There are instances where a single NATIONAL_ID has more than 1 STAFF_ID
	-- This is primarily due to 're-hires'
	---------------------------------------------------------------------------
    Execute Immediate 'Truncate TABLE DP_SCORECARD.SC_HIERARCHY_STAFF';

    INSERT INTO DP_SCORECARD.SC_HIERARCHY_STAFF
    (
    STAFF_ID, NATIONAL_ID, LAST_NAME,
    FIRST_NAME, MIDDLE_NAME, SUFFIX,
    HIRE_DATE, TERMINATION_DATE, SCHEDULE_TYPE,
   --DELETE_DATE,
    SENIORITY_EFFECTIVE_DATE, OWNER_USER,
    MODIFY_USER, OWNER_DATE, MODIFY_DATE,
    EMAIL_ADDRESS, COMMAND_SCRIPT, MESSAGE_BUFFER,
    SECONDARY_ID, ADDRESS, WORK_PHONE,
    HOME_PHONE, TERMINATION_POLICY_ID, TERMINATION_REASON,
    PIP_ADDRESS, TEXT_ADDRESS, CELL_PHONE,
    EXTRACT_DT, LAST_UPDATE_DT, LAST_UPDATED_BY
   )
    SELECT
    STAFF_ID, NATIONAL_ID, LAST_NAME,
    FIRST_NAME, MIDDLE_NAME, SUFFIX,
    HIRE_DATE, TERMINATION_DATE, SCHEDULE_TYPE,
    --DELETE_DATE,
    SENIORITY_EFFECTIVE_DATE, OWNER_USER,
    MODIFY_USER, OWNER_DATE, MODIFY_DATE,
    EMAIL_ADDRESS, COMMAND_SCRIPT, MESSAGE_BUFFER,
    SECONDARY_ID, ADDRESS, WORK_PHONE,
    HOME_PHONE, TERMINATION_POLICY_ID, TERMINATION_REASON,
    PIP_ADDRESS, TEXT_ADDRESS, CELL_PHONE,
    EXTRACT_DT, LAST_UPDATE_DT, LAST_UPDATED_BY
    FROM MAXDAT.PP_WFM_STAFF
WHERE DELETE_DATE IS NULL
AND  ( NATIONAL_ID, TRUNC(NVL(TERMINATION_DATE,SYSDATE)) )
IN
    ( -- get the last date for each national_id
    SELECT NATIONAL_ID, MAX(TRUNC(NVL(TERMINATION_DATE,SYSDATE))) LAST_DATE
    FROM MAXDAT.PP_WFM_STAFF STAFF
	WHERE DELETE_DATE IS NULL
	AND DELETE_DETECTED_DATE IS NULL
    GROUP BY NATIONAL_ID
    )
AND ( STAFF_ID, TRUNC(NVL(TERMINATION_DATE,SYSDATE)) )
IN (
    SELECT STAFF_ID, MAX(TRUNC(NVL(TERMINATION_DATE,SYSDATE))) LAST_DATE
    FROM MAXDAT.PP_WFM_STAFF STAFF
	WHERE DELETE_DATE IS NULL
	AND DELETE_DETECTED_DATE IS NULL
    GROUP BY STAFF_ID
	)
AND dp_scorecard.RETURN_NUMERIC(NATIONAL_ID) is not null;

	COMMIT;

	END;

-------------------------------------------------------------
-------------------------------------------------------------
--DROP TABLE DP_SCORECARD.SC_HIERARCHY_JOB_LEVEL_LKUP;
--
--CREATE TABLE DP_SCORECARD.SC_HIERARCHY_JOB_LEVEL_LKUP
--AS
--SELECT DISTINCT JOB_LEVEL, JOB_CODE, TRUNC(owner_date) AS OWNER_DATE, delete_date  --, JOB_TITLE
--FROM (
--    SELECT '6' AS JOB_LEVEL, JOB_CLASSIFICATION_CODE_ID AS JOB_CODE, CODE AS JOB_TITLE, owner_date, delete_date
--    FROM DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV
--    WHERE CODE IN ('Sr. Director')
--   -- AND ( TRUNC(SYSDATE) BETWEEN TRUNC(OWNER_DATE) AND TRUNC(NVL(DELETE_DATE,SYSDATE))
--    union
--    SELECT '5' AS CODE_LVL, JOB_CLASSIFICATION_CODE_ID, CODE, owner_date, delete_date
--    FROM DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV
--    WHERE CODE IN ('Director')
--   -- AND ( TRUNC(SYSDATE) BETWEEN TRUNC(OWNER_DATE) AND TRUNC(NVL(DELETE_DATE,SYSDATE))
--    UNION
--    SELECT '4' AS CODE_LVL, JOB_CLASSIFICATION_CODE_ID, CODE, owner_date, delete_date
--    FROM DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV
--    WHERE CODE IN ('Sr. Manager')
--   -- AND ( TRUNC(SYSDATE) BETWEEN TRUNC(OWNER_DATE) AND TRUNC(NVL(DELETE_DATE,SYSDATE))
--    UNION
--    SELECT '3' AS CODE_LVL, JOB_CLASSIFICATION_CODE_ID, CODE, owner_date, delete_date
--    FROM  DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV
--    WHERE JOB_CLASSIFICATION_CODE_ID IN (1057,1018,1044)
--   -- AND ( TRUNC(SYSDATE) BETWEEN TRUNC(OWNER_DATE) AND TRUNC(NVL(DELETE_DATE,SYSDATE))
--    UNION
--    SELECT '2' AS CODE_LVL, JOB_CLASSIFICATION_CODE_ID, CODE, owner_date, delete_date
--    FROM  DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV
--    WHERE JOB_CLASSIFICATION_CODE_ID IN (1058,1031)
--   -- AND ( TRUNC(SYSDATE) BETWEEN TRUNC(OWNER_DATE) AND TRUNC(NVL(DELETE_DATE,SYSDATE))
--    UNION
--    SELECT '1' AS CODE_LVL, JOB_CLASSIFICATION_CODE_ID, CODE, owner_date, delete_date
--    FROM  DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV
--    WHERE JOB_CLASSIFICATION_CODE_ID
--	IN ('1068','1059','1054','1053','1024','1011','1010','1009','1008','1043','1019','1013','1012',
--	    '1056','1047','1028','1025','1061','1032','1033','1060','1039','1063','1038','1037','1035',
--		'1052','1030','1022','1020','1046','1055','1026','1023','1027','1045','1051','1050','1049',
--		'1048','1017','1016','1015','1014','1082'
--		)
--   -- AND ( TRUNC(SYSDATE) BETWEEN TRUNC(OWNER_DATE) AND TRUNC(NVL(DELETE_DATE,SYSDATE))
--    );
-------------------------------------------------------------
-------------------------------------------------------------


    Procedure LD_SC_HIERARCHY_Staff_2_JOB IS

	BEGIN
	---------------------------------------------------------------------------
	-- the DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION has an overlap between the
	-- end if one job and the beginnec of the next. (usually end and start )
	-- This procedure produces a cleadned up version of the table
	-- with an adjusted end_date
	---------------------------------------------------------------------------

	EXECUTE IMMEDIATE 'TRUNCATE TABLE DP_SCORECARD.SC_HIERARCHY_STAFF_TO_JOB';

    INSERT INTO DP_SCORECARD.SC_HIERARCHY_STAFF_TO_JOB
    ( STAFF_ID, START_DATE, END_DATE,
        ADJUSTED_END_DATE, JOB_CODE, JOB_LEVEL,
        POSITION
    )
	SELECT STAFF_JOBS.STAFF_ID, TRUNC(STAFF_JOBS.START_DATE) AS START_DATE,
	TRUNC(STAFF_JOBS.END_DATE) AS END_DATE,
    CASE
            WHEN TRUNC(E.START_DATE) = TRUNC(STAFF_JOBS.END_DATE)
            THEN TRUNC(E.START_DATE-1)
            ELSE TRUNC(NVL(STAFF_JOBS.END_DATE,SYSDATE))
            END
    AS ADJUSTED_END_DATE,
	STAFF_JOBS.JOB_CODE, LKP.JOB_LEVEL, P.POSITION
    FROM ( SELECT STAFF_ID, TRUNC(START_DATE) AS START_DATE,
                JOB_CLASSIFICATION_CODE_ID AS JOB_CODE,
                TRUNC(END_DATE) AS END_DATE
            FROM DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION
            WHERE NVL(DELETE_FLAG,'N') = 'N' ) STAFF_JOBS
    LEFT OUTER JOIN
        ( SELECT STAFF_ID, TRUNC(START_DATE) AS START_DATE,
                JOB_CLASSIFICATION_CODE_ID AS JOB_CODE,
                TRUNC(END_DATE) AS END_DATE
           FROM DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION
           WHERE NVL(DELETE_FLAG,'N') = 'N' ) E
        ON STAFF_JOBS.STAFF_ID = E.STAFF_ID AND TRUNC(E.START_DATE) = TRUNC(STAFF_JOBS.END_DATE)
    JOIN ( SELECT *
            FROM DP_SCORECARD.SC_HIERARCHY_JOB_LEVEL_LKUP
            WHERE DELETE_DATE IS NULL
         ) LKP
        ON LKP.JOB_CODE = STAFF_JOBS.JOB_CODE
        AND TRUNC(STAFF_JOBS.START_DATE) <= TRUNC(NVL(LKP.END_DATE,SYSDATE))
        AND TRUNC(NVL(STAFF_JOBS.END_DATE,SYSDATE)) >= TRUNC(NVL(LKP.EFFECTIVE_DATE,SYSDATE))
    JOIN (SELECT JOB_CLASSIFICATION_CODE_ID, CODE AS POSITION
          FROM DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_CODE
          WHERE DELETE_DATE IS NULL
          ) P
    ON P.JOB_CLASSIFICATION_CODE_ID = LKP.JOB_CODE;

    COMMIT;

	END;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

Procedure LD_SC_HIERARCHY_STAFF_2_OFFICE IS

BEGIN

	---------------------------------------------------------------------------
	-- the DP_SCORECARD.PP_WFM_STAFF_TO_OFFICE has an overlap between the
	-- end OF one OFFICE assignment and the beginning of the next. (usually end and start )
	-- This procedure produces a cleaned up version of the table
	-- with an adjusted end_date
	---------------------------------------------------------------------------

	EXECUTE IMMEDIATE 'TRUNCATE TABLE DP_SCORECARD.SC_HIERARCHY_STAFF_to_OFFICE';

	INSERT INTO SC_HIERARCHY_STAFF_TO_OFFICE
	( STAFF_ID,
		EFFECTIVE_DATE,
		OFFICE_ID,
		OFFICE,
		BUILDING,
		END_DATE,
		ADJUSTED_END_DATE
	)
	SELECT S.STAFF_ID, TRUNC(S.EFFECTIVE_DATE) AS EFFECTIVE_DATE,
	S.OFFICE_ID, O.NAME AS OFFICE,
	NVL(OBL.BUILDING,'Undefined') AS BUILDING,
	TRUNC(S.END_DATE) AS END_DATE,
    CASE
            WHEN TRUNC(E.EFFECTIVE_DATE) = TRUNC(S.END_DATE)
            THEN TRUNC(E.EFFECTIVE_DATE-1)
            ELSE TRUNC(NVL(S.END_DATE,SYSDATE))
            END
    AS ADJUSTED_END_DATE
    FROM ( SELECT STAFF_ID, TRUNC(EFFECTIVE_DATE) AS EFFECTIVE_DATE,
                OFFICE_ID,
                TRUNC(END_DATE) AS END_DATE
            FROM DP_SCORECARD.PP_WFM_STAFF_TO_OFFICE_SV
            WHERE NVL(DELETE_FLAG,'N') = 'N' ) S
    LEFT OUTER JOIN
        ( SELECT STAFF_ID, TRUNC(EFFECTIVE_DATE) AS EFFECTIVE_DATE,
                OFFICE_ID,
                TRUNC(END_DATE) AS END_DATE
           FROM DP_SCORECARD.PP_WFM_STAFF_TO_OFFICE_SV
           WHERE NVL(DELETE_FLAG,'N') = 'N' ) E
        ON S.STAFF_ID = E.STAFF_ID AND TRUNC(E.EFFECTIVE_DATE) = TRUNC(S.END_DATE)
    JOIN
		( SELECT * FROM DP_SCORECARD.PP_WFM_OFFICE
            WHERE DELETE_DATE IS NULL
		) O
        ON S.OFFICE_ID = O.OFFICE_ID
	LEFT OUTER JOIN
		( -- OFFICE BUILDING LOCATION
            SELECT DISTINCT OFFICE, BUILDING
            FROM DP_SCORECARD.SCORECARD_OFFICE_BUILDING_LKUP
            WHERE OFFICE IN
                (   SELECT OFFICE --<< ENSURE YOU DON'T GET MULTIPLE ROWS
                    FROM DP_SCORECARD.SCORECARD_OFFICE_BUILDING_LKUP
                    GROUP BY OFFICE
                    HAVING SUM(1) = 1
                )
        ) OBL
		ON O.NAME = OBL.OFFICE;

    COMMIT;

END;

--------------------------------------------------------------------------------
    Procedure LD_SC_HIERARCHY_SUPV_2_STAFF IS

	BEGIN
	---------------------------------------------------------------------------
	-- the MAXDAT.PP_WFM_SUPERVISOR_TO_STAFF has an overlap between the
	-- end if one job and the beginnec of the next. (usually end and start )
	-- This procedure produces a cleadned up version of the table
	-- with an adjusted end_date
	---------------------------------------------------------------------------


	EXECUTE IMMEDIATE 'TRUNCATE TABLE DP_SCORECARD.SC_HIERARCHY_STAFF_TO_STAFF';

    INSERT INTO SC_HIERARCHY_STAFF_TO_STAFF
    (
    STAFF_ID,
    STAFF_NATID,
	SUPERVISOR_ID,
	SUPERVISOR_NATID,
	EFFECTIVE_DATE,
	LAST_UPDATE_DT,
	END_DATE,
	TERMINATION_DATE,
    ADJUSTED_END_DATE,
    E_STAFF_ID,
    E_SUPERVISOR_ID,
    E_EFFECTIVE_DATE,
    E_END_DATE,
    E_LAST_UPDATE_DT
	)
    SELECT
        S_STAFF_ID          AS STAFF_ID,
        S_STAFF_NATID       AS STAFF_NATID,
        S_SUPERVISOR_ID     AS SUPERVISOR_ID,
        S_SUPERVISOR_NATID  AS SUPERVISOR_NATID,
        S_EFFECTIVE_DATE    AS EFFECTIVE_DATE,
        S_LAST_UPDATE_DT    AS LAST_UPDATE_DT,
        S_END_DATE          AS END_DATE,
        S_TERMINATION_DATE  AS TERMINATION_DATE,
        ADJUSTED_END_DATE,
        E_STAFF_ID,
        E_SUPERVISOR_ID,
        E_EFFECTIVE_DATE,
        E_END_DATE,
        E_LAST_UPDATE_DT
    FROM (
    WITH LAST_UPDATES
    AS
	(	SELECT S2S.STAFF_ID, S2S.SUPERVISOR_ID, TRUNC(S2S.EFFECTIVE_DATE) AS EFFECTIVE_DATE, TRUNC(S2S.END_DATE) AS END_DATE, S2S.LAST_UPDATE_DT
		FROM MAXDAT.PP_WFM_SUPERVISOR_TO_STAFF S2S
        WHERE (S2S.STAFF_ID, S2S.EFFECTIVE_DATE, S2S.LAST_UPDATE_DT )
			IN  (
				SELECT  STAFF_ID, EFFECTIVE_DATE, MAX(LAST_UPDATE_DT)
                FROM MAXDAT.PP_WFM_SUPERVISOR_TO_STAFF
                WHERE NVL(DELETE_FLAG,'N') = 'N'
             --   AND STAFF_ID = 1311
                GROUP BY STAFF_ID, EFFECTIVE_DATE
                )
        AND NVL(DELETE_FLAG,'N') = 'N'
    )
    SELECT S_STAFF_ID, S_STAFF_NATID, S_SUPERVISOR_ID, S_SUPERVISOR_NATID,
        S_EFFECTIVE_DATE, S_LAST_UPDATE_DT, S_END_DATE,  S_TERMINATION_DATE, ADJUSTED_END_DATE,
        E_STAFF_ID, E_SUPERVISOR_ID, E_EFFECTIVE_DATE, E_END_DATE, E_LAST_UPDATE_DT
    FROM (
        SELECT S_STAFF_ID, S_STAFF_NATID, S_SUPERVISOR_ID, S_SUPERVISOR_NATID, TRUNC(S_EFFECTIVE_DATE) AS S_EFFECTIVE_DATE, S_END_DATE, S_LAST_UPDATE_DT, S_TERMINATION_DATE,
            E_STAFF_ID, E_SUPERVISOR_ID, TRUNC(E_EFFECTIVE_DATE) AS E_EFFECTIVE_DATE, E_END_DATE, E_LAST_UPDATE_DT,
            CASE
                WHEN S_EFFECTIVE_DATE = S_END_DATE
                    THEN S_END_DATE
                WHEN E_EFFECTIVE_DATE = S_END_DATE
                    THEN E_EFFECTIVE_DATE-1
            WHEN S_END_DATE IS NULL
                THEN TRUNC(NVL(S_TERMINATION_DATE,SYSDATE))
            WHEN E_EFFECTIVE_DATE IS NULL
                THEN S_END_DATE
            END AS ADJUSTED_END_DATE
        FROM ( 	SELECT L.STAFF_ID AS S_STAFF_ID, STAFF.NATIONAL_ID AS S_STAFF_NATID,
                L.SUPERVISOR_ID AS S_SUPERVISOR_ID, SUPERVISOR.NATIONAL_ID AS S_SUPERVISOR_NATID,
                TRUNC(L.EFFECTIVE_DATE) AS S_EFFECTIVE_DATE,
                L.END_DATE AS S_END_DATE, L.LAST_UPDATE_DT AS S_LAST_UPDATE_DT, STAFF.TERMINATION_DATE AS S_TERMINATION_DATE
            FROM LAST_UPDATES L
            JOIN SC_HIERARCHY_STAFF STAFF ON STAFF.STAFF_ID = L.STAFF_ID
            JOIN SC_HIERARCHY_STAFF SUPERVISOR ON SUPERVISOR.STAFF_ID = L.SUPERVISOR_ID
            ) S
        LEFT OUTER JOIN
            (
            SELECT STAFF_ID AS E_STAFF_ID, SUPERVISOR_ID AS E_SUPERVISOR_ID,
                TRUNC(EFFECTIVE_DATE) AS E_EFFECTIVE_DATE, END_DATE AS E_END_DATE,
                LAST_UPDATE_DT AS E_LAST_UPDATE_DT
            FROM LAST_UPDATES
            ) E
            ON S.S_STAFF_ID = E.E_STAFF_ID
            AND E.E_EFFECTIVE_DATE = S.S_END_DATE
    --
    )
    WHERE 1=1
    AND S_EFFECTIVE_DATE <= ADJUSTED_END_DATE
    --ORDER BY S_EFFECTIVE_DATE, S_LAST_UPDATE_DT
	);

    COMMIT;

	END;


--------------------------------------------------------
-- STAFF_TO_DEPARTMENT
--------------------------------------------------------

Procedure LD_SC_HIERARCHY_STAFF_2_DEPT IS
BEGIN

	EXECUTE IMMEDIATE 'TRUNCATE TABLE DP_SCORECARD.SC_HIERARCHY_STAFF_TO_DEPT';

    INSERT INTO DP_SCORECARD.SC_HIERARCHY_STAFF_TO_DEPT
    (
    STAFF_ID, START_DATE, END_DATE,
    ADJUSTED_END_DATE, DEPARTMENT
    )
    WITH STAFF_DEP
    AS (   -- STAFF_DEPARTMENT
             SELECT STD.STAFF_ID,
                 TRUNC(STD.EFFECTIVE_DATE)  AS START_DATE,
                 TRUNC(STD.END_DATE)        AS END_DATE,
                 D.NAME                     AS DEPARTMENT
             FROM DP_SCORECARD.PP_WFM_STAFF_TO_DEPARTMENT  STD
             JOIN DP_SCORECARD.PP_WFM_DEPARTMENT D
             ON STD.DEPARTMENT_ID = D.DEPARTMENT_ID
             WHERE 1=1
            -- AND STD.STAFF_ID = 4747
 			AND NVL(STD.DELETE_FLAG,'N') = 'N'
             GROUP BY STD.STAFF_ID, TRUNC(STD.EFFECTIVE_DATE), TRUNC(STD.END_DATE), D.NAME
             HAVING SUM(1) = 1
         )
        SELECT S.STAFF_ID, TRUNC(S.START_DATE) AS START_DATE,
            TRUNC(S.END_DATE) AS END_DATE,
            CASE
                WHEN TRUNC(E.START_DATE) = TRUNC(S.END_DATE)
                THEN TRUNC(E.START_DATE-1)
                ELSE TRUNC(NVL(S.END_DATE,SYSDATE))
            END
                AS ADJUSTED_END_DATE,
            DEPARTMENT
        FROM
            (   SELECT STAFF_ID, TRUNC(START_DATE) AS START_DATE,
                    TRUNC(END_DATE) AS END_DATE,
                    DEPARTMENT AS DEPARTMENT
                FROM STAFF_DEP
            ) S
    LEFT OUTER JOIN
            (   SELECT STAFF_ID, TRUNC(START_DATE) AS START_DATE,
                    TRUNC(END_DATE) AS END_DATE
               -- DEPARTMENT      AS E_DEPARTMENT
            FROM STAFF_DEP
            ) E
    ON S.STAFF_ID = E.STAFF_ID AND TRUNC(E.START_DATE) = TRUNC(S.END_DATE);

    COMMIT;


END;

-------------------------------------------------------
-------------------------------------------------------

PROCEDURE LD_SC_HIERARCHY_SERVING_TEAM IS

BEGIN

	EXECUTE IMMEDIATE 'TRUNCATE TABLE DP_SCORECARD.SC_HIERARCHY_SERVING_TEAM';


    INSERT INTO DP_SCORECARD.SC_HIERARCHY_SERVING_TEAM
        ( STAFF_ID, HIERARCHY_RUN_DATE, EVENT_ID, EVENT_NAME)
    WITH SERVING_TEAM_EVENT AS
    ( SELECT DISTINCT
        EVENT_ID,
        NAME AS EVENT_NAME
	FROM MAXDAT.PP_WFM_EVENT
	WHERE DELETE_DATE IS NULL
	AND EVENT_TYPE_ID IN (1,2,8)
    ),
    SERVING_TEAM_DETAILS AS
    ( SELECT PP_WFM_STAFF_ELIGIBILITY.STAFF_ID, PP_WFM_STAFF_ELIGIBILITY.EVENT_ID, SERVING_TEAM_EVENT.EVENT_NAME,
		TRUNC(START_DATE) AS START_DATE,
		TRUNC(NVL(END_DATE,SYSDATE)) AS END_DATE
    FROM PP_WFM_STAFF_ELIGIBILITY
	JOIN SERVING_TEAM_EVENT
	ON 	SERVING_TEAM_EVENT.EVENT_ID = PP_WFM_STAFF_ELIGIBILITY.EVENT_ID
	WHERE NVL(DELETE_FLAG,'N') = 'N'
	AND  SCHEDULING_PRIORITY = 1
    ),
    SERVING_TEAM_DATES AS
    ( SELECT STAFF_ID, START_DATE, END_DATE
        FROM SERVING_TEAM_DETAILS
    ),
    ADJUSTED_DATES AS
    ( 	SELECT DISTINCT S.STAFF_ID, S.START_DATE, S.END_DATE,
            CASE
                WHEN E.START_DATE = S.END_DATE
                THEN E.START_DATE-1
                ELSE TRUNC(NVL(S.END_DATE,SYSDATE))
            END                 AS ADJUSTED_END_DATE
        FROM
            (   SELECT STAFF_ID, START_DATE, END_DATE
                FROM SERVING_TEAM_DATES
            ) S
        LEFT OUTER JOIN
            (   SELECT STAFF_ID, START_DATE, END_DATE
            FROM SERVING_TEAM_DATES
            ) E
        ON S.STAFF_ID = E.STAFF_ID AND E.START_DATE = S.END_DATE
    )
    SELECT DISTINCT SC_HIERARCHY_STAFF.STAFF_ID,
        TRUNC(NVL(SC_HIERARCHY_STAFF.TERMINATION_DATE, SYSDATE)) AS HIERARCHY_RUN_DATE,
        SERVING_TEAM_DETAILS.EVENT_ID,
        SERVING_TEAM_DETAILS.EVENT_NAME
    FROM SC_HIERARCHY_STAFF
    JOIN ADJUSTED_DATES
        ON ADJUSTED_DATES.STAFF_ID = SC_HIERARCHY_STAFF.STAFF_ID
        AND TRUNC(NVL(TERMINATION_DATE, SYSDATE))
            BETWEEN ADJUSTED_DATES.START_DATE AND ADJUSTED_DATES.END_DATE
    JOIN SERVING_TEAM_DETAILS
    ON SERVING_TEAM_DETAILS.STAFF_ID = ADJUSTED_DATES.STAFF_ID
    AND SERVING_TEAM_DETAILS.START_DATE = ADJUSTED_DATES.START_DATE
    AND SERVING_TEAM_DETAILS.END_DATE = ADJUSTED_DATES.END_DATE;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN RAISE;

END;

-----------------------------------------------------
-- set up a cursor to get the 'Top' of the hierarchy
-----------------------------------------------------
	Procedure Get_top_level IS
	BEGIN
		Null;
	END;

	Procedure Process_Staff_id IS

	-----------------------------------------------------
	-- Set up a cursor to get all the lowest level staff members
	-- (terminated or active) .. use trunc(NVL(termination_date,sysdate))
	-- to identify the date to which the hierarcy applies (Hierarchy effective date )
	-----------------------------------------------------

	CURSOR STAFF_CSR IS
    SELECT STAFF_ID, START_DATE, JOB_CODE, JOB_LEVEL, END_DATE, ADJUSTED_END_DATE, POSITION
    FROM DP_SCORECARD.SC_HIERARCHY_STAFF_TO_JOB
    WHERE (STAFF_ID, ADJUSTED_END_DATE )
    IN (
        SELECT STAFF_ID, MAX(ADJUSTED_END_DATE) LAST_DATE
        FROM DP_SCORECARD.SC_HIERARCHY_STAFF_TO_JOB
        GROUP BY STAFF_ID)
    AND JOB_CODE
    IN (
        SELECT JOB_CODE
        FROM DP_SCORECARD.SC_HIERARCHY_JOB_LEVEL_LKUP
        WHERE JOB_LEVEL
        IN (
            SELECT MIN(JOB_LEVEL)
            FROM DP_SCORECARD.SC_HIERARCHY_JOB_LEVEL_LKUP
            )
        )
    ORDER BY 3 DESC;

	STAFF_REC   STAFF_CSR%ROWTYPE;


	-----------------------------------------------------
	-- for each staff member run a connect by from the
	-- bottom to the top (path UP)
	-- using the LAST_HIERARCHY_DATE for each staff Member
	-- and load them into a 'work table'
	-----------------------------------------------------

	BEGIN

		EXECUTE IMMEDIATE 'TRUNCATE TABLE DP_SCORECARD.SC_HIERARCHY_STAFF_2_STAFF_WRK';


	IF (STAFF_CSR%ISOPEN)
		THEN
			CLOSE STAFF_CSR;
	END IF;

	OPEN STAFF_CSR();

	LOOP

		FETCH STAFF_CSR INTO STAFF_REC;

		EXIT WHEN STAFF_CSR%NOTFOUND;

--		DBMS_OUTPUT.PUT_LINE('STAFF_ID = '||STAFF_REC.STAFF_ID||' JOB_CODE: '||STAFF_REC.job_code||' DATE: '||STAFF_REC.ADJUSTED_END_DATE);

		INSERT INTO DP_SCORECARD.SC_HIERARCHY_STAFF_2_STAFF_WRK
			(
            CYCLE_ERROR,
            ROOT_STAFF_ID,
            STAFF_ID,
            STAFF_NATID,
            EFFECTIVE_DATE,
            ADJUSTED_END_DATE,
            SUPERVISOR_ID,
            SUPERVISOR_NATID,
            FIRST_NAME,
            LAST_NAME,
            HIRE_DATE,
            TERMINATION_DATE,
            LVL,
            JOB_CODE,
			JOB_LEVEL,
			POSITION
			)
    SELECT  CONNECT_BY_ISCYCLE CYCLE_ERROR,
            CONNECT_BY_ROOT STAFF_ID ROOT_STAFF_ID,
            X.STAFF_ID, X.STAFF_NATID,
            X.EFFECTIVE_DATE, X.ADJUSTED_END_DATE, X.SUPERVISOR_ID, X.SUPERVISOR_NATID,
            X.FIRST_NAME, X.LAST_NAME, X.HIRE_DATE, X.TERMINATION_DATE, LEVEL AS LVL,
			X.JOB_CODE, X.JOB_LEVEL, X.POSITION
    FROM ( SELECT S2S.STAFF_ID, S2S.STAFF_NATID, S2S.SUPERVISOR_ID, S2S.SUPERVISOR_NATID,
                S2S.EFFECTIVE_DATE, S2S.ADJUSTED_END_DATE,
				S.FIRST_NAME, S.LAST_NAME, S.HIRE_DATE, S.TERMINATION_DATE,
				JC.JOB_CODE, JC.JOB_LEVEL, JC.POSITION
            FROM DP_SCORECARD.SC_HIERARCHY_STAFF_TO_STAFF S2S
            JOIN DP_SCORECARD.SC_HIERARCHY_STAFF_TO_JOB JC
                ON JC.STAFF_ID = S2S.STAFF_ID
                AND STAFF_REC.ADJUSTED_END_DATE BETWEEN JC.START_DATE AND JC.ADJUSTED_END_DATE
            LEFT OUTER JOIN DP_SCORECARD.SC_HIERARCHY_STAFF S
                ON S.STAFF_ID = S2S.STAFF_ID
            WHERE STAFF_REC.ADJUSTED_END_DATE BETWEEN S2S.EFFECTIVE_DATE AND S2S.ADJUSTED_END_DATE
        ) X
	CONNECT BY NOCYCLE X.STAFF_ID = PRIOR X.SUPERVISOR_ID
	START WITH STAFF_ID = STAFF_REC.STAFF_ID
	--4156 --1965 --9356 --1283 --1291 10130 --13352 --4156 --3146
	ORDER BY LEVEL, EFFECTIVE_DATE;



	END loop;

	COMMIT;

	IF (STAFF_CSR%ISOPEN)
		THEN
			CLOSE STAFF_CSR;
	END IF;

 END;

--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------
	Procedure Insert_Flat_Hierarchy IS
	-----------------------------------------------------
	-----------------------------------------------------
	-----------------------------------------------------
	-- Note: A National_id may be tied to multiple staff_ids but
	-- a single staff_id can have only 1 National_id.
	-- When a National_id has multiple Staff_ids only the
	-- latest staff_id record applies.
	----------------------------------------------------

	CURSOR S2S_CSR IS
	SELECT ROOT_STAFF_ID,
		LVL,
		CYCLE_ERROR,
		STAFF_ID,
		STAFF_NATID,
		JOB_CODE,
		JOB_LEVEL,
		EFFECTIVE_DATE, ADJUSTED_END_DATE,
		FIRST_NAME,
		LAST_NAME,
		TERMINATION_DATE,
		--
		CASE WHEN UPPER(LAST_NAME) = 'PLACEHOLDER'
		AND 1=2     -- 5/14/2018 PER REQUEST DO NOT PUSH DOWN THE NAME
			THEN NULL
			ELSE SUPERVISOR_ID
		END                     AS SUPERVISOR_ID,
        --
		POSITION
	FROM DP_SCORECARD.SC_HIERARCHY_STAFF_2_STAFF_WRK
	WHERE LVL <= 6
	ORDER BY ROOT_STAFF_ID, LVL DESC;

	S2S_REC   		    S2S_CSR%ROWTYPE;
	PREV_S2S_REC   		S2S_CSR%ROWTYPE;


	LV_HOLD_ROOT_ID         NUMBER(12) := 0;

	LV_STAFF_COUNT         NUMBER(12) := 0;


	-----------------------------------------------------
	-- FETCH THE ROOT_STAFF_ID ROWS IN SC_HIERARCHY_STAFF_2_STAFF_WRK
	-- IN DESCENDING LVL ORDER.
	-- USE THE LVL TO DETERMING WHICH COLUMNS TO LOAD IN THE 'FLAT' RECORD.
	-- IF THE SUPERVISOR_ID IS NULL THEN USE THE SUPERFISOR_ID
	-- FROM THE PRIOR RECORD.
	-----------------------------------------------------

	BEGIN

	IF (S2S_CSR%ISOPEN)
		THEN
			CLOSE S2S_CSR;
	END IF;

	OPEN S2S_CSR;

	LOOP

	FETCH S2S_CSR INTO S2S_REC;

    EXIT WHEN S2S_CSR%NOTFOUND;

--	IF LV_Hold_root_id between 14226 and 14235
--	or S2S_REC.ROOT_STAFF_ID between 14226 and 14235
--	then
--        DBMS_OUTPUT.PUT_LINE( 'Loop LV_Hold_root_id: '||LV_Hold_root_id
--            || ' S2S_REC.ROOT_STAFF_ID: '||S2S_REC.ROOT_STAFF_ID
--            ||' LVL: '||S2S_REC.LVL);
--	end if;

		IF LV_HOLD_ROOT_ID <> S2S_REC.ROOT_STAFF_ID
		AND S2S_REC.LVL = 6
			THEN
				-- ONLY CHANGE THE 'HOLD' VALUE ON A BREAK
				-- AND WHERE THE RECORD CAUSING THE BREAK IS LVL = 6

--					IF LV_Hold_root_id between 14226 and 14235
--					or S2S_REC.ROOT_STAFF_ID between 14226 and 14235
--					then
--						DBMS_OUTPUT.PUT_LINE( 'BREAK LV_Hold_root_id: '||LV_Hold_root_id
--						|| ' S2S_REC.ROOT_STAFF_ID: '||S2S_REC.ROOT_STAFF_ID
--						||' LVL: '||S2S_REC.LVL);
--					end if;


			FILL_IN_Values(GV_FLAT_REC.STAFF_STAFF_ID, TO_DATE(TRUNC(NVL(GV_FLAT_REC.TERMINATION_DATE,SYSDATE))));
			REPLACE_ONE_RECORD;

			LV_HOLD_ROOT_ID := S2S_REC.ROOT_STAFF_ID;
		--		PREV_S2S_REC    := S2S_REC;

		END IF;

		IF S2S_REC.ROOT_STAFF_ID = LV_HOLD_ROOT_ID
		THEN -- FLATTEN THE RECORD
			IF S2S_REC.LVL = 6
				THEN
					GV_FLAT_REC.SR_DIRECTOR_STAFF_ID   := S2S_REC.STAFF_ID;
					GV_FLAT_REC.SR_DIRECTOR_NATID      := S2S_REC.STAFF_NATID;
					GV_FLAT_REC.SR_DIRECTOR_NAME 	    := S2S_REC.LAST_NAME||', '||S2S_REC.FIRST_NAME;
			ELSIF S2S_REC.LVL = 5
				THEN
					IF S2S_REC.SUPERVISOR_ID IS NOT NULL
					THEN
						GV_FLAT_REC.DIRECTOR_STAFF_ID  := S2S_REC.STAFF_ID;
                        GV_FLAT_REC.DIRECTOR_NATID     := S2S_REC.STAFF_NATID;
						GV_FLAT_REC.DIRECTOR_NAME 	    := S2S_REC.LAST_NAME||', '||S2S_REC.FIRST_NAME;
					ELSE
						GV_FLAT_REC.DIRECTOR_STAFF_ID  := GV_FLAT_REC.SR_DIRECTOR_STAFF_ID;
                        GV_FLAT_REC.DIRECTOR_NATID     := GV_FLAT_REC.SR_DIRECTOR_NATID;
						GV_FLAT_REC.DIRECTOR_NAME      := GV_FLAT_REC.SR_DIRECTOR_NAME;
					END IF;

			ELSIF S2S_REC.LVL = 4
				THEN
					IF S2S_REC.SUPERVISOR_ID IS NOT NULL
					THEN
						GV_FLAT_REC.SR_MANAGER_STAFF_ID    := S2S_REC.STAFF_ID;
                        GV_FLAT_REC.SR_MANAGER_NATID       := S2S_REC.STAFF_NATID;
						GV_FLAT_REC.SR_MANAGER_NAME 	    := S2S_REC.LAST_NAME||', '||S2S_REC.FIRST_NAME;
					ELSE
						GV_FLAT_REC.SR_MANAGER_STAFF_ID    := GV_FLAT_REC.DIRECTOR_STAFF_ID;
						GV_FLAT_REC.SR_MANAGER_NATID       := GV_FLAT_REC.DIRECTOR_NATID;
						GV_FLAT_REC.SR_MANAGER_NAME        := GV_FLAT_REC.DIRECTOR_NAME;
					END IF;
			ELSIF S2S_REC.LVL = 3
				THEN
					IF S2S_REC.SUPERVISOR_ID IS NOT NULL
					THEN
						GV_FLAT_REC.MANAGER_STAFF_ID   := S2S_REC.STAFF_ID;
						GV_FLAT_REC.MANAGER_NATID      := S2S_REC.STAFF_NATID;
						GV_FLAT_REC.MANAGER_NAME 	    := S2S_REC.LAST_NAME||', '||S2S_REC.FIRST_NAME;
					ELSE
						GV_FLAT_REC.MANAGER_STAFF_ID   := GV_FLAT_REC.SR_MANAGER_STAFF_ID;
						GV_FLAT_REC.MANAGER_NATID      := GV_FLAT_REC.SR_MANAGER_NATID;
						GV_FLAT_REC.MANAGER_NAME       := GV_FLAT_REC.SR_MANAGER_NAME;
					END IF;
			ELSIF S2S_REC.LVL = 2
				THEN
					IF S2S_REC.SUPERVISOR_ID IS NOT NULL
					THEN
						GV_FLAT_REC.SUPERVISOR_STAFF_ID    := S2S_REC.STAFF_ID;
						GV_FLAT_REC.SUPERVISOR_NATID       := S2S_REC.STAFF_NATID;
						GV_FLAT_REC.SUPERVISOR_NAME 	    := S2S_REC.LAST_NAME||', '||S2S_REC.FIRST_NAME;
					ELSE
						GV_FLAT_REC.SUPERVISOR_STAFF_ID    := GV_FLAT_REC.MANAGER_STAFF_ID;
                        GV_FLAT_REC.SUPERVISOR_NATID       := GV_FLAT_REC.MANAGER_NATID;
						GV_FLAT_REC.SUPERVISOR_NAME        := GV_FLAT_REC.MANAGER_NAME;
					END IF;
			ELSIF S2S_REC.LVL = 1
				THEN
					IF S2S_REC.STAFF_ID IS NOT NULL
					THEN
						GV_FLAT_REC.STAFF_STAFF_ID     := S2S_REC.STAFF_ID;
						GV_FLAT_REC.STAFF_NATID        := S2S_REC.STAFF_NATID;
						GV_FLAT_REC.STAFF_STAFF_NAME 	:= S2S_REC.LAST_NAME||', '||S2S_REC.FIRST_NAME;
						GV_FLAT_REC.POSITION 			:= S2S_REC.POSITION;
						gv_FLAT_REC.TERMINATION_DATE    := S2S_REC.TERMINATION_DATE;
					END IF;
			END IF;


		ELSE -- WRITE THE RECORD

			IF GV_FLAT_REC.STAFF_STAFF_ID IS NOT NULL
			AND GV_FLAT_REC.SR_DIRECTOR_STAFF_ID IS NOT NULL
			AND GV_FLAT_REC.DIRECTOR_STAFF_ID IS NOT NULL
			AND GV_FLAT_REC.SR_MANAGER_STAFF_ID IS NOT NULL
			AND GV_FLAT_REC.MANAGER_STAFF_ID IS NOT NULL
			AND GV_FLAT_REC.SUPERVISOR_STAFF_ID IS NOT NULL
			THEN
			-- Fill in the individual STAFF_LEVEL data
--			FILL_IN_Values(GV_FLAT_REC.STAFF_STAFF_ID, TO_DATE(TRUNC(NVL(GV_FLAT_REC.TERMINATION_DATE,SYSDATE))));
			--
			-- insert or replace the SC_Hirearchy REPLACE
--			REPLACE_ONE_RECORD;

            LV_HOLD_ROOT_ID := 0;
--			LV_HOLD_ROOT_ID := S2S_REC.ROOT_STAFF_ID;


		END IF;

        END IF;

	END loop;

	--<< the last record >>

	FILL_IN_Values(GV_FLAT_REC.STAFF_STAFF_ID, TO_DATE(TRUNC(NVL(GV_FLAT_REC.TERMINATION_DATE,SYSDATE))));
	REPLACE_ONE_RECORD;

	COMMIT;

	IF (S2S_CSR%ISOPEN)
		THEN
			CLOSE S2S_CSR;
	END IF;
 EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE( 'FAILURE FOR STAFF_ID: '||S2S_REC.STAFF_ID||' EFFECTIVE DATE: '||S2S_REC.EFFECTIVE_DATE||' TERM DATE: '||S2S_REC.TERMINATION_DATE );
        END;

---------------------------------------------------------------
---------------------------------------------------------------
Procedure 	FILL_IN_VALUES(P_STAFF_ID NUMBER, P_EFFECTIVE_DATE DATE) IS

BEGIN

	-- --------------------------------------------------
	-- --			HIRE_DATE,
	-- --			TERMINATION_DATE,
-- --------------------------------------------------
	BEGIN
		SELECT MAX(HIRE_DATE) AS HIRE_DATE,
			MAX(TERMINATION_DATE)	AS TERMINATION_DATE
		INTO
			GV_FLAT_REC.HIRE_DATE,
			GV_FLAT_REC.TERMINATION_DATE
		FROM DP_SCORECARD.SC_HIERARCHY_STAFF
		WHERE STAFF_ID = GV_FLAT_REC.STAFF_STAFF_ID
		GROUP BY STAFF_ID;

	EXCEPTION
		WHEN NO_DATA_FOUND
			THEN
		--         DBMS_OUTPUT.PUT_LINE( 'FAILURE FOR STAFF_ID: '||S2S_REC.STAFF_ID||
		--         ' EFFECTIVE DATE: '||S2S_REC.EFFECTIVE_DATE||
		--         ' TERM DATE: '||S2S_REC.TERMINATION_DATE );
            NULL;

		WHEN OTHERS THEN RAISE;

	END;


	-- -------------------------------------------------------
	-- Office
	-- BUILDING,
	-- -------------------------------------------------------
	BEGIN

	SELECT OFFICE, BUILDING
		INTO GV_FLAT_REC.OFFICE, GV_FLAT_REC.BUILDING
	FROM SC_HIERARCHY_STAFF_TO_OFFICE
	WHERE STAFF_ID = P_STAFF_ID
	AND P_EFFECTIVE_DATE
	BETWEEN EFFECTIVE_DATE AND ADJUSTED_END_DATE;

	EXCEPTION
		WHEN NO_DATA_FOUND
			THEN
			GV_FLAT_REC.OFFICE := null;
			GV_FLAT_REC.BUILDING := null;
			--	DBMS_OUTPUT.PUT_LINE( 'FAILURE FOR STAFF_ID: '||S2S_REC.STAFF_ID||
			--  ' EFFECTIVE DATE: '||S2S_REC.EFFECTIVE_DATE||
			--  ' TERM DATE: '||S2S_REC.TERMINATION_DATE );
            NULL;

		WHEN OTHERS THEN RAISE;

	END;

	-- -----------------------------------------------
	-- --			EVENT_NAME,
	-- -----------------------------------------------

	SELECT NVL(MAX(EVENT_NAME),'Undefined') INTO GV_FLAT_REC.EVENT_NAME
	FROM SC_HIERARCHY_SERVING_TEAM
	WHERE STAFF_ID = GV_FLAT_REC.STAFF_STAFF_ID
	AND HIERARCHY_RUN_DATE = P_EFFECTIVE_DATE
	AND (STAFF_ID, HIERARCHY_RUN_DATE)
	IN ( SELECT STAFF_ID, HIERARCHY_RUN_DATE
        FROM SC_HIERARCHY_SERVING_TEAM
        GROUP BY STAFF_ID, HIERARCHY_RUN_DATE
        HAVING SUM(1) = 1
       );

    COMMIT;


	-- --------------------------------------------------
	-- 	DEPARTMENT,
	-- --------------------------------------------------
	BEGIN

	SELECT   NVL(DEPARTMENT,'UNDEFINED')  INTO GV_FLAT_REC.DEPARTMENT
	FROM DP_SCORECARD.SC_HIERARCHY_STAFF_TO_DEPT
		WHERE STAFF_ID = P_STAFF_ID
		AND P_EFFECTIVE_DATE
		BETWEEN START_DATE AND ADJUSTED_END_DATE;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN GV_FLAT_REC.DEPARTMENT := 'Undefined';
		WHEN OTHERS THEN RAISE;

	END;

	------------------------------------------------------
	--			QC_TENURE,
	------------------------------------------------------

	SELECT
		CASE WHEN QC_MONTHS IS NULL THEN NULL
			WHEN QC_MONTHS = 0 THEN '0'
			WHEN QC_MONTHS = 1 THEN '1'
			WHEN QC_MONTHS IN (2,3) THEN '2-3'
			WHEN QC_MONTHS IN (4,5,6) THEN '4-6'
			WHEN QC_MONTHS IN (7,8,9) THEN '7-9'
			WHEN QC_MONTHS IN (10,11,12) THEN '10-12'
			WHEN QC_MONTHS > 12 THEN 'OVER 12'
			ELSE NULL
		END QC_TENURE
			INTO GV_FLAT_REC.QC_TENURE
	FROM
		( SELECT MAX(MONTHS_BETWEEN(TRUNC(SYSDATE,'MM'), TRUNC(MIN(E.EVALUATION_DATE_TIME), 'MM'))) QC_MONTHS
		FROM DP_SCORECARD.ENGAGE_ACTUALS E
		WHERE E.AGENT_ID = (SELECT NATIONAL_ID FROM SC_HIERARCHY_STAFF WHERE STAFF_ID = P_STAFF_ID )
		AND NVL(E.DELETED_FLAG,'N') <> 'Y'
		GROUP BY E.AGENT_ID
		);


	-------------------------------------------------------
	--			QC_GROUP
	-------------------------------------------------------

    GV_FLAT_REC.QC_GROUP :=
        CASE GV_FLAT_REC.POSITION WHEN 'HSDE' THEN 'HSDE'
            WHEN 'Eligibility Specialist B' THEN 'V Docs'
            WHEN 'CSS1' THEN 'SBM'
            WHEN 'CSS3' THEN 'IND'
            WHEN 'CSS4' THEN 'IND'
            WHEN 'CSS4 - Web Chat' THEN 'WebChat'
            WHEN 'SWCC-CSR' THEN 'SWCC'
            WHEN 'SWCC-CSR 2' THEN 'SWCC'
            WHEN 'Eligibility Specialist C-Appeals' THEN 'Appeals'
            WHEN 'SHOP 1' THEN 'SBM'
            WHEN 'SHOP 2' THEN 'SBM'
            WHEN 'Task Team Administrators' THEN 'Task Team Administrators'
            WHEN 'Eligibility Specialist A' THEN 'HSDE-QC/LDS'
            WHEN 'Quality Control' THEN 'QC'
            WHEN 'Mailroom' THEN 'Mailroom'
            WHEN 'Research Specialist' THEN 'Research'
            WHEN 'NYEC - Mailroom' THEN 'NYEC 1'
            WHEN 'NAV-QR2' THEN 'IND'
         ELSE NULL END;


EXCEPTION

	WHEN OTHERS THEN 
	DBMS_OUTPUT.PUT_LINE(P_STAFF_ID);
	RAISE;

END;

---------------------------------------------------------------
---------------------------------------------------------------
	Procedure Replace_one_Record is

	LV_STAFF_COUNT      NUMBER(6) := 0;
	-----------------------------------------------------
	-- This is not a merge.. If there is a match
	-- on staff_staff_id then that record is deleted from the
	-- sc_hierarchy table and a new record is created.
	-- It is done 1 row at a time. ( commit on each row)
	-- This procedure could be run at any tiem and it
	-- should eliminate and problems with Micro Strategy.
	-----------------------------------------------------

	Begin

			--PRAGMA AUTONOMOUS_TRANSACTION;

			SELECT COUNT(*) INTO LV_STAFF_COUNT
			FROM SCORECARD_HIERARCHY WHERE STAFF_STAFF_ID = GV_FLAT_REC.STAFF_STAFF_ID;

			IF LV_STAFF_COUNT > 0
			THEN
				DELETE FROM SCORECARD_HIERARCHY
				WHERE STAFF_STAFF_ID = GV_FLAT_REC.STAFF_STAFF_ID;
			END IF;

			IF
                -- ENSURE THE STAFF_IDs AND NATIDs ARE NOT NULL
                    DP_SCORECARD.RETURN_NUMERIC(GV_FLAT_REC.SR_DIRECTOR_STAFF_ID) IS NOT NULL
                AND DP_SCORECARD.RETURN_NUMERIC(GV_FLAT_REC.SR_DIRECTOR_NATID) IS NOT NULL
                AND DP_SCORECARD.RETURN_NUMERIC(GV_FLAT_REC.DIRECTOR_STAFF_ID) IS NOT NULL
                AND DP_SCORECARD.RETURN_NUMERIC(GV_FLAT_REC.DIRECTOR_NATID) IS NOT NULL
                AND DP_SCORECARD.RETURN_NUMERIC(GV_FLAT_REC.SR_MANAGER_STAFF_ID) IS NOT NULL
                AND DP_SCORECARD.RETURN_NUMERIC(GV_FLAT_REC.SR_MANAGER_NATID) IS NOT NULL
                AND DP_SCORECARD.RETURN_NUMERIC(GV_FLAT_REC.MANAGER_STAFF_ID) IS NOT NULL
                AND DP_SCORECARD.RETURN_NUMERIC(GV_FLAT_REC.MANAGER_NATID) IS NOT NULL
                AND DP_SCORECARD.RETURN_NUMERIC(GV_FLAT_REC.SUPERVISOR_STAFF_ID) IS NOT NULL
                AND DP_SCORECARD.RETURN_NUMERIC(GV_FLAT_REC.SUPERVISOR_NATID) IS NOT NULL
                AND DP_SCORECARD.RETURN_NUMERIC(GV_FLAT_REC.STAFF_STAFF_ID) IS NOT NULL
                AND DP_SCORECARD.RETURN_NUMERIC(GV_FLAT_REC.STAFF_NATID) IS NOT NULL
			THEN
                INSERT INTO DP_SCORECARD.SCORECARD_HIERARCHY
                (
                ADMIN_ID,
                SR_DIRECTOR_NAME,
                SR_DIRECTOR_STAFF_ID,
                SR_DIRECTOR_NATID,
                DIRECTOR_NAME,
                DIRECTOR_STAFF_ID,
                DIRECTOR_NATID,
                SR_MANAGER_NAME,
                SR_MANAGER_STAFF_ID,
                SR_MANAGER_NATID,
                MANAGER_NAME,
                MANAGER_STAFF_ID,
                MANAGER_NATID,
                SUPERVISOR_NAME,
                SUPERVISOR_STAFF_ID,
                SUPERVISOR_NATID,
                STAFF_STAFF_ID,
                STAFF_STAFF_NAME,
                STAFF_NATID,
                HIRE_DATE,
                POSITION,
                OFFICE,
                TERMINATION_DATE,
                EVENT_NAME,
                DEPARTMENT,
                BUILDING,
                QC_TENURE,
                QC_GROUP
                )
                VALUES(
                '999', --<<GV_FLAT_REC.ADMIN_ID,
                GV_FLAT_REC.SR_DIRECTOR_NAME,
                GV_FLAT_REC.SR_DIRECTOR_STAFF_ID,
                GV_FLAT_REC.SR_DIRECTOR_NATID,
                GV_FLAT_REC.DIRECTOR_NAME,
                GV_FLAT_REC.DIRECTOR_STAFF_ID,
                GV_FLAT_REC.DIRECTOR_NATID,
                GV_FLAT_REC.SR_MANAGER_NAME,
                GV_FLAT_REC.SR_MANAGER_STAFF_ID,
                GV_FLAT_REC.SR_MANAGER_NATID,
                GV_FLAT_REC.MANAGER_NAME,
                GV_FLAT_REC.MANAGER_STAFF_ID,
                GV_FLAT_REC.MANAGER_NATID,
                GV_FLAT_REC.SUPERVISOR_NAME,
                GV_FLAT_REC.SUPERVISOR_STAFF_ID,
                GV_FLAT_REC.SUPERVISOR_NATID,
                GV_FLAT_REC.STAFF_STAFF_ID,
                GV_FLAT_REC.STAFF_STAFF_NAME,
                GV_FLAT_REC.STAFF_NATID,
                GV_FLAT_REC.HIRE_DATE,
                GV_FLAT_REC.POSITION,
                GV_FLAT_REC.OFFICE,
                GV_FLAT_REC.TERMINATION_DATE,
                GV_FLAT_REC.EVENT_NAME,
                GV_FLAT_REC.DEPARTMENT,
                GV_FLAT_REC.BUILDING,
                GV_FLAT_REC.QC_TENURE,
                GV_FLAT_REC.QC_GROUP
                );
        ELSE
            NULL;
        END IF;

        COMMIT;

	Exception

		When Others then Raise;

	End;

---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------

	Procedure Flag_Rehires is
	-- Last pass is to flag as "deleted" any
	-- Staff_ids associated to a National_id
	-- which is not the 'current staff id'.
	-- This condition is usually due to 're-hires'

	BEGIN
		Null;
	END;

---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------

Procedure Delete_Promoted_Staff is
    -- Because only Staff with a job level of 1
    -- are touched by the Process_Staff_ID procedure,
    -- it is necessary to Delete any STAFF_STAFF_ID(s)
    -- from the Hierarchy if they are no longer at
    -- a Job_Level of 1

Begin

    DELETE FROM SCORECARD_HIERARCHY
    WHERE STAFF_STAFF_ID
    IN (
        with LVL1 as
        ( select staff_id --<< anyone who was ever a Level 1
        from sc_hierarchy_staff_to_job
        where job_level = 1
        ),
        curr_job as
        ( select * from sc_hierarchy_staff_to_job
        where ( staff_id, adjusted_end_date )
        in ( select staff_id, max(adjusted_end_date)
             from sc_hierarchy_staff_to_job
             group by staff_id
            )
        )
        select lvl1.staff_id --, '<<>>', curr_job.*
        from curr_job
        join lvl1 on lvl1.staff_id = curr_job.staff_id
        where curr_job.job_level > 1
        intersect select staff_staff_id
        from SCORECARD_HIERARCHY
        );

    Commit;

Exception
    When others then raise;

End;

---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------

Procedure Delete_Transferred_Staff is
    -- Because only Staff with a job we use in the hierarchy
    -- are touched by the Process_Staff_ID procedure,
    -- it is necessary to Delete any STAFF_STAFF_ID(s)
    -- (who are not terminated)
    -- from the Hierarchy if their current job is not one
    -- we use in the hierarchy

Begin

    DELETE FROM DP_SCORECARD.SCORECARD_HIERARCHY
    WHERE STAFF_STAFF_ID
    IN ( SELECT STAFF_STAFF_ID
        FROM DP_SCORECARD.SCORECARD_HIERARCHY
        WHERE TERMINATION_DATE IS NULL
        AND STAFF_STAFF_ID IN
            ( -- People in the SCORECARD_HIERARCHY
            -- who no longer have jobs we use for the hierarchy
            SELECT STAFF_STAFF_ID FROM DP_SCORECARD.SCORECARD_HIERARCHY
            WHERE TERMINATION_DATE IS NULL
            MINUS
            SELECT STAFF_ID
            FROM DP_SCORECARD.SC_HIERARCHY_STAFF_TO_JOB
            WHERE END_DATE IS NULL
            )
        );

    Commit;

Exception
    When others then raise;

End;

---------------------------------------------------------------
---------------------------------------------------------------
Procedure Set_Termination_date is
Begin

    -- There are cases where a staff member was terminated
    -- while in traing ( or for some reason does not have
    -- a complete hierarchy ).
    -- Because only Staff with a 'complete Hierarchy'
    -- are updated by the Process_Staff_ID procedure,
    -- it is necessary to set the the Termination_date
    -- but leave the hierarchy as the last complete hierarchy

    UPDATE DP_SCORECARD.SCORECARD_HIERARCHY H
    SET TERMINATION_DATE =
        ( SELECT TERMINATION_DATE
        FROM DP_SCORECARD.SC_HIERARCHY_STAFF S
        WHERE S.STAFF_ID = H.STAFF_STAFF_ID
        AND S.TERMINATION_DATE IS NOT NULL
        AND H.TERMINATION_DATE IS NULL
        )
    WHERE H.STAFF_STAFF_ID
    IN ( SELECT STAFF_STAFF_ID
        FROM DP_SCORECARD.SCORECARD_HIERARCHY
        WHERE TERMINATION_DATE IS NULL
        AND STAFF_STAFF_ID
        IN ( SELECT STAFF_ID
            FROM DP_SCORECARD.SC_HIERARCHY_STAFF
            WHERE TERMINATION_DATE IS NOT NULL
           )
        );

    COMMIT;

Exception
    When others then raise;

End;

---------------------------------------------------------------
---------------------------------------------------------------
Procedure Remove_ReHires is

--  This procedure will remove records from the hierarchy
--  Whenever a NATIONAL_ID has more than 1 STAFF_ID
--  A NATIONAL_ID with more than 1 STAFF_ID is a 'duplcate'
--  and will cause problems in downstaream calculations.
--  The primary cause of duplication are RE-Hires, but this
--  procedure is not specific to RE-Hires.

Begin

    INSERT INTO SCORECARD_HIERARCHY_REHIRES
    (
    ADMIN_ID,
    SR_DIRECTOR_NAME, SR_DIRECTOR_STAFF_ID, SR_DIRECTOR_NATID,
    DIRECTOR_NAME, DIRECTOR_STAFF_ID, DIRECTOR_NATID,
    SR_MANAGER_NAME, SR_MANAGER_STAFF_ID, SR_MANAGER_NATID,
    MANAGER_NAME, MANAGER_STAFF_ID, MANAGER_NATID,
    SUPERVISOR_NAME, SUPERVISOR_STAFF_ID, SUPERVISOR_NATID,
    --
    STAFF_STAFF_NAME, STAFF_NATID,
    STAFF_STAFF_ID,
    HIRE_DATE, TERMINATION_DATE, QC_TENURE,
    POSITION, OFFICE, DEPARTMENT, BUILDING,
    EVENT_NAME, QC_GROUP, LAST_UPDATED_DATE
    )
    SELECT
    ADMIN_ID,
    SR_DIRECTOR_NAME, SR_DIRECTOR_STAFF_ID, SR_DIRECTOR_NATID,
    DIRECTOR_NAME, DIRECTOR_STAFF_ID, DIRECTOR_NATID,
    SR_MANAGER_NAME, SR_MANAGER_STAFF_ID, SR_MANAGER_NATID,
    MANAGER_NAME, MANAGER_STAFF_ID, MANAGER_NATID,
    SUPERVISOR_NAME, SUPERVISOR_STAFF_ID, SUPERVISOR_NATID,
    --
    STAFF_STAFF_NAME, STAFF_NATID,
    STAFF_STAFF_ID,
    HIRE_DATE, TERMINATION_DATE, QC_TENURE,
    POSITION, OFFICE, DEPARTMENT, BUILDING,
    EVENT_NAME, QC_GROUP, LAST_UPDATED_DATE
    FROM DP_SCORECARD.SCORECARD_HIERARCHY
    WHERE ( STAFF_NATID, STAFF_STAFF_ID )
    IN  (
            (select STAFF_NATID, STAFF_STAFF_ID
            from dp_scorecard.scorecard_hierarchy
            where staff_natid in
				( -- Identify the Duplicates in the Hierarchy
				SELECT STAFF_NATID
				FROM DP_SCORECARD.SCORECARD_HIERARCHY
				group by staff_natid
				having SUM(1) > 1
				)
            MINUS  -- The latest Staff_id should be the
			-- correct id
                SELECT STAFF_NATID, max(staff_staff_id)
                FROM DP_SCORECARD.SCORECARD_HIERARCHY
                group by staff_natid
                HAVING SUM(1) > 1
            )
        MINUS
            -- Don't insert rows which are already in the
            -- SCORECARD_HIERARCHY_REHIRES table
            ( SELECT STAFF_NATID, STAFF_STAFF_ID
            FROM SCORECARD_HIERARCHY_REHIRES
            )
            );

    COMMIT;

    Begin

        DELETE FROM DP_SCORECARD.SCORECARD_HIERARCHY
        WHERE (STAFF_NATID, STAFF_STAFF_ID)
        IN ( SELECT STAFF_NATID, STAFF_STAFF_ID
            FROM DP_SCORECARD.SCORECARD_HIERARCHY_REHIRES
            );

        COMMIT;

    Exception

        WHEN NO_DATA_FOUND
        THEN NULL;

        WHEN OTHERS
        THEN RAISE;

    End;

Exception
    When others then raise;

End;
END LOAD_SC_HIERARCHY_PKG_628;
/

show errors

grant execute on dp_scorecard.LOAD_SC_HIERARCHY_PKG_628 to dp_scorecard_read_only;