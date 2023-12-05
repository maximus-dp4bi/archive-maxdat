# Update kettle.properties Dev Add
DB_RM_DOC_TRANS_SUMM_HOSTNAME=UVAADMMSQL02HIX.maxcorp.maximus
DB_RM_DOC_TRANS_SUMM_PORT=1433
DB_RM_DOC_TRANS_SUMM_INSTANCE=
DB_RM_DOC_TRANS_SUMM_DB=KofaxCentralDEV
DB_RM_DOC_TRANS_SUMM_USER=Kofax11_MAXDAT_ETL
DB_RM_DOC_TRANS_SUMM_PASSWORD=^HePp%&&781$$^

-----------------------------------------------------------------
# Update kettle.properties UAT Add
DB_RM_DOC_TRANS_SUMM_HOSTNAME=UVAATMMSQL04HIX.maxcorp.maximus
DB_RM_DOC_TRANS_SUMM_PORT=1433
DB_RM_DOC_TRANS_SUMM_INSTANCE=
DB_RM_DOC_TRANS_SUMM_DB=KofaxCentralUAT
DB_RM_DOC_TRANS_SUMM_USER=Kofax11_MAXDAT_ETL
DB_RM_DOC_TRANS_SUMM_PASSWORD=^HePp%&&781$$^

------------------------------------------------------------------
# Update kettle.properties PRD Add
DB_RM_DOC_TRANS_SUMM_HOSTNAME=UVAAPMMSQL06HIX.maxcorp.maximus
DB_RM_DOC_TRANS_SUMM_PORT=1433
DB_RM_DOC_TRANS_SUMM_INSTANCE=
DB_RM_DOC_TRANS_SUMM_DB=KofaxCentralPrd
DB_RM_DOC_TRANS_SUMM_USER=Kofax11_MAXDAT_ETL
DB_RM_DOC_TRANS_SUMM_PASSWORD=HePp%&&781$$

-------------------------------------------------------------------
--Create db table RM_Document_Transaction_Summary
Create table maxdat.RM_Document_Transaction_Summary(
	function_name varchar2(50) NULL,
	mailroom_received_dt varchar2(50) NULL,
	insertts varchar2(50) NULL,
	request_receiveddate varchar2(50) NULL,
	ecn varchar2(50) NULL,
	response_code varchar2(50) NULL,
	step_name varchar2(50) NULL,
	batch_name varchar2(50) NULL,
	uuid varchar2(50) NULL,
	pdf_name varchar2(50) NULL
);

CREATE INDEX MAXDAT.IDX1_RM_Doc_Trans_summ_fn ON MAXDAT.RM_Document_Transaction_Summary (function_name);
CREATE INDEX MAXDAT.IDX2_RM_Doc_Trans_summ_ecn ON MAXDAT.RM_Document_Transaction_Summary (ecn);
CREATE INDEX MAXDAT.IDX3_RM_Doc_Trans_summ_it ON MAXDAT.RM_Document_Transaction_Summary (insertts);
CREATE INDEX MAXDAT.IDX4_RM_Doc_Trans_summ_rc ON MAXDAT.RM_Document_Transaction_Summary (response_code);
CREATE INDEX MAXDAT.IDX5_RM_Doc_Trans_summ_sn ON MAXDAT.RM_Document_Transaction_Summary (step_name);
CREATE INDEX MAXDAT.IDX6_RM_Doc_Trans_summ_bn ON MAXDAT.RM_Document_Transaction_Summary (batch_name);
CREATE INDEX MAXDAT.IDX7_RM_Doc_Trans_summ_uid ON MAXDAT.RM_Document_Transaction_Summary (uuid);


  GRANT SELECT ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_READ_ONLY;
  GRANT DELETE ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_OLTP_SIUD;
  GRANT SELECT ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_OLTP_SIUD;
  GRANT UPDATE ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_OLTP_SIU;
  GRANT SELECT ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_OLTP_SIU;
  GRANT UPDATE ON MAXDAT.RM_Document_Transaction_Summary TO MAXDAT_OLTP_SIU;

