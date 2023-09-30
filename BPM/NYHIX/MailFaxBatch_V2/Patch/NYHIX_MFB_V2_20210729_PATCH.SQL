DROP INDEX MAXDAT.NYHIX_MFB_V2_STATS_BATCH_PK;

  CREATE UNIQUE INDEX MAXDAT.NYHIX_MFB_V2_STATS_BATCH_PK 
  ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH (SOURCE_SERVER,EXTERNAL_BATCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_INDX;

----------------------------------------------------------------------

DROP INDEX MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_PK; 

 CREATE UNIQUE INDEX MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_PK 
 ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE (SOURCE_SERVER,BATCH_MODULE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_INDX;

----------------------------------------------------------------------

DROP INDEX MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PK; 

  CREATE UNIQUE INDEX MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PK 
  ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH (SOURCE_SERVER,MODULE_LAUNCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_INDX;


----------------------------------------------------------------------

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
		SRC.SBM_START_DATE_TIME                  AS SRC_SBM_START_DATE_TIME,  	-- 1 	4
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
		SRC.TRANSFER_ID                          AS SRC_TRANSFER_ID          	-- 1 	16
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
		TARGET.SBM_START_DATE_TIME               AS TARGET_SBM_START_DATE_TIME,	-- 2 	4
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
		TARGET.TRANSFER_ID                       AS TARGET_TRANSFER_ID       	-- 2 	16
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
		SRC_SBM_START_DATE_TIME,                                              	-- 3 	4
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
	--	TARGET_MFB_V2_CREATE_DATE,                                            	-- 4 	1
	--	TARGET_MFB_V2_UPDATE_DATE,                                            	-- 4 	2
		TARGET_SOURCE_SERVER,                                                 	-- 4 	3
		TARGET_SBM_START_DATE_TIME,                                           	-- 4 	4
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
		TARGET_TRANSFER_ID                                                   	-- 4 	16
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
            OR NVL(JOIN_REC.TARGET_SBM_START_DATE_TIME,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_SBM_START_DATE_TIME,SYSDATE - 93333)	-- 5 	4	DATE
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
	THEN
		UPDATE MAXDAT.NYHIX_MFB_V2_STATS_BATCH
		SET  
		-- THE UPDATE
        --    MFB_V2_CREATE_DATE                        =  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 6 	1
        --    MFB_V2_UPDATE_DATE                        =  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 6 	2
        --    SOURCE_SERVER                             =  JOIN_REC.SRC_SOURCE_SERVER,	-- 6 	3
        --  EXTERNAL_BATCH_ID                         =  JOIN_REC.SRC_EXTERNAL_BATCH_ID,	-- 6 	5
            SBM_START_DATE_TIME                       =  JOIN_REC.SRC_SBM_START_DATE_TIME,	-- 6 	4
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
            TRANSFER_ID                               =  JOIN_REC.SRC_TRANSFER_ID	-- 6 	16
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
            SBM_START_DATE_TIME,                    	-- 7 	4
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
            TRANSFER_ID                            	-- 7 	16
		)
		VALUES (
          --  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	1
          --  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	2
            JOIN_REC.SRC_SOURCE_SERVER,	-- 8 	3
            JOIN_REC.SRC_SBM_START_DATE_TIME,	-- 8 	4
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
            JOIN_REC.SRC_TRANSFER_ID	-- 8 	16
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
            SBM_START_DATE_TIME,                    	-- 7 	4
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
            TRANSFER_ID                            	-- 7 	16
		)
		VALUES (
          --  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	1
          --  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	2
			JOIN_REC.SRC_OLTP_LOAD_SEQ,
			JOIN_REC.SRC_OLTP_LOAD_DATE_TIME, 
            JOIN_REC.SRC_SOURCE_SERVER,	-- 8 	3
            JOIN_REC.SRC_SBM_START_DATE_TIME,	-- 8 	4
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
            JOIN_REC.SRC_TRANSFER_ID	-- 8 	16
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
show errors

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

create or replace PACKAGE BODY        NYHIX_MFB_V2_STATS_BATCH_MODULE_PKG AS

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
	GV_DRIVER_TABLE_NAME  		VARCHAR2(100 BYTE)	:= 'NYHIX_MFB_V2_STATS_BATCH_MODULE';
	GV_DRIVER_KEY_NUMBER  		VARCHAR2(100 BYTE)	:= NULL;
	GV_NR_OF_ERROR        		NUMBER				:= 0;
    GV_UPDATE_TS                DATE                := SYSDATE;

	-- USED FOR THE CORP_ETL_JOB_STATISTICS
	GV_JOB_ID                 	NUMBER              := 0;
	GV_JOB_STATUS_CD          	VARCHAR2(20 BYTE)   := 'STARTED';
	GV_FILE_NAME              	VARCHAR2(512 BYTE)	:= 'NYHIX_MFB_V2_STATS_BATCH_MODULE';
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
		ROWID    							 	 AS SRC_ROWID,
		-- Insert SQL from Query 1 section 1 Here
		SRC.OLTP_LOAD_SEQ						 AS SRC_OLTP_LOAD_SEQ,
		SRC.OLTP_LOAD_DATE_TIME					 AS SRC_OLTP_LOAD_DATE_TIME, 
	    SRC.SOURCE_SERVER                        AS SRC_SOURCE_SERVER,	-- 1 	1
--      SRC.MFB_V2_CREATE_DATE                   AS SRC_MFB_V2_CREATE_DATE,	-- 1 	2
--      SRC.MFB_V2_UPDATE_DATE                   AS SRC_MFB_V2_UPDATE_DATE,	-- 1 	3
        SRC.BATCH_GUID                           AS SRC_BATCH_GUID,	-- 1 	4
        SRC.BATCH_MODULE_ID                      AS SRC_BATCH_MODULE_ID,	-- 1 	5
        SRC.EXTERNAL_BATCH_ID                    AS SRC_EXTERNAL_BATCH_ID,	-- 1 	6
        SRC.BATCH_DESCRIPTION                    AS SRC_BATCH_DESCRIPTION,	-- 1 	7
        SRC.MODULE_LAUNCH_ID                     AS SRC_MODULE_LAUNCH_ID,	-- 1 	8
        SRC.MODULE_CLOSE_UNIQUE_ID               AS SRC_MODULE_CLOSE_UNIQUE_ID,	-- 1 	9
        SRC.MODULE_NAME                          AS SRC_MODULE_NAME,	-- 1 	10
        SRC.MODULE_CLOSE_NAME                    AS SRC_MODULE_CLOSE_NAME,	-- 1 	11
        SRC.START_DATE_TIME                      AS SRC_START_DATE_TIME,	-- 1 	12
        SRC.END_DATE_TIME                        AS SRC_END_DATE_TIME,	-- 1 	13
        SRC.BATCH_STATUS                         AS SRC_BATCH_STATUS,	-- 1 	14
        SRC.PRIORITY                             AS SRC_PRIORITY,	-- 1 	15
        SRC.EXPECTED_PAGES                       AS SRC_EXPECTED_PAGES,	-- 1 	16
        SRC.EXPECTED_DOCS                        AS SRC_EXPECTED_DOCS,	-- 1 	17
        SRC.DELETED                              AS SRC_DELETED,	-- 1 	18
        SRC.PAGES_PER_DOCUMENT                   AS SRC_PAGES_PER_DOCUMENT,	-- 1 	19
        SRC.PAGES_SCANNED                        AS SRC_PAGES_SCANNED,	-- 1 	20
        SRC.PAGES_DELETED                        AS SRC_PAGES_DELETED,	-- 1 	21
        SRC.DOCUMENTS_CREATED                    AS SRC_DOCUMENTS_CREATED,	-- 1 	22
        SRC.DOCUMENTS_DELETED                    AS SRC_DOCUMENTS_DELETED,	-- 1 	23
        SRC.CHANGED_FORM_TYPES                   AS SRC_CHANGED_FORM_TYPES,	-- 1 	24
        SRC.PAGES_REPLACED                       AS SRC_PAGES_REPLACED,	-- 1 	25
        SRC.ERROR_CODE                           AS SRC_ERROR_CODE,	-- 1 	26
        SRC.ERROR_TEXT                           AS SRC_ERROR_TEXT,	-- 1 	27
        SRC.ORPHANED                             AS SRC_ORPHANED,	-- 1 	28
        SRC.TRANSFER_ID                          AS SRC_TRANSFER_ID		-- 1 	29
	FROM MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_OLTP SRC
	),
	TARGET AS
	(
	SELECT 
		ROWID    						  AS TARGET_ROWID,
		-- Insert SQL from Query 1 section 2 Here
               TARGET.SOURCE_SERVER                     AS TARGET_SOURCE_SERVER,	-- 2 	1
       --   TARGET.MFB_V2_CREATE_DATE                AS TARGET_MFB_V2_CREATE_DATE,	-- 2 	2
       --   TARGET.MFB_V2_UPDATE_DATE                AS TARGET_MFB_V2_UPDATE_DATE,	-- 2 	3
                  TARGET.BATCH_GUID                        AS TARGET_BATCH_GUID,	-- 2 	4
             TARGET.BATCH_MODULE_ID                   AS TARGET_BATCH_MODULE_ID,	-- 2 	5
           TARGET.EXTERNAL_BATCH_ID                 AS TARGET_EXTERNAL_BATCH_ID,	-- 2 	6
           TARGET.BATCH_DESCRIPTION                 AS TARGET_BATCH_DESCRIPTION,	-- 2 	7
            TARGET.MODULE_LAUNCH_ID                  AS TARGET_MODULE_LAUNCH_ID,	-- 2 	8
      TARGET.MODULE_CLOSE_UNIQUE_ID            AS TARGET_MODULE_CLOSE_UNIQUE_ID,	-- 2 	9
                 TARGET.MODULE_NAME                       AS TARGET_MODULE_NAME,	-- 2 	10
           TARGET.MODULE_CLOSE_NAME                 AS TARGET_MODULE_CLOSE_NAME,	-- 2 	11
             TARGET.START_DATE_TIME                   AS TARGET_START_DATE_TIME,	-- 2 	12
               TARGET.END_DATE_TIME                     AS TARGET_END_DATE_TIME,	-- 2 	13
                TARGET.BATCH_STATUS                      AS TARGET_BATCH_STATUS,	-- 2 	14
                    TARGET.PRIORITY                          AS TARGET_PRIORITY,	-- 2 	15
              TARGET.EXPECTED_PAGES                    AS TARGET_EXPECTED_PAGES,	-- 2 	16
               TARGET.EXPECTED_DOCS                     AS TARGET_EXPECTED_DOCS,	-- 2 	17
                     TARGET.DELETED                           AS TARGET_DELETED,	-- 2 	18
          TARGET.PAGES_PER_DOCUMENT                AS TARGET_PAGES_PER_DOCUMENT,	-- 2 	19
               TARGET.PAGES_SCANNED                     AS TARGET_PAGES_SCANNED,	-- 2 	20
               TARGET.PAGES_DELETED                     AS TARGET_PAGES_DELETED,	-- 2 	21
           TARGET.DOCUMENTS_CREATED                 AS TARGET_DOCUMENTS_CREATED,	-- 2 	22
           TARGET.DOCUMENTS_DELETED                 AS TARGET_DOCUMENTS_DELETED,	-- 2 	23
          TARGET.CHANGED_FORM_TYPES                AS TARGET_CHANGED_FORM_TYPES,	-- 2 	24
              TARGET.PAGES_REPLACED                    AS TARGET_PAGES_REPLACED,	-- 2 	25
                  TARGET.ERROR_CODE                        AS TARGET_ERROR_CODE,	-- 2 	26
                  TARGET.ERROR_TEXT                        AS TARGET_ERROR_TEXT,	-- 2 	27
                    TARGET.ORPHANED                          AS TARGET_ORPHANED,	-- 2 	28
                 TARGET.TRANSFER_ID                       AS TARGET_TRANSFER_ID		-- 2 	29
	FROM MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE TARGET
	)
	SELECT 
		SRC_ROWID,
		TARGET_ROWID,
		-- insert SQL from 3 and 4 here
		SRC_OLTP_LOAD_SEQ,
		SRC_OLTP_LOAD_DATE_TIME, 
                      SRC_SOURCE_SERVER,                      	-- 3 	1
                         --     SRC_MFB_V2_CREATE_DATE,                 	-- 3 	2
                         --     SRC_MFB_V2_UPDATE_DATE,                 	-- 3 	3
                              SRC_BATCH_GUID,                         	-- 3 	4
                              SRC_BATCH_MODULE_ID,                    	-- 3 	5
                              SRC_EXTERNAL_BATCH_ID,                  	-- 3 	6
                              SRC_BATCH_DESCRIPTION,                  	-- 3 	7
                              SRC_MODULE_LAUNCH_ID,                   	-- 3 	8
                              SRC_MODULE_CLOSE_UNIQUE_ID,             	-- 3 	9
                              SRC_MODULE_NAME,                        	-- 3 	10
                              SRC_MODULE_CLOSE_NAME,                  	-- 3 	11
                              SRC_START_DATE_TIME,                    	-- 3 	12
                              SRC_END_DATE_TIME,                      	-- 3 	13
                              SRC_BATCH_STATUS,                       	-- 3 	14
                              SRC_PRIORITY,                           	-- 3 	15
                              SRC_EXPECTED_PAGES,                     	-- 3 	16
                              SRC_EXPECTED_DOCS,                      	-- 3 	17
                              SRC_DELETED,                            	-- 3 	18
                              SRC_PAGES_PER_DOCUMENT,                 	-- 3 	19
                              SRC_PAGES_SCANNED,                      	-- 3 	20
                              SRC_PAGES_DELETED,                      	-- 3 	21
                              SRC_DOCUMENTS_CREATED,                  	-- 3 	22
                              SRC_DOCUMENTS_DELETED,                  	-- 3 	23
                              SRC_CHANGED_FORM_TYPES,                 	-- 3 	24
                              SRC_PAGES_REPLACED,                     	-- 3 	25
                              SRC_ERROR_CODE,                         	-- 3 	26
                              SRC_ERROR_TEXT,                         	-- 3 	27
                              SRC_ORPHANED,                           	-- 3 	28
                              SRC_TRANSFER_ID,                        	-- 3 	29
                              TARGET_SOURCE_SERVER,                   	-- 4 	1
                       --       TARGET_MFB_V2_CREATE_DATE,              	-- 4 	2
                       --       TARGET_MFB_V2_UPDATE_DATE,              	-- 4 	3
                              TARGET_BATCH_GUID,                      	-- 4 	4
                              TARGET_BATCH_MODULE_ID,                 	-- 4 	5
                              TARGET_EXTERNAL_BATCH_ID,               	-- 4 	6
                              TARGET_BATCH_DESCRIPTION,               	-- 4 	7
                              TARGET_MODULE_LAUNCH_ID,                	-- 4 	8
                              TARGET_MODULE_CLOSE_UNIQUE_ID,          	-- 4 	9
                              TARGET_MODULE_NAME,                     	-- 4 	10
                              TARGET_MODULE_CLOSE_NAME,               	-- 4 	11
                              TARGET_START_DATE_TIME,                 	-- 4 	12
                              TARGET_END_DATE_TIME,                   	-- 4 	13
                              TARGET_BATCH_STATUS,                    	-- 4 	14
                              TARGET_PRIORITY,                        	-- 4 	15
                              TARGET_EXPECTED_PAGES,                  	-- 4 	16
                              TARGET_EXPECTED_DOCS,                   	-- 4 	17
                              TARGET_DELETED,                         	-- 4 	18
                              TARGET_PAGES_PER_DOCUMENT,              	-- 4 	19
                              TARGET_PAGES_SCANNED,                   	-- 4 	20
                              TARGET_PAGES_DELETED,                   	-- 4 	21
                              TARGET_DOCUMENTS_CREATED,               	-- 4 	22
                              TARGET_DOCUMENTS_DELETED,               	-- 4 	23
                              TARGET_CHANGED_FORM_TYPES,              	-- 4 	24
                              TARGET_PAGES_REPLACED,                  	-- 4 	25
                              TARGET_ERROR_CODE,                      	-- 4 	26
                              TARGET_ERROR_TEXT,                      	-- 4 	27
                              TARGET_ORPHANED,                        	-- 4 	28
                              TARGET_TRANSFER_ID                     	-- 4 	29
	FROM SRC
	LEFT OUTER JOIN TARGET
	ON SRC_SOURCE_SERVER = TARGET_SOURCE_SERVER
	AND SRC_Batch_Module_ID = TARGET_Batch_Module_ID
--	AND NOT (SRC_SOURCE_SERVER = 'REMOTE'
--	AND TARGET_SOURCE_SERVER = 'CENTRAL' )
	ORDER BY SRC_OLTP_LOAD_DATE_TIME, SRC_START_DATE_TIME;


	JOIN_REC   JOIN_CSR%ROWTYPE;

-----------------------------------------------------
PROCEDURE LOAD_STATS_BATCH_MODULE (P_JOB_ID number default 0) 
IS
-----------------------------------------------------

	BEGIN

		-- INITIAL SET Setup

		-- INITIAL SET Setup
        GV_RECORD_COUNT           	:= 0;
        GV_ERROR_COUNT            	:= 0;
        GV_WARNING_COUNT          	:= 0;
        GV_PROCESSED_COUNT        	:= 0;
        GV_RECORD_INSERTED_COUNT  	:= 0;
        GV_RECORD_UPDATED_COUNT   	:= 0;

		GV_PARENT_JOB_ID := P_JOB_ID;

		GV_JOB_ID 	:= SEQ_JOB_ID.NEXTVAL;

        GV_JOB_NAME	:= GV_PROCESS_NAME||' Parent ID: '||GV_PARENT_JOB_ID||' - '||'Step NYHIX_MFB_V2_STATS_BATCH_MODULE';			

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
				THEN Update_STATS_BATCH_MODULE;
			ELSIF JOIN_REC.SRC_ROWID IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NULL 
                --then null;
				THEN INSERT_STATS_BATCH_MODULE;
			ELSIF JOIN_REC.SRC_ROWID IS NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN DELETE_STATS_BATCH_MODULE;
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

END Load_STATS_BATCH_MODULE;

-----------------------------------------------------

-----------------------------------------------------
PROCEDURE UPDATE_STATS_BATCH_MODULE IS
-- USES SQL FROM 5 AND 6
-----------------------------------------------------

	BEGIN

	-- COMPARE
		IF 1=2
         --   OR NVL(JOIN_REC.TARGET_SOURCE_SERVER,'-?93333')	  <>  	NVL(JOIN_REC.SRC_SOURCE_SERVER,'-?93333')	-- 5 	1	VARCHAR2
         --   OR NVL(JOIN_REC.TARGET_MFB_V2_CREATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.MFB_V2_CREATE_DATE,SYSDATE - 93333)	-- 5 	2	DATE
         --   OR NVL(JOIN_REC.TARGET_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.MFB_V2_UPDATE_DATE,SYSDATE - 93333)	-- 5 	3	DATE
         --   OR NVL(JOIN_REC.TARGET_BATCH_GUID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_GUID,'-?93333')	-- 5 	4	VARCHAR2
         --   OR NVL(JOIN_REC.TARGET_BATCH_MODULE_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_MODULE_ID,'-?93333')	-- 5 	5	VARCHAR2
            OR NVL(JOIN_REC.TARGET_EXTERNAL_BATCH_ID, -93333)	  <>  	NVL(JOIN_REC.SRC_EXTERNAL_BATCH_ID, -93333)	-- 5 	6	NUMBER
            OR NVL(JOIN_REC.TARGET_BATCH_DESCRIPTION,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_DESCRIPTION,'-?93333')	-- 5 	7	VARCHAR2
            OR NVL(JOIN_REC.TARGET_MODULE_LAUNCH_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_LAUNCH_ID,'-?93333')	-- 5 	8	VARCHAR2
            OR NVL(JOIN_REC.TARGET_MODULE_CLOSE_UNIQUE_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_CLOSE_UNIQUE_ID,'-?93333')	-- 5 	9	VARCHAR2
            OR NVL(JOIN_REC.TARGET_MODULE_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_NAME,'-?93333')	-- 5 	10	VARCHAR2
            OR NVL(JOIN_REC.TARGET_MODULE_CLOSE_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_CLOSE_NAME,'-?93333')	-- 5 	11	VARCHAR2
            OR NVL(JOIN_REC.TARGET_START_DATE_TIME,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_START_DATE_TIME,SYSDATE - 93333)	-- 5 	12	DATE
            OR NVL(JOIN_REC.TARGET_END_DATE_TIME,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_END_DATE_TIME,SYSDATE - 93333)	-- 5 	13	DATE
            OR NVL(JOIN_REC.TARGET_BATCH_STATUS, -93333)	  <>  	NVL(JOIN_REC.SRC_BATCH_STATUS, -93333)	-- 5 	14	NUMBER
            OR NVL(JOIN_REC.TARGET_PRIORITY, -93333)	  <>  	NVL(JOIN_REC.SRC_PRIORITY, -93333)	-- 5 	15	NUMBER
            OR NVL(JOIN_REC.TARGET_EXPECTED_PAGES, -93333)	  <>  	NVL(JOIN_REC.SRC_EXPECTED_PAGES, -93333)	-- 5 	16	NUMBER
            OR NVL(JOIN_REC.TARGET_EXPECTED_DOCS, -93333)	  <>  	NVL(JOIN_REC.SRC_EXPECTED_DOCS, -93333)	-- 5 	17	NUMBER
            OR NVL(JOIN_REC.TARGET_DELETED, -93333)	  <>  	NVL(JOIN_REC.SRC_DELETED, -93333)	-- 5 	18	NUMBER
            OR NVL(JOIN_REC.TARGET_PAGES_PER_DOCUMENT, -93333)	  <>  	NVL(JOIN_REC.SRC_PAGES_PER_DOCUMENT, -93333)	-- 5 	19	NUMBER
            OR NVL(JOIN_REC.TARGET_PAGES_SCANNED, -93333)	  <>  	NVL(JOIN_REC.SRC_PAGES_SCANNED, -93333)	-- 5 	20	NUMBER
            OR NVL(JOIN_REC.TARGET_PAGES_DELETED, -93333)	  <>  	NVL(JOIN_REC.SRC_PAGES_DELETED, -93333)	-- 5 	21	NUMBER
            OR NVL(JOIN_REC.TARGET_DOCUMENTS_CREATED, -93333)	  <>  	NVL(JOIN_REC.SRC_DOCUMENTS_CREATED, -93333)	-- 5 	22	NUMBER
            OR NVL(JOIN_REC.TARGET_DOCUMENTS_DELETED, -93333)	  <>  	NVL(JOIN_REC.SRC_DOCUMENTS_DELETED, -93333)	-- 5 	23	NUMBER
            OR NVL(JOIN_REC.TARGET_CHANGED_FORM_TYPES, -93333)	  <>  	NVL(JOIN_REC.SRC_CHANGED_FORM_TYPES, -93333)	-- 5 	24	NUMBER
            OR NVL(JOIN_REC.TARGET_PAGES_REPLACED, -93333)	  <>  	NVL(JOIN_REC.SRC_PAGES_REPLACED, -93333)	-- 5 	25	NUMBER
            OR NVL(JOIN_REC.TARGET_ERROR_CODE, -93333)	  <>  	NVL(JOIN_REC.SRC_ERROR_CODE, -93333)	-- 5 	26	NUMBER
            OR NVL(JOIN_REC.TARGET_ERROR_TEXT,'-?93333')	  <>  	NVL(JOIN_REC.SRC_ERROR_TEXT,'-?93333')	-- 5 	27	VARCHAR2
            OR NVL(JOIN_REC.TARGET_ORPHANED, -93333)	  <>  	NVL(JOIN_REC.SRC_ORPHANED, -93333)	-- 5 	28	NUMBER
            OR NVL(JOIN_REC.TARGET_TRANSFER_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_TRANSFER_ID,'-?93333')	-- 5 	29	VARCHAR2
	THEN
		UPDATE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE
		SET  
		-- THE UPDATE
         --   SOURCE_SERVER                             =  JOIN_REC.SRC_SOURCE_SERVER,	-- 6 	1
       --     MFB_V2_CREATE_DATE                        =  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 6 	2
       --     MFB_V2_UPDATE_DATE                        =  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 6 	3
            BATCH_GUID                                =  JOIN_REC.SRC_BATCH_GUID,	-- 6 	4
            BATCH_MODULE_ID                           =  JOIN_REC.SRC_BATCH_MODULE_ID,	-- 6 	5
            EXTERNAL_BATCH_ID                         =  JOIN_REC.SRC_EXTERNAL_BATCH_ID,	-- 6 	6
            BATCH_DESCRIPTION                         =  JOIN_REC.SRC_BATCH_DESCRIPTION,	-- 6 	7
            MODULE_LAUNCH_ID                          =  JOIN_REC.SRC_MODULE_LAUNCH_ID,	-- 6 	8
            MODULE_CLOSE_UNIQUE_ID                    =  JOIN_REC.SRC_MODULE_CLOSE_UNIQUE_ID,	-- 6 	9
            MODULE_NAME                               =  JOIN_REC.SRC_MODULE_NAME,	-- 6 	10
            MODULE_CLOSE_NAME                         =  JOIN_REC.SRC_MODULE_CLOSE_NAME,	-- 6 	11
            START_DATE_TIME                           =  JOIN_REC.SRC_START_DATE_TIME,	-- 6 	12
            END_DATE_TIME                             =  JOIN_REC.SRC_END_DATE_TIME,	-- 6 	13
            BATCH_STATUS                              =  JOIN_REC.SRC_BATCH_STATUS,	-- 6 	14
            PRIORITY                                  =  JOIN_REC.SRC_PRIORITY,	-- 6 	15
            EXPECTED_PAGES                            =  JOIN_REC.SRC_EXPECTED_PAGES,	-- 6 	16
            EXPECTED_DOCS                             =  JOIN_REC.SRC_EXPECTED_DOCS,	-- 6 	17
            DELETED                                   =  JOIN_REC.SRC_DELETED,	-- 6 	18
            PAGES_PER_DOCUMENT                        =  JOIN_REC.SRC_PAGES_PER_DOCUMENT,	-- 6 	19
            PAGES_SCANNED                             =  JOIN_REC.SRC_PAGES_SCANNED,	-- 6 	20
            PAGES_DELETED                             =  JOIN_REC.SRC_PAGES_DELETED,	-- 6 	21
            DOCUMENTS_CREATED                         =  JOIN_REC.SRC_DOCUMENTS_CREATED,	-- 6 	22
            DOCUMENTS_DELETED                         =  JOIN_REC.SRC_DOCUMENTS_DELETED,	-- 6 	23
            CHANGED_FORM_TYPES                        =  JOIN_REC.SRC_CHANGED_FORM_TYPES,	-- 6 	24
            PAGES_REPLACED                            =  JOIN_REC.SRC_PAGES_REPLACED,	-- 6 	25
            ERROR_CODE                                =  JOIN_REC.SRC_ERROR_CODE,	-- 6 	26
            ERROR_TEXT                                =  JOIN_REC.SRC_ERROR_TEXT,	-- 6 	27
            ORPHANED                                  =  JOIN_REC.SRC_ORPHANED,	-- 6 	28
            TRANSFER_ID                               =  JOIN_REC.SRC_TRANSFER_ID	-- 6 	29
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
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_STATS_BATCH_MODULE_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_STATS_BATCH_MODULE';

		POST_ERROR;

	END UPDATE_STATS_BATCH_MODULE;	

-----------------------------------------------------
PROCEDURE INSERT_STATS_BATCH_MODULE IS
-- USES SQL  FROM 7 AND 8
-----------------------------------------------------

	BEGIN

		INSERT INTO MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE
		(   
            SOURCE_SERVER,                          	-- 7 	1
         --   MFB_V2_CREATE_DATE,                     	-- 7 	2
         --   MFB_V2_UPDATE_DATE,                     	-- 7 	3
            BATCH_GUID,                             	-- 7 	4
            BATCH_MODULE_ID,                        	-- 7 	5
            EXTERNAL_BATCH_ID,                      	-- 7 	6
            BATCH_DESCRIPTION,                      	-- 7 	7
            MODULE_LAUNCH_ID,                       	-- 7 	8
            MODULE_CLOSE_UNIQUE_ID,                 	-- 7 	9
            MODULE_NAME,                            	-- 7 	10
            MODULE_CLOSE_NAME,                      	-- 7 	11
            START_DATE_TIME,                        	-- 7 	12
            END_DATE_TIME,                          	-- 7 	13
            BATCH_STATUS,                           	-- 7 	14
            PRIORITY,                               	-- 7 	15
            EXPECTED_PAGES,                         	-- 7 	16
            EXPECTED_DOCS,                          	-- 7 	17
            DELETED,                                	-- 7 	18
            PAGES_PER_DOCUMENT,                     	-- 7 	19
            PAGES_SCANNED,                          	-- 7 	20
            PAGES_DELETED,                          	-- 7 	21
            DOCUMENTS_CREATED,                      	-- 7 	22
            DOCUMENTS_DELETED,                      	-- 7 	23
            CHANGED_FORM_TYPES,                     	-- 7 	24
            PAGES_REPLACED,                         	-- 7 	25
            ERROR_CODE,                             	-- 7 	26
            ERROR_TEXT,                             	-- 7 	27
            ORPHANED,                               	-- 7 	28
            TRANSFER_ID                            	-- 7 	29
		)
		VALUES (
             JOIN_REC.SRC_SOURCE_SERVER,	-- 8 	1
        --    JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	2
        --    JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	3
            JOIN_REC.SRC_BATCH_GUID,	-- 8 	4
            JOIN_REC.SRC_BATCH_MODULE_ID,	-- 8 	5
            JOIN_REC.SRC_EXTERNAL_BATCH_ID,	-- 8 	6
            JOIN_REC.SRC_BATCH_DESCRIPTION,	-- 8 	7
            JOIN_REC.SRC_MODULE_LAUNCH_ID,	-- 8 	8
            JOIN_REC.SRC_MODULE_CLOSE_UNIQUE_ID,	-- 8 	9
            JOIN_REC.SRC_MODULE_NAME,	-- 8 	10
            JOIN_REC.SRC_MODULE_CLOSE_NAME,	-- 8 	11
            JOIN_REC.SRC_START_DATE_TIME,	-- 8 	12
            JOIN_REC.SRC_END_DATE_TIME,	-- 8 	13
            JOIN_REC.SRC_BATCH_STATUS,	-- 8 	14
            JOIN_REC.SRC_PRIORITY,	-- 8 	15
            JOIN_REC.SRC_EXPECTED_PAGES,	-- 8 	16
            JOIN_REC.SRC_EXPECTED_DOCS,	-- 8 	17
            JOIN_REC.SRC_DELETED,	-- 8 	18
            JOIN_REC.SRC_PAGES_PER_DOCUMENT,	-- 8 	19
            JOIN_REC.SRC_PAGES_SCANNED,	-- 8 	20
            JOIN_REC.SRC_PAGES_DELETED,	-- 8 	21
            JOIN_REC.SRC_DOCUMENTS_CREATED,	-- 8 	22
            JOIN_REC.SRC_DOCUMENTS_DELETED,	-- 8 	23
            JOIN_REC.SRC_CHANGED_FORM_TYPES,	-- 8 	24
            JOIN_REC.SRC_PAGES_REPLACED,	-- 8 	25
            JOIN_REC.SRC_ERROR_CODE,	-- 8 	26
            JOIN_REC.SRC_ERROR_TEXT,	-- 8 	27
            JOIN_REC.SRC_ORPHANED,	-- 8 	28
            JOIN_REC.SRC_TRANSFER_ID	-- 8 	29
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
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_STATS_BATCH_MODULE_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_STATS_BATCH_MODULE';

		POST_ERROR;

	END INSERT_STATS_BATCH_MODULE;	

-----------------------------------------------------
PROCEDURE DELETE_STATS_BATCH_MODULE IS
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

	END DELETE_STATS_BATCH_MODULE;	


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

	GV_JOB_NAME		:= 'Mail Fax Batch V2';	

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

		INSERT INTO MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_OLTP_ERR
		(   
			OLTP_LOAD_SEQ,
			OLTP_LOAD_DATE_TIME, 
            SOURCE_SERVER,                          	-- 7 	1
         --   MFB_V2_CREATE_DATE,                     	-- 7 	2
         --   MFB_V2_UPDATE_DATE,                     	-- 7 	3
            BATCH_GUID,                             	-- 7 	4
            BATCH_MODULE_ID,                        	-- 7 	5
            EXTERNAL_BATCH_ID,                      	-- 7 	6
            BATCH_DESCRIPTION,                      	-- 7 	7
            MODULE_LAUNCH_ID,                       	-- 7 	8
            MODULE_CLOSE_UNIQUE_ID,                 	-- 7 	9
            MODULE_NAME,                            	-- 7 	10
            MODULE_CLOSE_NAME,                      	-- 7 	11
            START_DATE_TIME,                        	-- 7 	12
            END_DATE_TIME,                          	-- 7 	13
            BATCH_STATUS,                           	-- 7 	14
            PRIORITY,                               	-- 7 	15
            EXPECTED_PAGES,                         	-- 7 	16
            EXPECTED_DOCS,                          	-- 7 	17
            DELETED,                                	-- 7 	18
            PAGES_PER_DOCUMENT,                     	-- 7 	19
            PAGES_SCANNED,                          	-- 7 	20
            PAGES_DELETED,                          	-- 7 	21
            DOCUMENTS_CREATED,                      	-- 7 	22
            DOCUMENTS_DELETED,                      	-- 7 	23
            CHANGED_FORM_TYPES,                     	-- 7 	24
            PAGES_REPLACED,                         	-- 7 	25
            ERROR_CODE,                             	-- 7 	26
            ERROR_TEXT,                             	-- 7 	27
            ORPHANED,                               	-- 7 	28
            TRANSFER_ID                            	-- 7 	29
		)
		VALUES (
			JOIN_REC.SRC_OLTP_LOAD_SEQ,
			JOIN_REC.SRC_OLTP_LOAD_DATE_TIME, 
            JOIN_REC.SRC_SOURCE_SERVER,	-- 8 	1
        --    JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	2
        --    JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	3
            JOIN_REC.SRC_BATCH_GUID,	-- 8 	4
            JOIN_REC.SRC_BATCH_MODULE_ID,	-- 8 	5
            JOIN_REC.SRC_EXTERNAL_BATCH_ID,	-- 8 	6
            JOIN_REC.SRC_BATCH_DESCRIPTION,	-- 8 	7
            JOIN_REC.SRC_MODULE_LAUNCH_ID,	-- 8 	8
            JOIN_REC.SRC_MODULE_CLOSE_UNIQUE_ID,	-- 8 	9
            JOIN_REC.SRC_MODULE_NAME,	-- 8 	10
            JOIN_REC.SRC_MODULE_CLOSE_NAME,	-- 8 	11
            JOIN_REC.SRC_START_DATE_TIME,	-- 8 	12
            JOIN_REC.SRC_END_DATE_TIME,	-- 8 	13
            JOIN_REC.SRC_BATCH_STATUS,	-- 8 	14
            JOIN_REC.SRC_PRIORITY,	-- 8 	15
            JOIN_REC.SRC_EXPECTED_PAGES,	-- 8 	16
            JOIN_REC.SRC_EXPECTED_DOCS,	-- 8 	17
            JOIN_REC.SRC_DELETED,	-- 8 	18
            JOIN_REC.SRC_PAGES_PER_DOCUMENT,	-- 8 	19
            JOIN_REC.SRC_PAGES_SCANNED,	-- 8 	20
            JOIN_REC.SRC_PAGES_DELETED,	-- 8 	21
            JOIN_REC.SRC_DOCUMENTS_CREATED,	-- 8 	22
            JOIN_REC.SRC_DOCUMENTS_DELETED,	-- 8 	23
            JOIN_REC.SRC_CHANGED_FORM_TYPES,	-- 8 	24
            JOIN_REC.SRC_PAGES_REPLACED,	-- 8 	25
            JOIN_REC.SRC_ERROR_CODE,	-- 8 	26
            JOIN_REC.SRC_ERROR_TEXT,	-- 8 	27
            JOIN_REC.SRC_ORPHANED,	-- 8 	28
            JOIN_REC.SRC_TRANSFER_ID	-- 8 	29
			);


		COMMIT;

EXCEPTION

	When Others then 
		GV_ERROR_CODE := SQLCODE;
		GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 3000);                 
	DBMS_OUTPUT.PUT_LINE('Procedure Post_Error failed with '||GV_Error_Code||': '||GV_Error_Message);

	--RAISE;


END;

END NYHIX_MFB_V2_STATS_BATCH_MODULE_PKG;
/
SHOW ERRORS

------------------------------------------------------------------------

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
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_REMOTE_LOOKBACK_DAYS','N','5','This is the number of days to look back for Batch Created in ProcessMailFaxBatch Remote database run.',to_date('01-JUN-21','DD-MON-RR'),to_date('09-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_CENTRAL_LAST_UPDATE_DATE','D','14-JUL-21','This is the date of the last ProcessMailFaxBatch Central database run.',to_date('01-JUN-21','DD-MON-RR'),to_date('14-JUL-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_REMOTE_LAST_UPDATE_DATE','D','14-JUL-21','This is the date of the last ProcessMailFaxBatch Remote database run.',to_date('01-JUN-21','DD-MON-RR'),to_date('14-JUL-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_CENTRAL_LOOKBACK_DAYS','N','5','This is the number of days to look back for Batch Created in ProcessMailFaxBatch Remote database run.',to_date('01-JUN-21','DD-MON-RR'),to_date('09-JUN-21','DD-MON-RR'));
---
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_MAXDATREPORTING_FLAG','V','Y','Flag to run MFB ARS ETL processing, Y run, N skip',to_date('01-JUN-21','DD-MON-RR'),to_date('01-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_MAXDATREPORTING_LOOKBACK_DB_REC_NUM','N','50','This is the number of days to look back for Batch Created in ProcessMailFaxBatch Remote database run.',to_date('01-JUN-21','DD-MON-RR'),to_date('09-JUN-21','DD-MON-RR'));
Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_MAXDATREPORTING_LAST_DB_REC_NUM','N','0','This is the timestamp from the previous run of Kofax Central MaxDatReporting',to_date('01-JUN-21','DD-MON-RR'),to_date('01-JUN-21','DD-MON-RR'));
-- Insert into MAXDAT.CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('MFB_V2_MAXDATREPORTING_LAST_UPDATE_DATE','D','13-JUL-21','This is the date of the last ProcessMailFaxBatch Reporting database run.',to_date('01-JUN-21','DD-MON-RR'),to_date('14-JUL-21','DD-MON-RR'));

COMMIT;
