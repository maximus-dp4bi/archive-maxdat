-------------------------------------------------------------
-- CLEAR OUT EXISTING MFB_V2 VALUES
DELETE FROM MAXDAT.CORP_ETL_CONTROL WHERE NAME LIKE 'MFB_V2%';
-- INSERTING into MAXDAT.CORP_ETL_CONTROL
SET DEFINE OFF;
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_CENTRAL_FLAG','V','Y','Flag to run MFB Central ETL processing, Y run, N skip',to_date('01-JUN-21','DD-MON-RR'),to_date('01-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_REPORT_MODULE_NAME','V','Advanced Reports - Data Exporter','This is the Kofax Report Module Name',to_date('01-JUN-21','DD-MON-RR'),to_date('01-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_EXPORT_MODULE_NAME','V','Export','This is the Kofax Export Module Name',to_date('01-JUN-21','DD-MON-RR'),to_date('01-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_REMOTE_FLAG','V','Y','Flag to run MFB Remote ETL processing, Y run, N skip',to_date('01-JUN-21','DD-MON-RR'),to_date('01-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_PDF_MODULE_NAME','V','PDF Generator','This is the Kofax PDF Module Name',to_date('01-JUN-21','DD-MON-RR'),to_date('01-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_VALIDATION_MODULE_NAME','V','KTM Validation','This is the Kofax Validation Module Name',to_date('01-JUN-21','DD-MON-RR'),to_date('01-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_RECOGNITION_MODULE_NAME','V','KTM Server','This is the Kofax Recognition Module Name',to_date('01-JUN-21','DD-MON-RR'),to_date('01-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_QC_MODULE_NAME','V','Quality Control','This is the Kofax QC Module Name',to_date('01-JUN-21','DD-MON-RR'),to_date('01-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_SCAN_MODULE_NAME','V','Scan','This is the Kofax Scan Module Name',to_date('01-JUN-21','DD-MON-RR'),to_date('01-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_CLASSIFICATION_MODULE_NAME','V','KCN Server','This is the Kofax Classification Module Name',to_date('01-JUN-21','DD-MON-RR'),to_date('01-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_MAXDATREPORTING_FLAG','V','Y','Flag to run MFB ARS ETL processing, Y run, N skip',to_date('01-JAN-21','DD-MON-RR'),to_date('01-JUN-21','DD-MON-RR'));

---
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_MAXDATREPORTING_LOOKBACK_DB_REC_NUM','N','50','This is the number of days to look back for Batch Created in ProcessMailFaxBatch Remote database run.',to_date('01-JUN-21','DD-MON-RR'),to_date('09-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_REMOTE_LOOKBACK_DAYS','N','5','This is the number of days to look back for Batch Created in ProcessMailFaxBatch Remote database run.',to_date('01-JUN-21','DD-MON-RR'),to_date('09-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_CENTRAL_LOOKBACK_DAYS','N','5','This is the number of days to look back for Batch Created in ProcessMailFaxBatch Remote database run.',to_date('01-JUN-21','DD-MON-RR'),to_date('09-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_MAXDATREPORTING_LAST_DB_REC_NUM','N','0','This is the timestamp from the previous run of Kofax Central MaxDatReporting',to_date('01-JUN-21','DD-MON-RR'),to_date('01-JUN-21','DD-MON-RR'));


Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_MAXDATREPORTING_LAST_UPDATE_DATE','D','01-JAN-21','This is the date of the last ProcessMailFaxBatch Reporting database run.',to_date('01-JUN-21','DD-MON-RR'),to_date('14-JUL-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_CENTRAL_LAST_UPDATE_DATE','D','01-JAN-20','This is the date of the last ProcessMailFaxBatch Central database run.',to_date('01-JUN-21','DD-MON-RR'),to_date('14-JUL-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_REMOTE_LAST_UPDATE_DATE','D','01-JAN-20','This is the date of the last ProcessMailFaxBatch Remote database run.',to_date('01-JUN-21','DD-MON-RR'),to_date('14-JUL-21','DD-MON-RR'));

COMMIT;
-------------------------------------------------------------

alter table MAXDAT.NYHIX_MFB_V2_STATS_BATCH_OLTP 
drop column SBM_START_DATE_TIME;