-------------------------------------------------------------------
--Create db table RM_Document_Transaction_Summary_OLTP
Create table maxdat.RM_Document_Transaction_Summary_OLTP(
	function_name varchar2(50) NULL,
	mailroom_received_dt varchar2(50) NULL,
	insertts varchar2(50) NULL,
	request_receiveddate varchar2(50) NULL,
	ecn varchar2(50) NULL,
	response_code varchar2(50) NULL,
	step_name varchar2(50) NULL,
	batch_name varchar2(50) NULL,
	uuid varchar2(50) NULL,
	pdf_name varchar2(50) NULL
);

CREATE INDEX MAXDAT.IDX1_RM_Doc_Trans_summ_OLTP_fn ON MAXDAT.RM_Document_Transaction_Summary_OLTP (function_name);
CREATE INDEX MAXDAT.IDX2_RM_Doc_Trans_summ_OLTP_ecn ON MAXDAT.RM_Document_Transaction_Summary_OLTP (ecn);
CREATE INDEX MAXDAT.IDX3_RM_Doc_Trans_summ_OLTP_it ON MAXDAT.RM_Document_Transaction_Summary_OLTP (insertts);
CREATE INDEX MAXDAT.IDX4_RM_Doc_Trans_summ_OLTP_rc ON MAXDAT.RM_Document_Transaction_Summary_OLTP (response_code);
CREATE INDEX MAXDAT.IDX5_RM_Doc_Trans_summ_OLTP_sn ON MAXDAT.RM_Document_Transaction_Summary_OLTP (step_name);
CREATE INDEX MAXDAT.IDX6_RM_Doc_Trans_summ_OLTP_bn ON MAXDAT.RM_Document_Transaction_Summary_OLTP (batch_name);
CREATE INDEX MAXDAT.IDX7_RM_Doc_Trans_summ_OLTP_uid ON MAXDAT.RM_Document_Transaction_Summary_OLTP (uuid);


  GRANT SELECT ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_READ_ONLY;
  GRANT DELETE ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT SELECT ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT UPDATE ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_OLTP_SIU;
  GRANT SELECT ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_OLTP_SIU;
  GRANT UPDATE ON MAXDAT.RM_Document_Transaction_Summary_OLTP TO MAXDAT_OLTP_SIU;
  
-------------------------------------------------------------------
--Create db view RM_Doc_Transaction_Summary_SV
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT"."RM_DOC_TRANSACTION_SUMMARY_SV" ("FUNCTION_NAME", "MAILROOM_RECEIVED_DT", "INSERTTS", "REQUEST_RECEIVEDDATE", "ECN", "RESPONSE_CODE", "STEP_NAME", "BATCH_NAME", "UUID", "PDF_NAME") AS 
  select 
    function_name,
	to_date(substr(mailroom_received_dt,1,10),'yyyy-mm-dd') mailroom_received_dt,
	to_date(insertts, 'yyyy-mm-dd hh24:mi:ss') insertts,
	to_date(request_receiveddate, 'yyyy-mm-dd hh24:mi:ss') request_receiveddate,
	ecn,
	response_code,
	step_name,
	batch_name,
	uuid,
	pdf_name
 from MAXDAT.RM_Document_Transaction_Summary;


  GRANT SELECT ON "MAXDAT"."RM_DOC_TRANSACTION_SUMMARY_SV" TO "MAXDAT_READ_ONLY";
  GRANT SELECT ON "MAXDAT"."RM_DOC_TRANSACTION_SUMMARY_SV" TO "MAXDAT_OLTP_SIUD";
  GRANT SELECT ON "MAXDAT"."RM_DOC_TRANSACTION_SUMMARY_SV" TO "MAXDAT_OLTP_SIU";

