CREATE OR REPLACE Package MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    Procedure Insert_STATS_BATCH_MODULE_LAUNCH;
    Procedure Update_STATS_BATCH_MODULE_LAUNCH;
    Procedure Delete_STATS_BATCH_MODULE_LAUNCH;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_STATS_BATCH_MODULE_LAUNCH(p_job_id number default 0);

END NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG;



CREATE OR REPLACE PACKAGE BODY MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG AS

	-- USED FOR THE CORP_ETL_ERROR_LOG
	GV_PARENT_JOB_ID          	NUMBER				:= 0;
	GV_ERROR_CODE				VARCHAR2(50)		:= NULL;
	GV_ERROR_MESSAGE			VARCHAR2(4000)		:= NULL;
	GV_ERROR_FIELD				VARCHAR2(400)		:= NULL;
	GV_ERROR_CODES				VARCHAR2(400)		:= NULL;
	GV_ERR_DATE					DATE				:= SYSDATE;
	GV_ERR_LEVEL				VARCHAR2(20)		:= 'CRITICAL';
	GV_PROCESS_NAME				VARCHAR2(120)		:= 'NYHIX_MFB_V2';
	GV_JOB_NAME					VARCHAR2(120)		:= ''; --'Mail Fax Batch V2'
	GV_DRIVER_TABLE_NAME  		VARCHAR2(100 BYTE)	:= 'NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH';
	GV_DRIVER_KEY_NUMBER  		VARCHAR2(100 BYTE)	:= NULL;
	GV_NR_OF_ERROR        		NUMBER				:= 0;
    GV_UPDATE_TS                DATE                := SYSDATE;

	-- USED FOR THE CORP_ETL_JOB_STATISTICS
	GV_JOB_ID                 	NUMBER              := 0;
	GV_JOB_STATUS_CD          	VARCHAR2(20 BYTE)   := 'STARTED';
	GV_FILE_NAME              	VARCHAR2(512 BYTE)	:= 'NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH';
	GV_RECORD_COUNT           	NUMBER				:= 0;
	GV_ERROR_COUNT            	NUMBER				:= 0;
	GV_WARNING_COUNT          	NUMBER				:= 0;
	GV_PROCESSED_COUNT        	NUMBER				:= 0;
	GV_RECORD_INSERTED_COUNT  	NUMBER				:= 0;
	GV_RECORD_UPDATED_COUNT   	NUMBER				:= 0;
	GV_JOB_START_DATE         	DATE				:= SYSDATE;
	GV_JOB_END_DATE           	DATE				:= SYSDATE;


	-------------------------------------------------------------------------------------------
	-- THE CURSOR USES SQL FROM QUERIES 1, 2, 3 AND 4
	-------------------------------------------------------------------------------------------

	CURSOR JOIN_CSR IS
	WITH SRC AS
	(
	SELECT 
		ROWID    							 	AS SRC_ROWID,

		-- SQL FROM QUERY 1
		SRC.OLTP_LOAD_SEQ						AS SRC_OLTP_LOAD_SEQ,
		SRC.OLTP_LOAD_DATE_TIME					AS SRC_OLTP_LOAD_DATE_TIME,
        SRC.SOURCE_SERVER                       AS SRC_SOURCE_SERVER,	-- 1 	1
         --            SRC.BATCH_GUID                           AS SRC_BATCH_GUID,	-- 1 	2
         --    SRC.MFB_V2_CREATE_DATE                   AS SRC_MFB_V2_CREATE_DATE,	-- 1 	3
         --    SRC.MFB_V2_UPDATE_DATE                   AS SRC_MFB_V2_UPDATE_DATE,	-- 1 	4
        SRC.MODULE_LAUNCH_ID                    AS SRC_MODULE_LAUNCH_ID,	-- 1 	5
        SRC.START_DATE_TIME                     AS SRC_START_DATE_TIME,	-- 1 	6
        SRC.END_DATE_TIME                       AS SRC_END_DATE_TIME,	-- 1 	7
        SRC.MODULE_UNIQUE_ID                    AS SRC_MODULE_UNIQUE_ID,	-- 1 	8
        SRC.MODULE_NAME                         AS SRC_MODULE_NAME,	-- 1 	9
        SRC.USER_ID                             AS SRC_USER_ID,	-- 1 	10
        SRC.USER_NAME                           AS SRC_USER_NAME,	-- 1 	11
        SRC.STATION_ID                          AS SRC_STATION_ID,	-- 1 	12
        SRC.SITE_NAME                           AS SRC_SITE_NAME,	-- 1 	13
        SRC.SITE_ID                             AS SRC_SITE_ID,	-- 1 	14
        SRC.IN_PROCESS_TID                      AS SRC_IN_PROCESS_TID,	-- 1 	15
        SRC.ORPHANED                            AS SRC_ORPHANED,	-- 1 	16
        SRC.COMPLETED_TID                       AS SRC_COMPLETED_TID		-- 1 	17
	FROM MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_OLTP SRC
	),
	TARGET AS
	(
	SELECT 
		ROWID    						  AS TARGET_ROWID,
		-- SQL FROM QUERY 2
        TARGET.SOURCE_SERVER                     AS TARGET_SOURCE_SERVER,	-- 2 	1
     --             TARGET.BATCH_GUID                        AS TARGET_BATCH_GUID,	-- 2 	2
    --      TARGET.MFB_V2_CREATE_DATE                AS TARGET_MFB_V2_CREATE_DATE,	-- 2 	3
   --       TARGET.MFB_V2_UPDATE_DATE                AS TARGET_MFB_V2_UPDATE_DATE,	-- 2 	4
        TARGET.MODULE_LAUNCH_ID                  AS TARGET_MODULE_LAUNCH_ID,	-- 2 	5
        TARGET.START_DATE_TIME                   AS TARGET_START_DATE_TIME,	-- 2 	6
        TARGET.END_DATE_TIME                     AS TARGET_END_DATE_TIME,	-- 2 	7
        TARGET.MODULE_UNIQUE_ID                  AS TARGET_MODULE_UNIQUE_ID,	-- 2 	8
        TARGET.MODULE_NAME                       AS TARGET_MODULE_NAME,	-- 2 	9
        TARGET.USER_ID                           AS TARGET_USER_ID,	-- 2 	10
        TARGET.USER_NAME                         AS TARGET_USER_NAME,	-- 2 	11
        TARGET.STATION_ID                        AS TARGET_STATION_ID,	-- 2 	12
        TARGET.SITE_NAME                         AS TARGET_SITE_NAME,	-- 2 	13
        TARGET.SITE_ID                           AS TARGET_SITE_ID,	-- 2 	14
        TARGET.IN_PROCESS_TID                    AS TARGET_IN_PROCESS_TID,	-- 2 	15
        TARGET.ORPHANED                          AS TARGET_ORPHANED,	-- 2 	16
        TARGET.COMPLETED_TID                     AS TARGET_COMPLETED_TID		-- 2 	17
	FROM MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH TARGET
	)
	SELECT 
		SRC_ROWID,
		TARGET_ROWID,
		-- insert SQL from 3 and 4 here
		SRC_OLTP_LOAD_SEQ,
		SRC_OLTP_LOAD_DATE_TIME,
                              SRC_SOURCE_SERVER,                      	-- 3 	1
                    --          SRC_BATCH_GUID,                         	-- 3 	2
                    --        SRC_MFB_V2_CREATE_DATE,                 	-- 3 	3
                    --          SRC_MFB_V2_UPDATE_DATE,                 	-- 3 	4
                              SRC_MODULE_LAUNCH_ID,                   	-- 3 	5
                              SRC_START_DATE_TIME,                    	-- 3 	6
                              SRC_END_DATE_TIME,                      	-- 3 	7
                              SRC_MODULE_UNIQUE_ID,                   	-- 3 	8
                              SRC_MODULE_NAME,                        	-- 3 	9
                              SRC_USER_ID,                            	-- 3 	10
                              SRC_USER_NAME,                          	-- 3 	11
                              SRC_STATION_ID,                         	-- 3 	12
                              SRC_SITE_NAME,                          	-- 3 	13
                              SRC_SITE_ID,                            	-- 3 	14
                              SRC_IN_PROCESS_TID,                     	-- 3 	15
                              SRC_ORPHANED,                           	-- 3 	16
                              SRC_COMPLETED_TID,                      	-- 3 	17
                              TARGET_SOURCE_SERVER,                   	-- 4 	1
                          --    TARGET_BATCH_GUID,                      	-- 4 	2
                          --    TARGET_MFB_V2_CREATE_DATE,              	-- 4 	3
                         --     TARGET_MFB_V2_UPDATE_DATE,              	-- 4 	4
                              TARGET_MODULE_LAUNCH_ID,                	-- 4 	5
                              TARGET_START_DATE_TIME,                 	-- 4 	6
                              TARGET_END_DATE_TIME,                   	-- 4 	7
                              TARGET_MODULE_UNIQUE_ID,                	-- 4 	8
                              TARGET_MODULE_NAME,                     	-- 4 	9
                              TARGET_USER_ID,                         	-- 4 	10
                              TARGET_USER_NAME,                       	-- 4 	11
                              TARGET_STATION_ID,                      	-- 4 	12
                              TARGET_SITE_NAME,                       	-- 4 	13
                              TARGET_SITE_ID,                         	-- 4 	14
                              TARGET_IN_PROCESS_TID,                  	-- 4 	15
                              TARGET_ORPHANED,                        	-- 4 	16
                              TARGET_COMPLETED_TID                   	-- 4 	17
	FROM SRC
	LEFT OUTER JOIN TARGET
	ON SRC_Module_Launch_ID = TARGET_Module_Launch_ID
