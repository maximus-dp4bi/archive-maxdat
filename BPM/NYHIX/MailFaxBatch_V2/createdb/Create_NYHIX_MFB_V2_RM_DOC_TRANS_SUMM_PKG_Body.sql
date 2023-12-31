--Create NYHIX_MFB_V2_RM_DOC_TRANS_SUMM Pkg Body
create or replace PACKAGE BODY NYHIX_MFB_V2_RM_DOC_TRANS_SUMM_PKG AS

	-- USED FOR THE CORP_ETL_ERROR_LOG
	GV_PARENT_RM_ID          	varchar2(50)		:= null;
	GV_ERROR_CODE				VARCHAR2(50)		:= NULL;
	GV_ERROR_MESSAGE			VARCHAR2(4000)		:= NULL;
	GV_ERROR_FIELD				VARCHAR2(400)		:= NULL;
	GV_ERROR_CODES				VARCHAR2(400)		:= NULL;
	GV_ERR_DATE					DATE				:= SYSDATE;
	GV_ERR_LEVEL				VARCHAR2(20)		:= 'CRITICAL';
	GV_PROCESS_NAME				VARCHAR2(120)		:= 'RM_Document_Transaction_Summary';
	GV_RM_NAME					VARCHAR2(120)		:= '';
	GV_DRIVER_TABLE_NAME  		VARCHAR2(100 BYTE)	:= 'RM_Document_Transaction_Summary';
	GV_DRIVER_KEY_NUMBER  		VARCHAR2(100 BYTE)	:= NULL;
	GV_NR_OF_ERROR        		NUMBER				:= 0;
    GV_UPDATE_TS                DATE                := SYSDATE;

	-- USED FOR THE CORP_ETL_JOB_STATISTICS
	GV_RM_ID                 	NUMBER              := 0;
	GV_JOB_STATUS_CD          	VARCHAR2(20 BYTE)   := 'STARTED';
	GV_FILE_NAME              	VARCHAR2(512 BYTE)	:= 'RM_Document_Transaction_Summary';
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
		SRC.function_name         			AS SRC_function_name,   		-- 1 	1
		SRC.mailroom_received_dt         	AS SRC_mailroom_received_dt,   	-- 1 	2
		SRC.insertts         				AS SRC_insertts,    			-- 1 	3
		SRC.request_receiveddate         	AS SRC_request_receiveddate,    -- 1 	4
		SRC.ecn         					AS SRC_ecn,      				-- 1 	5
		SRC.response_code         			AS SRC_response_code,			-- 1 	6
		SRC.step_name         				AS SRC_step_name,       		-- 1 	7
		SRC.batch_name         				AS SRC_batch_name,  			-- 1 	8
		SRC.uuid         					AS SRC_uuid,       				-- 1 	9
		SRC.pdf_name         				AS SRC_pdf_name       			-- 1 	10
	FROM MAXDAT.RM_Document_Transaction_Summary_OLTP SRC
	),
	TARGET AS
	(
	SELECT 
		ROWID    						        AS TARGET_ROWID,
		TARGET.function_name         			AS TARGET_function_name,   			-- 1 	1
		TARGET.mailroom_received_dt         	AS TARGET_mailroom_received_dt,   	-- 1 	2
		TARGET.insertts         				AS TARGET_insertts,    				-- 1 	3
		TARGET.request_receiveddate         	AS TARGET_request_receiveddate,    	-- 1 	4
		TARGET.ecn         						AS TARGET_ecn,      				-- 1 	5
		TARGET.response_code         			AS TARGET_response_code,			-- 1 	6
		TARGET.step_name         				AS TARGET_step_name,       			-- 1 	7
		TARGET.batch_name         				AS TARGET_batch_name,  				-- 1 	8
		TARGET.uuid         					AS TARGET_uuid,       				-- 1 	9
		TARGET.pdf_name         				AS TARGET_pdf_name       			-- 1 	10
	  FROM MAXDAT.RM_Document_Transaction_Summary TARGET
	)
	SELECT 
	--	SRC_ROWID,
		TARGET_ROWID,
		-- insert SQL from 3 and 4 here
                              SRC_function_name,   		    			-- 3 	1
                              SRC_mailroom_received_dt,   	    		-- 3 	2
                              SRC_insertts,    			    			-- 3 	3
                              SRC_request_receiveddate,        			-- 3 	4
                              SRC_ecn,      				    		-- 3 	5
                              SRC_response_code,			    		-- 3 	6
                              SRC_step_name,       		    			-- 3 	7
                              SRC_batch_name,  			    			-- 3 	8
                              SRC_uuid,       				    		-- 3 	9
                              SRC_pdf_name,       			    		-- 3 	10
                              TARGET_function_name,   					-- 4 	1
                              TARGET_mailroom_received_dt,   			-- 4 	2
                              TARGET_insertts,    				 		-- 4 	3
                              TARGET_request_receiveddate,    	 		-- 4 	4
                              TARGET_ecn,      				 			-- 4 	5
                              TARGET_response_code,			 			-- 4 	6
                              TARGET_step_name,       			 		-- 4 	7
                              TARGET_batch_name,  				 		-- 4 	8
                              TARGET_uuid,       				 		-- 4 	9
                              TARGET_pdf_name       			 		-- 4 	10
	FROM SRC
	LEFT OUTER JOIN TARGET
	ON SRC.SRC_uuid = TARGET.TARGET_uuid;