-------------------------------------------------------------------  
-- Create table EnvelopeStats 
CREATE TABLE maxdat.EnvelopeStats(
	id varchar2(10) NULL,
	imagetrust_batch_name varchar2(100) NULL,
	ecn varchar2(50) NULL,
	envlope_batch_name varchar2(50) NULL,
	envelope_count int NULL,
	batch_create_dt varchar2(50) NULL,
	insert_dt varchar2(50) NULL,
	batch_class varchar2(50) NULL,
	dcn varchar2(50) NULL
);
CREATE INDEX MAXDAT.IDX1_EnvelopeStats_id ON MAXDAT.EnvelopeStats (id);
CREATE INDEX MAXDAT.IDX2_EnvelopeStats_ecn ON MAXDAT.EnvelopeStats (ecn);
CREATE INDEX MAXDAT.IDX3_EnvelopeStats_it ON MAXDAT.EnvelopeStats (insert_dt);
CREATE INDEX MAXDAT.IDX4_EnvelopeStats_ebn ON MAXDAT.EnvelopeStats (envlope_batch_name);
CREATE INDEX MAXDAT.IDX5_EnvelopeStats_bcd ON MAXDAT.EnvelopeStats (batch_create_dt);
CREATE INDEX MAXDAT.IDX6_EnvelopeStats_ibn ON MAXDAT.EnvelopeStats (imagetrust_batch_name);
CREATE INDEX MAXDAT.IDX7_EnvelopeStats_dcn ON MAXDAT.EnvelopeStats (dcn);


  GRANT SELECT ON MAXDAT.EnvelopeStats TO MAXDAT_READ_ONLY;
  GRANT DELETE ON MAXDAT.EnvelopeStats TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.EnvelopeStats TO MAXDAT_OLTP_SIUD;
  GRANT SELECT ON MAXDAT.EnvelopeStats TO MAXDAT_OLTP_SIUD;
  GRANT UPDATE ON MAXDAT.EnvelopeStats TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.EnvelopeStats TO MAXDAT_OLTP_SIU;
  GRANT SELECT ON MAXDAT.EnvelopeStats TO MAXDAT_OLTP_SIU;
  GRANT UPDATE ON MAXDAT.EnvelopeStats TO MAXDAT_OLTP_SIU;

-------------------------------------------------------------------  
-- Create table EnvelopeStats_OLTP 
CREATE TABLE maxdat.EnvelopeStats_OLTP(
	id varchar2(10) NULL,
	imagetrust_batch_name varchar2(100) NULL,
	ecn varchar2(50) NULL,
	envlope_batch_name varchar2(50) NULL,
	envelope_count int NULL,
	batch_create_dt varchar2(50) NULL,
	insert_dt varchar2(50) NULL,
	batch_class varchar2(50) NULL,
	dcn varchar2(50) NULL
);
CREATE INDEX MAXDAT.IDX1_EnvelopeStats_OLTP_id ON MAXDAT.EnvelopeStats_OLTP (id);
CREATE INDEX MAXDAT.IDX2_EnvelopeStats_OLTP_ecn ON MAXDAT.EnvelopeStats_OLTP (ecn);
CREATE INDEX MAXDAT.IDX3_EnvelopeStats_OLTP_it ON MAXDAT.EnvelopeStats_OLTP (insert_dt);
CREATE INDEX MAXDAT.IDX4_EnvelopeStats_OLTP_ebn ON MAXDAT.EnvelopeStats_OLTP (envlope_batch_name);
CREATE INDEX MAXDAT.IDX5_EnvelopeStats_OLTP_bcd ON MAXDAT.EnvelopeStats_OLTP (batch_create_dt);
CREATE INDEX MAXDAT.IDX6_EnvelopeStats_OLTP_ibn ON MAXDAT.EnvelopeStats_OLTP (imagetrust_batch_name);
CREATE INDEX MAXDAT.IDX7_EnvelopeStats_OLTP_dcn ON MAXDAT.EnvelopeStats_OLTP (dcn);


  GRANT SELECT ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_READ_ONLY;
  GRANT DELETE ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT SELECT ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT UPDATE ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_OLTP_SIU;
  GRANT SELECT ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_OLTP_SIU;
  GRANT UPDATE ON MAXDAT.EnvelopeStats_OLTP TO MAXDAT_OLTP_SIU;

