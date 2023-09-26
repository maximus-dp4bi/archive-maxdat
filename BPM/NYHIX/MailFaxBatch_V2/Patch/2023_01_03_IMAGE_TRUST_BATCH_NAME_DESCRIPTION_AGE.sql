ALTER TABLE MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_OLTP
ADD BATCH_DESCRIPTION VARCHAR2(2000);

ALTER TABLE MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_OLTP
ADD USER_NAME VARCHAR2(255);

ALTER TABLE MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH
ADD BATCH_DESCRIPTION VARCHAR2(255);

ALTER TABLE MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH
ADD USER_NAME VARCHAR2(2000);

CREATE OR REPLACE PACKAGE BODY MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_PKG AS

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
	GV_DRIVER_TABLE_NAME  		VARCHAR2(100 BYTE)	:= 'NYHIX_MFB_V2_Load_IMAGE_TRUST_STATS_BATCH';
	GV_DRIVER_KEY_NUMBER  		VARCHAR2(100 BYTE)	:= NULL;
	GV_NR_OF_ERROR        		NUMBER				:= 0;
    GV_UPDATE_TS                DATE                := SYSDATE;

	-- USED FOR THE CORP_ETL_JOB_STATISTICS
	GV_JOB_ID                 	NUMBER              := 0;
	GV_JOB_STATUS_CD          	VARCHAR2(20 BYTE)   := 'STARTED';
	GV_FILE_NAME              	VARCHAR2(512 BYTE)	:= 'NYHIX_MFB_V2_Load_IMAGE_TRUST_STATS_BATCH';
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
		SRC.STATS_BATCH_ID                       AS SRC_STATS_BATCH_ID,                 	-- 1 	1
		SRC.BATCH_ID                             AS SRC_BATCH_ID,                       	-- 1 	2
		SRC.BATCH_U_UID                          AS SRC_BATCH_U_UID,                    	-- 1 	3
		SRC.NODE_ID                              AS SRC_NODE_ID,                        	-- 1 	4
		SRC.NODE_U_UID                           AS SRC_NODE_U_UID,                     	-- 1 	5
		SRC.FLD_COUNT                            AS SRC_FLD_COUNT,                      	-- 1 	6
		SRC.DOC_COUNT                            AS SRC_DOC_COUNT,                      	-- 1 	7
		SRC.PAGE_COUNT                           AS SRC_PAGE_COUNT,                     	-- 1 	8
		SRC.JOB_ID                               AS SRC_JOB_ID,                         	-- 1 	9
		SRC.PRIVAT                               AS SRC_PRIVAT,                         	-- 1 	10
		SRC.START_DATE                           AS SRC_START_DATE,                     	-- 1 	11
		SRC.END_DATE                             AS SRC_END_DATE,                       	-- 1 	12
		SRC.INDEXED_BATCH_COUNT                  AS SRC_INDEXED_BATCH_COUNT,            	-- 1 	13
		SRC.INDEXED_DOC_COUNT                    AS SRC_INDEXED_DOC_COUNT,              	-- 1 	14
		SRC.INDEXED_FLD_COUNT                    AS SRC_INDEXED_FLD_COUNT,              	-- 1 	15
		SRC.USER_ID                              AS SRC_USER_ID,                        	-- 1 	16
		SRC.DELETED                              AS SRC_DELETED,                        	-- 1 	17
		SRC.SESSION_ID                           AS SRC_SESSION_ID,                     	-- 1 	18
		SRC.QUEUE                                AS SRC_QUEUE,                          	-- 1 	19
		SRC.QUEUE_MODE                           AS SRC_QUEUE_MODE,                     	-- 1 	20
		SRC.VERSION                              AS SRC_VERSION,                        	-- 1 	21
		SRC.ORIG_BATCH_ID                        AS SRC_ORIG_BATCH_ID,                  	-- 1 	22
		SRC.LAST_SCANNER_NAME                    AS SRC_LAST_SCANNER_NAME,              	-- 1 	23
		SRC.REASON                               AS SRC_REASON,                         	-- 1 	24
		SRC.COPIED_FROM_BATCH_ID                 AS SRC_COPIED_FROM_BATCH_ID,           	-- 1 	25
		SRC.BATCH_NAME                           AS SRC_BATCH_NAME,                     	-- 1 	26
		SRC.BATCH_PRIORITY                       AS SRC_BATCH_PRIORITY,                 	-- 1 	27
		SRC.STATS_BATCH_SESSION_ID               AS SRC_STATS_BATCH_SESSION_ID,         	-- 1 	28
		SRC.BATCH_RELEASE_RUN_ID                 AS SRC_BATCH_RELEASE_RUN_ID,           	-- 1 	29
		SRC.BATCH_CLASS_NAME                     AS SRC_BATCH_CLASS_NAME,               	-- 1 	30
		SRC.BATCH_DESCRIPTION                    AS SRC_BATCH_DESCRIPTION,               	-- 1 	31
		SRC.USER_NAME							AS 	SRC_USER_NAME
	FROM MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_OLTP SRC
	),
	TARGET AS
	(
	SELECT 
		ROWID    						  AS TARGET_ROWID,
		-- Insert SQL from Query 1 section 2 Here
		--	TARGET.MFB_V2_CREATE_DATE                AS TARGET_MFB_V2_CREATE_DATE,	-- 2 	1
		--	TARGET.MFB_V2_UPDATE_DATE                AS TARGET_MFB_V2_UPDATE_DATE,	-- 2 	2
		TARGET.STATS_BATCH_ID                    AS TARGET_STATS_BATCH_ID,              	-- 2 	1
		TARGET.BATCH_ID                          AS TARGET_BATCH_ID,                    	-- 2 	2
		TARGET.BATCH_U_UID                       AS TARGET_BATCH_U_UID,                 	-- 2 	3
		TARGET.NODE_ID                           AS TARGET_NODE_ID,                     	-- 2 	4
		TARGET.NODE_U_UID                        AS TARGET_NODE_U_UID,                  	-- 2 	5
		TARGET.FLD_COUNT                         AS TARGET_FLD_COUNT,                   	-- 2 	6
		TARGET.DOC_COUNT                         AS TARGET_DOC_COUNT,                   	-- 2 	7
		TARGET.PAGE_COUNT                        AS TARGET_PAGE_COUNT,                  	-- 2 	8
		TARGET.JOB_ID                            AS TARGET_JOB_ID,                      	-- 2 	9
		TARGET.PRIVAT                            AS TARGET_PRIVAT,                      	-- 2 	10
		TARGET.START_DATE                        AS TARGET_START_DATE,                  	-- 2 	11
		TARGET.END_DATE                          AS TARGET_END_DATE,                    	-- 2 	12
		TARGET.INDEXED_BATCH_COUNT               AS TARGET_INDEXED_BATCH_COUNT,         	-- 2 	13
		TARGET.INDEXED_DOC_COUNT                 AS TARGET_INDEXED_DOC_COUNT,           	-- 2 	14
		TARGET.INDEXED_FLD_COUNT                 AS TARGET_INDEXED_FLD_COUNT,           	-- 2 	15
		TARGET.USER_ID                           AS TARGET_USER_ID,                     	-- 2 	16
		TARGET.DELETED                           AS TARGET_DELETED,                     	-- 2 	17
		TARGET.SESSION_ID                        AS TARGET_SESSION_ID,                  	-- 2 	18
		TARGET.QUEUE                             AS TARGET_QUEUE,                       	-- 2 	19
		TARGET.QUEUE_MODE                        AS TARGET_QUEUE_MODE,                  	-- 2 	20
		TARGET.VERSION                           AS TARGET_VERSION,                     	-- 2 	21
		TARGET.ORIG_BATCH_ID                     AS TARGET_ORIG_BATCH_ID,               	-- 2 	22
		TARGET.LAST_SCANNER_NAME                 AS TARGET_LAST_SCANNER_NAME,           	-- 2 	23
		TARGET.REASON                            AS TARGET_REASON,                      	-- 2 	24
		TARGET.COPIED_FROM_BATCH_ID              AS TARGET_COPIED_FROM_BATCH_ID,        	-- 2 	25
		TARGET.BATCH_NAME                        AS TARGET_BATCH_NAME,                  	-- 2 	26
		TARGET.BATCH_PRIORITY                    AS TARGET_BATCH_PRIORITY,              	-- 2 	27
		TARGET.STATS_BATCH_SESSION_ID            AS TARGET_STATS_BATCH_SESSION_ID,      	-- 2 	28
		TARGET.BATCH_RELEASE_RUN_ID              AS TARGET_BATCH_RELEASE_RUN_ID,        	-- 2 	29
		TARGET.BATCH_CLASS_NAME                  AS TARGET_BATCH_CLASS_NAME,           		-- 2 	30 
		TARGET.BATCH_DESCRIPTION                 AS TARGET_BATCH_DESCRIPTION,            	-- 2 	31
	    TARGET.USER_NAME						 AS TARGET_USER_NAME

	  FROM MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH TARGET
	)
	SELECT 
	--	SRC_ROWID,
		TARGET_ROWID,
		-- insert SQL from 3 and 4 here
	--	SRC_MFB_V2_CREATE_DATE,                                      	-- 3 	1
	--	SRC_MFB_V2_UPDATE_DATE,                                         -- 3 	2
                              SRC_STATS_BATCH_ID,                     	-- 3 	1
                              SRC_BATCH_ID,                           	-- 3 	2
                              SRC_BATCH_U_UID,                        	-- 3 	3
                              SRC_NODE_ID,                            	-- 3 	4
                              SRC_NODE_U_UID,                         	-- 3 	5
                              SRC_FLD_COUNT,                          	-- 3 	6
                              SRC_DOC_COUNT,                          	-- 3 	7
                              SRC_PAGE_COUNT,                         	-- 3 	8
                              SRC_JOB_ID,                             	-- 3 	9
                              SRC_PRIVAT,                             	-- 3 	10
                              SRC_START_DATE,                         	-- 3 	11
                              SRC_END_DATE,                           	-- 3 	12
                              SRC_INDEXED_BATCH_COUNT,                	-- 3 	13
                              SRC_INDEXED_DOC_COUNT,                  	-- 3 	14
                              SRC_INDEXED_FLD_COUNT,                  	-- 3 	15
                              SRC_USER_ID,                            	-- 3 	16
                              SRC_DELETED,                            	-- 3 	17
                              SRC_SESSION_ID,                         	-- 3 	18
                              SRC_QUEUE,                              	-- 3 	19
                              SRC_QUEUE_MODE,                         	-- 3 	20
                              SRC_VERSION,                            	-- 3 	21
                              SRC_ORIG_BATCH_ID,                      	-- 3 	22
                              SRC_LAST_SCANNER_NAME,                  	-- 3 	23
                              SRC_REASON,                             	-- 3 	24
                              SRC_COPIED_FROM_BATCH_ID,               	-- 3 	25
                              SRC_BATCH_NAME,                         	-- 3 	26
                              SRC_BATCH_PRIORITY,                     	-- 3 	27
                              SRC_STATS_BATCH_SESSION_ID,             	-- 3 	28
                              SRC_BATCH_RELEASE_RUN_ID,               	-- 3 	29
                              SRC_BATCH_CLASS_NAME,                   	-- 3 	30
							  SRC_BATCH_DESCRIPTION,					-- 3	31
							  SRC_USER_NAME,
                              TARGET_STATS_BATCH_ID,                  	-- 4 	1
                              TARGET_BATCH_ID,                        	-- 4 	2
                              TARGET_BATCH_U_UID,                     	-- 4 	3
                              TARGET_NODE_ID,                         	-- 4 	4
                              TARGET_NODE_U_UID,                      	-- 4 	5
                              TARGET_FLD_COUNT,                       	-- 4 	6
                              TARGET_DOC_COUNT,                       	-- 4 	7
                              TARGET_PAGE_COUNT,                      	-- 4 	8
                              TARGET_JOB_ID,                          	-- 4 	9
                              TARGET_PRIVAT,                          	-- 4 	10
                              TARGET_START_DATE,                      	-- 4 	11
                              TARGET_END_DATE,                        	-- 4 	12
                              TARGET_INDEXED_BATCH_COUNT,             	-- 4 	13
                              TARGET_INDEXED_DOC_COUNT,               	-- 4 	14
                              TARGET_INDEXED_FLD_COUNT,               	-- 4 	15
                              TARGET_USER_ID,                         	-- 4 	16
                              TARGET_DELETED,                         	-- 4 	17
                              TARGET_SESSION_ID,                      	-- 4 	18
                              TARGET_QUEUE,                           	-- 4 	19
                              TARGET_QUEUE_MODE,                      	-- 4 	20
                              TARGET_VERSION,                         	-- 4 	21
                              TARGET_ORIG_BATCH_ID,                   	-- 4 	22
                              TARGET_LAST_SCANNER_NAME,               	-- 4 	23
                              TARGET_REASON,                          	-- 4 	24
                              TARGET_COPIED_FROM_BATCH_ID,            	-- 4 	25
                              TARGET_BATCH_NAME,                      	-- 4 	26
                              TARGET_BATCH_PRIORITY,                  	-- 4 	27
                              TARGET_STATS_BATCH_SESSION_ID,          	-- 4 	28
                              TARGET_BATCH_RELEASE_RUN_ID,            	-- 4 	29
                              TARGET_BATCH_CLASS_NAME,                	-- 4 	30
							  TARGET_BATCH_DESCRIPTION,					-- 4	31
							  TARGET_USER_NAME
	FROM SRC
	LEFT OUTER JOIN TARGET
	ON SRC.SRC_STATS_BATCH_ID = TARGET.TARGET_STATS_BATCH_ID;

