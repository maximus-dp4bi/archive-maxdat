CREATE OR REPLACE Package MAXDAT.NYHIX_MFB_V2_ENVELOPE_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    Procedure Insert_ENVELOPE;
    Procedure Update_ENVELOPE;
    Procedure Delete_ENVELOPE;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_ENVELOPE ( p_job_id number default 0);

END NYHIX_MFB_V2_ENVELOPE_PKG;



CREATE OR REPLACE PACKAGE BODY MAXDAT.NYHIX_MFB_V2_ENVELOPE_PKG AS

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
	GV_DRIVER_TABLE_NAME  		VARCHAR2(100 BYTE)	:= 'NYHIX_MFB_V2_ENVELOPE';
	GV_DRIVER_KEY_NUMBER  		VARCHAR2(100 BYTE)	:= NULL;
	GV_NR_OF_ERROR        		NUMBER				:= 0;
    GV_UPDATE_TS                DATE                := SYSDATE;

	-- USED FOR THE CORP_ETL_JOB_STATISTICS
	GV_JOB_ID                 	NUMBER              := 0;
	GV_JOB_STATUS_CD          	VARCHAR2(20 BYTE)   := 'STARTED';
	GV_FILE_NAME              	VARCHAR2(512 BYTE)	:= 'NYHIX_MFB_V2_ENVELOPE';
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
        SRC.ECN                                  AS SRC_ECN,	-- 1 	3
        SRC.BATCH_GUID                           AS SRC_BATCH_GUID,	-- 1 	4
        SRC.ENV_RECEIPT_DATE                     AS SRC_ENV_RECEIPT_DATE,	-- 1 	5
        SRC.ENV_CREATION_DATE                    AS SRC_ENV_CREATION_DATE,	-- 1 	6
        SRC.ENVELOPE_DOCUMENT_COUNT              AS SRC_ENVELOPE_DOCUMENT_COUNT,	-- 1 	7
        SRC.ENV_PAGE_COUNT                       AS SRC_ENV_PAGE_COUNT	-- 1 	8
	FROM MAXDAT.NYHIX_MFB_V2_ENVELOPE_OLTP_V SRC
	),
	TARGET AS
	(
	SELECT 
		ROWID    						  AS TARGET_ROWID,
		-- Insert SQL from Query 1 section 2 Here
		--	TARGET.MFB_V2_CREATE_DATE                AS TARGET_MFB_V2_CREATE_DATE,	-- 2 	1
		--	TARGET.MFB_V2_UPDATE_DATE                AS TARGET_MFB_V2_UPDATE_DATE,	-- 2 	2
            TARGET.ECN                               AS TARGET_ECN,	-- 2 	3
            TARGET.BATCH_GUID                        AS TARGET_BATCH_GUID,	-- 2 	4
            TARGET.ENV_RECEIPT_DATE                  AS TARGET_ENV_RECEIPT_DATE,	-- 2 	5
			TARGET.ENV_CREATION_DATE                 AS TARGET_ENV_CREATION_DATE,	-- 2 	6
			TARGET.ENVELOPE_DOCUMENT_COUNT           AS TARGET_ENVELOPE_DOCUMENT_COUNT,	-- 2 	7
            TARGET.ENV_PAGE_COUNT                    AS TARGET_ENV_PAGE_COUNT	-- 2 	8
	  FROM MAXDAT.NYHIX_MFB_V2_ENVELOPE TARGET
	)
	SELECT 
	--	SRC_ROWID,
		TARGET_ROWID,
		-- insert SQL from 3 and 4 here
	--	SRC_MFB_V2_CREATE_DATE,                                               	-- 3 	1
	--	SRC_MFB_V2_UPDATE_DATE,                                               	-- 3 	2
            SRC_ECN,                                	-- 3 	3
            SRC_BATCH_GUID,                         	-- 3 	4
            SRC_ENV_RECEIPT_DATE,                   	-- 3 	5
            SRC_ENV_CREATION_DATE,                  	-- 3 	6
            SRC_ENVELOPE_DOCUMENT_COUNT,            	-- 3 	7
            SRC_ENV_PAGE_COUNT,                     	-- 3 	8
        --  TARGET_MFB_V2_CREATE_DATE,              	-- 4 	1
        --  TARGET_MFB_V2_UPDATE_DATE,              	-- 4 	2
            TARGET_ECN,                             	-- 4 	3
            TARGET_BATCH_GUID,                      	-- 4 	4
            TARGET_ENV_RECEIPT_DATE,                	-- 4 	5
            TARGET_ENV_CREATION_DATE,               	-- 4 	6
            TARGET_ENVELOPE_DOCUMENT_COUNT,         	-- 4 	7
            TARGET_ENV_PAGE_COUNT                  	-- 4 	8							  
	FROM SRC
	LEFT OUTER JOIN TARGET
	ON SRC_ECN = TARGET_ECN;

-----------------------------------------------------

	JOIN_REC   JOIN_CSR%ROWTYPE;

-----------------------------------------------------
PROCEDURE LOAD_ENVELOPE (P_JOB_ID number default 0) 
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

			IF JOIN_REC.SRC_ECN IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN Update_ENVELOPE;
			ELSIF JOIN_REC.SRC_ECN IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NULL 
                --then null;
				THEN INSERT_ENVELOPE;
			ELSIF JOIN_REC.SRC_ECN IS NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN DELETE_ENVELOPE;
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
				'SRC_ECN: '||JOIN_REC.SRC_ECN
				||' TARGET_ECN: '||JOIN_REC.TARGET_ECN
				||'SQLCODE '||GV_ERROR_CODE
				||' '||GV_ERROR_MESSAGE);

			ROLLBACK;

			RAISE;