-------------------------------------------------------------------
--Create db view EnvelopeStats_SV
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT"."EnvelopeStats_SV" ("id",	"imagetrust_batch_name", "ecn",	"envlope_batch_name", "envelope_count", "batch_create_dt", "insert_dt", "batch_class", "dcn") AS
select
	id,
	imagetrust_batch_name,
	ecn,
	envlope_batch_name,
	envelope_count,
	to_date(batch_create_dt, 'yyyy-mm-dd hh24:mi:ss') batch_create_dt,
	insert_dt,
	batch_class,
	dcn
from maxdat.EnvelopeStats;
 
  GRANT SELECT ON "MAXDAT"."EnvelopeStats_SV" TO "MAXDAT_READ_ONLY";
  GRANT SELECT ON "MAXDAT"."EnvelopeStats_SV" TO "MAXDAT_OLTP_SIUD";
  GRANT SELECT ON "MAXDAT"."EnvelopeStats_SV" TO "MAXDAT_OLTP_SIU";

 
-------------------------------------------------------------------
-- Insert corp_etl_control rows for rm_document_transaction_summary run 
INSERT INTO maxdat.corp_etl_control (
name,
value_type,
value,
description
) VALUES (
'MFB_V2_RM_DOC_TRANS_SUMMARY_RUN_FLAG',
'V',
'Y',
'Signal to run RM_Document_Transaction_Summary'
);

insert into maxdat.corp_etl_control (
name,
value_type,
value,
description
) values (
'MFB_V2_RM_DOC_TRANS_SUMMARY_LAST_UPDATE_DATE',
'D',
'2023-01-01 00:00:00',
'Last insertts for RM_DOC_TRANS_SUMMARY FORMAT YYYY-MM-DD hh24:mi:ss'
);

commit;

-------------------------------------------------------------------
-- Insert corp_etl_control rows for EnveloprStats run 
INSERT INTO maxdat.corp_etl_control (
name,
value_type,
value,
description
) VALUES (
'MFB_V2_ENVELOPESTATS_RUN_FLAG',
'V',
'Y',
'Signal to run EnvelopeStats'
);

insert into maxdat.corp_etl_control (
name,
value_type,
value,
description
) values (
'MFB_V2_ENVELOPESTATS_LAST_UPDATE_DATE',
'D',
'2023-01-01 00:00:00',
'Last insertts for ENVELOPESTATS FORMAT YYYY-MM-SS hh24:mi:ss'
);

commit;
-------------------------------------------------------------------
--Create NYHIX_MFB_V2_RM_DOC_TRANS_SUMM Pkg Head
create or replace Package NYHIX_MFB_V2_RM_DOC_TRANS_SUMM_PKG AS

    Procedure Insert_Load_RM_DOC_TRANS_SUMM;
    Procedure Update_Load_RM_DOC_TRANS_SUMM;
    Procedure Delete_Load_RM_DOC_TRANS_SUMM;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_Load_RM_DOC_TRANS_SUMM ( p_rm_id varchar2 default 'a');

END NYHIX_MFB_V2_RM_DOC_TRANS_SUMM_PKG;

-------------------------------------------------------------------
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

-------------------------------------------------------------------
--Create NYHIX_MFB_V2_ENVELOPESTATS Pkg Head
create or replace Package NYHIX_MFB_V2_ENVELOPESTATS_PKG AS

    Procedure Insert_Load_ENVELOPESTATS;
    Procedure Update_Load_ENVELOPESTATS;
    Procedure Delete_Load_ENVELOPESTATS;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_Load_ENVELOPESTATS ( p_rm_id varchar2 default 'a');

