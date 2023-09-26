
ALTER SESSION SET plsql_code_type = native;

-- BEGIN PACKAGE CLEAR2WORK_JOB
CREATE OR REPLACE PACKAGE CLEAR2WORK_JOB AS

    -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
    SVN_FILE_URL varchar2(200) := '$URL$'; 
    SVN_REVISION varchar2(20) := '$Revision$'; 
    SVN_REVISION_DATE varchar2(60) := '$Date$'; 
    SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

	-- Package level variables
	gv_DEFAULT_RETENTION_DAYS VARCHAR2(4) := '2000';            -- default number of retention days for AUDIT, LOG, RUN tables if missing in global config table
	gv_DATE_FORMAT VARCHAR2(10) := 'YYYY-MM-DD';                -- default format for date 
	
	-- List of Functions
	FUNCTION UPDATE_EVENTUSER_NAME_MAP (p_upd_type IN VARCHAR2 DEFAULT 'NEW'
	                                   ,p_job_id IN NUMBER DEFAULT 0)
    RETURN NUMBER;
	
    -- List of Procedures
    PROCEDURE ADD_CLEAR2WORK_LOG (p_log_desc IN VARCHAR2, 
                                  p_log_severity IN VARCHAR2, 
                                  p_log_code IN NUMBER, 
                                  p_job_id IN NUMBER, 
                                  p_step_id IN NUMBER, 
                                  p_step_desc IN VARCHAR2);
    PROCEDURE PURGE_CLEAR2WORK_DATA;

	PROCEDURE PROCESS_CLEAR2WORK_DATA;
END;
/
-- END PACKAGE CLEAR2WORK_JOB

