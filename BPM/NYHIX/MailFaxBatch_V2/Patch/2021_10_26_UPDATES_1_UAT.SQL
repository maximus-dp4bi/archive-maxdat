-- ALTER THE TABLE

ALTER TABLE MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY DROP COLUMN STG_DONE_DATE;
ALTER TABLE MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY DROP COLUMN STG_EXTRACT_DATE;
ALTER TABLE MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY DROP COLUMN STG_LAST_UPDATE_DATE;
ALTER TABLE MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY DROP COLUMN STG_PROCESSED_DATE;
ALTER TABLE MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY DROP COLUMN UPDATED;

ALTER TABLE MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY
ADD (
MFB_V2_BI_ID					NUMBER,
AGE_IN_BUSINESS_DAYS            NUMBER(6),
AGE_IN_CALENDAR_DAYS            NUMBER(6),
TIMELINESS_STATUS               VARCHAR2(20 BYTE),
TIMELINESS_DAYS                 NUMBER(6),
TIMELINESS_DAYS_TYPE            VARCHAR2(2 BYTE),
TIMELINESS_DT                   DATE,
JEOPARDY_FLAG                   VARCHAR2(3 BYTE),
JEOPARDY_DAYS                   NUMBER(6),
JEOPARDY_DAYS_TYPE              VARCHAR2(2 BYTE),
JEOPARDY_DT                     DATE,
TARGET_DAYS                     NUMBER(6)
);

-- CREATE THE SQQUENCE
CREATE SEQUENCE  MAXDAT.SEQ_NYHIX_MFB_BATCH_SUMMARY_ID  
MINVALUE 1 
MAXVALUE 9999999999999999999999999999 
INCREMENT BY 1 
START WITH 100000 
CACHE 100 NOORDER  
NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;


GRANT SELECT ON MAXDAT.SEQ_NYHIX_MFB_BATCH_SUMMARY_ID TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON MAXDAT.SEQ_NYHIX_MFB_BATCH_SUMMARY_ID TO MAXDAT_OLTP_SIU;


-- ALTER THE TRIGGER
CREATE OR REPLACE TRIGGER 
MAXDAT.TRG_BIU_NYHIX_MFB_V2_BATCH_SUMMARY 
BEFORE INSERT OR UPDATE ON MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY
FOR EACH ROW
BEGIN
	IF INSERTING THEN
		:NEW.MFB_V2_CREATE_DATE := SYSDATE;
		:NEW.MFB_V2_UPDATE_DATE := NULL;
		:NEW.MFB_V2_BI_ID		:= SEQ_NYHIX_MFB_BATCH_SUMMARY_ID.NEXTVAL;
	END IF;

	IF UPDATING THEN
		:NEW.MFB_V2_CREATE_DATE := :OLD.MFB_V2_CREATE_DATE;
		:NEW.MFB_V2_UPDATE_DATE := SYSDATE;
	END IF;	
END;	

-- ALTER THE PLSQL PACKAGE
create or replace Package        NYHIX_MFB_V2_BATCH_SUMMARY_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


    Procedure Insert_BATCH_SUMMARY;
    Procedure Update_BATCH_SUMMARY;
    Procedure Delete_BATCH_SUMMARY;
	Procedure Load_BATCH_SUMMARY ( p_job_id number default 0);
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


END NYHIX_MFB_V2_BATCH_SUMMARY_PKG;
/

