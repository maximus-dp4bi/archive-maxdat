CREATE OR REPLACE PACKAGE MAXDAT."NYHIX_MFB_V2_MAXDAT_REPORTING_PKG" AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $';
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    Procedure Insert_MAXDAT_REPORTING;
    Procedure Update_MAXDAT_REPORTING;
    Procedure Delete_MAXDAT_REPORTING;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_MAXDAT_REPORTING ( p_job_id number default 0);

END NYHIX_MFB_V2_MAXDAT_REPORTING_PKG;
/
SHOW ERRORS

CREATE OR REPLACE PACKAGE BODY MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING_PKG AS

	GV_PARENT_JOB_ID          	NUMBER				:= 0;
	GV_ERROR_CODE				VARCHAR2(50)		:= NULL;
	GV_ERROR_MESSAGE			VARCHAR2(4000)		:= NULL;
	GV_ERROR_FIELD				VARCHAR2(400)		:= NULL;
	GV_ERROR_CODES				VARCHAR2(400)		:= NULL;
	GV_ERR_DATE					DATE				:= SYSDATE;
	GV_ERR_LEVEL				VARCHAR2(20)		:= 'CRITICAL';
	GV_PROCESS_NAME				VARCHAR2(120)		:= 'NYHIX_MFB_V2';
	GV_JOB_NAME					VARCHAR2(120)		:= '';
	GV_DRIVER_TABLE_NAME  		VARCHAR2(100 BYTE)	:= 'NYHIX_MFB_V2_MAXDAT_REPORTING';
	GV_DRIVER_KEY_NUMBER  		VARCHAR2(100 BYTE)	:= NULL;
	GV_NR_OF_ERROR        		NUMBER				:= 0;
    GV_UPDATE_TS                DATE                := SYSDATE;

	-- USED FOR THE CORP_ETL_JOB_STATISTICS
	GV_JOB_ID                 	NUMBER              := 0;
	GV_JOB_STATUS_CD          	VARCHAR2(20 BYTE)   := 'STARTED';
	GV_FILE_NAME              	VARCHAR2(512 BYTE)	:= 'NYHIX_MFB_V2_MAXDAT_REPORTING';
	GV_RECORD_COUNT           	NUMBER				:= 0;
	GV_ERROR_COUNT            	NUMBER				:= 0;
	GV_WARNING_COUNT          	NUMBER				:= 0;
	GV_PROCESSED_COUNT        	NUMBER				:= 0;
	GV_RECORD_INSERTED_COUNT  	NUMBER				:= 0;
	GV_RECORD_UPDATED_COUNT   	NUMBER				:= 0;
	GV_JOB_START_DATE         	DATE				:= SYSDATE;

    GV_UPDATE_SECTION           VARCHAR2(50)        := NULL;

	CURSOR JOIN_CSR IS
	WITH SRC AS
	(
	SELECT
		--	rowidtochar(ROWID)    			 AS  SRC_ROWID,
		ROWID    							 AS SRC_ROWID,
		DB_RECORD_NUM                        AS SRC_DB_RECORD_NUM,        	-- 1 	1
		DOCUMENT_NUMBER                      AS SRC_DOCUMENT_NUMBER,      	-- 1 	2
		BATCH_GUID                           AS SRC_BATCH_GUID,           	-- 1 	3
		BATCH_ID                             AS SRC_BATCH_ID,             	-- 1 	4
		ECN                                  AS SRC_ECN,                  	-- 1 	5
		DCN                                  AS SRC_DCN,                  	-- 1 	6
		VALID                                AS SRC_VALID,                	-- 1 	7
		BATCH_CLASS                          AS SRC_BATCH_CLASS,          	-- 1 	8
		BATCH_EXPORT_DATE					 AS SRC_BATCH_EXPORT_DATE,    	-- 1 	9
		BATCH_EXPORT_TIME                    AS SRC_BATCH_EXPORT_TIME,    	-- 1 	10
		BATCH_CREATE_DATE					 AS SRC_BATCH_CREATE_DATE,    	-- 1 	11
		BATCH_CREATE_TIME                    AS SRC_BATCH_CREATE_TIME,    	-- 1 	12
		BATCH_DESCRIPTION                    AS SRC_BATCH_DESCRIPTION,    	-- 1 	13
		EXPORT_PATH                          AS SRC_EXPORT_PATH,          	-- 1 	14
		BATCH_NAME                           AS SRC_BATCH_NAME,           	-- 1 	15
		BATCH_DOC_COUNT                      AS SRC_BATCH_DOC_COUNT,      	-- 1 	16
		BATCH_CREATION_STATION_ID            AS SRC_BATCH_CREATION_STATION_ID,	-- 1 	17
		ENVELOPE_DOCUMENT_COUNT              AS SRC_ENVELOPE_DOCUMENT_COUNT,	-- 1 	18
		DOC_CLASS                            AS SRC_DOC_CLASS,            	-- 1 	19
		FORM_TYPE                            AS SRC_FORM_TYPE,            	-- 1 	20
		DOC_TYPE                             AS SRC_DOC_TYPE,             	-- 1 	21
		DOC_PAGE_COUNT                       AS SRC_DOC_PAGE_COUNT,       	-- 1 	22
		BATCH_CREATED_BY                     AS SRC_BATCH_CREATED_BY,     	-- 1 	23
		ENVELOPE_RECEIVED_DATE               AS SRC_ENVELOPE_RECEIVED_DATE,	-- 1 	24
		FAX_BATCH_SOURCE                     AS SRC_FAX_BATCH_SOURCE     	-- 1 	25
	FROM MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING_OLTP
	WHERE VALID = 1   -- 2022/04/15 ADDED TO PRVENT DUP VAL IN INDEX ERROR  
	),
	TARGET AS
	(
	SELECT
		--	rowidtochar(ROWID)    		  AS  TARGET_ROWID,
		ROWID    						  AS TARGET_ROWID,
		DB_RECORD_NUM                     AS TARGET_DB_RECORD_NUM,     	-- 2 	1
		DOCUMENT_NUMBER                   AS TARGET_DOCUMENT_NUMBER,   	-- 2 	2
		BATCH_GUID                        AS TARGET_BATCH_GUID,        	-- 2 	3
		BATCH_ID                          AS TARGET_BATCH_ID,          	-- 2 	4
		ECN                               AS TARGET_ECN,               	-- 2 	5
		DCN                               AS TARGET_DCN,               	-- 2 	6
		VALID                             AS TARGET_VALID,             	-- 2 	7
		BATCH_CLASS                       AS TARGET_BATCH_CLASS,       	-- 2 	8
		BATCH_EXPORT_DATE                 AS TARGET_BATCH_EXPORT_DATE, 	-- 2 	9
--		BATCH_EXPORT_TIME                 AS TARGET_BATCH_EXPORT_TIME, 	-- 2 	10
		BATCH_CREATE_DATE                 AS TARGET_BATCH_CREATE_DATE, 	-- 2 	11
--		BATCH_CREATE_TIME                 AS TARGET_BATCH_CREATE_TIME, 	-- 2 	12
		BATCH_DESCRIPTION                 AS TARGET_BATCH_DESCRIPTION, 	-- 2 	13
		EXPORT_PATH                       AS TARGET_EXPORT_PATH,       	-- 2 	14
		BATCH_NAME                        AS TARGET_BATCH_NAME,        	-- 2 	15
		BATCH_DOC_COUNT                   AS TARGET_BATCH_DOC_COUNT,   	-- 2 	16
		BATCH_CREATION_STATION_ID         AS TARGET_BATCH_CREATION_STATION_ID,	-- 2 	17
		ENVELOPE_DOCUMENT_COUNT           AS TARGET_ENVELOPE_DOCUMENT_COUNT, -- 2 	18
		DOC_CLASS                         AS TARGET_DOC_CLASS,         	-- 2 	19
		FORM_TYPE                         AS TARGET_FORM_TYPE,         	-- 2 	20
		DOC_TYPE                          AS TARGET_DOC_TYPE,          	-- 2 	21
		DOC_PAGE_COUNT                    AS TARGET_DOC_PAGE_COUNT,    	-- 2 	22
		BATCH_CREATED_BY                  AS TARGET_BATCH_CREATED_BY,  	-- 2 	23
		ENVELOPE_RECEIVED_DATE            AS TARGET_ENVELOPE_RECEIVED_DATE,-- 2 	24
		FAX_BATCH_SOURCE                  AS TARGET_FAX_BATCH_SOURCE  	-- 2 	25
	FROM MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING
	)
	SELECT
	SRC_ROWID,
		SRC_DB_RECORD_NUM,        	-- 1 	1
		SRC_DOCUMENT_NUMBER,      	-- 1 	2
		SRC_BATCH_GUID,           	-- 1 	3
		SRC_BATCH_ID,             	-- 1 	4
		SRC_ECN,                  	-- 1 	5
		SRC_DCN,                  	-- 1 	6
		SRC_VALID,                	-- 1 	7
		SRC_BATCH_CLASS,          	-- 1 	8
		SRC_BATCH_EXPORT_DATE,    	-- 1 	9
		SRC_BATCH_EXPORT_TIME,    	-- 1 	10
		SRC_BATCH_CREATE_DATE,    	-- 1 	11
		SRC_BATCH_CREATE_TIME,    	-- 1 	12
		SRC_BATCH_DESCRIPTION,    	-- 1 	13
		SRC_EXPORT_PATH,          	-- 1 	14
		SRC_BATCH_NAME,           	-- 1 	15
		SRC_BATCH_DOC_COUNT,      	-- 1 	16
		SRC_BATCH_CREATION_STATION_ID,	-- 1 	17
		SRC_ENVELOPE_DOCUMENT_COUNT,	-- 1 	18
		SRC_DOC_CLASS,            	-- 1 	19
		SRC_FORM_TYPE,            	-- 1 	20
		SRC_DOC_TYPE,             	-- 1 	21
		SRC_DOC_PAGE_COUNT,       	-- 1 	22
		SRC_BATCH_CREATED_BY,     	-- 1 	23
		SRC_ENVELOPE_RECEIVED_DATE,	-- 1 	24
		SRC_FAX_BATCH_SOURCE,     	-- 1 	25
		TARGET_ROWID,
		TARGET_DB_RECORD_NUM,     	-- 2 	1
		TARGET_DOCUMENT_NUMBER,   	-- 2 	2
		TARGET_BATCH_GUID,        	-- 2 	3
		TARGET_BATCH_ID,          	-- 2 	4
		TARGET_ECN,               	-- 2 	5
		TARGET_DCN,               	-- 2 	6
		TARGET_VALID,             	-- 2 	7
		TARGET_BATCH_CLASS,       	-- 2 	8
		TARGET_BATCH_EXPORT_DATE, 	-- 2 	9