END Load_ENVELOPE;

-----------------------------------------------------

-----------------------------------------------------
PROCEDURE UPDATE_ENVELOPE IS
-- USES SQL FROM 5 AND 6
-----------------------------------------------------

	BEGIN

	-- COMPARE
		IF 1=2
        --    OR NVL(JOIN_REC.TARGET_MFB_V2_CREATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_CREATE_DATE,SYSDATE - 93333)	-- 5 	1	DATE
        --   OR NVL(JOIN_REC.TARGET_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	-- 5 	2	DATE
            OR NVL(JOIN_REC.TARGET_ECN,'-?93333')	  <>  	NVL(JOIN_REC.SRC_ECN,'-?93333')	-- 5 	3	VARCHAR2
            OR NVL(JOIN_REC.TARGET_BATCH_GUID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_GUID,'-?93333')	-- 5 	4	VARCHAR2
            OR NVL(JOIN_REC.TARGET_ENV_RECEIPT_DATE,SYSDATE - 9333)	  <>  	NVL(JOIN_REC.SRC_ENV_RECEIPT_DATE,SYSDATE - 9333)	-- 5 	5	DATE
            OR NVL(JOIN_REC.TARGET_ENV_CREATION_DATE,SYSDATE - 9333)	  <>  	NVL(JOIN_REC.SRC_ENV_CREATION_DATE,SYSDATE - 9333)	-- 5 	6	DATE
            OR NVL(JOIN_REC.TARGET_ENVELOPE_DOCUMENT_COUNT, -93333)	  <>  	NVL(JOIN_REC.SRC_ENVELOPE_DOCUMENT_COUNT, -93333)	-- 5 	7	NUMBER
            OR NVL(JOIN_REC.TARGET_ENV_PAGE_COUNT, -93333)	  <>  	NVL(JOIN_REC.SRC_ENV_PAGE_COUNT, -93333)	-- 5 	8	NUMBER
			THEN
		UPDATE MAXDAT.NYHIX_MFB_V2_ENVELOPE
		SET  
		-- THE UPDATE
        --    MFB_V2_CREATE_DATE                        =  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 6 	1
        --    MFB_V2_UPDATE_DATE                        =  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 6 	2
            ECN                                       =  JOIN_REC.SRC_ECN,	-- 6 	3
            BATCH_GUID                                =  JOIN_REC.SRC_BATCH_GUID,	-- 6 	4
            ENV_RECEIPT_DATE                          =  JOIN_REC.SRC_ENV_RECEIPT_DATE,	-- 6 	5
            ENV_CREATION_DATE                         =  JOIN_REC.SRC_ENV_CREATION_DATE,	-- 6 	6
            ENVELOPE_DOCUMENT_COUNT                   =  JOIN_REC.SRC_ENVELOPE_DOCUMENT_COUNT,	-- 6 	7
            ENV_PAGE_COUNT                            =  JOIN_REC.SRC_ENV_PAGE_COUNT,	-- 6 	8
			MFB_V2_PARENT_JOB_ID					  =  GV_PARENT_JOB_ID	
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

	--	GV_DRIVER_KEY_NUMBER  	:= 'SRC_ECN : '||JOIN_REC.ECN;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_ENVELOPE_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_ENVELOPE';

		POST_ERROR;

	END UPDATE_ENVELOPE;	

-----------------------------------------------------
PROCEDURE INSERT_ENVELOPE IS
-- USES SQL  FROM 7 AND 8
-----------------------------------------------------

	BEGIN

		INSERT INTO MAXDAT.NYHIX_MFB_V2_ENVELOPE
		(   
         --   MFB_V2_CREATE_DATE,                     	-- 7 	1
          --  MFB_V2_UPDATE_DATE,                     	-- 7 	2
            ECN,                                    	-- 7 	3
            BATCH_GUID,                             	-- 7 	4
            ENV_RECEIPT_DATE,                       	-- 7 	5
            ENV_CREATION_DATE,                      	-- 7 	6
            ENVELOPE_DOCUMENT_COUNT,                	-- 7 	7
            ENV_PAGE_COUNT,	                        	-- 7 	8
			MFB_V2_PARENT_JOB_ID
			)
		VALUES (
          --  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	1
          --  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	2
            JOIN_REC.SRC_ECN,	-- 8 	3
            JOIN_REC.SRC_BATCH_GUID,	-- 8 	4
            JOIN_REC.SRC_ENV_RECEIPT_DATE,	-- 8 	5
            JOIN_REC.SRC_ENV_CREATION_DATE,	-- 8 	6
            JOIN_REC.SRC_ENVELOPE_DOCUMENT_COUNT,	-- 8 	7
            JOIN_REC.SRC_ENV_PAGE_COUNT,	-- 8 	8
			GV_PARENT_JOB_ID				
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
		GV_DRIVER_KEY_NUMBER  	:= 'SRC ECN : '||JOIN_REC.SRC_ECN;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_ENVELOPE_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_ENVELOPE';

		POST_ERROR;

	END INSERT_ENVELOPE;	

-----------------------------------------------------
PROCEDURE DELETE_ENVELOPE IS
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
            ||JOIN_REC.SRC_ECN||' '
            ||JOIN_REC.target_ECN);

		Post_Error;

	END DELETE_ENVELOPE;	


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

END NYHIX_MFB_V2_ENVELOPE_PKG;



GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_ENVELOPE_PKG TO MAXDAT_PFP_READ_ONLY;
GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_ENVELOPE_PKG TO MAXDAT_READ_ONLY;