-----------------------------------------------------

	JOIN_REC   JOIN_CSR%ROWTYPE;

-----------------------------------------------------
PROCEDURE Load_Load_RM_DOC_TRANS_SUMM (P_RM_ID varchar2 default 'a') 
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

		GV_PARENT_RM_ID := P_RM_ID;

		GV_RM_ID 	:= SEQ_JOB_ID.NEXTVAL;

        GV_RM_NAME	:= GV_PROCESS_NAME;			

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

			IF JOIN_REC.SRC_uuid IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN Update_Load_RM_DOC_TRANS_SUMM;
			ELSIF JOIN_REC.SRC_uuid IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NULL 
                --then null;
				THEN Insert_Load_RM_DOC_TRANS_SUMM;
			ELSIF JOIN_REC.SRC_uuid IS NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN DELETE_Load_RM_DOC_TRANS_SUMM;
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
				'SRC_uuid: '||JOIN_REC.SRC_uuid
				||' TARGET_uuid: '||JOIN_REC.TARGET_uuid
				||'SQLCODE '||GV_ERROR_CODE
				||' '||GV_ERROR_MESSAGE);

			ROLLBACK;

			RAISE;

END Load_Load_RM_DOC_TRANS_SUMM;

-----------------------------------------------------

-----------------------------------------------------
PROCEDURE UPDATE_Load_RM_DOC_TRANS_SUMM IS
-- USES SQL FROM 5 AND 6
-----------------------------------------------------

	BEGIN

	-- COMPARE
		IF 1=2
            OR NVL(JOIN_REC.TARGET_function_name, '-?93333')	  		<>  	NVL(JOIN_REC.SRC_function_name, '-?93333')			-- 5 	1	VARCHAR2
            OR NVL(JOIN_REC.TARGET_mailroom_received_dt, '-?93333')	  	<>  	NVL(JOIN_REC.SRC_mailroom_received_dt, '-?93333')	-- 5 	2	VARCHAR2
            OR NVL(JOIN_REC.TARGET_insertts,'-?93333')	  				<>  	NVL(JOIN_REC.SRC_insertts,'-?93333')				-- 5 	3	VARCHAR2
            OR NVL(JOIN_REC.TARGET_request_receiveddate, '-?93333')	  	<>  	NVL(JOIN_REC.SRC_request_receiveddate, '-?93333')	-- 5 	4	VARCHAR2
            OR NVL(JOIN_REC.TARGET_ecn,'-?93333') 						<>  	NVL(JOIN_REC.SRC_ecn,'-?93333')						-- 5 	5	VARCHAR2
            OR NVL(JOIN_REC.TARGET_response_code, '-?93333')	  		<>  	NVL(JOIN_REC.SRC_response_code, '-?93333')			-- 5 	6	VARCHAR2
            OR NVL(JOIN_REC.TARGET_step_name, '-?93333')	  			<>  	NVL(JOIN_REC.SRC_step_name, '-?93333')				-- 5 	7	VARCHAR2
            OR NVL(JOIN_REC.TARGET_batch_name, '-?93333')	  			<>  	NVL(JOIN_REC.SRC_batch_name, '-?93333')				-- 5 	8	VARCHAR2
            OR NVL(JOIN_REC.TARGET_uuid, '-?93333')	  					<>  	NVL(JOIN_REC.SRC_uuid, '-?93333')					-- 5 	9	VARCHAR2
            OR NVL(JOIN_REC.TARGET_pdf_name,'-?93333')	  				<>  	NVL(JOIN_REC.SRC_pdf_name,'-?93333')				-- 5 	10	VARCHAR2
			THEN
		UPDATE MAXDAT.RM_Document_Transaction_Summary
		SET  
            function_name         	=  JOIN_REC.SRC_function_name,			-- 6 	1
            mailroom_received_dt    =  JOIN_REC.SRC_mailroom_received_dt,	-- 6 	2
            insertts         		=  JOIN_REC.SRC_insertts,				-- 6 	3
            request_receiveddate    =  JOIN_REC.SRC_request_receiveddate,	-- 6 	4
            ecn         			=  JOIN_REC.SRC_ecn,					-- 6 	5
            response_code      		=  JOIN_REC.SRC_response_code,			-- 6 	6
            step_name         		=  JOIN_REC.SRC_step_name,				-- 6 	7
            batch_name        		=  JOIN_REC.SRC_batch_name,				-- 6 	8
            uuid         			=  JOIN_REC.SRC_uuid,					-- 6 	9
            pdf_name         		=  JOIN_REC.SRC_pdf_name				-- 6 	10
			WHERE ROWID = JOIN_REC.TARGET_ROWID;

		GV_RECORD_UPDATED_COUNT := GV_RECORD_UPDATED_COUNT + 1;
		GV_PROCESSED_COUNT := GV_PROCESSED_COUNT + 1;

	ELSE
		NULL; -- NO UPDATE REQUIRED
	END IF;	

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('UPDATE FAILURE '
            ||JOIN_REC.SRC_ecn||' '
            --||JOIN_REC.SRC_rowid||' '
            ||JOIN_REC.target_rowid);

	--	GV_DRIVER_KEY_NUMBER  	:= 'SRC_ECN : '||JOIN_REC.ECN;
		GV_DRIVER_TABLE_NAME  	:= 'MAXDAT.RM_Document_Transaction_Summary_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'UPDATE_Load_RM_DOC_TRANS_SUMM';

		POST_ERROR;

	END UPDATE_Load_RM_DOC_TRANS_SUMM;	