--		TARGET_BATCH_EXPORT_TIME, 	-- 2 	10
		TARGET_BATCH_CREATE_DATE, 	-- 2 	11
--		TARGET_BATCH_CREATE_TIME, 	-- 2 	12
		TARGET_BATCH_DESCRIPTION, 	-- 2 	13
		TARGET_EXPORT_PATH,       	-- 2 	14
		TARGET_BATCH_NAME,        	-- 2 	15
		TARGET_BATCH_DOC_COUNT,   	-- 2 	16
		TARGET_BATCH_CREATION_STATION_ID,	-- 2 	17
		TARGET_ENVELOPE_DOCUMENT_COUNT,	-- 2 	18
		TARGET_DOC_CLASS,         	-- 2 	19
		TARGET_FORM_TYPE,         	-- 2 	20
		TARGET_DOC_TYPE,          	-- 2 	21
		TARGET_DOC_PAGE_COUNT,    	-- 2 	22
		TARGET_BATCH_CREATED_BY,  	-- 2 	23
		TARGET_ENVELOPE_RECEIVED_DATE,	-- 2 	24
		TARGET_FAX_BATCH_SOURCE  	-- 2 	25
	FROM SRC
	LEFT OUTER JOIN TARGET
	ON SRC_DB_RECORD_NUM = TARGET_DB_RECORD_NUM;

	JOIN_REC   JOIN_CSR%ROWTYPE;


