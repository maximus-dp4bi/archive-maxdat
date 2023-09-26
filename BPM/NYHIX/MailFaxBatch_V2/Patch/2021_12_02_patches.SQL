--------------------------------------------------------------------------
-- Run this script in MAXDAT@NHX1DORUHXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMU to make it look like MAXDAT@NHX1DORD1HXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMD.
--
-- Please review the script before using it to make sure it won't cause any unacceptable data loss.
--
-- MAXDAT@NHX1DORUHXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMU schema extracted by user WL134672
-- MAXDAT@NHX1DORD1HXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMD schema extracted by user MAXDAT
--  
--  Note: Difference limit has been reached.
--       Only the first 1000 differences are shown.
--  
--------------------------------------------------------------------------
-- "Set define off" turns off substitution variables.
Set define off;

ALTER TABLE MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY
 ADD (REPROCESSED_DATE  DATE);

ALTER TABLE MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY
 ADD (ELAPSED_HOURS  NUMBER);

ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE NOLOGGING;

ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_OLTP NOLOGGING;

ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_OLTP_ERR NOLOGGING;

CREATE OR REPLACE PACKAGE MAXDAT."NYHIX_MFB_V2_BATCH_EVENT_PKG" AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$';
  	SVN_REVISION varchar2(20) := '$Revision$';
 	SVN_REVISION_DATE varchar2(60) := '$Date$';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


    Procedure Insert_EVENTS;
    Procedure Update_EVENTS;
    Procedure Delete_EVENTS;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_EVENTS ( p_job_id number default 0);

END NYHIX_MFB_V2_BATCH_EVENT_PKG;
/
SHOW ERRORS;

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
                     SRC.MODULENAME                           AS SRC_MODULENAME,	-- 1 	5
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
                  TARGET.MODULENAME                        AS TARGET_MODULENAME,	-- 2 	5
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
                              SRC_MODULENAME,                         	-- 3 	5
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
                              TARGET_MODULENAME,                      	-- 4 	5
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

        GV_JOB_NAME	:= GV_PROCESS_NAME||' Parent ID: '||GV_PARENT_JOB_ID||' - '||'Step NYHIX_MFB_V2_BATCH_EVENT';			

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
            OR NVL(JOIN_REC.TARGET_MODULENAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULENAME,'-?93333')	-- 5 	5	VARCHAR2
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
            MODULENAME                                =  JOIN_REC.SRC_MODULENAME,	-- 6 	5
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
            MODULENAME,                             	-- 7 	5
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
            JOIN_REC.SRC_MODULENAME,	-- 8 	5
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
/
show errors

CREATE OR REPLACE Package MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

	function GET_TIMELINESS_STATUS
    (p_create_dt in date, 
     p_batch_complete_dt in date,
     p_cancel_dt in date
    )
	return varchar2;

	function GET_TIMELINESS_DT
	(p_create_dt in date, 
	p_batch_complete_dt in date,
	p_cancel_dt in date
	) 
	return date;

	function GET_JEOPARDY_FLAG
	(p_create_dt in date,
	p_cancel_dt in date,  /**/
	p_batch_complete_dt in date 
	)
	return varchar2;

	function GET_JEOPARDY_DT
	(p_create_dt in date, 
	p_cancel_dt in date,
	p_batch_complete_dt in date
	)
	return date;

    Procedure INITIALIZE_GV_SRC_REC_SUMMARY;
    Procedure Insert_BATCH_SUMMARY;
    Procedure Update_BATCH_SUMMARY;
    Procedure Delete_BATCH_SUMMARY;
    Procedure Extract_Target ( P_SOURCE_SERVER VARCHAR DEFAULT 'CENTRAL', p_Batch_GUID varchar default null);
    Procedure Extract_Stats_Batch ( P_SOURCE_SERVER VARCHAR DEFAULT 'CENTRAL', p_Batch_GUID varchar default null);
    Procedure Extract_Batch_Event ( P_SOURCE_SERVER VARCHAR DEFAULT 'CENTRAL', p_Batch_GUID varchar default null);
    Procedure Extract_Document ( P_SOURCE_SERVER VARCHAR DEFAULT 'CENTRAL', p_Batch_GUID varchar default null);
    Procedure Extract_Envelope ( P_SOURCE_SERVER VARCHAR DEFAULT 'CENTRAL', p_Batch_GUID varchar default null);
    Procedure Extract_Stats_Batch_Module ( P_SOURCE_SERVER VARCHAR DEFAULT 'CENTRAL', p_Batch_GUID varchar default null);
    Procedure Extract_Maxdat_Reporting ( P_SOURCE_SERVER VARCHAR DEFAULT 'CENTRAL', p_Batch_GUID varchar default null);
    Procedure Extract_Stats_Form_Type ( P_SOURCE_SERVER VARCHAR DEFAULT 'CENTRAL', p_Batch_GUID varchar default null);
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Extract_CORP_ETL_CONTROL;

    PROCEDURE INSERT_F_MFB_V2_BY_HOUR( 	
		P_MFB_V2_BI_ID 			NUMBER DEFAULT NULL, 
		P_BATCH_GUID 			VARCHAR DEFAULT NULL,
		P_EVENT_DATE 			DATE DEFAULT NULL, 
		P_CREATE_DT				DATE DEFAULT NULL,
		P_CANCELLED_DT			DATE DEFAULT NULL,
		P_BATCH_COMPLETED_DT	DATE DEFAULT NULL,
		P_REPROCESSED_FLAG		VARCHAR DEFAULT  'N'
        );

    PROCEDURE UPDATE_F_MFB_V2_BY_HOUR( 
		P_MFB_V2_BI_ID 			NUMBER DEFAULT NULL, 
		P_BATCH_GUID 			VARCHAR DEFAULT NULL,
		P_EVENT_DATE 			DATE DEFAULT NULL, 
		P_CREATE_DT				DATE DEFAULT NULL,
		P_CANCELLED_DT			DATE DEFAULT NULL,
		P_BATCH_COMPLETED_DT	DATE DEFAULT NULL,
		P_REPROCESSED_FLAG		VARCHAR DEFAULT  'N'
        );

	Procedure Load_BATCH_SUMMARY ( p_job_id number default 0);
	--
    Procedure Insert_F_BY_DAY;
    Procedure Update_F_BY_DAY;
    Procedure Delete_F_BY_DAY;
    --
	Procedure Load_F_BY_DAY ( p_batch_guid varchar default null);


END NYHIX_MFB_V2_BATCH_SUMMARY_PKG;
/

SHOW ERRORS;

CREATE OR REPLACE PACKAGE BODY MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY_PKG AS

-- Table Relationships
-- Stats_Batch <------>> Stats_Batch_Module <<----> Stats_Batch_Module_Launch
--						
--						 Stats_Batch_Module <------->> Stats_Form_Type 
  
