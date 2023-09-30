CREATE OR REPLACE PACKAGE MAXDAT."NYHIX_MFB_V2_BATCH_EVENT_PKG" AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $';
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    Procedure Insert_EVENTS;
    Procedure Update_EVENTS;
    Procedure Delete_EVENTS;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_EVENTS ( p_job_id number default 0);

END NYHIX_MFB_V2_BATCH_EVENT_PKG;


CREATE OR REPLACE PACKAGE BODY MAXDAT.NYHIX_MFB_V2_BATCH_EVENT_PKG AS

	-- USED FOR THE CORP_ETL_ERROR_LOG
	GV_PARENT_JOB_ID          	NUMBER				:= 0;
	GV_ERROR_CODE				VARCHAR2(50)		:= NULL;
	GV_ERROR_MESSAGE			VARCHAR2(4000)		:= NULL;
	GV_ERROR_FIELD				VARCHAR2(400)		:= NULL;
	GV_ERROR_CODES				VARCHAR2(400)		:= NULL;
	GV_ERR_DATE					DATE				:= SYSDATE;
	GV_ERR_LEVEL				VARCHAR2(20)		:= 'CRITICAL';
	GV_PROCESS_NAME				VARCHAR2(120)		:= 'NYHIX_MFB_V2';
	GV_JOB_NAME					VARCHAR2(120)		:= '';
	GV_DRIVER_TABLE_NAME  		VARCHAR2(100 BYTE)	:= 'NYHIX_MFB_V2_BATCH_EVENT';
	GV_DRIVER_KEY_NUMBER  		VARCHAR2(100 BYTE)	:= NULL;
	GV_NR_OF_ERROR        		NUMBER				:= 0;
    GV_UPDATE_TS                DATE                := SYSDATE;

	-- USED FOR THE CORP_ETL_JOB_STATISTICS
	GV_JOB_ID                 	NUMBER              := 0;
	GV_JOB_STATUS_CD          	VARCHAR2(20 BYTE)   := 'STARTED';
	GV_FILE_NAME              	VARCHAR2(512 BYTE)	:= 'NYHIX_MFB_V2_EVENT';
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
		-- ROWID    							 AS SRC_ROWID,
		-- Insert SQL from Query 1 section 1 Here
	--	SRC.MFB_V2_CREATE_DATE                   AS SRC_MFB_V2_CREATE_DATE,   	-- 1 	1
	--	SRC.MFB_V2_UPDATE_DATE                   AS SRC_MFB_V2_UPDATE_DATE,   	-- 1 	2
                SRC.BATCH_MODULE_ID                      AS SRC_BATCH_MODULE_ID,	-- 1 	1
                     SRC.BATCH_GUID                           AS SRC_BATCH_GUID,	-- 1 	2
               SRC.MODULE_LAUNCH_ID                     AS SRC_MODULE_LAUNCH_ID,	-- 1 	3  << Prime Key for StatsModuleLaunch
               SRC.MODULE_UNIQUE_ID                     AS SRC_MODULE_UNIQUE_ID,	-- 1 	4
                     SRC.MODULE_NAME                           AS SRC_MODULE_NAME,	-- 1 	5
         SRC.MODULE_CLOSE_UNIQUE_ID               AS SRC_MODULE_CLOSE_UNIQUE_ID,	-- 1 	6
              SRC.MODULE_CLOSE_NAME                    AS SRC_MODULE_CLOSE_NAME,	-- 1 	7
                   SRC.BATCH_STATUS                         AS SRC_BATCH_STATUS,	-- 1 	8
                SRC.START_DATE_TIME                      AS SRC_START_DATE_TIME,	-- 1 	9
                  SRC.END_DATE_TIME                        AS SRC_END_DATE_TIME,	-- 1 	10
                      SRC.USER_NAME                            AS SRC_USER_NAME,	-- 1 	11
                        SRC.USER_ID                              AS SRC_USER_ID,	-- 1 	12
                     SRC.STATION_ID                           AS SRC_STATION_ID,	-- 1 	13
                      SRC.SITE_NAME                            AS SRC_SITE_NAME,	-- 1 	14
                        SRC.SITE_ID                              AS SRC_SITE_ID,	-- 1 	15
                        SRC.DELETED                              AS SRC_DELETED,	-- 1 	16
             SRC.PAGES_PER_DOCUMENT                   AS SRC_PAGES_PER_DOCUMENT,	-- 1 	17
                  SRC.PAGES_SCANNED                        AS SRC_PAGES_SCANNED,	-- 1 	18
                  SRC.PAGES_DELETED                        AS SRC_PAGES_DELETED,	-- 1 	19
              SRC.DOCUMENTS_CREATED                    AS SRC_DOCUMENTS_CREATED,	-- 1 	20
              SRC.DOCUMENTS_DELETED                    AS SRC_DOCUMENTS_DELETED,	-- 1 	21
                 SRC.PAGES_REPLACED                       AS SRC_PAGES_REPLACED,	-- 1 	22
                     SRC.ERROR_TEXT                           AS SRC_ERROR_TEXT,	-- 1 	23
                   SRC.EXTRACT_DATE                         AS SRC_EXTRACT_DATE,	-- 1 	24
                  SRC.SOURCE_SERVER                        AS SRC_SOURCE_SERVER,	-- 1 	25
                  SRC.PRIORITY                             AS SRC_PRIORITY,
					SRC.SML_MODULE_NAME					AS SRC_SML_MODULE_NAME	
    FROM MAXDAT.NYHIX_MFB_V2_EVENTS_OLTP_V SRC
	),
	TARGET AS
	(
	SELECT 
		ROWID    						  AS TARGET_ROWID,
		-- Insert SQL from Query 1 section 2 Here
	--	TARGET.MFB_V2_CREATE_DATE                AS TARGET_MFB_V2_CREATE_DATE,	-- 2 	1
	--	TARGET.MFB_V2_UPDATE_DATE                AS TARGET_MFB_V2_UPDATE_DATE,	-- 2 	2
             TARGET.BATCH_MODULE_ID                   AS TARGET_BATCH_MODULE_ID,	-- 2 	1
                  TARGET.BATCH_GUID                        AS TARGET_BATCH_GUID,	-- 2 	2
            TARGET.MODULE_LAUNCH_ID                  AS TARGET_MODULE_LAUNCH_ID,	-- 2 	3
            TARGET.MODULE_UNIQUE_ID                  AS TARGET_MODULE_UNIQUE_ID,	-- 2 	4
                  TARGET.MODULE_NAME                        AS TARGET_MODULE_NAME,	-- 2 	5
      TARGET.MODULE_CLOSE_UNIQUE_ID            AS TARGET_MODULE_CLOSE_UNIQUE_ID,	-- 2 	6
           TARGET.MODULE_CLOSE_NAME                 AS TARGET_MODULE_CLOSE_NAME,	-- 2 	7
                TARGET.BATCH_STATUS                      AS TARGET_BATCH_STATUS,	-- 2 	8
             TARGET.START_DATE_TIME                   AS TARGET_START_DATE_TIME,	-- 2 	9
               TARGET.END_DATE_TIME                     AS TARGET_END_DATE_TIME,	-- 2 	10
                   TARGET.USER_NAME                         AS TARGET_USER_NAME,	-- 2 	11
                     TARGET.USER_ID                           AS TARGET_USER_ID,	-- 2 	12
                  TARGET.STATION_ID                        AS TARGET_STATION_ID,	-- 2 	13
                   TARGET.SITE_NAME                         AS TARGET_SITE_NAME,	-- 2 	14
                     TARGET.SITE_ID                           AS TARGET_SITE_ID,	-- 2 	15
                     TARGET.DELETED                           AS TARGET_DELETED,	-- 2 	16
          TARGET.PAGES_PER_DOCUMENT                AS TARGET_PAGES_PER_DOCUMENT,	-- 2 	17
               TARGET.PAGES_SCANNED                     AS TARGET_PAGES_SCANNED,	-- 2 	18
               TARGET.PAGES_DELETED                     AS TARGET_PAGES_DELETED,	-- 2 	19
           TARGET.DOCUMENTS_CREATED                 AS TARGET_DOCUMENTS_CREATED,	-- 2 	20
           TARGET.DOCUMENTS_DELETED                 AS TARGET_DOCUMENTS_DELETED,	-- 2 	21
              TARGET.PAGES_REPLACED                    AS TARGET_PAGES_REPLACED,	-- 2 	22
                  TARGET.ERROR_TEXT                        AS TARGET_ERROR_TEXT,	-- 2 	23
                TARGET.EXTRACT_DATE                      AS TARGET_EXTRACT_DATE,	-- 2 	24
               TARGET.SOURCE_SERVER                     AS TARGET_SOURCE_SERVER,	-- 2 	25
               TARGET.PRIORITY                          AS TARGET_PRIORITY,
			   TARGET.SML_MODULE_NAME					AS TARGET_SML_MODULE_NAME
    FROM MAXDAT.NYHIX_MFB_V2_BATCH_EVENT TARGET
	)
	SELECT 
	--	SRC_ROWID,
		TARGET_ROWID,
		-- insert SQL from 3 and 4 here
	--	SRC_MFB_V2_CREATE_DATE,                                               	-- 3 	1
	--	SRC_MFB_V2_UPDATE_DATE,                                               	-- 3 	2
                              SRC_BATCH_MODULE_ID,                    	-- 3 	1
                              SRC_BATCH_GUID,                         	-- 3 	2
                              SRC_MODULE_LAUNCH_ID,                   	-- 3 	3
                              SRC_MODULE_UNIQUE_ID,                   	-- 3 	4
                              SRC_MODULE_NAME,                         	-- 3 	5
                              SRC_MODULE_CLOSE_UNIQUE_ID,             	-- 3 	6
                              SRC_MODULE_CLOSE_NAME,                  	-- 3 	7
                              SRC_BATCH_STATUS,                       	-- 3 	8
                              SRC_START_DATE_TIME,                    	-- 3 	9
                              SRC_END_DATE_TIME,                      	-- 3 	10
                              SRC_USER_NAME,                          	-- 3 	11
                              SRC_USER_ID,                            	-- 3 	12
                              SRC_STATION_ID,                         	-- 3 	13
                              SRC_SITE_NAME,                          	-- 3 	14
                              SRC_SITE_ID,                            	-- 3 	15
                              SRC_DELETED,                            	-- 3 	16
                              SRC_PAGES_PER_DOCUMENT,                 	-- 3 	17
                              SRC_PAGES_SCANNED,                      	-- 3 	18
                              SRC_PAGES_DELETED,                      	-- 3 	19
                              SRC_DOCUMENTS_CREATED,                  	-- 3 	20
                              SRC_DOCUMENTS_DELETED,                  	-- 3 	21
                              SRC_PAGES_REPLACED,                     	-- 3 	22
                              SRC_ERROR_TEXT,                         	-- 3 	23
                              SRC_EXTRACT_DATE,                       	-- 3 	24
                              SRC_SOURCE_SERVER,                      	-- 3 	25
                              SRC_PRIORITY,
							  SRC_SML_MODULE_NAME,
                              TARGET_BATCH_MODULE_ID,                 	-- 4 	1
                              TARGET_BATCH_GUID,                      	-- 4 	2
                              TARGET_MODULE_LAUNCH_ID,                	-- 4 	3
                              TARGET_MODULE_UNIQUE_ID,                	-- 4 	4
                              TARGET_MODULE_NAME,                      	-- 4 	5
                              TARGET_MODULE_CLOSE_UNIQUE_ID,          	-- 4 	6
                              TARGET_MODULE_CLOSE_NAME,               	-- 4 	7
                              TARGET_BATCH_STATUS,                    	-- 4 	8
                              TARGET_START_DATE_TIME,                 	-- 4 	9
                              TARGET_END_DATE_TIME,                   	-- 4 	10
                              TARGET_USER_NAME,                       	-- 4 	11
                              TARGET_USER_ID,                         	-- 4 	12
                              TARGET_STATION_ID,                      	-- 4 	13
                              TARGET_SITE_NAME,                       	-- 4 	14
                              TARGET_SITE_ID,                         	-- 4 	15
                              TARGET_DELETED,                         	-- 4 	16
                              TARGET_PAGES_PER_DOCUMENT,              	-- 4 	17
                              TARGET_PAGES_SCANNED,                   	-- 4 	18
                              TARGET_PAGES_DELETED,                   	-- 4 	19
                              TARGET_DOCUMENTS_CREATED,               	-- 4 	20
                              TARGET_DOCUMENTS_DELETED,               	-- 4 	21
                              TARGET_PAGES_REPLACED,                  	-- 4 	22
                              TARGET_ERROR_TEXT,                      	-- 4 	23
                              TARGET_EXTRACT_DATE,                    	-- 4 	24
                              TARGET_SOURCE_SERVER,                   	-- 4 	25	
                              TARGET_PRIORITY,
							  TARGET_SML_MODULE_NAME
    FROM SRC
	LEFT OUTER JOIN TARGET
	ON  SRC_SOURCE_SERVER = TARGET_SOURCE_SERVER
		AND SRC_BATCH_GUID = TARGET_BATCH_GUID
        AND SRC_BATCH_MODULE_ID = TARGET_BATCH_MODULE_ID                 	-- 4 	1
        AND SRC_MODULE_LAUNCH_ID = TARGET_MODULE_LAUNCH_ID;

	JOIN_REC   JOIN_CSR%ROWTYPE;