END NYHIX_MFB_V2_ENVELOPESTATS_PKG;

-------------------------------------------------------------------
--Create NYHIX_MFB_V2_RM_DOC_TRANS_SUMM Pkg Body
create or replace PACKAGE BODY NYHIX_MFB_V2_ENVELOPESTATS_PKG AS

	-- USED FOR THE CORP_ETL_ERROR_LOG
	GV_PARENT_RM_ID          	varchar2(50)		:= null;
	GV_ERROR_CODE				VARCHAR2(50)		:= NULL;
	GV_ERROR_MESSAGE			VARCHAR2(4000)		:= NULL;
	GV_ERROR_FIELD				VARCHAR2(400)		:= NULL;
	GV_ERROR_CODES				VARCHAR2(400)		:= NULL;
	GV_ERR_DATE					DATE				:= SYSDATE;
	GV_ERR_LEVEL				VARCHAR2(20)		:= 'CRITICAL';
	GV_PROCESS_NAME				VARCHAR2(120)		:= 'EnvelopeStats';
	GV_RM_NAME					VARCHAR2(120)		:= '';
	GV_DRIVER_TABLE_NAME  		VARCHAR2(100 BYTE)	:= 'EnvelopeStats';
	GV_DRIVER_KEY_NUMBER  		VARCHAR2(100 BYTE)	:= NULL;
	GV_NR_OF_ERROR        		NUMBER				:= 0;
    GV_UPDATE_TS                DATE                := SYSDATE;

	-- USED FOR THE CORP_ETL_JOB_STATISTICS
	GV_RM_ID                 	NUMBER              := 0;
	GV_JOB_STATUS_CD          	VARCHAR2(20 BYTE)   := 'STARTED';
	GV_FILE_NAME              	VARCHAR2(512 BYTE)	:= 'EnvelopeStats';
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
		SRC.imagetrust_batch_name       AS SRC_imagetrust_batch_name,  	-- 1 	1	
		SRC.envlope_batch_name         	AS SRC_envlope_batch_name,   	-- 1 	2
		SRC.envelope_count         		AS SRC_envelope_count,    		-- 1 	3
		SRC.batch_create_dt         	AS SRC_batch_create_dt,    		-- 1 	4
		SRC.ecn         				AS SRC_ecn,      				-- 1 	5
		SRC.insert_dt         			AS SRC_insert_dt,				-- 1 	6
		SRC.batch_class         		AS SRC_batch_class,       		-- 1 	7
		SRC.dcn         				AS SRC_dcn,  					-- 1 	8
		SRC.id         					AS SRC_id       				-- 1 	9
	FROM MAXDAT.EnvelopeStats_OLTP SRC
	),
	TARGET AS
	(
	SELECT 
		ROWID    						AS TARGET_ROWID,
		TARGET.imagetrust_batch_name    AS TARGET_imagetrust_batch_name,  	-- 1 	1	
		TARGET.envlope_batch_name       AS TARGET_envlope_batch_name,   	-- 1 	2
		TARGET.envelope_count         	AS TARGET_envelope_count,    		-- 1 	3
		TARGET.batch_create_dt         	AS TARGET_batch_create_dt,    		-- 1 	4
		TARGET.ecn         				AS TARGET_ecn,      				-- 1 	5
		TARGET.insert_dt         		AS TARGET_insert_dt,				-- 1 	6
		TARGET.batch_class         		AS TARGET_batch_class,       		-- 1 	7
		TARGET.dcn         				AS TARGET_dcn,  					-- 1 	8
		TARGET.id         				AS TARGET_id        				-- 1 	9
	  FROM MAXDAT.EnvelopeStats TARGET
	)
	SELECT 
	--	SRC_ROWID,
		TARGET_ROWID,
		-- insert SQL from 3 and 4 here
                              SRC_imagetrust_batch_name,  	    			-- 3 	1
                              SRC_envlope_batch_name,   	  	    		-- 3 	2
                              SRC_envelope_count,    		    			-- 3 	3
                              SRC_batch_create_dt,    		       			-- 3 	4
                              SRC_ecn,      					    		-- 3 	5
                              SRC_insert_dt,					    		-- 3 	6
                              SRC_batch_class,       		    			-- 3 	7
                              SRC_dcn,  					    			-- 3 	8
                              SRC_id,       					    		-- 3 	9
                              TARGET_imagetrust_batch_name,					-- 4 	1
                              TARGET_envlope_batch_name,    				-- 4 	2
                              TARGET_envelope_count,    		 			-- 4 	3
                              TARGET_batch_create_dt,    	  	 			-- 4 	4
                              TARGET_ecn,      			 					-- 4 	5
                              TARGET_insert_dt,			 					-- 4 	6
                              TARGET_batch_class,       		 			-- 4 	7
                              TARGET_dcn,  					 				-- 4 	8
                              TARGET_id        				 				-- 4 	9
	FROM SRC
	LEFT OUTER JOIN TARGET
	ON SRC.SRC_id = TARGET.TARGET_id;