-- BATCH_STATUS Codes
-- 0, 2 - Ready, 
-- 4 - In Progress, 
-- 8 - Suspended, 
-- 32 - Error, 
-- 64 - Completed, 
-- 128 - Reserved, 
-- 512 - locked.

	-- USED FOR THE CORP_ETL_ERROR_LOG
	
	GV_SQL_CODE                 NUMBER 				:= NULL;
    GV_LOG_MESSAGE              CLOB 			    := NULL;

	GV_PARENT_JOB_ID          	NUMBER				:= 0;
	GV_ERROR_CODE				VARCHAR2(50)		:= NULL;
	GV_ERROR_MESSAGE			VARCHAR2(4000)		:= NULL;
	GV_ERROR_FIELD				VARCHAR2(400)		:= NULL;
	GV_ERROR_CODES				VARCHAR2(400)		:= NULL;
	GV_ERR_DATE					DATE				:= SYSDATE;
	GV_ERR_LEVEL				VARCHAR2(20)		:= 'CRITICAL';
	GV_PROCESS_NAME				VARCHAR2(120)		:= 'NYHIX_MFB_V2';
	GV_JOB_NAME					VARCHAR2(120)		:= '';
	GV_DRIVER_TABLE_NAME  		VARCHAR2(100 BYTE)	:= 'NYHIX_MFB_V2_BATCH_SUMMARY';
	GV_DRIVER_KEY_NUMBER  		VARCHAR2(100 BYTE)	:= NULL;
	GV_NR_OF_ERROR        		NUMBER				:= 0;
    GV_UPDATE_TS                DATE                := SYSDATE;
    GV_TARGET_ROWID             ROWID               := NULL;

	-- USED FOR THE CORP_ETL_JOB_STATISTICS
	GV_JOB_ID                 	NUMBER              := 0;
	GV_JOB_STATUS_CD          	VARCHAR2(20 BYTE)   := 'STARTED';
	GV_FILE_NAME              	VARCHAR2(512 BYTE)	:= 'NYHIX_MFB_V2_STATS_BATCH';
	GV_RECORD_COUNT           	NUMBER				:= 0;
	GV_ERROR_COUNT            	NUMBER				:= 0;
	GV_WARNING_COUNT          	NUMBER				:= 0;
	GV_PROCESSED_COUNT        	NUMBER				:= 0;
	GV_RECORD_INSERTED_COUNT  	NUMBER				:= 0;
	GV_RECORD_UPDATED_COUNT   	NUMBER				:= 0;
	GV_JOB_START_DATE         	DATE				:= SYSDATE;
	GV_JOB_END_DATE           	DATE				:= SYSDATE;
	GV_BATCH_GUID_ID			VARCHAR2(38 BYTE) 	:= NULL;
	GV_SOURCE_SERVER			VARCHAR2(38 BYTE) 	:= NULL;

    GV_FACT_BY_HOUR_INSERT_COUNT    NUMBER				:= 0;
    GV_FACT_BY_HOUR_UPDATE_COUNT    NUMBER				:= 0;
    GV_FACT_BY_HOUR_INSERT_SKIP_COUNT   NUMBER				:= 0;
    GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT   NUMBER				:= 0;
	GV_F_MFB_V2_BY_HOUR_DELETE_COUNT   	NUMBER				:= 0;

	GV_EVENT_COUNT				NUMBER				:= 0;

    -- Values from CORP_ETL_CONTROL used as filters

    GV_MFB_SCAN_MODULE_NAME				VARCHAR2(256) := NULL;
    GV_MFB_QC_MODULE_NAME				VARCHAR2(256) := NULL;
    GV_MFB_CLASSIFICATION_MODULE_NAME	VARCHAR2(256) := NULL;
    GV_MFB_RECOGNITION_MODULE_NAME		VARCHAR2(256) := NULL;
    GV_MFB_VALIDATION_MODULE_NAME		VARCHAR2(256) := NULL;
    GV_MFB_PDF_MODULE_NAME				VARCHAR2(256) := NULL;
    GV_MFB_REPORT_MODULE_NAME			VARCHAR2(256) := NULL;
    GV_MFB_EXPORT_MODULE_NAME			VARCHAR2(256) := NULL;
    GV_MFB_BATCH_CLASS_LIST9			VARCHAR2(256) := NULL;
    GV_MFB_BATCH_CLASS_LIST10			VARCHAR2(256) := NULL;
    GV_MFB_REPORTING_PERIOD_TYPE		VARCHAR2(256) := NULL;

	-- USED FOR INSERT AND UPDATES OF NYHIX_MFB_V2_BATCH_SUMMARY AND F_MFB_V2_BY_HOUR	
	GV_MFB_V2_BI_ID				NUMBER   	:= NULL;	--<< SEQUENCE FOR NYHIX)MFB_V2_BATCH_SUMMARY 
	GV_MFB_V2_CREATE_DATE		DATE 		:= SYSDATE;
	GV_MFB_V2_UPDATE_DATE   	DATE 		:= TO_DATE(NULL);

	-- Additionl Fields needed to match D_MFB_CURRENT
	GV_TIMELINESS_DAYS 			NUMBER; 			--<< From CORP_ETL_LIST_LKUP
	GV_TIMELINESS_DAYS_TYPE 	VARCHAR2(2 BYTE);   --<< From CORP_ETL_LIST_LKUP
	GV_JEOPARDY_DAYS 			NUMBER; 			--<< From CORP_ETL_LIST_LKUP
	GV_JEOPARDY_DAYS_TYPE 		VARCHAR2(2 BYTE); 	--<< From CORP_ETL_LIST_LKUP
	GV_TARGET_DAYS 				NUMBER;				--<< From CORP_ETL_LIST_LKUP

	GV_AGE_IN_BUSINESS_DAYS 	NUMBER; 			--<< Derived Once a day
	
	-- USED BY THE FACT_BY_DAY_PROCESS
    GV_CANCEL_DT                DATE                := SYSDATE +1;
	GV_BATCH_GUID               VARCHAR2(38)    := NULL;
	GV_BATCH_CANCEL_DT          DATE            := TO_DATE(NULL);
	GV_BATCH_COMPLETE_DT        DATE            := TO_DATE(NULL);

    GV_FACT_BY_DAY_PROCESSED_COUNT   NUMBER              := 0;
    GV_FACT_BY_DAY_INSERTED_COUNT      NUMBER              := 0;
    GV_FACT_BY_DAY_UPDATED_COUNT      NUMBER              := 0;
    GV_FACT_BY_DAY_DELETED_COUNT      NUMBER              := 0;

	--GV_AGE_IN_CALENDAR_DAYS 	NUMBER; 			--<< Derived Once a day
	--GV_TIMELINESS_STATUS 		VARCHAR2(20 BYTE); 	--<< Derived Once a day
	--GV_TIMELINESS_DT 			DATE; 				--<< Derived Once a day
	--GV_JEOPARDY_FLAG 			VARCHAR2(3 BYTE); 	--<< Derived Once a day
	--GV_JEOPARDY_DT 				DATE; 				--<< Derived Once a day


	-------------------------------------------------------------------------------------------
	-- THIS IS THE "DRIVING" CURSOR  
	-- It selects a distinct list of any  BATCH_GUID 
	-- that was Inserted or Updated
	-- based on the "Parent Job ID"
	-------------------------------------------------------------------------------------------

	CURSOR BATCH_GUID_CSR IS
	SELECT 
	MIN(SOURCE_SERVER) AS SOURCE_SERVER, 
    BATCH_GUID
	FROM (
			SELECT source_server, BATCH_GUID 
            FROM maxdat.NYHIX_MFB_V2_BATCH_SUMMARY
			WHERE nvl(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID 
			OR (
				BATCH_COMPLETE_DT IS NULL							-- All 'Active Batches'
				AND CANCEL_DT IS NULL
			   )
			UNION   
			SELECT source_server, BATCH_GUID 
            FROM maxdat.NYHIX_MFB_V2_STATS_BATCH
			WHERE nvl(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID 
			UNION
			SELECT source_server, BATCH_GUID 
            FROM maxdat.NYHIX_MFB_V2_BATCH_EVENT
			WHERE nvl(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID 
			UNION
			SELECT  'CENTRAL' as source_server, BATCH_GUID 
            FROM maxdat.NYHIX_MFB_V2_DOCUMENT
			WHERE nvl(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID 
			UNION
			SELECT  'CENTRAL' as source_server, BATCH_GUID 
            FROM maxdat.NYHIX_MFB_V2_ENVELOPE
			WHERE nvl(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID 
			UNION
			SELECT 'CENTRAL' as source_server, BATCH_GUID 
            FROM maxdat.NYHIX_MFB_V2_MAXDAT_REPORTING
			WHERE nvl(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID 
            AND VALID = 1
			UNION
			SELECT source_server, BATCH_GUID 
            FROM maxdat.NYHIX_MFB_V2_STATS_BATCH_MODULE
			WHERE nvl(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID 
			UNION
			SELECT source_server, BATCH_GUID 
            FROM maxdat.NYHIX_MFB_V2_STATS_FORM_TYPE
			WHERE nvl(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID 
		)
        GROUP BY BATCH_GUID
        ORDER BY BATCH_GUID, SOURCE_SERVER desc;
		
	GV_SRC_REC_SUMMARY          			NYHIX_MFB_V2_BATCH_SUMMARY%ROWTYPE;
	GV_TARGET_REC       					NYHIX_MFB_V2_BATCH_SUMMARY%ROWTYPE;

	GV_SRC_REC_EVENT    					NYHIX_MFB_V2_BATCH_EVENT%ROWTYPE;
	GV_SRC_REC_MAXDAT_REPORTING				NYHIX_MFB_V2_MAXDAT_REPORTING%ROWTYPE;
	GV_SRC_REC_DOCUMENT						NYHIX_MFB_V2_DOCUMENT%ROWTYPE;
	GV_SRC_REC_ENVELOPE						NYHIX_MFB_V2_ENVELOPE%ROWTYPE;
	GV_SRC_REC_STATS_BATCH					NYHIX_MFB_V2_STATS_BATCH%ROWTYPE;
	GV_SRC_REC_STATS_BATCH_MODULE			NYHIX_MFB_V2_STATS_BATCH_MODULE%ROWTYPE; 
	GV_SRC_REC_STATS_BATCH_MODULE_LAUNCH	NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH%ROWTYPE;
	GV_SRC_REC_STATS_FORM_TYPE				NYHIX_MFB_V2_STATS_FORM_TYPE%ROWTYPE; 
	
	---------------------------------------------------------------------------
	
	CURSOR F_BY_DAY_CSR IS
   WITH GUID AS
   ( SELECT 
        BATCH_GUID, 					-- 1 	1
        MFB_V2_BI_ID,      				-- 1 	3
--             SRC.MFB_V2_CREATE_DATE  	-- 1 	4
--             SRC.MFB_V2_UPDATE_DATE 	-- 1 	5
        CREATE_DT,       				-- 1 	6
        FAX_BATCH_SOURCE,				-- 1 	7
        BATCH_CLASS,					-- 1 	8
        CANCEL_DT,						-- 1 	9
        REPROCESSED_FLAG,				-- 1 	10
        BATCH_COMPLETE_DT,   			-- 1 	11
        BATCH_CLASS AS BATCH_GROUP,
        CASE 
            WHEN BATCH_CLASS LIKE 'NYHO%' 
            THEN 'NYEC' 
            ELSE 'NYHIX' END  AS BATCH_PROGRAM
     FROM NYHIX_MFB_V2_BATCH_SUMMARY
     WHERE BATCH_GUID = GV_BATCH_GUID
   ), 
   date_tab as
   (select d_date, WEEKEND_FLAG,     BUSINESS_DAY_FLAG 
       from BPM_d_dates, GUID
    where d_date between TRUNC(guid.create_dt) 
    and trunc(least(NVL(guid.cancel_dt,SYSDATE), NVL(GUID.batch_complete_dt,SYSDATE), sysdate))   
   ),
   SRC as
   (select 
        GUID.BATCH_GUID                   	AS SRC_BATCH_GUID,				-- 1 	1
        DATE_TAB.D_date            	AS SRC_D_DATE,					-- 1 	2
        GUID.MFB_V2_BI_ID                  	AS SRC_MFB_V2_BI_ID,			-- 1 	3
--             SRC.MFB_V2_CREATE_DATE       AS SRC_MFB_V2_CREATE_DATE,		-- 1 	4
--             SRC.MFB_V2_UPDATE_DATE       AS SRC_MFB_V2_UPDATE_DATE,		-- 1 	5
        GUID.CREATE_DT                     	AS SRC_CREATE_DT,				-- 1 	6
        GUID.FAX_BATCH_SOURCE              	AS SRC_FAX_BATCH_SOURCE,		-- 1 	7
        GUID.BATCH_CLASS                   	AS SRC_BATCH_CLASS,				-- 1 	8
        GUID.CANCEL_DT                     	AS SRC_CANCEL_DT,				-- 1 	9
        GUID.CANCEL_DT                     	AS SRC_REPROCESSED_DT,			-- 1 	10
        GUID.BATCH_COMPLETE_DT             	AS SRC_BATCH_COMPLETE_DT,		-- 1 	11
        CASE 
            WHEN  NVL(DATE_TAB.BUSINESS_DAY_FLAG,'N')	= 'Y'
            THEN
                MAXDAT.BUS_HRS_BETWEEN(GUID.CREATE_DT, 						-- << START_DATE
                LEAST(SYSDATE,NVL(BATCH_COMPLETE_DT,D_DATE+19/24) ))		-- << END_DATE
            ELSE 0      
			END 								AS SRC_AGE_IN_BUSINESS_HOURS,	-- 1   12
        0                                       AS SRC_AGE_IN_BUSINESS_DAYS,                  
        CASE WHEN TRUNC(GUID.CREATE_DT ) = TRUNC(D_DATE) 
			THEN 1 ELSE 0 END 				AS SRC_CREATION_COUNT,  		-- 1    14 
        CASE WHEN TRUNC(CANCEL_DT) = D_DATE
           		THEN 0
           		ELSE 1
           		END						AS SRC_INVENTORY_COUNT,			-- 1 	15    
        CASE WHEN TRUNC(BATCH_COMPLETE_DT) = TRUNC(D_DATE) 
		AND BATCH_COMPLETE_DT <> SYSDATE 
			THEN 1 ELSE 0 END 				AS SRC_COMPLETION_COUNT,		-- 1 	16 
        CASE WHEN GUID.CANCEL_DT IS NOT NULL
			AND TRUNC(GUID.CANCEL_DT) = D_DATE
			THEN 1 ELSE 0 END              	AS SRC_CANCELATION_COUNT,		-- 1 	17
        CASE WHEN GUID.REPROCESSED_FLAG = 'Y' 
        AND TRUNC(GUID.CANCEL_DT) = D_DATE
			THEN 1 ELSE 0 END              	AS SRC_REPROCESSED_COUNT,       -- 1 	18,
		DATE_TAB.WEEKEND_FLAG               as SRC_WEEKEND_FLAG,            -- 1 	19,
        DATE_TAB.BUSINESS_DAY_FLAG			as SRC_BUSINESS_DAY_FLAG,        -- 1 	20,
        GUID.BATCH_GROUP                    AS SRC_BATCH_GROUP,
        GUID.BATCH_PROGRAM                  AS SRC_BATCH_PROGRAM
    FROM GUID, DATE_TAB
	),
	TARGET AS
	(
	SELECT 
		ROWID    						  AS TARGET_ROWID,
		-- Insert SQL from Query 1 section 2 Here
                  TARGET.BATCH_GUID                        AS TARGET_BATCH_GUID,	-- 2 	1
                      TARGET.D_DATE                            AS TARGET_D_DATE,	-- 2 	2
                TARGET.MFB_V2_BI_ID                      AS TARGET_MFB_V2_BI_ID,	-- 2 	3
          TARGET.MFB_V2_CREATE_DATE                AS TARGET_MFB_V2_CREATE_DATE,	-- 2 	4
          TARGET.MFB_V2_UPDATE_DATE                AS TARGET_MFB_V2_UPDATE_DATE,	-- 2 	5
                   TARGET.CREATE_DT                         AS TARGET_CREATE_DT,	-- 2 	6
            TARGET.FAX_BATCH_SOURCE                  AS TARGET_FAX_BATCH_SOURCE,	-- 2 	7
                 TARGET.BATCH_CLASS                       AS TARGET_BATCH_CLASS,	-- 2 	8
                   TARGET.CANCEL_DT                         AS TARGET_CANCEL_DT,	-- 2 	9
              TARGET.REPROCESSED_DT                    AS TARGET_REPROCESSED_DT,	-- 2 	10
           TARGET.BATCH_COMPLETE_DT                 AS TARGET_BATCH_COMPLETE_DT,	-- 2 	11
       TARGET.AGE_IN_BUSINESS_HOURS             AS TARGET_AGE_IN_BUSINESS_HOURS,	-- 2 	12
        TARGET.AGE_IN_BUSINESS_DAYS              AS TARGET_AGE_IN_BUSINESS_DAYS,	-- 2 	13
              TARGET.CREATION_COUNT                    AS TARGET_CREATION_COUNT,	-- 2 	14
             TARGET.INVENTORY_COUNT                   AS TARGET_INVENTORY_COUNT,	-- 2 	15
            TARGET.COMPLETION_COUNT                  AS TARGET_COMPLETION_COUNT,	-- 2 	16
           TARGET.CANCELATION_COUNT                 AS TARGET_CANCELATION_COUNT,	-- 2 	17
           TARGET.REPROCESSED_COUNT                 AS TARGET_REPROCESSED_COUNT, 	-- 2 	18
		TARGET.WEEKEND_FLAG                        as TARGET_WEEKEND_FLAG,            -- 2 	19,
        TARGET.BUSINESS_DAY_FLAG			        as TARGET_BUSINESS_DAY_FLAG,
        TARGET.BATCH_GROUP                    AS TARGET_BATCH_GROUP,
        TARGET.BATCH_PROGRAM                  AS TARGET_BATCH_PROGRAM
        -- 2 	20,
    FROM MAXDAT.F_MFB_V2_BY_DAY TARGET
	)
	SELECT 
	--	SRC_ROWID,
		TARGET_ROWID,
		-- insert SQL from 3 and 4 here
                              SRC_BATCH_GUID,                         	-- 3 	1
                              SRC_D_DATE,                             	-- 3 	2
                              SRC_MFB_V2_BI_ID,                       	-- 3 	3
--                              SRC_MFB_V2_CREATE_DATE,                	-- 3 	4
--                              SRC_MFB_V2_UPDATE_DATE,                 -- 3 	5
                              SRC_CREATE_DT,                          	-- 3 	6
                              SRC_FAX_BATCH_SOURCE,                   	-- 3 	7
                              SRC_BATCH_CLASS,                        	-- 3 	8
                              SRC_CANCEL_DT,                          	-- 3 	9
                              SRC_REPROCESSED_DT,                     	-- 3 	10
                              SRC_BATCH_COMPLETE_DT,                  	-- 3 	11
                              SRC_AGE_IN_BUSINESS_HOURS,              	-- 3 	12
                              SRC_AGE_IN_BUSINESS_DAYS,               	-- 3 	13
                              SRC_CREATION_COUNT,                     	-- 3 	14
                              SRC_INVENTORY_COUNT,                    	-- 3 	15
                              SRC_COMPLETION_COUNT,                   	-- 3 	16
                              SRC_CANCELATION_COUNT,                  	-- 3 	17
                              SRC_REPROCESSED_COUNT,                  	-- 3 	18
                              SRC_WEEKEND_FLAG,                         -- 4 	19,
                              SRC_BUSINESS_DAY_FLAG,                     -- 4 	20,
                              SRC_BATCH_GROUP,
                              SRC_BATCH_PROGRAM,
                              ---------
                              TARGET_BATCH_GUID,                      	-- 4 	1
                              TARGET_D_DATE,                          	-- 4 	2
                              TARGET_MFB_V2_BI_ID,                    	-- 4 	3
--                              TARGET_MFB_V2_CREATE_DATE,              -- 4 	4
--                              TARGET_MFB_V2_UPDATE_DATE,              -- 4 	5
                              TARGET_CREATE_DT,                       	-- 4 	6
                              TARGET_FAX_BATCH_SOURCE,                	-- 4 	7
                              TARGET_BATCH_CLASS,                     	-- 4 	8
                              TARGET_CANCEL_DT,                       	-- 4 	9
                              TARGET_REPROCESSED_DT,                  	-- 4 	10
                              TARGET_BATCH_COMPLETE_DT,               	-- 4 	11
                              TARGET_AGE_IN_BUSINESS_HOURS,           	-- 4 	12
                              TARGET_AGE_IN_BUSINESS_DAYS,            	-- 4 	13
                              TARGET_CREATION_COUNT,                  	-- 4 	14
                              TARGET_INVENTORY_COUNT,                 	-- 4 	15
                              TARGET_COMPLETION_COUNT,                	-- 4 	16
                              TARGET_CANCELATION_COUNT,               	-- 4 	17
                              TARGET_REPROCESSED_COUNT,               	-- 4 	18
                              TARGET_WEEKEND_FLAG,                      -- 4 	19,
                              TARGET_BUSINESS_DAY_FLAG,                  -- 4 	20,
                              TARGET_BATCH_GROUP,
                              TARGET_BATCH_PROGRAM
    FROM SRC
	LEFT OUTER JOIN TARGET
	ON  
		SRC_BATCH_GUID = TARGET_BATCH_GUID
        AND TRUNC(SRC_D_DATE) = TRUNC(TARGET_D_DATE);

	JOIN_REC   F_BY_DAY_CSR%ROWTYPE;
	
	---------------------------------------------------------------------------

function GET_TIMELINESS_STATUS
    (p_create_dt in date, 
     p_batch_complete_dt in date,
     p_cancel_dt in date
     )
	return varchar2 
as
	days_type 	varchar2(2)	:=	null;
	timeliness_days number 	:= 	null;
	bus_days number 		:= 	null;
	cal_days number 		:= 	null;
begin

	if p_cancel_dt is not null then
		return 'Not Required';
	end if;

	days_type 		:= GV_TIMELINESS_DAYS_TYPE;
	timeliness_days := GV_TIMELINESS_DAYS;
	-- bus_days		:= BPM_COMMON.BUS_DAYS_BETWEEN(p_create_dt,nvl(p_batch_complete_dt,sysdate));
	bus_days		:= GV_AGE_IN_BUSINESS_DAYS;
	cal_days		:= trunc(nvl(p_batch_complete_dt,sysdate)) - trunc(p_create_dt);

	if (p_batch_complete_dt is not null) 
	then
		if (days_type='B') 
		then
			if (bus_days<=GV_timeliness_days)
			then 
				return 'Timely';
			elsif (bus_days	>	GV_timeliness_days)
			then 
				return 'Untimely';
			else
				return null;
			end if;

		elsif (days_type='C') 
		then
			if (cal_days<GV_timeliness_days)
			then 
				return 'Timely';
			elsif (cal_days >= GV_timeliness_days)
			then 
				return 'Untimely';
			else
				return null;
			end if;
		else
			return null;
		end if;
	elsif (p_batch_complete_dt is null)
	then 	
		return 'Not Complete';
	else
		return null;
	end if;
end;


-- *************************************************************************
--	GV_TIMELINESS_DT 			DATE, 				--<< Derived Once a day
-- *************************************************************************

function GET_TIMELINESS_DT
	(p_create_dt in date, 
	p_batch_complete_dt in date,
	p_cancel_dt in date
	)
	return date 
	as
		days_type 		varchar2(2)		:=	null;
		timeliness_days number			:=	null;
		v_timeliness 	varchar2(30)	:=	null;

	begin
		v_timeliness	:=	GET_TIMELINESS_STATUS(p_create_dt,p_batch_complete_dt,p_cancel_dt);
		days_type		:=	GV_TIMELINESS_DAYS_TYPE;
 		timeliness_days	:=	GV_TIMELINESS_DAYS;

	if(v_timeliness is not null) 
	then
		return p_create_dt + gv_timeliness_days;
	else 
		return null;
	end if;
end;

-- *************************************************************************
--	GV_JEOPARDY_FLAG 			VARCHAR2(3 BYTE), 	--<< Derived Once a day
-- *************************************************************************

function GET_JEOPARDY_FLAG
	(p_create_dt in date, 
	p_cancel_dt in date,  /**/ 
	p_batch_complete_dt in date
	)
	return varchar2 
	as
		days_type varchar2(2):=null;
		jeopardy_days number:=null;
		bus_days number :=null;
		cal_days number :=null;
begin

	if p_cancel_dt is not null 
	or p_batch_complete_dt is not null 
	then
		return 'N/A';
	end if;

	days_type		:=	GV_JEOPARDY_DAYS_TYPE;
	jeopardy_days	:=	GV_JEOPARDY_DAYS;
	-- bus_days		:=	BPM_COMMON.BUS_DAYS_BETWEEN(p_create_dt,nvl(p_batch_complete_dt,sysdate));
	bus_days		:=  GV_AGE_IN_BUSINESS_DAYS;
	cal_days		:=	trunc(nvl(p_batch_complete_dt,sysdate)) - trunc(p_create_dt);

	if(p_batch_complete_dt is null) 
	then
		if (days_type='B') 
		then
			if (bus_days>=GV_jeopardy_days) 
			then
				return 'Y';
			else
				return 'N';
			end if;
	elsif (days_type='C') 
		then
			if (cal_days>=GV_jeopardy_days) 
			then
				return 'Y';
			else
				return 'N';
			end if;
		else
			return null;
		end if;
	else
		return null;
	end if;
end;


-- *************************************************************************
--	GV_JEOPARDY_DT 				DATE, 				--<< Derived Once a day
-- *************************************************************************

function GET_JEOPARDY_DT
	(p_create_dt in date, 
	p_cancel_dt in date, /**/
	p_batch_complete_dt in date
	)
	return date
as
	days_type varchar2(2):=null;
	jeopardy_days number:=null;
	v_jeopardy varchar2(3):=null;
begin
	v_jeopardy		:=	GET_JEOPARDY_FLAG(p_create_dt,p_cancel_dt,p_batch_complete_dt);
	days_type		:=	GV_JEOPARDY_DAYS_TYPE;
	jeopardy_days	:=	GV_JEOPARDY_DAYS;

if (v_jeopardy is not null) 
	then
		return p_create_dt+GV_jeopardy_days;
	else 
		return null;
	end if;

end;


-- *************************************************************************
-- *************************************************************************
-- *************************************************************************

-----------------------------------------------------
PROCEDURE LOAD_BATCH_SUMMARY (P_JOB_ID number default 0) 
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
		GV_EVENT_COUNT				:= 0;

        GV_FACT_BY_HOUR_INSERT_COUNT    	:= 0;
        GV_FACT_BY_HOUR_UPDATE_COUNT    	:= 0;
		GV_F_MFB_V2_BY_HOUR_DELETE_COUNT 	:= 0;


		GV_PARENT_JOB_ID := P_JOB_ID;
		
        -- USED BY LOAD_F_BY_DAY
        GV_CANCEL_DT                := SYSDATE +1;
        GV_BATCH_GUID               := NULL;
        GV_BATCH_CANCEL_DT          := TO_DATE(NULL);
        GV_BATCH_COMPLETE_DT        := TO_DATE(NULL);

        GV_FACT_BY_DAY_PROCESSED_COUNT   := 0;
        GV_FACT_BY_DAY_INSERTED_COUNT    := 0;
        GV_FACT_BY_DAY_UPDATED_COUNT     := 0;
        GV_FACT_BY_DAY_DELETED_COUNT     := 0;

		
		

        -- GET VALUES FROM CORP_ETL_CONTROL
        Extract_CORP_ETL_CONTROL;

		GV_JOB_ID 	:= SEQ_JOB_ID.NEXTVAL;

        GV_JOB_NAME	:= GV_PROCESS_NAME||' Parent ID: '||GV_PARENT_JOB_ID||' - '||'Step NYHIX_MFB_V2_BATCH_SUMMARY';			

		Insert_Corp_ETL_Job_Statistics;


		IF (BATCH_GUID_CSR%ISOPEN)
		THEN
			CLOSE BATCH_GUID_CSR;
		END IF;

		OPEN BATCH_GUID_CSR;

		LOOP  -- Main "Driving" Loop

			FETCH BATCH_GUID_CSR INTO GV_SOURCE_SERVER, GV_BATCH_GUID_ID;

			EXIT WHEN BATCH_GUID_CSR%NOTFOUND;

			GV_RECORD_COUNT := GV_RECORD_COUNT+1;

			--DBMS_OUTPUT.PUT_LINE('Processing BATCH_GUID: '||GV_BATCH_GUID_ID);

			INITIALIZE_GV_SRC_REC_SUMMARY;

			--GV_SRC_REC_SUMMARY := NULL;
			--GV_TARGET_REC := NULL;

			Extract_Stats_Batch(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);
			Extract_Target(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);
            -- THE EXTRACTS MUST BE IN THE PROPER ORDER
            -- ALL EXTRAXTS MAY NOT BE NEEDED
            Extract_Document(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);
            Extract_Envelope(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);
            Extract_Stats_Batch_Module(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);
            Extract_Maxdat_Reporting(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);
            Extract_Stats_Form_Type(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);
            Extract_Batch_Event(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);

			-- Calculate the 'Derived' fields to match D_FMB_CURRENT ( v1 )
			-- try to do this only once a day
			IF TRUNC(GV_TARGET_REC.MFB_V2_UPDATE_DATE) <> TRUNC(SYSDATE)
			OR GV_PARENT_JOB_ID <= 0
			THEN	
			-- Calculate the 'Derived' fields to match D_FMB_CURRENT ( v1 ) 
			-- ONCE A DAY PER BATCH_GUID
				GV_AGE_IN_BUSINESS_DAYS 	:= BPM_COMMON.BUS_DAYS_BETWEEN(
									GV_SRC_REC_SUMMARY.CREATE_DT,
									nvl(GV_SRC_REC_SUMMARY.batch_complete_dt,sysdate)
									);

				GV_SRC_REC_SUMMARY.AGE_IN_BUSINESS_DAYS := 	GV_AGE_IN_BUSINESS_DAYS;		

				GV_SRC_REC_SUMMARY.AGE_IN_CALENDAR_DAYS		:= trunc(nvl(GV_SRC_REC_SUMMARY.batch_complete_dt,sysdate)) - trunc(GV_SRC_REC_SUMMARY.CREATE_DT);

				GV_SRC_REC_SUMMARY.TIMELINESS_STATUS		:= GET_TIMELINESS_STATUS(
                                    GV_SRC_REC_SUMMARY.CREATE_DT,
                                    GV_SRC_REC_SUMMARY.batch_complete_dt,
                                    GV_SRC_REC_SUMMARY.cancel_dt
                                    );
				GV_SRC_REC_SUMMARY.TIMELINESS_DT	:=	GET_TIMELINESS_DT(
                                    GV_SRC_REC_SUMMARY.CREATE_DT,
                                    GV_SRC_REC_SUMMARY.batch_complete_dt,
                                    GV_SRC_REC_SUMMARY.cancel_dt
                                    );

				GV_SRC_REC_SUMMARY.JEOPARDY_FLAG	:= 	GET_JEOPARDY_FLAG(
                                    GV_SRC_REC_SUMMARY.CREATE_DT,
                                    GV_SRC_REC_SUMMARY.batch_complete_dt,
                                    GV_SRC_REC_SUMMARY.cancel_dt
                                    );

				GV_SRC_REC_SUMMARY.JEOPARDY_DT	:= 	GET_JEOPARDY_DT(
                                    GV_SRC_REC_SUMMARY.CREATE_DT,
                                    GV_SRC_REC_SUMMARY.batch_complete_dt,
                                    GV_SRC_REC_SUMMARY.cancel_dt
                                    );

                ELSE	
				-- THE FIELDS SHOULD ALREADY BE DERRIVED.
				NULL;
			END IF;	


            IF GV_TARGET_ROWID IS NULL
				AND GV_SRC_REC_SUMMARY.BATCH_GUID IS NOT NULL
				THEN 
					GV_MFB_V2_BI_ID			:= SEQ_NYHIX_MFB_BATCH_SUMMARY_ID.NEXTVAL; --<< SEQUENCE FOR NYHIX)MFB_V2_BATCH_SUMMARY 
					GV_MFB_V2_CREATE_DATE	:= SYSDATE;
					GV_MFB_V2_UPDATE_DATE   := TO_DATE(NULL);
					INSERT_BATCH_SUMMARY();
					--dbms_output.put_line('Insert_FBH SRC_BATCH_GUID '||GV_SRC_REC_SUMMARY.BATCH_GUID||
					--                     'GV_TARGET_ROWID '||GV_TARGET_ROWID); 
					INSERT_F_MFB_V2_BY_HOUR( 	
						GV_MFB_V2_BI_ID,   						--<< P_MFB_V2_BI_ID
						GV_SRC_REC_SUMMARY.BATCH_GUID, 			--<< P_BATCH_GUID
						SYSDATE,								--<< P_EVENT_DATE 			
						GV_SRC_REC_SUMMARY.CREATE_DT,			--<< P_CREATE_DT				
						GV_SRC_REC_SUMMARY.CANCEL_DT,		    --<< P_CANCELLED_DT			
						GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT,	--<< P_BATCH_COMPLETED_DT
						GV_SRC_REC_SUMMARY.REPROCESSED_FLAG		--<< P_REPROCESSED_FLAG
						);
            ELSIF GV_TARGET_ROWID IS NOT NULL
				AND GV_SRC_REC_SUMMARY.BATCH_GUID IS NOT NULL
				THEN 
					GV_MFB_V2_BI_ID			:= GV_TARGET_REC.MFB_V2_BI_ID;
					GV_MFB_V2_CREATE_DATE	:= GV_TARGET_REC.CREATE_DT;
					GV_MFB_V2_UPDATE_DATE   := SYSDATE;
					UPDATE_BATCH_SUMMARY();
					--dbms_output.put_line('Update_FBH SRC_BATCH_GUID '||GV_SRC_REC_SUMMARY.BATCH_GUID||
					--                     'GV_TARGET_ROWID '||GV_TARGET_ROWID); 
                    UPDATE_F_MFB_V2_BY_HOUR(
						GV_MFB_V2_BI_ID,   						--<< P_MFB_V2_BI_ID
						GV_SRC_REC_SUMMARY.BATCH_GUID, 			--<< P_BATCH_GUID
						SYSDATE,								--<< P_EVENT_DATE 			
						GV_SRC_REC_SUMMARY.CREATE_DT,			--<< P_CREATE_DT				
						GV_SRC_REC_SUMMARY.CANCEL_DT,		    --<< P_CANCELLED_DT			
						GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT,	--<< P_BATCH_COMPLETED_DT
						GV_SRC_REC_SUMMARY.REPROCESSED_FLAG		--<< P_REPROCESSED_FLAG
						);

            ELSIF GV_TARGET_ROWID IS NOT NULL
				AND GV_SRC_REC_SUMMARY.BATCH_GUID IS NULL
				THEN DELETE_BATCH_SUMMARY(); --<< *** see notes in this procedure ***

                    UPDATE_F_MFB_V2_BY_HOUR(
						GV_MFB_V2_BI_ID,   						--<< P_MFB_V2_BI_ID
						GV_SRC_REC_SUMMARY.BATCH_GUID, 			--<< P_BATCH_GUID
						SYSDATE,								--<< P_EVENT_DATE 			
						GV_SRC_REC_SUMMARY.CREATE_DT,			--<< P_CREATE_DT				
						GV_SRC_REC_SUMMARY.CANCEL_DT,		    --<< P_CANCELLED_DT			
						GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT,	--<< P_BATCH_COMPLETED_DT
						GV_SRC_REC_SUMMARY.REPROCESSED_FLAG		--<< P_REPROCESSED_FLAG
						);

			END IF;

            LOAD_F_BY_DAY(GV_TARGET_REC.BATCH_GUID);

		END LOOP;

		COMMIT;

		IF (BATCH_GUID_CSR%ISOPEN)
		THEN
			CLOSE BATCH_GUID_CSR;
		END IF;

	-- Post the job statistics	
		DBMS_OUTPUT.PUT_LINE('GV_RECORD_COUNT: '||GV_RECORD_COUNT);
		DBMS_OUTPUT.PUT_LINE('GV_RECORD_INSERTED_COUNT: '||GV_RECORD_INSERTED_COUNT);
		DBMS_OUTPUT.PUT_LINE('GV_RECORD_UPDATED_COUNT: '||GV_RECORD_UPDATED_COUNT);

		DBMS_OUTPUT.PUT_LINE('GV_EVENT_COUNT: '||GV_EVENT_COUNT);

        DBMS_OUTPUT.PUT_LINE('GV_FACT_BY_HOUR_INSERT_COUNT: '||GV_FACT_BY_HOUR_INSERT_COUNT);
        DBMS_OUTPUT.PUT_LINE('GV_FACT_BY_HOUR_UPDATE_COUNT: '||GV_FACT_BY_HOUR_UPDATE_COUNT);
		DBMS_OUTPUT.PUT_LINE('GV_F_MFB_V2_BY_HOUR_DELETE_COUNT: '||GV_F_MFB_V2_BY_HOUR_DELETE_COUNT);


        DBMS_OUTPUT.PUT_LINE('GV_FACT_BY_HOUR_INSERT_SKIP_COUNT: '||GV_FACT_BY_HOUR_INSERT_SKIP_COUNT);
        DBMS_OUTPUT.PUT_LINE('GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT: '||GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT);

        DBMS_OUTPUT.PUT_LINE('GV_FACT_BY_DAY_PROCESSED_COUNT: '|| GV_FACT_BY_DAY_PROCESSED_COUNT);
        DBMS_OUTPUT.PUT_LINE('GV_FACT_BY_DAY_INSERTED_COUNT: '||  GV_FACT_BY_DAY_INSERTED_COUNT);
        DBMS_OUTPUT.PUT_LINE('GV_FACT_BY_DAY_UPDATED_COUNT: '||   GV_FACT_BY_DAY_UPDATED_COUNT);
        DBMS_OUTPUT.PUT_LINE('GV_FACT_BY_DAY_DELETED_COUNT: '||    GV_FACT_BY_DAY_DELETED_COUNT);

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

			DBMS_OUTPUT.PUT_LINE('Main Cursor failure for BATCH_GUID '||GV_BATCH_GUID_ID
				||'  SQLCODE '||GV_ERROR_CODE
				||' '||GV_ERROR_MESSAGE);

			ROLLBACK;
			RAISE;

END Load_BATCH_SUMMARY;

-----------------------------------------------------
-- *************************************************************************
-- *************************************************************************
-- *************************************************************************
-----------------------------------------------------



-------------------------------------------------------------------------------------------
-- THE CURSOR USES SQL FROM QUERIES 1, 2, 3 AND 4
-------------------------------------------------------------------------------------------
PROCEDURE Extract_CORP_ETL_CONTROL IS

    LV_NAME                     VARCHAR2(256) := NULL;
    LV_VALUE                    VARCHAR2(256) := NULL;

    CURSOR ETL_CONTROL_CSR IS
    SELECT NAME, VALUE
    FROM CORP_ETL_CONTROL
    WHERE SUBSTR(NAME,1,4) = 'MFB_'
    AND SUBSTR(NAME,1,6) <> 'MFB_V2';

BEGIN
    GV_MFB_SCAN_MODULE_NAME				:= NULL;
    GV_MFB_QC_MODULE_NAME				:= NULL;
    GV_MFB_CLASSIFICATION_MODULE_NAME	:= NULL;
    GV_MFB_RECOGNITION_MODULE_NAME		:= NULL;
    GV_MFB_VALIDATION_MODULE_NAME		:= NULL;
    GV_MFB_PDF_MODULE_NAME				:= NULL;
    GV_MFB_REPORT_MODULE_NAME			:= NULL;
    GV_MFB_EXPORT_MODULE_NAME			:= NULL;
    GV_MFB_BATCH_CLASS_LIST9			:= NULL;
    GV_MFB_BATCH_CLASS_LIST10			:= NULL;
    GV_MFB_REPORTING_PERIOD_TYPE		:= NULL;
	---
	---

		IF (ETL_CONTROL_CSR%ISOPEN)
		THEN
			CLOSE ETL_CONTROL_CSR;
		END IF;

		OPEN ETL_CONTROL_CSR;

		LOOP  -- 

			FETCH ETL_CONTROL_CSR 
                INTO LV_NAME, LV_VALUE;

        IF 
            LV_NAME = 'MFB_SCAN_MODULE_NAME' 
            THEN GV_MFB_SCAN_MODULE_NAME		:= LV_VALUE;
        ELSIF    
            LV_NAME = 'MFB_QC_MODULE_NAME' 
            THEN GV_MFB_QC_MODULE_NAME		:= LV_VALUE;
        ELSIF   
            LV_NAME = 'MFB_CLASSIFICATION_MODULE_NAME' 
            THEN GV_MFB_CLASSIFICATION_MODULE_NAME		:= LV_VALUE;
        ELSIF
            LV_NAME = 'MFB_RECOGNITION_MODULE_NAME' 
            THEN GV_MFB_RECOGNITION_MODULE_NAME		:= LV_VALUE;
        ELSIF
            LV_NAME = 'MFB_VALIDATION_MODULE_NAME' 
        THEN GV_MFB_VALIDATION_MODULE_NAME		:= LV_VALUE;
        ELSIF
            LV_NAME = 'MFB_PDF_MODULE_NAME' 
            THEN GV_MFB_PDF_MODULE_NAME		:= LV_VALUE;
        ELSIF
            LV_NAME = 'MFB_REPORT_MODULE_NAME' 
            THEN GV_MFB_REPORT_MODULE_NAME		:= LV_VALUE;
        ELSIF
            LV_NAME = 'MFB_EXPORT_MODULE_NAME' 
            THEN GV_MFB_EXPORT_MODULE_NAME		:= LV_VALUE;
        ELSIF
            LV_NAME = 'MFB_BATCH_CLASS_LIST9' 
            THEN GV_MFB_BATCH_CLASS_LIST9		:= LV_VALUE;
        ELSIF
            LV_NAME = 'MFB_BATCH_CLASS_LIST10' 
            THEN GV_MFB_BATCH_CLASS_LIST10		:= LV_VALUE;
        ELSIF
            LV_NAME = 'MFB_REPORTING_PERIOD_TYPE' 
            THEN GV_MFB_REPORTING_PERIOD_TYPE		:= LV_VALUE;
        END IF;

			EXIT WHEN ETL_CONTROL_CSR%NOTFOUND;

		--	DBMS_OUTPUT.PUT_LINE('Processing ETL_CONTROL_CSR: '||GV_BATCH_GUID_ID);

		END LOOP;

		IF (ETL_CONTROL_CSR%ISOPEN)
		THEN
			CLOSE ETL_CONTROL_CSR;
		END IF;

		SELECT OUT_VAR
		INTO GV_TIMELINESS_DAYS
		FROM CORP_ETL_LIST_LKUP
		WHERE NAME='MFB_TIMELINESS_DAYS';

		SELECT OUT_VAR
		INTO GV_JEOPARDY_DAYS_TYPE
		FROM CORP_ETL_LIST_LKUP
		WHERE NAME='MFB_TIMELINESS_DAYS_TYPE';

		SELECT OUT_VAR
		INTO GV_JEOPARDY_DAYS
		FROM CORP_ETL_LIST_LKUP
		WHERE NAME='MFB_JEOPARDY_DAYS';


		SELECT OUT_VAR
		INTO GV_JEOPARDY_DAYS_TYPE
		FROM CORP_ETL_LIST_LKUP
		WHERE NAME='MFB_JEOPARDY_DAYS_TYPE';

		SELECT OUT_VAR
		INTO GV_TARGET_DAYS
		FROM CORP_ETL_LIST_LKUP
		WHERE NAME='MFB_TARGET_DAYS';	


        DBMS_OUTPUT.PUT_LINE('GV_MFB_SCAN_MODULE_NAME: 			'||GV_MFB_SCAN_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_QC_MODULE_NAME:				'||GV_MFB_QC_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_CLASSIFICATION_MODULE_NAME: '||GV_MFB_CLASSIFICATION_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_RECOGNITION_MODULE_NAME: 	'||GV_MFB_RECOGNITION_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_VALIDATION_MODULE_NAME: 	'||GV_MFB_VALIDATION_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_PDF_MODULE_NAME: 			'||GV_MFB_PDF_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_REPORT_MODULE_NAME: 		'||GV_MFB_REPORT_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_EXPORT_MODULE_NAME: 		'||GV_MFB_EXPORT_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_BATCH_CLASS_LIST9: 			'||GV_MFB_BATCH_CLASS_LIST9);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_BATCH_CLASS_LIST10: 		'||GV_MFB_BATCH_CLASS_LIST10);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_REPORTING_PERIOD_TYPE: 		'||GV_MFB_REPORTING_PERIOD_TYPE);


EXCEPTION
    WHEN NO_DATA_FOUND THEN 
		DBMS_OUTPUT.PUT_LINE('**** FAILED TO EXTRACT CORP_ETL_CONTROL ****');
		RAISE;
    WHEN OTHERS THEN RAISE;
END Extract_CORP_ETL_CONTROL;

-----------------------------------------------------
-----------------------------------------------------
-----------------------------------------------------
PROCEDURE INITIALIZE_GV_SRC_REC_SUMMARY 
IS

BEGIN
       GV_SRC_REC_SUMMARY.BATCH_NAME := NULL;	  					-- 	5	VARCHAR2
       GV_SRC_REC_SUMMARY.SOURCE_SERVER := NULL;	  				-- 	6	VARCHAR2
       GV_SRC_REC_SUMMARY.BATCH_DESCRIPTION := NULL;	  			-- 	7	VARCHAR2
       GV_SRC_REC_SUMMARY.REPROCESSED_FLAG := NULL;	  				-- 	8	VARCHAR2
       GV_SRC_REC_SUMMARY.CREATION_STATION_ID := NULL;	  			-- 	9	VARCHAR2
       GV_SRC_REC_SUMMARY.CREATION_USER_NAME := NULL;	  			-- 	10	VARCHAR2
       GV_SRC_REC_SUMMARY.CREATION_USER_ID := NULL;	  				-- 	11	VARCHAR2
       GV_SRC_REC_SUMMARY.BATCH_CLASS := NULL;	  					-- 	12	VARCHAR2
       GV_SRC_REC_SUMMARY.BATCH_CLASS_DES := NULL;	  				-- 	13	VARCHAR2
       GV_SRC_REC_SUMMARY.BATCH_TYPE := NULL;	  					-- 	14	VARCHAR2
       GV_SRC_REC_SUMMARY.CREATE_DT := TO_DATE(NULL);	  			-- 	15	DATE
       GV_SRC_REC_SUMMARY.COMPLETE_DT := TO_DATE(NULL);	  			-- 	16	DATE
       GV_SRC_REC_SUMMARY.INSTANCE_STATUS := NULL;	  				-- 	17	VARCHAR2
       GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT := TO_DATE(NULL);	  	-- 	18	DATE
       GV_SRC_REC_SUMMARY.BATCH_PAGE_COUNT := NULL;	  				-- 	19	NUMBER
       GV_SRC_REC_SUMMARY.BATCH_DOC_COUNT := NULL;	  				-- 	20	NUMBER
       GV_SRC_REC_SUMMARY.BATCH_ENVELOPE_COUNT := NULL;	  			-- 	21	NUMBER
       GV_SRC_REC_SUMMARY.CANCEL_DT := TO_DATE(NULL);	  			-- 	22	DATE
       GV_SRC_REC_SUMMARY.CANCEL_BY := NULL;	  					-- 	23	VARCHAR2
       GV_SRC_REC_SUMMARY.CANCEL_REASON := NULL;	  				-- 	24	VARCHAR2
       GV_SRC_REC_SUMMARY.CANCEL_METHOD := NULL;	  				-- 	25	VARCHAR2
       GV_SRC_REC_SUMMARY.ASF_SCAN_BATCH := 'N';	  				-- 	26	VARCHAR2
       GV_SRC_REC_SUMMARY.ASSD_SCAN_BATCH := TO_DATE(NULL);	  		-- 	27	DATE
       GV_SRC_REC_SUMMARY.ASED_SCAN_BATCH := TO_DATE(NULL);	  		-- 	28	DATE
       GV_SRC_REC_SUMMARY.ASPB_SCAN_BATCH := NULL;	  				-- 	29	VARCHAR2
       GV_SRC_REC_SUMMARY.ASF_PERFORM_QC := 'N';	  				-- 	30	VARCHAR2
       GV_SRC_REC_SUMMARY.ASSD_PERFORM_QC := TO_DATE(NULL);	  		-- 	31	DATE
       GV_SRC_REC_SUMMARY.ASED_PERFORM_QC := TO_DATE(NULL);	  		-- 	32	DATE
       GV_SRC_REC_SUMMARY.ASPB_PERFORM_QC := NULL;	  				-- 	33	VARCHAR2
       GV_SRC_REC_SUMMARY.KOFAX_QC_REASON := NULL;	  				-- 	34	VARCHAR2
       GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION := 'N';	  			-- 	35	VARCHAR2
       GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION := TO_DATE(NULL);	  	-- 	36	DATE
       GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION := TO_DATE(NULL);	  	-- 	37	DATE
       GV_SRC_REC_SUMMARY.CLASSIFICATION_DT := TO_DATE(NULL);	  	-- 	38	DATE
       GV_SRC_REC_SUMMARY.ASF_RECOGNITION := 'N';	  			    -- 	39	VARCHAR2
       GV_SRC_REC_SUMMARY.ASSD_RECOGNITION := TO_DATE(NULL);	  	-- 	40	DATE
       GV_SRC_REC_SUMMARY.ASED_RECOGNITION := TO_DATE(NULL);	  	-- 	41	DATE
       GV_SRC_REC_SUMMARY.RECOGNITION_DT := NULL;	  			    -- 	42	DATE
       GV_SRC_REC_SUMMARY.ASF_VALIDATE_DATA := 'N';	  		    -- 	43	VARCHAR2
       GV_SRC_REC_SUMMARY.ASSD_VALIDATE_DATA := TO_DATE(NULL);	  	-- 	44	DATE
       GV_SRC_REC_SUMMARY.ASED_VALIDATE_DATA := TO_DATE(NULL);	  	-- 	45	DATE
       GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA := NULL;	  		    -- 	46	VARCHAR2
       GV_SRC_REC_SUMMARY.VALIDATION_DT := TO_DATE(NULL);	  		-- 	47	DATE
       GV_SRC_REC_SUMMARY.ASF_CREATE_PDF := 'N';	  			    -- 	48	VARCHAR2
       GV_SRC_REC_SUMMARY.ASSD_CREATE_PDF := TO_DATE(NULL);	  		-- 	49	DATE
       GV_SRC_REC_SUMMARY.ASED_CREATE_PDF := TO_DATE(NULL);	  		-- 	50	DATE
       GV_SRC_REC_SUMMARY.ASF_POPULATE_REPORTS := 'N';	  	    	-- 	51	VARCHAR2
       GV_SRC_REC_SUMMARY.ASSD_POPULATE_REPORTS := TO_DATE(NULL);	-- 	52	DATE
       GV_SRC_REC_SUMMARY.ASED_POPULATE_REPORTS := TO_DATE(NULL);	-- 	53	DATE
       GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS := 'N';	  				-- 	54	VARCHAR2
       GV_SRC_REC_SUMMARY.ASSD_RELEASE_DMS := TO_DATE(NULL);	  	-- 	55	DATE
       GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS := TO_DATE(NULL);	  	-- 	56	DATE
       GV_SRC_REC_SUMMARY.BATCH_PRIORITY := NULL;	  			    -- 	57	NUMBER
       GV_SRC_REC_SUMMARY.BATCH_DELETED := NULL;	  			    -- 	58	VARCHAR2
       GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG := NULL;	  			-- 	59	VARCHAR2
       GV_SRC_REC_SUMMARY.DOCS_CREATED_FLAG := NULL;	  			-- 	60	VARCHAR2
       GV_SRC_REC_SUMMARY.DOCS_DELETED_FLAG := NULL;	  			-- 	61	VARCHAR2
       GV_SRC_REC_SUMMARY.PAGES_REPLACED_FLAG := NULL;	  			-- 	62	VARCHAR2
       GV_SRC_REC_SUMMARY.PAGES_DELETED_FLAG := NULL;	  			-- 	63	VARCHAR2
       GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT := TO_DATE(NULL);	  	-- 	69	DATE
       GV_SRC_REC_SUMMARY.CURRENT_BATCH_MODULE_ID := NULL;	  		-- 	70	VARCHAR2
       GV_SRC_REC_SUMMARY.GWF_QC_REQUIRED := NULL;	  				-- 	71	VARCHAR2
       GV_SRC_REC_SUMMARY.CURRENT_STEP := NULL;	  					-- 	72	VARCHAR2
 --      GV_SRC_REC_SUMMARY.CEJS_JOB_ID := NULL;	  					-- 	73	NUMBER
       GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA_USER_ID := NULL;		-- 	74	VARCHAR2
       GV_SRC_REC_SUMMARY.FAX_BATCH_SOURCE := NULL;	  				-- 	75	VARCHAR2
	   GV_SRC_REC_SUMMARY.LAST_Event_MODULE_NAME := NULL;	 
	   GV_SRC_REC_SUMMARY.LAST_Event_Status := NULL;	 
	   GV_SRC_REC_SUMMARY.AGE_IN_BUSINESS_DAYS := NULL;
	   GV_SRC_REC_SUMMARY.AGE_IN_CALENDAR_DAYS := NULL;
	   GV_SRC_REC_SUMMARY.TIMELINESS_STATUS := NULL;
	   GV_SRC_REC_SUMMARY.TIMELINESS_DAYS := NULL;
	   GV_SRC_REC_SUMMARY.TIMELINESS_DAYS_TYPE := NULL;
	   GV_SRC_REC_SUMMARY.TIMELINESS_DT := TO_DATE(NULL);
	   GV_SRC_REC_SUMMARY.JEOPARDY_FLAG := NULL;
	   GV_SRC_REC_SUMMARY.JEOPARDY_DAYS := NULL;
	   GV_SRC_REC_SUMMARY.JEOPARDY_DAYS_TYPE := NULL;
	   GV_SRC_REC_SUMMARY.JEOPARDY_DT := TO_DATE(NULL);
	   GV_SRC_REC_SUMMARY.TARGET_DAYS := NULL;

	   GV_AGE_IN_BUSINESS_DAYS := NULL;

EXCEPTION
    WHEN OTHERS 
		THEN 
		DBMS_OUTPUT.PUT_LINE('**** FAILED TO INITIALIZE GV_SRC_REC_SUMMARY ***');
		RAISE;
END INITIALIZE_GV_SRC_REC_SUMMARY;

-- *****************************************************
-- *****************************************************
-- *****************************************************

PROCEDURE INSERT_F_MFB_V2_BY_HOUR(
	P_MFB_V2_BI_ID 			NUMBER DEFAULT NULL, 
	P_BATCH_GUID 			VARCHAR DEFAULT NULL,
	P_EVENT_DATE 			DATE DEFAULT NULL, 
	P_CREATE_DT				DATE DEFAULT NULL,
	P_CANCELLED_DT			DATE DEFAULT NULL,
	P_BATCH_COMPLETED_DT	DATE DEFAULT NULL,
	P_REPROCESSED_FLAG		VARCHAR DEFAULT 'N')

-- *****************************************************
-- REPLACEMENT FOR THE Insert fact for BPM Semantic model 
-- Process Mail Fax Batch V2 process. 
-- *****************************************************
-- This procedure is run after INSERTING a BTACH_GUID into NYHIX_MFB_V2_BATCH_SUMMARY.
-- Its input is from "LV_SRC_REC := GV_SRC_REC_SUMMARY;"
-- Normally the P_MFB_V2_BI_ID parameter is null, however if a Batch_GUID is alreay in
-- the summary table and ir needs to be inserted into the Fact_by_hour then 
-- use the P_MFB_V2_BI_ID for this procedure.
-- **********************************************

   IS
		-- THE FOLLOWING ARE USED FOR ERROR REPORTING
		LV_PROCEDURE_NAME VARCHAR2(61) := 'NYHIX_MFB_V2_BATCH_SUMMARY'|| '.' || 'INSERT_F_MFB_V2_BY_HOUR';
		LV_BSL_ID						NUMBER := 16; --<< 'BSL NUMBER FOR CORP_ETL_MFB_BATCH'
		LV_BIL_ID						NUMBER := 4;
		LV_IDENTIFIER					VARCHAR2(100) := NULL;
		LV_BI_ID						NUMBER(12)    := NULL;

		-- THE FOLLOWING ARE USED FOR ETL LOGIC
		LV_FACT_COUNT			NUMBER 	    := 0;
        LV_END_DATE			    DATE 		:= NULL;
		LV_BUCKET_START_DATE    DATE 		:= NULL;
		LV_BUCKET_END_DATE      DATE 		:= NULL;
--		LV_LAST_UPDATE_DATE DATE		:= NULL;

		LV_DATE_BPM_COMMON_DATE_FMT VARCHAR2(21)	:= 'YYYY-MM-DD HH24:MI:SS'; -- << BPM_COMMON.Date_FMT
		LV_DATE_BUCKET_FMT VARCHAR2(21) 			:= 'YYYY-MM-DD HH24'; -- << BPM_COMMON.Date_FMT


		-- THIS IS THE DATA TO BE INSERTED
	--	LV_SRC_REC          			NYHIX_MFB_V2_BATCH_SUMMARY%ROWTYPE;

		LV_MFB_V2_FBH_ID					NUMBER(12) := NULL;

    BEGIN

        GV_FACT_BY_HOUR_INSERT_COUNT    := GV_FACT_BY_HOUR_INSERT_COUNT + 1;

		IF P_MFB_V2_BI_ID IS NULL
		THEN
            GV_FACT_BY_HOUR_INSERT_SKIP_COUNT := GV_FACT_BY_HOUR_INSERT_SKIP_COUNT + 1;
			RETURN;
		END IF;

		-- THIS PROCEDURE IS ONLY FOR INSERTS
		-- IF THE MFB_V2_BI_ID IS IN THE F_MFB_V2_BY_HOUR TABLE
		-- THE INPUT PARAMETERS ARE WORN... EXIT THE PROCEDURE

		SELECT COUNT(*) 
			INTO LV_FACT_COUNT	
		FROM F_MFB_V2_BY_HOUR
		WHERE MFB_V2_BI_ID = P_MFB_V2_BI_ID;

		IF LV_FACT_COUNT > 0
        THEN
            GV_FACT_BY_HOUR_INSERT_SKIP_COUNT := GV_FACT_BY_HOUR_INSERT_SKIP_COUNT + 1;
			RETURN;
		END IF;	

		-- VALIDATE FACT DATE RANGES.
		IF P_CREATE_DT >  NVL(P_BATCH_COMPLETED_DT,SYSDATE)
        OR P_CREATE_DT >  NVL(P_CANCELLED_DT,SYSDATE)
		OR P_CREATE_DT >  NVL(BPM_COMMON.MAX_DATE,SYSDATE)
			THEN
				GV_SQL_CODE := -20030;
				GV_LOG_MESSAGE := 'Insert failed to Validate FACT BY HOUR DATE RANGE.  ' || 
                ' P_CREATE_DT = ' || P_CREATE_DT || 
                ' P_BATCH_COMPLETED_DT = ' || P_BATCH_COMPLETED_DT ||
                ' P_CANCELLED_DT = ' || P_CANCELLED_DT ||
				' BPM_COMMON.MAX_DATE = '|| BPM_COMMON.MAX_DATE;
				BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,NULL,LV_PROCEDURE_NAME,
                    P_MFB_V2_BI_ID,
                    LV_BIL_ID,
                    P_BATCH_GUID,P_MFB_V2_BI_ID,GV_LOG_MESSAGE,GV_SQL_CODE);
				--RAISE_APPLICATION_ERROR(GV_SQL_CODE,GV_LOG_MESSAGE);
				RETURN;
		END IF;

		LV_BUCKET_START_DATE	:= TO_DATE(TO_CHAR(P_CREATE_DT,'YYYY/MM/DD HH24'),'YYYY/MM/DD HH24');

		LV_END_DATE				:= COALESCE(P_CANCELLED_DT, P_BATCH_COMPLETED_DT);
		LV_BUCKET_END_DATE	    := TO_DATE(TO_CHAR(COALESCE(LV_END_DATE,BPM_COMMON.MAX_DATE),'YYYY/MM/DD HH24'),'YYYY/MM/DD HH24');

		LV_MFB_V2_FBH_ID := SEQ_NYHIX_MFB_BATCH_BY_HOUR_ID.NEXTVAL;

		IF P_REPROCESSED_FLAG = 'Y'
		THEN -- THIS SHOUD NOT HAPPEN
			RETURN;
		END IF;	

		INSERT INTO F_MFB_V2_BY_HOUR
			(
			F_MFB_V2_FBH_ID,  
			D_DATE,
			BUCKET_START_DATE,
			BUCKET_END_DATE,
			MFB_V2_BI_ID, 
			INVENTORY_COUNT, 
			CREATION_COUNT, 
			COMPLETION_COUNT
			)
		VALUES
			( 
			LV_MFB_V2_FBH_ID,
			P_CREATE_DT,
			LV_BUCKET_START_DATE,
			LV_BUCKET_END_DATE,
			P_MFB_V2_BI_ID,
			CASE 
				WHEN LV_END_DATE IS NULL THEN 1
				ELSE 0
			END,				--<< as INVENTORY_COUNT
			1,				--<< as CREATION_COUNT
			CASE 
				WHEN LV_END_DATE IS NULL THEN 0
				ELSE 1
			END				--<< as COMPLETION_COUNT
			);

	EXCEPTION

		WHEN NO_DATA_FOUND 
		THEN
			NULL;

		WHEN OTHERS THEN
			GV_SQL_CODE := SQLCODE;
			GV_LOG_MESSAGE := SQLERRM;
			DBMS_OUTPUT.PUT_LINE('FAILED IN INSERT_F_MFB_V2_BY_HOUR'||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE); 
			DBMS_OUTPUT.PUT_LINE('FAILED IN INSERT_F_MFB_V2_BY_HOUR FOR P_MFB_V2_BI_ID'||' '||P_MFB_V2_BI_ID); 
			BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,NULL,LV_PROCEDURE_NAME,LV_BSL_ID,LV_BIL_ID,LV_IDENTIFIER,LV_BI_ID,GV_LOG_MESSAGE,GV_SQL_CODE);
		RAISE;

	END INSERT_F_MFB_V2_BY_HOUR;

-- *****************************************************
-- *****************************************************
-- *****************************************************

PROCEDURE UPDATE_F_MFB_V2_BY_HOUR( 
	P_MFB_V2_BI_ID 			NUMBER DEFAULT NULL, 
	P_BATCH_GUID 			VARCHAR DEFAULT NULL,
	P_EVENT_DATE 			DATE DEFAULT NULL, 
	P_CREATE_DT				DATE DEFAULT NULL,
	P_CANCELLED_DT			DATE DEFAULT NULL,
	P_BATCH_COMPLETED_DT	DATE DEFAULT NULL,
	P_REPROCESSED_FLAG		VARCHAR DEFAULT 'N')
IS
-- *****************************************************
-- REPLACEMENT FOR THE UPDATE fact for BPM Semantic model 
-- Process Mail Fax Batch V2 process. 
-- *****************************************************
-- **********************************************
-- This procedure should only be used when 
-- updating a BTACH_GUID into NYHIX_MFB_V2_BATCH_SUMMARY
-- **********************************************	
-- *****************************************************
-- MFB_V2 REPLACEMENT FOR Update fact for BPM Semantic model - Mail Fax Batch Process
-- *****************************************************

    LV_PROCEDURE_NAME 					VARCHAR2(61) 	:= $$PLSQL_UNIT || '.' || 'UPDATE_F_MFB_V2_BY_HOUR';

	LV_DATE_BPM_COMMON_DATE_FMT 		VARCHAR2(21)	:= 'YYYY-MM-DD HH24:MI:SS'; -- << BPM_COMMON.Date_FMT
	LV_DATE_BUCKET_FMT 					VARCHAR2(21) 	:= 'YYYY-MM-DD HH24'; -- << BUCKET_Date_FMT

	LV_BSL_ID						    NUMBER          := 16; --<< 'BSL NUMBER FOR CORP_ETL_MFB_BATCH'
	LV_BIL_ID						    NUMBER          := 4;
	LV_IDENTIFIER					    VARCHAR2(100)   := NULL;
	LV_BI_ID						    NUMBER(12)      := NULL;

--    LV_MFB_V2_BI_ID  					NUMBER    		:= NULL;
--    LV_MFB_V2_FBH_ID  					NUMBER    		:= NULL;

	-- THESE ARE USED TO UPDATE THE LAST RCORD
	-- PRIOR TO INSERTING THE NEW RECORD

    LV_MFB_V2_FBH_ID_OLD 				NUMBER 			:= NULL;
    LV_D_DATE_OLD 						DATE 			:= NULL;
	LV_BUCKET_START_DATE_OLD			DATE 			:= NULL;
	LV_BUCKET_END_DATE_OLD				DATE 			:= NULL;
    LV_CREATION_COUNT_OLD 				NUMBER 			:= NULL;
    LV_COMPLETION_COUNT_OLD 			NUMBER 			:= NULL;
    LV_MAX_D_DATE_OLD 					DATE 			:= NULL;

    LV_MFB_V2_FBH_ID     				NUMBER 			:= NULL;

    -- LV_STG_LAST_UPDATE_DATE 			DATE 			:= NULL;

--    LV_LAST_UPDATE_DATE 				DATE 			:= NULL;
--    LV_EVENT_DATE 						DATE 			:= NULL;  
    LV_END_DATE                         DATE 			:= NULL;  
	LV_BUCKET_START_DATE    DATE 		:= NULL;
	LV_BUCKET_END_DATE      DATE 		:= NULL;


--	LV_SRC_REC_SUMMARY          			NYHIX_MFB_V2_BATCH_SUMMARY%ROWTYPE;
	LV_FACT_REC							F_MFB_V2_BY_HOUR%ROWTYPE;

	BEGIN 

    GV_FACT_BY_HOUR_UPDATE_COUNT := GV_FACT_BY_HOUR_UPDATE_COUNT + 1;

--		LV_EVENT_DATE 			:= P_EVENT_DATE;
		IF  -- P_EVENT_DT < P_CREATE_DT
			TO_DATE(TO_CHAR(P_EVENT_DATE,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT)  
			<  TO_DATE(TO_CHAR(P_CREATE_DT,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT)
		THEN 
            GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT := GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT + 1;
			RETURN;
		END IF;

		IF P_BATCH_COMPLETED_DT IS NOT NULL
		AND -- P_EVENT_DT > P_BATCH_COMPLETED_DT
			TO_DATE(TO_CHAR(P_EVENT_DATE,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT)  
			>  TO_DATE(TO_CHAR(nvl(P_BATCH_COMPLETED_DT,sysdate),LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT)
		THEN
            GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT := GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT + 1;
			RETURN;
		END IF;

		IF P_CANCELLED_DT IS NOT NULL
		AND -- P_EVENT_DT > P_CANCELLED_DT
			TO_DATE(TO_CHAR(P_EVENT_DATE,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT)  
			>  TO_DATE(TO_CHAR(nvl(P_CANCELLED_DT,sysdate),LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT)
		THEN
            GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT := GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT + 1;
			RETURN;
		END IF;	

	-- VALIDATE FACT DATE RANGES.
		IF P_CREATE_DT >  NVL(P_BATCH_COMPLETED_DT,SYSDATE)
        OR P_CREATE_DT >  NVL(P_CANCELLED_DT,SYSDATE)
		OR P_CREATE_DT >  BPM_COMMON.MAX_DATE
        THEN
            GV_SQL_CODE := -20030;
            GV_LOG_MESSAGE := 'ATTEMPTED TO UPDATE INVALID FACT DATE RANGE.  ' || 
                'P_CREATE_DT = ' || P_CREATE_DT || 
                ' P_BATCH_COMPLETED_DT = ' || P_BATCH_COMPLETED_DT ||
                ' P_CANCELLED_DT = ' || P_CANCELLED_DT ||
                ' BPM_COMMON.MAX_DATE = '||BPM_COMMON.MAX_DATE;
            BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,NULL,LV_PROCEDURE_NAME,
                    P_MFB_V2_BI_ID,
                    LV_BIL_ID,
                    P_BATCH_GUID,P_MFB_V2_BI_ID,GV_LOG_MESSAGE,GV_SQL_CODE);
				--RAISE_APPLICATION_ERROR(GV_SQL_CODE,GV_LOG_MESSAGE);
            RETURN;
		END IF;

		-- GET THE MOST RECENT FACT AND SAVE TO THE 'OLD' LVs

		LV_MFB_V2_FBH_ID_OLD := NULL;

		BEGIN

			WITH MOST_RECENT_FACT AS
			(SELECT 
				MAX(F_MFB_V2_FBH_ID) MAX_FBH_ID, --<<< fact_by_hour_id
				MAX(D_DATE) MAX_D_DATE
			FROM F_MFB_V2_BY_HOUR
			WHERE MFB_V2_BI_ID = P_MFB_V2_BI_ID --<< Batch_Summary_id
			)  
			select 
				FBH.F_MFB_V2_FBH_ID,
				FBH.D_DATE,
				FBH.BUCKET_START_DATE,
				FBH.BUCKET_END_DATE,
				FBH.CREATION_COUNT,
				FBH.COMPLETION_COUNT,
				MOST_RECENT_FACT.MAX_D_DATE
			INTO 
				LV_MFB_V2_FBH_ID_OLD,
				LV_D_DATE_OLD,
				LV_BUCKET_START_DATE_OLD,
				LV_BUCKET_END_DATE_OLD,
				LV_CREATION_COUNT_OLD,
				LV_COMPLETION_COUNT_OLD,
				LV_MAX_D_DATE_OLD
			FROM 
				F_MFB_V2_BY_HOUR FBH,
				MOST_RECENT_FACT 
			WHERE
				FBH.F_MFB_V2_FBH_ID = MOST_RECENT_FACT.MAX_FBH_ID
				AND FBH.D_DATE = MOST_RECENT_FACT.MAX_D_DATE;   

		EXCEPTION

			WHEN NO_DATA_FOUND
			THEN
				NULL;

			WHEN OTHERS
            THEN
                DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE_F_MFB_V2_BY_HOUR GET RICENT DATA'||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
                DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE_F_MFB_V2_BY_HOUR GET RICENT DATA FOR P_MFB_V2_BI_ID '||P_MFB_V2_BI_ID);
				RAISE;

		END;	
		-- See if a Fact record was returned
		IF LV_MFB_V2_FBH_ID_OLD IS NULL
		AND P_REPROCESSED_FLAG = 'N'		-- IF REPROCESSED = 'Y' SKIP THIS
		THEN -- << Its possible that there is already a row in Batch Summary
             -- << but not in Fact BY Hour -- Insert the row and RETURN

            --DBMS_OUTPUT.PUT_LINE('update-insert '||p_batch_guid);

			INSERT_F_MFB_V2_BY_HOUR(
				P_MFB_V2_BI_ID,
				P_BATCH_GUID,
				P_EVENT_DATE,
				P_CREATE_DT,
				P_CANCELLED_DT,
				P_BATCH_COMPLETED_DT,
				P_REPROCESSED_FLAG);

			COMMIT;	

			RETURN;

		END IF;	

		IF P_REPROCESSED_FLAG = 'Y'
		THEN
			DELETE FROM F_MFB_V2_BY_HOUR
			WHERE MFB_V2_BI_ID = P_MFB_V2_BI_ID;
			COMMIT;
			RETURN;
		END IF;

       -- Do not modify fact table further once an instance has EVER been 
	   -- completed or cancelled.

		IF LV_COMPLETION_COUNT_OLD >= 1 THEN
            GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT := GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT + 1;
			RETURN;
		END IF;

		LV_END_DATE	:= COALESCE( P_BATCH_COMPLETED_DT, P_CANCELLED_DT, BPM_COMMON.MAX_DATE);

		IF LV_END_DATE < LV_MAX_D_DATE_OLD
		THEN

            DELETE FROM F_MFB_V2_BY_HOUR
            WHERE 
              MFB_V2_BI_ID = P_MFB_V2_BI_ID
              AND BUCKET_START_DATE > TO_DATE(TO_CHAR(LV_END_DATE,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT);   

            GV_F_MFB_V2_BY_HOUR_DELETE_COUNT := GV_F_MFB_V2_BY_HOUR_DELETE_COUNT + SQL%ROWCOUNT;
			-- *** REPULL THE DATES AFTER THE DELETE 
            -- *** FROM LAST REMAINIG RECORD AND SAVE TO THE 'OLD' LVs

			LV_MFB_V2_FBH_ID_OLD := NULL;

            WITH MOST_RECENT_FACT_BI_ID AS
				(SELECT 
					MAX(F_MFB_V2_FBH_ID) 	MAX_FMFBBH_ID,
					MAX(D_DATE) 	MAX_D_DATE
				FROM F_MFB_V2_BY_HOUR
				WHERE MFB_v2_BI_ID = P_MFB_V2_BI_ID
				) 
				SELECT 
					FBH.F_MFB_V2_FBH_ID,
					FBH.D_DATE,
					FBH.BUCKET_START_DATE,
					FBH.BUCKET_END_DATE,
					FBH.CREATION_COUNT,
					FBH.COMPLETION_COUNT,
					MOST_RECENT_FACT_BI_ID.MAX_D_DATE
				INTO 
					LV_MFB_V2_FBH_ID_OLD,
					LV_D_DATE_OLD,
					LV_BUCKET_START_DATE_OLD,
					LV_BUCKET_END_DATE_OLD,
					LV_CREATION_COUNT_OLD,
					LV_COMPLETION_COUNT_OLD,
					LV_MAX_D_DATE_OLD
				FROM 
					F_MFB_V2_BY_HOUR FBH,
					MOST_RECENT_FACT_BI_ID 
				WHERE FBH.F_MFB_V2_FBH_ID = MAX_FMFBBH_ID
				AND FBH.D_DATE = MOST_RECENT_FACT_BI_ID.MAX_D_DATE;

		END IF;  

		-- IF A RECORD WAS NOT RETURNED THEN EXIT
		IF LV_MFB_V2_FBH_ID_OLD IS NULL
		THEN
            GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT := GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT + 1;
			RETURN;
		END IF;	

		LV_BUCKET_START_DATE	:= TO_DATE(TO_CHAR(GREATEST(P_CREATE_DT,P_EVENT_DATE),'YYYY/MM/DD HH24'),'YYYY/MM/DD HH24');

		LV_END_DATE				:= COALESCE( P_BATCH_COMPLETED_DT, P_CANCELLED_DT);

		LV_BUCKET_END_DATE	    := TO_DATE(TO_CHAR(COALESCE(LV_END_DATE,BPM_COMMON.MAX_DATE),'YYYY/MM/DD HH24'),'YYYY/MM/DD HH24');


		IF LV_END_DATE IS NULL --<< it's not completed or cancelled
		THEN
			LV_FACT_REC.D_DATE 				:= P_EVENT_DATE;
			LV_FACT_REC.BUCKET_START_DATE 	:= TO_DATE(TO_CHAR(P_EVENT_DATE,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT);
			LV_FACT_REC.BUCKET_END_DATE 	:= TO_DATE(TO_CHAR(BPM_COMMON.MAX_DATE,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT);
			LV_FACT_REC.INVENTORY_COUNT 	:= 1;
			LV_FACT_REC.COMPLETION_COUNT 	:= 0;
		ELSE -- its completed or cancelled
			LV_FACT_REC.D_DATE 				:= P_EVENT_DATE;
			LV_FACT_REC.BUCKET_START_DATE 	:= TO_DATE(TO_CHAR(LV_END_DATE,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT);
			LV_FACT_REC.BUCKET_END_DATE 	:= LV_FACT_REC.BUCKET_START_DATE;     --<< this is from the old procedure  
			LV_FACT_REC.INVENTORY_COUNT 	:= 0;
			LV_FACT_REC.COMPLETION_COUNT 	:= 1;
		END IF;         

	IF TO_DATE(TO_CHAR(LV_D_DATE_OLD,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT) = LV_FACT_REC.BUCKET_START_DATE 
	THEN    
		-------------------------------------------------
		-- Same bucket time.
		-------------------------------------------------

		IF LV_CREATION_COUNT_OLD = 1 
		THEN
			LV_FACT_REC.CREATION_COUNT := LV_CREATION_COUNT_OLD;
		END IF;

        LV_FACT_REC.MFB_V2_BI_ID :=  P_MFB_V2_BI_ID;

		UPDATE F_MFB_V2_BY_HOUR
		--	SET ROW = LV_FACT_REC
            SET 
            -- F_MFB_V2_FBH_ID 			= LV_FACT_REC.F_MFB_V2_FBH_ID, 
            D_DATE                      = LV_FACT_REC.D_DATE,
            BUCKET_START_DATE           = LV_FACT_REC.BUCKET_START_DATE,
            BUCKET_END_DATE             = LV_FACT_REC.BUCKET_END_DATE,
           -- MFB_V2_BI_ID                = LV_FACT_REC.MFB_V2_BI_ID,
            CREATION_COUNT              = LV_FACT_REC.CREATION_COUNT,
            INVENTORY_COUNT             = LV_FACT_REC.INVENTORY_COUNT,
            COMPLETION_COUNT            = LV_FACT_REC.COMPLETION_COUNT
		WHERE F_MFB_V2_FBH_ID = LV_MFB_V2_FBH_ID_OLD;

    ELSE    

		-------------------------------------------------
		-- DIFFERENT BUCKET TIME.
		-------------------------------------------------

		UPDATE F_MFB_V2_BY_HOUR
			SET BUCKET_END_DATE = LV_FACT_REC.BUCKET_START_DATE
		WHERE F_MFB_V2_FBH_ID = LV_MFB_V2_FBH_ID_OLD;

        LV_FACT_REC.F_MFB_V2_FBH_ID := MAXDAT.SEQ_NYHIX_MFB_BATCH_BY_HOUR_ID.NEXTVAL;
        LV_FACT_REC.MFB_V2_BI_ID    := P_MFB_V2_BI_ID;

		INSERT INTO F_MFB_V2_BY_HOUR
            (
            F_MFB_V2_FBH_ID, 			
            D_DATE,                      
            BUCKET_START_DATE,           
            BUCKET_END_DATE,             
            MFB_V2_BI_ID,                
            CREATION_COUNT,              
            INVENTORY_COUNT,             
            COMPLETION_COUNT
            )
			VALUES 
            (
				LV_FACT_REC.F_MFB_V2_FBH_ID, 
				LV_FACT_REC.D_DATE,
				LV_FACT_REC.BUCKET_START_DATE,
				LV_FACT_REC.BUCKET_END_DATE,
				LV_FACT_REC.MFB_V2_BI_ID,
				nvl(LV_FACT_REC.CREATION_COUNT,0),
				nvl(LV_FACT_REC.INVENTORY_COUNT,0),
				nvl(LV_FACT_REC.COMPLETION_COUNT,0)
			);	

	END IF;

      EXCEPTION

		WHEN NO_DATA_FOUND 
		THEN
			NULL;

        WHEN OTHERS THEN
          GV_SQL_CODE := SQLCODE;
          GV_LOG_MESSAGE := SQLERRM;
          DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE_F_MFB_V2_BY_HOUR'||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
          DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE_F_MFB_V2_BY_HOUR FOR P_MFB_V2_BI_ID '||P_MFB_V2_BI_ID);
          BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,NULL,LV_PROCEDURE_NAME,LV_BSL_ID,LV_BIL_ID,LV_IDENTIFIER,P_MFB_V2_BI_ID,GV_LOG_MESSAGE,GV_SQL_CODE);  
          RAISE; 

      END UPDATE_F_MFB_V2_BY_HOUR;     

-- *****************************************************
-- *****************************************************
-- *****************************************************

-----------------------------------------------------
PROCEDURE UPDATE_BATCH_SUMMARY IS
PRAGMA AUTONOMOUS_TRANSACTION;
-----------------------------------------------------

	BEGIN


	IF 1 = 2
	   OR (	-- SPECIAL CASE TO FORCE AND UPDATE BASED ON THE GV_PARENT_JOB_ID 
			-- BEING LESS THAN GV_TARGET_REC.MFB_V2_PARENT_JOB_ID 
			--
			-- PRIMARILY USED FOR "REPROCESSED FLAG" WHERE THE PARENT_JOB_ID
			-- OF THE BATCH_SUMMARY ROW IS SET TO A VERY HIGH VALUE LIKE 999999999
			NVL(GV_PARENT_JOB_ID,0) <= NVL(GV_TARGET_REC.MFB_V2_PARENT_JOB_ID,0)
			)
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.BATCH_NAME),'?')	  				<>  	NVL(TO_CHAR(GV_TARGET_REC.BATCH_NAME),'?')						-- 	5	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.SOURCE_SERVER),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.SOURCE_SERVER),'?')					-- 	6	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.BATCH_DESCRIPTION),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.BATCH_DESCRIPTION),'?')				-- 	7	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.REPROCESSED_FLAG),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.REPROCESSED_FLAG),'?')				-- 	8	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CREATION_STATION_ID),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.CREATION_STATION_ID),'?')				-- 	9	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CREATION_USER_NAME),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.CREATION_USER_NAME),'?')				-- 	10	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CREATION_USER_ID),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.CREATION_USER_ID),'?')				-- 	11	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.BATCH_CLASS),'?')	  				<>  	NVL(TO_CHAR(GV_TARGET_REC.BATCH_CLASS),'?')						-- 	12	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.BATCH_CLASS_DES),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.BATCH_CLASS_DES),'?')					-- 	13	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.BATCH_TYPE),'?')	  				<>  	NVL(TO_CHAR(GV_TARGET_REC.BATCH_TYPE),'?')						-- 	14	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CREATE_DT),'?')	  				<>  	NVL(TO_CHAR(GV_TARGET_REC.CREATE_DT),'?')						-- 	15	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.COMPLETE_DT),'?')	  				<>  	NVL(TO_CHAR(GV_TARGET_REC.COMPLETE_DT),'?')						-- 	16	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.INSTANCE_STATUS),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.INSTANCE_STATUS),'?')					-- 	17	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.INSTANCE_STATUS_DT),'?')				-- 	18	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.BATCH_PAGE_COUNT),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.BATCH_PAGE_COUNT),'?')				-- 	19	NUMBER
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.BATCH_DOC_COUNT),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.BATCH_DOC_COUNT),'?')					-- 	20	NUMBER
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.BATCH_ENVELOPE_COUNT),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.BATCH_ENVELOPE_COUNT),'?')			-- 	21	NUMBER
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CANCEL_DT),'?')	  				<>  	NVL(TO_CHAR(GV_TARGET_REC.CANCEL_DT),'?')						-- 	22	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CANCEL_BY),'?')	  				<>  	NVL(TO_CHAR(GV_TARGET_REC.CANCEL_BY),'?')						-- 	23	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CANCEL_REASON),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.CANCEL_REASON),'?')			   		-- 	24	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CANCEL_METHOD),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.CANCEL_METHOD),'?')			   		-- 	25	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASF_SCAN_BATCH),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASF_SCAN_BATCH),'?')			   		-- 	26	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASSD_SCAN_BATCH),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASSD_SCAN_BATCH),'?')			   		-- 	27	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASED_SCAN_BATCH),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASED_SCAN_BATCH),'?')			   		-- 	28	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASPB_SCAN_BATCH),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASPB_SCAN_BATCH),'?')			   		-- 	29	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASF_PERFORM_QC),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASF_PERFORM_QC),'?')			   		-- 	30	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASSD_PERFORM_QC),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASSD_PERFORM_QC),'?')			   		-- 	31	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASED_PERFORM_QC),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASED_PERFORM_QC),'?')			   		-- 	32	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASPB_PERFORM_QC),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASPB_PERFORM_QC),'?')			   		-- 	33	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.KOFAX_QC_REASON),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.KOFAX_QC_REASON),'?')			   		-- 	34	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.ASF_CLASSIFICATION),'?')		 		-- 	35	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.ASSD_CLASSIFICATION),'?')		   		-- 	36	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.ASED_CLASSIFICATION),'?')		   		-- 	37	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CLASSIFICATION_DT),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.CLASSIFICATION_DT),'?')		        -- 	38	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASF_RECOGNITION),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASF_RECOGNITION),'?')			        -- 	39	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASSD_RECOGNITION),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASSD_RECOGNITION),'?')		        -- 	40	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASED_RECOGNITION),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASED_RECOGNITION),'?')		        -- 	41	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.RECOGNITION_DT),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.RECOGNITION_DT),'?')			        -- 	42	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASF_VALIDATE_DATA),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.ASF_VALIDATE_DATA),'?')		        -- 	43	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASSD_VALIDATE_DATA),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.ASSD_VALIDATE_DATA),'?')		        -- 	44	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASED_VALIDATE_DATA),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.ASED_VALIDATE_DATA),'?')		        -- 	45	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.ASPB_VALIDATE_DATA),'?')		        -- 	46	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.VALIDATION_DT),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.VALIDATION_DT),'?')			        -- 	47	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASF_CREATE_PDF),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASF_CREATE_PDF),'?')			        -- 	48	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASSD_CREATE_PDF),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASSD_CREATE_PDF),'?')			        -- 	49	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASED_CREATE_PDF),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASED_CREATE_PDF),'?')			        -- 	50	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASF_POPULATE_REPORTS),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.ASF_POPULATE_REPORTS),'?')	        -- 	51	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASSD_POPULATE_REPORTS),'?')	  	<>  	NVL(TO_CHAR(GV_TARGET_REC.ASSD_POPULATE_REPORTS),'?')	        -- 	52	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASED_POPULATE_REPORTS),'?')	  	<>  	NVL(TO_CHAR(GV_TARGET_REC.ASED_POPULATE_REPORTS),'?')	        -- 	53	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASF_RELEASE_DMS),'?')					-- 	54	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASSD_RELEASE_DMS),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASSD_RELEASE_DMS),'?')		        -- 	55	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.ASED_RELEASE_DMS),'?')		        -- 	56	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.BATCH_PRIORITY),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.BATCH_PRIORITY),'?')			        -- 	57	NUMBER
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.BATCH_DELETED),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.BATCH_DELETED),'?')			        -- 	58	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.PAGES_SCANNED_FLAG),'?')				-- 	59	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.DOCS_CREATED_FLAG),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.DOCS_CREATED_FLAG),'?')				-- 	60	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.DOCS_DELETED_FLAG),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.DOCS_DELETED_FLAG),'?')				-- 	61	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.PAGES_REPLACED_FLAG),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.PAGES_REPLACED_FLAG),'?')				-- 	62	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.PAGES_DELETED_FLAG),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.PAGES_DELETED_FLAG),'?')				-- 	63	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.BATCH_COMPLETE_DT),'?')				-- 	69	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CURRENT_BATCH_MODULE_ID),'?')	  	<>  	NVL(TO_CHAR(GV_TARGET_REC.CURRENT_BATCH_MODULE_ID),'?')			-- 	70	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.GWF_QC_REQUIRED),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.GWF_QC_REQUIRED),'?')					-- 	71	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CURRENT_STEP),'?')	  				<>  	NVL(TO_CHAR(GV_TARGET_REC.CURRENT_STEP),'?')					-- 	72	VARCHAR2
 --      OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CEJS_JOB_ID),'?')	  				<>  	NVL(TO_CHAR(GV_TARGET_REC.CEJS_JOB_ID),'?')						-- 	73	NUMBER
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA_USER_ID),'?')	<>  	NVL(TO_CHAR(GV_TARGET_REC.ASPB_VALIDATE_DATA_USER_ID),'?')		-- 	74	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.FAX_BATCH_SOURCE),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.FAX_BATCH_SOURCE),'?')				-- 	75	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.last_event_module_name),'?')		<>  	NVL(TO_CHAR(GV_TARGET_REC.last_event_module_name),'?')				-- 	75	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.last_event_status),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.last_event_status),'?')				-- 	75	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.AGE_IN_BUSINESS_DAYS),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.AGE_IN_BUSINESS_DAYS),'?')
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.AGE_IN_CALENDAR_DAYS),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.AGE_IN_CALENDAR_DAYS),'?')	  		
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.TIMELINESS_STATUS),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.TIMELINESS_STATUS),'?')
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.TIMELINESS_DAYS),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.TIMELINESS_DAYS),'?')	
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.TIMELINESS_DAYS_TYPE),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.TIMELINESS_DAYS_TYPE),'?')	 
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.TIMELINESS_DT),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.TIMELINESS_DT),'?')	
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.JEOPARDY_FLAG),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.JEOPARDY_FLAG),'?')	
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.JEOPARDY_DAYS),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.JEOPARDY_DAYS),'?')
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.JEOPARDY_DAYS_TYPE),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.JEOPARDY_DAYS_TYPE),'?')	
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.JEOPARDY_DT),'?')	  				<>  	NVL(TO_CHAR(GV_TARGET_REC.JEOPARDY_DT),'?')	 
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.TARGET_DAYS),'?')	  				<>  	NVL(TO_CHAR(GV_TARGET_REC.TARGET_DAYS),'?')	  
---------	   
	THEN
		UPDATE NYHIX_MFB_V2_BATCH_SUMMARY
		SET
			MFB_V2_CREATE_DATE 			= GV_SRC_REC_SUMMARY.MFB_V2_CREATE_DATE,    		--	1
			MFB_V2_UPDATE_DATE 			= SYSDATE,   	 		--	2
		--	BATCH_GUID 					= GV_SRC_REC_SUMMARY.BATCH_GUID,    				--	3
			EXTERNAL_BATCH_ID 			= GV_SRC_REC_SUMMARY.EXTERNAL_BATCH_ID,    			--	4
			BATCH_NAME 					= GV_SRC_REC_SUMMARY.BATCH_NAME,    				--	5
			SOURCE_SERVER 				= GV_SRC_REC_SUMMARY.SOURCE_SERVER,    				--	6
			BATCH_DESCRIPTION 			= GV_SRC_REC_SUMMARY.BATCH_DESCRIPTION,    			--	7
			REPROCESSED_FLAG 			= GV_SRC_REC_SUMMARY.REPROCESSED_FLAG,    			--	8
			CREATION_STATION_ID 		= GV_SRC_REC_SUMMARY.CREATION_STATION_ID,    		--	9
			CREATION_USER_NAME 			= GV_SRC_REC_SUMMARY.CREATION_USER_NAME,    		--	10
			CREATION_USER_ID 			= GV_SRC_REC_SUMMARY.CREATION_USER_ID,    			--	11
			BATCH_CLASS 				= GV_SRC_REC_SUMMARY.BATCH_CLASS,    				--	12
			BATCH_CLASS_DES 			= GV_SRC_REC_SUMMARY.BATCH_CLASS_DES,    			--	13
			BATCH_TYPE 					= GV_SRC_REC_SUMMARY.BATCH_TYPE,    				--	14
			CREATE_DT 					= GV_SRC_REC_SUMMARY.CREATE_DT,    					--	15
			COMPLETE_DT 				= GV_SRC_REC_SUMMARY.COMPLETE_DT,    				--	16
			INSTANCE_STATUS 			= GV_SRC_REC_SUMMARY.INSTANCE_STATUS,    			--	17
			INSTANCE_STATUS_DT 			= GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT,    		--	18
			BATCH_PAGE_COUNT 			= GV_SRC_REC_SUMMARY.BATCH_PAGE_COUNT,    			--	19
			BATCH_DOC_COUNT 			= GV_SRC_REC_SUMMARY.BATCH_DOC_COUNT,    			--	20
			BATCH_ENVELOPE_COUNT 		= GV_SRC_REC_SUMMARY.BATCH_ENVELOPE_COUNT,    		--	21
			CANCEL_DT 					= GV_SRC_REC_SUMMARY.CANCEL_DT,    					--	22
			CANCEL_BY 					= GV_SRC_REC_SUMMARY.CANCEL_BY,    					--	23
			CANCEL_REASON 				= GV_SRC_REC_SUMMARY.CANCEL_REASON,    				--	24
			CANCEL_METHOD 				= GV_SRC_REC_SUMMARY.CANCEL_METHOD,    				--	25
			ASF_SCAN_BATCH 				= GV_SRC_REC_SUMMARY.ASF_SCAN_BATCH,    			--	26
			ASSD_SCAN_BATCH 			= GV_SRC_REC_SUMMARY.ASSD_SCAN_BATCH,    			--	27
			ASED_SCAN_BATCH 			= GV_SRC_REC_SUMMARY.ASED_SCAN_BATCH,    			--	28
			ASPB_SCAN_BATCH 			= GV_SRC_REC_SUMMARY.ASPB_SCAN_BATCH,    			--	29
			ASF_PERFORM_QC 				= GV_SRC_REC_SUMMARY.ASF_PERFORM_QC,    			--	30
			ASSD_PERFORM_QC 			= GV_SRC_REC_SUMMARY.ASSD_PERFORM_QC,    			--	31
			ASED_PERFORM_QC 			= GV_SRC_REC_SUMMARY.ASED_PERFORM_QC,    			--	32
			ASPB_PERFORM_QC 			= GV_SRC_REC_SUMMARY.ASPB_PERFORM_QC,    			--	33
			KOFAX_QC_REASON 			= GV_SRC_REC_SUMMARY.KOFAX_QC_REASON,    			--	34
			ASF_CLASSIFICATION 			= GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION,    		--	35
			ASSD_CLASSIFICATION 		= GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION,    		--	36
			ASED_CLASSIFICATION 		= GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION,    		--	37
			CLASSIFICATION_DT 			= GV_SRC_REC_SUMMARY.CLASSIFICATION_DT,    			--	38
			ASF_RECOGNITION 			= GV_SRC_REC_SUMMARY.ASF_RECOGNITION,    			--	39
			ASSD_RECOGNITION 			= GV_SRC_REC_SUMMARY.ASSD_RECOGNITION,    			--	40
			ASED_RECOGNITION 			= GV_SRC_REC_SUMMARY.ASED_RECOGNITION,    			--	41
			RECOGNITION_DT 				= GV_SRC_REC_SUMMARY.RECOGNITION_DT,    			--	42
			ASF_VALIDATE_DATA 			= GV_SRC_REC_SUMMARY.ASF_VALIDATE_DATA,    			--	43
			ASSD_VALIDATE_DATA 			= GV_SRC_REC_SUMMARY.ASSD_VALIDATE_DATA,    		--	44
			ASED_VALIDATE_DATA 			= GV_SRC_REC_SUMMARY.ASED_VALIDATE_DATA,    		--	45
			ASPB_VALIDATE_DATA 			= GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA,    		--	46
			VALIDATION_DT 				= GV_SRC_REC_SUMMARY.VALIDATION_DT,    				--	47
			ASF_CREATE_PDF 				= GV_SRC_REC_SUMMARY.ASF_CREATE_PDF,    			--	48
			ASSD_CREATE_PDF 			= GV_SRC_REC_SUMMARY.ASSD_CREATE_PDF,    			--	49
			ASED_CREATE_PDF 			= GV_SRC_REC_SUMMARY.ASED_CREATE_PDF,    			--	50
			ASF_POPULATE_REPORTS 		= GV_SRC_REC_SUMMARY.ASF_POPULATE_REPORTS,    		--	51
			ASSD_POPULATE_REPORTS 		= GV_SRC_REC_SUMMARY.ASSD_POPULATE_REPORTS,    		--	52
			ASED_POPULATE_REPORTS 		= GV_SRC_REC_SUMMARY.ASED_POPULATE_REPORTS,    		--	53
			ASF_RELEASE_DMS 			= GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS,    			--	54
			ASSD_RELEASE_DMS 			= GV_SRC_REC_SUMMARY.ASSD_RELEASE_DMS,    			--	55
			ASED_RELEASE_DMS 			= GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS,    			--	56
			BATCH_PRIORITY 				= GV_SRC_REC_SUMMARY.BATCH_PRIORITY,    			--	57
			BATCH_DELETED 				= GV_SRC_REC_SUMMARY.BATCH_DELETED,    				--	58
			PAGES_SCANNED_FLAG 			= GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG,    		--	59
			DOCS_CREATED_FLAG 			= GV_SRC_REC_SUMMARY.DOCS_CREATED_FLAG,    			--	60
			DOCS_DELETED_FLAG 			= GV_SRC_REC_SUMMARY.DOCS_DELETED_FLAG,    			--	61
			PAGES_REPLACED_FLAG 		= GV_SRC_REC_SUMMARY.PAGES_REPLACED_FLAG,    		--	62
			PAGES_DELETED_FLAG 			= GV_SRC_REC_SUMMARY.PAGES_DELETED_FLAG,    		--	63
			BATCH_COMPLETE_DT 			= GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT,    			--	69
			CURRENT_BATCH_MODULE_ID 	= GV_SRC_REC_SUMMARY.CURRENT_BATCH_MODULE_ID,    	--	70
			GWF_QC_REQUIRED 			= GV_SRC_REC_SUMMARY.GWF_QC_REQUIRED,    			--	71
			CURRENT_STEP 				= GV_SRC_REC_SUMMARY.CURRENT_STEP,    				--	72