-- BEGIN PACKAGE BODY CLEAR2WORK_JOB
CREATE OR REPLACE PACKAGE BODY CLEAR2WORK_JOB AS
    
    -- BEGIN PROCEDURE ADD_CLEAR2WORK_LOG
    PROCEDURE ADD_CLEAR2WORK_LOG (p_log_desc IN VARCHAR2, 
                                  p_log_severity IN VARCHAR2, 
                                  p_log_code IN NUMBER, 
                                  p_job_id IN NUMBER, 
                                  p_step_id IN NUMBER, 
                                  p_step_desc IN VARCHAR2)
    AS
        -- variable declaration
    BEGIN
        -- STEP 10: Insert the log data into CLEAR2WORK_JOB_LOG Table
        INSERT INTO CLEAR2WORK_JOB_LOG (
            LOG_DESC,
            LOG_UPD_DT,
            LOG_SEVERITY_LEVEL,
            LOG_CODE,
            JOB_ID,
            STEP_ID,
            STEP_DESC)
        VALUES (
            p_log_desc,
            SYSDATE,
            p_log_severity,
            p_log_code,
            p_job_id,
            p_step_id,
            p_step_desc);
            
        -- STEP 20: Commit
        COMMIT;

        -- STEP 1000: Exception Handling
        EXCEPTION
            WHEN OTHERS THEN
                RAISE;      
    END;
    -- END PROCEDURE ADD_ETL_LOG
    
    -- BEGIN PROCEDURE PURGE_CLEAR2WORK_DATA
    PROCEDURE PURGE_CLEAR2WORK_DATA
    AS
        -- variable declaration
        v_step_id NUMBER;
        v_step_desc VARCHAR2(100);
    BEGIN
        -- STEP 10: Purge records in CLEAR2WORK_BADGE table
        v_step_id := 10;
        v_step_desc := 'Purge records in CLEAR2WORK_BADGE table';
        
        DELETE FROM CLEAR2WORK_BADGE
		WHERE BADGE_DATE < TO_DATE(TO_CHAR(SYSDATE,gv_DATE_FORMAT),gv_DATE_FORMAT) 
		                   - (SELECT TO_NUMBER(COALESCE(MAX(PARAM_VALUE),gv_DEFAULT_RETENTION_DAYS))
                              FROM CLEAR2WORK_GLOBAL_CONFIG gc
                              WHERE gc.PARAM_KEY = 'BADGE_DATA_RETENTION_DAYS');
																					
        -- STEP 20: Purge records in CLEAR2WORK_SURVEY table
        v_step_id := 20;
        v_step_desc := 'Purge records in CLEAR2WORK_SURVEY table';
        
        DELETE FROM CLEAR2WORK_SURVEY
		WHERE SURVEY_DATE < TO_DATE(TO_CHAR(SYSDATE,gv_DATE_FORMAT),gv_DATE_FORMAT) 
		                    - (SELECT TO_NUMBER(COALESCE(MAX(PARAM_VALUE),gv_DEFAULT_RETENTION_DAYS))
                               FROM CLEAR2WORK_GLOBAL_CONFIG gc
                               WHERE gc.PARAM_KEY = 'SURVEY_DATA_RETENTION_DAYS');
		--AND EMP_LATEST_SURVEY <> 'Y';
							   
        -- STEP 30: Purge records in CLEAR2WORK_BADGE_SKIP_RECS table
        v_step_id := 30;
        v_step_desc := 'Purge records in CLEAR2WORK_BADGE_SKIP_RECS table';
        
        DELETE FROM CLEAR2WORK_BADGE_SKIP_RECS
		WHERE BADGE_DATE < TO_DATE(TO_CHAR(SYSDATE,gv_DATE_FORMAT),gv_DATE_FORMAT) 
		                   - (SELECT TO_NUMBER(COALESCE(MAX(PARAM_VALUE),gv_DEFAULT_RETENTION_DAYS))
                              FROM CLEAR2WORK_GLOBAL_CONFIG gc
                              WHERE gc.PARAM_KEY = 'BADGE_DATA_RETENTION_DAYS');

        -- STEP 40: Purge records in CLEAR2WORK_SURVEY_SKIP_RECS table
        v_step_id := 40;
        v_step_desc := 'Purge records in CLEAR2WORK_SURVEY_SKIP_RECS table';
        
        DELETE FROM CLEAR2WORK_SURVEY_SKIP_RECS
		WHERE SURVEY_DATE < TO_DATE(TO_CHAR(SYSDATE,gv_DATE_FORMAT),gv_DATE_FORMAT) 
		                    - (SELECT TO_NUMBER(COALESCE(MAX(PARAM_VALUE),gv_DEFAULT_RETENTION_DAYS))
                               FROM CLEAR2WORK_GLOBAL_CONFIG gc
                               WHERE gc.PARAM_KEY = 'SURVEY_DATA_RETENTION_DAYS');
        
		-- STEP 100:  Commit the changes
		v_step_id := 100;
		v_step_desc := 'Commit the changes';
		
		COMMIT;
		
		-- STEP 1000: Exception Handling
        EXCEPTION
            WHEN OTHERS THEN
                ADD_CLEAR2WORK_LOG ($$PLSQL_UNIT || '.PURGE_CLEAR2WORK_DATA procedure : ' || SUBSTR(SQLERRM,1,200), 'ERROR', SQLCODE, NULL, v_step_id, v_step_desc);
                RAISE; 
    END;
    -- END PROCEDURE PURGE_CLEAR2WORK_JOB_DATA

    -- BEGIN FUNCTION PROCESS_CLEAR2WORK_DATA
    PROCEDURE PROCESS_CLEAR2WORK_DATA
    AS
        -- variable declaration
		v_job_id NUMBER;
		v_job_status VARCHAR2(50) := 'COMPLETED';
        v_step_id NUMBER;
        v_step_desc VARCHAR2(100);
		v_loop_ind NUMBER;
		v_retval NUMBER;
    BEGIN

		-- STEP 1: Purge Badge and Survey data
		v_step_id := 1;
		v_step_desc := 'Purge Badge and Survey data';
        
		PURGE_CLEAR2WORK_DATA;
		
        -- STEP 5: Start a new job
		v_step_id := 5;
		v_step_desc := 'Start a new job';
        
		INSERT INTO CLEAR2WORK_JOB_STATUS (
            JOB_STATUS,
            JOB_BEGIN_DT,
			LAST_UPD_DT)
        VALUES (
            'STARTED',
            SYSDATE,
            SYSDATE);
						 
		-- STEP 10: Get the new job id into variable v_job_id		
        v_step_id := 10;
        v_step_desc := 'Get the new job id into variable v_job_id';

		SELECT MAX(JOB_ID) 
		INTO v_job_id 
		FROM CLEAR2WORK_JOB_STATUS;

        -- STEP 15: Skip if job is disabled on the DB side
		v_step_id := 15;
		v_step_desc := 'Skip if job is disabled on the DB side';
		
		SELECT COALESCE(MAX(PARAM_VALUE),'N') 
		INTO v_job_status
        FROM  
            CLEAR2WORK_GLOBAL_CONFIG
        WHERE 
            PARAM_KEY = 'JOB_ENABLED';
                
        IF (v_job_status <> 'Y') THEN

			UPDATE
				CLEAR2WORK_JOB_STATUS
			SET 
				JOB_STATUS = 'SKIPPED',
				DESCRIPTION = 'JOB DISABLED IN DATABASE, UPDATE/INSERT *JOB_ENABLED* WITH *Y* IN CLEAR2WORK_GLOBAL_CONFIG TABLE TO ENABLE IT',
				JOB_END_DT = SYSDATE,
				LAST_UPD_DT = SYSDATE
			WHERE
				JOB_ID = v_job_id;

            COMMIT;
		    RETURN;
		END IF;
		
		-- STEP 20: Exit the process if the last instance of the job is still running
		v_step_id := 20;
		v_step_desc := 'Exit the process if the last instance of the job is still running';
				
		SELECT COALESCE(MAX(JOB_STATUS),'COMPLETED') 
		INTO v_job_status
		FROM CLEAR2WORK_JOB_STATUS
		WHERE JOB_ID IN (SELECT COALESCE(MAX(JOB_ID), 0)
		                 FROM CLEAR2WORK_JOB_STATUS
						 WHERE JOB_ID < v_job_id);
			
        IF (v_job_status = 'STARTED') THEN
			UPDATE
				CLEAR2WORK_JOB_STATUS
			SET 
				JOB_STATUS = 'SKIPPED',
				DESCRIPTION = 'PREVIOUS INSTANCE OF THE JOB IS STILL RUNNING',
				JOB_END_DT = SYSDATE,
				LAST_UPD_DT = SYSDATE
			WHERE
				JOB_ID = v_job_id;

            COMMIT;
		    RETURN;
		END IF;

		-- STEP 25: Mark the Badge records if DATE_TIME field is invalid
		v_step_id := 25;
		v_step_desc := 'Mark the Badge records if DATE_TIME field is invalid';
		
		UPDATE CLEAR2WORK_BADGE_STG stg
		SET REC_STATUS = 'INVALID DATE_TIME'
		WHERE REC_STATUS = 'NEW' 
		AND INSTR(DATE_TIME,' ') < 7;

		-- STEP 30: Mark the Badge records if duplicate
		v_step_id := 30;
		v_step_desc := 'Mark the Badge records if duplicate';

		UPDATE CLEAR2WORK_BADGE_STG stg
		SET REC_STATUS = 'DUPLICATE_RECORD'
		WHERE REC_STATUS = 'NEW' 
		  AND EXISTS (SELECT 1 
		              FROM CLEAR2WORK_BADGE badg
		              WHERE badg.DATE_TIME = stg.DATE_TIME
					    AND badg.EVENT_USER = stg.EVENT_USER
						AND badg.CREDENTIAL_ID = COALESCE(stg.CREDENTIAL_ID,' ')
						AND badg.MAX_ID = COALESCE(stg.MAX_ID,' ')
						AND badg.SITE_NAME  = COALESCE(stg.SITE_NAME,' ')
						AND badg.DOOR_DEVICE = COALESCE(stg.DOOR_DEVICE,' '));

		-- STEP 35: Mark the Survey records if SUBMISSION_TIME field is invalid
		v_step_id := 35;
		v_step_desc := 'Mark the Survey records if SUBMISSION_TIME field is invalid';
				
		UPDATE CLEAR2WORK_SURVEY_STG stg
		SET REC_STATUS = 'INV SUBMISSION_TIME'
		WHERE REC_STATUS = 'NEW' 
		AND INSTR(SUBMISSION_TIME,' ') < 11;
		
		-- STEP 40: Mark the Survey records if duplicate
		v_step_id := 40;
		v_step_desc := 'Mark the Survey records if duplicate';

		UPDATE CLEAR2WORK_SURVEY_STG stg
		SET REC_STATUS = 'DUPLICATE_RECORD'
		WHERE REC_STATUS = 'NEW' 
		  AND EXISTS (SELECT 1 
		              FROM CLEAR2WORK_SURVEY badg
		              WHERE badg.ASSIGNEE_ID = stg.ASSIGNEE_ID
					    AND badg.SUBMISSION_TIME = stg.SUBMISSION_TIME
						AND badg.EMP_ID = COALESCE(stg.EMP_ID,' ')
						AND badg.SITE_NAME = COALESCE(stg.SITE_NAME,' ')
						AND badg.CLEAR_IND = COALESCE(stg.CLEAR_IND,' ')
					    AND badg.NOT_CLEAR_IND = COALESCE(stg.NOT_CLEAR_IND,' ')
						AND badg.ASSIGNEE_NAME = COALESCE(stg.ASSIGNEE_NAME,' ')
						AND badg.ABOUT_USER_ID = COALESCE(stg.ABOUT_USER_ID,' ')
						AND badg.ABOUT_USER_NAME = COALESCE(stg.ABOUT_USER_NAME,' ')
						AND badg.START_TIME = COALESCE(stg.START_TIME,' ')
						AND badg.COMPLETED_BY_USER_ID = COALESCE(stg.COMPLETED_BY_USER_ID,' ')
						AND badg.COMPLETED_BY_USER_NAME = COALESCE(stg.COMPLETED_BY_USER_NAME,' '));
		
		-- STEP 45: call function to update the EVENTUSER to NAME mapping
		v_step_id := 45;
		v_step_desc := 'call function to update the EVENTUSER to NAME mapping';

		v_retval := UPDATE_EVENTUSER_NAME_MAP('NEW',v_job_id);

		-- STEP 50: exit if the function to update the EVENTUSER to NAME mapping fails
		v_step_id := 50;
		v_step_desc := 'exit if the function to update the EVENTUSER to NAME mapping fails';

		IF (v_retval = 1) THEN
			RETURN;
		END IF;
		
		-- STEP 55: Insert the new Badge records into main table
		v_step_id := 55;
		v_step_desc := 'Insert the new Badge records into main table';

		INSERT INTO CLEAR2WORK_BADGE (
			DATE_TIME,
			EVENT_USER,
			CREDENTIAL_ID,
			MAX_ID,
			SITE_NAME,
			DOOR_DEVICE,
			FILE_NAME,
			BADGE_DATE)
		SELECT DISTINCT
            DATE_TIME,
			EVENT_USER,
			COALESCE(CREDENTIAL_ID,' '),
			COALESCE(MAX_ID,' '),
			COALESCE(SITE_NAME,' '),
			COALESCE(DOOR_DEVICE,' '),
			FILE_NAME,
			TO_DATE(SUBSTR(DATE_TIME, 1, INSTR(DATE_TIME,' ')-1),'MM/DD/YY')
		FROM
			CLEAR2WORK_BADGE_STG
		WHERE
			REC_STATUS = 'NEW';
			
		-- STEP 60: Insert the new Survey records into main table
		v_step_id := 60;
		v_step_desc := 'Insert the new Survey records into main table';
		
		INSERT INTO CLEAR2WORK_SURVEY (
			ASSIGNEE_ID,
			SUBMISSION_TIME,
			EMP_ID,
			SITE_NAME,
			CLEAR_IND,
			NOT_CLEAR_IND,
			ASSIGNEE_NAME,
			ABOUT_USER_ID,
			ABOUT_USER_NAME,
			START_TIME,
			COMPLETED_BY_USER_ID,
			COMPLETED_BY_USER_NAME,
			FILE_NAME,
			SURVEY_DATE)
		SELECT DISTINCT
			ASSIGNEE_ID,
			SUBMISSION_TIME,
			COALESCE(EMP_ID,' '),
			COALESCE(SITE_NAME,' '),
			COALESCE(CLEAR_IND,' '),
			COALESCE(NOT_CLEAR_IND,' '),
			COALESCE(ASSIGNEE_NAME,' '),
			COALESCE(ABOUT_USER_ID,' '),
			COALESCE(ABOUT_USER_NAME,' '),
			COALESCE(START_TIME,' '),
			COALESCE(COMPLETED_BY_USER_ID,' '),
			COALESCE(COMPLETED_BY_USER_NAME,' '),
			FILE_NAME,
			TO_DATE(SUBSTR(SUBMISSION_TIME, 1, 10),'YYYY-MM-DD')
		FROM 
  		    CLEAR2WORK_SURVEY_STG
		WHERE
			REC_STATUS = 'NEW';

		-- STEP 65: Update EMP_LATEST_SURVEY as N for all older records
		v_step_id := 65;
		v_step_desc := 'Update EMP_LATEST_SURVEY as N for all older records';
		
		UPDATE CLEAR2WORK_SURVEY srvy1
		SET EMP_LATEST_SURVEY = 'N'
		WHERE EMP_LATEST_SURVEY = 'Y'
		AND TO_DATE(SUBSTR(SUBMISSION_TIME, 1, 19),'YYYY-MM-DD HH24:MI:SS') < (SELECT MAX(TO_DATE(SUBSTR(SUBMISSION_TIME, 1, 19),'YYYY-MM-DD HH24:MI:SS'))
		                                                                       FROM CLEAR2WORK_SURVEY srvy2
																			   WHERE srvy2.EMP_ID = srvy1.EMP_ID);