-----------------------------------------------------

	JOIN_REC   JOIN_CSR%ROWTYPE;

-----------------------------------------------------
PROCEDURE Load_Load_ENVELOPESTATS (P_RM_ID varchar2 default 'a') 
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

			IF JOIN_REC.SRC_id IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN Update_Load_ENVELOPESTATS;
			ELSIF JOIN_REC.SRC_id IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NULL 
                --then null;
				THEN Insert_Load_ENVELOPESTATS;
			ELSIF JOIN_REC.SRC_id IS NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN DELETE_Load_ENVELOPESTATS;
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
				'SRC_id: '||JOIN_REC.SRC_id
				||' TARGET_id: '||JOIN_REC.TARGET_id
				||'SQLCODE '||GV_ERROR_CODE
				||' '||GV_ERROR_MESSAGE);

			ROLLBACK;

			RAISE;

END Load_Load_ENVELOPESTATS;

-----------------------------------------------------

-----------------------------------------------------
PROCEDURE UPDATE_Load_ENVELOPESTATS IS
-- USES SQL FROM 5 AND 6
-----------------------------------------------------

	BEGIN

	-- COMPARE
		IF 1=2
            OR NVL(JOIN_REC.TARGET_imagetrust_batch_name, 	 '-?93333')	 	<>  	NVL(JOIN_REC.SRC_imagetrust_batch_name,'-?93333')	-- 5 	1	VARCHAR2
            OR NVL(JOIN_REC.TARGET_envlope_batch_name, 		 '-?93333')	  	<>  	NVL(JOIN_REC.SRC_envlope_batch_name,   '-?93333')	-- 5 	2	VARCHAR2
            OR NVL(JOIN_REC.TARGET_envelope_count, 			 '-?93333')	  	<>  	NVL(JOIN_REC.SRC_envelope_count,       '-?93333')	-- 5 	3	VARCHAR2
            OR NVL(JOIN_REC.TARGET_batch_create_dt,	 		 '-?93333')	  	<>  	NVL(JOIN_REC.SRC_batch_create_dt,      '-?93333')	-- 5 	4	VARCHAR2
            OR NVL(JOIN_REC.TARGET_ecn,      			 	 '-?93333') 	<>  	NVL(JOIN_REC.SRC_ecn,      			   '-?93333')	-- 5 	5	VARCHAR2
            OR NVL(JOIN_REC.TARGET_insert_dt,			 	 '-?93333')	  	<>  	NVL(JOIN_REC.SRC_insert_dt,			   '-?93333')	-- 5 	6	VARCHAR2
            OR NVL(JOIN_REC.TARGET_batch_class,       	 	 '-?93333')	  	<>  	NVL(JOIN_REC.SRC_batch_class,          '-?93333')	-- 5 	7	VARCHAR2
            OR NVL(JOIN_REC.TARGET_dcn,  					 '-?93333')	  	<>  	NVL(JOIN_REC.SRC_dcn,  				   '-?93333')	-- 5 	8	VARCHAR2
            OR NVL(JOIN_REC.TARGET_id,        				 '-?93333')	  	<>  	NVL(JOIN_REC.SRC_id,       			   '-?93333')	-- 5 	9	VARCHAR2
			THEN
		UPDATE MAXDAT.ENVELOPESTATS
		SET  
            imagetrust_batch_name  	=  JOIN_REC.SRC_imagetrust_batch_name,-- 6 	1
            envlope_batch_name      =  JOIN_REC.SRC_envlope_batch_name,   -- 6 	2
            envelope_count       	=  JOIN_REC.SRC_envelope_count,       -- 6 	3
            batch_create_dt         =  JOIN_REC.SRC_batch_create_dt,      -- 6 	4
            ecn      			   	=  JOIN_REC.SRC_ecn,      			   -- 6 	5
            insert_dt			   	=  JOIN_REC.SRC_insert_dt,			   -- 6 	6
            batch_class          	=  JOIN_REC.SRC_batch_class,          -- 6 	7
            dcn  				   	=  JOIN_REC.SRC_dcn,  				   -- 6 	8
            id       			   	=  JOIN_REC.SRC_id       			   -- 6 	9
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
		GV_DRIVER_TABLE_NAME  	:= 'MAXDAT.ENVELOPESTATS_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'UPDATE_Load_ENVELOPESTATS';

		POST_ERROR;

	END UPDATE_Load_ENVELOPESTATS;	

