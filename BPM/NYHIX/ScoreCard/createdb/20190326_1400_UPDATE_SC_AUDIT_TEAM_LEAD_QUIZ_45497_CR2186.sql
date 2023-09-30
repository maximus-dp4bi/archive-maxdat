CREATE OR REPLACE Procedure DP_SCORECARD.UPDATE_SC_AUDIT_TEAM_LEAD_QUIZ
   (
    IN_DELETE_FLAG					IN VARCHAR2,
    IN_TEAM_LEAD_QUIZ_ID            IN NUMBER,
	IN_Team_lead_AGENT_STAFF_ID     IN NUMBER,
	--IN_TEAM_LEAD_QUIZ_CREATE_USER  	IN VARCHAR2,
	--IN_TEAM_LEAD_QUIZ_CREATE_DATE  	IN DATE,
	IN_TEAM_LEAD_QUIZ_UPDT_USER  	IN VARCHAR2,
	--IN_TEAM_LEAD_QUIZ_UPDT_DATE  	IN DATE,
	IN_CBT_EXAM_NAME				IN VARCHAR2,
	IN_CBT_EXAM_ASSIGNMENT_DATE		IN DATE,
	IN_CBT_EXAM_COMPLETION_DATE		IN DATE,
	IN_CBT_EXAM_SCORE				IN NUMBER,
	IN_CBT_EXAM_TIMELINESS			IN VARCHAR2
   )
AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180625_1106_SC_AUDIT_TEAM_LEAD_PLSQL.SQL $';
  	SVN_REVISION varchar2(20) := '$Revision: 23924 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-06-25 11:40:44 -0400 (Mon, 25 Jun 2018) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';

	V_USERNAME          VARCHAR2(300)   := NULL;
	V_EXAM_SCORE        VARCHAR2(50)    := NULL;

BEGIN

	-- this is bad form because if the user is not authorized the prodeure fails with a no data found.
	-- but it is what has been used in prior procedures
      select name into v_username from
      (
        SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=IN_TEAM_LEAD_QUIZ_UPDT_USER
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=IN_TEAM_LEAD_QUIZ_UPDT_USER
        UNION
        SELECT director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=IN_TEAM_LEAD_QUIZ_UPDT_USER
        UNION
        SELECT sr_manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=IN_TEAM_LEAD_QUIZ_UPDT_USER
        UNION
        SELECT manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=IN_TEAM_LEAD_QUIZ_UPDT_USER
        UNION
        SELECT supervisor_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=IN_TEAM_LEAD_QUIZ_UPDT_USER
      );

	IF TRUNC(IN_CBT_EXAM_ASSIGNMENT_DATE) > TRUNC(SYSDATE)
		THEN
			SELECT DUMMY INTO V_USERNAME -- FAIL IF DATE IS IN THE FUTURE
			FROM  DUAL
			WHERE 1 = 2;
		ELSE
			NULL;
	END IF;

	IF TRUNC(IN_CBT_EXAM_COMPLETION_DATE) > TRUNC(SYSDATE)
		THEN
			SELECT DUMMY INTO V_USERNAME -- FAIL IF DATE IS IN THE FUTURE
			FROM  DUAL
			WHERE 1 = 2;
		ELSE
			NULL;
	END IF;


	V_EXAM_SCORE  := rtrim(TO_CHAR(IN_CBT_EXAM_SCORE),'0');


	IF NVL(LENGTH(V_EXAM_SCORE),0) > 0
	THEN
		IF LENGTH(V_EXAM_SCORE) > 6        -- FAIL
		OR LENGTH(CEIL(V_EXAM_SCORE)) > 3  -- FAIL
		OR LENGTH(SUBSTR(V_EXAM_SCORE,INSTR(V_EXAM_SCORE,'.'))) > 3 -- FAIL
			THEN
				SELECT DUMMY INTO V_USERNAME -- FAIL IF DATE IS IN THE FUTURE
				FROM  DUAL
				WHERE 1 = 2;
			ELSE
				NULL;
		END IF;
	END IF;


	IF IN_TEAM_LEAD_QUIZ_ID IS NULL
	THEN
		NULL;
    ELSIF IN_DELETE_FLAG = 1 THEN
		DELETE FROM dp_scorecard.SC_AUDIT_TEAM_LEAD_QUIZ
			WHERE TEAM_LEAD_QUIZ_ID = IN_TEAM_LEAD_QUIZ_ID;

		COMMIT;
	ELSE

		UPDATE dp_scorecard.SC_AUDIT_TEAM_LEAD_QUIZ
		SET
			TEAM_LEAD_AGENT_STAFF_ID		=   IN_Team_lead_AGENT_STAFF_ID,
			--TEAM_LEAD_QUIZ_CREATE_USER		=   IN_TEAM_LEAD_QUIZ_CREATE_USER,
			--TEAM_LEAD_QUIZ_CREATE_DATE		=   IN_TEAM_LEAD_QUIZ_CREATE_DATE,
			TEAM_LEAD_QUIZ_UPDATE_USER		=   IN_TEAM_LEAD_QUIZ_UPDT_USER,
			TEAM_LEAD_QUIZ_UPDATE_DATE		=   SYSDATE,
			CBT_EXAM_NAME					=   IN_CBT_EXAM_NAME,
			CBT_EXAM_ASSIGNMENT_DATE		=   IN_CBT_EXAM_ASSIGNMENT_DATE,
			CBT_EXAM_COMPLETION_DATE		=   IN_CBT_EXAM_COMPLETION_DATE,
			CBT_EXAM_SCORE					=   IN_CBT_EXAM_SCORE,
			CBT_EXAM_TIMELINESS				=   IN_CBT_EXAM_TIMELINESS
		WHERE TEAM_LEAD_QUIZ_ID = IN_TEAM_LEAD_QUIZ_ID;

		COMMIT;

	END IF;

EXCEPTION

	WHEN NO_DATA_FOUND
		THEN NULL;
	WHEN OTHERS
		THEN RAISE;

END;
/