show errors
create or replace PACKAGE BODY        NYHIX_MFB_V2_BATCH_SUMMARY_PKG AS

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
-- 128 – Reserved, 
-- 512 - locked.

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
	
	-- Additionl Fields needed to match D_MFB_CURRENT
	
	GV_TIMELINESS_DAYS 			NUMBER; 			--<< From CORP_ETL_LIST_LKUP
	GV_TIMELINESS_DAYS_TYPE 	VARCHAR2(2 BYTE);   --<< From CORP_ETL_LIST_LKUP
	GV_JEOPARDY_DAYS 			NUMBER; 			--<< From CORP_ETL_LIST_LKUP
	GV_JEOPARDY_DAYS_TYPE 		VARCHAR2(2 BYTE); 	--<< From CORP_ETL_LIST_LKUP
	GV_TARGET_DAYS 				NUMBER;				--<< From CORP_ETL_LIST_LKUP

	GV_AGE_IN_BUSINESS_DAYS 	NUMBER; 			--<< Derived Once a day
	
	--GV_AGE_IN_CALENDAR_DAYS 	NUMBER; 			--<< Derived Once a day
	--GV_TIMELINESS_STATUS 		VARCHAR2(20 BYTE); 	--<< Derived Once a day
	--GV_TIMELINESS_DT 			DATE; 				--<< Derived Once a day
	--GV_JEOPARDY_FLAG 			VARCHAR2(3 BYTE); 	--<< Derived Once a day
	--GV_JEOPARDY_DT 				DATE; 				--<< Derived Once a day


	-------------------------------------------------------------------------------------------
	-- THIS IS THE DRIVING CURSOR  
	-- It selects a distinct list of any  BATCH_GUID 
	-- that was Inserted or Updated
	-- based on the Parent Job ID
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
    WHEN NO_DATA_FOUND THEN RAISE;
    WHEN OTHERS THEN RAISE;
END;

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
       GV_SRC_REC_SUMMARY.CEJS_JOB_ID := NULL;	  					-- 	73	NUMBER
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
    WHEN OTHERS THEN RAISE;
END;
-----------------------------------------------------

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

		GV_PARENT_JOB_ID := P_JOB_ID;

        -- GET VALUES FROM CORP_ETL_CONTROL
        Extract_CORP_ETL_CONTROL;

--		IF P_JOB_ID = 0
--		OR P_JOB_ID IS NULL
--		THEN 
--			GV_PARENT_JOB_ID := SEQ_JOB_ID.NEXTVAL;
--		END IF;
		
		GV_JOB_ID 	:= SEQ_JOB_ID.NEXTVAL;

        GV_JOB_NAME	:= GV_PROCESS_NAME||' Parent ID: '||GV_PARENT_JOB_ID||' - '||'Step NYHIX_MFB_V2_BATCH_SUMMARY';			

		Insert_Corp_ETL_Job_Statistics;


		IF (BATCH_GUID_CSR%ISOPEN)
		THEN
			CLOSE BATCH_GUID_CSR;
		END IF;

		OPEN BATCH_GUID_CSR;

		LOOP  -- Main Driving Loop

			FETCH BATCH_GUID_CSR INTO GV_SOURCE_SERVER, GV_BATCH_GUID_ID;

			EXIT WHEN BATCH_GUID_CSR%NOTFOUND;

			GV_RECORD_COUNT := GV_RECORD_COUNT+1;

--			DBMS_OUTPUT.PUT_LINE('Processing BATCH_GUID: '||GV_BATCH_GUID_ID);

			INITIALIZE_GV_SRC_REC_SUMMARY;

--			GV_SRC_REC_SUMMARY := NULL;
--			GV_TARGET_REC := NULL;

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
			IF TRUNC(GV_TARGET_REC.MFB_V2_UPDATE_DATE) <> TRUNC(SYSDATE)
			OR GV_PARENT_JOB_ID = 0
			THEN	
			-- Calculate the 'Derived' fields to match D_FMB_CURRENT ( v1 ) ???
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
				THEN INSERT_BATCH_SUMMARY();
            ELSIF GV_TARGET_ROWID IS NOT NULL
				AND GV_SRC_REC_SUMMARY.BATCH_GUID IS NOT NULL
				THEN UPDATE_BATCH_SUMMARY();
            ELSIF GV_TARGET_ROWID IS NOT NULL
				AND GV_SRC_REC_SUMMARY.BATCH_GUID IS NULL
				THEN DELETE_BATCH_SUMMARY();
			END IF;



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