alter table MAXDAT.NYHIX_MFB_V2_STATS_BATCH_OLTP 
add ( sbm_min_start_date_time VARCHAR2(50 BYTE), 
      sbm_max_end_date_time VARCHAR2(50 BYTE)
      );
      
alter table MAXDAT.NYHIX_MFB_V2_STATS_BATCH_OLTP_ERR 
drop column SBM_START_DATE_TIME;

alter table MAXDAT.NYHIX_MFB_V2_STATS_BATCH_OLTP_ERR 
add ( sbm_min_start_date_time VARCHAR2(50 BYTE), 
      sbm_max_end_date_time VARCHAR2(50 BYTE)
      );
      
alter table MAXDAT.NYHIX_MFB_V2_STATS_BATCH 
drop column SBM_START_DATE_TIME;

alter table MAXDAT.NYHIX_MFB_V2_STATS_BATCH 
add ( sbm_min_start_date_time date, 
      sbm_max_end_date_time date
      );
      
	  
	  
------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------

create or replace PACKAGE BODY        NYHIX_MFB_V2_STATS_BATCH_PKG AS

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
	GV_DRIVER_TABLE_NAME  		VARCHAR2(100 BYTE)	:= 'NYHIX_MFB_V2_STATS_BATCH';
	GV_DRIVER_KEY_NUMBER  		VARCHAR2(100 BYTE)	:= NULL;
	GV_NR_OF_ERROR        		NUMBER				:= 0;
    GV_UPDATE_TS                DATE                := SYSDATE;

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


	-------------------------------------------------------------------------------------------
	-- THE CURSOR USES SQL FROM QUERIES 1, 2, 3 AND 4
	-------------------------------------------------------------------------------------------

	CURSOR JOIN_CSR IS
	WITH SRC AS
	(
	SELECT 
		ROWID    							 AS SRC_ROWID,
		-- Insert SQL from Query 1 section 1 Here
	--	SRC.MFB_V2_CREATE_DATE                   AS SRC_MFB_V2_CREATE_DATE,   	-- 1 	1
	--	SRC.MFB_V2_UPDATE_DATE                   AS SRC_MFB_V2_UPDATE_DATE,   	-- 1 	2
		SRC.OLTP_LOAD_SEQ						 AS SRC_OLTP_LOAD_SEQ,
		SRC.OLTP_LOAD_DATE_TIME					 AS SRC_OLTP_LOAD_DATE_TIME, 
		SRC.SOURCE_SERVER                        AS SRC_SOURCE_SERVER,        	-- 1 	3
--		SRC.SBM_START_DATE_TIME                  AS SRC_SBM_START_DATE_TIME,  	-- 1 	4
		SRC.EXTERNAL_BATCH_ID                    AS SRC_EXTERNAL_BATCH_ID,    	-- 1 	5
		SRC.BATCH_GUID                           AS SRC_BATCH_GUID,           	-- 1 	6
		SRC.BATCH_NAME                           AS SRC_BATCH_NAME,           	-- 1 	7
		SRC.BATCH_CLASS                          AS SRC_BATCH_CLASS,          	-- 1 	8
		SRC.BATCH_CLASS_DESCRIPTION              AS SRC_BATCH_CLASS_DESCRIPTION,	-- 1 	9
		SRC.BATCH_DESCRIPTION                    AS SRC_BATCH_DESCRIPTION,    	-- 1 	10
		SRC.BATCH_REFERENCE_ID                   AS SRC_BATCH_REFERENCE_ID,   	-- 1 	11
		SRC.BATCH_TYPE                           AS SRC_BATCH_TYPE,           	-- 1 	12
		SRC.CREATION_STATION_ID                  AS SRC_CREATION_STATION_ID,  	-- 1 	13
		SRC.CREATION_USER_ID                     AS SRC_CREATION_USER_ID,     	-- 1 	14
		SRC.CREATION_USER_NAME                   AS SRC_CREATION_USER_NAME,   	-- 1 	15
		SRC.TRANSFER_ID                          AS SRC_TRANSFER_ID,          	-- 1 	16
		SRC.SBM_MIN_START_DATE_TIME				 AS SRC_SBM_MIN_START_DATE_TIME,
		SRC.SBM_MAX_END_DATE_TIME                AS SRC_SBM_MAX_END_DATE_TIME
	FROM MAXDAT.NYHIX_MFB_V2_STATS_BATCH_OLTP SRC
	),
	TARGET AS
	(
	SELECT 
		ROWID    						  AS TARGET_ROWID,
		-- Insert SQL from Query 1 section 2 Here
	--	TARGET.MFB_V2_CREATE_DATE                AS TARGET_MFB_V2_CREATE_DATE,	-- 2 	1
	--	TARGET.MFB_V2_UPDATE_DATE                AS TARGET_MFB_V2_UPDATE_DATE,	-- 2 	2
		TARGET.SOURCE_SERVER                     AS TARGET_SOURCE_SERVER,     	-- 2 	3
	--	TARGET.SBM_START_DATE_TIME               AS TARGET_SBM_START_DATE_TIME,	-- 2 	4
		TARGET.EXTERNAL_BATCH_ID                 AS TARGET_EXTERNAL_BATCH_ID, 	-- 2 	5
		TARGET.BATCH_GUID                        AS TARGET_BATCH_GUID,        	-- 2 	6
		TARGET.BATCH_NAME                        AS TARGET_BATCH_NAME,        	-- 2 	7
		TARGET.BATCH_CLASS                       AS TARGET_BATCH_CLASS,       	-- 2 	8
		TARGET.BATCH_CLASS_DESCRIPTION           AS TARGET_BATCH_CLASS_DESCRIPTION,	-- 2 	9
		TARGET.BATCH_DESCRIPTION                 AS TARGET_BATCH_DESCRIPTION, 	-- 2 	10
		TARGET.BATCH_REFERENCE_ID                AS TARGET_BATCH_REFERENCE_ID,	-- 2 	11
		TARGET.BATCH_TYPE                        AS TARGET_BATCH_TYPE,        	-- 2 	12
		TARGET.CREATION_STATION_ID               AS TARGET_CREATION_STATION_ID,	-- 2 	13
		TARGET.CREATION_USER_ID                  AS TARGET_CREATION_USER_ID,  	-- 2 	14
		TARGET.CREATION_USER_NAME                AS TARGET_CREATION_USER_NAME,	-- 2 	15
		TARGET.TRANSFER_ID                       AS TARGET_TRANSFER_ID,       	-- 2 	16
		TARGET.SBM_MIN_START_DATE_TIME			 AS TARGET_SBM_MIN_START_DATE_TIME,
		TARGET.SBM_MAX_END_DATE_TIME             AS TARGET_SBM_MAX_END_DATE_TIME
	FROM MAXDAT.NYHIX_MFB_V2_STATS_BATCH TARGET
	)
	SELECT 
		SRC_ROWID,
		TARGET_ROWID,
		-- insert SQL from 3 and 4 here
	--	SRC_MFB_V2_CREATE_DATE,                                               	-- 3 	1
	--	SRC_MFB_V2_UPDATE_DATE,                                               	-- 3 	2
		SRC_OLTP_LOAD_SEQ,
		SRC_OLTP_LOAD_DATE_TIME, 	
		SRC_SOURCE_SERVER,                                                    	-- 3 	3
	--	SRC_SBM_START_DATE_TIME,                                              	-- 3 	4
		SRC_EXTERNAL_BATCH_ID,                                                	-- 3 	5
		SRC_BATCH_GUID,                                                       	-- 3 	6
		SRC_BATCH_NAME,                                                       	-- 3 	7
		SRC_BATCH_CLASS,                                                      	-- 3 	8
		SRC_BATCH_CLASS_DESCRIPTION,                                          	-- 3 	9
		SRC_BATCH_DESCRIPTION,                                                	-- 3 	10
		SRC_BATCH_REFERENCE_ID,                                               	-- 3 	11
		SRC_BATCH_TYPE,                                                       	-- 3 	12
		SRC_CREATION_STATION_ID,                                              	-- 3 	13
		SRC_CREATION_USER_ID,                                                 	-- 3 	14
		SRC_CREATION_USER_NAME,                                               	-- 3 	15
		SRC_TRANSFER_ID,                                                      	-- 3 	16
		SRC_SBM_MIN_START_DATE_TIME,
		SRC_SBM_MAX_END_DATE_TIME,
	--	TARGET_MFB_V2_CREATE_DATE,                                            	-- 4 	1
	--	TARGET_MFB_V2_UPDATE_DATE,                                            	-- 4 	2
		TARGET_SOURCE_SERVER,                                                 	-- 4 	3
	--	TARGET_SBM_START_DATE_TIME,                                           	-- 4 	4
		TARGET_EXTERNAL_BATCH_ID,                                             	-- 4 	5
		TARGET_BATCH_GUID,                                                    	-- 4 	6
		TARGET_BATCH_NAME,                                                    	-- 4 	7
		TARGET_BATCH_CLASS,                                                   	-- 4 	8
		TARGET_BATCH_CLASS_DESCRIPTION,                                       	-- 4 	9
		TARGET_BATCH_DESCRIPTION,                                             	-- 4 	10
		TARGET_BATCH_REFERENCE_ID,                                            	-- 4 	11
		TARGET_BATCH_TYPE,                                                    	-- 4 	12
		TARGET_CREATION_STATION_ID,                                           	-- 4 	13
		TARGET_CREATION_USER_ID,                                              	-- 4 	14
		TARGET_CREATION_USER_NAME,                                            	-- 4 	15
		TARGET_TRANSFER_ID,                                                   	-- 4 	16
		TARGET_SBM_MIN_START_DATE_TIME,
		TARGET_SBM_MAX_END_DATE_TIME
	FROM SRC
	LEFT OUTER JOIN TARGET
	ON SRC_EXTERNAL_BATCH_ID = TARGET_EXTERNAL_BATCH_ID
    AND SRC_SOURCE_SERVER = TARGET_SOURCE_SERVER 