--	and SRC_BATCH_GUID = TARGET_BATCH_GUID
--	and SRC_Batch_Module_ID = TARGET_Batch_Module_ID
--	AND NOT (SRC_SOURCE_SERVER = 'REMOTE'
--	AND TARGET_SOURCE_SERVER = 'CENTRAL' )
	ORDER BY 
--	SRC_BATCH_GUID, SRC_Batch_Module_ID, 
	SRC_START_DATE_TIME;

	JOIN_REC   JOIN_CSR%ROWTYPE;

-----------------------------------------------------
PROCEDURE LOAD_STATS_BATCH_MODULE_LAUNCH (P_JOB_ID number default 0) 
IS
-----------------------------------------------------

	BEGIN

		-- INITIAL SET Setup
        GV_RECORD_COUNT           	:= 0;
        GV_ERROR_COUNT            	:= 0;
        GV_WARNING_COUNT          	:= 0;
        GV_PROCESSED_COUNT        	:= 0;
        GV_RECORD_INSERTED_COUNT  	:= 0;
        GV_RECORD_UPDATED_COUNT   	:= 0;

		GV_PARENT_JOB_ID := P_JOB_ID;

		GV_JOB_ID 	:= SEQ_JOB_ID.NEXTVAL;

        GV_JOB_NAME	:= GV_PROCESS_NAME;			

		Insert_Corp_ETL_Job_Statistics;

		IF (JOIN_CSR%ISOPEN)
		THEN
			CLOSE JOIN_CSR;
		END IF;

		OPEN JOIN_CSR;

		LOOP

			FETCH JOIN_CSR INTO JOIN_REC;

			EXIT WHEN JOIN_CSR%NOTFOUND;

			GV_RECORD_COUNT := GV_RECORD_COUNT+1;

			IF JOIN_REC.SRC_ROWID IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN Update_STATS_BATCH_MODULE_LAUNCH;
			ELSIF JOIN_REC.SRC_ROWID IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NULL 
                --then null;
				THEN INSERT_STATS_BATCH_MODULE_LAUNCH;
			ELSIF JOIN_REC.SRC_ROWID IS NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN DELETE_STATS_BATCH_MODULE_LAUNCH;
			ELSE
				NULL;
			END IF;	

		END LOOP;

		COMMIT;

		IF (JOIN_CSR%ISOPEN)
		THEN
			CLOSE JOIN_CSR;
		END IF;

	-- Post the job statistics	
		DBMS_OUTPUT.PUT_LINE('GV_PROCESSED_COUNT: '||GV_PROCESSED_COUNT);
		DBMS_OUTPUT.PUT_LINE('GV_RECORD_INSERTED_COUNT: '||GV_RECORD_INSERTED_COUNT);
		DBMS_OUTPUT.PUT_LINE('GV_RECORD_UPDATED_COUNT: '||GV_RECORD_UPDATED_COUNT);

		GV_JOB_STATUS_CD          	:= 'COMPLETED';
		GV_JOB_END_DATE				:= SYSDATE;

		Update_Corp_ETL_Job_Statistics;



	EXCEPTION

		WHEN NO_DATA_FOUND
		THEN
			NULL;

        WHEN OTHERS THEN

            GV_ERROR_CODE := SQLCODE;
            GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 3000);                 

			DBMS_OUTPUT.PUT_LINE('Main Cursor failure for '||
				'SRC_DB_RECORD_NUM: '||JOIN_REC.SRC_MODULE_LAUNCH_ID
				||' TARGET_DB_RECORD_NUM: '||JOIN_REC.TARGET_MODULE_LAUNCH_ID
				||'SQLCODE '||GV_ERROR_CODE
				||' '||GV_ERROR_MESSAGE);

			ROLLBACK;

			RAISE;