-----------------------------------------------------
PROCEDURE INSERT_Load_ENVELOPESTATS IS
-- USES SQL  FROM 7 AND 8
-----------------------------------------------------

	BEGIN

		INSERT INTO MAXDAT.ENVELOPESTATS
		(   
            imagetrust_batch_name,  	-- 7 	1
            envlope_batch_name,         -- 7 	2
            envelope_count,       		-- 7 	3
            batch_create_dt ,           -- 7 	4
            ecn,      			  		-- 7 	5
            insert_dt,			   		-- 7 	6
            batch_class,         		-- 7 	7
            dcn, 				  		-- 7 	8
            id       			  		-- 7 	9
			)
		VALUES (
            JOIN_REC.SRC_imagetrust_batch_name, -- 8 	1
            JOIN_REC.SRC_envlope_batch_name,    -- 8 	2
            JOIN_REC.SRC_envelope_count,        -- 8 	3
            JOIN_REC.SRC_batch_create_dt,       -- 8 	4
            JOIN_REC.SRC_ecn,      			   -- 8 	5
            JOIN_REC.SRC_insert_dt,			   -- 8 	6
            JOIN_REC.SRC_batch_class,           -- 8 	7
            JOIN_REC.SRC_dcn,  				   -- 8 	8
            JOIN_REC.SRC_id       			   -- 8 	9
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
		GV_DRIVER_KEY_NUMBER  	:= 'SRC id : '||JOIN_REC.SRC_id;
		GV_DRIVER_TABLE_NAME  	:= 'MAXDAT.ENVELOPESTATS_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Load_ENVELOPESTATS';

		POST_ERROR;

	END INSERT_Load_ENVELOPESTATS;	

-----------------------------------------------------
PROCEDURE DELETE_Load_ENVELOPESTATS IS
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

	END DELETE_Load_ENVELOPESTATS;	


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

--	GV_JOB_NAME		:= 'ENVELOPESTATS';	

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

END NYHIX_MFB_V2_ENVELOPESTATS_PKG;