--	AND NOT (SRC_SOURCE_SERVER = 'REMOTE'
--	AND TARGET_SOURCE_SERVER = 'CENTRAL' )
	ORDER BY SRC_OLTP_LOAD_DATE_TIME;


	JOIN_REC   JOIN_CSR%ROWTYPE;

-----------------------------------------------------
PROCEDURE LOAD_STATS_BATCH (P_JOB_ID number default 0) 
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

        GV_JOB_NAME	:= GV_PROCESS_NAME||' Parent ID: '||GV_PARENT_JOB_ID||' - '||'Step NYHIX_MFB_V2_STATS_BATCH';			

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
				THEN Update_STATS_BATCH;
			ELSIF JOIN_REC.SRC_ROWID IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NULL 
                --then null;
				THEN INSERT_STATS_BATCH;
			ELSIF JOIN_REC.SRC_ROWID IS NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN DELETE_STATS_BATCH;
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
				'SRC_DB_RECORD_NUM: '||JOIN_REC.SRC_EXTERNAL_BATCH_ID
				||' TARGET_DB_RECORD_NUM: '||JOIN_REC.TARGET_EXTERNAL_BATCH_ID
				||'SQLCODE '||GV_ERROR_CODE
				||' '||GV_ERROR_MESSAGE);

			ROLLBACK;

			RAISE;