--			CEJS_JOB_ID 				= GV_SRC_REC_SUMMARY.CEJS_JOB_ID,    				--	73
			ASPB_VALIDATE_DATA_USER_ID 	= GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA_USER_ID,    --	74
			FAX_BATCH_SOURCE 			= GV_SRC_REC_SUMMARY.FAX_BATCH_SOURCE,    			--	75
			LAST_EVENT_MODULE_NAME		= GV_SRC_REC_SUMMARY.LAST_EVENT_MODULE_NAME,
			LAST_EVENT_STATUS			= GV_SRC_REC_SUMMARY.LAST_EVENT_STATUS,
			AGE_IN_BUSINESS_DAYS	  	=	GV_SRC_REC_SUMMARY.AGE_IN_BUSINESS_DAYS,
			AGE_IN_CALENDAR_DAYS	  	=	GV_SRC_REC_SUMMARY.AGE_IN_CALENDAR_DAYS,
			--	GV_TIMELINESS_DAYS 			NUMBER, 			--<< CORP_ETL_LIST_LKUP
			--	GV_TIMELINESS_DAYS_TYPE 	VARCHAR2(2 BYTE),   --<< CORP_ETL_LIST_LKUP
			--	GV_JEOPARDY_DAYS 			NUMBER, 			--<< CORP_ETL_LIST_LKUP
			--	GV_JEOPARDY_DAYS_TYPE 		VARCHAR2(2 BYTE), 	--<< CORP_ETL_LIST_LKUP
			--	GV_TARGET_DAYS 				NUMBER				--<< CORP_ETL_LIST_LKUP

			TIMELINESS_STATUS	  		=	GV_SRC_REC_SUMMARY.TIMELINESS_STATUS,
			TIMELINESS_DAYS	  			=	GV_TIMELINESS_DAYS,	
			TIMELINESS_DAYS_TYPE	  	=	GV_TIMELINESS_DAYS_TYPE,	 
			TIMELINESS_DT	  			=	GV_SRC_REC_SUMMARY.TIMELINESS_DT,	
			JEOPARDY_FLAG	  			=	GV_SRC_REC_SUMMARY.JEOPARDY_FLAG,	
			JEOPARDY_DAYS	  			=	GV_JEOPARDY_DAYS,
			JEOPARDY_DAYS_TYPE	  		=	GV_JEOPARDY_DAYS_TYPE,	
			JEOPARDY_DT	  				=	GV_SRC_REC_SUMMARY.JEOPARDY_DT,	 
			TARGET_DAYS	  				=	GV_TARGET_DAYS,	  
			MFB_V2_PARENT_JOB_ID 		=   GV_PARENT_JOB_ID    						--	76	
		WHERE ROWID = GV_TARGET_ROWID; 

		GV_RECORD_UPDATED_COUNT := GV_RECORD_UPDATED_COUNT + 1;

    END IF;

    COMMIT;

	EXCEPTION

        WHEN OTHERS THEN

		GV_DRIVER_KEY_NUMBER  	:= 'SRC_REC.BATCH_GUID : '||GV_SRC_REC_SUMMARY.BATCH_GUID;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_STATS_BATCH_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_STATS_BATCH';
		
        GV_SQL_CODE := SQLCODE;
        GV_LOG_MESSAGE := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE_BATCH_SUMMARY'||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
        DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE_BATCH_SUMMARY FOR BATCH_GUID '||GV_SRC_REC_SUMMARY.BATCH_GUID);

		POST_ERROR;

	END UPDATE_BATCH_SUMMARY;	