-----------------------------------------------------
PROCEDURE LOAD_MAXDAT_REPORTING (P_JOB_ID number default 0)
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

        GV_JOB_NAME	:= GV_PROCESS_NAME||' Parent ID: '||GV_PARENT_JOB_ID||' - '||'Step NYHIX_MFB_V2_MAXDAT_REPORTING';

		Insert_Corp_ETL_Job_Statistics;

		IF (JOIN_CSR%ISOPEN)
		THEN
			CLOSE JOIN_CSR;
		END IF;

		OPEN JOIN_CSR;

		LOOP

			BEGIN
			
			FETCH JOIN_CSR INTO JOIN_REC;

			EXIT WHEN JOIN_CSR%NOTFOUND;

			GV_RECORD_COUNT := GV_RECORD_COUNT+1;

			IF JOIN_REC.SRC_ROWID IS NOT NULL
			AND JOIN_REC.TARGET_ROWID IS NOT NULL
				THEN Update_MAXDAT_REPORTING;
			ELSIF JOIN_REC.SRC_ROWID IS NOT NULL
			AND JOIN_REC.TARGET_ROWID IS NULL
				THEN INSERT_MAXDAT_REPORTING;
			ELSIF JOIN_REC.SRC_ROWID IS NULL
			AND JOIN_REC.TARGET_ROWID IS NOT NULL
				THEN DELETE_MAXDAT_REPORTING;
			ELSE
				NULL;
			END IF;
			
			EXCEPTION
				WHEN NO_DATA_FOUND
				THEN NULL;

				WHEN OTHERS THEN

					GV_ERROR_CODE := SQLCODE;
					GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 3000);

					DBMS_OUTPUT.PUT_LINE('Main Cursor failure for '||
					'SRC_DB_RECORD_NUM: '||JOIN_REC.SRC_DB_RECORD_NUM
					||' TARGET_DB_RECORD_NUM: '||JOIN_REC.TARGET_DB_RECORD_NUM
					||'SQLCODE '||GV_ERROR_CODE
					||' '||GV_ERROR_MESSAGE);

				COMMIT;

				CONTINUE;
			
			END;

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

		Update_Corp_ETL_Job_Statistics;



	EXCEPTION

		WHEN NO_DATA_FOUND
		THEN
			NULL;

        WHEN OTHERS THEN

            GV_ERROR_CODE := SQLCODE;
            GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 3000);

			DBMS_OUTPUT.PUT_LINE('Main Cursor failure for '||
				'SRC_DB_RECORD_NUM: '||JOIN_REC.SRC_DB_RECORD_NUM
				||' TARGET_DB_RECORD_NUM: '||JOIN_REC.TARGET_DB_RECORD_NUM
				||'SQLCODE '||GV_ERROR_CODE
				||' '||GV_ERROR_MESSAGE);

			ROLLBACK;

			RAISE;

END Load_MAXDAT_REPORTING;

-----------------------------------------------------
Procedure Insert_Corp_ETL_Job_Statistics IS
PRAGMA AUTONOMOUS_TRANSACTION;
-----------------------------------------------------
BEGIN

	INSERT INTO MAXDAT.CORP_ETL_JOB_STATISTICS (
		ERROR_COUNT,
		FILE_NAME,
--		JOB_END_DATE,
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
--		GV_JOB_END_DATE, 			-- JOB_END_DATE
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
		JOB_END_DATE         	= sysdate,
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


-----------------------------------------------------
PROCEDURE UPDATE_MAXDAT_REPORTING IS
-----------------------------------------------------

	BEGIN
        GV_UPDATE_SECTION  :=  'COMPARE';

	-- COMPARE
		IF NVL(JOIN_REC.TARGET_DB_RECORD_NUM, -93333)	  				<>  	NVL(JOIN_REC.SRC_DB_RECORD_NUM, -93333)
		OR NVL(JOIN_REC.TARGET_DOCUMENT_NUMBER, -93333)	  				<>  	NVL(JOIN_REC.SRC_DOCUMENT_NUMBER, -93333)
		OR NVL(JOIN_REC.TARGET_BATCH_GUID,'-?93333')	  				<>  	NVL(JOIN_REC.SRC_BATCH_GUID,'-?93333')
		OR NVL(JOIN_REC.TARGET_BATCH_ID, -93333)	  					<>  	NVL(JOIN_REC.SRC_BATCH_ID, -93333)
		OR NVL(JOIN_REC.TARGET_ECN,'-?93333')	  						<>  	NVL(JOIN_REC.SRC_ECN,'-?93333')
		OR NVL(JOIN_REC.TARGET_DCN,'-?93333')	  						<>  	NVL(JOIN_REC.SRC_DCN,'-?93333')
		OR NVL(JOIN_REC.TARGET_VALID, -93333)	  						<>  	NVL(JOIN_REC.SRC_VALID, -93333)
		OR NVL(JOIN_REC.TARGET_BATCH_CLASS,'-?93333')	  				<>  	NVL(JOIN_REC.SRC_BATCH_CLASS,'-?93333')
		-----
		OR NVL(JOIN_REC.TARGET_BATCH_EXPORT_DATE,SYSDATE -93333)
            <>
            NVL(
                TO_DATE(JOIN_REC.SRC_BATCH_EXPORT_DATE||' '||JOIN_REC.SRC_BATCH_EXPORT_TIME,
				   	   'MM/DD/YYYY HH:MI:SS PM'),
				SYSDATE - 93333)
		-----
		OR NVL(JOIN_REC.TARGET_BATCH_CREATE_DATE,SYSDATE -93333)
                <>
                NVL(TO_DATE(JOIN_REC.SRC_BATCH_CREATE_DATE||' '||JOIN_REC.SRC_BATCH_CREATE_TIME,
									'MM/DD/YYYY HH:MI:SS PM'), -- 4/14/2021 7:24:37 AM
				SYSDATE -93333)
		OR NVL(JOIN_REC.TARGET_BATCH_DESCRIPTION,'-?93333')	  			<>  	NVL(JOIN_REC.SRC_BATCH_DESCRIPTION,'-?93333')
		OR NVL(JOIN_REC.TARGET_EXPORT_PATH,'-?93333')	  				<>  	NVL(JOIN_REC.SRC_EXPORT_PATH,'-?93333')
		OR NVL(JOIN_REC.TARGET_BATCH_NAME,'-?93333')	  				<>  	NVL(JOIN_REC.SRC_BATCH_NAME,'-?93333')
		OR NVL(JOIN_REC.TARGET_BATCH_DOC_COUNT, -93333)	  				<>  	NVL(JOIN_REC.SRC_BATCH_DOC_COUNT, -93333)
		OR NVL(JOIN_REC.TARGET_BATCH_CREATION_STATION_ID,'-?93333')	  	<>  	NVL(JOIN_REC.SRC_BATCH_CREATION_STATION_ID,'-?93333')
		OR NVL(JOIN_REC.TARGET_ENVELOPE_DOCUMENT_COUNT, -93333)	  		<>  	NVL(JOIN_REC.SRC_ENVELOPE_DOCUMENT_COUNT, -93333)
		OR NVL(JOIN_REC.TARGET_DOC_CLASS,'-?93333')	  					<>  	NVL(JOIN_REC.SRC_DOC_CLASS,'-?93333')
		OR NVL(JOIN_REC.TARGET_FORM_TYPE,'-?93333')	  					<>  	NVL(JOIN_REC.SRC_FORM_TYPE,'-?93333')
		OR NVL(JOIN_REC.TARGET_DOC_TYPE,'-?93333')	  					<>  	NVL(JOIN_REC.SRC_DOC_TYPE,'-?93333')
		OR NVL(JOIN_REC.TARGET_DOC_PAGE_COUNT, -93333)	  				<>  	NVL(JOIN_REC.SRC_DOC_PAGE_COUNT, -93333)
		OR NVL(JOIN_REC.TARGET_BATCH_CREATED_BY,'-?93333')	  			<>  	NVL(JOIN_REC.SRC_BATCH_CREATED_BY,'-?93333')
		---
		OR NVL(JOIN_REC.TARGET_ENVELOPE_RECEIVED_DATE,SYSDATE -93333)	<>  	NVL(TO_DATE(JOIN_REC.SRC_ENVELOPE_RECEIVED_DATE,'YYYY-MM-DD'), SYSDATE-93333) -- 2020-06-16
		---
		OR NVL(JOIN_REC.TARGET_FAX_BATCH_SOURCE,'-?93333')	  			<>  	NVL(JOIN_REC.SRC_FAX_BATCH_SOURCE,'-?93333')
	THEN
        GV_UPDATE_SECTION  :=  'UPDATE';

		UPDATE MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING
		SET
		-- THE UPDATE
			DOCUMENT_NUMBER                           =  JOIN_REC.SRC_DOCUMENT_NUMBER,
			BATCH_GUID                                =  JOIN_REC.SRC_BATCH_GUID,
			BATCH_ID                                  =  JOIN_REC.SRC_BATCH_ID,
			ECN                                       =  JOIN_REC.SRC_ECN,
			DCN                                       =  JOIN_REC.SRC_DCN,
			VALID                                     =  JOIN_REC.SRC_VALID,
			BATCH_CLASS                               =  JOIN_REC.SRC_BATCH_CLASS,
			BATCH_EXPORT_DATE                         =  TO_DATE(JOIN_REC.SRC_BATCH_EXPORT_DATE||' '||JOIN_REC.SRC_BATCH_EXPORT_TIME,'MM/DD/YYYY HH:MI:SS PM'),
--??			BATCH_EXPORT_TIME                         =  JOIN_REC.SRC_BATCH_EXPORT_TIME,
			BATCH_CREATE_DATE                         =  TO_DATE(JOIN_REC.SRC_BATCH_CREATE_DATE||' '||JOIN_REC.SRC_BATCH_CREATE_TIME,'MM/DD/YYYY HH:MI:SS PM'),
--??			BATCH_CREATE_TIME                         =  JOIN_REC.SRC_BATCH_CREATE_TIME,
			BATCH_DESCRIPTION                         =  JOIN_REC.SRC_BATCH_DESCRIPTION,
			EXPORT_PATH                               =  JOIN_REC.SRC_EXPORT_PATH,
			BATCH_NAME                                =  JOIN_REC.SRC_BATCH_NAME,
			BATCH_DOC_COUNT                           =  JOIN_REC.SRC_BATCH_DOC_COUNT,
			BATCH_CREATION_STATION_ID                 =  JOIN_REC.SRC_BATCH_CREATION_STATION_ID,
			ENVELOPE_DOCUMENT_COUNT                   =  JOIN_REC.SRC_ENVELOPE_DOCUMENT_COUNT,
			DOC_CLASS                                 =  JOIN_REC.SRC_DOC_CLASS,
			FORM_TYPE                                 =  JOIN_REC.SRC_FORM_TYPE,
			DOC_TYPE                                  =  JOIN_REC.SRC_DOC_TYPE,
			DOC_PAGE_COUNT                            =  JOIN_REC.SRC_DOC_PAGE_COUNT,
			BATCH_CREATED_BY                          =  JOIN_REC.SRC_BATCH_CREATED_BY,
			ENVELOPE_RECEIVED_DATE                    =  NVL(TO_DATE(JOIN_REC.SRC_ENVELOPE_RECEIVED_DATE,'YYYY-MM-DD'),SYSDATE - 93333),  -- 2020-06-16
			FAX_BATCH_SOURCE                          =  JOIN_REC.SRC_FAX_BATCH_SOURCE,
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
            ||JOIN_REC.SRC_DB_RECORD_NUM||' '
            ||JOIN_REC.SRC_rowid||' '
            ||JOIN_REC.target_rowid||' '
            ||GV_UPDATE_SECTION);

		GV_DRIVER_KEY_NUMBER  	:= 'SRC_ROWID : '||JOIN_REC.SRC_ROWID;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_REPORTING_OLTP';
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_Maxdat_reporting';

		POST_ERROR;

	END UPDATE_MAXDAT_REPORTING;