END Load_STATS_BATCH;

-----------------------------------------------------

-----------------------------------------------------
PROCEDURE UPDATE_STATS_BATCH IS
-- USES SQL FROM 5 AND 6
-----------------------------------------------------

	BEGIN

	-- COMPARE
		IF 1=2
        --    OR NVL(JOIN_REC.TARGET_MFB_V2_CREATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_CREATE_DATE,SYSDATE - 93333)	-- 5 	1	DATE
        --   OR NVL(JOIN_REC.TARGET_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	-- 5 	2	DATE
            --OR NVL(JOIN_REC.TARGET_SOURCE_SERVER,'-?93333')	  <>  	NVL(JOIN_REC.SRC_SOURCE_SERVER,'-?93333')	-- 5 	3	VARCHAR2
            --OR NVL(JOIN_REC.TARGET_EXTERNAL_BATCH_ID, -93333)	  <>  	NVL(JOIN_REC.SRC_EXTERNAL_BATCH_ID, -93333)	-- 5 	5	NUMBER
            --OR NVL(TO_CHAR(JOIN_REC.TARGET_SBM_START_DATE_TIME,'yyyymmdd hh24:mi:ss'),'X')	  <>  	NVL(TO_CHAR(TO_TIMESTAMP(JOIN_REC.SRC_SBM_START_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),'yyyymmdd hh24:mi:ss'),'X')	-- 5 	4	DATE
            OR NVL(JOIN_REC.TARGET_BATCH_GUID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_GUID,'-?93333')	-- 5 	6	VARCHAR2
            OR NVL(JOIN_REC.TARGET_BATCH_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_NAME,'-?93333')	-- 5 	7	VARCHAR2
            OR NVL(JOIN_REC.TARGET_BATCH_CLASS,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_CLASS,'-?93333')	-- 5 	8	VARCHAR2
            OR NVL(JOIN_REC.TARGET_BATCH_CLASS_DESCRIPTION,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_CLASS_DESCRIPTION,'-?93333')	-- 5 	9	VARCHAR2
            OR NVL(JOIN_REC.TARGET_BATCH_DESCRIPTION,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_DESCRIPTION,'-?93333')	-- 5 	10	VARCHAR2
            OR NVL(JOIN_REC.TARGET_BATCH_REFERENCE_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_REFERENCE_ID,'-?93333')	-- 5 	11	VARCHAR2
            OR NVL(JOIN_REC.TARGET_BATCH_TYPE,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_TYPE,'-?93333')	-- 5 	12	VARCHAR2
            OR NVL(JOIN_REC.TARGET_CREATION_STATION_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_CREATION_STATION_ID,'-?93333')	-- 5 	13	VARCHAR2
            OR NVL(JOIN_REC.TARGET_CREATION_USER_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_CREATION_USER_ID,'-?93333')	-- 5 	14	VARCHAR2
            OR NVL(JOIN_REC.TARGET_CREATION_USER_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_CREATION_USER_NAME,'-?93333')	-- 5 	15	VARCHAR2
            OR NVL(JOIN_REC.TARGET_TRANSFER_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_TRANSFER_ID,'-?93333')	-- 5 	16	VARCHAR2
            OR NVL(TO_CHAR(JOIN_REC.TARGET_SBM_MIN_START_DATE_TIME,'yyyymmdd hh24:mi:ss'),'X')	  <>  	NVL(TO_CHAR(TO_TIMESTAMP(JOIN_REC.SRC_SBM_MIN_START_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),'yyyymmdd hh24:mi:ss'),'X')	-- 5 	4	DATE
            OR NVL(TO_CHAR(JOIN_REC.TARGET_SBM_MAX_END_DATE_TIME,'yyyymmdd hh24:mi:ss'),'X')	  <>  	NVL(TO_CHAR(TO_TIMESTAMP(JOIN_REC.SRC_SBM_MAX_END_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),'yyyymmdd hh24:mi:ss'),'X')	-- 5 	4	DATE
	THEN
		UPDATE MAXDAT.NYHIX_MFB_V2_STATS_BATCH
		SET  
		-- THE UPDATE
        --    MFB_V2_CREATE_DATE                        =  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 6 	1
        --    MFB_V2_UPDATE_DATE                        =  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 6 	2
        --    SOURCE_SERVER                             =  JOIN_REC.SRC_SOURCE_SERVER,	-- 6 	3
        --  EXTERNAL_BATCH_ID                         =  JOIN_REC.SRC_EXTERNAL_BATCH_ID,	-- 6 	5
        --    SBM_START_DATE_TIME                       =  TO_TIMESTAMP(JOIN_REC.SRC_SBM_START_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 6 	4
            BATCH_GUID                                =  JOIN_REC.SRC_BATCH_GUID,	-- 6 	6
            BATCH_NAME                                =  JOIN_REC.SRC_BATCH_NAME,	-- 6 	7
            BATCH_CLASS                               =  JOIN_REC.SRC_BATCH_CLASS,	-- 6 	8
            BATCH_CLASS_DESCRIPTION                   =  JOIN_REC.SRC_BATCH_CLASS_DESCRIPTION,	-- 6 	9
            BATCH_DESCRIPTION                         =  JOIN_REC.SRC_BATCH_DESCRIPTION,	-- 6 	10
            BATCH_REFERENCE_ID                        =  JOIN_REC.SRC_BATCH_REFERENCE_ID,	-- 6 	11
            BATCH_TYPE                                =  JOIN_REC.SRC_BATCH_TYPE,	-- 6 	12
            CREATION_STATION_ID                       =  JOIN_REC.SRC_CREATION_STATION_ID,	-- 6 	13
            CREATION_USER_ID                          =  JOIN_REC.SRC_CREATION_USER_ID,	-- 6 	14
            CREATION_USER_NAME                        =  JOIN_REC.SRC_CREATION_USER_NAME,	-- 6 	15
            TRANSFER_ID                               =  JOIN_REC.SRC_TRANSFER_ID,	-- 6 	16
            SBM_MIN_START_DATE_TIME                   =  TO_TIMESTAMP(JOIN_REC.SRC_SBM_MIN_START_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 6 	4
            SBM_MAX_END_DATE_TIME                     =  TO_TIMESTAMP(JOIN_REC.SRC_SBM_MAX_END_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am')	-- 6 	4
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
            ||JOIN_REC.SRC_rowid||' '
            ||JOIN_REC.target_rowid);

		GV_DRIVER_KEY_NUMBER  	:= 'SRC_OLTP_LOAD_SEQ : '||JOIN_REC.SRC_OLTP_LOAD_SEQ;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_STATS_BATCH_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_STATS_BATCH';

		POST_ERROR;

	END UPDATE_STATS_BATCH;	

-----------------------------------------------------
PROCEDURE INSERT_STATS_BATCH IS
-- USES SQL  FROM 7 AND 8
-----------------------------------------------------

	BEGIN

		INSERT INTO MAXDAT.NYHIX_MFB_V2_STATS_BATCH
		(   
         --   MFB_V2_CREATE_DATE,                     	-- 7 	1
          --  MFB_V2_UPDATE_DATE,                     	-- 7 	2
            SOURCE_SERVER,                          	-- 7 	3
         --   SBM_START_DATE_TIME,                    	-- 7 	4
            EXTERNAL_BATCH_ID,                      	-- 7 	5
            BATCH_GUID,                             	-- 7 	6
            BATCH_NAME,                             	-- 7 	7
            BATCH_CLASS,                            	-- 7 	8
            BATCH_CLASS_DESCRIPTION,                	-- 7 	9
            BATCH_DESCRIPTION,                      	-- 7 	10
            BATCH_REFERENCE_ID,                     	-- 7 	11
            BATCH_TYPE,                             	-- 7 	12
            CREATION_STATION_ID,                    	-- 7 	13
            CREATION_USER_ID,                       	-- 7 	14
            CREATION_USER_NAME,                     	-- 7 	15
            TRANSFER_ID,                            	-- 7 	16
			SBM_MIN_START_DATE_TIME,
			SBM_MAX_END_DATE_TIME
		)
		VALUES (
          --  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	1
          --  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	2
            JOIN_REC.SRC_SOURCE_SERVER,	-- 8 	3
          --  TO_TIMESTAMP(JOIN_REC.SRC_SBM_START_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 8 	4
            JOIN_REC.SRC_EXTERNAL_BATCH_ID,	-- 8 	5
            JOIN_REC.SRC_BATCH_GUID,	-- 8 	6
            JOIN_REC.SRC_BATCH_NAME,	-- 8 	7
            JOIN_REC.SRC_BATCH_CLASS,	-- 8 	8
            JOIN_REC.SRC_BATCH_CLASS_DESCRIPTION,	-- 8 	9
            JOIN_REC.SRC_BATCH_DESCRIPTION,	-- 8 	10
            JOIN_REC.SRC_BATCH_REFERENCE_ID,	-- 8 	11
            JOIN_REC.SRC_BATCH_TYPE,	-- 8 	12
            JOIN_REC.SRC_CREATION_STATION_ID,	-- 8 	13
            JOIN_REC.SRC_CREATION_USER_ID,	-- 8 	14
            JOIN_REC.SRC_CREATION_USER_NAME,	-- 8 	15
            JOIN_REC.SRC_TRANSFER_ID,	-- 8 	16
            TO_TIMESTAMP(JOIN_REC.SRC_SBM_MIN_START_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 8 	4
            TO_TIMESTAMP(JOIN_REC.SRC_SBM_MAX_END_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am')	-- 8 	4
			);

		GV_RECORD_INSERTED_COUNT := GV_RECORD_INSERTED_COUNT + 1;

		GV_PROCESSED_COUNT := GV_PROCESSED_COUNT + 1;

	EXCEPTION

        WHEN OTHERS THEN
--        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE '
--            ||JOIN_REC.SRC_DB_RECORD_NUM||' '
--            ||JOIN_REC.SRC_rowid||' '
--            ||JOIN_REC.target_rowid);

        -- '${MFB_V2_REMOTE_START_DATE}'
		GV_DRIVER_KEY_NUMBER  	:= 'SRC_OLTP_LOAD_SEQ : '||JOIN_REC.SRC_OLTP_LOAD_SEQ;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_STATS_BATCH_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_STATS_BATCH';

		POST_ERROR;

	END INSERT_STATS_BATCH;	

-----------------------------------------------------
PROCEDURE DELETE_STATS_BATCH IS
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

	END DELETE_STATS_BATCH;	


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


			INSERT INTO MAXDAT.NYHIX_MFB_V2_STATS_BATCH_OLTP_ERR
		(   
         --   MFB_V2_CREATE_DATE,                     	-- 7 	1
          --  MFB_V2_UPDATE_DATE,                     	-- 7 	2
			OLTP_LOAD_SEQ,
			OLTP_LOAD_DATE_TIME, 
            SOURCE_SERVER,                          	-- 7 	3
        --    SBM_START_DATE_TIME,                    	-- 7 	4
            EXTERNAL_BATCH_ID,                      	-- 7 	5
            BATCH_GUID,                             	-- 7 	6
            BATCH_NAME,                             	-- 7 	7
            BATCH_CLASS,                            	-- 7 	8
            BATCH_CLASS_DESCRIPTION,                	-- 7 	9
            BATCH_DESCRIPTION,                      	-- 7 	10
            BATCH_REFERENCE_ID,                     	-- 7 	11
            BATCH_TYPE,                             	-- 7 	12
            CREATION_STATION_ID,                    	-- 7 	13
            CREATION_USER_ID,                       	-- 7 	14
            CREATION_USER_NAME,                     	-- 7 	15
            TRANSFER_ID,                           		-- 7 	16
			SBM_MIN_START_DATE_TIME,
			SBM_MAX_END_DATE_TIME
		)
		VALUES (
          --  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	1
          --  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	2
			JOIN_REC.SRC_OLTP_LOAD_SEQ,
			JOIN_REC.SRC_OLTP_LOAD_DATE_TIME, 
            JOIN_REC.SRC_SOURCE_SERVER,	-- 8 	3
         --   JOIN_REC.SRC_SBM_START_DATE_TIME,	-- 8 	4
            JOIN_REC.SRC_EXTERNAL_BATCH_ID,	-- 8 	5
            JOIN_REC.SRC_BATCH_GUID,	-- 8 	6
            JOIN_REC.SRC_BATCH_NAME,	-- 8 	7
            JOIN_REC.SRC_BATCH_CLASS,	-- 8 	8
            JOIN_REC.SRC_BATCH_CLASS_DESCRIPTION,	-- 8 	9
            JOIN_REC.SRC_BATCH_DESCRIPTION,	-- 8 	10
            JOIN_REC.SRC_BATCH_REFERENCE_ID,	-- 8 	11
            JOIN_REC.SRC_BATCH_TYPE,	-- 8 	12
            JOIN_REC.SRC_CREATION_STATION_ID,	-- 8 	13
            JOIN_REC.SRC_CREATION_USER_ID,	-- 8 	14
            JOIN_REC.SRC_CREATION_USER_NAME,	-- 8 	15
            JOIN_REC.SRC_TRANSFER_ID,	-- 8 	16
			JOIN_REC.SRC_SBM_MIN_START_DATE_TIME,
			JOIN_REC.SRC_SBM_MAX_END_DATE_TIME
			);



EXCEPTION

	When Others then 
		GV_ERROR_CODE := SQLCODE;
		GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 3000);                 
	DBMS_OUTPUT.PUT_LINE('Procedure Post_Error failed with '||GV_Error_Code||': '||GV_Error_Message);

	--RAISE;


END;

END NYHIX_MFB_V2_STATS_BATCH_PKG;
/
SHOW ERRORS	  
	  