-- *****************************************************
-- *****************************************************
-- *****************************************************

PROCEDURE INSERT_BATCH_SUMMARY IS
PRAGMA AUTONOMOUS_TRANSACTION;
-----------------------------------------------------

	BEGIN

	--    DBMS_OUTPUT.PUT_LINE('Inserting Batch_GUID: '||GV_SRC_REC_SUMMARY.BATCH_GUID);

	Insert into NYHIX_MFB_V2_BATCH_SUMMARY
	( 
        MFB_V2_CREATE_DATE,
        MFB_V2_UPDATE_DATE,
		MFB_V2_BI_ID,
        BATCH_GUID,
        EXTERNAL_BATCH_ID,
        BATCH_NAME,
        SOURCE_SERVER,
        BATCH_DESCRIPTION,
        REPROCESSED_FLAG,
        CREATION_STATION_ID,
        CREATION_USER_NAME,
        CREATION_USER_ID,
        BATCH_CLASS,
        BATCH_CLASS_DES,
        BATCH_TYPE,
        CREATE_DT,
        COMPLETE_DT,
        INSTANCE_STATUS,
        INSTANCE_STATUS_DT,
        BATCH_PAGE_COUNT,
        BATCH_DOC_COUNT,
        BATCH_ENVELOPE_COUNT,
         CANCEL_DT,
        CANCEL_BY,
        CANCEL_REASON,
        CANCEL_METHOD,
        ASF_SCAN_BATCH,
        ASSD_SCAN_BATCH,
        ASED_SCAN_BATCH,
        ASPB_SCAN_BATCH,
        ASF_PERFORM_QC,
        ASSD_PERFORM_QC,
        ASED_PERFORM_QC,
        ASPB_PERFORM_QC,
        KOFAX_QC_REASON,
        ASF_CLASSIFICATION,
        ASSD_CLASSIFICATION,
        ASED_CLASSIFICATION,
        CLASSIFICATION_DT,
        ASF_RECOGNITION,
        ASSD_RECOGNITION,
        ASED_RECOGNITION,
        RECOGNITION_DT,
        ASF_VALIDATE_DATA,
        ASSD_VALIDATE_DATA,
        ASED_VALIDATE_DATA,
        ASPB_VALIDATE_DATA,
        VALIDATION_DT,
        ASF_CREATE_PDF,
        ASSD_CREATE_PDF,
        ASED_CREATE_PDF,
        ASF_POPULATE_REPORTS,
        ASSD_POPULATE_REPORTS,
        ASED_POPULATE_REPORTS,
        ASF_RELEASE_DMS,
        ASSD_RELEASE_DMS,
        ASED_RELEASE_DMS,
        BATCH_PRIORITY,
        BATCH_DELETED,
        PAGES_SCANNED_FLAG,
        DOCS_CREATED_FLAG,
        DOCS_DELETED_FLAG,
        PAGES_REPLACED_FLAG,
        PAGES_DELETED_FLAG,
        BATCH_COMPLETE_DT,
        CURRENT_BATCH_MODULE_ID,
        GWF_QC_REQUIRED,
        CURRENT_STEP,
 --       CEJS_JOB_ID,
        ASPB_VALIDATE_DATA_USER_ID,
        FAX_BATCH_SOURCE,
		LAST_EVENT_MODULE_NAME,
		LAST_EVENT_STATUS,
        AGE_IN_BUSINESS_DAYS,
        AGE_IN_CALENDAR_DAYS,
        TIMELINESS_STATUS,
        TIMELINESS_DAYS,
        TIMELINESS_DAYS_TYPE,
        TIMELINESS_DT,
        JEOPARDY_FLAG,
        JEOPARDY_DAYS,
        JEOPARDY_DAYS_TYPE,
        JEOPARDY_DT,
        TARGET_DAYS,
        MFB_V2_PARENT_JOB_ID
        )
	values
	(
        GV_MFB_V2_CREATE_DATE,
        GV_MFB_V2_UPDATE_DATE,
		GV_MFB_V2_BI_ID,
        GV_SRC_REC_SUMMARY.BATCH_GUID,
        nvl(GV_SRC_REC_SUMMARY.EXTERNAL_BATCH_ID,0),
        GV_SRC_REC_SUMMARY.BATCH_NAME,
        GV_SRC_REC_SUMMARY.SOURCE_SERVER,
        GV_SRC_REC_SUMMARY.BATCH_DESCRIPTION,
        GV_SRC_REC_SUMMARY.REPROCESSED_FLAG,
        GV_SRC_REC_SUMMARY.CREATION_STATION_ID,
        GV_SRC_REC_SUMMARY.CREATION_USER_NAME,
        GV_SRC_REC_SUMMARY.CREATION_USER_ID,
        GV_SRC_REC_SUMMARY.BATCH_CLASS,
        GV_SRC_REC_SUMMARY.BATCH_CLASS_DES,
        GV_SRC_REC_SUMMARY.BATCH_TYPE,
        NVL(GV_SRC_REC_SUMMARY.CREATE_DT,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.COMPLETE_DT,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.INSTANCE_STATUS,'Active'),
        NVL(GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT,SYSDATE),
        nvl(GV_SRC_REC_SUMMARY.BATCH_PAGE_COUNT,0),
        NVL(GV_SRC_REC_SUMMARY.BATCH_DOC_COUNT,0),
        NVL(GV_SRC_REC_SUMMARY.BATCH_ENVELOPE_COUNT,0),
        NVL(GV_SRC_REC_SUMMARY.CANCEL_DT,TO_DATE(NULL)),
        GV_SRC_REC_SUMMARY.CANCEL_BY,
        GV_SRC_REC_SUMMARY.CANCEL_REASON,
        GV_SRC_REC_SUMMARY.CANCEL_METHOD,
        NVL(GV_SRC_REC_SUMMARY.ASF_SCAN_BATCH,'?'),
        NVL(GV_SRC_REC_SUMMARY.ASSD_SCAN_BATCH,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.ASED_SCAN_BATCH,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.ASPB_SCAN_BATCH,'?'),
        GV_SRC_REC_SUMMARY.ASF_PERFORM_QC,
        GV_SRC_REC_SUMMARY.ASSD_PERFORM_QC,
        GV_SRC_REC_SUMMARY.ASED_PERFORM_QC,
        GV_SRC_REC_SUMMARY.ASPB_PERFORM_QC,
        GV_SRC_REC_SUMMARY.KOFAX_QC_REASON,
        GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION,
        NVL(GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.CLASSIFICATION_DT,TO_DATE(NULL)),
        GV_SRC_REC_SUMMARY.ASF_RECOGNITION,
        NVL(GV_SRC_REC_SUMMARY.ASSD_RECOGNITION,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.ASED_RECOGNITION,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.RECOGNITION_DT,TO_DATE(NULL)),
        GV_SRC_REC_SUMMARY.ASF_VALIDATE_DATA,
        NVL(GV_SRC_REC_SUMMARY.ASSD_VALIDATE_DATA,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.ASED_VALIDATE_DATA,TO_DATE(NULL)),
        GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA,
        NVL(GV_SRC_REC_SUMMARY.VALIDATION_DT,TO_DATE(NULL)),
        GV_SRC_REC_SUMMARY.ASF_CREATE_PDF,
        NVL(GV_SRC_REC_SUMMARY.ASSD_CREATE_PDF,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.ASED_CREATE_PDF,TO_DATE(NULL)),
        GV_SRC_REC_SUMMARY.ASF_POPULATE_REPORTS,
        NVL(GV_SRC_REC_SUMMARY.ASSD_POPULATE_REPORTS,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.ASED_POPULATE_REPORTS,TO_DATE(NULL)),
        GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS,
        NVL(GV_SRC_REC_SUMMARY.ASSD_RELEASE_DMS,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.BATCH_PRIORITY,0),
        GV_SRC_REC_SUMMARY.BATCH_DELETED,
        GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG,
        GV_SRC_REC_SUMMARY.DOCS_CREATED_FLAG,
        GV_SRC_REC_SUMMARY.DOCS_DELETED_FLAG,
        GV_SRC_REC_SUMMARY.PAGES_REPLACED_FLAG,
        GV_SRC_REC_SUMMARY.PAGES_DELETED_FLAG,
        NVL(GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT,TO_DATE(NULL)),
        GV_SRC_REC_SUMMARY.CURRENT_BATCH_MODULE_ID,
        GV_SRC_REC_SUMMARY.GWF_QC_REQUIRED,
        GV_SRC_REC_SUMMARY.CURRENT_STEP,
 --       NVL(GV_SRC_REC_SUMMARY.CEJS_JOB_ID,0),
        GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA_USER_ID,
        GV_SRC_REC_SUMMARY.FAX_BATCH_SOURCE,
		GV_SRC_REC_SUMMARY.LAST_EVENT_MODULE_NAME,
		GV_SRC_REC_SUMMARY.LAST_EVENT_STATUS,
		GV_SRC_REC_SUMMARY.AGE_IN_BUSINESS_DAYS,
		GV_SRC_REC_SUMMARY.AGE_IN_CALENDAR_DAYS,
		GV_SRC_REC_SUMMARY.TIMELINESS_STATUS,
		GV_SRC_REC_SUMMARY.TIMELINESS_DAYS,
		GV_SRC_REC_SUMMARY.TIMELINESS_DAYS_TYPE,
		GV_SRC_REC_SUMMARY.TIMELINESS_DT,
		GV_SRC_REC_SUMMARY.JEOPARDY_FLAG,
		GV_SRC_REC_SUMMARY.JEOPARDY_DAYS,
		GV_SRC_REC_SUMMARY.JEOPARDY_DAYS_TYPE,
		GV_SRC_REC_SUMMARY.JEOPARDY_DT,
		GV_SRC_REC_SUMMARY.TARGET_DAYS,
        NVL(GV_PARENT_JOB_ID,-999)
	);

   -- ROLLBACK;

   GV_RECORD_INSERTED_COUNT := GV_RECORD_INSERTED_COUNT + 1;

    COMMIT;

    GV_SRC_REC_SUMMARY.EXTERNAL_BATCH_ID := 0;
    GV_SRC_REC_SUMMARY.BATCH_PAGE_COUNT := 0;
    GV_SRC_REC_SUMMARY.BATCH_DOC_COUNT := 0;
    GV_SRC_REC_SUMMARY.BATCH_ENVELOPE_COUNT := 0;
    GV_SRC_REC_SUMMARY.BATCH_PRIORITY := 0;