/*
		-- STEP 70: Insert any new Sites from Badge records
		v_step_id := 70;
		v_step_desc := 'Insert any new Sites from Badge records';
		
		INSERT INTO CLEAR2WORK_SITE (
			SITE_NAME,
			BRIVO_SITE)
		SELECT DISTINCT 
            SITE_NAME,
			SITE_NAME
		FROM	
			CLEAR2WORK_BADGE_STG bdg
		WHERE 
		    NOT EXISTS (SELECT 1 
			  		    FROM CLEAR2WORK_SITE site
						WHERE bdg.SITE_NAME = site.SITE_NAME);
		
		-- STEP 75: Update BRAVO_SITE if Site exists but only marked as Survey Site
		v_step_id := 75;
		v_step_desc := 'Update BRAVO_SITE if Site exists but only marked as Survey Site';
		
		UPDATE CLEAR2WORK_SITE site
		SET BRIVO_SITE = SITE_NAME
		WHERE BRIVO_SITE IS NULL
		AND EXISTS (SELECT 1
		            FROM CLEAR2WORK_BADGE_STG bdg
		            WHERE bdg.SITE_NAME = site.SITE_NAME);
		
		-- STEP 80: Insert any new Sites from Survey records
		v_step_id := 80;
		v_step_desc := 'Insert any new Sites from Survey records';
		
		INSERT INTO CLEAR2WORK_SITE (
			SITE_NAME,
			CLEAR2WORK_SITE)
		SELECT DISTINCT 
            SITE_NAME,
			SITE_NAME
		FROM	
			CLEAR2WORK_SURVEY_STG srvy
		WHERE 
		    NOT EXISTS (SELECT 1 
			  		    FROM CLEAR2WORK_SITE site
						WHERE srvy.SITE_NAME = site.SITE_NAME);

		-- STEP 85: Update CLEAR2WORK_SITE if Site exists but only marked as Badge Site
		v_step_id := 85;
		v_step_desc := 'Update CLEAR2WORK_SITE if Site exists but only marked as Badge Site';
		
		UPDATE CLEAR2WORK_SITE site
		SET CLEAR2WORK_SITE = SITE_NAME
		WHERE CLEAR2WORK_SITE IS NULL
		AND EXISTS (SELECT 1
		            FROM CLEAR2WORK_SURVEY_STG srvy
		            WHERE srvy.SITE_NAME = site.SITE_NAME);
*/
		
		-- STEP 90: Insert job statistics for Badge records
		v_step_id := 90;
		v_step_desc := 'Insert job statistics for Badge records';
		
		INSERT INTO CLEAR2WORK_JOB_STATISTICS (
			JOB_ID,
			FILE_NAME,
			RECS_INPUT_UNIQUE,
			RECS_SKIPPED_DUPE_UNIQUE,
			RECS_SKIPPED_INVALID_DATE_UNIQUE,
			RECS_LOADED_UNIQUE)
		SELECT
			v_job_id,
			FILE_NAME,
			COUNT(1),
			SUM(CASE WHEN REC_STATUS = 'DUPLICATE_RECORD' THEN 1 ELSE 0 END),
			SUM(CASE WHEN REC_STATUS = 'INVALID DATE_TIME' THEN 1 ELSE 0 END),
			SUM(CASE WHEN REC_STATUS = 'NEW' THEN 1 ELSE 0 END)
		FROM (SELECT DISTINCT * FROM CLEAR2WORK_BADGE_STG) BDG
		GROUP BY FILE_NAME;
		
		-- STEP 95: Insert job statistics for Survey records
		v_step_id := 95;
		v_step_desc := 'Insert job statistics for Survey records';

		INSERT INTO CLEAR2WORK_JOB_STATISTICS (
			JOB_ID,
			FILE_NAME,
			RECS_INPUT_UNIQUE,
			RECS_SKIPPED_DUPE_UNIQUE,
			RECS_SKIPPED_INVALID_DATE_UNIQUE,
			RECS_LOADED_UNIQUE)
		SELECT
			v_job_id,
			FILE_NAME,
			COUNT(1),
			SUM(CASE WHEN REC_STATUS = 'DUPLICATE_RECORD' THEN 1 ELSE 0 END),
			SUM(CASE WHEN REC_STATUS = 'INV SUBMISSION_TIME' THEN 1 ELSE 0 END),		
			SUM(CASE WHEN REC_STATUS = 'NEW' THEN 1 ELSE 0 END)
		FROM (SELECT DISTINCT * FROM CLEAR2WORK_SURVEY_STG) SRVY
		GROUP BY FILE_NAME;
		
		-- STEP 100: Save Badge skip records
		v_step_id := 100;
		v_step_desc := 'Save Badge skip records';
				
		INSERT INTO CLEAR2WORK_BADGE_SKIP_RECS (
			JOB_ID,
			DATE_TIME,
			EVENT_USER,
			CREDENTIAL_ID,
			MAX_ID,
			SITE_NAME,
			DOOR_DEVICE,
			FILE_NAME,
			LOAD_DT,
			REC_STATUS,
			BADGE_DATE)
		SELECT DISTINCT	
			v_job_id,
			DATE_TIME,
			EVENT_USER,
			COALESCE(CREDENTIAL_ID,' '),
			COALESCE(MAX_ID,' '),
			COALESCE(SITE_NAME,' '),
			COALESCE(DOOR_DEVICE,' '),
			FILE_NAME,
			LOAD_DT,
			REC_STATUS,
			TO_DATE(SUBSTR(DATE_TIME, 1, INSTR(DATE_TIME,' ')-1),'MM/DD/YY')
		FROM 
			CLEAR2WORK_BADGE_STG
		WHERE
			REC_STATUS <> 'NEW';

		-- STEP 105: Save Survey skip records
		v_step_id := 105;
		v_step_desc := 'Save Survey skip records';

		INSERT INTO CLEAR2WORK_SURVEY_SKIP_RECS (
			JOB_ID,
			ASSIGNEE_ID,
			SUBMISSION_TIME,
			EMP_ID,
			SITE_NAME,
			CLEAR_IND,
			NOT_CLEAR_IND,
			ASSIGNEE_NAME,
			ABOUT_USER_ID,
			ABOUT_USER_NAME,
			START_TIME,
			COMPLETED_BY_USER_ID,
			COMPLETED_BY_USER_NAME,
			FILE_NAME,
			LOAD_DT,
            REC_STATUS,
			SURVEY_DATE)
		SELECT DISTINCT
			v_job_id,
			ASSIGNEE_ID,
			SUBMISSION_TIME,
			COALESCE(EMP_ID,' '),
			COALESCE(SITE_NAME,' '),
			COALESCE(CLEAR_IND,' '),
			COALESCE(NOT_CLEAR_IND,' '),
			COALESCE(ASSIGNEE_NAME,' '),
			COALESCE(ABOUT_USER_ID,' '),
			COALESCE(ABOUT_USER_NAME,' '),
			COALESCE(START_TIME,' '),
			COALESCE(COMPLETED_BY_USER_ID,' '),
			COALESCE(COMPLETED_BY_USER_NAME,' '),
			FILE_NAME,
			LOAD_DT,
            REC_STATUS,
			TO_DATE(SUBSTR(SUBMISSION_TIME, 1, 10),'YYYY-MM-DD')
		FROM 
			CLEAR2WORK_SURVEY_STG
		WHERE
			REC_STATUS <> 'NEW';

		-- STEP 110: Truncate the staging tables
        v_step_id := 110;
        v_step_desc := 'Truncate the staging tables';

		DELETE FROM CLEAR2WORK_BADGE_STG;
		DELETE FROM CLEAR2WORK_SURVEY_STG;

		-- STEP 115: Complete the new job
        v_step_id := 115;
        v_step_desc := 'Complete the new job';

        UPDATE
            CLEAR2WORK_JOB_STATUS
        SET 
            JOB_STATUS = 'COMPLETED',
			DESCRIPTION = 'DATA WAS PROCESSED SUCCESSFULLY, REFER JOB_STATISTICS TABLE FOR RECORD COUNTS',
            JOB_END_DT = SYSDATE,
            LAST_UPD_DT = SYSDATE
        WHERE
            JOB_ID = v_job_id;
			
        -- STEP 999: Commit all changes
        v_step_id := 999;
        v_step_desc := 'Commit all changes';
        
        COMMIT;
        RETURN;
		
        -- STEP 1000: Exception Handling
        EXCEPTION
            WHEN OTHERS THEN
				
                ADD_CLEAR2WORK_LOG ($$PLSQL_UNIT || '.PROCESS_CLEAR2WORK_DATA function : ' || SUBSTR(SQLERRM,1,200), 'ERROR', SQLCODE, v_job_id, v_step_id, v_step_desc);

				UPDATE
					CLEAR2WORK_JOB_STATUS
				SET 
					JOB_STATUS = 'FAILED',
					DESCRIPTION = 'REFER THE CLEAR2WORK_JOB_LOG TABLE FOR THE FAILURE REASONS',
					JOB_END_DT = SYSDATE,
					LAST_UPD_DT = SYSDATE
				WHERE
					JOB_ID = v_job_id;                

				COMMIT;
				RETURN; 
    END;
    -- END PROCEDURE PROCESS_CLEAR2WORK_DATA
	
    -- BEGIN FUNCTION UPDATE_EVENTUSER_NAME_MAP
    FUNCTION UPDATE_EVENTUSER_NAME_MAP (p_upd_type IN VARCHAR2 DEFAULT 'NEW'
	                                   ,p_job_id IN NUMBER DEFAULT 0)
    RETURN NUMBER
    AS
        -- variable declaration
		v_step_id NUMBER;
        v_step_desc VARCHAR2(100);
		v_loop_ind NUMBER;
    BEGIN

        -- STEP 5: check if the update is for ALL records
		v_step_id := 5;
		v_step_desc := 'check if the update is for ALL records';
        
        IF (p_upd_type = 'ALL') THEN
		
			-- STEP 10: truncate CLEAR2WORK_EVENTUSER_NAME_MAP table
			v_step_id := 10;
			v_step_desc := 'truncate CLEAR2WORK_EVENTUSER_NAME_MAP table';		

			DELETE FROM CLEAR2WORK_EVENTUSER_NAME_MAP;
			
			-- STEP 15: Populate distinct EVENT_USER from main badge table
			v_step_id := 15;
			v_step_desc := 'Populate distinct EVENT_USER from main badge table';		

			INSERT INTO CLEAR2WORK_EVENTUSER_NAME_MAP (
				EVENT_USER)
			SELECT DISTINCT
				EVENT_USER
			FROM
				CLEAR2WORK_BADGE bdg
			WHERE
				MAX_ID <> ' '
			AND EVENT_USER LIKE 'User Entry:%'
			AND EVENT_USER NOT LIKE '% - %';
		END IF;

        -- STEP 20: check if the update is for only NEW records
		v_step_id := 20;
		v_step_desc := 'check if the update is for only NEW records';
        		
		IF (p_upd_type = 'NEW') THEN

			-- STEP 25: Populate distinct EVENT_USER from badge staging table
			v_step_id := 25;
			v_step_desc := 'Populate distinct EVENT_USER from badge staging table';		

			INSERT INTO CLEAR2WORK_EVENTUSER_NAME_MAP (
				EVENT_USER)
			SELECT DISTINCT
				EVENT_USER
			FROM
				CLEAR2WORK_BADGE_STG bdg
			WHERE
				REC_STATUS = 'NEW'
			AND MAX_ID <> ' '
			AND EVENT_USER LIKE 'User Entry:%'
			AND EVENT_USER NOT LIKE '% - %'
			AND NOT EXISTS (SELECT 1 
							FROM CLEAR2WORK_EVENTUSER_NAME_MAP mp
							WHERE mp.EVENT_USER = bdg.EVENT_USER);
		
		END IF;

		-- STEP 30: Populate FULL_NAME after applying data wrangling
		v_step_id := 30;
		v_step_desc := 'Populate FULL_NAME after applying data wrangling';
		 
		UPDATE CLEAR2WORK_EVENTUSER_NAME_MAP mp
		SET FULL_NAME = COALESCE(
                        (SELECT MAX(TRIM(REPLACE(TRIM(REPLACE(TRIM(REPLACE(mp.EVENT_USER,'User Entry:',' ')),dw.PREFIX_TEXT, ' ')),dw.SUFFIX_TEXT, ' ')))
		                 FROM CLEAR2WORK_DATA_WRANG_PATTERN dw
		                 WHERE INSTR(mp.EVENT_USER, dw.PREFIX_TEXT) > 0
		                 AND INSTR(mp.EVENT_USER, dw.SUFFIX_TEXT) > 0),
                         TRIM(REPLACE(mp.EVENT_USER,'User Entry:',' ')))
		   ,LAST_UPD_DT = SYSDATE
		WHERE mp.FULL_NAME IS NULL;

		-- STEP 35: Handle single word FULL_NAME
		v_step_id := 35;
		v_step_desc := 'Handle single word FULL_NAME';

		UPDATE CLEAR2WORK_EVENTUSER_NAME_MAP
		SET FIRST_NAME = FULL_NAME,
		    LAST_NAME = ' '
		WHERE FIRST_NAME IS NULL
		AND INSTR(FULL_NAME,' ') = 0;
		
		-- STEP 40: update the FIRST_NAME and LAST_NAME fields
		v_step_id := 40;
		v_step_desc := 'update the FIRST_NAME and LAST_NAME fields';

		UPDATE CLEAR2WORK_EVENTUSER_NAME_MAP
		SET FIRST_NAME = TRIM(SUBSTR(FULL_NAME, 1, INSTR(FULL_NAME,' ')-1)),
		    LAST_NAME = TRIM(SUBSTR(FULL_NAME, INSTR(FULL_NAME,' ')+1,100))
		WHERE FIRST_NAME IS NULL
		AND INSTR(FULL_NAME,' ') > 0;

		-- STEP 45: Update multiple word valid LAST_NAME
		v_step_id := 45;
		v_step_desc := 'Update multiple word valid LAST_NAME';

		UPDATE CLEAR2WORK_EVENTUSER_NAME_MAP mp
		SET LAST_NAME = COALESCE((SELECT lst.LAST_NAME
		                 FROM CLEAR2WORK_LASTNAME_LIST lst
						 WHERE lst.IS_VALID  = 'Y'
						 AND INSTR(mp.LAST_NAME, lst.LAST_NAME)>0),LAST_NAME);
						 		
		-- STEP 50: split the LAST_NAME when last word is INVALID
		v_step_id := 50;
		v_step_desc := 'split the LAST_NAME when last word is INVALID';

		FOR v_loop_ind IN 1..6 LOOP
			UPDATE CLEAR2WORK_EVENTUSER_NAME_MAP
			SET LAST_NAME = TRIM(SUBSTR(LAST_NAME,1,INSTR(LAST_NAME,' ')-1))
			WHERE LAST_NAME NOT IN (SELECT LAST_NAME FROM CLEAR2WORK_LASTNAME_LIST WHERE IS_VALID = 'Y')
			AND INSTR(LAST_NAME,' ') > 0
			AND SUBSTR(LAST_NAME, INSTR(LAST_NAME,' ')+1, 100) IN (SELECT LAST_NAME FROM CLEAR2WORK_LASTNAME_LIST WHERE IS_VALID = 'N');
		END LOOP;

		-- STEP 55: split the LAST_NAME when last word is VALID
		v_step_id := 55;
		v_step_desc := 'split the LAST_NAME when last word is VALID';

		FOR v_loop_ind IN 1..6 LOOP
			UPDATE CLEAR2WORK_EVENTUSER_NAME_MAP
			SET LAST_NAME = TRIM(SUBSTR(LAST_NAME,INSTR(LAST_NAME,' ')+1, 100))
			WHERE LAST_NAME NOT IN (SELECT LAST_NAME FROM CLEAR2WORK_LASTNAME_LIST WHERE IS_VALID = 'Y')
			AND INSTR(LAST_NAME,' ') > 0
			AND SUBSTR(LAST_NAME, INSTR(LAST_NAME,' ')+1, 100) NOT IN (SELECT LAST_NAME FROM CLEAR2WORK_LASTNAME_LIST WHERE IS_VALID = 'N');
		END LOOP;
		
        -- STEP 999: Commit all changes
        v_step_id := 999;
        v_step_desc := 'Commit all changes';
        
        COMMIT;
        RETURN 0;
		
        -- STEP 1000: Exception Handling
        EXCEPTION
            WHEN OTHERS THEN
                ADD_CLEAR2WORK_LOG ($$PLSQL_UNIT || '.UPDATE_EVENTUSER_NAME_MAP function : ' || SUBSTR(SQLERRM,1,200), 'ERROR', SQLCODE, p_job_id, v_step_id, v_step_desc);
				
				UPDATE
					CLEAR2WORK_JOB_STATUS
				SET 
					JOB_STATUS = 'FAILED',
					DESCRIPTION = 'REFER THE CLEAR2WORK_JOB_LOG TABLE FOR THE FAILURE REASONS',
					JOB_END_DT = SYSDATE,
					LAST_UPD_DT = SYSDATE
				WHERE
					JOB_ID = p_job_id;                

				COMMIT;
				RETURN 1; 
    END;
    -- END FUNCTION UPDATE_EVENTUSER_NAME_MAP
	
END;
/
-- BEGIN PACKAGE BODY CLEAR2WORK_JOB

ALTER SESSION SET plsql_code_type = interpreted;