-----------------------------------------------------
PROCEDURE INSERT_Load_RM_DOC_TRANS_SUMM IS
-- USES SQL  FROM 7 AND 8
-----------------------------------------------------

	BEGIN

		INSERT INTO MAXDAT.RM_Document_Transaction_Summary
		(   
            function_name,           		-- 7 	1
            mailroom_received_dt,          	-- 7 	2
            insertts,           			-- 7 	3
            request_receiveddate,          	-- 7 	4
            ecn,           					-- 7 	5
            response_code,           		-- 7 	6
            step_name,           			-- 7 	7
            batch_name,           			-- 7 	8
            uuid,           				-- 7 	9
            pdf_name           				-- 7 	10
			)
		VALUES (
            JOIN_REC.SRC_function_name,			 -- 8 	1
            JOIN_REC.SRC_mailroom_received_dt,	 -- 8 	2
            JOIN_REC.SRC_insertts,				 -- 8 	3
            JOIN_REC.SRC_request_receiveddate,	 -- 8 	4
            JOIN_REC.SRC_ecn,					 -- 8 	5
            JOIN_REC.SRC_response_code,			 -- 8 	6
            JOIN_REC.SRC_step_name,				 -- 8 	7
            JOIN_REC.SRC_batch_name,			 -- 8 	8
            JOIN_REC.SRC_uuid,					 -- 8 	9
            JOIN_REC.SRC_pdf_name				 -- 8 	10
			);

		GV_RECORD_INSERTED_COUNT := GV_RECORD_INSERTED_COUNT + 1;

		GV_PROCESSED_COUNT := GV_PROCESSED_COUNT + 1;

	EXCEPTION

        WHEN OTHERS THEN
--        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE '
--            ||JOIN_REC.SRC_uuid||' '
--            ||JOIN_REC.SRC_step_name||' '
--            ||JOIN_REC.target_BATCH_name);

        -- '${MFB_V2_REMOTE_START_DATE}'
		GV_DRIVER_KEY_NUMBER  	:= 'SRC uuid : '||JOIN_REC.SRC_uuid;
		GV_DRIVER_TABLE_NAME  	:= 'MAXDAT.RM_Document_Transaction_Summary_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Load_RM_DOC_TRANS_SUMM';

		POST_ERROR;

	END INSERT_Load_RM_DOC_TRANS_SUMM;	

-----------------------------------------------------
PROCEDURE DELETE_Load_RM_DOC_TRANS_SUMM IS
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
            ||JOIN_REC.SRC_ecn||' '
            ||JOIN_REC.target_ecn);

		Post_Error;

	END DELETE_Load_RM_DOC_TRANS_SUMM;	


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
		GV_RM_ID, 					-- JOB_ID 
		GV_RM_NAME, 				-- JOB_NAME 
		GV_JOB_START_DATE, 			-- JOB_START_DATE 
		GV_JOB_STATUS_CD, 			-- JOB_STATUS_CD 
		0, 							-- PARENT_JOB_ID 
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
		JOB_NAME              	= GV_RM_NAME,
		JOB_START_DATE        	= GV_JOB_START_DATE,
		JOB_STATUS_CD         	= GV_JOB_STATUS_CD,
		PARENT_JOB_ID         	= 0,
		PROCESSED_COUNT       	= GV_PROCESSED_COUNT,
		RECORD_COUNT          	= GV_RECORD_COUNT,
		RECORD_INSERTED_COUNT 	= GV_RECORD_INSERTED_COUNT,
		RECORD_UPDATED_COUNT  	= GV_RECORD_UPDATED_COUNT,
		WARNING_COUNT         	= GV_WARNING_COUNT
	WHERE  
		JOB_ID                = GV_RM_ID;	

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

--	GV_JOB_NAME		:= 'RM_Document_Transaction_Summary';	

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
		GV_RM_NAME,
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

END NYHIX_MFB_V2_RM_DOC_TRANS_SUMM_PKG;