--    GV_SRC_REC_SUMMARY.CEJS_JOB_ID := 0;
    GV_PARENT_JOB_ID := 0;


	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE '
            ||GV_SRC_REC_SUMMARY.BATCH_GUID||' '||SUBSTR(SQLERRM, 1, 3000));

        --	DBMS_OUTPUT.PUT_LINE('INSERT FAILURE BATCH_PAGE_COUNT '||GV_SRC_REC_SUMMARY.BATCH_PAGE_COUNT);
        --	DBMS_OUTPUT.PUT_LINE('INSERT FAILURE CANCEL_DT'||GV_SRC_REC_SUMMARY.CANCEL_DT);
        --	DBMS_OUTPUT.PUT_LINE('INSERT FAILURE EXTERNAL_BATCH_ID '||GV_SRC_REC_SUMMARY.EXTERNAL_BATCH_ID);
        --	DBMS_OUTPUT.PUT_LINE('INSERT FAILURE BATCH_ENVELOPE_COUNT '||GV_SRC_REC_SUMMARY.BATCH_ENVELOPE_COUNT);
        --	DBMS_OUTPUT.PUT_LINE('INSERT FAILURE BATCH_DOC_COUNT '||GV_SRC_REC_SUMMARY.BATCH_DOC_COUNT);
        --	DBMS_OUTPUT.PUT_LINE('INSERT FAILURE BATCH_PRIORITY '||GV_SRC_REC_SUMMARY.BATCH_PRIORITY);
        --	DBMS_OUTPUT.PUT_LINE('INSERT FAILURE MFB_V2_PARENT_JOB_ID '||GV_SRC_REC_SUMMARY.MFB_V2_PARENT_JOB_ID);
        
        GV_SQL_CODE := SQLCODE;
        GV_LOG_MESSAGE := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('FAILED IN INSERT_BATCH_SUMMARY'||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
        DBMS_OUTPUT.PUT_LINE('FAILED IN INSERT_BATCH_SUMMARY FOR BATCH_GUID '||GV_SRC_REC_SUMMARY.BATCH_GUID);


		POST_ERROR;
		RETURN;

	END INSERT_BATCH_SUMMARY;	

-- *****************************************************
-- *****************************************************
-- *****************************************************

PROCEDURE DELETE_BATCH_SUMMARY IS
-- IF THE JOIN CURSOR USES A FULL OUTTER JOIN THEN 
-- THIS PROCEDURE CAN BE USED TO IDENTIFY
-- RECORDS DELETED FROM THE SORCE SYSTEM
-- Since the join is NOT currntly a FULL OUTTER JOIN
-- This procedure is used to allow reprocessing of 
-- older 'Converted' records whic do not have any 
-- the detail behind them such as events, document etc
-----------------------------------------------------

	BEGIN

		GV_SRC_REC_SUMMARY  := GV_TARGET_REC;     

		GV_PROCESSED_COUNT := GV_PROCESSED_COUNT + 1;

	EXCEPTION

        WHEN OTHERS THEN

		Post_Error;

	END DELETE_BATCH_SUMMARY;	

-- *****************************************************
-- *****************************************************
-- *****************************************************


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
END Insert_Corp_ETL_Job_Statistics;	

-- *****************************************************
-- *****************************************************
-- *****************************************************

Procedure Update_Corp_ETL_Job_Statistics IS
PRAGMA AUTONOMOUS_TRANSACTION;
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

        GV_SQL_CODE := SQLCODE;
        GV_LOG_MESSAGE := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE JOB STATISTICS '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);

        RAISE;
END Update_Corp_ETL_Job_Statistics;	

-- *****************************************************
-- *****************************************************
-- *****************************************************

PROCEDURE Post_Error IS
--PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN

	GV_ERROR_COUNT := GV_ERROR_COUNT + 1;
	GV_NR_OF_ERROR := GV_NR_OF_ERROR + 1;

    GV_ERROR_CODES := SQLCODE;
    GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 3000);                 

	GV_ERR_DATE		:= SYSDATE;
	GV_ERROR_FIELD  := 'BATCH_GUID: '||GV_BATCH_GUID_ID;

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
		JOB_NAME, 
        NR_OF_ERROR, 
        PROCESS_NAME 
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
		              
        GV_SQL_CODE := SQLCODE;
        GV_LOG_MESSAGE := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('FAILED IN POST ERROR '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);

		DBMS_OUTPUT.PUT_LINE('Procedure Post_Error failed with '||GV_Error_Code||': '||GV_Error_Message);

	RETURN;


END Post_Error;

-- *****************************************************
-- *****************************************************
-- *****************************************************