-----------------------------------------------------
PROCEDURE INSERT_MAXDAT_REPORTING IS
-----------------------------------------------------

	BEGIN

		INSERT INTO MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING
		(
			DB_RECORD_NUM,                          	-- 1
			DOCUMENT_NUMBER,                        	-- 2
			BATCH_GUID,                             	-- 3
			BATCH_ID,                               	-- 4
			ECN,                                    	-- 5
			DCN,                                    	-- 6
			VALID,                                  	-- 7
			BATCH_CLASS,                            	-- 8
			BATCH_EXPORT_DATE,                      	-- 9
--			BATCH_EXPORT_TIME,                      	-- 10
			BATCH_CREATE_DATE,                      	-- 11
--			BATCH_CREATE_TIME,                      	-- 12
			BATCH_DESCRIPTION,                      	-- 13
			EXPORT_PATH,                            	-- 14
			BATCH_NAME,                             	-- 15
			BATCH_DOC_COUNT,                        	-- 16
			BATCH_CREATION_STATION_ID,              	-- 17
			ENVELOPE_DOCUMENT_COUNT,                	-- 18
			DOC_CLASS,                              	-- 19
			FORM_TYPE,                              	-- 20
			DOC_TYPE,                               	-- 21
			DOC_PAGE_COUNT,                         	-- 22
			BATCH_CREATED_BY,                       	-- 23
			ENVELOPE_RECEIVED_DATE,                 	-- 24
			FAX_BATCH_SOURCE,                      		-- 25
			MFB_V2_PARENT_JOB_ID
		)
		VALUES (
			JOIN_REC.SRC_DB_RECORD_NUM,				-- 1
			JOIN_REC.SRC_DOCUMENT_NUMBER,			-- 2
			JOIN_REC.SRC_BATCH_GUID,				-- 3
			JOIN_REC.SRC_BATCH_ID,					-- 4
			JOIN_REC.SRC_ECN,						-- 5
			JOIN_REC.SRC_DCN,						-- 6
			JOIN_REC.SRC_VALID,						-- 7
			JOIN_REC.SRC_BATCH_CLASS,				-- 8
			TO_DATE(JOIN_REC.SRC_BATCH_EXPORT_DATE||' '||JOIN_REC.SRC_BATCH_EXPORT_TIME,'MM/DD/YYYY HH:MI:SS PM'),			-- 9
--			JOIN_REC.SRC_BATCH_EXPORT_TIME,			-- 10
			TO_DATE(JOIN_REC.SRC_BATCH_CREATE_DATE||' '||JOIN_REC.SRC_BATCH_CREATE_TIME,'MM/DD/YYYY HH:MI:SS PM'),			-- 11
--			JOIN_REC.SRC_BATCH_CREATE_TIME,			-- 12
			JOIN_REC.SRC_BATCH_DESCRIPTION,			-- 13
			JOIN_REC.SRC_EXPORT_PATH,				-- 14
			JOIN_REC.SRC_BATCH_NAME,				-- 15
			JOIN_REC.SRC_BATCH_DOC_COUNT,			-- 16
			JOIN_REC.SRC_BATCH_CREATION_STATION_ID,	-- 17
			JOIN_REC.SRC_ENVELOPE_DOCUMENT_COUNT,	-- 18
			JOIN_REC.SRC_DOC_CLASS,					-- 19
			JOIN_REC.SRC_FORM_TYPE,					-- 20
			JOIN_REC.SRC_DOC_TYPE,					-- 21
			JOIN_REC.SRC_DOC_PAGE_COUNT,			-- 22
			JOIN_REC.SRC_BATCH_CREATED_BY,			-- 23
			TO_DATE(JOIN_REC.SRC_ENVELOPE_RECEIVED_DATE,'YYYY-MM-DD'),	--  2020-06-16
			JOIN_REC.SRC_FAX_BATCH_SOURCE,			-- 25
			GV_PARENT_JOB_ID
			);

		GV_RECORD_INSERTED_COUNT := GV_RECORD_INSERTED_COUNT + 1;

		GV_PROCESSED_COUNT := GV_PROCESSED_COUNT + 1;

	EXCEPTION

        WHEN OTHERS THEN
--        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE '
--            ||JOIN_REC.SRC_DB_RECORD_NUM||' '
--            ||JOIN_REC.SRC_rowid||' '
--            ||JOIN_REC.target_rowid);

		GV_DRIVER_KEY_NUMBER  	:= 'SRC ROW_ID : '||JOIN_REC.SRC_ROWID;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_REPORTING_OLTP';
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_Maxdat_reporting';

		POST_ERROR;

	END INSERT_MAXDAT_REPORTING;

-----------------------------------------------------
PROCEDURE DELETE_MAXDAT_REPORTING IS
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

	END DELETE_MAXDAT_REPORTING;


-----------------------------------------------------
-----------------------------------------------------

END NYHIX_MFB_V2_MAXDAT_REPORTING_PKG;
/
show errors