-----------------------------------------------------
PROCEDURE UPDATE_BATCH_SUMMARY IS
PRAGMA AUTONOMOUS_TRANSACTION;
-----------------------------------------------------

	BEGIN

    IF GV_BATCH_GUID_ID = '{02c22dca-69d7-48e0-b2ce-66dfbe51e71c}'
	THEN
		DBMS_OUTPUT.PUT_LINE('START UPDATE BATCH_GUID_ID: '||GV_BATCH_GUID_ID);
		DBMS_OUTPUT.PUT_LINE('Start  GV_SRC_REC_SUMMARY.batch_guid '||NVL(GV_SRC_REC_SUMMARY.batch_guid,'NL'));
		dbms_output.put_line('Start  GV_SRC_REC_SUMMARY.Classification_DT '||NVL(TO_CHAR(GV_SRC_REC_SUMMARY.Classification_DT),'NL'));
		dbms_output.put_line('Start  GV_SRC_REC_SUMMARY.Recognition_DT '||NVL(TO_CHAR(GV_SRC_REC_SUMMARY.Recognition_DT),'NL'));
		dbms_output.put_line('Start  GV_SRC_REC_SUMMARY.Batch_Priority '||NVL(TO_CHAR(GV_SRC_REC_SUMMARY.Batch_Priority ),'NL'));
		

		DBMS_OUTPUT.PUT_LINE('Start  GV_TARGET_REC.batch_guid '||NVL(GV_TARGET_REC.batch_guid,'NL'));
		dbms_output.put_line('Start  GV_TARGET_REC.Classification_DT '||GV_TARGET_REC.Classification_DT);
		dbms_output.put_line('Start  GV_TARGET_REC.Recognition_DT '||GV_TARGET_REC.Recognition_DT);
		dbms_output.put_line('Start  GV_TARGET_REC.Batch_Priority '||GV_TARGET_REC.Batch_Priority );

    END IF; 		

	IF 1 = 2
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
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CEJS_JOB_ID),'?')	  				<>  	NVL(TO_CHAR(GV_TARGET_REC.CEJS_JOB_ID),'?')						-- 	73	NUMBER
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
			CEJS_JOB_ID 				= GV_SRC_REC_SUMMARY.CEJS_JOB_ID,    				--	73
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

		if GV_SRC_REC_SUMMARY.batch_guid = '{02c22dca-69d7-48e0-b2ce-66dfbe51e71c}'
		then 
			dbms_output.put_line('Pre  GV_SRC_REC_SUMMARY.Classification_DT '||NVL(GV_SRC_REC_SUMMARY.Classification_DT,'NULL'));
			dbms_output.put_line('Pre  GV_TARGET_REC.Classification_DT '||NVL(GV_TARGET_REC.Classification_DT,'NULL'));
			dbms_output.put_line('Pre  GV_SRC_REC_SUMMARY.Recognition_DT '||NVL(GV_SRC_REC_SUMMARY.Recognition_DT,'NULL'));
			dbms_output.put_line('Pre  GV_TARGET_REC.Recognition_DT '||NVL(GV_TARGET_REC.Recognition_DT,'NULL'));
		end if;	

    END IF;

    COMMIT;

	if GV_SRC_REC_SUMMARY.batch_guid = '{02c22dca-69d7-48e0-b2ce-66dfbe51e71c}'
	then 
		dbms_output.put_line('POST GV_SRC_REC_SUMMARY.Classification_DT '||NVL(GV_SRC_REC_SUMMARY.Classification_DT,'NL'));
		dbms_output.put_line('POST GV_TARGET_REC.Classification_DT '||NVL(GV_TARGET_REC.Classification_DT,'NL'));
		dbms_output.put_line('POST GV_SRC_REC_SUMMARY.Recognition_DT '||NVL(GV_SRC_REC_SUMMARY.Recognition_DT,'NL'));
		dbms_output.put_line('POST GV_TARGET_REC.Recognition_DT '||NVL(GV_TARGET_REC.Recognition_DT,'NL'));
	end if;	

	EXCEPTION

        WHEN OTHERS THEN

		GV_DRIVER_KEY_NUMBER  	:= 'SRC_REC.BATCH_GUID : '||GV_SRC_REC_SUMMARY.BATCH_GUID;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_STATS_BATCH_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_STATS_BATCH';

		POST_ERROR;

	END UPDATE_BATCH_SUMMARY;	

-----------------------------------------------------
PROCEDURE INSERT_BATCH_SUMMARY IS
PRAGMA AUTONOMOUS_TRANSACTION;
-----------------------------------------------------

	BEGIN

--    DBMS_OUTPUT.PUT_LINE('Inserting Batch_GUID: '||GV_SRC_REC_SUMMARY.BATCH_GUID);

	Insert into NYHIX_MFB_V2_BATCH_SUMMARY
	( 
        --MFB_V2_CREATE_DATE,
        --MFB_V2_UPDATE_DATE,
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
        CEJS_JOB_ID,
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
        --MFB_V2_CREATE_DATE,
        --MFB_V2_UPDATE_DATE,
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
        NVL(GV_SRC_REC_SUMMARY.CEJS_JOB_ID,0),
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
    GV_SRC_REC_SUMMARY.CEJS_JOB_ID := 0;
    GV_PARENT_JOB_ID := 0;


	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE '
            ||GV_SRC_REC_SUMMARY.BATCH_GUID||' '||SUBSTR(SQLERRM, 1, 3000));

        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE CEJS_JOB_ID '||GV_SRC_REC_SUMMARY.CEJS_JOB_ID);
        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE BATCH_PAGE_COUNT '||GV_SRC_REC_SUMMARY.BATCH_PAGE_COUNT);
        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE CANCEL_DT'||GV_SRC_REC_SUMMARY.CANCEL_DT);
        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE EXTERNAL_BATCH_ID '||GV_SRC_REC_SUMMARY.EXTERNAL_BATCH_ID);
        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE BATCH_ENVELOPE_COUNT '||GV_SRC_REC_SUMMARY.BATCH_ENVELOPE_COUNT);
        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE BATCH_DOC_COUNT '||GV_SRC_REC_SUMMARY.BATCH_DOC_COUNT);
        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE BATCH_PRIORITY '||GV_SRC_REC_SUMMARY.BATCH_PRIORITY);
        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE MFB_V2_PARENT_JOB_ID '||GV_SRC_REC_SUMMARY.MFB_V2_PARENT_JOB_ID);

        -- '${MFB_V2_REMOTE_START_DATE}'
--		GV_DRIVER_KEY_NUMBER  	:= 'SRC_REC.BATCH_GUID: '||GV_SRC_REC_SUMMARY.BATCH_GUID;
--		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_STATS_BATCH';	
--		GV_ERR_LEVEL		  	:= 'Warning';
--		GV_PROCESS_NAME 		:= 'Update_STATS_BATCH_Summary';

		POST_ERROR;

	END INSERT_BATCH_SUMMARY;	

-----------------------------------------------------
PROCEDURE DELETE_BATCH_SUMMARY IS
-- IF THE JOIN CURSOR USES A FULL OUTTER JOIN THEN 
-- THIS PROCEDURE CAN BE USED TO IDENTIFY
-- ROECORDS DELETED FROM THE SORCE SYSTEM
-----------------------------------------------------

	BEGIN

		NULL;

		GV_PROCESSED_COUNT := GV_PROCESSED_COUNT + 1;

	EXCEPTION

        WHEN OTHERS THEN

		Post_Error;

	END DELETE_BATCH_SUMMARY;	


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
--PRAGMA AUTONOMOUS_TRANSACTION;
-----------------------------------------------------
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
	DBMS_OUTPUT.PUT_LINE('Procedure Post_Error failed with '||GV_Error_Code||': '||GV_Error_Message);

	--RAISE;


END;

-----------------------------------------------------------------
    Procedure Extract_Target ( P_SOURCE_SERVER varchar DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS
	BEGIN
    -- NOTE THIS TABLE IS CENTRAL ONLY.. THE P_SOURCE_SERVER IS NOT NEEDED 
--		GV_TARGET_REC := NULL;

	SELECT 
		ROWID,
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
		CEJS_JOB_ID,
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
		GV_TARGET_REC.CEJS_JOB_ID,
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
	WHERE BATCH_GUID = p_Batch_GUID;

	--	DBMS_OUTPUT.PUT_LINE('Target BATCH_GUID : '||GV_BATCH_GUID_ID|| 'found');
	EXCEPTION
		WHEN NO_DATA_FOUND
			THEN
 --           DBMS_OUTPUT.PUT_LINE('Target BATCH_GUID : '||GV_BATCH_GUID_ID|| 'NOT found');
            GV_TARGET_ROWID := NULL;
			GV_TARGET_REC := NULL;
		WHEN OTHERS THEN
			RAISE;
	End;

-----------------------------------------------------------------
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
		WHERE SOURCE_SERVER = P_SOURCE_SERVER
        AND BATCH_GUID = 	p_Batch_GUID;

--        DBMS_OUTPUT.PUT_LINE('p_BATCH_GUID : '||p_Batch_GUID|| ' found');


	EXCEPTION
		WHEN NO_DATA_FOUND
			THEN
            DBMS_OUTPUT.PUT_LINE('Extract_Stats_Batch: P_SOURCE_SERVER, p_BATCH_GUID : '||P_SOURCE_SERVER||', '||p_Batch_GUID|| 'NOT found');

			GV_SRC_REC_SUMMARY.BATCH_GUID := p_Batch_GUID;
			--GV_TARGET_REC := NULL;
		WHEN OTHERS THEN
			RAISE;
	End;

-----------------------------------------------------------------
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

		--	DBMS_OUTPUT.PUT_LINE('Processing DOCUMENT_CSR: '||GV_BATCH_GUID_ID);

		END LOOP;

		IF (DOCUMENT_CSR%ISOPEN)
		THEN
			CLOSE DOCUMENT_CSR;
		END IF;


	EXCEPTION
		WHEN NO_DATA_FOUND 
			THEN NULL;
		WHEN OTHERS 
			THEN RAISE;

	End;

-----------------------------------------------------------------

    Procedure Extract_Envelope ( P_SOURCE_SERVER varchar DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS

    -- NOTE THIS TABLE IS CENTRAL ONLY.. THE P_SOURCE_SERVER IS NOT NEEDED 

	BEGIN
		null;
	End;

-----------------------------------------------------------------
    Procedure Extract_Stats_Batch_Module ( P_SOURCE_SERVER varchar DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS
--GV_SRC_REC_STATS_BATCH_MODULE			
	BEGIN
		null;
	End;

-----------------------------------------------------------------
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
            then raise;

	End;

-----------------------------------------------------------------
    Procedure Extract_Stats_Form_Type ( P_SOURCE_SERVER varchar DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS
--GV_SRC_REC_STATS_FORM_TYPE				
	BEGIN
		null;
	End;

-----------------------------------------------------------------

-----------------------------------------------------------------
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

-- DBMS_OUTPUT.PUT_LINE('Processing BATCH_EVENT_CSR: '||GV_BATCH_GUID_ID);

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

-- If there is a DELETED = 'Y' after skipping
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
-- NOTE USE OF STATS_MODULE_LAUNCH.MODULENAME 
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
            DBMS_OUTPUT.PUT_LINE('Extract_Batch_Event: P_SOURCE_SERVER, p_BATCH_GUID : '||P_SOURCE_SERVER||' '||p_Batch_GUID|| 'NOT found');
			GV_SRC_REC_SUMMARY.BATCH_GUID := p_Batch_GUID;
			--GV_TARGET_REC := NULL;
		WHEN OTHERS THEN
			RAISE;



End; -- Extract_Batch_Event
	--------------------------------------	

END NYHIX_MFB_V2_BATCH_SUMMARY_PKG;
/
show error

-- *********************************************************
-- *********************************************************
-- CREATE OR REPLACE VIEWS
-- *********************************************************
-- *********************************************************
--------------------------------------------------------
--  DDL for View D_MFB_V2_BATCH_EVENTS_CURRENT_SV
--------------------------------------------------------

CREATE OR REPLACE FORCE EDITIONABLE VIEW MAXDAT.D_MFB_V2_BATCH_EVENTS_CURRENT_SV 
AS
SELECT
BATCH_MODULE_ID			AS 		BATCH_MODULE_ID,
BATCH_GUID				AS 		BATCH_GUID,
MODULE_LAUNCH_ID		AS 		MODULE_LAUNCH_ID,
MODULE_UNIQUE_ID		AS 		MODULE_UNIQUE_ID,
MODULENAME				AS 		MODULE_NAME,
MODULE_CLOSE_UNIQUE_ID	AS 		MODULE_CLOSE_UNIQUE_ID,
MODULE_CLOSE_NAME		AS 		MODULE_CLOSE_NAME,
BATCH_STATUS			AS 		BATCH_STATUS,
START_DATE_TIME			AS 		MODULE_START_DT,
END_DATE_TIME			AS 		MODULE_END_DT,
USER_NAME				AS 		MODULE_LAUNCH_USER_NAME,
STATION_ID				AS 		STATION_ID,
SITE_NAME				AS 		SITE_NAME,
SITE_ID					AS 		SITE_ID,
DELETED					AS 		BATCH_DELETED,
PAGES_PER_DOCUMENT		AS 		PAGES_PER_DOCUMENT,
PAGES_SCANNED			AS 		PAGES_SCANNED,
PAGES_DELETED			AS 		PAGES_DELETED,
DOCUMENTS_CREATED		AS 		DOCUMENTS_CREATED,
DOCUMENTS_DELETED		AS 		DOCUMENTS_DELETED,
PAGES_REPLACED			AS 		PAGES_REPLACED,
SOURCE_SERVER			AS 		SOURCE_SERVER,
ERROR_TEXT				AS 		ERROR_TEXT
FROM MAXDAT.NYHIX_MFB_V2_BATCH_EVENT
;

GRANT SELECT ON MAXDAT.D_MFB_V2_BATCH_EVENTS_CURRENT_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.D_MFB_V2_BATCH_EVENTS_CURRENT_SV TO MAXDAT_REPORTS;

--------------------------------------------------------
--  DDL for View D_MFB_V2_CURRENT_MFD_DCN_SV
--------------------------------------------------------

CREATE OR REPLACE FORCE EDITIONABLE VIEW MAXDAT.D_MFB_V2_CURRENT_MFD_DCN_SV 
AS SELECT DD.NYHIX_MFD_BI_ID		AS NYHIX_MFD_BI_ID,
		B2.MFB_V2_BI_ID 		AS MFB_BI_ID
FROM NYHIX_MFB_V2_BATCH_SUMMARY 	B2
JOIN D_NYHIX_MFD_CURRENT_V2 		DD 
ON (B2.BATCH_NAME=DD.BATCH_NAME)
WITH READ ONLY
;
GRANT SELECT ON MAXDAT.D_MFB_V2_CURRENT_MFD_DCN_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.D_MFB_V2_CURRENT_MFD_DCN_SV TO MAXDAT_REPORTS;

--------------------------------------------------------
--  DDL for View D_MFB_V2_CURRENT_SV
--------------------------------------------------------

CREATE OR REPLACE FORCE EDITIONABLE VIEW MAXDAT.D_MFB_V2_CURRENT_SV 
AS  SELECT 
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
FROM MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY
;
  
GRANT SELECT ON MAXDAT.D_MFB_V2_CURRENT_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.D_MFB_V2_CURRENT_SV TO MAXDAT_REPORTS;

--------------------------------------------------------
--  DDL for View D_MFB_V2_DOC_CURRENT_SV
--------------------------------------------------------

CREATE OR REPLACE FORCE EDITIONABLE VIEW MAXDAT.D_MFB_V2_DOC_CURRENT_SV 
AS  SELECT
ECN				AS	ECN,
BATCH_GUID		AS	BATCH_GUID,
DOCUMENT_NUMBER	AS	DOCUMENT_ID,
DCN				AS	DCN,
ORDERNUMBER		AS	DOC_ORDER_NUMBER,
FORM_TYPE		AS	TYPE_NAME,
DOC_CLASS		AS	DOCUMENT_CLASS,
DOC_RECEIPT_DT	AS	DOCUMENT_RECEIPT_DT,
DOC_CREATION_DT	AS	DOCUMENT_CREATION_DT,
DOC_PAGE_COUNT	AS	DOCUMENT_PAGE_COUNT,
CLASSIFIED_DOC	AS	CLASSIFIED_DOCUMENT,
DELETED			AS	DELETED,
CONFIDENCE		AS	CONFIDENCE,
CONFIDENT		AS	CONFIDENT
FROM MAXDAT.NYHIX_MFB_V2_DOCUMENT
;

GRANT SELECT ON MAXDAT.D_MFB_V2_DOC_CURRENT_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.D_MFB_V2_DOC_CURRENT_SV TO MAXDAT_REPORTS;


--------------------------------------------------------
--  DDL for View D_MFB_V2_BATCH_EVENTS_CURMOD_SV
--------------------------------------------------------

CREATE OR REPLACE FORCE EDITIONABLE VIEW MAXDAT.D_MFB_V2_BATCH_EVENTS_CURMOD_SV 
AS SELECT c.CURRENT_BATCH_MODULE_ID,
  c.BATCH_GUID,
  e.MODULE_LAUNCH_ID,
  e.MODULE_UNIQUE_ID,
  e.MODULE_NAME,
  e.MODULE_CLOSE_ID AS MODULE_CLOSE_UNIQUE_ID,
  e.MODULE_CLOSE_NAME,
  e.BATCH_STATUS,
  e.MODULE_START_DT,
  e.MODULE_END_DT,
  e.USER_NAME AS MODULE_LAUNCH_USER_NAME,
  e.STATION_ID,
  e.SITE_NAME,
  e.SITE_ID,
  e.BATCH_DELETED,
  e.DOC_PAGES AS PAGES_PER_DOCUMENT,
  e.PAGES_SCANNED,
  e.PAGES_DELETED,
  e.DOCS_CREATED AS DOCUMENTS_CREATED,
  e.DOCS_DELETED AS DOCUMENTS_DELETED,
  e.PAGES_REPLACED ,
  e.SOURCE_SERVER,
  e.ERROR_TEXT
FROM NYHIX_MFB_V2_BATCH_EVENT e, 
NYHIX_MFB_V2_BATCH_SUMMARY c
WHERE e.BATCH_MODULE_ID = c.CURRENT_BATCH_MODULE_ID WITH READ ONLY
;

GRANT SELECT ON MAXDAT.D_MFB_V2_BATCH_EVENTS_CURMOD_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.D_MFB_V2_BATCH_EVENTS_CURMOD_SV TO MAXDAT_REPORTS;

--------------------------------------------------------
--  DDL for View F_MFB_V2_BY_BATCH_GROUP_BY_DAY_SV
--------------------------------------------------------

CREATE OR REPLACE FORCE EDITIONABLE VIEW MAXDAT.F_MFB_V2_BY_BATCH_GROUP_BY_DAY_SV 
AS   SELECT
BDD.D_DATE,
BDD.WEEKEND_FLAG,
CASE 
    WHEN D.BATCH_CLASS   =  'NYSOH_NoPrep_FAX'                                   then 'Expedited Appeals'
    WHEN D.BATCH_CLASS   =  'NYSOH_FAX_NavCAC'                                   then 'Nav/CAC Faxes'
    WHEN D.BATCH_CLASS   =  'NYSOH_RETURNED_MAIL'                                then 'Returned Mail'
    WHEN D.BATCH_CLASS   =  'NYSOH_FAX_Channel'                                  then 'Fax Batches' --for DEV   
    WHEN D.BATCH_CLASS LIKE '%FAX_NavCAC'                                        then 'Nav/CAC Faxes' --for UAT
    WHEN D.BATCH_CLASS LIKE '%FAX'                                               then 'Fax Batches'
    WHEN D.BATCH_CLASS LIKE '%MAIL'                                              then 'Mail Batches'  else 'NA' end as Batch_Group,
	D.FAX_BATCH_SOURCE,
	D.BATCH_CLASS,
	CASE WHEN D.BATCH_CLASS LIKE 'NYHO%' THEN 'NYEC' ELSE 'NYHIX' END AS BATCH_PROGRAM,
	SUM(CASE WHEN BDD.D_DATE = TRUNC(D.CREATE_DT) THEN 1 ELSE 0 END) AS CREATION_COUNT,
	SUM(CASE WHEN BDD.D_DATE = TRUNC(D.BATCH_COMPLETE_DT) THEN 1 ELSE 0 END) AS COMPLETION_COUNT,
	SUM(CASE WHEN BDD.D_DATE = TRUNC(D.CANCEL_DT) THEN 1 ELSE 0 END) AS CANCEL_COUNT,
	SUM(CASE WHEN BDD.D_DATE = TRUNC(D.CANCEL_DT) AND D.REPROCESSED_FLAG = 'Y' THEN 1 ELSE 0 END) AS REPROCESSED_COUNT
FROM MAXDAT.D_DATES BDD 
JOIN MAXDAT.D_MFB_V2_CURRENT_SV D 
ON (BDD.D_DATE = TRUNC(D.CREATE_DT) 
OR BDD.D_DATE = COALESCE(TRUNC(D.COMPLETE_DT),TRUNC(D.CANCEL_DT),TRUNC(SYSDATE))) 
GROUP BY 
	BDD.D_DATE,
	BDD.WEEKEND_FLAG,
	CASE 
		WHEN D.BATCH_CLASS   =  'NYSOH_NoPrep_FAX'                                   then 'Expedited Appeals'
		WHEN D.BATCH_CLASS   =  'NYSOH_FAX_NavCAC'                                   then 'Nav/CAC Faxes'
		WHEN D.BATCH_CLASS   =  'NYSOH_RETURNED_MAIL'                                then 'Returned Mail'
		WHEN D.BATCH_CLASS   =  'NYSOH_FAX_Channel'                                  then 'Fax Batches' --for DEV   
		WHEN D.BATCH_CLASS LIKE '%FAX_NavCAC'                                        then 'Nav/CAC Faxes' --for UAT
		WHEN D.BATCH_CLASS LIKE '%FAX'                                               then 'Fax Batches'
		WHEN D.BATCH_CLASS LIKE '%MAIL'                                              then 'Mail Batches'  else 'NA' end ,
	D.FAX_BATCH_SOURCE,
	D.BATCH_CLASS,
	CASE WHEN D.BATCH_CLASS LIKE 'NYHO%' THEN 'NYEC' ELSE 'NYHIX' END
;

GRANT SELECT ON MAXDAT.F_MFB_V2_BY_BATCH_GROUP_BY_DAY_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.F_MFB_V2_BY_BATCH_GROUP_BY_DAY_SV TO MAXDAT_REPORTS;