Procedure Extract_Target ( P_SOURCE_SERVER varchar DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS
	BEGIN
    -- NOTE THIS TABLE IS CENTRAL ONLY.. THE P_SOURCE_SERVER IS NOT NEEDED 
	--		GV_TARGET_REC := NULL;

	SELECT 
		ROWID,
        MFB_V2_BI_ID,
		NVL(MFB_V2_CREATE_DATE,TO_DATE(NULL)),
		NVL(MFB_V2_UPDATE_DATE,TO_DATE(NULL)),
		BATCH_GUID,
		EXTERNAL_BATCH_ID,
		BATCH_NAME,
		SOURCE_SERVER,
		BATCH_DESCRIPTION,
		REPROCESSED_FLAG,
		CREATION_STATION_ID,
		CREATION_USER_NAME,
		CREATION_USER_ID,
		BATCH_CLASS,
		BATCH_CLASS_DES,
		BATCH_TYPE,
		NVL(CREATE_DT,TO_DATE(NULL)),
		NVL(COMPLETE_DT,TO_DATE(NULL)),
		INSTANCE_STATUS,
		NVL(INSTANCE_STATUS_DT,TO_DATE(NULL)),
		BATCH_PAGE_COUNT,
		BATCH_DOC_COUNT,
		BATCH_ENVELOPE_COUNT,
		NVL(CANCEL_DT,TO_DATE(NULL)),
		CANCEL_BY,
		CANCEL_REASON,
		CANCEL_METHOD,
		ASF_SCAN_BATCH,
		NVL(ASSD_SCAN_BATCH,TO_DATE(NULL)),
		NVL(ASED_SCAN_BATCH,TO_DATE(NULL)),
		ASPB_SCAN_BATCH,
		ASF_PERFORM_QC,
		NVL(ASSD_PERFORM_QC,TO_DATE(NULL)),
		NVL(ASED_PERFORM_QC,TO_DATE(NULL)),
		ASPB_PERFORM_QC,
		KOFAX_QC_REASON,
		ASF_CLASSIFICATION,
		NVL(ASSD_CLASSIFICATION,TO_DATE(NULL)),
		NVL(ASED_CLASSIFICATION,TO_DATE(NULL)),
		NVL(CLASSIFICATION_DT,TO_DATE(NULL)),
		ASF_RECOGNITION,
		NVL(ASSD_RECOGNITION,TO_DATE(NULL)),
		NVL(ASED_RECOGNITION,TO_DATE(NULL)),
		NVL(RECOGNITION_DT,TO_DATE(NULL)),
		ASF_VALIDATE_DATA,
		NVL(ASSD_VALIDATE_DATA,TO_DATE(NULL)),
		NVL(ASED_VALIDATE_DATA,TO_DATE(NULL)),
		ASPB_VALIDATE_DATA,
		NVL(VALIDATION_DT,TO_DATE(NULL)),
		ASF_CREATE_PDF,
		NVL(ASSD_CREATE_PDF,TO_DATE(NULL)),
		NVL(ASED_CREATE_PDF,TO_DATE(NULL)),
		ASF_POPULATE_REPORTS,
		NVL(ASSD_POPULATE_REPORTS,TO_DATE(NULL)),
		NVL(ASED_POPULATE_REPORTS,TO_DATE(NULL)),
		ASF_RELEASE_DMS,
		NVL(ASSD_RELEASE_DMS,TO_DATE(NULL)),
		NVL(ASED_RELEASE_DMS,TO_DATE(NULL)),
		BATCH_PRIORITY,
		BATCH_DELETED,
		PAGES_SCANNED_FLAG,
		DOCS_CREATED_FLAG,
		DOCS_DELETED_FLAG,
		PAGES_REPLACED_FLAG,
		PAGES_DELETED_FLAG,
		NVL(BATCH_COMPLETE_DT,TO_DATE(NULL)),
		CURRENT_BATCH_MODULE_ID,
		GWF_QC_REQUIRED,
		CURRENT_STEP,
--		CEJS_JOB_ID,
		ASPB_VALIDATE_DATA_USER_ID,
		FAX_BATCH_SOURCE,
		LAST_EVENT_MODULE_NAME,
		LAST_EVENT_STATUS,
		AGE_IN_BUSINESS_DAYS,
		AGE_IN_CALENDAR_DAYS,
		TIMELINESS_STATUS,
		TIMELINESS_DAYS,
		TIMELINESS_DAYS_TYPE,
		TIMELINESS_DT,
		JEOPARDY_FLAG,
		JEOPARDY_DAYS,
		JEOPARDY_DAYS_TYPE,
		JEOPARDY_DT,
		TARGET_DAYS,
		MFB_V2_PARENT_JOB_ID
	INTO
		GV_TARGET_ROWID,
        GV_TARGET_REC.MFB_V2_BI_ID,
		GV_TARGET_REC.MFB_V2_CREATE_DATE,
		GV_TARGET_REC.MFB_V2_UPDATE_DATE,
		GV_TARGET_REC.BATCH_GUID,
		GV_TARGET_REC.EXTERNAL_BATCH_ID,
		GV_TARGET_REC.BATCH_NAME,
		GV_TARGET_REC.SOURCE_SERVER,
		GV_TARGET_REC.BATCH_DESCRIPTION,
		GV_TARGET_REC.REPROCESSED_FLAG,
		GV_TARGET_REC.CREATION_STATION_ID,
		GV_TARGET_REC.CREATION_USER_NAME,
		GV_TARGET_REC.CREATION_USER_ID,
		GV_TARGET_REC.BATCH_CLASS,
		GV_TARGET_REC.BATCH_CLASS_DES,
		GV_TARGET_REC.BATCH_TYPE,
		GV_TARGET_REC.CREATE_DT,
		GV_TARGET_REC.COMPLETE_DT,
		GV_TARGET_REC.INSTANCE_STATUS,
		GV_TARGET_REC.INSTANCE_STATUS_DT,
		GV_TARGET_REC.BATCH_PAGE_COUNT,
		GV_TARGET_REC.BATCH_DOC_COUNT,
		GV_TARGET_REC.BATCH_ENVELOPE_COUNT,
		GV_TARGET_REC.CANCEL_DT,
		GV_TARGET_REC.CANCEL_BY,
		GV_TARGET_REC.CANCEL_REASON,
		GV_TARGET_REC.CANCEL_METHOD,
		GV_TARGET_REC.ASF_SCAN_BATCH,
		GV_TARGET_REC.ASSD_SCAN_BATCH,
		GV_TARGET_REC.ASED_SCAN_BATCH,
		GV_TARGET_REC.ASPB_SCAN_BATCH,
		GV_TARGET_REC.ASF_PERFORM_QC,
		GV_TARGET_REC.ASSD_PERFORM_QC,
		GV_TARGET_REC.ASED_PERFORM_QC,
		GV_TARGET_REC.ASPB_PERFORM_QC,
		GV_TARGET_REC.KOFAX_QC_REASON,
		GV_TARGET_REC.ASF_CLASSIFICATION,
		GV_TARGET_REC.ASSD_CLASSIFICATION,
		GV_TARGET_REC.ASED_CLASSIFICATION,
		GV_TARGET_REC.CLASSIFICATION_DT,
		GV_TARGET_REC.ASF_RECOGNITION,
		GV_TARGET_REC.ASSD_RECOGNITION,
		GV_TARGET_REC.ASED_RECOGNITION,
		GV_TARGET_REC.RECOGNITION_DT,
		GV_TARGET_REC.ASF_VALIDATE_DATA,
		GV_TARGET_REC.ASSD_VALIDATE_DATA,
		GV_TARGET_REC.ASED_VALIDATE_DATA,
		GV_TARGET_REC.ASPB_VALIDATE_DATA,
		GV_TARGET_REC.VALIDATION_DT,
		GV_TARGET_REC.ASF_CREATE_PDF,
		GV_TARGET_REC.ASSD_CREATE_PDF,
		GV_TARGET_REC.ASED_CREATE_PDF,
		GV_TARGET_REC.ASF_POPULATE_REPORTS,
		GV_TARGET_REC.ASSD_POPULATE_REPORTS,
		GV_TARGET_REC.ASED_POPULATE_REPORTS,
		GV_TARGET_REC.ASF_RELEASE_DMS,
		GV_TARGET_REC.ASSD_RELEASE_DMS,
		GV_TARGET_REC.ASED_RELEASE_DMS,
		GV_TARGET_REC.BATCH_PRIORITY,
		GV_TARGET_REC.BATCH_DELETED,
		GV_TARGET_REC.PAGES_SCANNED_FLAG,
		GV_TARGET_REC.DOCS_CREATED_FLAG,
		GV_TARGET_REC.DOCS_DELETED_FLAG,
		GV_TARGET_REC.PAGES_REPLACED_FLAG,
		GV_TARGET_REC.PAGES_DELETED_FLAG,
		GV_TARGET_REC.BATCH_COMPLETE_DT,
		GV_TARGET_REC.CURRENT_BATCH_MODULE_ID,
		GV_TARGET_REC.GWF_QC_REQUIRED,
		GV_TARGET_REC.CURRENT_STEP,
--		GV_TARGET_REC.CEJS_JOB_ID,
		GV_TARGET_REC.ASPB_VALIDATE_DATA_USER_ID,
		GV_TARGET_REC.FAX_BATCH_SOURCE,
		GV_TARGET_REC.LAST_EVENT_MODULE_NAME,
		GV_TARGET_REC.LAST_EVENT_STATUS,
		GV_TARGET_REC.AGE_IN_BUSINESS_DAYS,
		GV_TARGET_REC.AGE_IN_CALENDAR_DAYS,
		GV_TARGET_REC.TIMELINESS_STATUS,
		GV_TARGET_REC.TIMELINESS_DAYS,
		GV_TARGET_REC.TIMELINESS_DAYS_TYPE,
		GV_TARGET_REC.TIMELINESS_DT,
		GV_TARGET_REC.JEOPARDY_FLAG,
		GV_TARGET_REC.JEOPARDY_DAYS,
		GV_TARGET_REC.JEOPARDY_DAYS_TYPE,
		GV_TARGET_REC.JEOPARDY_DT,
		GV_TARGET_REC.TARGET_DAYS,
		GV_TARGET_REC.MFB_V2_PARENT_JOB_ID
	FROM NYHIX_MFB_V2_BATCH_SUMMARY
	WHERE BATCH_GUID = P_BATCH_GUID;

	EXCEPTION
		WHEN NO_DATA_FOUND
			THEN
            GV_TARGET_ROWID := NULL;
			GV_TARGET_REC := NULL;
		WHEN OTHERS THEN
		
        GV_SQL_CODE := SQLCODE;
        GV_LOG_MESSAGE := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT TARGET '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
        DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT TARGET FOR P_BATCH_GUID '||P_BATCH_GUID );
        
		RAISE;
	End Extract_Target;

-- *****************************************************
-- *****************************************************
-- *****************************************************

Procedure Extract_Stats_Batch ( P_SOURCE_SERVER VARCHAR DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS
	BEGIN

		SELECT 
			BATCH_GUID,
			EXTERNAL_BATCH_ID,
			BATCH_NAME,
			SOURCE_SERVER,
			BATCH_DESCRIPTION,
			CASE WHEN SOURCE_SERVER = 'CENTRAL' THEN NVL(REPROCESSED_FLAG,'N') ELSE 'N' END AS REPROCESSED_FLAG,
			CREATION_STATION_ID,
			CREATION_USER_NAME,
			CREATION_USER_ID,
			BATCH_CLASS,
			BATCH_CLASS_DESCRIPTION,
			--BATCH_TYPE,
			SBM_MIN_START_DATE_TIME AS CREATE_DT,
            CASE     
                WHEN BATCH_CLASS   =  'NYSOH_NoPrep_FAX'          then 'Expedited Appeals'
                WHEN BATCH_CLASS   =  'NYSOH_FAX_NavCAC'          then 'Nav/CAC Faxes'
                WHEN BATCH_CLASS   =  'NYSOH_RETURNED_MAIL'       then 'Returned Mail'
                WHEN BATCH_CLASS LIKE '%FAX'                      then 'Fax Batches'
                WHEN BATCH_CLASS LIKE '%MAIL'                     then 'Mail Batches' 
            ELSE 'NA' END AS BATCH_GROUP
		INTO
			GV_SRC_REC_SUMMARY.BATCH_GUID,
			GV_SRC_REC_SUMMARY.EXTERNAL_BATCH_ID,
			GV_SRC_REC_SUMMARY.BATCH_NAME,
			GV_SRC_REC_SUMMARY.SOURCE_SERVER,
			GV_SRC_REC_SUMMARY.BATCH_DESCRIPTION,
			GV_SRC_REC_SUMMARY.REPROCESSED_FLAG,
			GV_SRC_REC_SUMMARY.CREATION_STATION_ID,
			GV_SRC_REC_SUMMARY.CREATION_USER_NAME,
			GV_SRC_REC_SUMMARY.CREATION_USER_ID,
			GV_SRC_REC_SUMMARY.BATCH_CLASS,
			GV_SRC_REC_SUMMARY.BATCH_CLASS_DES,
			--GV_SRC_REC_SUMMARY.BATCH_TYPE,
			GV_SRC_REC_SUMMARY.CREATE_DT,
            GV_SRC_REC_SUMMARY.batch_type
		FROM NYHIX_MFB_V2_STATS_BATCH
		WHERE SOURCE_SERVER = nvl(P_SOURCE_SERVER,'CENTRAL')
        AND BATCH_GUID = 	P_BATCH_GUID;

	EXCEPTION
		WHEN NO_DATA_FOUND
			THEN
			
			IF P_BATCH_GUID = '{13ada2b1-4aa6-421d-8f5a-7a41e32c0e02}'
			THEN
               DBMS_OUTPUT.PUT_LINE('Extract_Stats_Batch: P_SOURCE_SERVER, p_BATCH_GUID : '||P_SOURCE_SERVER||', '||p_Batch_GUID||' NOT found');
			END IF;
            --   DBMS_OUTPUT.PUT_LINE('Extract_Stats_Batch: P_SOURCE_SERVER, p_BATCH_GUID : '||P_SOURCE_SERVER||', '||p_Batch_GUID||' NOT found');
            --   GV_SRC_REC_SUMMARY.BATCH_GUID := p_Batch_GUID;
			NULL;

		WHEN OTHERS 
		THEN
            GV_SQL_CODE := SQLCODE;
            GV_LOG_MESSAGE := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT STATS BATCH '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
            DBMS_OUTPUT.PUT_LINE('FAILED TO Extract_Stats_Batch FOR '||P_SOURCE_SERVER||' '||P_BATCH_GUID);
		RAISE;

	End Extract_Stats_Batch;

-- *****************************************************
-- *****************************************************
-- *****************************************************

Procedure Extract_Document ( P_SOURCE_SERVER varchar DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS

    -- NOTE THIS TABLE IS CENTRAL ONLY.. THE P_SOURCE_SERVER IS NOT NEEDED 

		CURSOR DOCUMENT_CSR IS
		SELECT 
			--MFB_V2_CREATE_DATE
			--MFB_V2_UPDATE_DATE
			BATCH_GUID,
			ECN,
			DOCUMENT_NUMBER,
			DCN,
			ORDERNUMBER,
			FORM_TYPE,
			DOC_CLASS,
			DOC_RECEIPT_DT,
			DOC_CREATION_DT,
			DOC_PAGE_COUNT,
			CLASSIFIED_DOC,
			DELETED,
			CONFIDENCE,
			CONFIDENT
			--MFB_V2_PARENT_JOB_ID
		FROM NYHIX_MFB_V2_DOCUMENT
		WHERE BATCH_GUID = P_BATCH_GUID
		ORDER BY DOC_RECEIPT_DT;

	BEGIN

		IF (DOCUMENT_CSR%ISOPEN)
		THEN
			CLOSE DOCUMENT_CSR;
		END IF;

		OPEN DOCUMENT_CSR;

		LOOP  -- 

			FETCH DOCUMENT_CSR 
			INTO 
				GV_SRC_REC_DOCUMENT.BATCH_GUID,
				GV_SRC_REC_DOCUMENT.ECN,
				GV_SRC_REC_DOCUMENT.DOCUMENT_NUMBER,
				GV_SRC_REC_DOCUMENT.DCN,
				GV_SRC_REC_DOCUMENT.ORDERNUMBER,
				GV_SRC_REC_DOCUMENT.FORM_TYPE,
				GV_SRC_REC_DOCUMENT.DOC_CLASS,
				GV_SRC_REC_DOCUMENT.DOC_RECEIPT_DT,
				GV_SRC_REC_DOCUMENT.DOC_CREATION_DT,
				GV_SRC_REC_DOCUMENT.DOC_PAGE_COUNT,
				GV_SRC_REC_DOCUMENT.CLASSIFIED_DOC,
				GV_SRC_REC_DOCUMENT.DELETED,
				GV_SRC_REC_DOCUMENT.CONFIDENCE,
				GV_SRC_REC_DOCUMENT.CONFIDENT;

			EXIT WHEN DOCUMENT_CSR%NOTFOUND;

		END LOOP;

		IF (DOCUMENT_CSR%ISOPEN)
		THEN
			CLOSE DOCUMENT_CSR;
		END IF;


	EXCEPTION
		WHEN NO_DATA_FOUND 
			THEN NULL;
		WHEN OTHERS 
			THEN 

            GV_SQL_CODE := SQLCODE;
            GV_LOG_MESSAGE := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT DOCUMENT '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
            DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT DOCUMENT FOR P_BATCH_GUID '||P_BATCH_GUID );


			RAISE;

	End Extract_Document;

-- *****************************************************
-- *****************************************************
-- *****************************************************


Procedure Extract_Envelope ( P_SOURCE_SERVER varchar DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS

    -- NOTE THIS TABLE IS CENTRAL ONLY.. THE P_SOURCE_SERVER IS NOT NEEDED 

	BEGIN
		null;
	End;

-- *****************************************************
-- *****************************************************
-- *****************************************************

Procedure Extract_Stats_Batch_Module ( P_SOURCE_SERVER varchar DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS
--GV_SRC_REC_STATS_BATCH_MODULE			
	BEGIN
		null;
	End;

-- *****************************************************
-- *****************************************************
-- *****************************************************

Procedure Extract_Maxdat_Reporting ( P_SOURCE_SERVER varchar DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS
--GV_SRC_REC_MAXDAT_REPORTING				
	BEGIN
    -- NOTE THIS TABLE IS CENTRAL ONLY.. THE P_SOURCE_SERVER IS NOT NEEDED 

		SELECT 
			sum(doc_page_count)	    			AS BATCH_PAGE_COUNT,
			COUNT(distinct dcn )				AS BATCH_DOC_COUNT,
			COUNT(distinct ecn )			    AS BATCH_ENVELOPE_COUNT,
			MAX(FAX_BATCH_SOURCE)				AS FAX_BATCH_SOURCE
		INTO 
			GV_SRC_REC_SUMMARY.BATCH_PAGE_COUNT,
			GV_SRC_REC_SUMMARY.BATCH_DOC_COUNT,
			GV_SRC_REC_SUMMARY.BATCH_ENVELOPE_COUNT,
			GV_SRC_REC_SUMMARY.FAX_BATCH_SOURCE
		FROM NYHIX_MFB_V2_MAXDAT_REPORTING
		WHERE BATCH_GUID = P_BATCH_GUID
		AND VALID = 1;

    Exception
        when No_data_found 
            then null;
            
        when others
        THEN
            GV_SQL_CODE := SQLCODE;
            GV_LOG_MESSAGE := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT MAXDAT REPORTING  '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
            DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT MAXDAT REPORTING FOR P_BATCH_GUID '||P_BATCH_GUID );
			DBMS_OUTPUT.PUT_LINE('FAILED TO Extract_Maxdat_Reporting FOR '||P_BATCH_GUID);
            raise;

	End Extract_Maxdat_Reporting;

-- *****************************************************
-- *****************************************************
-- *****************************************************

Procedure Extract_Stats_Form_Type ( P_SOURCE_SERVER varchar DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS
--GV_SRC_REC_STATS_FORM_TYPE				
	BEGIN
		null;
	End;

-- *****************************************************
-- *****************************************************
-- *****************************************************

Procedure Extract_Batch_Event ( P_SOURCE_SERVER VARCHAR DEFAULT 'CENTRAL', P_BATCH_GUID varchar default null) IS

    -- NOTE THIS TABLE IS CENTRAL ONLY.. THE P_SOURCE_SERVER IS NOT NEEDED 

	CURSOR BATCH_EVENT_CSR IS
	select MFB_V2_CREATE_DATE,
        MFB_V2_UPDATE_DATE,
        BATCH_MODULE_ID,
        BATCH_GUID,
        MODULE_LAUNCH_ID,
        MODULE_UNIQUE_ID,
        MODULENAME,
        MODULE_CLOSE_UNIQUE_ID,
        MODULE_CLOSE_NAME,
        BATCH_STATUS,
        START_DATE_TIME,
        END_DATE_TIME,
        USER_NAME,
        USER_ID,
        STATION_ID,
        SITE_NAME,
        SITE_ID,
        DELETED,
        PAGES_PER_DOCUMENT,
        PAGES_SCANNED,
        PAGES_DELETED,
        DOCUMENTS_CREATED,
        DOCUMENTS_DELETED,
        PAGES_REPLACED,
        ERROR_TEXT,
        EXTRACT_DATE,
        SOURCE_SERVER,
        MFB_V2_PARENT_JOB_ID,
		PRIORITY,
		SML_MODULE_NAME
    from NYHIX_MFB_V2_BATCH_EVENT
	where source_server = p_source_server
	and batch_guid = p_Batch_GUID
	--order by START_DATE_TIME;
    order by nvl(END_DATE_TIME,sysdate), START_DATE_TIME;
	--------------------------------------	
	BEGIN

		IF (BATCH_EVENT_CSR%ISOPEN)
		THEN
			CLOSE BATCH_EVENT_CSR;
		END IF;

		OPEN BATCH_EVENT_CSR;

	    GV_SRC_REC_SUMMARY.INSTANCE_STATUS		:= 'Active'; 


LOOP  -- FOR EACH BATCH_GUID 

			FETCH BATCH_EVENT_CSR 
            INTO GV_SRC_REC_EVENT.MFB_V2_CREATE_DATE,
                GV_SRC_REC_EVENT.MFB_V2_UPDATE_DATE,
                GV_SRC_REC_EVENT.BATCH_MODULE_ID,
                GV_SRC_REC_EVENT.BATCH_GUID,
                GV_SRC_REC_EVENT.MODULE_LAUNCH_ID,
                GV_SRC_REC_EVENT.MODULE_UNIQUE_ID,
                GV_SRC_REC_EVENT.MODULENAME,
                GV_SRC_REC_EVENT.MODULE_CLOSE_UNIQUE_ID,
                GV_SRC_REC_EVENT.MODULE_CLOSE_NAME,
                GV_SRC_REC_EVENT.BATCH_STATUS,
                GV_SRC_REC_EVENT.START_DATE_TIME,
                GV_SRC_REC_EVENT.END_DATE_TIME,
                GV_SRC_REC_EVENT.USER_NAME,
                GV_SRC_REC_EVENT.USER_ID,
                GV_SRC_REC_EVENT.STATION_ID,
                GV_SRC_REC_EVENT.SITE_NAME,
                GV_SRC_REC_EVENT.SITE_ID,
                GV_SRC_REC_EVENT.DELETED,
                GV_SRC_REC_EVENT.PAGES_PER_DOCUMENT,
                GV_SRC_REC_EVENT.PAGES_SCANNED,
                GV_SRC_REC_EVENT.PAGES_DELETED,
                GV_SRC_REC_EVENT.DOCUMENTS_CREATED,
                GV_SRC_REC_EVENT.DOCUMENTS_DELETED,
                GV_SRC_REC_EVENT.PAGES_REPLACED,
                GV_SRC_REC_EVENT.ERROR_TEXT,
                GV_SRC_REC_EVENT.EXTRACT_DATE,
                GV_SRC_REC_EVENT.SOURCE_SERVER,
                GV_SRC_REC_EVENT.MFB_V2_PARENT_JOB_ID,
				GV_SRC_REC_EVENT.PRIORITY,
				GV_SRC_REC_EVENT.SML_MODULE_NAME;

			GV_EVENT_COUNT	:= 	GV_EVENT_COUNT+1;

EXIT WHEN BATCH_EVENT_CSR%NOTFOUND;

	--------------------------------------------------------------------------------
	-- These are the values that can be obtained from CORP_ETL_CONTROL
	--GV_MFB_SCAN_MODULE_NAME: 				Scan
	--GV_MFB_QC_MODULE_NAME:				Quality Control
	--GV_MFB_CLASSIFICATION_MODULE_NAME: 	KCN Server		--<< BAD??
	--GV_MFB_RECOGNITION_MODULE_NAME: 		KTM Server
	--GV_MFB_VALIDATION_MODULE_NAME: 		KTM Validation
	--------------------------------------------------------------------------------
	-- These are the Modulename values as of October 2021
	-- 	Batch Manager
	-- 	BatchImageExtractCM
	-- 	Export
	-- 	KCN Server
	-- 	KTM Server
	-- 	KTM Validation
	-- 	Kofax Capture Utility
	-- 	NoPrepBatchImageExtractCM
	-- 	PDF Generator
	-- 	Quality Control
	-- 	Quality Control (FAX)
	-- 	Scan
	--------------------------------------------------------------------------------

-- *** SKIP THESE EVENTS  *** ( They are at the end of almost every batch )

IF GV_SRC_REC_EVENT.MODULENAME = 'Batch Manager'
AND GV_SRC_REC_EVENT.MODULE_CLOSE_UNIQUE_ID IS NULL
AND GV_SRC_REC_EVENT.MODULE_CLOSE_NAME IS NULL
AND GV_SRC_REC_EVENT.BATCH_STATUS = 64
AND GV_SRC_REC_EVENT.DELETED = 'Y'
THEN
    GV_SRC_REC_SUMMARY.CANCEL_DT := GV_SRC_REC_EVENT.START_DATE_TIME; 
    GV_SRC_REC_SUMMARY.BATCH_DELETED := 'Y';
	GV_SRC_REC_SUMMARY.INSTANCE_STATUS		:= 'Complete'; 
	CONTINUE;
END IF;	


-- NEW Code for LAST_EVENT_STATUS ( new field ) AND LAST_EVENT_MODULE_NAME

IF GV_SRC_REC_EVENT.BATCH_STATUS = 0
	THEN GV_SRC_REC_SUMMARY.LAST_Event_Status := 'Ready';
ELSIF GV_SRC_REC_EVENT.BATCH_STATUS = 2
	THEN GV_SRC_REC_SUMMARY.LAST_Event_Status := 'Ready';
ELSIF GV_SRC_REC_EVENT.BATCH_STATUS = 4 
	THEN GV_SRC_REC_SUMMARY.LAST_Event_Status := 'In Progress'; 
ELSIF GV_SRC_REC_EVENT.BATCH_STATUS =  8 
	THEN GV_SRC_REC_SUMMARY.LAST_Event_Status := 'Suspended'; 
ELSIF GV_SRC_REC_EVENT.BATCH_STATUS =  32 
	THEN GV_SRC_REC_SUMMARY.LAST_Event_Status := 'Error'; 
ELSIF GV_SRC_REC_EVENT.BATCH_STATUS = 64 
	THEN GV_SRC_REC_SUMMARY.LAST_Event_Status := 'Complete';
ELSIF GV_SRC_REC_EVENT.BATCH_STATUS =  128 
	THEN GV_SRC_REC_SUMMARY.LAST_Event_Status := 'Reserved'; 
ELSIF GV_SRC_REC_EVENT.BATCH_STATUS = 512 
	THEN GV_SRC_REC_SUMMARY.LAST_Event_Status := 'Locked';
END IF;	


GV_SRC_REC_SUMMARY.LAST_EVENT_MODULE_NAME := GV_SRC_REC_EVENT.MODULENAME;

GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT := GV_SRC_REC_EVENT.END_DATE_TIME; 


-- NOTE MANY OF THE 'EXPORTED' EVENTS HAVE DELETED = 'Y'
-- AND
-------------------------------------------------------------------------------
-- UPD9_010 - ASED_POPULATE_REPORTS
--	ASF_POPULATE_REPORTS
--	ASSD_POPULATE_REPORTS -- START DATE
--	ASED_POPULATE_REPORTS
-------------------------------------------------------------------------------


IF 	GV_SRC_REC_EVENT.MODULENAME  = 'Export' --'${EXPORT_MODULE_NAME}'
AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
AND GV_SRC_REC_EVENT.BATCH_STATUS=64
--AND GV_SRC_REC_SUMMARY.CANCEL_DT IS NULL
--AND GV_TARGET_REC.ASED_RELEASE_DMS = 'N'
THEN 
	GV_SRC_REC_SUMMARY.ASSD_RELEASE_DMS			:= GV_SRC_REC_EVENT.START_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS			:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS			:= 'Y'; --	YES_FLAG
	GV_SRC_REC_SUMMARY.COMPLETE_DT				:= GV_SRC_REC_EVENT.END_DATE_TIME;	--ASED_RELEASE_DMS
	GV_SRC_REC_SUMMARY.INSTANCE_STATUS			:= 'Complete'; 
	GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT		:= GV_SRC_REC_EVENT.END_DATE_TIME;	--ASED_RELEASE_DMS
    GV_SRC_REC_SUMMARY.CANCEL_DT 				:= NULL;
	GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT 		:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.CURRENT_BATCH_MODULE_ID 	:= GV_SRC_REC_EVENT.BATCH_MODULE_ID;
	--
	GV_SRC_REC_SUMMARY.ASSD_POPULATE_REPORTS 	:= GV_SRC_REC_EVENT.START_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASED_POPULATE_REPORTS 	:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASF_POPULATE_REPORTS		:= 'Y';
	--
	CONTINUE;
END IF;

-- If there is a "DELETED = 'Y' after skipping
-- the above rows... set the cancel_dt

IF GV_SRC_REC_EVENT.DELETED = 'Y'
THEN
	GV_SRC_REC_SUMMARY.CANCEL_DT 		:= GV_SRC_REC_EVENT.START_DATE_TIME; 
	GV_SRC_REC_SUMMARY.CANCEL_BY 		:= GV_SRC_REC_EVENT.USER_NAME;	
	GV_SRC_REC_SUMMARY.CANCEL_REASON 	:= 'Deleted';
	GV_SRC_REC_SUMMARY.CANCEL_METHOD 	:= 'Normal'; 
	GV_SRC_REC_SUMMARY.BATCH_DELETED 	:= 'Y'; 
	GV_SRC_REC_SUMMARY.INSTANCE_STATUS 	:= 'Complete';
END IF;

IF GV_SRC_REC_EVENT.DELETED = 'Y'
AND GV_SRC_REC_SUMMARY.CANCEL_DT IS NULL
AND GV_SRC_REC_EVENT.MODULENAME  <> 'Export' --'${EXPORT_MODULE_NAME}'
THEN 	
	GV_SRC_REC_SUMMARY.COMPLETE_DT					:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT			:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.CURRENT_BATCH_MODULE_ID		:= NULL;
	GV_SRC_REC_SUMMARY.BATCH_DELETED 				:= 'Y';
	GV_SRC_REC_SUMMARY.INSTANCE_STATUS 				:= 'Complete';
	GV_SRC_REC_SUMMARY.CANCEL_BY 					:= GV_SRC_REC_EVENT.USER_NAME;	
	GV_SRC_REC_SUMMARY.CANCEL_REASON 				:= 'Deleted';
	GV_SRC_REC_SUMMARY.CANCEL_METHOD 				:= 'Normal'; 
--	GV_SRC_REC_SUMMARY.CANCEL_DT					:= GV_SRC_REC_EVENT.END_DATE_TIME;
END IF;

-- SET COMPLETE_DT AND CURRENT_BATCH_MODULE_ID ( FOR INCOMPLETE BATCHES )
IF  GV_SRC_REC_EVENT.BATCH_STATUS = 64
AND GV_SRC_REC_EVENT.MODULENAME <> 'Export' 
AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
AND ( GV_SRC_REC_EVENT.END_DATE_TIME > GV_SRC_REC_SUMMARY.COMPLETE_DT
    OR GV_SRC_REC_SUMMARY.COMPLETE_DT IS NULL )
THEN 
	 GV_SRC_REC_SUMMARY.COMPLETE_DT := GV_SRC_REC_EVENT.END_DATE_TIME;
	 GV_SRC_REC_SUMMARY.CURRENT_BATCH_MODULE_ID := GV_SRC_REC_EVENT.BATCH_MODULE_ID;
END IF;

-- BATCH_PRIORITY
-- Grab the last one

GV_SRC_REC_SUMMARY.BATCH_PRIORITY := GV_SRC_REC_EVENT.PRIORITY;

-- Pages_Scanned Note Pages_scanned is a number 

IF GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG IS NULL
	THEN GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG := 'N';
END IF; 

IF NVL(GV_SRC_REC_EVENT.PAGES_SCANNED,0) <> 0
AND NVL(GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG,'N') = 'N' 
	THEN 
		GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG := 'Y';
END IF;	

-- Pages_Deleted
IF GV_SRC_REC_SUMMARY.PAGES_DELETED_FLAG IS NULL
THEN GV_SRC_REC_SUMMARY.PAGES_DELETED_FLAG := 'N';
END IF;

IF NVL(GV_SRC_REC_EVENT.PAGES_DELETED,0) <> 0
AND NVL(GV_SRC_REC_SUMMARY.PAGES_DELETED_FLAG,'N') = 'N' 
THEN GV_SRC_REC_SUMMARY.PAGES_DELETED_FLAG := 'Y';
END IF;

-- DOCS_Created
IF GV_SRC_REC_SUMMARY.DOCS_CREATED_FLAG IS NULL
THEN GV_SRC_REC_SUMMARY.DOCS_CREATED_FLAG := 'N';
END IF;

IF NVL(GV_SRC_REC_EVENT.DOCUMENTS_CREATED,0) <> 0
AND NVL(GV_SRC_REC_SUMMARY.DOCS_CREATED_FLAG,'N') = 'N'
THEN GV_SRC_REC_SUMMARY.DOCS_CREATED_FLAG := 'Y';
END IF;	

-- DELETED
IF GV_SRC_REC_SUMMARY.DOCS_DELETED_FLAG IS NULL
THEN GV_SRC_REC_SUMMARY.DOCS_DELETED_FLAG := 'N';
END IF;

IF NVL(GV_SRC_REC_EVENT.DOCUMENTS_DELETED,0) <> 0
AND NVL(GV_SRC_REC_SUMMARY.DOCS_DELETED_FLAG,'N') = 'N'
THEN GV_SRC_REC_SUMMARY.DOCS_DELETED_FLAG := 'Y';
END IF;	

-- PAGES_REPLACED
IF GV_SRC_REC_SUMMARY.PAGES_REPLACED_FLAG IS NULL
THEN GV_SRC_REC_SUMMARY.PAGES_REPLACED_FLAG := 'N';
END IF;

IF NVL(GV_SRC_REC_EVENT.PAGES_REPLACED,0) <> 0
AND NVL(GV_SRC_REC_SUMMARY.PAGES_REPLACED_FLAG,'N') = 'N' 
THEN GV_SRC_REC_SUMMARY.PAGES_REPLACED_FLAG := 'Y';
END IF;

-----------------------------------------------------------
-- THE FOLLOWING USE THE MODULENAME OR SML_MODULE_NAME
-- FROM AN INDIVIDULE EVENT RECORD TO POPULATES THE
-- 'AS%' COLUMNS.
-- TESTS WHICH REQUIRE DATA FROM MORE THAT ONE EVENT
-- ARE DONE AT THE CLOSE OF THE LOOP
-----------------------------------------------------------

-- UPD2_010 

IF GV_SRC_REC_EVENT.MODULENAME = 'Scan' --<<'${SCAN_MODULE_NAME}'
AND GV_SRC_REC_EVENT.BATCH_STATUS = 64			
AND GV_SRC_REC_EVENT.START_DATE_TIME IS NOT NULL
AND ( GV_SRC_REC_EVENT.START_DATE_TIME <= GV_SRC_REC_SUMMARY.ASSD_SCAN_BATCH
     OR GV_SRC_REC_SUMMARY.ASSD_SCAN_BATCH IS NULL )
THEN
	GV_SRC_REC_SUMMARY.ASF_SCAN_BATCH	:= 'Y';
	GV_SRC_REC_SUMMARY.ASSD_SCAN_BATCH  := GV_SRC_REC_EVENT.START_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASED_SCAN_BATCH 	:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASPB_SCAN_BATCH 	:= GV_SRC_REC_EVENT.USER_NAME; 
END IF;

-------------------------------------------------------------------------------
-- UPD3_010
-- SET
-- ASF_PERFORM_QC	FLAG ( Y OR N )
-- ASSD_PERFORM_QC -- START DATE
-- ASED_PERFORM_QC
-- ASPB_PERFORM_QC
-- KOFAX_QC_REASON  -- null
-------------------------------------------------------------------------------

IF 1=1
AND gv_src_rec_event.MODULENAME= 'Scan' --<<'${SCAN_MODULE_NAME}'
AND (
	gv_src_rec_event.MODULE_CLOSE_NAME = 'Quality Control' -- '${QC_MODULE_NAME}'
	OR gv_src_rec_event.MODULE_CLOSE_NAME = 'Quality Control (FAX)' -- '${QC_MODULE_NAME}'
	)
AND gv_src_rec_event.START_DATE_TIME IS NOT NULL
AND gv_src_rec_event.END_DATE_TIME IS NULL
THEN 
	gv_src_rec_summary.GWF_QC_REQUIRED 	:= 'Y';
	gv_src_rec_summary.ASSD_PERFORM_QC 	:= gv_src_rec_event.START_DATE_TIME;
	gv_src_rec_summary.ASED_PERFORM_QC := gv_src_rec_event.END_date_time;
	gv_src_rec_summary.ASPB_PERFORM_QC := gv_src_rec_event.user_name;
END IF;	

IF GV_SRC_REC_SUMMARY.CANCEL_DT IS NULL
AND GV_SRC_REC_EVENT.MODULENAME= 'Scan'
AND GV_SRC_REC_EVENT.MODULE_CLOSE_NAME <> 'Quality Control' --	'${QC_MODULE_NAME}'
AND GV_SRC_REC_SUMMARY.GWF_QC_REQUIRED IS NULL
AND GV_SRC_REC_SUMMARY.ASED_SCAN_BATCH IS NOT NULL
THEN GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION 	:= GV_SRC_REC_SUMMARY.ASED_SCAN_BATCH;
	GV_SRC_REC_SUMMARY.GWF_QC_REQUIRED 			:= 'N';
END IF;


-- MailFaxBatch_UPD3_030

IF (
	GV_SRC_REC_EVENT.MODULE_CLOSE_NAME = 'Quality Control' -- '${QC_MODULE_NAME}'
	OR gv_src_rec_event.MODULE_CLOSE_NAME = 'Quality Control (FAX)' -- '${QC_MODULE_NAME}'
	)
THEN
	gv_src_rec_summary.ASF_PERFORM_QC := 'Y';
	gv_src_rec_summary.ASSD_PERFORM_QC := gv_src_rec_event.start_date_time;
	gv_src_rec_summary.ASED_PERFORM_QC := gv_src_rec_event.END_date_time;
	gv_src_rec_summary.ASPB_PERFORM_QC := gv_src_rec_event.user_name;
end if;

-------------------------------------------------------------------------------
-- UPD4_010
-------------------------------------------------------------------------------

 IF 1=1
 -- AND GV_SRC_REC_SUMMARY.ASED_PERFORM_QC IS NULL
 -- AND ASSD_PERFORM_QC IS NOT NULL
 AND GV_SRC_REC_EVENT.MODULENAME = 'Quality Control'	--	'${QC_MODULE_NAME}'
 AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
 AND GV_SRC_REC_EVENT.BATCH_STATUS = 64			--??
THEN 
	GV_SRC_REC_SUMMARY.ASF_PERFORM_QC		:= 'Y';
	GV_SRC_REC_SUMMARY.ASED_PERFORM_QC		:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASPB_PERFORM_QC		:= GV_SRC_REC_EVENT.USER_NAME;
END IF;



-------------------------------------------------------------------------------
-- UPD5_010
-------------------------------------------------------------------------------

IF  GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION IS NOT NULL
	AND GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION IS NULL
	AND GV_SRC_REC_EVENT.MODULENAME =  'KCN Server' 		--'${CLASSIFICATION_MODULE_NAME}'
	AND GV_SRC_REC_EVENT.MODULE_CLOSE_NAME = 'KTM Server'	--'${RECOGNITION_MODULE_NAME}'
--	AND GV_SRC_REC_EVENT.BATCH_STATUS=64
	AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
	AND GV_TARGET_REC.CANCEL_DT IS NULL
THEN 
	GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION	:= GV_SRC_REC_EVENT.END_DATE_TIME; 
	GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION	:= 'Y';
END IF;	

-------------------------------------------------------------------------------
-- UPD6_010
--GV_MFB_RECOGNITION_MODULE_NAME: 	KTM Server
--ASF_RECOGNITION FLAG ( Y OR N )
--ASSD_RECOGNITION	-- START DATE
--ASED_RECOGNITION
--RECOGNITION_DT
-------------------------------------------------------------------------------

 IF GV_SRC_REC_EVENT.SML_MODULE_NAME = 'KTM Server' --'${RECOGNITION_MODULE_NAME}'
 AND GV_SRC_REC_EVENT.BATCH_STATUS = 64		
 AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
THEN
	--	GV_SRC_REC_SUMMARY.ASSD_VALIDATE_DATA		:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASF_RECOGNITION  := 'Y';		--??
	GV_SRC_REC_SUMMARY.ASSD_RECOGNITION	:= GV_SRC_REC_EVENT.START_DATE_TIME; 
	GV_SRC_REC_SUMMARY.ASED_RECOGNITION	:= GV_SRC_REC_EVENT.END_DATE_TIME; 
	GV_SRC_REC_SUMMARY.RECOGNITION_DT	:= GV_SRC_REC_EVENT.END_DATE_TIME; --??
END IF;

-------------------------------------------------------------------------------
-- UPD7_020 KTM VALIDATION
-- NOTE USE OF "STATS_MODULE_LAUNCH.MODULENAME" 
--	ASF_VALIDATE_DATA
--	ASSD_VALIDATE_DATA	-- START DATE
--	ASED_VALIDATE_DATA
--	ASPB_VALIDATE_DATA
--	ASPB_VALIDATE_DATA_USER_ID
-- VALIDATION_DT
-------------------------------------------------------------------------------

IF NVL(GV_SRC_REC_EVENT.SML_MODULE_NAME,'?') =  'KTM Validation'
-- AND GV_SRC_REC_EVENT.BATCH_STATUS	=	64 ??
AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
THEN  
	GV_SRC_REC_SUMMARY.ASF_VALIDATE_DATA 	:= 'Y';
	GV_SRC_REC_SUMMARY.ASSD_VALIDATE_DATA	:= GV_SRC_REC_EVENT.START_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASED_VALIDATE_DATA	:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA	:= GV_SRC_REC_EVENT.USER_ID;
	GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA_USER_ID := GV_SRC_REC_EVENT.USER_NAME;
	GV_SRC_REC_SUMMARY.VALIDATION_DT 		:= GV_SRC_REC_EVENT.END_DATE_TIME; --??
END IF;


IF NVL(GV_SRC_REC_EVENT.SML_MODULE_NAME,'?') = 'KTN Server'
AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
THEN  
	GV_SRC_REC_SUMMARY.Classification_DT := GV_SRC_REC_EVENT.END_DATE_TIME;
END IF;

-------------------------------------------------------------------------------
-- CLASSIFICATION
--	ASF_CLASSIFICATION FLAG ( Y OR N )
--	ASSD_CLASSIFICATION -- START DATE
--	ASED_CLASSIFICATION
--	CLASSIFICATION_DT
-------------------------------------------------------------------------------

IF NVL(GV_SRC_REC_EVENT.SML_MODULE_NAME,'?') = 'KTN Server'
AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
THEN  
	GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION := 'Y';
	GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION := GV_SRC_REC_EVENT.START_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION := GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.Classification_DT := GV_SRC_REC_EVENT.END_DATE_TIME; -- ??
END IF;

-------------------------------------------------------------------------------
-- PDF DATA
--	ASF_CREATE_PDF
--	ASSD_CREATE_PDF
--	ASED_CREATE_PDF
-------------------------------------------------------------------------------

-- UPD8_010 - Create PDF
IF 1=1
 AND GV_SRC_REC_EVENT.MODULENAME = 'PDF Generator' --'${PDF_MODULE_NAME}'
 AND GV_SRC_REC_EVENT.BATCH_STATUS=64    --??
 AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
THEN
	GV_SRC_REC_SUMMARY.ASF_CREATE_PDF			:= 'Y';
	GV_SRC_REC_SUMMARY.ASSD_CREATE_PDF			:=  GV_SRC_REC_EVENT.START_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASED_CREATE_PDF 			:=  GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASSD_POPULATE_REPORTS 	:=  GV_SRC_REC_EVENT.START_DATE_TIME;
END IF;

-----------------------------------------------
-----------------------------------------------

END LOOP;

-- Because the update looks at multiple 'values' these tests
-- must be done at the end of the LOOP

-------------------------------------------------------------------------------
-- UPD11_010 - SET BATCH_DELETED
-------------------------------------------------------------------------------

IF  GV_SRC_REC_SUMMARY.BATCH_DELETED IS NULL
THEN GV_SRC_REC_SUMMARY.BATCH_DELETED := 'N';
END IF;

-- UPD12_010  -- SET CURRENT_STEP	
IF 		GV_SRC_REC_SUMMARY.CANCEL_DT 				IS NOT NULL  
	THEN  	GV_SRC_REC_SUMMARY.CURRENT_STEP := 'End - Cancelled';
ELSIF 	GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS 		IS NOT NULL  
	THEN  	GV_SRC_REC_SUMMARY.CURRENT_STEP := 'End - Release to DMS';
ELSIF 	GV_SRC_REC_SUMMARY.ASSD_RELEASE_DMS 		IS NOT NULL  
	THEN  	GV_SRC_REC_SUMMARY.CURRENT_STEP := 'Release to DMS';
ELSIF 	GV_SRC_REC_SUMMARY.ASSD_POPULATE_REPORTS 	IS NOT NULL  
	THEN 	GV_SRC_REC_SUMMARY.CURRENT_STEP :=  'Populate Reports Data';
ELSIF 	GV_SRC_REC_SUMMARY.ASSD_CREATE_PDF 		IS NOT NULL  
	THEN  	GV_SRC_REC_SUMMARY.CURRENT_STEP := 'Create PDFs';
ELSIF 	GV_SRC_REC_SUMMARY.ASSD_VALIDATE_DATA 		IS NOT NULL  
	THEN  	GV_SRC_REC_SUMMARY.CURRENT_STEP := 'Review Batch (KTM Validation Module)';
ELSIF 	GV_SRC_REC_SUMMARY.ASSD_RECOGNITION 		IS NOT NULL  
	THEN  	GV_SRC_REC_SUMMARY.CURRENT_STEP := 'Batch Recognition (Recognition Server)';
ELSIF 	GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION 	IS NOT NULL  
	THEN  	GV_SRC_REC_SUMMARY.CURRENT_STEP := 'Classify Document and Extract Metadata';
ELSIF 	GV_SRC_REC_SUMMARY.ASSD_PERFORM_QC 		IS NOT NULL  
	THEN  	GV_SRC_REC_SUMMARY.CURRENT_STEP := 'Perform QC';
ELSIF 	GV_SRC_REC_SUMMARY.GWF_QC_REQUIRED 		IS NOT NULL  
	THEN  	GV_SRC_REC_SUMMARY.CURRENT_STEP := 'Gateway - QC Required';
ELSIF 	GV_SRC_REC_SUMMARY.ASSD_SCAN_BATCH 		IS NOT NULL  
	THEN  	GV_SRC_REC_SUMMARY.CURRENT_STEP := 'Scan Batch';
ELSE GV_SRC_REC_SUMMARY.CURRENT_STEP := 'Unknown'; 
END IF;


		IF (BATCH_EVENT_CSR%ISOPEN)
		THEN
			CLOSE BATCH_EVENT_CSR;
		END IF;

EXCEPTION
		WHEN NO_DATA_FOUND
			THEN
            -- DBMS_OUTPUT.PUT_LINE('Extract_Batch_Event: P_SOURCE_SERVER, p_BATCH_GUID : '||P_SOURCE_SERVER||' '||p_Batch_GUID|| 'NOT found');
			-- GV_SRC_REC_SUMMARY.BATCH_GUID := p_Batch_GUID;
			NULL;

		WHEN OTHERS THEN
		
            GV_SQL_CODE := SQLCODE;
            GV_LOG_MESSAGE := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT EVENT '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
            DBMS_OUTPUT.PUT_LINE('FAILED TO EXTRACT EVENT FOR '||P_SOURCE_SERVER||' '||P_BATCH_GUID);
		
			DBMS_OUTPUT.PUT_LINE('FAILED TO Extract_EVENT FOR '||P_BATCH_GUID);
			RAISE;



End Extract_Batch_Event; 

-- *****************************************************
-- *****************************************************
-- *****************************************************

-----------------------------------------------------
PROCEDURE LOAD_F_BY_DAY (P_BATCH_GUID VARCHAR  default NULL) 
IS
-----------------------------------------------------
	-------------------------------------------------------------------------------------------
	-- THE CURSOR USES SQL GENERATED QUERIES 1, 2, 3 AND 4
	-------------------------------------------------------------------------------------------


	BEGIN

		-- INITIAL SET Setup
		
		JOIN_REC := NULL;
		
		GV_AGE_IN_BUSINESS_DAYS := 0;
        GV_CANCEL_DT                := SYSDATE +1;
        GV_BATCH_GUID               := NULL;
        GV_BATCH_CANCEL_DT          := TO_DATE(NULL);
        GV_BATCH_COMPLETE_DT        := TO_DATE(NULL);


		
		GV_BATCH_GUID := P_BATCH_GUID;
		GV_BATCH_CANCEL_DT  := TO_DATE(NULL);
		GV_BATCH_COMPLETE_DT := TO_DATE(NULL);
		
		
		BEGIN
			SELECT TRUNC(LEAST(
                               NVL(CANCEL_DT,SYSDATE), 
                                NVL(BATCH_COMPLETE_DT,SYSDATE)
                                ) 
                        )
				INTO GV_CANCEL_DT
				FROM NYHIX_MFB_V2_BATCH_SUMMARY
				WHERE BATCH_GUID = GV_BATCH_GUID;
		EXCEPTION
				WHEN NO_DATA_FOUND 
				THEN NULL;
				RAISE;
		END;
        
		IF TRUNC(GV_CANCEL_DT) <> TRUNC(SYSDATE)
		THEN
			BEGIN
				DELETE FROM F_MFB_V2_BY_DAY
				WHERE BATCH_GUID = GV_BATCH_GUID
				AND D_DATE > TRUNC(GV_CANCEL_DT);
				
			GV_FACT_BY_DAY_DELETED_COUNT := GV_FACT_BY_DAY_DELETED_COUNT + sql%rowcount;
				
			EXCEPTION
				WHEN NO_DATA_FOUND 
				THEN NULL;
				
				WHEN OTHERS
				THEN
                    GV_SQL_CODE := SQLCODE;
                    GV_LOG_MESSAGE := SQLERRM;
                    DBMS_OUTPUT.PUT_LINE('FAILED TO DELETE FROM FACT BY DAY '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
                    DBMS_OUTPUT.PUT_LINE('FAILED TO DEKETE FROM FACT BY DAY FOR P_BATCH_GUID '||P_BATCH_GUID);
				
				RAISE;
			END;
			
		END IF;

		IF (F_BY_DAY_CSR%ISOPEN)
		THEN
			CLOSE F_BY_DAY_CSR;
		END IF;

		OPEN F_BY_DAY_CSR;

		LOOP

			FETCH F_BY_DAY_CSR INTO JOIN_REC;

			EXIT WHEN F_BY_DAY_CSR%NOTFOUND;

			GV_FACT_BY_DAY_PROCESSED_COUNT := GV_FACT_BY_DAY_PROCESSED_COUNT+1;
			
			IF JOIN_REC.SRC_BUSINESS_DAY_FLAG = 'Y'
			THEN 
                GV_AGE_IN_BUSINESS_DAYS := GV_AGE_IN_BUSINESS_DAYS + 1;
            END IF;
            
			IF JOIN_REC.SRC_BATCH_GUID IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN Update_F_BY_DAY;
			ELSIF JOIN_REC.SRC_BATCH_GUID IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NULL 
                --then null;
				THEN INSERT_F_BY_DAY;
			ELSIF JOIN_REC.SRC_BATCH_GUID IS NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN DELETE_F_BY_DAY;
			ELSE
				NULL;
			END IF;	

		END LOOP;

		COMMIT;

		IF (F_BY_DAY_CSR%ISOPEN)
		THEN
			CLOSE F_BY_DAY_CSR;
		END IF;

	-- Post the job statistics	
    --    DBMS_OUTPUT.PUT_LINE('GV_RECORD_PROCESSED_COUNT: '||GV_RECORD_PROCESSED_COUNT);
    --   DBMS_OUTPUT.PUT_LINE('GV_RECORD_INSERTED_COUNT: '||GV_RECORD_INSERTED_COUNT);
     --   DBMS_OUTPUT.PUT_LINE('GV_RECORD_UPDATED_COUNT: '||GV_RECORD_UPDATED_COUNT);
    --    DBMS_OUTPUT.PUT_LINE('GV_RECORD_DELETED_COUNT: '||GV_RECORD_DELETED_COUNT);

	EXCEPTION

		WHEN NO_DATA_FOUND
		THEN
			NULL;

        WHEN OTHERS THEN

            GV_ERROR_CODE := SQLCODE;
            GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 3000);                 

			DBMS_OUTPUT.PUT_LINE('Main Cursor failure for '||
				'SRC_BATCH_GUID: '||JOIN_REC.SRC_BATCH_GUID
				||' TARGET_BATCH_GUID: '||JOIN_REC.TARGET_BATCH_GUID
				||'SQLCODE '||GV_ERROR_CODE
				||' '||GV_ERROR_MESSAGE);

			ROLLBACK;

			RAISE;

END Load_F_BY_DAY;

-----------------------------------------------------

-----------------------------------------------------
PROCEDURE UPDATE_F_BY_DAY IS
-- USES SQL FROM 5 AND 6
-----------------------------------------------------

	BEGIN
	-- COMPARE -- SQL FROM SECTION 5
		IF 1=2
            OR NVL(JOIN_REC.TARGET_BATCH_GUID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_GUID,'-?93333')	-- 5 	1	VARCHAR2
            OR NVL(JOIN_REC.TARGET_D_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_D_DATE,SYSDATE - 93333)	-- 5 	2	DATE
            OR NVL(JOIN_REC.TARGET_MFB_V2_BI_ID, -93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_BI_ID, -93333)	-- 5 	3	NUMBER
       --     OR NVL(JOIN_REC.TARGET_MFB_V2_CREATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_CREATE_DATE,SYSDATE - 93333)	-- 5 	4	DATE
        --    OR NVL(JOIN_REC.TARGET_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	-- 5 	5	DATE
            OR NVL(JOIN_REC.TARGET_CREATE_DT,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_CREATE_DT,SYSDATE - 93333)	-- 5 	6	DATE
            OR NVL(JOIN_REC.TARGET_FAX_BATCH_SOURCE,'-?93333')	  <>  	NVL(JOIN_REC.SRC_FAX_BATCH_SOURCE,'-?93333')	-- 5 	7	VARCHAR2
            OR NVL(JOIN_REC.TARGET_BATCH_CLASS,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_CLASS,'-?93333')	-- 5 	8	VARCHAR2
            OR NVL(JOIN_REC.TARGET_CANCEL_DT,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_CANCEL_DT,SYSDATE - 93333)	-- 5 	9	DATE
            OR NVL(JOIN_REC.TARGET_REPROCESSED_DT,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_REPROCESSED_DT,SYSDATE - 93333)	-- 5 	10	DATE
            OR NVL(JOIN_REC.TARGET_BATCH_COMPLETE_DT,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_BATCH_COMPLETE_DT,SYSDATE - 93333)	-- 5 	11	DATE
            OR NVL(JOIN_REC.TARGET_AGE_IN_BUSINESS_HOURS, -93333)	  <>  	NVL(JOIN_REC.SRC_AGE_IN_BUSINESS_HOURS, -93333)	-- 5 	12	NUMBER
            OR NVL(JOIN_REC.TARGET_AGE_IN_BUSINESS_DAYS, -93333)	  <>  	CASE WHEN JOIN_REC.SRC_BUSINESS_DAY_FLAG = 'Y'
                                                                            THEN GV_AGE_IN_BUSINESS_DAYS
                                                                            ELSE 0 END  	                    -- 5 	13	NUMBER
            OR NVL(JOIN_REC.TARGET_CREATION_COUNT, -93333)	  <>  	NVL(JOIN_REC.SRC_CREATION_COUNT, -93333)	-- 5 	14	NUMBER
            OR NVL(JOIN_REC.TARGET_INVENTORY_COUNT, -93333)	  <>  	NVL(JOIN_REC.SRC_INVENTORY_COUNT, -93333)	-- 5 	15	NUMBER
            OR NVL(JOIN_REC.TARGET_COMPLETION_COUNT, -93333)	  <>  	NVL(JOIN_REC.SRC_COMPLETION_COUNT, -93333)	-- 5 	16	NUMBER
            OR NVL(JOIN_REC.TARGET_CANCELATION_COUNT, -93333)	  <>  	NVL(JOIN_REC.SRC_CANCELATION_COUNT, -93333)	-- 5 	17	NUMBER
            OR NVL(JOIN_REC.TARGET_REPROCESSED_COUNT, -93333)	  <>  	NVL(JOIN_REC.SRC_REPROCESSED_COUNT, -93333)	-- 5 	18	NUMBER
            OR NVL(JOIN_REC.TARGET_WEEKEND_FLAG,'?')                <>   NVL(JOIN_REC.SRC_WEEKEND_FLAG,'X')         -- 5 	19,
            OR NVL(JOIN_REC.TARGET_BUSINESS_DAY_FLAG,'?')           <>   NVL(JOIN_REC.SRC_BUSINESS_DAY_FLAG,'X')        -- 5 	20,
            OR NVL(JOIN_REC.TARGET_BATCH_GROUP,'?')                    <>   NVL(JOIN_REC.SRC_BATCH_GROUP,'?')
            OR NVL(JOIN_REC.TARGET_BATCH_PROGRAM,'?')                  <>   NVL(JOIN_REC.SRC_BATCH_PROGRAM,'?')
         THEN        
		UPDATE MAXDAT.F_MFB_V2_BY_DAY
 		SET  
		-- THE UPDATE SQL FROM SECTION 6
            BATCH_GUID                                =  JOIN_REC.SRC_BATCH_GUID,				-- 6 	1
            D_DATE                                    =  JOIN_REC.SRC_D_DATE,					-- 6 	2
            MFB_V2_BI_ID                              =  JOIN_REC.SRC_MFB_V2_BI_ID,				-- 6 	3
            -- MFB_V2_CREATE_DATE                        =  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 6 	4
            -- MFB_V2_UPDATE_DATE                        =  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 6 	5
            CREATE_DT                                 =  JOIN_REC.SRC_CREATE_DT,				-- 6 	6
            FAX_BATCH_SOURCE                          =  JOIN_REC.SRC_FAX_BATCH_SOURCE,			-- 6 	7
            BATCH_CLASS                               =  JOIN_REC.SRC_BATCH_CLASS,				-- 6 	8
            CANCEL_DT                                 =  JOIN_REC.SRC_CANCEL_DT,				-- 6 	9
            REPROCESSED_DT                            =  JOIN_REC.SRC_REPROCESSED_DT,			-- 6 	10
            BATCH_COMPLETE_DT                         =  JOIN_REC.SRC_BATCH_COMPLETE_DT,		-- 6 	11
            AGE_IN_BUSINESS_HOURS                     =  JOIN_REC.SRC_AGE_IN_BUSINESS_HOURS,	-- 6 	12
 --           AGE_IN_BUSINESS_DAYS                      =  JOIN_REC.SRC_AGE_IN_BUSINESS_DAYS,		-- 6 	13
            AGE_IN_BUSINESS_DAYS                      =  CASE WHEN JOIN_REC.SRC_BUSINESS_DAY_FLAG = 'Y'
                                                                THEN GV_AGE_IN_BUSINESS_DAYS
                                                                ELSE 0
                                                                END,		-- 6 	13
            CREATION_COUNT                            =  JOIN_REC.SRC_CREATION_COUNT,			-- 6 	14
            INVENTORY_COUNT                           =  JOIN_REC.SRC_INVENTORY_COUNT,			-- 6 	15
            COMPLETION_COUNT                          =  JOIN_REC.SRC_COMPLETION_COUNT,			-- 6 	16
            CANCELATION_COUNT                         =  JOIN_REC.SRC_CANCELATION_COUNT,		-- 6 	17
            REPROCESSED_COUNT                         =  JOIN_REC.SRC_REPROCESSED_COUNT,		-- 6 	18
            WEEKEND_FLAG                              =  JOIN_REC.SRC_WEEKEND_FLAG,             -- 6 	19,
            BUSINESS_DAY_FLAG                         =  JOIN_REC.SRC_BUSINESS_DAY_FLAG,         -- 6 	20,
            BATCH_GROUP                               = JOIN_REC.SRC_BATCH_GROUP,
            BATCH_PROGRAM                             = JOIN_REC.SRC_BATCH_PROGRAM
		WHERE ROWID = JOIN_REC.TARGET_ROWID;

		GV_RECORD_UPDATED_COUNT := GV_RECORD_UPDATED_COUNT + 1;

	ELSE
		NULL; -- NO UPDATE REQUIRED
	END IF;	

	EXCEPTION

        WHEN OTHERS THEN
        
            GV_SQL_CODE := SQLCODE;
            GV_LOG_MESSAGE := SQLERRM;
            DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE FATC BY DAY '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
            DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE FACT BY DAY FOR JOIN_REC.SRC_BATCH_GUID '||JOIN_REC.SRC_BATCH_GUID);

        DBMS_OUTPUT.PUT_LINE('UPDATE FAILURE '
            ||JOIN_REC.SRC_BATCH_GUID||' '
            --||JOIN_REC.SRC_rowid||' '
            ||JOIN_REC.target_rowid);

	--	GV_DRIVER_KEY_NUMBER  	:= 'SRC_ROWID : '||JOIN_REC.SRC_ROWID;
	--	GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_EVENTS_OLTP';	
	--	GV_ERR_LEVEL		  	:= 'Warning';
	--	GV_PROCESS_NAME 		:= 'Update_EVENTS';

	--	POST_ERROR;

	END UPDATE_F_BY_DAY;	

-----------------------------------------------------
PROCEDURE INSERT_F_BY_DAY IS
-- USES SQL  FROM 7 AND 8
-----------------------------------------------------

	BEGIN

		INSERT INTO MAXDAT.F_MFB_V2_BY_DAY
		(   -- SQL FROM SECTION 7
            BATCH_GUID,                             	-- 7 	1
            D_DATE,                                 	-- 7 	2
            MFB_V2_BI_ID,                           	-- 7 	3
        --    MFB_V2_CREATE_DATE,                     	-- 7 	4
        --    MFB_V2_UPDATE_DATE,                     	-- 7 	5
            CREATE_DT,                              	-- 7 	6
            FAX_BATCH_SOURCE,                       	-- 7 	7
            BATCH_CLASS,                            	-- 7 	8
            CANCEL_DT,                              	-- 7 	9
            REPROCESSED_DT,                         	-- 7 	10
            BATCH_COMPLETE_DT,                      	-- 7 	11
            AGE_IN_BUSINESS_HOURS,                  	-- 7 	12
            AGE_IN_BUSINESS_DAYS,                   	-- 7 	13
            CREATION_COUNT,                         	-- 7 	14
            INVENTORY_COUNT,                        	-- 7 	15
            COMPLETION_COUNT,                       	-- 7 	16
            CANCELATION_COUNT,                      	-- 7 	17
            REPROCESSED_COUNT,                     		-- 7 	18
            WEEKEND_FLAG,                               -- 7 	19,
            BUSINESS_DAY_FLAG,                           -- 7 	20,
            BATCH_GROUP,
            BATCH_PROGRAM
			)
		VALUES ( -- SQL FROM SECTION 8
            JOIN_REC.SRC_BATCH_GUID,					-- 8 	1
            JOIN_REC.SRC_D_DATE,						-- 8 	2
            JOIN_REC.SRC_MFB_V2_BI_ID,					-- 8 	3
         --   JOIN_REC.SRC_MFB_V2_CREATE_DATE,			-- 8 	4
         --   JOIN_REC.SRC_MFB_V2_UPDATE_DATE,			-- 8 	5
            JOIN_REC.SRC_CREATE_DT,						-- 8 	6
            JOIN_REC.SRC_FAX_BATCH_SOURCE,				-- 8 	7
            JOIN_REC.SRC_BATCH_CLASS,					-- 8 	8
            JOIN_REC.SRC_CANCEL_DT,						-- 8 	9
            JOIN_REC.SRC_REPROCESSED_DT,				-- 8 	10
            JOIN_REC.SRC_BATCH_COMPLETE_DT,				-- 8 	11
            JOIN_REC.SRC_AGE_IN_BUSINESS_HOURS,			-- 8 	12
            CASE WHEN JOIN_REC.SRC_BUSINESS_DAY_FLAG = 'Y'
                THEN GV_AGE_IN_BUSINESS_DAYS
                ELSE 0 END,			-- 8 	13
            JOIN_REC.SRC_CREATION_COUNT,				-- 8 	14
            JOIN_REC.SRC_INVENTORY_COUNT,				-- 8 	15
            JOIN_REC.SRC_COMPLETION_COUNT,				-- 8 	16
            JOIN_REC.SRC_CANCELATION_COUNT,				-- 8 	17
            JOIN_REC.SRC_REPROCESSED_COUNT,				-- 8 	18
            JOIN_REC.SRC_WEEKEND_FLAG,                  -- 8 	19,
            JOIN_REC.SRC_BUSINESS_DAY_FLAG,             -- 8 	20,
            JOIN_REC.SRC_BATCH_GROUP,
            JOIN_REC.SRC_BATCH_PROGRAM
			);

		GV_RECORD_INSERTED_COUNT := GV_RECORD_INSERTED_COUNT + 1;


	EXCEPTION

        WHEN OTHERS THEN
--        null;
            GV_ERROR_CODE := SQLCODE;
            GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 3000);                 

        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE IN FACT_BY_DAY'
            ||JOIN_REC.SRC_BATCH_GUID||' '
            ||JOIN_REC.TARGET_BATCH_GUID||' '
            ||JOIN_REC.SRC_CREATE_DT||' '			
            ||'  SQLCODE '||GV_ERROR_CODE
			||' '||GV_ERROR_MESSAGE);
    

        -- '${MFB_V2_REMOTE_START_DATE}'
	--	GV_DRIVER_KEY_NUMBER  	:= 'SRC BATCH_MODULE_ID : '||JOIN_REC.SRC_BATCH_GUID;
	--	GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_EVENTS_OLTP';	
	--	GV_ERR_LEVEL		  	:= 'Warning';
	--	GV_PROCESS_NAME 		:= 'Update_EVENTS';

	--	POST_ERROR;

	END INSERT_F_BY_DAY;	

-----------------------------------------------------
PROCEDURE DELETE_F_BY_DAY IS
-- IF THE JOIN CURSOR USES A FULL OUTTER JOIN THEN 
-- THIS PROCEDURE CAN BE USED TO IDENTIFY
-- ROECORDS DELETED FROM THE SORCE SYSTEM
-----------------------------------------------------

	BEGIN

		NULL;

		GV_FACT_BY_DAY_DELETED_COUNT := GV_FACT_BY_DAY_DELETED_COUNT + 1;

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('DELETE FAILURE'||' '
            ||JOIN_REC.SRC_BATCH_GUID||' '
            ||JOIN_REC.TARGET_BATCH_GUID);

		--Post_Error;

	END DELETE_F_BY_DAY;	




-- *****************************************************
-- *****************************************************
-- *****************************************************

END NYHIX_MFB_V2_BATCH_SUMMARY_PKG;
/

show errors

CREATE OR REPLACE FORCE VIEW MAXDAT.D_MFB_V2_CURRENT_SV
(MFB_BI_ID, BATCH_GUID, BATCH_ID, BATCH_NAME, CREATION_STATION_ID, 
 BATCH_CREATED_BY, CREATION_USER_ID, BATCH_CLASS, BATCH_CLASS_DESCRIPTION, BATCH_TYPE, 
 CREATE_DT, COMPLETE_DT, INSTANCE_STATUS, INSTANCE_STATUS_DT, BATCH_PAGE_COUNT, 
 BATCH_DOC_COUNT, BATCH_ENVELOPE_COUNT, CANCEL_DT, CANCEL_BY, CANCEL_REASON, 
 CANCEL_METHOD, SCAN_BATCH_FLAG, PERFORM_SCAN_START, PERFORM_SCAN_END, PERFORM_SCAN_PERFORMED_BY, 
 PERFORM_QC_FLAG, PERFORM_QC_START, PERFORM_QC_END, PERFORM_QC_PERFORMED_BY, KOFAX_QC_REASON, 
 CLASSIFICATION_FLAG, CLASSIFICATION_START, CLASSIFICATION_END, CLASSIFICATION_DT, RECOGNITION_FLAG, 
 RECOGNITION_START, RECOGNITION_END, RECOGNITION_DT, VALIDATE_DATA_FLAG, VALIDATE_DATA_START, 
 VALIDATE_DATA_END, VALIDATE_DATA_PERFORMED_BY, VALIDATION_DT, CREATE_PDF_FLAG, CREATE_PDFS_START, 
 CREATE_PDFS_END, POPULATE_REPORTS_DATA_FLAG, POPULATE_REPORTS_DATA_START, POPULATE_REPORTS_DATA_END, RELEASE_TO_DMS_FLAG, 
 RELEASE_TO_DMS_START, RELEASE_TO_DMS_END, BATCH_PRIORITY, BATCH_DELETED, PAGES_SCANNED, 
 DOCUMENTS_CREATED, DOCUMENTS_DELETED, PAGES_REPLACED_FLAG, PAGES_DELETED_FLAG, AGE_IN_BUSINESS_DAYS, 
 AGE_IN_CALENDAR_DAYS, TIMELINESS_STATUS, TIMELINESS_DAYS, TIMELINESS_DAYS_TYPE, TIMELINESS_DT, 
 JEOPARDY_FLAG, JEOPARDY_DAYS, JEOPARDY_DAYS_TYPE, JEOPARDY_DT, TARGET_DAYS, 
 BATCH_COMPLETE_DT, CURRENT_BATCH_MODULE_ID, GWF_QC_REQUIRED, CURRENT_STEP, SOURCE_SERVER, 
 BATCH_DESCRIPTION, REPROCESSED_FLAG, VALIDATE_DATA_PERF_BY_USER_ID, FAX_BATCH_SOURCE)
BEQUEATH DEFINER
AS 
SELECT 
MFB_V2_BI_ID							AS MFB_BI_ID,
BATCH_GUID                              AS BATCH_GUID,
EXTERNAL_BATCH_ID                       AS BATCH_ID,
BATCH_NAME                              AS BATCH_NAME,
CREATION_STATION_ID                     AS CREATION_STATION_ID,
CREATION_USER_NAME                      AS BATCH_CREATED_BY,
CREATION_USER_ID                        AS CREATION_USER_ID,
BATCH_CLASS                             AS BATCH_CLASS,
BATCH_CLASS_DES                         AS BATCH_CLASS_DESCRIPTION,
BATCH_TYPE								AS BATCH_TYPE,
CREATE_DT                               AS CREATE_DT,
COMPLETE_DT                             AS COMPLETE_DT,
INSTANCE_STATUS                         AS INSTANCE_STATUS,
INSTANCE_STATUS_DT                      AS INSTANCE_STATUS_DT,
BATCH_PAGE_COUNT                        AS BATCH_PAGE_COUNT,
BATCH_DOC_COUNT                         AS BATCH_DOC_COUNT,
BATCH_ENVELOPE_COUNT                    AS BATCH_ENVELOPE_COUNT,
CANCEL_DT                               AS CANCEL_DT,
CANCEL_BY                               AS CANCEL_BY,
CANCEL_REASON                           AS CANCEL_REASON,
CANCEL_METHOD                           AS CANCEL_METHOD,
ASF_SCAN_BATCH                          AS SCAN_BATCH_FLAG,
ASSD_SCAN_BATCH                         AS PERFORM_SCAN_START,
ASED_SCAN_BATCH                         AS PERFORM_SCAN_END,
ASPB_SCAN_BATCH                         AS PERFORM_SCAN_PERFORMED_BY,
ASF_PERFORM_QC                          AS PERFORM_QC_FLAG,
ASSD_PERFORM_QC                         AS PERFORM_QC_START,
ASED_PERFORM_QC                         AS PERFORM_QC_END,
ASPB_PERFORM_QC                         AS PERFORM_QC_PERFORMED_BY,
KOFAX_QC_REASON                         AS KOFAX_QC_REASON,
ASF_CLASSIFICATION                      AS CLASSIFICATION_FLAG,
ASSD_CLASSIFICATION                     AS CLASSIFICATION_START,
ASED_CLASSIFICATION                     AS CLASSIFICATION_END,
CLASSIFICATION_DT                       AS CLASSIFICATION_DT,
ASF_RECOGNITION                         AS RECOGNITION_FLAG,
ASSD_RECOGNITION                        AS RECOGNITION_START,
ASED_RECOGNITION                        AS RECOGNITION_END,
RECOGNITION_DT                          AS RECOGNITION_DT,
ASF_VALIDATE_DATA                       AS VALIDATE_DATA_FLAG,
ASSD_VALIDATE_DATA                      AS VALIDATE_DATA_START,
ASED_VALIDATE_DATA                      AS VALIDATE_DATA_END,
ASPB_VALIDATE_DATA                      AS VALIDATE_DATA_PERFORMED_BY,
VALIDATION_DT                           AS VALIDATION_DT,
ASF_CREATE_PDF                          AS CREATE_PDF_FLAG,
ASSD_CREATE_PDF                         AS CREATE_PDFS_START,
ASED_CREATE_PDF                         AS CREATE_PDFS_END,
ASF_POPULATE_REPORTS                    AS POPULATE_REPORTS_DATA_FLAG,
ASSD_POPULATE_REPORTS                   AS POPULATE_REPORTS_DATA_START,
ASED_POPULATE_REPORTS                   AS POPULATE_REPORTS_DATA_END,
ASF_RELEASE_DMS                         AS RELEASE_TO_DMS_FLAG,
ASSD_RELEASE_DMS                        AS RELEASE_TO_DMS_START,
ASED_RELEASE_DMS                        AS RELEASE_TO_DMS_END,
BATCH_PRIORITY                          AS BATCH_PRIORITY,
BATCH_DELETED                           AS BATCH_DELETED,
PAGES_SCANNED_FLAG                      AS PAGES_SCANNED,
DOCS_CREATED_FLAG                       AS DOCUMENTS_CREATED,
DOCS_DELETED_FLAG                       AS DOCUMENTS_DELETED,
PAGES_REPLACED_FLAG                     AS PAGES_REPLACED_FLAG,
PAGES_DELETED_FLAG                      AS PAGES_DELETED_FLAG,
AGE_IN_BUSINESS_DAYS                    AS AGE_IN_BUSINESS_DAYS,
AGE_IN_CALENDAR_DAYS                    AS AGE_IN_CALENDAR_DAYS,
TIMELINESS_STATUS                       AS TIMELINESS_STATUS,
TIMELINESS_DAYS                         AS TIMELINESS_DAYS,
TIMELINESS_DAYS_TYPE                    AS TIMELINESS_DAYS_TYPE,
TIMELINESS_DT                           AS TIMELINESS_DT,
JEOPARDY_FLAG                           AS JEOPARDY_FLAG,
JEOPARDY_DAYS                           AS JEOPARDY_DAYS,
JEOPARDY_DAYS_TYPE                      AS JEOPARDY_DAYS_TYPE,
JEOPARDY_DT                             AS JEOPARDY_DT,
TARGET_DAYS                             AS TARGET_DAYS,
BATCH_COMPLETE_DT                       AS BATCH_COMPLETE_DT,
CURRENT_BATCH_MODULE_ID                 AS CURRENT_BATCH_MODULE_ID,
GWF_QC_REQUIRED                         AS GWF_QC_REQUIRED,
CURRENT_STEP                            AS CURRENT_STEP,
SOURCE_SERVER                           AS SOURCE_SERVER,
BATCH_DESCRIPTION                       AS BATCH_DESCRIPTION,
REPROCESSED_FLAG                        AS REPROCESSED_FLAG,
ASPB_VALIDATE_DATA_USER_ID              AS VALIDATE_DATA_PERF_BY_USER_ID,
FAX_BATCH_SOURCE                        AS FAX_BATCH_SOURCE
FROM MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY;