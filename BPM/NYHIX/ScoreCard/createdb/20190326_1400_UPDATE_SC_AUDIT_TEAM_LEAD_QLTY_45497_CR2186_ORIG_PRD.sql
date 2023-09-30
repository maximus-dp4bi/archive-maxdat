CREATE OR REPLACE Procedure DP_SCORECARD.UPDATE_SC_AUDIT_TEAM_LEAD_QLTY
   (
IN_DELETE_FLAG					IN VARCHAR2,
IN_TEAM_LEAD_QUALITY_ID         IN NUMBER,
IN_DATES_MONTH_NUM    			IN NUMBER,
IN_Team_lead_AGENT_STAFF_ID     IN NUMBER,
-- IN_TEAM_LEAD_QLTY_CREATE_USER  	IN VARCHAR2,  	<< REMOVED
-- IN_TEAM_LEAD_QLTY_CREATE_DATE  	IN DATE,		<< REMOVED
IN_TEAM_LEAD_QLTY_UPDT_USER  	IN VARCHAR2,
-- IN_TEAM_LEAD_QLTY_UPDT_DATE  	IN DATE,		<< REMOVED
IN_REVIEW_SESSIONS_COMPL_RTNG	IN VARCHAR2,
IN_LIVE_OBSRV_COMPL_RTNG		IN VARCHAR2,
IN_QPP_CHECKLIST_COMPL_RTNG 	IN VARCHAR2,
IN_QPP_QUALITY_SCORE_1_RTNG 	IN VARCHAR2,
IN_QPP_QUALITY_SCORE_2_RTNG		IN VARCHAR2
   )
AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180625_1106_SC_AUDIT_TEAM_LEAD_PLSQL.SQL $';
  	SVN_REVISION varchar2(20) := '$Revision: 23924 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-06-25 11:40:44 -0400 (Mon, 25 Jun 2018) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';

	v_username                 varchar2(300)	:=	NULL;

	C1_CURSOR_REC 				DP_SCORECARD.SC_AUDIT_TEAM_LEAD_QUALITY%ROWTYPE;

   CURSOR C1 IS
	WITH
	HDR AS
	( SELECT
	TEAM_LEAD_QUALITY_ID       	    AS  TEAM_LEAD_QUALITY_ID,
	IN_Team_lead_AGENT_STAFF_ID		AS	Team_lead_AGENT_STAFF_ID,
	IN_DATES_MONTH_NUM				AS	DATES_MONTH_NUM,
	TEAM_LEAD_QUALITY_CREATE_USER	AS  TEAM_LEAD_QUALITY_CREATE_USER,
	TEAM_LEAD_QUALITY_CREATE_DATE		AS	TEAM_LEAD_QUALITY_CREATE_DATE,
	IN_TEAM_LEAD_QLTY_UPDT_USER     AS  TEAM_LEAD_QUALITY_UPDT_USER,
	SYSDATE							AS  TEAM_LEAD_QUALITY_UPDT_DATE
	FROM SC_AUDIT_TEAM_LEAD_QUALITY
	WHERE TEAM_LEAD_QUALITY_ID = IN_TEAM_LEAD_QUALITY_ID
	),
	LIVE_OBSRV_COMPLTD AS
	(SELECT DROP_DOWN_VALUE,
			DROP_DOWN_TEXT,
			DROP_DOWN_METRIC
	FROM DP_SCORECARD.SCORECARD_DROP_DOWN_LKUP_SV
	WHERE TARGET_TABLE = 'SC_AUDIT_TEAM_LEAD_QUALITY'
	AND TARGET_COLUMN = 'LIVE_OBSRV_COMPLTD_RATING'
	AND TO_DATE(IN_DATES_MONTH_NUM,'YYYYMM') BETWEEN EFFECTIVE_DATE AND END_DATE
	AND DROP_DOWN_TEXT = IN_LIVE_OBSRV_COMPL_RTNG  -- 'Acceptable (6)' --IN_DROP_DOWN_TEXT
	),
	REVIEW_SESSIONS_COMPLTD AS
	(SELECT DROP_DOWN_VALUE,
		DROP_DOWN_TEXT,
		DROP_DOWN_METRIC
	FROM DP_SCORECARD.SCORECARD_DROP_DOWN_LKUP_SV
	WHERE TARGET_TABLE = 'SC_AUDIT_TEAM_LEAD_QUALITY'
	AND TARGET_COLUMN = 'REVIEW_SESSIONS_COMPLTD_RATING'
	AND TO_DATE(IN_DATES_MONTH_NUM,'YYYYMM') BETWEEN EFFECTIVE_DATE AND END_DATE
	AND DROP_DOWN_TEXT = IN_REVIEW_SESSIONS_COMPL_RTNG --'Exceeds (12)' -- IN_DROP_DOWN_TEXT
	),
	QPP_CHECKLIST_COMPLTD AS
	(SELECT DROP_DOWN_VALUE,
		DROP_DOWN_TEXT,
		DROP_DOWN_METRIC
	FROM DP_SCORECARD.SCORECARD_DROP_DOWN_LKUP_SV
	WHERE TARGET_TABLE = 'SC_AUDIT_TEAM_LEAD_QUALITY'
	AND TARGET_COLUMN = 'QPP_CHECKLIST_COMPLTD_RATING'
	AND TO_DATE(IN_DATES_MONTH_NUM,'YYYYMM') BETWEEN EFFECTIVE_DATE AND END_DATE
	AND DROP_DOWN_TEXT = IN_QPP_CHECKLIST_COMPL_RTNG --'Unacceptable (0)' --IN_DROP_DOWN_TEXT
	),
	QPP_QUALITY_SCORE_1 AS
	(SELECT DROP_DOWN_VALUE,
		DROP_DOWN_TEXT,
		DROP_DOWN_METRIC
	FROM DP_SCORECARD.SCORECARD_DROP_DOWN_LKUP_SV
	WHERE TARGET_TABLE = 'SC_AUDIT_TEAM_LEAD_QUALITY'
	AND TARGET_COLUMN = 'QPP_QUALITY_SCORE_1_RATING'
	AND TO_DATE(IN_DATES_MONTH_NUM,'YYYYMM') BETWEEN EFFECTIVE_DATE AND END_DATE
	AND DROP_DOWN_TEXT = IN_QPP_QUALITY_SCORE_1_RTNG --'Exceeds (>95%) (6)'--IN_DROP_DOWN_TEXT
	),
	QPP_QUALITY_SCORE_2 AS
	(SELECT DROP_DOWN_VALUE,
		DROP_DOWN_TEXT,
		DROP_DOWN_METRIC
	FROM DP_SCORECARD.SCORECARD_DROP_DOWN_LKUP_SV
	WHERE TARGET_TABLE = 'SC_AUDIT_TEAM_LEAD_QUALITY'
	AND TARGET_COLUMN = 'QPP_QUALITY_SCORE_2_RATING'
	AND TO_DATE(IN_DATES_MONTH_NUM,'YYYYMM') BETWEEN EFFECTIVE_DATE AND END_DATE
	AND DROP_DOWN_TEXT = IN_QPP_QUALITY_SCORE_2_RTNG -- 'Acceptable (Quality score remained the same or improved) (3)' --IN_DROP_DOWN_TEXT
	)
	--QPP_EVALUATION_RATING AS
	--(SELECT DROP_DOWN_VALUE, DROP_DOWN_TEXT, DROP_DOWN_METRIC
	--FROM DP_SCORECARD.SCORECARD_DROP_DOWN_LKUP_SV
	--WHERE TARGET_TABLE = 'SC_AUDIT_TEAM_LEAD_QUALITY'
	--AND TARGET_COLUMN = 'QPP_EVALUATION_RATING'
	--AND TO_DATE(IN_DATES_MONTH_NUM,'YYYYMM') BETWEEN EFFECTIVE_DATE AND END_DATE
	----AND DROP_DOWN_TEXT = IN_DROP_DOWN_TEXT
	--),
SELECT
	HDR.TEAM_LEAD_QUALITY_ID,
    HDR.Team_lead_AGENT_STAFF_ID,
    HDR.DATES_MONTH_NUM,
    HDR.TEAM_LEAD_QUALITY_CREATE_USER,
    HDR.TEAM_LEAD_QUALITY_CREATE_DATE,
    HDR.TEAM_LEAD_QUALITY_UPDT_USER,
    HDR.TEAM_LEAD_QUALITY_UPDT_DATE,
    --
	REVIEW_SESSIONS_COMPLTD.DROP_DOWN_TEXT	    AS	REVIEW_SESSIONS_COMPLTD_RATING,
	REVIEW_SESSIONS_COMPLTD.DROP_DOWN_METRIC	AS	REVIEW_SESSIONS_COMPLTD_POINTS,
	LIVE_OBSRV_COMPLTD.DROP_DOWN_TEXT 		    AS 	LIVE_OBSRV_COMPLTD_RATING,
	LIVE_OBSRV_COMPLTD.DROP_DOWN_METRIC         AS	LIVE_OBSRV_COMPLTD_POINTS,
	QPP_CHECKLIST_COMPLTD.DROP_DOWN_TEXT	    AS	QPP_CHECKLIST_COMPLTD_RATING,
	QPP_CHECKLIST_COMPLTD.DROP_DOWN_METRIC		AS	QPP_CHECKLIST_COMPLTD_POINTS,
	QPP_QUALITY_SCORE_1.DROP_DOWN_TEXT		    AS 	QPP_QUALITY_SCORE_1_RATING,
	QPP_QUALITY_SCORE_1.DROP_DOWN_METRIC		AS	QPP_QUALITY_SCORE_1_POINTS,
	QPP_QUALITY_SCORE_2.DROP_DOWN_TEXT		    AS	QPP_QUALITY_SCORE_2_RATING,
	QPP_QUALITY_SCORE_2.DROP_DOWN_METRIC		AS	QPP_QUALITY_SCORE_2_POINTS
	--
	--LIVE_OBSRV_COMPLTD.DROP_DOWN_METRIC
	--+REVIEW_SESSIONS_COMPLTD.DROP_DOWN_METRIC
	--+QPP_CHECKLIST_COMPLTD.DROP_DOWN_METRIC
	--+QPP_QUALITY_SCORE_1.DROP_DOWN_METRIC
	--+QPP_QUALITY_SCORE_2.DROP_DOWN_METRIC       AS  CUMULATIVE_RATING_POINT_VALUE
	--
	FROM HDR,
	LIVE_OBSRV_COMPLTD,
	REVIEW_SESSIONS_COMPLTD,
	QPP_CHECKLIST_COMPLTD,
	QPP_QUALITY_SCORE_1,
	QPP_QUALITY_SCORE_2;


BEGIN

	-- this is bad form because if the user is not authorized the prodeure fails with a no data found.
	-- but it is what has been used in prior procedures
      select name into v_username from
      (
        SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=IN_TEAM_LEAD_QLTY_UPDT_USER
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=IN_TEAM_LEAD_QLTY_UPDT_USER
        UNION
        SELECT director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=IN_TEAM_LEAD_QLTY_UPDT_USER
        UNION
        SELECT sr_manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=IN_TEAM_LEAD_QLTY_UPDT_USER
        UNION
        SELECT manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=IN_TEAM_LEAD_QLTY_UPDT_USER
        UNION
        SELECT supervisor_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=IN_TEAM_LEAD_QLTY_UPDT_USER
      );

	IF C1%ISOPEN
	THEN
		CLOSE C1;
	END IF;


	IF IN_TEAM_LEAD_QUALITY_ID IS NULL
	OR IN_DATES_MONTH_NUM > TO_CHAR(SYSDATE,'YYYYMM')
	THEN
		NULL;
    ELSIF IN_DELETE_FLAG = 1 THEN
		DELETE FROM dp_scorecard.SC_AUDIT_TEAM_LEAD_QUALITY
			WHERE TEAM_LEAD_QUALITY_ID = IN_TEAM_LEAD_QUALITY_ID;

		COMMIT;
	ELSE

		OPEN C1;
		FETCH C1 INTO C1_CURSOR_REC;

		IF C1_CURSOR_REC.TEAM_LEAD_QUALITY_ID IS NULL
		THEN
			NULL;
		ELSE
			UPDATE dp_scorecard.SC_AUDIT_TEAM_LEAD_QUALITY
			SET
			TEAM_LEAD_AGENT_STAFF_ID		=	C1_CURSOR_REC.Team_lead_AGENT_STAFF_ID,
			DATES_MONTH_NUM					=  C1_CURSOR_REC.DATES_MONTH_NUM,
			--TEAM_LEAD_QUALITY_CREATE_USER	=  C1_CURSOR_REC.TEAM_LEAD_QUALITY_CREATE_USER, -- << do not update
			--TEAM_LEAD_QUALITY_CREATE_DATE	=  C1_CURSOR_REC.TEAM_LEAD_QUALITY_CREATE_DATE,	-- << do not update
			TEAM_LEAD_QUALITY_UPDATE_USER	=  C1_CURSOR_REC.TEAM_LEAD_QUALITY_UPDATE_USER,
			TEAM_LEAD_QUALITY_UPDATE_DATE	=  C1_CURSOR_REC.TEAM_LEAD_QUALITY_UPDATE_DATE,
			REVIEW_SESSIONS_COMPLTD_RATING	=  C1_CURSOR_REC.REVIEW_SESSIONS_COMPLTD_RATING,
			REVIEW_SESSIONS_COMPLTD_POINTS	=  C1_CURSOR_REC.REVIEW_SESSIONS_COMPLTD_POINTS,
			LIVE_OBSRV_COMPLTD_RATING		=  C1_CURSOR_REC.LIVE_OBSRV_COMPLTD_RATING,
			LIVE_OBSRV_COMPLTD_POINTS		=  C1_CURSOR_REC.LIVE_OBSRV_COMPLTD_POINTS,
			QPP_CHECKLIST_COMPLTD_RATING	=  C1_CURSOR_REC.QPP_CHECKLIST_COMPLTD_RATING,
			QPP_CHECKLIST_COMPLTD_POINTS	=  C1_CURSOR_REC.QPP_CHECKLIST_COMPLTD_POINTS,
			QPP_QUALITY_SCORE_1_RATING		=  C1_CURSOR_REC.QPP_QUALITY_SCORE_1_RATING,
			QPP_QUALITY_SCORE_1_POINTS		=  C1_CURSOR_REC.QPP_QUALITY_SCORE_1_POINTS,
			QPP_QUALITY_SCORE_2_RATING		=  C1_CURSOR_REC.QPP_QUALITY_SCORE_2_RATING,
			QPP_QUALITY_SCORE_2_POINTS		=  C1_CURSOR_REC.QPP_QUALITY_SCORE_2_POINTS
			WHERE 	TEAM_LEAD_QUALITY_ID	=	C1_CURSOR_REC.TEAM_LEAD_QUALITY_ID;

		END IF;

		COMMIT;

	END IF;

	IF C1%ISOPEN
	THEN
		CLOSE C1;
	END IF;

EXCEPTION

	WHEN NO_DATA_FOUND
		THEN NULL;
	WHEN OTHERS
		THEN RAISE;


END;
/