END Load_STATS_BATCH_MODULE_LAUNCH;

-----------------------------------------------------

-----------------------------------------------------
PROCEDURE UPDATE_STATS_BATCH_MODULE_LAUNCH IS
PRAGMA AUTONOMOUS_TRANSACTION;
-- USES SQL FROM 5 AND 6
-----------------------------------------------------

	BEGIN

	-- COMPARE  -- SQL FROM QUERY 5
		IF 1=2
            OR NVL(JOIN_REC.TARGET_MODULE_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_NAME,'-?93333')	-- 5 	9	VARCHAR2
            OR NVL(JOIN_REC.TARGET_USER_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_USER_ID,'-?93333')	-- 5 	10	VARCHAR2
            OR NVL(JOIN_REC.TARGET_USER_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_USER_NAME,'-?93333')	-- 5 	11	VARCHAR2
            OR NVL(JOIN_REC.TARGET_STATION_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_STATION_ID,'-?93333')	-- 5 	12	VARCHAR2
            OR NVL(JOIN_REC.TARGET_SITE_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_SITE_NAME,'-?93333')	-- 5 	13	VARCHAR2
            OR NVL(JOIN_REC.TARGET_SITE_ID, -93333)	  <>  	NVL(JOIN_REC.SRC_SITE_ID, -93333)	-- 5 	14	NUMBER
            OR NVL(JOIN_REC.TARGET_IN_PROCESS_TID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_IN_PROCESS_TID,'-?93333')	-- 5 	15	VARCHAR2
            OR NVL(JOIN_REC.TARGET_ORPHANED, -93333)	  <>  	NVL(JOIN_REC.SRC_ORPHANED, -93333)	-- 5 	16	NUMBER
            OR NVL(JOIN_REC.TARGET_COMPLETED_TID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_COMPLETED_TID,'-?93333')	-- 5 	17	VARCHAR2
            OR NVL(JOIN_REC.TARGET_SOURCE_SERVER,'-?93333')	  <>  	NVL(JOIN_REC.SRC_SOURCE_SERVER,'-?93333')	-- 5 	1	VARCHAR2
         --   OR NVL(JOIN_REC.TARGET_BATCH_GUID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_GUID,'-?93333')	-- 5 	2	VARCHAR2
         --   OR NVL(JOIN_REC.TARGET_MFB_V2_CREATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_CREATE_DATE,SYSDATE - 93333)	-- 5 	3	DATE
         --   OR NVL(JOIN_REC.TARGET_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	-- 5 	4	DATE
            OR NVL(JOIN_REC.TARGET_MODULE_LAUNCH_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_LAUNCH_ID,'-?93333')	-- 5 	5	VARCHAR2
            ---
			OR to_char(JOIN_REC.TARGET_START_DATE_TIME,'yyyymmdd hh24:mi:ss') <> to_char(to_timestamp(join_rec.src_start_date_time,'dd-mon-yy hh.mi.ss.ff am'),'yyyymmdd hh24:mi:ss')	-- 5 	6	DATE
            ---
			OR to_char(JOIN_REC.TARGET_END_DATE_TIME,'yyyymmdd hh24:mi:ss')  <> to_char(to_timestamp(join_rec.src_end_date_time,'dd-mon-yy hh.mi.ss.ff am'),'yyyymmdd hh24:mi:ss')	-- 5 	7	DATE
            ---
			OR NVL(JOIN_REC.TARGET_MODULE_UNIQUE_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_UNIQUE_ID,'-?93333')	-- 5 	8	VARCHAR2
	THEN
		UPDATE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH
		SET  
		-- THE UPDATE  SQL FROM QUERY 6
            SOURCE_SERVER                             =  JOIN_REC.SRC_SOURCE_SERVER,	-- 6 	1
         --   BATCH_GUID                                =  JOIN_REC.SRC_BATCH_GUID,	-- 6 	2
        --    MFB_V2_CREATE_DATE                        =  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 6 	3
        --    MFB_V2_UPDATE_DATE                        =  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 6 	4
            MODULE_LAUNCH_ID                          =  JOIN_REC.SRC_MODULE_LAUNCH_ID,	-- 6 	5
            START_DATE_TIME                           =  to_timestamp(JOIN_REC.SRC_START_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 6 	6
            END_DATE_TIME                             =  to_timestamp(JOIN_REC.SRC_END_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 6 	7
            MODULE_UNIQUE_ID                          =  JOIN_REC.SRC_MODULE_UNIQUE_ID,	-- 6 	8
            MODULE_NAME                               =  JOIN_REC.SRC_MODULE_NAME,	-- 6 	9
            USER_ID                                   =  JOIN_REC.SRC_USER_ID,	-- 6 	10
            USER_NAME                                 =  JOIN_REC.SRC_USER_NAME,	-- 6 	11
            STATION_ID                                =  JOIN_REC.SRC_STATION_ID,	-- 6 	12
            SITE_NAME                                 =  JOIN_REC.SRC_SITE_NAME,	-- 6 	13
            SITE_ID                                   =  JOIN_REC.SRC_SITE_ID,	-- 6 	14
            IN_PROCESS_TID                            =  JOIN_REC.SRC_IN_PROCESS_TID,	-- 6 	15
            ORPHANED                                  =  JOIN_REC.SRC_ORPHANED,	-- 6 	16
            COMPLETED_TID                             =  JOIN_REC.SRC_COMPLETED_TID,		-- 6 	17
			MFB_V2_PARENT_JOB_ID					  =  GV_PARENT_JOB_ID	
		WHERE ROWID = JOIN_REC.TARGET_ROWID;


		DBMS_OUTPUT.PUT_LINE('UPDATE MADE TO TARGET ROW_ID '||JOIN_REC.TARGET_ROWID);

		COMMIT;

		GV_RECORD_UPDATED_COUNT := GV_RECORD_UPDATED_COUNT + 1;
		GV_PROCESSED_COUNT := GV_PROCESSED_COUNT + 1;

	ELSE
		NULL; -- NO UPDATE REQUIRED
	END IF;	

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('UPDATE FAILURE '
            ||JOIN_REC.SRC_MODULE_LAUNCH_ID||' '
            ||JOIN_REC.SRC_rowid||' '
            ||JOIN_REC.target_rowid);

		GV_DRIVER_KEY_NUMBER  	:= 'SRC_OLTP_LOAD_SEQ : '||JOIN_REC.SRC_OLTP_LOAD_SEQ;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_STATS_BATCH_MODULE_LAUNCH_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
--		GV_PROCESS_NAME 		:= 'Update_STATS_BATCH_MODULE_LAUNCH';

		POST_ERROR;

	END UPDATE_STATS_BATCH_MODULE_LAUNCH;	

-----------------------------------------------------
PROCEDURE INSERT_STATS_BATCH_MODULE_LAUNCH IS
-- USES SQL  FROM 7 AND 8
-----------------------------------------------------

	BEGIN

		INSERT INTO MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH
		(   -- INSERT PART 1 SQL FROM QUERY 7
            SOURCE_SERVER,                          	-- 7 	1
         --   BATCH_GUID,                             	-- 7 	2
        --    MFB_V2_CREATE_DATE,                     	-- 7 	3
        --    MFB_V2_UPDATE_DATE,                     	-- 7 	4
            MODULE_LAUNCH_ID,                       	-- 7 	5
            START_DATE_TIME,                        	-- 7 	6
            END_DATE_TIME,                          	-- 7 	7
            MODULE_UNIQUE_ID,                       	-- 7 	8
            MODULE_NAME,                            	-- 7 	9
            USER_ID,                                	-- 7 	10
            USER_NAME,                              	-- 7 	11
            STATION_ID,                             	-- 7 	12
            SITE_NAME,                              	-- 7 	13
            SITE_ID,                                	-- 7 	14
            IN_PROCESS_TID,                         	-- 7 	15
            ORPHANED,                               	-- 7 	16
            COMPLETED_TID,                          	-- 7 	17
			MFB_V2_PARENT_JOB_ID
		)
		VALUES ( -- INSERT PART 2 SQL FROM QUERY 8
            JOIN_REC.SRC_SOURCE_SERVER,		-- 8 	1
         --   JOIN_REC.SRC_BATCH_GUID,		-- 8 	2
         --   JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	3
         --   JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	4
            JOIN_REC.SRC_MODULE_LAUNCH_ID,	-- 8 	5
            to_timestamp(JOIN_REC.SRC_START_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 8 	6
            to_timestamp(JOIN_REC.SRC_END_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 8 	7
            JOIN_REC.SRC_MODULE_UNIQUE_ID,	-- 8 	8
            JOIN_REC.SRC_MODULE_NAME,		-- 8 	9
            JOIN_REC.SRC_USER_ID,			-- 8 	10
            JOIN_REC.SRC_USER_NAME,			-- 8 	11
            JOIN_REC.SRC_STATION_ID,		-- 8 	12
            JOIN_REC.SRC_SITE_NAME,			-- 8 	13
            JOIN_REC.SRC_SITE_ID,			-- 8 	14
            JOIN_REC.SRC_IN_PROCESS_TID,	-- 8 	15
            JOIN_REC.SRC_ORPHANED,			-- 8 	16
            JOIN_REC.SRC_COMPLETED_TID,		-- 8 	17
			GV_PARENT_JOB_ID	
			);

		GV_RECORD_INSERTED_COUNT := GV_RECORD_INSERTED_COUNT + 1;

		GV_PROCESSED_COUNT := GV_PROCESSED_COUNT + 1;

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE '
 --           ||JOIN_REC.SRC_DB_RECORD_NUM||' '
            ||JOIN_REC.SRC_rowid||' '
            ||JOIN_REC.target_rowid);

        -- '${MFB_V2_REMOTE_START_DATE}'
		GV_DRIVER_KEY_NUMBER  	:= 'SRC_OLTP_LOAD_SEQ : '||JOIN_REC.SRC_OLTP_LOAD_SEQ;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_STATS_BATCH_MODULE_LAUNCH_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
--		GV_PROCESS_NAME 		:= 'Update_STATS_BATCH_MODULE_LAUNCH';

		POST_ERROR;

	END INSERT_STATS_BATCH_MODULE_LAUNCH;	

-----------------------------------------------------
PROCEDURE DELETE_STATS_BATCH_MODULE_LAUNCH IS
-- IF THE JOIN CURSOR USES A FULL OUTTER JOIN THEN 
-- THIS PROCEDURE CAN BE USED TO IDENTIFY
-- ROECORDS DELETED FROM THE SORCE SYSTEM
-----------------------------------------------------

	BEGIN

		NULL;

		GV_PROCESSED_COUNT := GV_PROCESSED_COUNT + 1;

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('DELETE FAILURE'||' '
            ||JOIN_REC.SRC_rowid||' '
            ||JOIN_REC.target_rowid);

		Post_Error;

	END DELETE_STATS_BATCH_MODULE_LAUNCH;	


-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------
Procedure Insert_Corp_ETL_Job_Statistics IS
PRAGMA AUTONOMOUS_TRANSACTION;
-----------------------------------------------------
BEGIN

	INSERT INTO MAXDAT.CORP_ETL_JOB_STATISTICS (
		ERROR_COUNT, 
		FILE_NAME, 
		JOB_END_DATE, 
		JOB_ID, 
		JOB_NAME, 
		JOB_START_DATE, 
		JOB_STATUS_CD, 
		PARENT_JOB_ID, 
		PROCESSED_COUNT, 
		RECORD_COUNT, 
		RECORD_INSERTED_COUNT, 
		RECORD_UPDATED_COUNT, 
		WARNING_COUNT) 
	VALUES ( 
		GV_ERROR_COUNT, 			-- ERROR_COUNT 
		GV_FILE_NAME, 				-- FILE_NAME 
		GV_JOB_END_DATE, 			-- JOB_END_DATE 
		GV_JOB_ID, 					-- JOB_ID 
		GV_JOB_NAME, 				-- JOB_NAME 
		GV_JOB_START_DATE, 			-- JOB_START_DATE 
		GV_JOB_STATUS_CD, 			-- JOB_STATUS_CD 
		GV_PARENT_JOB_ID, 			-- PARENT_JOB_ID 
		GV_PROCESSED_COUNT, 		-- PROCESSED_COUNT 
		GV_RECORD_COUNT, 			-- RECORD_COUNT 
		GV_RECORD_INSERTED_COUNT,	-- RECORD_INSERTED_COUNT 
		GV_RECORD_UPDATED_COUNT, 	-- RECORD_UPDATED_COUNT 
		GV_WARNING_COUNT); 			-- WARNING_COUNT 

	COMMIT;

EXCEPTION
	WHEN OTHERS THEN
	RAISE;
END;	

-----------------------------------------------------
Procedure Update_Corp_ETL_Job_Statistics IS
PRAGMA AUTONOMOUS_TRANSACTION;
-----------------------------------------------------
BEGIN

	UPDATE MAXDAT.CORP_ETL_JOB_STATISTICS
	SET    
		ERROR_COUNT       		= GV_ERROR_COUNT,
		FILE_NAME            	= GV_FILE_NAME,
		JOB_END_DATE         	= GV_JOB_END_DATE,
--		JOB_ID                	= GV_JOB_ID,
		JOB_NAME              	= GV_JOB_NAME,
		JOB_START_DATE        	= GV_JOB_START_DATE,
		JOB_STATUS_CD         	= GV_JOB_STATUS_CD,
		PARENT_JOB_ID         	= GV_PARENT_JOB_ID,
		PROCESSED_COUNT       	= GV_PROCESSED_COUNT,
		RECORD_COUNT          	= GV_RECORD_COUNT,
		RECORD_INSERTED_COUNT 	= GV_RECORD_INSERTED_COUNT,
		RECORD_UPDATED_COUNT  	= GV_RECORD_UPDATED_COUNT,
		WARNING_COUNT         	= GV_WARNING_COUNT
	WHERE  
		JOB_ID                = GV_JOB_ID;	

	COMMIT;

EXCEPTION
	WHEN OTHERS THEN
	RAISE;
END;	

-----------------------------------------------------
PROCEDURE Post_Error IS
PRAGMA AUTONOMOUS_TRANSACTION;
-----------------------------------------------------
BEGIN

	GV_ERROR_COUNT := GV_ERROR_COUNT + 1;
	GV_NR_OF_ERROR := GV_NR_OF_ERROR + 1;

    GV_ERROR_CODES := SQLCODE;
    GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 3000);                 

	GV_ERR_DATE		:= SYSDATE;
	GV_ERROR_FIELD  := NULL;

	GV_UPDATE_TS 	:= SYSDATE;


	INSERT INTO MAXDAT.CORP_ETL_ERROR_LOG (
		--CEEL_ID, 
		--CREATE_TS, 
		DRIVER_KEY_NUMBER, 
		DRIVER_TABLE_NAME, 
		ERR_DATE, 
		ERR_LEVEL, 
		ERROR_CODES, 
		ERROR_DESC, ERROR_FIELD, 
		JOB_NAME, NR_OF_ERROR, PROCESS_NAME 
		--UPDATE_TS
		) 
	VALUES ( 
--		GV_CEEL_ID
--		GV_CREATE_TS,
		GV_DRIVER_KEY_NUMBER,
		GV_DRIVER_TABLE_NAME,
		SYSDATE,
		'CRITICAL',
		GV_ERROR_CODES,
		GV_ERROR_MESSAGE,
		GV_ERROR_FIELD,
		GV_JOB_NAME,
		GV_NR_OF_ERROR,
		GV_PROCESS_NAME
--		GV_UPDATE_TS 
		);

	COMMIT;

			INSERT INTO MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_OLTP_ERR
		(   -- INSERT PART 1 SQL FROM QUERY 7
		    OLTP_LOAD_SEQ,
			OLTP_LOAD_DATE_TIME,
            SOURCE_SERVER,                          	-- 7 	1
         --   BATCH_GUID,                             	-- 7 	2
        --    MFB_V2_CREATE_DATE,                     	-- 7 	3
        --    MFB_V2_UPDATE_DATE,                     	-- 7 	4
            MODULE_LAUNCH_ID,                       	-- 7 	5
            START_DATE_TIME,                        	-- 7 	6
            END_DATE_TIME,                          	-- 7 	7
            MODULE_UNIQUE_ID,                       	-- 7 	8
            MODULE_NAME,                            	-- 7 	9
            USER_ID,                                	-- 7 	10
            USER_NAME,                              	-- 7 	11
            STATION_ID,                             	-- 7 	12
            SITE_NAME,                              	-- 7 	13
            SITE_ID,                                	-- 7 	14
            IN_PROCESS_TID,                         	-- 7 	15
            ORPHANED,                               	-- 7 	16
            COMPLETED_TID                          	-- 7 	17
		)
		VALUES ( -- INSERT PART 2 SQL FROM QUERY 8
			JOIN_REC.SRC_OLTP_LOAD_SEQ,
			JOIN_REC.SRC_OLTP_LOAD_DATE_TIME,
            JOIN_REC.SRC_SOURCE_SERVER,	-- 8 	1
         --   JOIN_REC.SRC_BATCH_GUID,	-- 8 	2
         --   JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	3
         --   JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	4
            JOIN_REC.SRC_MODULE_LAUNCH_ID,	-- 8 	5
            JOIN_REC.SRC_START_DATE_TIME,	-- 8 	6
            JOIN_REC.SRC_END_DATE_TIME,	-- 8 	7
            JOIN_REC.SRC_MODULE_UNIQUE_ID,	-- 8 	8
            JOIN_REC.SRC_MODULE_NAME,	-- 8 	9
            JOIN_REC.SRC_USER_ID,	-- 8 	10
            JOIN_REC.SRC_USER_NAME,	-- 8 	11
            JOIN_REC.SRC_STATION_ID,	-- 8 	12
            JOIN_REC.SRC_SITE_NAME,	-- 8 	13
            JOIN_REC.SRC_SITE_ID,	-- 8 	14
            JOIN_REC.SRC_IN_PROCESS_TID,	-- 8 	15
            JOIN_REC.SRC_ORPHANED,	-- 8 	16
            JOIN_REC.SRC_COMPLETED_TID	-- 8 	17
			);

	COMMIT;


EXCEPTION

	When Others then 
		GV_ERROR_CODE := SQLCODE;
		GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 3000);                 
	DBMS_OUTPUT.PUT_LINE('Procedure Post_Error failed with '||GV_Error_Code||': '||GV_Error_Message);

	--RAISE;


END;

END NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG;



GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG TO MAXDAT_PFP_READ_ONLY;
GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG TO MAXDAT_READ_ONLY;