-----------------------------------------------------
PROCEDURE LOAD_EVENTS (P_JOB_ID number default 0) 
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

			IF JOIN_REC.SRC_Batch_Module_ID IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN Update_EVENTS;
			ELSIF JOIN_REC.SRC_Batch_Module_ID IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NULL 
                --then null;
				THEN INSERT_EVENTS;
			ELSIF JOIN_REC.SRC_Batch_Module_ID IS NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN DELETE_EVENTS;
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
				'SRC_BATCH_MODULE_ID: '||JOIN_REC.SRC_BATCH_MODULE_ID
				||' TARGET_BATCH_MODULE_ID: '||JOIN_REC.TARGET_BATCH_MODULE_ID
				||'SQLCODE '||GV_ERROR_CODE
				||' '||GV_ERROR_MESSAGE);

			ROLLBACK;

			RAISE;

END Load_EVENTS;

-----------------------------------------------------

-----------------------------------------------------
PROCEDURE UPDATE_EVENTS IS
-- USES SQL FROM 5 AND 6
-----------------------------------------------------

	BEGIN
	-- COMPARE
		IF 1=2
        --    OR NVL(JOIN_REC.TARGET_MFB_V2_CREATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_CREATE_DATE,SYSDATE - 93333)	-- 5 	1	DATE
        --   OR NVL(JOIN_REC.TARGET_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	-- 5 	2	DATE
         --   OR NVL(JOIN_REC.TARGET_BATCH_MODULE_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_MODULE_ID,'-?93333')	-- 5 	1	VARCHAR2
         --   OR NVL(JOIN_REC.TARGET_BATCH_GUID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_GUID,'-?93333')	-- 5 	2	VARCHAR2
         --   OR NVL(JOIN_REC.TARGET_MODULE_LAUNCH_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_LAUNCH_ID,'-?93333')	-- 5 	3	VARCHAR2
            OR NVL(JOIN_REC.TARGET_MODULE_UNIQUE_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_UNIQUE_ID,'-?93333')	-- 5 	4	VARCHAR2
            OR NVL(JOIN_REC.TARGET_MODULE_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_NAME,'-?93333')	-- 5 	5	VARCHAR2
            OR NVL(JOIN_REC.TARGET_MODULE_CLOSE_UNIQUE_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_CLOSE_UNIQUE_ID,'-?93333')	-- 5 	6	VARCHAR2
            OR NVL(JOIN_REC.TARGET_MODULE_CLOSE_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_CLOSE_NAME,'-?93333')	-- 5 	7	VARCHAR2
            OR NVL(JOIN_REC.TARGET_BATCH_STATUS,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_STATUS,'-?93333')	-- 5 	8	VARCHAR2
            OR NVL(JOIN_REC.TARGET_START_DATE_TIME,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_START_DATE_TIME,SYSDATE - 93333)	-- 5 	9	DATE
            OR NVL(JOIN_REC.TARGET_END_DATE_TIME,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_END_DATE_TIME,SYSDATE - 93333)	-- 5 	10	DATE
            OR NVL(JOIN_REC.TARGET_USER_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_USER_NAME,'-?93333')	-- 5 	11	VARCHAR2
            OR NVL(JOIN_REC.TARGET_USER_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_USER_ID,'-?93333')	-- 5 	12	VARCHAR2
            OR NVL(JOIN_REC.TARGET_STATION_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_STATION_ID,'-?93333')	-- 5 	13	VARCHAR2
            OR NVL(JOIN_REC.TARGET_SITE_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_SITE_NAME,'-?93333')	-- 5 	14	VARCHAR2
            OR NVL(JOIN_REC.TARGET_SITE_ID, -93333)	  <>  	NVL(JOIN_REC.SRC_SITE_ID, -93333)	-- 5 	15	NUMBER
            OR NVL(JOIN_REC.TARGET_DELETED,'-?93333')	  <>  	NVL(JOIN_REC.SRC_DELETED,'-?93333')	-- 5 	16	VARCHAR2
            OR NVL(JOIN_REC.TARGET_PAGES_PER_DOCUMENT,-93333)	  <>  	NVL(JOIN_REC.SRC_PAGES_PER_DOCUMENT,-93333)	-- 5 	17	VARCHAR2
            OR NVL(JOIN_REC.TARGET_PAGES_SCANNED,-93333)	  <>  	NVL(JOIN_REC.SRC_PAGES_SCANNED,-93333)	-- 5 	18	VARCHAR2
            OR NVL(JOIN_REC.TARGET_PAGES_DELETED,-93333)	  <>  	NVL(JOIN_REC.SRC_PAGES_DELETED,-93333)	-- 5 	19	VARCHAR2
            OR NVL(JOIN_REC.TARGET_DOCUMENTS_CREATED,-93333)	  <>  	NVL(JOIN_REC.SRC_DOCUMENTS_CREATED,-93333)	-- 5 	20	VARCHAR2
            OR NVL(JOIN_REC.TARGET_DOCUMENTS_DELETED,-93333)	  <>  	NVL(JOIN_REC.SRC_DOCUMENTS_DELETED,-93333)	-- 5 	21	VARCHAR2
            OR NVL(JOIN_REC.TARGET_PAGES_REPLACED,-93333)	  <>  	NVL(JOIN_REC.SRC_PAGES_REPLACED,-93333)	-- 5 	22	VARCHAR2
            OR NVL(JOIN_REC.TARGET_ERROR_TEXT,'-?93333')	  <>  	NVL(JOIN_REC.SRC_ERROR_TEXT,'-?93333')	-- 5 	23	VARCHAR2
            OR NVL(JOIN_REC.TARGET_PRIORITY,-99999)           <>    NVL(JOIN_REC.SRC_PRIORITY,-99999)  
			OR NVL(JOIN_REC.TARGET_SML_MODULE_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_SML_MODULE_NAME,'-?93333')
        --    OR NVL(JOIN_REC.TARGET_EXTRACT_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_EXTRACT_DATE,SYSDATE - 93333)	-- 5 	24	DATE
        --    OR NVL(JOIN_REC.TARGET_SOURCE_SERVER,'-?93333')	  <>  	NVL(JOIN_REC.SRC_SOURCE_SERVER,'-?93333')	-- 5 	25	VARCHAR2
			THEN
		UPDATE MAXDAT.NYHIX_MFB_V2_BATCH_EVENT
		SET  
		-- THE UPDATE
        --    MFB_V2_CREATE_DATE                        =  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 6 	1
        --    MFB_V2_UPDATE_DATE                        =  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 6 	2
            BATCH_MODULE_ID                           =  JOIN_REC.SRC_BATCH_MODULE_ID,	-- 6 	1
            BATCH_GUID                                =  JOIN_REC.SRC_BATCH_GUID,	-- 6 	2
            MODULE_LAUNCH_ID                          =  JOIN_REC.SRC_MODULE_LAUNCH_ID,	-- 6 	3
            MODULE_UNIQUE_ID                          =  JOIN_REC.SRC_MODULE_UNIQUE_ID,	-- 6 	4
            MODULE_NAME                                =  JOIN_REC.SRC_MODULE_NAME,	-- 6 	5
            MODULE_CLOSE_UNIQUE_ID                    =  JOIN_REC.SRC_MODULE_CLOSE_UNIQUE_ID,	-- 6 	6
            MODULE_CLOSE_NAME                         =  JOIN_REC.SRC_MODULE_CLOSE_NAME,	-- 6 	7
            BATCH_STATUS                              =  JOIN_REC.SRC_BATCH_STATUS,	-- 6 	8
            START_DATE_TIME                           =  JOIN_REC.SRC_START_DATE_TIME,	-- 6 	9
            END_DATE_TIME                             =  JOIN_REC.SRC_END_DATE_TIME,	-- 6 	10
            USER_NAME                                 =  JOIN_REC.SRC_USER_NAME,	-- 6 	11
            USER_ID                                   =  JOIN_REC.SRC_USER_ID,	-- 6 	12
            STATION_ID                                =  JOIN_REC.SRC_STATION_ID,	-- 6 	13
            SITE_NAME                                 =  JOIN_REC.SRC_SITE_NAME,	-- 6 	14
            SITE_ID                                   =  JOIN_REC.SRC_SITE_ID,	-- 6 	15
            DELETED                                   =  JOIN_REC.SRC_DELETED,	-- 6 	16
            PAGES_PER_DOCUMENT                        =  JOIN_REC.SRC_PAGES_PER_DOCUMENT,	-- 6 	17
            PAGES_SCANNED                             =  JOIN_REC.SRC_PAGES_SCANNED,	-- 6 	18
            PAGES_DELETED                             =  JOIN_REC.SRC_PAGES_DELETED,	-- 6 	19
            DOCUMENTS_CREATED                         =  JOIN_REC.SRC_DOCUMENTS_CREATED,	-- 6 	20
            DOCUMENTS_DELETED                         =  JOIN_REC.SRC_DOCUMENTS_DELETED,	-- 6 	21
            PAGES_REPLACED                            =  JOIN_REC.SRC_PAGES_REPLACED,	-- 6 	22
            ERROR_TEXT                                =  JOIN_REC.SRC_ERROR_TEXT,	-- 6 	23
            EXTRACT_DATE                              =  JOIN_REC.SRC_EXTRACT_DATE,	-- 6 	24
            PRIORITY                                  =  JOIN_REC.SRC_PRIORITY,
			SML_MODULE_NAME								= JOIN_REC.SRC_SML_MODULE_NAME
         --   SOURCE_SERVER                             =  JOIN_REC.SRC_SOURCE_SERVER		-- 6 	25
		WHERE ROWID = JOIN_REC.TARGET_ROWID;

		GV_RECORD_UPDATED_COUNT := GV_RECORD_UPDATED_COUNT + 1;
		GV_PROCESSED_COUNT := GV_PROCESSED_COUNT + 1;

	ELSE
		NULL; -- NO UPDATE REQUIRED
	END IF;	

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('UPDATE FAILURE '
            ||JOIN_REC.SRC_BATCH_GUID||' '
            --||JOIN_REC.SRC_rowid||' '
            ||JOIN_REC.target_rowid);

	--	GV_DRIVER_KEY_NUMBER  	:= 'SRC_ROWID : '||JOIN_REC.SRC_ROWID;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_EVENTS_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_EVENTS';

		POST_ERROR;

	END UPDATE_EVENTS;	

-----------------------------------------------------
PROCEDURE INSERT_EVENTS IS
-- USES SQL  FROM 7 AND 8
-----------------------------------------------------

	BEGIN

		INSERT INTO MAXDAT.NYHIX_MFB_V2_BATCH_EVENT
		(   
         --   MFB_V2_CREATE_DATE,                     	-- 7 	1
          --  MFB_V2_UPDATE_DATE,                     	-- 7 	2
            BATCH_MODULE_ID,                        	-- 7 	1
            BATCH_GUID,                             	-- 7 	2
            MODULE_LAUNCH_ID,                       	-- 7 	3
            MODULE_UNIQUE_ID,                       	-- 7 	4
            MODULE_NAME,                             	-- 7 	5
            MODULE_CLOSE_UNIQUE_ID,                 	-- 7 	6
            MODULE_CLOSE_NAME,                      	-- 7 	7
            BATCH_STATUS,                           	-- 7 	8
            START_DATE_TIME,                        	-- 7 	9
            END_DATE_TIME,                          	-- 7 	10
            USER_NAME,                              	-- 7 	11
            USER_ID,                                	-- 7 	12
            STATION_ID,                             	-- 7 	13
            SITE_NAME,                              	-- 7 	14
            SITE_ID,                                	-- 7 	15
            DELETED,                                	-- 7 	16
            PAGES_PER_DOCUMENT,                     	-- 7 	17
            PAGES_SCANNED,                          	-- 7 	18
            PAGES_DELETED,                          	-- 7 	19
            DOCUMENTS_CREATED,                      	-- 7 	20
            DOCUMENTS_DELETED,                      	-- 7 	21
            PAGES_REPLACED,                         	-- 7 	22
            ERROR_TEXT,                             	-- 7 	23
            EXTRACT_DATE,                           	-- 7 	24
            SOURCE_SERVER,	                          	-- 7 	25
            PRIORITY,
			SML_MODULE_NAME
			)
		VALUES (
          --  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	1
          --  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	2
            JOIN_REC.SRC_BATCH_MODULE_ID,	-- 8 	1
            JOIN_REC.SRC_BATCH_GUID,	-- 8 	2
            JOIN_REC.SRC_MODULE_LAUNCH_ID,	-- 8 	3
            JOIN_REC.SRC_MODULE_UNIQUE_ID,	-- 8 	4
            JOIN_REC.SRC_MODULE_NAME,	-- 8 	5
            JOIN_REC.SRC_MODULE_CLOSE_UNIQUE_ID,	-- 8 	6
            JOIN_REC.SRC_MODULE_CLOSE_NAME,	-- 8 	7
            JOIN_REC.SRC_BATCH_STATUS,	-- 8 	8
            JOIN_REC.SRC_START_DATE_TIME,	-- 8 	9
            JOIN_REC.SRC_END_DATE_TIME,	-- 8 	10
            JOIN_REC.SRC_USER_NAME,	-- 8 	11
            JOIN_REC.SRC_USER_ID,	-- 8 	12
            JOIN_REC.SRC_STATION_ID,	-- 8 	13
            JOIN_REC.SRC_SITE_NAME,	-- 8 	14
            JOIN_REC.SRC_SITE_ID,	-- 8 	15
            JOIN_REC.SRC_DELETED,	-- 8 	16
            JOIN_REC.SRC_PAGES_PER_DOCUMENT,	-- 8 	17
            JOIN_REC.SRC_PAGES_SCANNED,	-- 8 	18
            JOIN_REC.SRC_PAGES_DELETED,	-- 8 	19
            JOIN_REC.SRC_DOCUMENTS_CREATED,	-- 8 	20
            JOIN_REC.SRC_DOCUMENTS_DELETED,	-- 8 	21
            JOIN_REC.SRC_PAGES_REPLACED,	-- 8 	22
            JOIN_REC.SRC_ERROR_TEXT,	-- 8 	23
            JOIN_REC.SRC_EXTRACT_DATE,	-- 8 	24
            JOIN_REC.SRC_SOURCE_SERVER,		-- 8 	25
            JOIN_REC.SRC_PRIORITY,
			JOIN_REC.SRC_SML_MODULE_NAME
			);

		GV_RECORD_INSERTED_COUNT := GV_RECORD_INSERTED_COUNT + 1;

		GV_PROCESSED_COUNT := GV_PROCESSED_COUNT + 1;

	EXCEPTION

        WHEN OTHERS THEN
--        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE '
--            ||JOIN_REC.SRC_DB_RECORD_NUM||' '
--            ||JOIN_REC.SRC_BATCH_MODULE_ID||' '
--            ||JOIN_REC.target_BATCH_MODULE_ID);

        -- '${MFB_V2_REMOTE_START_DATE}'
		GV_DRIVER_KEY_NUMBER  	:= 'SRC BATCH_MODULE_ID : '||JOIN_REC.SRC_BATCH_MODULE_ID;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_EVENTS_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_EVENTS';

		POST_ERROR;

	END INSERT_EVENTS;	

-----------------------------------------------------
PROCEDURE DELETE_EVENTS IS
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
            ||JOIN_REC.SRC_BATCH_MODULE_ID||' '
            ||JOIN_REC.target_BATCH_MODULE_ID);

		Post_Error;

	END DELETE_EVENTS;	


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
		SUBSTR(GV_JOB_NAME,1,80), 				-- JOB_NAME 
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

EXCEPTION

	When Others then 
		GV_ERROR_CODE := SQLCODE;
		GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 3000);                 
	DBMS_OUTPUT.PUT_LINE('Procedure Post_Error failed with '||GV_Error_Code||': '||GV_Error_Message);

	--RAISE;


END;

END NYHIX_MFB_V2_BATCH_EVENT_PKG;


GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_BATCH_EVENT_PKG TO MAXDAT_PFP_READ_ONLY;
GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_BATCH_EVENT_PKG TO MAXDAT_READ_ONLY;
GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_BATCH_EVENT_PKG TO MAXDAT_READ_ONLY;