-----------------------------------------------------

	JOIN_REC   JOIN_CSR%ROWTYPE;

-----------------------------------------------------
PROCEDURE LOAD_Load_IMAGE_TRUST_STATS_BATCH (P_JOB_ID number default 0) 
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

			IF JOIN_REC.SRC_STATS_BATCH_ID IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN Update_Load_IMAGE_TRUST_STATS_BATCH;
			ELSIF JOIN_REC.SRC_STATS_BATCH_ID IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NULL 
                --then null;
				THEN INSERT_Load_IMAGE_TRUST_STATS_BATCH;
			ELSIF JOIN_REC.SRC_STATS_BATCH_ID IS NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN DELETE_Load_IMAGE_TRUST_STATS_BATCH;
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
				'SRC_STATS_BATCH_ID: '||JOIN_REC.SRC_STATS_BATCH_ID
				||' TARGET_STATS_BATCH_ID: '||JOIN_REC.TARGET_STATS_BATCH_ID
				||'SQLCODE '||GV_ERROR_CODE
				||' '||GV_ERROR_MESSAGE);

			ROLLBACK;

			RAISE;

END Load_Load_IMAGE_TRUST_STATS_BATCH;

-----------------------------------------------------

-----------------------------------------------------
PROCEDURE UPDATE_Load_IMAGE_TRUST_STATS_BATCH IS
-- USES SQL FROM 5 AND 6
-----------------------------------------------------

	BEGIN

	-- COMPARE
		IF 1=2
        --    OR NVL(JOIN_REC.TARGET_MFB_V2_CREATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_CREATE_DATE,SYSDATE - 93333)	-- 5 	1	DATE
        --   OR NVL(JOIN_REC.TARGET_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	-- 5 	2	DATE
            OR NVL(JOIN_REC.TARGET_STATS_BATCH_ID, -93333)	  <>  	NVL(JOIN_REC.SRC_STATS_BATCH_ID, -93333)	-- 5 	1	NUMBER
            OR NVL(JOIN_REC.TARGET_BATCH_ID, -93333)	  <>  	NVL(JOIN_REC.SRC_BATCH_ID, -93333)	-- 5 	2	NUMBER
            OR NVL(JOIN_REC.TARGET_BATCH_U_UID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_U_UID,'-?93333')	-- 5 	3	VARCHAR2
            OR NVL(JOIN_REC.TARGET_NODE_ID, -93333)	  <>  	NVL(JOIN_REC.SRC_NODE_ID, -93333)	-- 5 	4	NUMBER
            OR NVL(JOIN_REC.TARGET_NODE_U_UID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_NODE_U_UID,'-?93333')	-- 5 	5	VARCHAR2
            OR NVL(JOIN_REC.TARGET_FLD_COUNT, -93333)	  <>  	NVL(JOIN_REC.SRC_FLD_COUNT, -93333)	-- 5 	6	NUMBER
            OR NVL(JOIN_REC.TARGET_DOC_COUNT, -93333)	  <>  	NVL(JOIN_REC.SRC_DOC_COUNT, -93333)	-- 5 	7	NUMBER
            OR NVL(JOIN_REC.TARGET_PAGE_COUNT, -93333)	  <>  	NVL(JOIN_REC.SRC_PAGE_COUNT, -93333)	-- 5 	8	NUMBER
            OR NVL(JOIN_REC.TARGET_JOB_ID, -93333)	  <>  	NVL(JOIN_REC.SRC_JOB_ID, -93333)	-- 5 	9	NUMBER
            OR NVL(JOIN_REC.TARGET_PRIVAT,'?')	  <>  	NVL(JOIN_REC.SRC_PRIVAT,'?')	-- 5 	10	CHAR
            OR NVL(JOIN_REC.TARGET_START_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_START_DATE,SYSDATE - 93333)	-- 5 	11	TIMESTAMP(6)
            OR NVL(JOIN_REC.TARGET_END_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_END_DATE,SYSDATE - 93333)	-- 5 	12	TIMESTAMP(6)
            OR NVL(JOIN_REC.TARGET_INDEXED_BATCH_COUNT, -93333)	  <>  	NVL(JOIN_REC.SRC_INDEXED_BATCH_COUNT, -93333)	-- 5 	13	NUMBER
            OR NVL(JOIN_REC.TARGET_INDEXED_DOC_COUNT, -93333)	  <>  	NVL(JOIN_REC.SRC_INDEXED_DOC_COUNT, -93333)	-- 5 	14	NUMBER
            OR NVL(JOIN_REC.TARGET_INDEXED_FLD_COUNT, -93333)	  <>  	NVL(JOIN_REC.SRC_INDEXED_FLD_COUNT, -93333)	-- 5 	15	NUMBER
            OR NVL(JOIN_REC.TARGET_USER_ID, -93333)	  <>  	NVL(JOIN_REC.SRC_USER_ID, -93333)	-- 5 	16	NUMBER
            OR NVL(JOIN_REC.TARGET_DELETED,'?')	  <>  	NVL(JOIN_REC.SRC_DELETED,'?')	-- 5 	17	CHAR
            OR NVL(JOIN_REC.TARGET_SESSION_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_SESSION_ID,'-?93333')	-- 5 	18	VARCHAR2
            OR NVL(JOIN_REC.TARGET_QUEUE,'-?93333')	  <>  	NVL(JOIN_REC.SRC_QUEUE,'-?93333')	-- 5 	19	VARCHAR2
            OR NVL(JOIN_REC.TARGET_QUEUE_MODE,'-?93333')	  <>  	NVL(JOIN_REC.SRC_QUEUE_MODE,'-?93333')	-- 5 	20	VARCHAR2
            OR NVL(JOIN_REC.TARGET_VERSION, -93333)	  <>  	NVL(JOIN_REC.SRC_VERSION, -93333)	-- 5 	21	NUMBER
            OR NVL(JOIN_REC.TARGET_ORIG_BATCH_ID, -93333)	  <>  	NVL(JOIN_REC.SRC_ORIG_BATCH_ID, -93333)	-- 5 	22	NUMBER
            OR NVL(JOIN_REC.TARGET_LAST_SCANNER_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_LAST_SCANNER_NAME,'-?93333')	-- 5 	23	VARCHAR2
            OR NVL(JOIN_REC.TARGET_REASON,'-?93333')	  <>  	NVL(JOIN_REC.SRC_REASON,'-?93333')	-- 5 	24	VARCHAR2
            OR NVL(JOIN_REC.TARGET_COPIED_FROM_BATCH_ID, -93333)	  <>  	NVL(JOIN_REC.SRC_COPIED_FROM_BATCH_ID, -93333)	-- 5 	25	NUMBER
            OR NVL(JOIN_REC.TARGET_BATCH_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_NAME,'-?93333')	-- 5 	26	VARCHAR2
            OR NVL(JOIN_REC.TARGET_BATCH_PRIORITY, -93333)	  <>  	NVL(JOIN_REC.SRC_BATCH_PRIORITY, -93333)	-- 5 	27	NUMBER
            OR NVL(JOIN_REC.TARGET_STATS_BATCH_SESSION_ID, -93333)	  <>  	NVL(JOIN_REC.SRC_STATS_BATCH_SESSION_ID, -93333)	-- 5 	28	NUMBER
            OR NVL(JOIN_REC.TARGET_BATCH_RELEASE_RUN_ID, -93333)	  <>  	NVL(JOIN_REC.SRC_BATCH_RELEASE_RUN_ID, -93333)	-- 5 	29	NUMBER
            OR NVL(JOIN_REC.TARGET_BATCH_CLASS_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_CLASS_NAME,'-?93333')	-- 5 	30	VARCHAR2
            OR NVL(JOIN_REC.TARGET_BATCH_DESCRIPTION,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_DESCRIPTION,'-?93333')	-- 5 	31	VARCHAR2
            OR NVL(JOIN_REC.TARGET_USER_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_USER_NAME,'-?93333')	-- 5 	31	VARCHAR2
			THEN
		UPDATE MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH
		SET  
		-- THE UPDATE
        --    MFB_V2_CREATE_DATE                        =  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 6 	1
        --    MFB_V2_UPDATE_DATE                        =  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 6 	2
            STATS_BATCH_ID                            	=  JOIN_REC.SRC_STATS_BATCH_ID,	-- 6 	1
            BATCH_ID                                  	=  JOIN_REC.SRC_BATCH_ID,	-- 6 	2
            BATCH_U_UID                               	=  JOIN_REC.SRC_BATCH_U_UID,	-- 6 	3
            NODE_ID                                   	=  JOIN_REC.SRC_NODE_ID,	-- 6 	4
            NODE_U_UID                                	=  JOIN_REC.SRC_NODE_U_UID,	-- 6 	5
            FLD_COUNT                                 	=  JOIN_REC.SRC_FLD_COUNT,	-- 6 	6
            DOC_COUNT                                 	=  JOIN_REC.SRC_DOC_COUNT,	-- 6 	7
            PAGE_COUNT                                	=  JOIN_REC.SRC_PAGE_COUNT,	-- 6 	8
            JOB_ID                                    	=  JOIN_REC.SRC_JOB_ID,	-- 6 	9
            PRIVAT                                    	=  JOIN_REC.SRC_PRIVAT,	-- 6 	10
            START_DATE                                	=  JOIN_REC.SRC_START_DATE,	-- 6 	11
            END_DATE                                  	=  JOIN_REC.SRC_END_DATE,	-- 6 	12
            INDEXED_BATCH_COUNT                       	=  JOIN_REC.SRC_INDEXED_BATCH_COUNT,	-- 6 	13
            INDEXED_DOC_COUNT                         	=  JOIN_REC.SRC_INDEXED_DOC_COUNT,	-- 6 	14
            INDEXED_FLD_COUNT                         	=  JOIN_REC.SRC_INDEXED_FLD_COUNT,	-- 6 	15
            USER_ID                                   	=  JOIN_REC.SRC_USER_ID,	-- 6 	16
            DELETED                                   	=  JOIN_REC.SRC_DELETED,	-- 6 	17
            SESSION_ID                                	=  JOIN_REC.SRC_SESSION_ID,	-- 6 	18
            QUEUE                                     	=  JOIN_REC.SRC_QUEUE,	-- 6 	19
            QUEUE_MODE                                	=  JOIN_REC.SRC_QUEUE_MODE,	-- 6 	20
            VERSION                                   	=  JOIN_REC.SRC_VERSION,	-- 6 	21
            ORIG_BATCH_ID                             	=  JOIN_REC.SRC_ORIG_BATCH_ID,	-- 6 	22
            LAST_SCANNER_NAME                         	=  JOIN_REC.SRC_LAST_SCANNER_NAME,	-- 6 	23
            REASON                                    	=  JOIN_REC.SRC_REASON,	-- 6 	24
            COPIED_FROM_BATCH_ID                      	=  JOIN_REC.SRC_COPIED_FROM_BATCH_ID,	-- 6 	25
            BATCH_NAME                                	=  JOIN_REC.SRC_BATCH_NAME,	-- 6 	26
            BATCH_PRIORITY                            	=  JOIN_REC.SRC_BATCH_PRIORITY,	-- 6 	27
            STATS_BATCH_SESSION_ID                    	=  JOIN_REC.SRC_STATS_BATCH_SESSION_ID,	-- 6 	28
            BATCH_RELEASE_RUN_ID                      	=  JOIN_REC.SRC_BATCH_RELEASE_RUN_ID,	-- 6 	29
            BATCH_CLASS_NAME                          	=  JOIN_REC.SRC_BATCH_CLASS_NAME,	-- 6 	30
			BATCH_DESCRIPTION							=  JOIN_REC.SRC_BATCH_DESCRIPTION,
			USER_NAME									=  JOIN_REC.SRC_USER_NAME
			WHERE ROWID = JOIN_REC.TARGET_ROWID;

		GV_RECORD_UPDATED_COUNT := GV_RECORD_UPDATED_COUNT + 1;
		GV_PROCESSED_COUNT := GV_PROCESSED_COUNT + 1;

	ELSE
		NULL; -- NO UPDATE REQUIRED
	END IF;	

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('UPDATE FAILURE '
            ||JOIN_REC.SRC_STATS_BATCH_ID||' '
            --||JOIN_REC.SRC_rowid||' '
            ||JOIN_REC.target_rowid);

	--	GV_DRIVER_KEY_NUMBER  	:= 'SRC_ECN : '||JOIN_REC.ECN;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_Load_IMAGE_TRUST_STATS_BATCH_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_Load_IMAGE_TRUST_STATS_BATCH';

		POST_ERROR;

	END UPDATE_Load_IMAGE_TRUST_STATS_BATCH;	

-----------------------------------------------------
PROCEDURE INSERT_Load_IMAGE_TRUST_STATS_BATCH IS
-- USES SQL  FROM 7 AND 8
-----------------------------------------------------

	BEGIN

		INSERT INTO MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH
		(   
         --   MFB_V2_CREATE_DATE,                     	-- 7 	1
          --  MFB_V2_UPDATE_DATE,                     	-- 7 	2
            STATS_BATCH_ID,                         	-- 7 	1
            BATCH_ID,                               	-- 7 	2
            BATCH_U_UID,                            	-- 7 	3
            NODE_ID,                                	-- 7 	4
            NODE_U_UID,                             	-- 7 	5
            FLD_COUNT,                              	-- 7 	6
            DOC_COUNT,                              	-- 7 	7
            PAGE_COUNT,                             	-- 7 	8
            JOB_ID,                                 	-- 7 	9
            PRIVAT,                                 	-- 7 	10
            START_DATE,                             	-- 7 	11
            END_DATE,                               	-- 7 	12
            INDEXED_BATCH_COUNT,                    	-- 7 	13
            INDEXED_DOC_COUNT,                      	-- 7 	14
            INDEXED_FLD_COUNT,                      	-- 7 	15
            USER_ID,                                	-- 7 	16
            DELETED,                                	-- 7 	17
            SESSION_ID,                             	-- 7 	18
            QUEUE,                                  	-- 7 	19
            QUEUE_MODE,                             	-- 7 	20
            VERSION,                                	-- 7 	21
            ORIG_BATCH_ID,                          	-- 7 	22
            LAST_SCANNER_NAME,                      	-- 7 	23
            REASON,                                 	-- 7 	24
            COPIED_FROM_BATCH_ID,                   	-- 7 	25
            BATCH_NAME,                             	-- 7 	26
            BATCH_PRIORITY,                         	-- 7 	27
            STATS_BATCH_SESSION_ID,                 	-- 7 	28
            BATCH_RELEASE_RUN_ID,                   	-- 7 	29
            BATCH_CLASS_NAME,                      		-- 7 	30
			BATCH_DESCRIPTION,							-- 7 	31
			USER_NAME
			)
		VALUES (
          --  JOIN_REC.SRC_MFB_V2_CREATE_DATE,		-- 8 	1
          --  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,		-- 8 	2
            JOIN_REC.SRC_STATS_BATCH_ID,			-- 8 	1
            JOIN_REC.SRC_BATCH_ID,					-- 8 	2
            JOIN_REC.SRC_BATCH_U_UID,				-- 8 	3
            JOIN_REC.SRC_NODE_ID,					-- 8 	4
            JOIN_REC.SRC_NODE_U_UID,				-- 8 	5
            JOIN_REC.SRC_FLD_COUNT,					-- 8 	6
            JOIN_REC.SRC_DOC_COUNT,					-- 8 	7
            JOIN_REC.SRC_PAGE_COUNT,				-- 8 	8
            JOIN_REC.SRC_JOB_ID,					-- 8 	9
            JOIN_REC.SRC_PRIVAT,					-- 8 	10
            JOIN_REC.SRC_START_DATE,				-- 8 	11
            JOIN_REC.SRC_END_DATE,					-- 8 	12
            JOIN_REC.SRC_INDEXED_BATCH_COUNT,		-- 8 	13
            JOIN_REC.SRC_INDEXED_DOC_COUNT,			-- 8 	14
            JOIN_REC.SRC_INDEXED_FLD_COUNT,			-- 8 	15
            JOIN_REC.SRC_USER_ID,					-- 8 	16
            JOIN_REC.SRC_DELETED,					-- 8 	17
            JOIN_REC.SRC_SESSION_ID,				-- 8 	18
            JOIN_REC.SRC_QUEUE,						-- 8 	19
            JOIN_REC.SRC_QUEUE_MODE,				-- 8 	20
            JOIN_REC.SRC_VERSION,					-- 8 	21
            JOIN_REC.SRC_ORIG_BATCH_ID,				-- 8 	22
            JOIN_REC.SRC_LAST_SCANNER_NAME,			-- 8 	23
            JOIN_REC.SRC_REASON,					-- 8 	24
            JOIN_REC.SRC_COPIED_FROM_BATCH_ID,		-- 8 	25
            JOIN_REC.SRC_BATCH_NAME,				-- 8 	26
            JOIN_REC.SRC_BATCH_PRIORITY,			-- 8 	27
            JOIN_REC.SRC_STATS_BATCH_SESSION_ID,	-- 8 	28
            JOIN_REC.SRC_BATCH_RELEASE_RUN_ID,		-- 8 	29
            JOIN_REC.SRC_BATCH_CLASS_NAME,			-- 8 	30
			JOIN_REC.SRC_BATCH_DESCRIPTION,			-- 8	31
			JOIN_REC.SRC_USER_NAME
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
		GV_DRIVER_KEY_NUMBER  	:= 'SRC STATS_BATCH_ID : '||JOIN_REC.SRC_STATS_BATCH_ID;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_Load_IMAGE_TRUST_STATS_BATCH_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_Load_IMAGE_TRUST_STATS_BATCH';

		POST_ERROR;

	END INSERT_Load_IMAGE_TRUST_STATS_BATCH;	

-----------------------------------------------------
PROCEDURE DELETE_Load_IMAGE_TRUST_STATS_BATCH IS
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
            ||JOIN_REC.SRC_STATS_BATCH_ID||' '
            ||JOIN_REC.target_STATS_BATCH_ID);

		Post_Error;

	END DELETE_Load_IMAGE_TRUST_STATS_BATCH;	


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

--	GV_JOB_NAME		:= 'Mail Fax Batch V2';	

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

END NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_PKG;
/
SHOW ERRORS

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

/* Formatted on 12/20/2022 1:53:34 PM (QP5 v5.374) */
CREATE OR REPLACE FORCE VIEW MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_SV
AS
    SELECT STATS_BATCH_ID,
           MFB_V2_CREATE_DATE,
           MFB_V2_UPDATE_DATE,
           BATCH_ID,
           BATCH_U_UID,
           NODE_ID,
           NODE_U_UID,
           FLD_COUNT,
           DOC_COUNT,
           PAGE_COUNT,
           JOB_ID,
           PRIVAT,
           START_DATE,
           END_DATE,
           INDEXED_BATCH_COUNT,
           INDEXED_DOC_COUNT,
           INDEXED_FLD_COUNT,
           USER_ID,
           DELETED,
           SESSION_ID,
           QUEUE,
           QUEUE_MODE,
           VERSION,
           ORIG_BATCH_ID,
           LAST_SCANNER_NAME,
           REASON,
           COPIED_FROM_BATCH_ID,
           BATCH_NAME,
           BATCH_PRIORITY,
           STATS_BATCH_SESSION_ID,
           BATCH_RELEASE_RUN_ID,
           BATCH_CLASS_NAME,
		   BATCH_DESCRIPTION AS IMAGE_TRUST_BATCH_DESCRIPTION,
		   USER_NAME         AS IMAGE_TRUST_USER_NAME 
      FROM MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_Stats_Batch;
/
SHOW ERRORS


GRANT INSERT, SELECT, UPDATE ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_SV TO MAXDAT_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_SV TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_SV TO MAXDAT_REPORTS;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

CREATE OR REPLACE FORCE VIEW MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_KOFAX_DMS_CHECK_SV
AS
    WITH
        VALID_EXPORTS
        AS
            (                                      -- THIS IS THE DRIVER TABLE
                              -- ALL OTHER TABLES ARE OUTER JOINED TO THIS ONE
     -- NOTE ON 2022/10/1 BATCH CLASSES ('NYHO-FPBP-MAIL','NYHO-FAX') ARE NYEC
                        -- ALL OTHERS ARE NYHIX  *** BUT THAT COULD CHANGE ***
        SELECT BATCH_CREATE_DATE,
               DCN     AS KOFAX_DCN,
               BATCH_NAME,
               BATCH_GUID,
               BATCH_CLASS,
               FORM_TYPE,
               DOCUMENT_NUMBER,
               BATCH_ID,
               BATCH_DOC_COUNT,
               ENVELOPE_DOCUMENT_COUNT,
               DOC_PAGE_COUNT,
               DOC_TYPE,
               ENVELOPE_RECEIVED_DATE,
               FAX_BATCH_SOURCE
          FROM MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING
         WHERE VALID = 1-- AND DB_RECORD_NUM > 0
                        ),
        DMS_DOC
        AS
            (SELECT DCN           AS DMS_DCN,
                    BATCH_ID      AS DMS_BATCH_ID,
                    DATE_RECEIVED,
                    FORM_TYPE     AS DMS_FORM_TYPE,
                    NUMBER_OF_PAGES,
                    ECN           AS DMS_ECN,
                    KOFAX_DCN     AS DMS_KOFAX_DCN,
                    CREATION_DATE,
                    LAST_UPDATE_DATE
               FROM MAXDAT.D_DOCUMENTS
             ----------
             UNION ALL
             ----------
             SELECT DCN           AS DMS_DCN,
                    BATCH_ID      AS DMS_BATCH_ID,
                    DATE_RECEIVED,
                    FORM_TYPE     AS DMS_FORM_TYPE,
                    NUMBER_OF_PAGES,
                    ECN           AS DMS_ECN,
                    KOFAX_DCN     AS DMS_KOFAX_DCN,
                    CREATION_DATE,
                    LAST_UPDATE_DATE
               FROM MAXDAT.D_NYEC_DOCUMENTS),
        BATCH_SUMMARY
        AS
            (SELECT BATCH_GUID     AS SUMMARY_BATCH_GUID,                   --
                    BATCH_COMPLETE_DT,
                    INSTANCE_STATUS,
                    SOURCE_SERVER,
                    BATCH_DESCRIPTION,
                    -- BATCH_CLASS, --
                    BATCH_TYPE,
                    JEOPARDY_FLAG,
                    JEOPARDY_DAYS,
                    JEOPARDY_DT,
                    COMPLETE_DT,
                    REPROCESSED_FLAG,
                    REPROCESSED_DATE,
                    CANCEL_DT,
                    CANCEL_REASON,
                    BATCH_PRIORITY,
                    BATCH_DELETED,
                    AGE_IN_BUSINESS_DAYS,
                    AGE_IN_CALENDAR_DAYS,
                    TIMELINESS_STATUS,
                    TIMELINESS_DAYS,
                    TIMELINESS_DT,
                    LAST_EVENT_STATUS,
                    LAST_EVENT_MODULE_NAME
               FROM MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY),
        IMAGE_TRUST
        AS
            (SELECT DISTINCT
                    BATCH_NAME        AS IMAGE_TRUST_BATCH_NAME,
					BATCH_DESCRIPTION AS IMAGE_TRUST_BATCH_DESCRIPTION,
                    'Image Trust'     AS IMAGE_TRUST_SOURCE_SERVER,
                    USER_NAME         AS IMAGE_TRUST_USER_NAME
               FROM MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH),
        RESULTS
        AS
            (SELECT CASE
                        WHEN DMS_DOC.DMS_DCN IS NULL
                        THEN
                            'Missing from DMS'
                        WHEN NVL (VALID_EXPORTS.DOC_PAGE_COUNT, 0) <>
                             NVL (DMS_DOC.NUMBER_OF_PAGES, 0)
                        THEN
                            'Page Count Error'
                    END    AS ERROR_MESSAGE,
                    CASE
                        WHEN IMAGE_TRUST.IMAGE_TRUST_SOURCE_SERVER
                                 IS NOT NULL
                        THEN
                               'IMAGE TRUST '
                            || IMAGE_TRUST.IMAGE_TRUST_SOURCE_SERVER
                        ELSE
                            BATCH_SUMMARY.SOURCE_SERVER
                    END    AS INITIAL_SOURCE,
                    --   '*** Kofax >>>' as FROM_kofax,
                    VALID_EXPORTS.*,                  -- from MAXDAT_REPORTING
                    --   '*** << Kofax . DMS >>>' as from_DMS,
                    DMS_DOC.*, -- from maxdat.d_documents << dms.app_doc_data_ext
                    --   '*** << DMS .. KOFAX >>>' as FROM_KOFAX_2,
                    BATCH_SUMMARY.*,
                    --   '*** << KOFAX .. Image_trust >>>' as FROM_image_trust,
                    IMAGE_TRUST.*
               FROM VALID_EXPORTS
                    LEFT OUTER JOIN DMS_DOC
                        ON VALID_EXPORTS.KOFAX_DCN = DMS_DOC.DMS_KOFAX_DCN
                    LEFT OUTER JOIN NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH IT
                        ON IT.BATCH_NAME = VALID_EXPORTS.BATCH_NAME
                    LEFT OUTER JOIN BATCH_SUMMARY
                        ON BATCH_SUMMARY.SUMMARY_BATCH_GUID =
                           VALID_EXPORTS.BATCH_GUID
                    LEFT OUTER JOIN IMAGE_TRUST
                        ON IMAGE_TRUST.IMAGE_TRUST_BATCH_NAME =
                           VALID_EXPORTS.BATCH_NAME)
    SELECT ERROR_MESSAGE,
           INITIAL_SOURCE,
           BATCH_CREATE_DATE,
           KOFAX_DCN,
           BATCH_NAME,
           BATCH_GUID,
           BATCH_CLASS,
           FORM_TYPE,
           DOCUMENT_NUMBER,
           BATCH_ID,
           BATCH_DOC_COUNT,
           ENVELOPE_DOCUMENT_COUNT,
           DOC_PAGE_COUNT,
           DOC_TYPE,
           ENVELOPE_RECEIVED_DATE,
           FAX_BATCH_SOURCE,
           DMS_DCN,
           DMS_BATCH_ID,
           DATE_RECEIVED,
           DMS_FORM_TYPE,
           NUMBER_OF_PAGES,
           DMS_ECN,
           DMS_KOFAX_DCN,
           CREATION_DATE,
           LAST_UPDATE_DATE,
           SUMMARY_BATCH_GUID,
           BATCH_COMPLETE_DT,
           INSTANCE_STATUS,
           SOURCE_SERVER,
           IMAGE_TRUST_BATCH_DESCRIPTION,
           IMAGE_TRUST_USER_NAME,
           BATCH_TYPE,
           JEOPARDY_FLAG,
           JEOPARDY_DAYS,
           JEOPARDY_DT,
           COMPLETE_DT,
           REPROCESSED_FLAG,
           REPROCESSED_DATE,
           CANCEL_DT,
           CANCEL_REASON,
           BATCH_PRIORITY,
           BATCH_DELETED,
           AGE_IN_BUSINESS_DAYS,
           AGE_IN_CALENDAR_DAYS,
           TIMELINESS_STATUS,
           TIMELINESS_DAYS,
           TIMELINESS_DT,
           LAST_EVENT_STATUS,
           LAST_EVENT_MODULE_NAME,
           IMAGE_TRUST_BATCH_NAME,
           IMAGE_TRUST_SOURCE_SERVER
      FROM RESULTS;
/
SHOW ERRORS

GRANT INSERT, SELECT, UPDATE ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_KOFAX_DMS_CHECK_SV TO MAXDAT_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_KOFAX_DMS_CHECK_SV TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_KOFAX_DMS_CHECK_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_KOFAX_DMS_CHECK_SV TO MAXDAT_REPORTS;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

CREATE OR REPLACE FORCE VIEW MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_KOFAX_AUDIT_SV
AS
    WITH
        IT_LAST_MODULE
        AS
            (SELECT MIN_MAX.START_DATE,
                    MIN_MAX.END_DATE,
              --      MAXDAT.BUS_DAYS_BETWEEN (MIN_MAX.START_DATE,
              --                               MIN_MAX.END_DATE)
              --          AS IMAGE_TRUST_AGE_IN_BUSINESS_DAYS,
                    ITSB.STATS_BATCH_ID,
                    ITSB.MFB_V2_CREATE_DATE,
                    ITSB.MFB_V2_UPDATE_DATE,
                    ITSB.BATCH_ID,
                    ITSB.BATCH_U_UID,
                    ITSB.NODE_ID,
                    ITSB.NODE_U_UID,
                    ITSB.FLD_COUNT,
                    ITSB.DOC_COUNT,
                    ITSB.PAGE_COUNT,
                    ITSB.JOB_ID,
                    ITSB.PRIVAT,
                    --    ITSB.START_DATE,
                    --    ITSB.END_DATE,
                    ITSB.INDEXED_BATCH_COUNT,
                    ITSB.INDEXED_DOC_COUNT,
                    ITSB.INDEXED_FLD_COUNT,
                    ITSB.USER_ID,
                    ITSB.DELETED,
                    ITSB.SESSION_ID,
                    ITSB.QUEUE,
                    ITSB.QUEUE_MODE,
                    ITSB.VERSION,
                    ITSB.ORIG_BATCH_ID,
                    ITSB.LAST_SCANNER_NAME,
                    ITSB.REASON,
                    ITSB.COPIED_FROM_BATCH_ID,
                    ITSB.BATCH_NAME,
                    ITSB.BATCH_PRIORITY,
                    ITSB.STATS_BATCH_SESSION_ID,
                    ITSB.BATCH_RELEASE_RUN_ID,
                    ITSB.BATCH_CLASS_NAME,
					ITSB.BATCH_DESCRIPTION   AS IMAGE_TRUST_BATCH_DESCRIPTION,
					ITSB.USER_NAME          AS IMAGE_TRUST_USER_NAME
		FROM MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH  ITSB
                    JOIN (  SELECT BATCH_U_UID,
                                   MAX (START_DATE)     AS LAST_START_DATE,
                                   MIN (START_DATE)     AS START_DATE,
                                   MAX (END_DATE)       AS END_DATE
                              FROM MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH
                             WHERE REASON <> 'BATCH_CLEANUP'
                          --AND END_DATE IS NOT NULL
                          GROUP BY BATCH_U_UID) MIN_MAX
                        ON     ITSB.BATCH_U_UID = MIN_MAX.BATCH_U_UID
                           -- MUST JOIN ON LAST_START_DATE BECAUSE END_DATE COULD BE NULL
                           AND ITSB.START_DATE = MIN_MAX.LAST_START_DATE),
        KOFAX_FIRST_MODULE
        AS
            (SELECT SB.BATCH_NAME,
                    SMRY.BATCH_GUID,
                    EV.PAGES_SCANNED         AS KOFAX_PAGES_SCANNED,
                    SMRY.INSTANCE_STATUS     MAXDAT_INSTANCE_STATUS,
                    SMRY.JEOPARDY_FLAG,
                    SMRY.JEOPARDY_DT,
                    --
                    SMRY.CREATE_DT           AS SMRY_CREATE_DATE,
                    --   BATCH_NAME,
                    --   BATCH_GUID,
                    SMRY.BATCH_CLASS,
                    --        SMRY.FORM_TYPE,
                    --        SMRY.DOCUMENT_NUMBER,
                    --        SMRY.BATCH_ID,
                    SMRY.BATCH_DOC_COUNT,
                    SMRY.BATCH_ENVELOPE_COUNT,
                    SMRY.BATCH_PAGE_COUNT,
                    --        SMRY.DOC_TYPE,
                    --        SMRY.ENVELOPE_RECEIVED_DATE,
                    SMRY.FAX_BATCH_SOURCE,
                    --        SMRY.BATCH_GUID,
                    SMRY.BATCH_COMPLETE_DT,
                    --   INSTANCE_STATUS,
                    SMRY.SOURCE_SERVER,                                   --??
                    SMRY.BATCH_DESCRIPTION,
                    SMRY.BATCH_TYPE,
                    --   JEOPARDY_FLAG,
                    --   JEOPARDY_DAYS,
                    --   JEOPARDY_DT,
                    SMRY.COMPLETE_DT,
                    SMRY.REPROCESSED_FLAG,
                    SMRY.REPROCESSED_DATE,
                    SMRY.CANCEL_DT,
                    SMRY.CANCEL_REASON,
                    SMRY.BATCH_PRIORITY      AS KOFAX_BATCH_PRIORITY,
                    SMRY.BATCH_DELETED,
                    SMRY.AGE_IN_BUSINESS_DAYS,
                    SMRY.AGE_IN_CALENDAR_DAYS,
                    SMRY.TIMELINESS_STATUS,
                    SMRY.TIMELINESS_DAYS,
                    SMRY.TIMELINESS_DT,
                    SMRY.LAST_EVENT_STATUS,
                    SMRY.LAST_EVENT_MODULE_NAME
               FROM MAXDAT.NYHIX_MFB_V2_STATS_BATCH  SB
                    JOIN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY SMRY
                        ON SB.BATCH_GUID = SMRY.BATCH_GUID
                    JOIN MAXDAT.NYHIX_MFB_V2_BATCH_EVENT EV
                        ON     SB.BATCH_GUID = EV.BATCH_GUID
                           AND (EV.BATCH_GUID, EV.START_DATE_TIME) IN
                                   (  SELECT BATCH_GUID, MIN (START_DATE_TIME)
                                        FROM MAXDAT.NYHIX_MFB_V2_BATCH_EVENT
                                    GROUP BY BATCH_GUID)
                           AND SB.BATCH_NAME IN
                                   (SELECT BATCH_NAME
                                      FROM MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH)),
        CLEANUPS
        AS              -- << USED TO DETERMINE INACTIVE OR INACTIVE INVENTORY
            (SELECT *
               FROM MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH
              WHERE (BATCH_U_UID, END_DATE) IN
                        (  SELECT BATCH_U_UID, MAX (END_DATE)
                             FROM MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH
                            WHERE     REASON = 'BATCH_CLEANUP'
                                  AND END_DATE IS NOT NULL --<< Cleanup must complete
                         GROUP BY BATCH_U_UID)) --                           ,    --<<<<<< for tetsing <<<<<
    --  Interim_results AS                                                          --<<<<<< for tetsing <<<<<
    --  (                                                                           --<<<<<< for tetsing <<<<<
    SELECT 
		--------------------------------
		CASE
               WHEN     (    IT_LAST_MODULE.QUEUE = 'Export'
                         AND IT_LAST_MODULE.REASON IN
                                 ('EXPORT', 'BATCH_CLEANUP?')
                         AND IT_LAST_MODULE.QUEUE_MODE = 'READY')
                    AND KOFAX_FIRST_MODULE.BATCH_NAME IS NULL
                    AND CLEANUPS.BATCH_U_UID IS NOT NULL
               THEN
                   'ERROR EXPORTED BATCH MISSING'
               ---
               WHEN     (    IT_LAST_MODULE.queue = 'Export'
                         AND IT_LAST_MODULE.REASON IN
                                 ('EXPORT', 'BATCH_CLEANUP?')
                         AND IT_LAST_MODULE.QUEUE_MODE = 'READY')
                    AND KOFAX_FIRST_MODULE.BATCH_NAME IS NOT NULL
                   -- AND CLEANUPS.BATCH_U_UID IS NOT NULL  -- FIX JAN 2023
                    AND NVL (IT_LAST_MODULE.PAGE_COUNT, 0) =
                        NVL (KOFAX_FIRST_MODULE.KOFAX_PAGES_SCANNED, 0)
               THEN
                   'PAGE COUNTS MATCH'
               ---
               WHEN     (    IT_LAST_MODULE.queue = 'Export'
                         AND IT_LAST_MODULE.REASON IN
                                 ('EXPORT', 'BATCH_CLEANUP?')
                         AND IT_LAST_MODULE.QUEUE_MODE = 'READY')
                    AND KOFAX_FIRST_MODULE.BATCH_NAME IS NOT NULL
                    AND NVL (IT_LAST_MODULE.PAGE_COUNT, 0) <>
                        NVL (KOFAX_FIRST_MODULE.KOFAX_PAGES_SCANNED, 0)
                   -- AND CLEANUPS.BATCH_U_UID IS NOT NULL		-- FIX JAN 2023
               THEN
                   'PAGE COUNTS DO NOT MATCH'
               WHEN     NOT (    IT_LAST_MODULE.queue = 'Export'
                             AND IT_LAST_MODULE.REASON IN
                                     ('EXPORT', 'BATCH_CLEANUP?')
                             AND IT_LAST_MODULE.QUEUE_MODE = 'READY')
                    AND KOFAX_FIRST_MODULE.BATCH_NAME IS NULL
                    AND CLEANUPS.BATCH_U_UID IS NULL
               THEN
                   'ACTIVE INVENTORY'
               ---
               WHEN     NOT (    IT_LAST_MODULE.queue = 'Export'
                             AND IT_LAST_MODULE.REASON IN
                                     ('EXPORT?', 'BATCH_CLEANUP?')
                             AND IT_LAST_MODULE.QUEUE_MODE = 'READY')
                    AND KOFAX_FIRST_MODULE.BATCH_NAME IS NULL
                    AND CLEANUPS.BATCH_U_UID IS NOT NULL
               THEN
                   'INACTIVE INVENTORY'
               ---
               ELSE
                   'UNKNOWN'
           END                    AS STATUS,
		--------------------------------
           MAXDAT.BUS_DAYS_BETWEEN 									-- FIX JAN 2023
				(IT_LAST_MODULE.START_DATE,							-- FIX JAN 2023
					CASE 											-- FIX JAN 2023
						WHEN IT_LAST_MODULE.queue = 'Export'		-- FIX JAN 2023
						AND IT_LAST_MODULE.REASON 					-- FIX JAN 2023
							IN ('EXPORT', 'BATCH_CLEANUP?')			-- FIX JAN 2023
						AND IT_LAST_MODULE.QUEUE_MODE = 'READY'		-- FIX JAN 2023
							THEN IT_LAST_MODULE.END_DATE 			-- FIX JAN 2023
							ELSE SYSDATE END 						-- FIX JAN 2023
				) AS IMAGE_TRUST_AGE_IN_BUSINESS_DAYS,				-- FIX JAN 2023
--           IT_LAST_MODULE.IMAGE_TRUST_AGE_IN_BUSINESS_DAYS,
           IT_LAST_MODULE.start_date,
           IT_LAST_MODULE.end_date,
           IT_LAST_MODULE.batch_name,
		   IT_LAST_MODULE.IMAGE_TRUST_BATCH_DESCRIPTION,
		   IT_LAST_MODULE.IMAGE_TRUST_USER_NAME,
           IT_LAST_MODULE.QUEUE,
           IT_LAST_MODULE.REASON,
           IT_LAST_MODULE.QUEUE_MODE,
           IT_LAST_MODULE.PAGE_COUNT,
           KOFAX_FIRST_MODULE.KOFAX_PAGES_SCANNED,
           KOFAX_FIRST_MODULE.MAXDAT_INSTANCE_STATUS,
           KOFAX_FIRST_MODULE.JEOPARDY_FLAG,
           KOFAX_FIRST_MODULE.JEOPARDY_DT,
           -- 'CLEANUPS >>>',
           CLEANUPS.QUEUE         AS BATCH_CLEANUP_QUEUE,
           CLEANUPS.REASON        AS BATCH_CLEANUP_REASON,
           CLEANUPS.QUEUE_MODE    AS BATCH_CLEANUP_QUEUE_MODE,
           CASE
               WHEN KOFAX_FIRST_MODULE.BATCH_NAME IS NULL THEN 'N'
               ELSE 'Y'
           END                    AS IN_KOFAX,
           ---------------------------------
           --    IT_LAST_MODULE.*,
           IT_LAST_MODULE.STATS_BATCH_ID,
           IT_LAST_MODULE.MFB_V2_CREATE_DATE,
           IT_LAST_MODULE.MFB_V2_UPDATE_DATE,
           IT_LAST_MODULE.BATCH_ID,
           IT_LAST_MODULE.BATCH_U_UID,
           IT_LAST_MODULE.NODE_ID,
           IT_LAST_MODULE.NODE_U_UID,
           IT_LAST_MODULE.FLD_COUNT,
           IT_LAST_MODULE.DOC_COUNT,
           --    IT_LAST_MODULE.PAGE_COUNT,
           IT_LAST_MODULE.JOB_ID,
           IT_LAST_MODULE.PRIVAT,
           --    IT_LAST_MODULE.START_DATE,
           --    IT_LAST_MODULE.END_DATE,
           IT_LAST_MODULE.INDEXED_BATCH_COUNT,
           IT_LAST_MODULE.INDEXED_DOC_COUNT,
           IT_LAST_MODULE.INDEXED_FLD_COUNT,
           IT_LAST_MODULE.USER_ID,
           IT_LAST_MODULE.DELETED,
           IT_LAST_MODULE.SESSION_ID,
           --    IT_LAST_MODULE.QUEUE,
           --    IT_LAST_MODULE.QUEUE_MODE,
           IT_LAST_MODULE.VERSION,
           IT_LAST_MODULE.ORIG_BATCH_ID,
           IT_LAST_MODULE.LAST_SCANNER_NAME,
           --    IT_LAST_MODULE.REASON,
           IT_LAST_MODULE.COPIED_FROM_BATCH_ID,
           --    IT_LAST_MODULE.BATCH_NAME,
           IT_LAST_MODULE.BATCH_PRIORITY,
           IT_LAST_MODULE.STATS_BATCH_SESSION_ID,
           IT_LAST_MODULE.BATCH_RELEASE_RUN_ID,
           IT_LAST_MODULE.BATCH_CLASS_NAME,
           --   KOFAX_FIRST_MODULE.*
           -- KOFAX_FIRST_MODULE.BATCH_NAME,
           KOFAX_FIRST_MODULE.BATCH_GUID,
           --
           KOFAX_FIRST_MODULE.SMRY_CREATE_DATE,
           --   BATCH_NAME,
           --   BATCH_GUID,
           KOFAX_FIRST_MODULE.BATCH_CLASS,
           --        KOFAX_FIRST_MODULE.FORM_TYPE,
           --        KOFAX_FIRST_MODULE.DOCUMENT_NUMBER,
           --        KOFAX_FIRST_MODULE.BATCH_ID,
           KOFAX_FIRST_MODULE.BATCH_DOC_COUNT,
           KOFAX_FIRST_MODULE.BATCH_ENVELOPE_COUNT,
           KOFAX_FIRST_MODULE.BATCH_PAGE_COUNT,
           --        KOFAX_FIRST_MODULE.DOC_TYPE,
           --        KOFAX_FIRST_MODULE.ENVELOPE_RECEIVED_DATE,
           KOFAX_FIRST_MODULE.FAX_BATCH_SOURCE,
           --        KOFAX_FIRST_MODULE.BATCH_GUID,
           KOFAX_FIRST_MODULE.BATCH_COMPLETE_DT,
           --   INSTANCE_STATUS,
           KOFAX_FIRST_MODULE.SOURCE_SERVER,                              --??
           KOFAX_FIRST_MODULE.BATCH_DESCRIPTION,
           KOFAX_FIRST_MODULE.BATCH_TYPE,
           --   JEOPARDY_FLAG,
           --   JEOPARDY_DAYS,
           --   JEOPARDY_DT,
           KOFAX_FIRST_MODULE.COMPLETE_DT,
           KOFAX_FIRST_MODULE.REPROCESSED_FLAG,
           KOFAX_FIRST_MODULE.REPROCESSED_DATE,
           KOFAX_FIRST_MODULE.CANCEL_DT,
           KOFAX_FIRST_MODULE.CANCEL_REASON,
           KOFAX_FIRST_MODULE.KOFAX_BATCH_PRIORITY,
           KOFAX_FIRST_MODULE.BATCH_DELETED,
           KOFAX_FIRST_MODULE.AGE_IN_BUSINESS_DAYS,
           KOFAX_FIRST_MODULE.AGE_IN_CALENDAR_DAYS,
           KOFAX_FIRST_MODULE.TIMELINESS_STATUS,
           KOFAX_FIRST_MODULE.TIMELINESS_DAYS,
           KOFAX_FIRST_MODULE.TIMELINESS_DT,
           KOFAX_FIRST_MODULE.LAST_EVENT_STATUS,
           KOFAX_FIRST_MODULE.LAST_EVENT_MODULE_NAME
      FROM IT_LAST_MODULE
           LEFT OUTER JOIN KOFAX_FIRST_MODULE
               -- note: batch_name is not guaranteed to be unique
               -- for Kofax or Image trust.
               -- In recient Production it is except for 'test' cases.
               ON IT_LAST_MODULE.BATCH_NAME = KOFAX_FIRST_MODULE.BATCH_NAME
           LEFT OUTER JOIN CLEANUPS
               ON CLEANUPS.BATCH_U_UID = IT_LAST_MODULE.BATCH_U_UID;


GRANT INSERT, SELECT, UPDATE ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_KOFAX_AUDIT_SV TO MAXDAT_OLTP_SIU;

GRANT DELETE, INSERT, SELECT, UPDATE ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_KOFAX_AUDIT_SV TO MAXDAT_OLTP_SIUD;

GRANT SELECT ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_KOFAX_AUDIT_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_KOFAX_AUDIT_SV TO MAXDAT_REPORTS;


----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
