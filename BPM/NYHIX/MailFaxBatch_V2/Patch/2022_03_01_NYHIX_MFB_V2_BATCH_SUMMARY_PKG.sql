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
	GV_JOB_NAME					VARCHAR2(120)		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG';
	GV_DRIVER_TABLE_NAME  		VARCHAR2(100 BYTE)	:= 'NYHIX_MFB_V2_BATCH_SUMMARY';
	GV_DRIVER_KEY_NUMBER  		VARCHAR2(100 BYTE)	:= NULL;
	GV_NR_OF_ERROR        		NUMBER				:= 0;
    GV_UPDATE_TS                DATE                := SYSDATE;
    GV_TARGET_ROWID             ROWID               := NULL;

	-- USED FOR THE CORP_ETL_JOB_STATISTICS
	GV_JOB_ID                 	NUMBER              := 0;
	GV_FILE_NAME              	VARCHAR2(512 BYTE)	:= 'NYHIX_MFB_V2_STATS_BATCH';
	GV_RECORD_COUNT           	NUMBER				:= 0;
	GV_ERROR_COUNT            	NUMBER				:= 0;
	GV_WARNING_COUNT          	NUMBER				:= 0;
	GV_PROCESSED_COUNT        	NUMBER				:= 0;
	GV_RECORD_INSERTED_COUNT  	NUMBER				:= 0;
	GV_RECORD_UPDATED_COUNT   	NUMBER				:= 0;
	GV_JOB_START_DATE         	DATE				:= SYSDATE;
	--GV_JOB_END_DATE           	DATE				:= SYSDATE;
	GV_BATCH_GUID				VARCHAR2(38 BYTE) 	:= NULL;
	GV_SOURCE_SERVER			VARCHAR2(38 BYTE) 	:= NULL;
	GV_SBM_MAX_END_DATE_TIME    DATE				:= SYSDATE;

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

    GV_FACT_BY_HOUR_INSERT_COUNT    	NUMBER				:= 0;
    GV_FACT_BY_HOUR_UPDATE_COUNT    	NUMBER				:= 0;
    GV_FACT_BY_HOUR_INSERT_SKIP_COUNT   NUMBER				:= 0;
    GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT   NUMBER				:= 0;
	GV_F_MFB_V2_BY_HOUR_DELETE_COUNT   	NUMBER				:= 0;
	GV_EVENT_COUNT						NUMBER				:= 0;

	-- Additionl Fields needed to match D_MFB_CURRENT
	GV_TIMELINESS_DAYS 					NUMBER  			:= 3; 	--<< From CORP_ETL_LIST_LKUP
	GV_TIMELINESS_DAYS_TYPE 			VARCHAR2(2 BYTE)	:= 'B'; --<< From CORP_ETL_LIST_LKUP
	GV_JEOPARDY_DAYS 					NUMBER  			:= 2; 	--<< From CORP_ETL_LIST_LKUP
	GV_JEOPARDY_DAYS_TYPE 				VARCHAR2(2 BYTE)	:= 'B'; --<< From CORP_ETL_LIST_LKUP
	GV_TARGET_DAYS 						NUMBER				:= 0;	--<< From CORP_ETL_LIST_LKUP

	-- USED FOR INSERT AND UPDATES OF NYHIX_MFB_V2_BATCH_SUMMARY AND F_MFB_V2_BY_HOUR
	GV_MFB_V2_BI_ID						NUMBER   	:= NULL;	--<< SEQUENCE FOR NYHIX)MFB_V2_BATCH_SUMMARY
	GV_MFB_V2_CREATE_DATE				DATE 		:= SYSDATE;
	GV_MFB_V2_UPDATE_DATE   			DATE 		:= TO_DATE(NULL);

	-- USED IN THE CALCULATIONS OF BUSINESS HOURS, BUSINESS DAYS FACT BY HOUR FACT BY DAY
	GV_START_DATE						DATE		:= TO_DATE(NULL);
	GV_END_DATE							DATE		:= TO_DATE(NULL);
	GV_AGE_IN_BUSINESS_DAYS 			NUMBER; 			--<< Derived Once a day for EACH Batch_summary



	-- USED BY THE FACT_BY_DAY_PROCESS
    GV_CANCEL_DT                		DATE                := SYSDATE +1;
	GV_BATCH_CANCEL_DT          		DATE            	:= TO_DATE(NULL);
	GV_BATCH_COMPLETE_DT        		DATE            	:= TO_DATE(NULL);

    GV_FACT_BY_DAY_PROCESSED_COUNT   	NUMBER              := 0;
    GV_FACT_BY_DAY_INSERTED_COUNT      	NUMBER              := 0;
    GV_FACT_BY_DAY_UPDATED_COUNT      	NUMBER              := 0;
    GV_FACT_BY_DAY_DELETED_COUNT      	NUMBER              := 0;

	GV_F_BY_DAY_CSR_OPEN 				NUMBER              := 0;
	GV_F_BY_DAY_CSR_CLOSE				NUMBER              := 0;

	-- *** NOTE *** These only need to be derrived once a day
	--GV_AGE_IN_CALENDAR_DAYS 	NUMBER; 			--<< Derived Once a day
	--GV_TIMELINESS_STATUS 		VARCHAR2(20 BYTE); 	--<< Derived Once a day
	--GV_TIMELINESS_DT 			DATE; 				--<< Derived Once a day
	--GV_JEOPARDY_FLAG 			VARCHAR2(3 BYTE); 	--<< Derived Once a day
	--GV_JEOPARDY_DT 				DATE; 				--<< Derived Once a day


	-------------------------------------------------------------------------------------------
	-- THIS IS THE MAIN "DRIVING" CURSOR for the package
	-- It selects a distinct list of any  BATCH_GUID
	-- that was Inserted or Updated
	-- based on the "Parent Job ID"
	-------------------------------------------------------------------------------------------

	CURSOR BATCH_GUID_CSR IS
	SELECT SOURCE_SERVER, BATCH_GUID
	FROM NYHIX_MFB_V2_GUID_RUN_LIST
	ORDER BY BATCH_GUID, SOURCE_SERVER desc;

	GV_SRC_REC_SUMMARY          			NYHIX_MFB_V2_BATCH_SUMMARY%ROWTYPE;
	GV_TARGET_REC       					NYHIX_MFB_V2_BATCH_SUMMARY%ROWTYPE;

	GV_SRC_REC_EVENT    					NYHIX_MFB_V2_BATCH_EVENT%ROWTYPE;
	GV_SRC_REC_DOCUMENT						NYHIX_MFB_V2_DOCUMENT%ROWTYPE;

--	GV_SRC_REC_MAXDAT_REPORTING				NYHIX_MFB_V2_MAXDAT_REPORTING%ROWTYPE;
--	GV_SRC_REC_ENVELOPE						NYHIX_MFB_V2_ENVELOPE%ROWTYPE;
--	GV_SRC_REC_STATS_BATCH					NYHIX_MFB_V2_STATS_BATCH%ROWTYPE;
--	GV_SRC_REC_STATS_BATCH_MODULE			NYHIX_MFB_V2_STATS_BATCH_MODULE%ROWTYPE;
--	GV_SRC_REC_STATS_BATCH_MODULE_LAUNCH	NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH%ROWTYPE;
--	GV_SRC_REC_STATS_FORM_TYPE				NYHIX_MFB_V2_STATS_FORM_TYPE%ROWTYPE;

	---------------------------------------------------------------------------

    CURSOR F_BY_DAY_CSR IS
    WITH GUID AS
        ( SELECT
            BATCH_GUID, 					-- 1 	1
            MFB_V2_BI_ID,      				-- 1 	3
            -- SRC.MFB_V2_CREATE_DATE  	-- 1 	4
            -- SRC.MFB_V2_UPDATE_DATE 	-- 1 	5
            CREATE_DT,       				-- 1 	6
            FAX_BATCH_SOURCE,				-- 1 	7
            BATCH_CLASS,					-- 1 	8
            CANCEL_DT,						-- 1 	9
            REPROCESSED_FLAG,				-- 1 	10
            REPROCESSED_DATE,				-- 1 	10
            BATCH_COMPLETE_DT,   			-- 1 	11
            BATCH_CLASS AS BATCH_GROUP,
            CASE
                WHEN BATCH_CLASS LIKE 'NYHO%'
                THEN 'NYEC'
                ELSE 'NYHIX' END        AS BATCH_PROGRAM
        FROM NYHIX_MFB_V2_BATCH_SUMMARY
        WHERE BATCH_GUID = GV_BATCH_GUID
        ),
    DATE_TAB AS
        (SELECT D_DATE, WEEKEND_FLAG,     BUSINESS_DAY_FLAG
        FROM BPM_D_DATES, GUID
		WHERE D_DATE BETWEEN TRUNC(GUID.CREATE_DT)
		AND GV_END_DATE
		),
    SRC AS
        (SELECT
            GUID.BATCH_GUID                   	AS SRC_BATCH_GUID,				-- 1 	1
            DATE_TAB.D_date            			AS SRC_D_DATE,					-- 1 	2
            GUID.MFB_V2_BI_ID                  	AS SRC_MFB_V2_BI_ID,			-- 1 	3
            --  SRC.MFB_V2_CREATE_DATE       AS SRC_MFB_V2_CREATE_DATE,		-- 1 	4
            -- SRC.MFB_V2_UPDATE_DATE       AS SRC_MFB_V2_UPDATE_DATE,		-- 1 	5
            GUID.CREATE_DT                     	AS SRC_CREATE_DT,				-- 1 	6
            GUID.FAX_BATCH_SOURCE              	AS SRC_FAX_BATCH_SOURCE,		-- 1 	7
            GUID.BATCH_CLASS                   	AS SRC_BATCH_CLASS,				-- 1 	8
            GUID.CANCEL_DT    	                AS SRC_CANCEL_DT,				-- 1 	9
            GUID.REPROCESSED_FLAG				AS SRC_REPROCESSED_FLAG,
            GUID.REPROCESSED_DATE               AS SRC_REPROCESSED_DATE,			-- 1 	10
            GUID.BATCH_COMPLETE_DT             	AS SRC_BATCH_COMPLETE_DT,		-- 1 	11
        --CASE
        --    WHEN  NVL(DATE_TAB.BUSINESS_DAY_FLAG,'N')	= 'Y'
        --    THEN
        --        MAXDAT.BUS_HRS_BETWEEN(GUID.CREATE_DT, 						-- << START_DATE ******
        --        LEAST(SYSDATE,NVL(BATCH_COMPLETE_DT,D_DATE+19/24) ))		-- << END_DATE  *******
        --    ELSE 0
		--	END 								AS SRC_AGE_IN_BUSINESS_HOURS,	-- 1   12
		0		 								AS SRC_AGE_IN_BUSINESS_HOURS,	-- 1   12
        0                                       AS SRC_AGE_IN_BUSINESS_DAYS,
        CASE WHEN TRUNC(GUID.CREATE_DT ) = TRUNC(D_DATE)
			THEN 1 ELSE 0 END 				AS SRC_CREATION_COUNT,  		-- 1    14
        CASE WHEN TRUNC(GV_END_DATE) = D_DATE
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
        AND TRUNC(LEAST(GUID.REPROCESSED_DATE,GUID.CANCEL_DT)) = D_DATE
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
		ROWID    						  		AS TARGET_ROWID,
		-- Insert SQL from Query 1 section 2 Here
                  TARGET.BATCH_GUID            	AS TARGET_BATCH_GUID,	-- 2 	1
                      TARGET.D_DATE             AS TARGET_D_DATE,	-- 2 	2
                TARGET.MFB_V2_BI_ID             AS TARGET_MFB_V2_BI_ID,	-- 2 	3
          TARGET.MFB_V2_CREATE_DATE             AS TARGET_MFB_V2_CREATE_DATE,	-- 2 	4
          TARGET.MFB_V2_UPDATE_DATE             AS TARGET_MFB_V2_UPDATE_DATE,	-- 2 	5
                   TARGET.CREATE_DT             AS TARGET_CREATE_DT,	-- 2 	6
            TARGET.FAX_BATCH_SOURCE             AS TARGET_FAX_BATCH_SOURCE,	-- 2 	7
                 TARGET.BATCH_CLASS             AS TARGET_BATCH_CLASS,	-- 2 	8
                   TARGET.CANCEL_DT             AS TARGET_CANCEL_DT,	-- 2 	9
			TARGET.REPROCESSED_FLAG			    AS TARGET_REPROCESSED_FLAG,
            TARGET.REPROCESSED_DATE             AS TARGET_REPROCESSED_DATE,	-- 2 	10
           TARGET.BATCH_COMPLETE_DT             AS TARGET_BATCH_COMPLETE_DT,	-- 2 	11
       TARGET.AGE_IN_BUSINESS_HOURS             AS TARGET_AGE_IN_BUSINESS_HOURS,	-- 2 	12
        TARGET.AGE_IN_BUSINESS_DAYS             AS TARGET_AGE_IN_BUSINESS_DAYS,	-- 2 	13
              TARGET.CREATION_COUNT             AS TARGET_CREATION_COUNT,	-- 2 	14
             TARGET.INVENTORY_COUNT             AS TARGET_INVENTORY_COUNT,	-- 2 	15
            TARGET.COMPLETION_COUNT             AS TARGET_COMPLETION_COUNT,	-- 2 	16
           TARGET.CANCELATION_COUNT             AS TARGET_CANCELATION_COUNT,	-- 2 	17
           TARGET.REPROCESSED_COUNT             AS TARGET_REPROCESSED_COUNT, 	-- 2 	18
		TARGET.WEEKEND_FLAG                     AS TARGET_WEEKEND_FLAG,            -- 2 	19,
        TARGET.BUSINESS_DAY_FLAG			    AS TARGET_BUSINESS_DAY_FLAG,
        TARGET.BATCH_GROUP                    	AS TARGET_BATCH_GROUP,
        TARGET.BATCH_PROGRAM                  	AS TARGET_BATCH_PROGRAM
        -- 2 	20,
    FROM F_MFB_V2_BY_DAY TARGET
	where batch_guid = gv_batch_guid
	)
	SELECT
        ROWNUM AS BUSINESS_DAY_NUM,
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
                              SRC_CANCEL_DT,                         	-- 3 	9
                              SRC_REPROCESSED_FLAG,                     	-- 3 	10
                              SRC_REPROCESSED_DATE,                     	-- 3 	10
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
                              TARGET_REPROCESSED_FLAG,                  	-- 4 	10
                              TARGET_REPROCESSED_DATE,                  	-- 4 	10
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
        AND SRC_D_DATE = TARGET_D_DATE
	ORDER BY SRC_D_DATE;

	GV_FACT_JOIN_REC   F_BY_DAY_CSR%ROWTYPE;

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
		bus_days number := null;
		cal_days number := null;
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
			if (bus_days >= GV_jeopardy_days)
			then
				return 'Y';
			else
				return 'N';
			end if;
	elsif (days_type='C')
		then
			if (cal_days >= GV_jeopardy_days)
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
PROCEDURE LOAD_BATCH_SUMMARY (P_JOB_ID varchar default null)
IS
-----------------------------------------------------

	BEGIN

		-- INITIAL SET Setup

		-- Its a Job not a single batch
		IF P_JOB_ID IS NULL
		OR P_JOB_ID <= 0
		THEN
			GV_PARENT_JOB_ID := SEQ_JOB_ID.NEXTVAL;
		ELSE
			GV_PARENT_JOB_ID := P_JOB_ID;
		END IF;

        GV_JOB_ID := SEQ_JOB_ID.NEXTVAL;
		GV_JOB_NAME := 'NYHIX_MFB_V2 Parent ID: '||P_JOB_ID||' - Step LOAD_BATCH_SUMMARY';

        GV_RECORD_COUNT           	:= 0;
        GV_ERROR_COUNT            	:= 0;
        GV_WARNING_COUNT          	:= 0;
        GV_PROCESSED_COUNT        	:= 0;
        GV_RECORD_INSERTED_COUNT  	:= 0;
        GV_RECORD_UPDATED_COUNT   	:= 0;
		GV_EVENT_COUNT				:= 0;

		GV_BATCH_GUID				:= NULL;

        GV_FACT_BY_HOUR_INSERT_COUNT    	:= 0;
        GV_FACT_BY_HOUR_UPDATE_COUNT    	:= 0;
		GV_F_MFB_V2_BY_HOUR_DELETE_COUNT 	:= 0;


        -- USED BY LOAD_F_BY_DAY
        GV_CANCEL_DT                := SYSDATE +1;
        GV_BATCH_GUID            	:= NULL;
        GV_BATCH_CANCEL_DT          := TO_DATE(NULL);
        GV_BATCH_COMPLETE_DT        := TO_DATE(NULL);

        GV_FACT_BY_DAY_PROCESSED_COUNT   := 0;
        GV_FACT_BY_DAY_INSERTED_COUNT    := 0;
        GV_FACT_BY_DAY_UPDATED_COUNT     := 0;
        GV_FACT_BY_DAY_DELETED_COUNT     := 0;

        -- GET VALUES FROM CORP_ETL_CONTROL
        Extract_CORP_ETL_CONTROL;

        GV_FILE_NAME	:= 'NYHIX_MFB_V2_BATCH_SUMMARY';
		INSERT_CORP_ETL_JOB_STATISTICS;


		LOAD_RUN_LIST(GV_PARENT_JOB_ID);
		PROCESS_RUN_LIST(GV_PARENT_JOB_ID);

		-- Post the job statistics
		/*
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

		DBMS_OUTPUT.PUT_LINE('GV_F_BY_DAY_CSR_OPEN :'||GV_F_BY_DAY_CSR_OPEN);
		DBMS_OUTPUT.PUT_LINE('GV_F_BY_DAY_CSR_CLOSE :'||GV_F_BY_DAY_CSR_CLOSE);
		*/

		Update_Corp_ETL_Job_Statistics;

	EXCEPTION

		WHEN NO_DATA_FOUND
		THEN
			NULL;

        WHEN OTHERS THEN
            GV_ERROR_CODE 			:= SQLCODE;
            GV_ERROR_MESSAGE 		:= SUBSTR(SQLERRM, 1, 3000);
			GV_DRIVER_KEY_NUMBER  	:= 'GV_SRC_REC_SUMMARY.BATCH_GUID : '||GV_SRC_REC_SUMMARY.BATCH_GUID;
			GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_V2_BATCH_SUMMARY';
			GV_ERR_LEVEL		  	:= 'CRITICAL';
			GV_FILE_NAME				:= 'LOAD_BATCH_SUMMARY';
			POST_ERROR;

			ROLLBACK;
			DBMS_OUTPUT.PUT_LINE('Main Cursor failure for BATCH_GUID '||GV_BATCH_GUID
				||'  SQLCODE '||GV_ERROR_CODE
				||' '||GV_ERROR_MESSAGE);


			RAISE;

	END LOAD_BATCH_SUMMARY;

---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
PROCEDURE LOAD_RUN_LIST(P_PARENT_JOB_ID varchar default null) IS
BEGIN
		-- Because of loops and commits the list of Batch Guids to run
		-- is created and commited first.
		-- it is the driving cursor for the process

		-- CREATE A LIST OF BATCHES TO RUN
		-- DBMS_OUTPUT.PUT_LINE( 'LIST STARTING '||TO_CHAR(SYSDATE,'YYYYMMDD HH24:MI:SS'));

		DELETE FROM NYHIX_MFB_V2_GUID_RUN_LIST;

		COMMIT;

		GV_PARENT_JOB_ID := P_PARENT_JOB_ID;

			INSERT INTO NYHIX_MFB_V2_GUID_RUN_LIST
			(SOURCE_SERVER, BATCH_GUID, MFB_V2_PARENT_JOB_ID, BATCH_SUMMARY_JOB_ID)
			SELECT DISTINCT
				SOURCE_SERVER,
				BATCH_GUID,
				P_PARENT_JOB_ID,
				GV_JOB_ID
			FROM (
					SELECT
						SOURCE_SERVER,
						BATCH_GUID,
						P_PARENT_JOB_ID,
						GV_JOB_ID
					FROM
					(
					SELECT SOURCE_SERVER, BATCH_GUID
					FROM NYHIX_MFB_V2_BATCH_SUMMARY
					WHERE NVL(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID 		-- Used to "FORCE" a run
					OR (
						INSTANCE_STATUS = 'Active'
						AND COMPLETE_DT IS NULL
						AND BATCH_COMPLETE_DT IS NULL							-- ALL 'ACTIVE BATCHES'
						AND CANCEL_DT IS NULL
					)
					UNION
					SELECT SOURCE_SERVER, BATCH_GUID
					FROM NYHIX_MFB_V2_STATS_BATCH
					WHERE NVL(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID
					UNION
					SELECT SOURCE_SERVER, BATCH_GUID
					FROM NYHIX_MFB_V2_BATCH_EVENT
					WHERE SOURCE_SERVER = 'REMOTE' 
					AND NVL(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID
					UNION
					SELECT SOURCE_SERVER, BATCH_GUID
					FROM NYHIX_MFB_V2_BATCH_EVENT
					WHERE SOURCE_SERVER = 'CENTRAL'
					AND NVL(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID
					UNION
					SELECT  'CENTRAL' AS SOURCE_SERVER, BATCH_GUID
					FROM NYHIX_MFB_V2_DOCUMENT
					WHERE NVL(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID
					UNION
					SELECT  'CENTRAL' AS SOURCE_SERVER, BATCH_GUID
					FROM NYHIX_MFB_V2_ENVELOPE
					WHERE NVL(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID
					UNION
					SELECT 'CENTRAL' AS SOURCE_SERVER, BATCH_GUID
					FROM NYHIX_MFB_V2_MAXDAT_REPORTING
					WHERE NVL(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID
					AND VALID = 1
					UNION
					SELECT SOURCE_SERVER, BATCH_GUID
					FROM NYHIX_MFB_V2_STATS_BATCH_MODULE
					WHERE NVL(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID
					UNION
					SELECT SOURCE_SERVER, BATCH_GUID
					FROM NYHIX_MFB_V2_STATS_FORM_TYPE
					WHERE NVL(MFB_V2_PARENT_JOB_ID,0) >= GV_PARENT_JOB_ID
					)
				WHERE BATCH_GUID IS NOT NULL
				AND (SOURCE_SERVER, BATCH_GUID )
				IN ( SELECT SOURCE_SERVER, BATCH_GUID
					FROM NYHIX_MFB_V2_STATS_BATCH
					MINUS
					SELECT SOURCE_SERVER, BATCH_GUID
					FROM NYHIX_MFB_V2_BATCH_SUMMARY
					WHERE CANCEL_DT IS NOT NULL
					OR COMPLETE_DT IS NOT NULL
					OR BATCH_COMPLETE_DT IS NOT NULL
					OR INSTANCE_STATUS <> 'Active'
					)
				);

			COMMIT;

			-- Add a row to the list for 'CENTRAL' 
			-- when the source_server is 'REMOTE'
			-- and status is 'Active'
			-- and there is an entry in stats_batch for 'CENTRAL'
            -- and the is an entry for 'CENTRAL' in batch_event		

			INSERT INTO NYHIX_MFB_V2_GUID_RUN_LIST
			(SOURCE_SERVER, BATCH_GUID, MFB_V2_PARENT_JOB_ID, BATCH_SUMMARY_JOB_ID)
			SELECT DISTINCT
				SOURCE_SERVER,
				BATCH_GUID,
				P_PARENT_JOB_ID,
				GV_JOB_ID
			FROM ((
                SELECT 'CENTRAL' SOURCE_SERVER, BATCH_GUID
                FROM MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY
                WHERE SOURCE_SERVER = 'REMOTE'
                AND INSTANCE_STATUS = 'Active'
                AND BATCH_GUID 
                    IN ( SELECT SB.BATCH_GUID
                    FROM MAXDAT.NYHIX_MFB_V2_STATS_BATCH SB
                    JOIN MAXDAT.NYHIX_MFB_V2_BATCH_EVENT E
                    ON E.SOURCE_SERVER = SB.SOURCE_SERVER
                    AND E.BATCH_GUID = SB.BATCH_GUID
                    AND  SB.SOURCE_SERVER = 'CENTRAL'
                        ) 
                  )      
                MINUS  -- Any that are already in the list
                SELECT SOURCE_SERVER, BATCH_GUID
                FROM MAXDAT.NYHIX_MFB_V2_GUID_RUN_LIST
                WHERE SOURCE_SERVER = 'CENTRAL'
                );

			COMMIT;			

			-- Remove and BATCH_GUIDS from the run list
			-- when the SOURCE_SERVER = 'REMOTE'
			-- and thee is already a record for 'CENTRAL'

			DELETE FROM NYHIX_MFB_V2_GUID_RUN_LIST
			WHERE SOURCE_SERVER = 'REMOTE'
			AND ( SOURCE_SERVER, BATCH_GUID )
			IN ( SELECT 'REMOTE', BATCH_GUID
			     FROM NYHIX_MFB_V2_BATCH_SUMMARY
				 WHERE SOURCE_SERVER = 'CENTRAL'
				 AND BATCH_GUID IN
				 ( SELECT BATCH_GUID FROM NYHIX_MFB_V2_GUID_RUN_LIST )
				);

			COMMIT;

		-- DON'T PROCESS BATCH_GUID FROM REMOTE ID THERE IS ONE FROM CENTRAL


		-- DBMS_OUTPUT.PUT_LINE( 'LIST CREATED '||TO_CHAR(SYSDATE,'YYYYMMDD HH24:MI:SS'));
		-- this curcor reads the NYHIX_MFB_V2_GUID_RUN_LIST

	EXCEPTION

		WHEN NO_DATA_FOUND
		THEN
			NULL;

        WHEN OTHERS THEN
            GV_ERROR_CODE 			:= SQLCODE;
            GV_ERROR_MESSAGE 		:= SUBSTR(SQLERRM, 1, 3000);
			GV_DRIVER_KEY_NUMBER  	:= 'GV_SRC_REC_SUMMARY.BATCH_GUID : '||GV_SRC_REC_SUMMARY.BATCH_GUID;
			GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_V2_BATCH_SUMMARY';
			GV_ERR_LEVEL		  	:= 'CRITICAL';
			GV_FILE_NAME 			:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.Load_run_lst';

			--DBMS_OUTPUT.PUT_LINE('Main Cursor failure for BATCH_GUID '||GV_BATCH_GUID
			--	||'  SQLCODE '||GV_ERROR_CODE
			--	||' '||GV_ERROR_MESSAGE);

			POST_ERROR;

			ROLLBACK;

			RAISE;

	END LOAD_RUN_LIST;

---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
PROCEDURE PROCESS_ONE_BATCH(P_SOURCE_SERVER VARCHAR DEFAULT 'CENTRAL', P_BATCH_GUID varchar default null)
IS

    LV_RECORD_COUNT     NUMBER := 0;

	BEGIN

		IF GV_RECORD_COUNT < 10
		THEN
			DBMS_OUTPUT.PUT_LINE('PROCESS_ONE_BATCH  P_SOURCE_SERVER: '||P_SOURCE_SERVER);  -- DEBUG
			DBMS_OUTPUT.PUT_LINE('PROCESS_ONE_BATCH  P_BATCH_GUID: '||P_BATCH_GUID);			-- DEBUG
		END IF;

	    LV_RECORD_COUNT    := GV_RECORD_COUNT;

		GV_RECORD_COUNT 				:= GV_RECORD_COUNT+1;
		GV_AGE_IN_BUSINESS_DAYS 		:= 0;
		GV_END_DATE						:= TO_DATE(NULL);
		GV_START_DATE					:= TO_DATE(NULL);

		-- USED BY LOAD_F_BY_DAY
		GV_CANCEL_DT                := SYSDATE +1;
		GV_BATCH_CANCEL_DT          := TO_DATE(NULL);
		GV_BATCH_COMPLETE_DT        := TO_DATE(NULL);

		INITIALIZE_GV_SRC_REC_SUMMARY;
		GV_TARGET_REC := GV_SRC_REC_SUMMARY;

		-- GET VALUES FROM CORP_ETL_CONTROL
		Extract_CORP_ETL_CONTROL;

		GV_SOURCE_SERVER 	:= P_SOURCE_SERVER;
		GV_BATCH_GUID		:= P_BATCH_GUID;

 		Extract_Target(P_SOURCE_SERVER, P_BATCH_GUID);

		Extract_Stats_Batch(P_SOURCE_SERVER, P_BATCH_GUID);

		-- Note: the SOURCE_SERVER comes from STATS_BATCH
		-- THE JOIN to the Target ( Batch_summary ) in on BTACH_GUID
		-- IF the current target is from REMOTE and the current source
		-- is from CENTRAL, The TARGET should be updated.
		--
		-- If the SOURCE_SERVER from STATS_BATCH is REMOTE
		-- and the SOURCE_SERVER from BATCH_SUMMARY is CENTRAL
		-- this record should be skipped.

		IF GV_SRC_REC_SUMMARY.SOURCE_SERVER = 'REMOTE'
		AND GV_TARGET_REC.SOURCE_SERVER = 'CENTRAL'
		THEN
			dbms_output.put_line('RETURNING??');
			RETURN;
		END IF;

        -- THE EXTRACTS MUST BE IN THE PROPER ORDER
        -- ALL EXTRAXTS MAY NOT BE NEEDED
        Extract_Document(P_SOURCE_SERVER, P_BATCH_GUID);
        Extract_Envelope(P_SOURCE_SERVER, P_BATCH_GUID);
        -- Extract_Stats_Batch_Module(P_SOURCE_SERVER, P_BATCH_GUID);
        Extract_Maxdat_Reporting(P_SOURCE_SERVER, P_BATCH_GUID);
        Extract_Stats_Form_Type(P_SOURCE_SERVER, P_BATCH_GUID);

        --DBMS_OUTPUT.PUT_LINE('GV_SRC_REC_SUMMARY.INSTANCE_STATUS: BEFORE EVENT '||GV_SRC_REC_SUMMARY.INSTANCE_STATUS);

		dbms_output.put_line('Extract_Batch_Event:'||P_SOURCE_SERVER||' '||P_BATCH_GUID);

        Extract_Batch_Event(P_SOURCE_SERVER, P_BATCH_GUID);

        --DBMS_OUTPUT.PUT_LINE('GV_SRC_REC_SUMMARY.INSTANCE_STATUS: AFTER EVENT '||GV_SRC_REC_SUMMARY.INSTANCE_STATUS);

		GV_END_DATE := COALESCE(GV_SRC_REC_SUMMARY.REPROCESSED_DATE,
								GV_SRC_REC_SUMMARY.CANCEL_DT,
								GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT,
								GV_SRC_REC_SUMMARY.COMPLETE_DT,
								SYSDATE);

		-- Calculate the 'Derived' fields to match D_FMB_CURRENT ( v1 )
		-- try to do this only once a day

		IF GV_TARGET_ROWID IS NOT NULL
		AND GV_TARGET_REC.MFB_V2_UPDATE_DATE IS NOT NULL
		AND NOT ( GV_PARENT_JOB_ID < GV_TARGET_REC.MFB_V2_PARENT_JOB_ID ) -- ITS NOT A FORCED RERUN
		AND TRUNC(GV_TARGET_REC.MFB_V2_UPDATE_DATE) = TRUNC(SYSDATE) --<< IT SHOULD HAVE BEEN CALCULATED TODAY
		THEN
				GV_SRC_REC_SUMMARY.AGE_IN_BUSINESS_DAYS := GV_TARGET_REC.AGE_IN_BUSINESS_DAYS;
				GV_SRC_REC_SUMMARY.AGE_IN_CALENDAR_DAYS	:= GV_TARGET_REC.AGE_IN_CALENDAR_DAYS;
				GV_SRC_REC_SUMMARY.TIMELINESS_STATUS	:= GV_TARGET_REC.TIMELINESS_STATUS;
				GV_SRC_REC_SUMMARY.TIMELINESS_DT		:= GV_TARGET_REC.TIMELINESS_DT;
				GV_SRC_REC_SUMMARY.JEOPARDY_FLAG		:= GV_TARGET_REC.JEOPARDY_FLAG;
				GV_SRC_REC_SUMMARY.JEOPARDY_DT			:= GV_TARGET_REC.JEOPARDY_DT;
		ELSE
			-- Calculate the 'Derived' fields to match D_FMB_CURRENT ( v1 )
			-- ONCE A DAY PER BATCH_GUID
			GV_AGE_IN_BUSINESS_DAYS := BPM_COMMON.BUS_DAYS_BETWEEN(
								GV_SRC_REC_SUMMARY.CREATE_DT,
								nvl(GV_SRC_REC_SUMMARY.batch_complete_dt,sysdate)
								);

			GV_SRC_REC_SUMMARY.AGE_IN_BUSINESS_DAYS :=  GV_AGE_IN_BUSINESS_DAYS;

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


		END IF;

		IF GV_SRC_REC_SUMMARY.REPROCESSED_DATE IS NOT NULL
		AND GV_SRC_REC_SUMMARY.REPROCESSED_FLAG = 'Y'
		THEN
			GV_SRC_REC_SUMMARY.CANCEL_DT := GV_SRC_REC_SUMMARY.REPROCESSED_DATE;
			GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT := GV_SRC_REC_SUMMARY.REPROCESSED_DATE;
			GV_SRC_REC_SUMMARY.INSTANCE_STATUS := 'Complete';
		END IF;

		GV_START_DATE := GV_SRC_REC_SUMMARY.CREATE_DT;

		-- DBMS_OUTPUT.PUT_LINE('INSERT UPDATE TEST GV_TARGET_ROWID; '||GV_TARGET_ROWID);							    -- DEBUG
		-- DBMS_OUTPUT.PUT_LINE('INSERT UPDATE TEST GV_SRC_REC_SUMMARY.BATCH_GUID; '||GV_SRC_REC_SUMMARY.BATCH_GUID);	-- DEBUG


        IF GV_TARGET_ROWID IS NULL
			AND GV_SRC_REC_SUMMARY.BATCH_GUID IS NOT NULL
			THEN
				GV_MFB_V2_BI_ID			:= SEQ_NYHIX_MFB_BATCH_SUMMARY_ID.NEXTVAL; --<< SEQUENCE FOR NYHIX)MFB_V2_BATCH_SUMMARY
				GV_MFB_V2_CREATE_DATE	:= SYSDATE;
				GV_MFB_V2_UPDATE_DATE   := TO_DATE(NULL);

				INSERT_BATCH_SUMMARY();

				LOAD_F_BY_DAY(NVL(GV_SRC_REC_SUMMARY.BATCH_GUID,
								  GV_TARGET_REC.BATCH_GUID
								  )
							);

				LOAD_F_MFB_V2_BY_HOUR(
						GV_MFB_V2_BI_ID,   						--<< P_MFB_V2_BI_ID
						GV_SRC_REC_SUMMARY.BATCH_GUID, 			--<< P_BATCH_GUID
						SYSDATE,								--<< P_EVENT_DATE
						GV_SRC_REC_SUMMARY.CREATE_DT,			--<< P_CREATE_DT
						GV_END_DATE,							--<< P_END_DT
						GV_SRC_REC_SUMMARY.CANCEL_DT,		    --<< P_CANCELLED_DT
						GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT,	--<< P_BATCH_COMPLETED_DT
						GV_SRC_REC_SUMMARY.REPROCESSED_FLAG,	--<< P_REPROCESSED_FLAG
						GV_SRC_REC_SUMMARY.REPROCESSED_DATE		--<< P_REPROCESSED_DATE
						);


            ELSIF GV_TARGET_ROWID IS NOT NULL
				AND GV_SRC_REC_SUMMARY.BATCH_GUID IS NOT NULL
				THEN
					GV_MFB_V2_BI_ID			:= GV_TARGET_REC.MFB_V2_BI_ID;
					GV_MFB_V2_CREATE_DATE	:= GV_TARGET_REC.CREATE_DT;
					GV_MFB_V2_UPDATE_DATE   := SYSDATE;

					UPDATE_BATCH_SUMMARY();

					LOAD_F_BY_DAY(NVL(GV_SRC_REC_SUMMARY.BATCH_GUID,
									  GV_TARGET_REC.BATCH_GUID
									 )
							     );

                    LOAD_F_MFB_V2_BY_HOUR(
						GV_MFB_V2_BI_ID,   						--<< P_MFB_V2_BI_ID
						GV_SRC_REC_SUMMARY.BATCH_GUID, 			--<< P_BATCH_GUID
						SYSDATE,								--<< P_EVENT_DATE
						GV_SRC_REC_SUMMARY.CREATE_DT,			--<< P_CREATE_DT
						GV_END_DATE,							--<< P_END_DT
						GV_SRC_REC_SUMMARY.CANCEL_DT,		    --<< P_CANCELLED_DT
						GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT,	--<< P_BATCH_COMPLETED_DT
						GV_SRC_REC_SUMMARY.REPROCESSED_FLAG,	--<< P_REPROCESSED_FLAG
						GV_SRC_REC_SUMMARY.REPROCESSED_DATE		--<< P_REPROCESSED_DATE
						);


            ELSIF GV_TARGET_ROWID IS NOT NULL
				AND GV_SRC_REC_SUMMARY.BATCH_GUID IS NULL
				THEN DELETE_BATCH_SUMMARY(); --<< *** see notes in this procedure ***

					LOAD_F_BY_DAY(NVL(GV_SRC_REC_SUMMARY.BATCH_GUID,
									  GV_TARGET_REC.BATCH_GUID
									 )
								);

                    LOAD_F_MFB_V2_BY_HOUR(
						GV_MFB_V2_BI_ID,   						--<< P_MFB_V2_BI_ID
						GV_SRC_REC_SUMMARY.BATCH_GUID, 			--<< P_BATCH_GUID
						SYSDATE,								--<< P_EVENT_DATE
						GV_SRC_REC_SUMMARY.CREATE_DT,			--<< P_CREATE_DT
						GV_END_DATE,							--<< P_END_DT
						GV_SRC_REC_SUMMARY.CANCEL_DT,		    --<< P_CANCELLED_DT
						GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT,	--<< P_BATCH_COMPLETED_DT
						GV_SRC_REC_SUMMARY.REPROCESSED_FLAG,	--<< P_REPROCESSED_FLAG
						GV_SRC_REC_SUMMARY.REPROCESSED_DATE		--<< P_REPROCESSED_DATE
						);

			END IF;

		COMMIT;

	EXCEPTION

		WHEN NO_DATA_FOUND
		THEN
			NULL;

        WHEN OTHERS THEN
            GV_ERROR_CODE 			:= SQLCODE;
            GV_ERROR_MESSAGE 		:= SUBSTR(SQLERRM, 1, 3000);
			GV_DRIVER_KEY_NUMBER  	:= 'GV_SRC_REC_SUMMARY.BATCH_GUID : '||GV_SRC_REC_SUMMARY.BATCH_GUID;
			GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_V2_BATCH_SUMMARY';
			GV_ERR_LEVEL		  	:= 'CRITICAL';
			GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.PROCESS_ONE_BATCH';

			-- DBMS_OUTPUT.PUT_LINE('Main Cursor failure for BATCH_GUID '||GV_BATCH_GUID
			--	||'  SQLCODE '||GV_ERROR_CODE
			--	||' '||GV_ERROR_MESSAGE);

			POST_ERROR;

			ROLLBACK;

			RAISE;

	END PROCESS_ONE_BATCH;
---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
PROCEDURE PROCESS_RUN_LIST(P_PARENT_JOB_ID varchar default null) IS
	 LV_RECORD_COUNT   number := 0;

BEGIN

    LV_RECORD_COUNT  := 0;

		IF (BATCH_GUID_CSR%ISOPEN)
		THEN
			CLOSE BATCH_GUID_CSR;
		END IF;

		OPEN BATCH_GUID_CSR;

		LOOP  -- Main "Driving" Loop

			FETCH BATCH_GUID_CSR INTO GV_SOURCE_SERVER, GV_BATCH_GUID;

			EXIT WHEN BATCH_GUID_CSR%NOTFOUND;

			 LV_RECORD_COUNT :=  LV_RECORD_COUNT + 1;

			if GV_RECORD_COUNT < 10 -- DEBUG
			then
			DBMS_OUTPUT.PUT_LINE('Processing RUN LIST: '||GV_SOURCE_SERVER||' '||GV_BATCH_GUID);
			end if;

			PROCESS_ONE_BATCH(GV_SOURCE_SERVER, GV_BATCH_GUID);

		END LOOP;

		COMMIT;


		IF (BATCH_GUID_CSR%ISOPEN)
		THEN
			CLOSE BATCH_GUID_CSR;
		END IF;


	EXCEPTION

		WHEN NO_DATA_FOUND
		THEN
			NULL;

        WHEN OTHERS THEN
            GV_ERROR_CODE 			:= SQLCODE;
            GV_ERROR_MESSAGE 		:= SUBSTR(SQLERRM, 1, 3000);
			GV_DRIVER_KEY_NUMBER  	:= 'GV_SRC_REC_SUMMARY.BATCH_GUID : '||GV_SRC_REC_SUMMARY.BATCH_GUID;
			GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_V2_BATCH_SUMMARY';
			GV_ERR_LEVEL		  	:= 'CRITICAL';
			GV_FILE_NAME 			:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.PROCESS_RUN_LIST';

			-- DBMS_OUTPUT.PUT_LINE('Main Cursor failure for BATCH_GUID '||GV_BATCH_GUID
			--	||'  SQLCODE '||GV_ERROR_CODE
			--	||' '||GV_ERROR_MESSAGE);

			POST_ERROR;

			ROLLBACK;

			RAISE;

END PROCESS_RUN_LIST;

-----------------------------------------------------
-- *************************************************************************
-- *************************************************************************
-- *************************************************************************
-----------------------------------------------------

-------------------------------------------------------------------------------------------
-- THE CURSOR USES SQL FROM QUERIES 1, 2, 3 AND 4
-------------------------------------------------------------------------------------------
PROCEDURE Extract_CORP_ETL_CONTROL IS
BEGIN
	SELECT /*+ RESULT_CACHE +*/
        MAX(CASE WHEN NAME = 'MFB_SCAN_MODULE_NAME'
			THEN VALUE END) AS  GV_MFB_SCAN_MODULE_NAME,
        MAX(CASE WHEN NAME = 'MFB_QC_MODULE_NAME'
			THEN VALUE END) AS  GV_MFB_QC_MODULE_NAME,
        MAX(CASE WHEN NAME = 'MFB_CLASSIFICATION_MODULE_NAME'
			THEN VALUE END) AS  GV_MFB_CLASSIFICATION_MODULE_NAME,
        MAX(CASE WHEN NAME = 'MFB_RECOGNITION_MODULE_NAME'
			THEN VALUE END) AS  GV_MFB_RECOGNITION_MODULE_NAME,
        MAX(CASE WHEN NAME = 'MFB_VALIDATION_MODULE_NAME'
			THEN VALUE END) AS  GV_MFB_VALIDATION_MODULE_NAME,
        MAX(CASE WHEN NAME = 'MFB_PDF_MODULE_NAME'
			THEN VALUE END) AS  GV_MFB_PDF_MODULE_NAME,
        MAX(CASE WHEN NAME = 'MFB_REPORT_MODULE_NAME'
			THEN VALUE END) AS  GV_MFB_REPORT_MODULE_NAME,
        MAX(CASE WHEN NAME = 'MFB_EXPORT_MODULE_NAME'
			THEN VALUE END) AS  GV_MFB_EXPORT_MODULE_NAME,
        MAX(CASE WHEN NAME = 'MFB_BATCH_CLASS_LIST9'
			THEN VALUE END) AS  GV_MFB_BATCH_CLASS_LIST9,
        MAX(CASE WHEN NAME = 'MFB_BATCH_CLASS_LIST10'
			THEN VALUE END) AS  GV_MFB_BATCH_CLASS_LIST10,
        MAX(CASE WHEN NAME = 'MFB_REPORTING_PERIOD_TYPE'
			THEN VALUE END) AS  GV_MFB_REPORTING_PERIOD_TYPE
--
       		INTO
			GV_MFB_SCAN_MODULE_NAME,
			GV_MFB_QC_MODULE_NAME,
			GV_MFB_CLASSIFICATION_MODULE_NAME,
			GV_MFB_RECOGNITION_MODULE_NAME,
			GV_MFB_VALIDATION_MODULE_NAME,
			GV_MFB_PDF_MODULE_NAME,
			GV_MFB_REPORT_MODULE_NAME,
			GV_MFB_EXPORT_MODULE_NAME,
			GV_MFB_BATCH_CLASS_LIST9,
			GV_MFB_BATCH_CLASS_LIST10,
			GV_MFB_REPORTING_PERIOD_TYPE
--
    FROM CORP_ETL_CONTROL
	WHERE SUBSTR(NAME,1,4) = 'MFB_'
    AND SUBSTR(NAME,1,6) <> 'MFB_V2'
;

	SELECT /*+ RESULT_CACHE +*/
            max(CASE WHEN NAME = 'MFB_TIMELINESS_DAYS' THEN OUT_VAR END) AS MFB_TIMELINESS_DAYS,
            max(CASE WHEN NAME = 'MFB_TIMELINESS_DAYS_TYPE' THEN OUT_VAR END) AS MFB_TIMELINESS_DAYS_TYPE,
            max(CASE WHEN NAME = 'MFB_JEOPARDY_DAYS' THEN OUT_VAR END) AS MFB_JEOPARDY_DAYS,
            max(CASE WHEN NAME = 'MFB_JEOPARDY_DAYS_TYPE' THEN OUT_VAR END) AS MFB_JEOPARDY_DAYS_TYPE,
            max(CASE WHEN NAME = 'MFB_TARGET_DAYS' THEN OUT_VAR END) AS MFB_TARGET_DAYS
	--
		INTO
            GV_TIMELINESS_DAYS,
            GV_TIMELINESS_DAYS_TYPE,
            GV_JEOPARDY_DAYS,
            GV_JEOPARDY_DAYS_TYPE,
            GV_TARGET_DAYS
    --
	FROM CORP_ETL_LIST_LKUP
	WHERE NAME LIKE 'MFB%DAYS%';

	/*
        DBMS_OUTPUT.PUT_LINE('GV_MFB_SCAN_MODULE_NAME: 			'||GV_MFB_SCAN_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_QC_MODULE_NAME:			'||GV_MFB_QC_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_CLASSIFICATION_MODULE_NAME: '||GV_MFB_CLASSIFICATION_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_RECOGNITION_MODULE_NAME: 	'||GV_MFB_RECOGNITION_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_VALIDATION_MODULE_NAME: 	'||GV_MFB_VALIDATION_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_PDF_MODULE_NAME: 			'||GV_MFB_PDF_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_REPORT_MODULE_NAME: 		'||GV_MFB_REPORT_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_EXPORT_MODULE_NAME: 		'||GV_MFB_EXPORT_MODULE_NAME);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_BATCH_CLASS_LIST9: 		'||GV_MFB_BATCH_CLASS_LIST9);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_BATCH_CLASS_LIST10: 		'||GV_MFB_BATCH_CLASS_LIST10);
        DBMS_OUTPUT.PUT_LINE('GV_MFB_REPORTING_PERIOD_TYPE: 		'||GV_MFB_REPORTING_PERIOD_TYPE);

        DBMS_OUTPUT.PUT_LINE('GV_TIMELINESS_DAYS:      '||GV_TIMELINESS_DAYS);
        DBMS_OUTPUT.PUT_LINE('GV_TIMELINESS_DAYS_TYPE: '||GV_TIMELINESS_DAYS_TYPE);
        DBMS_OUTPUT.PUT_LINE('GV_JEOPARDY_DAYS:        '||GV_JEOPARDY_DAYS);
        DBMS_OUTPUT.PUT_LINE('GV_JEOPARDY_DAYS_TYPE"   '||GV_JEOPARDY_DAYS_TYPE);
        DBMS_OUTPUT.PUT_LINE('GV_TARGET_DAYS:          '||GV_TARGET_DAYS);
	*/

	EXCEPTION
		WHEN OTHERS THEN
	        GV_ERROR_CODE := SQLCODE;
            GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 3000);
			GV_DRIVER_KEY_NUMBER  	:= 'N/A';
			GV_DRIVER_TABLE_NAME  	:= 'CORP_ETL_CONTROL';
			GV_ERR_LEVEL		  	:= 'CRITICAL';
			GV_FILE_NAME 			:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.Extract_CORP_ETL_CONTROL';

			-- DBMS_OUTPUT.PUT_LINE('**** FAILED TO EXTRACT CORP_ETL_CONTROL ****');
			POST_ERROR;

			RAISE;

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
       GV_SRC_REC_SUMMARY.REPROCESSED_DATE := TO_DATE(NULL);		-- 	8	VARCHAR2
       GV_SRC_REC_SUMMARY.CREATION_STATION_ID := NULL;	  			-- 	9	VARCHAR2
       GV_SRC_REC_SUMMARY.CREATION_USER_NAME := NULL;	  			-- 	10	VARCHAR2
       GV_SRC_REC_SUMMARY.CREATION_USER_ID := NULL;	  				-- 	11	VARCHAR2
       GV_SRC_REC_SUMMARY.BATCH_CLASS := NULL;	  					-- 	12	VARCHAR2
       GV_SRC_REC_SUMMARY.BATCH_CLASS_DES := NULL;	  				-- 	13	VARCHAR2
       GV_SRC_REC_SUMMARY.BATCH_TYPE := NULL;	  					-- 	14	VARCHAR2
       GV_SRC_REC_SUMMARY.CREATE_DT := TO_DATE(NULL);	  			-- 	15	DATE
       GV_SRC_REC_SUMMARY.COMPLETE_DT := TO_DATE(NULL);	  			-- 	16	DATE
       GV_SRC_REC_SUMMARY.INSTANCE_STATUS := 'Active';	  			-- 	17	VARCHAR2
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
       GV_SRC_REC_SUMMARY.BATCH_DELETED := 'N';	  			    	-- 	58	VARCHAR2
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

	   GV_AGE_IN_BUSINESS_DAYS 		:= 0;
	   GV_END_DATE					:= TO_DATE(NULL);
	   GV_START_DATE				:= TO_DATE(NULL);

EXCEPTION
    WHEN OTHERS
		THEN

	        GV_ERROR_CODE 			:= SQLCODE;
            GV_ERROR_MESSAGE 		:= SUBSTR(SQLERRM, 1, 3000);
			GV_DRIVER_KEY_NUMBER  	:= 'N/A';
			GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_V2_BATCH_SUMMARY';
			GV_ERR_LEVEL		  	:= 'CRITICAL';
			GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.INITIALIZE_GV_SRC_REC_SUMMARY';

			-- DBMS_OUTPUT.PUT_LINE('**** FAILED TO INITIALIZE_GV_SRC_REC_SUMMARY ****');
			POST_ERROR;

			RAISE;

END INITIALIZE_GV_SRC_REC_SUMMARY;

-- *****************************************************
-- *****************************************************

PROCEDURE LOAD_F_MFB_V2_BY_HOUR(
	P_MFB_V2_BI_ID 			NUMBER DEFAULT NULL,
	P_BATCH_GUID 			VARCHAR DEFAULT NULL,
	P_EVENT_DATE 			DATE DEFAULT NULL,
	P_CREATE_DT				DATE DEFAULT NULL,
	P_END_DATE				DATE DEFAULT NULL,
	P_CANCELLED_DT			DATE DEFAULT NULL,
	P_BATCH_COMPLETED_DT	DATE DEFAULT NULL,
	P_REPROCESSED_FLAG		VARCHAR DEFAULT 'N',
	P_REPROCESSED_DATE		DATE DEFAULT NULL
	)
IS
-- *****************************************************
-- MFB_V2 REPLACEMENT FOR Update fact for BPM Semantic model - Mail Fax Batch Process
-- *****************************************************

	LV_ROW_COUNT						NUMBER			:= 0;
	LV_DATE_BEFORE_COUNT				NUMBER			:= 0;
	LV_DATE_AFTER_COUNT					NUMBER			:= 0;

--    LV_PROCEDURE_NAME 					VARCHAR2(61) 	:= $$PLSQL_UNIT || '.' || 'LOAD_F_MFB_V2_BY_HOUR';
--	LV_DATE_BPM_COMMON_DATE_FMT 		VARCHAR2(21)	:= 'YYYY-MM-DD HH24:MI:SS'; -- << BPM_COMMON.Date_FMT
	LV_DATE_BUCKET_FMT 					VARCHAR2(21) 	:= 'YYYY-MM-DD HH24'; -- << BUCKET_Date_FMT



	-- THESE ARE USED TO UPDATE THE LAST RCORD
	-- PRIOR TO INSERTING THE NEW RECORD

    LV_MFB_V2_FBH_ID_OLD 				NUMBER 			:= NULL;
    LV_D_DATE_OLD 						DATE 			:= NULL;
	LV_BUCKET_START_DATE_OLD			DATE 			:= NULL;
	LV_BUCKET_END_DATE_OLD				DATE 			:= NULL;
    LV_CREATION_COUNT_OLD 				NUMBER 			:= NULL;
    LV_COMPLETION_COUNT_OLD 			NUMBER 			:= NULL;
    LV_MAX_D_DATE_OLD 					DATE 			:= NULL;


	LV_BUCKET_START_DATE    DATE 		:= NULL;
	LV_BUCKET_END_DATE      DATE 		:= NULL;


	LV_FACT_BY_HOUR_REC							F_MFB_V2_BY_HOUR%ROWTYPE;

	BEGIN

		GV_FACT_BY_HOUR_UPDATE_COUNT := GV_FACT_BY_HOUR_UPDATE_COUNT + 1;

		LV_DATE_BEFORE_COUNT	:= 0;
		LV_DATE_AFTER_COUNT		:= 0;
		LV_ROW_COUNT			:= 0;


		-- DBMS_OUTPUT.PUT_LINE('*************************  GV_END_DATE: '||NVL(TO_CHAR(GV_END_DATE,'YYYY.MM/DD HH24:MI:SS'),'NULL'));

		SELECT COUNT(*),
			SUM(CASE WHEN D_DATE < P_CREATE_DT THEN 1 ELSE 0 END),
			SUM(CASE WHEN D_DATE > GV_END_DATE THEN 1 ELSE 0 END)
		INTO LV_ROW_COUNT, LV_DATE_BEFORE_COUNT, LV_DATE_AFTER_COUNT
		FROM F_MFB_V2_BY_HOUR
		WHERE MFB_V2_BI_ID	=	P_MFB_V2_BI_ID;

		IF LV_DATE_BEFORE_COUNT > 0
		THEN
			DELETE FROM F_MFB_V2_BY_HOUR
			WHERE MFB_V2_BI_ID	=	P_MFB_V2_BI_ID
			AND BUCKET_END_DATE < GV_END_DATE;

            GV_F_MFB_V2_BY_HOUR_DELETE_COUNT := GV_F_MFB_V2_BY_HOUR_DELETE_COUNT + SQL%ROWCOUNT;

		END IF;


		IF LV_DATE_AFTER_COUNT > 0
		THEN
			DELETE FROM F_MFB_V2_BY_HOUR
			WHERE MFB_V2_BI_ID	=	P_MFB_V2_BI_ID
			AND BUCKET_START_DATE > GV_END_DATE;

            GV_F_MFB_V2_BY_HOUR_DELETE_COUNT := GV_F_MFB_V2_BY_HOUR_DELETE_COUNT + SQL%ROWCOUNT;

		END IF;

		IF LV_ROW_COUNT - (LV_DATE_BEFORE_COUNT + LV_DATE_AFTER_COUNT ) <= 0
		THEN
			RETURN;
		END IF;

		-- GET THE MOST RECENT FACT AND SAVE TO THE 'OLD' LVs

		LV_MFB_V2_FBH_ID_OLD := NULL;

		BEGIN

			WITH MOST_RECENT_FACT AS
			(SELECT
				MAX(F_MFB_V2_FBH_ID) MAX_FBH_ID,
				MAX(D_DATE) MAX_D_DATE
			FROM F_MFB_V2_BY_HOUR
			WHERE MFB_V2_BI_ID = P_MFB_V2_BI_ID
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

				GV_ERROR_CODE 			:= SQLCODE;
				GV_ERROR_MESSAGE 		:= SUBSTR(SQLERRM, 1, 3000);
				GV_DRIVER_KEY_NUMBER  	:= 'F_MFB_V2_FBH_ID: '||P_MFB_V2_BI_ID;
				GV_DRIVER_TABLE_NAME  	:= 'F_MFB_V2_BY_HOUR';
				GV_ERR_LEVEL		  	:= 'LOG';
				GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.INSERT_F_MFB_V2_BY_HOUR';

            --  DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE_F_MFB_V2_BY_HOUR GET RICENT DATA'||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
            --  DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE_F_MFB_V2_BY_HOUR GET RICENT DATA FOR P_MFB_V2_BI_ID '||P_MFB_V2_BI_ID);

				POST_ERROR;

				RETURN;

		END;

       -- Do not modify fact table further once an instance has EVER been
	   -- completed or cancelled.

		-- See if a Fact record was returned
		IF LV_MFB_V2_FBH_ID_OLD IS NULL
		AND LV_COMPLETION_COUNT_OLD >= 1 THEN
            GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT := GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT + 1;
			RETURN;
		END IF;

		LV_BUCKET_START_DATE	:= TO_DATE(TO_CHAR(P_CREATE_DT,'YYYY/MM/DD HH24'),'YYYY/MM/DD HH24');
		LV_BUCKET_END_DATE	    := TO_DATE(TO_CHAR(COALESCE(GV_END_DATE,BPM_COMMON.MAX_DATE),'YYYY/MM/DD HH24'),'YYYY/MM/DD HH24');




		-- See if a Fact record was returned
		IF LV_MFB_V2_FBH_ID_OLD IS NULL
		THEN -- << Its possible that there is already a row in Batch Summary
             -- << but not in Fact BY Hour -- Insert the row and RETURN

            -- -- DBMS_OUTPUT.PUT_LINE('INSERT NEW FOR :'||p_batch_guid);

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
				SEQ_NYHIX_MFB_BATCH_BY_HOUR_ID.NEXTVAL,		--<<F_MFB_V2_FBH_ID
				TRUNC(SYSDATE), 							--<< D_DATE,
				LV_BUCKET_START_DATE,						--<< BUCKET_START_DATE
				LV_BUCKET_END_DATE,							--<< LV_BUCKET_END_DATE
				P_MFB_V2_BI_ID,								--<< MFB_V2_BI_ID,
				CASE
					WHEN TO_DATE(TO_CHAR(P_CREATE_DT,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT)
						>= LV_BUCKET_START_DATE
						AND TO_DATE(TO_CHAR(P_CREATE_DT,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT)
						< LV_BUCKET_END_DATE
					THEN 1
					ELSE 0
				END,			--<< AS CREATION_COUNT
				1,				--<< as INVENTORY_COUNT
				CASE
					WHEN TO_DATE(TO_CHAR(P_CREATE_DT,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT)
						>= LV_BUCKET_START_DATE
						AND TO_DATE(TO_CHAR(P_CREATE_DT,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT)
						< LV_BUCKET_END_DATE
					THEN 1
					ELSE 0
				END					--<< as COMPLETION_COUNT
			);

            -- -- DBMS_OUTPUT.PUT_LINE('INSERT NEW RETURN :'||p_batch_guid);

			RETURN;

		END IF;

		-- IF A RECORD WAS NOT RETURNED THEN EXIT

		LV_BUCKET_START_DATE	:= TO_DATE(TO_CHAR(GREATEST(P_CREATE_DT,P_EVENT_DATE),'YYYY/MM/DD HH24'),'YYYY/MM/DD HH24');


		LV_BUCKET_END_DATE	    := TO_DATE(TO_CHAR(COALESCE(GV_END_DATE,BPM_COMMON.MAX_DATE),'YYYY/MM/DD HH24'),'YYYY/MM/DD HH24');

        -- -- DBMS_OUTPUT.PUT_LINE('INSERT NEW CONTINUE :'||p_batch_guid);

		IF 	P_CANCELLED_DT 			IS NULL
		AND P_BATCH_COMPLETED_DT	IS NULL
		AND P_REPROCESSED_DATE		IS NULL
		THEN	--<< it's not completed or cancelled or eprocesed
			LV_FACT_BY_HOUR_REC.D_DATE 				:= P_EVENT_DATE;
			LV_FACT_BY_HOUR_REC.BUCKET_START_DATE 	:= TO_DATE(TO_CHAR(P_EVENT_DATE,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT);
			LV_FACT_BY_HOUR_REC.BUCKET_END_DATE 	:= TO_DATE(TO_CHAR(BPM_COMMON.MAX_DATE,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT);
			LV_FACT_BY_HOUR_REC.INVENTORY_COUNT 	:= 1;
			LV_FACT_BY_HOUR_REC.COMPLETION_COUNT 	:= 0;
		ELSE -- its completed or cancelled
			LV_FACT_BY_HOUR_REC.D_DATE 				:= P_EVENT_DATE;
			LV_FACT_BY_HOUR_REC.BUCKET_START_DATE 	:= TO_DATE(TO_CHAR(GV_END_DATE,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT);
			LV_FACT_BY_HOUR_REC.BUCKET_END_DATE 	:= LV_FACT_BY_HOUR_REC.BUCKET_START_DATE;     --<< this is from the old procedure
			LV_FACT_BY_HOUR_REC.INVENTORY_COUNT 	:= 0;
			LV_FACT_BY_HOUR_REC.COMPLETION_COUNT 	:= 1;
		END IF;

		IF TO_DATE(TO_CHAR(LV_D_DATE_OLD,LV_DATE_BUCKET_FMT),LV_DATE_BUCKET_FMT) = LV_FACT_BY_HOUR_REC.BUCKET_START_DATE
		THEN
		-------------------------------------------------
		-- Same bucket time.
		-------------------------------------------------

			IF LV_CREATION_COUNT_OLD = 1
			THEN
				LV_FACT_BY_HOUR_REC.CREATION_COUNT := LV_CREATION_COUNT_OLD;
			END IF;

			LV_FACT_BY_HOUR_REC.MFB_V2_BI_ID :=  P_MFB_V2_BI_ID;

			UPDATE F_MFB_V2_BY_HOUR
			--	SET ROW = LV_FACT_BY_HOUR_REC
            SET
				-- F_MFB_V2_FBH_ID 			= LV_FACT_BY_HOUR_REC.F_MFB_V2_FBH_ID,
				D_DATE                      = LV_FACT_BY_HOUR_REC.D_DATE,
				BUCKET_START_DATE           = LV_FACT_BY_HOUR_REC.BUCKET_START_DATE,
				BUCKET_END_DATE             = LV_FACT_BY_HOUR_REC.BUCKET_END_DATE,
				-- MFB_V2_BI_ID                = LV_FACT_BY_HOUR_REC.MFB_V2_BI_ID,
				CREATION_COUNT              = LV_FACT_BY_HOUR_REC.CREATION_COUNT,
				INVENTORY_COUNT             = LV_FACT_BY_HOUR_REC.INVENTORY_COUNT,
				COMPLETION_COUNT            = LV_FACT_BY_HOUR_REC.COMPLETION_COUNT
			WHERE F_MFB_V2_FBH_ID = LV_MFB_V2_FBH_ID_OLD;

			ELSE

			-------------------------------------------------
			-- DIFFERENT BUCKET TIME.
			-------------------------------------------------
			-- UPDATE THE 'OLD' RECORD

			UPDATE F_MFB_V2_BY_HOUR
				SET BUCKET_END_DATE = LV_FACT_BY_HOUR_REC.BUCKET_START_DATE
			WHERE F_MFB_V2_FBH_ID = LV_MFB_V2_FBH_ID_OLD;

			LV_FACT_BY_HOUR_REC.F_MFB_V2_FBH_ID := SEQ_NYHIX_MFB_BATCH_BY_HOUR_ID.NEXTVAL;
			LV_FACT_BY_HOUR_REC.MFB_V2_BI_ID    := P_MFB_V2_BI_ID;

			-- INSERT A NEW RECORD

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
				LV_FACT_BY_HOUR_REC.F_MFB_V2_FBH_ID,
				LV_FACT_BY_HOUR_REC.D_DATE,
				LV_FACT_BY_HOUR_REC.BUCKET_START_DATE,
				LV_FACT_BY_HOUR_REC.BUCKET_END_DATE,
				LV_FACT_BY_HOUR_REC.MFB_V2_BI_ID,
				nvl(LV_FACT_BY_HOUR_REC.CREATION_COUNT,0),
				nvl(LV_FACT_BY_HOUR_REC.INVENTORY_COUNT,0),
				nvl(LV_FACT_BY_HOUR_REC.COMPLETION_COUNT,0)
			);

		END IF;

    EXCEPTION

		WHEN NO_DATA_FOUND
		THEN
			NULL;

        WHEN OTHERS THEN

			GV_ERROR_CODE 			:= SQLCODE;
			GV_ERROR_MESSAGE 		:= SUBSTR(SQLERRM, 1, 3000);
			GV_DRIVER_KEY_NUMBER  	:= 'F_MFB_V2_FBH_ID: '||LV_FACT_BY_HOUR_REC.F_MFB_V2_FBH_ID;
			GV_DRIVER_TABLE_NAME  	:= 'F_MFB_V2_BY_HOUR';
			GV_ERR_LEVEL		  	:= 'LOG';
			GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.LOAD_F_MFB_V2_BY_HOUR';

			-- DBMS_OUTPUT.PUT_LINE('FAILED IN LOAD_F_MFB_V2_BY_HOUR'||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
			-- DBMS_OUTPUT.PUT_LINE('FAILED IN LOAD_F_MFB_V2_BY_HOUR FOR P_MFB_V2_BI_ID '||P_MFB_V2_BI_ID);
			-- POST_ERROR;

			RETURN;

    END LOAD_F_MFB_V2_BY_HOUR;

-- *****************************************************
-- *****************************************************

-- *****************************************************
-- *****************************************************
-- *****************************************************

-----------------------------------------------------
PROCEDURE UPDATE_BATCH_SUMMARY IS
--PRAGMA AUTONOMOUS_TRANSACTION;
-----------------------------------------------------

	BEGIN

		--		if gv_batch_guid  = '{960afa66-bbd6-4b4f-b285-886ed74c790e}'
		--	then
		--		DBMS_OUTPUT.PUT_LINE('PROCESS ONE BATCH UPDATE '||GV_SOURCE_SERVER||' '||GV_BATCH_GUID);
		--	end if;


	-- DBMS_OUTPUT.PUT_LINE('UPDATE_BATCH_SUMMARY '||'SRC='||GV_SRC_REC_SUMMARY.REPROCESSED_FLAG||'  TARGET ='||GV_TARGET_REC.REPROCESSED_FLAG);

	-- patch BECAUSE THE INSTANCE_STATUS_DT CANNOT BE NULL 2021/12/07
	GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT := COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,
												GV_SBM_MAX_END_DATE_TIME,
												GV_TARGET_REC.INSTANCE_STATUS_DT);

	IF GV_SRC_REC_SUMMARY.BATCH_GUID = GV_TARGET_REC.BATCH_GUID
	AND
	(
	1 = 2
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
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.REPROCESSED_DATE),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.REPROCESSED_DATE),'?')				-- 	8	VARCHAR2
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
	  )
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
			REPROCESSED_DATE 			= GV_SRC_REC_SUMMARY.REPROCESSED_DATE,    			--	8
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
			BATCH_DELETED 				= nvl(GV_SRC_REC_SUMMARY.BATCH_DELETED,'N'),    				--	58
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

        GV_SQL_CODE 			:= SQLCODE;
        GV_LOG_MESSAGE 			:= SQLERRM;
 		GV_DRIVER_KEY_NUMBER  	:= 'GV_SRC_REC_SUMMARY.BATCH_GUID : '||GV_SRC_REC_SUMMARY.BATCH_GUID;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_V2_BATCH_SUMMARY';
		GV_ERR_LEVEL		  	:= 'LOG';
		GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.UPDATE_BATCH_SUMMARY';

        -- DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE_BATCH_SUMMARY'||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
		-- DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE_BATCH_SUMMARY SRC_BATCH_GUID, SRC_BATCH_NAME'||GV_SRC_REC_SUMMARY.BATCH_guid||' *** '||GV_SRC_REC_SUMMARY.BATCH_NAME);
		---- DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE_BATCH_SUMMARY TARGET_BATCH_GUID, TARGET_BATCH_NAME'||GV_TARGET_REC.BATCH_guid||' *** '||GV_TARGET_REC.BATCH_NAME);

		POST_ERROR;

		RETURN;

	END UPDATE_BATCH_SUMMARY;

-- *****************************************************
-- *****************************************************
-- *****************************************************

PROCEDURE INSERT_BATCH_SUMMARY IS
--PRAGMA AUTONOMOUS_TRANSACTION;
-----------------------------------------------------

	BEGIN

	--    -- DBMS_OUTPUT.PUT_LINE('Inserting Batch_GUID: '||GV_SRC_REC_SUMMARY.BATCH_GUID);

	--			if gv_batch_guid  = '{960afa66-bbd6-4b4f-b285-886ed74c790e}'
	--		then
	--			DBMS_OUTPUT.PUT_LINE('PROCESS ONE BATCH Insert '||GV_SOURCE_SERVER||' '||GV_BATCH_GUID);
	--		end if;


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
        REPROCESSED_DATE,
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
        GV_SRC_REC_SUMMARY.REPROCESSED_DATE,
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
        nvl(GV_SRC_REC_SUMMARY.BATCH_DELETED,'N'),
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

 --   COMMIT;

    GV_SRC_REC_SUMMARY.EXTERNAL_BATCH_ID := 0;
    GV_SRC_REC_SUMMARY.BATCH_PAGE_COUNT := 0;
    GV_SRC_REC_SUMMARY.BATCH_DOC_COUNT := 0;
    GV_SRC_REC_SUMMARY.BATCH_ENVELOPE_COUNT := 0;
    GV_SRC_REC_SUMMARY.BATCH_PRIORITY := 0;
--    GV_SRC_REC_SUMMARY.CEJS_JOB_ID := 0;
--    GV_PARENT_JOB_ID := 0;


	EXCEPTION

        WHEN OTHERS THEN

        GV_SQL_CODE 			:= SQLCODE;
        GV_LOG_MESSAGE 			:= SQLERRM;
 		GV_DRIVER_KEY_NUMBER  	:= 'GV_SRC_REC_SUMMARY.BATCH_GUID : '||GV_SRC_REC_SUMMARY.BATCH_GUID;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_V2_BATCH_SUMMARY';
		GV_ERR_LEVEL		  	:= 'LOG';
		GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.INSERT_BATCH_SUMMARY';

        ---- DBMS_OUTPUT.PUT_LINE('FAILED IN INSERT_BATCH_SUMMARY'||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
        ---- DBMS_OUTPUT.PUT_LINE('FAILED IN INSERT_BATCH_SUMMARY FOR BATCH_GUID '||GV_SRC_REC_SUMMARY.BATCH_GUID);


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

		-- GV_SRC_REC_SUMMARY  := GV_TARGET_REC;

		GV_PROCESSED_COUNT := GV_PROCESSED_COUNT + 1;

	EXCEPTION

        WHEN OTHERS THEN
        GV_SQL_CODE 			:= SQLCODE;
        GV_LOG_MESSAGE 			:= SQLERRM;
 		GV_DRIVER_KEY_NUMBER  	:= 'GV_SRC_REC_SUMMARY.BATCH_GUID : '||GV_SRC_REC_SUMMARY.BATCH_GUID;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_V2_BATCH_SUMMARY';
		GV_ERR_LEVEL		  	:= 'LOG';
		GV_FILE_NAME 			:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.DELETE_BATCH_SUMMARY';

		Post_Error;

	END DELETE_BATCH_SUMMARY;

-- *****************************************************
-- *****************************************************
-- *****************************************************


Procedure Insert_Corp_ETL_Job_Statistics IS
PRAGMA AUTONOMOUS_TRANSACTION;
-----------------------------------------------------
BEGIN

	INSERT INTO CORP_ETL_JOB_STATISTICS (
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
		TO_DATE(NULL),	 			-- JOB_END_DATE
		GV_JOB_ID, 					-- JOB_ID
		substr(GV_JOB_NAME,1,80), 	-- JOB_NAME
		GV_JOB_START_DATE, 			-- JOB_START_DATE
		'STARTED', 					-- JOB_STATUS_CD
		GV_PARENT_JOB_ID, 			-- PARENT_JOB_ID
		GV_PROCESSED_COUNT, 		-- PROCESSED_COUNT
		GV_RECORD_COUNT, 			-- RECORD_COUNT
		GV_RECORD_INSERTED_COUNT,	-- RECORD_INSERTED_COUNT
		GV_RECORD_UPDATED_COUNT, 	-- RECORD_UPDATED_COUNT
		GV_WARNING_COUNT); 			-- WARNING_COUNT

	COMMIT;

EXCEPTION
	WHEN OTHERS THEN

        GV_SQL_CODE 			:= SQLCODE;
        GV_LOG_MESSAGE 			:= SQLERRM;
 		GV_DRIVER_KEY_NUMBER  	:= 'GV_JOB_ID : '||GV_JOB_ID;
		GV_DRIVER_TABLE_NAME  	:= 'Corp_ETL_Job_Statistics';
		GV_ERR_LEVEL		  	:= 'CRITICAL';
		GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.Insert_Corp_ETL_Job_Statistics';

		Post_Error;

		RAISE;

END Insert_Corp_ETL_Job_Statistics;

-- *****************************************************
-- *****************************************************
-- *****************************************************

Procedure Update_Corp_ETL_Job_Statistics IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

	UPDATE CORP_ETL_JOB_STATISTICS
	SET
		ERROR_COUNT       		= GV_ERROR_COUNT,
		FILE_NAME            	= GV_FILE_NAME,
		JOB_END_DATE         	= SYSDATE,
--		JOB_ID                	= GV_JOB_ID,
		JOB_NAME              	= substr(GV_JOB_NAME,1,80),
		JOB_START_DATE        	= GV_JOB_START_DATE,
		JOB_STATUS_CD         	= 'COMPLETED',
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

        GV_SQL_CODE 			:= SQLCODE;
        GV_LOG_MESSAGE 			:= SQLERRM;
 		GV_DRIVER_KEY_NUMBER  	:= 'GV_JOB_ID : '||GV_JOB_ID;
		GV_DRIVER_TABLE_NAME  	:= 'Corp_ETL_Job_Statistics';
		GV_ERR_LEVEL		  	:= 'CRITICAL';
		GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.Update_Corp_ETL_Job_Statistics';

		Post_Error;

        -- DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE JOB STATISTICS '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);

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
	GV_ERROR_FIELD  := 'BATCH_GUID: '||GV_BATCH_GUID;

	GV_UPDATE_TS 	:= SYSDATE;


	INSERT INTO CORP_ETL_ERROR_LOG (
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
		GV_ERR_LEVEL,
		GV_ERROR_CODES,
		GV_ERROR_MESSAGE,
		GV_ERROR_FIELD,
		GV_JOB_NAME,
		GV_NR_OF_ERROR,
		GV_PROCESS_NAME
--		GV_UPDATE_TS
		);

--	COMMIT;

EXCEPTION

	When Others then

        GV_SQL_CODE 			:= SQLCODE;
        GV_LOG_MESSAGE 			:= SQLERRM;
 		GV_DRIVER_KEY_NUMBER  	:= 'GV_JOB_ID : '||GV_JOB_ID;
		GV_DRIVER_TABLE_NAME  	:= 'CORP_ETL_ERROR_LOG';
		GV_ERR_LEVEL		  	:= 'CRITICAL';
		GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.Post_Error';

        -- DBMS_OUTPUT.PUT_LINE('FAILED IN POST ERROR '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
		-- DBMS_OUTPUT.PUT_LINE('Procedure Post_Error failed with '||GV_Error_Code||': '||GV_Error_Message);

		RAISE;


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
		REPROCESSED_DATE,
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
		GV_TARGET_REC.REPROCESSED_DATE,
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

        GV_SQL_CODE 			:= SQLCODE;
        GV_LOG_MESSAGE 			:= SQLERRM;
 		GV_DRIVER_KEY_NUMBER  	:= 'BATCH_GUID : '||P_BATCH_GUID;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_V2_BATCH_SUMMARY';
		GV_ERR_LEVEL		  	:= 'LOG';
		GV_FILE_NAME 			:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.Extract_Target';

        ---- DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT TARGET '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
        ---- DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT TARGET FOR P_BATCH_GUID '||P_BATCH_GUID );

		Post_Error;

		RETURN;

	End Extract_Target;

-- *****************************************************
-- *****************************************************
-- *****************************************************

Procedure Extract_Stats_Batch( P_SOURCE_SERVER VARCHAR DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS
	BEGIN

		-- DBMS_OUTPUT.PUT_LINE('Extract_Stats_Batch - P_SOURCE_SERVER: '||P_SOURCE_SERVER); -- DEBUG
		-- DBMS_OUTPUT.PUT_LINE('Extract_Stats_Batch - p_Batch_GUID: '||p_Batch_GUID); -- DEBUG


		SELECT
			BATCH_GUID,
			EXTERNAL_BATCH_ID,
			BATCH_NAME,
			SOURCE_SERVER,
			BATCH_DESCRIPTION,
			NVL(REPROCESSED_FLAG,'N') AS REPROCESSED_FLAG,
			REPROCESSED_DATE,
			CREATION_STATION_ID,
			CREATION_USER_NAME,
			CREATION_USER_ID,
			BATCH_CLASS,
			BATCH_CLASS_DESCRIPTION,
			--BATCH_TYPE,
			SBM_MIN_START_DATE_TIME AS CREATE_DT,
			SBM_MAX_END_DATE_TIME,
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
			GV_SRC_REC_SUMMARY.REPROCESSED_DATE,
			GV_SRC_REC_SUMMARY.CREATION_STATION_ID,
			GV_SRC_REC_SUMMARY.CREATION_USER_NAME,
			GV_SRC_REC_SUMMARY.CREATION_USER_ID,
			GV_SRC_REC_SUMMARY.BATCH_CLASS,
			GV_SRC_REC_SUMMARY.BATCH_CLASS_DES,
			--GV_SRC_REC_SUMMARY.BATCH_TYPE,
			GV_SRC_REC_SUMMARY.CREATE_DT,
			GV_SBM_MAX_END_DATE_TIME,
            GV_SRC_REC_SUMMARY.batch_type
		FROM NYHIX_MFB_V2_STATS_BATCH
		WHERE SOURCE_SERVER = P_SOURCE_SERVER
        AND BATCH_GUID = 	P_BATCH_GUID;

		-- DBMS_OUTPUT.PUT_LINE('Extract_Stats_Batch - GV_SRC_REC_SUMMARY.BATCH_GUID: '||GV_SRC_REC_SUMMARY.BATCH_GUID); -- DEBUG

	EXCEPTION
		WHEN NO_DATA_FOUND
			THEN

               -- DBMS_OUTPUT.PUT_LINE('Extract_Stats_Batch: P_SOURCE_SERVER, p_BATCH_GUID : '||P_SOURCE_SERVER||', '||p_Batch_GUID||' NOT found'); -- DEBUG
               GV_SRC_REC_SUMMARY.BATCH_GUID := p_Batch_GUID;																						-- DEBUG
			NULL;

		WHEN OTHERS
		THEN

			GV_SQL_CODE 			:= SQLCODE;
			GV_LOG_MESSAGE 			:= SQLERRM;
			GV_DRIVER_KEY_NUMBER  	:= 'BATCH_GUID : '||P_BATCH_GUID;
			GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_V2_STATS_BATCH';
			GV_ERR_LEVEL		  	:= 'LOG';
			GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.Extract_Stats_Batch';

            ---- DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT STATS BATCH '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
            ---- DBMS_OUTPUT.PUT_LINE('FAILED TO Extract_Stats_Batch FOR '||P_SOURCE_SERVER||' '||P_BATCH_GUID);

			POST_ERROR;

			RETURN;

	End Extract_Stats_Batch;

-- *****************************************************
-- *****************************************************
-- *****************************************************

Procedure Extract_Document(P_SOURCE_SERVER varchar DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS

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

			GV_SQL_CODE 			:= SQLCODE;
			GV_LOG_MESSAGE 			:= SQLERRM;
			GV_DRIVER_KEY_NUMBER  	:= 'BATCH_GUID : '||P_BATCH_GUID;
			GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_V2_DOCUMENT';
			GV_ERR_LEVEL		  	:= 'LOG';
			GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.Extract_Document';

            ---- DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT DOCUMENT '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
            ---- DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT DOCUMENT FOR P_BATCH_GUID '||P_BATCH_GUID );

			POST_ERROR;

			RETURN;

	End Extract_Document;

-- *****************************************************
-- *****************************************************
-- *****************************************************


Procedure Extract_Envelope(P_SOURCE_SERVER varchar DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS

    -- NOTE THIS TABLE IS CENTRAL ONLY.. THE P_SOURCE_SERVER IS NOT NEEDED

	BEGIN
		null;
	End Extract_Envelope;

-- *****************************************************
-- *****************************************************
-- *****************************************************

Procedure Extract_Stats_Batch_Module ( P_SOURCE_SERVER varchar DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS
--GV_SRC_REC_STATS_BATCH_MODULE
	BEGIN
		null;
	End Extract_Stats_Batch_Module;

-- *****************************************************
-- *****************************************************
-- *****************************************************

Procedure Extract_Maxdat_Reporting(P_SOURCE_SERVER varchar DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS
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
			GV_SQL_CODE 			:= SQLCODE;
			GV_LOG_MESSAGE 			:= SQLERRM;
			GV_DRIVER_KEY_NUMBER  	:= 'BATCH_GUID : '||P_BATCH_GUID;
			GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_V2_MAXDAT_REPORTING';
			GV_ERR_LEVEL		  	:= 'LOG';
			GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.Extract_Maxdat_Reporting';

			POST_ERROR;

            ---- DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT MAXDAT REPORTING  '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
            ---- DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT MAXDAT REPORTING FOR P_BATCH_GUID '||P_BATCH_GUID );
			---- DBMS_OUTPUT.PUT_LINE('FAILED TO Extract_Maxdat_Reporting FOR '||P_BATCH_GUID);

			RETURN;


	End Extract_Maxdat_Reporting;

-- *****************************************************
-- *****************************************************
-- *****************************************************

Procedure Extract_Stats_Form_Type ( P_SOURCE_SERVER varchar DEFAULT 'CENTRAL', p_Batch_GUID varchar default null) IS
--GV_SRC_REC_STATS_FORM_TYPE
	BEGIN
		null;
	End Extract_Stats_Form_Type;

-- *****************************************************
-- *****************************************************
-- *****************************************************
-----------------------------------------------------
PROCEDURE UPDATE_F_BY_DAY IS
-- USES SQL FROM 5 AND 6
-----------------------------------------------------

	BEGIN
	-- COMPARE -- SQL FROM SECTION 5
		IF GV_FACT_JOIN_REC.TARGET_BATCH_GUID = GV_FACT_JOIN_REC.SRC_BATCH_GUID
		and ( 1=2
            OR NVL(GV_FACT_JOIN_REC.TARGET_BATCH_GUID,'-?93333')	  <>  	NVL(GV_FACT_JOIN_REC.SRC_BATCH_GUID,'-?93333')	-- 5 	1	VARCHAR2
            OR NVL(GV_FACT_JOIN_REC.TARGET_D_DATE,SYSDATE - 93333)	  <>  	NVL(GV_FACT_JOIN_REC.SRC_D_DATE,SYSDATE - 93333)	-- 5 	2	DATE
            OR NVL(GV_FACT_JOIN_REC.TARGET_MFB_V2_BI_ID, -93333)	  <>  	NVL(GV_FACT_JOIN_REC.SRC_MFB_V2_BI_ID, -93333)	-- 5 	3	NUMBER
       --     OR NVL(GV_FACT_JOIN_REC.TARGET_MFB_V2_CREATE_DATE,SYSDATE - 93333)	  <>  	NVL(GV_FACT_JOIN_REC.SRC_MFB_V2_CREATE_DATE,SYSDATE - 93333)	-- 5 	4	DATE
        --    OR NVL(GV_FACT_JOIN_REC.TARGET_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	  <>  	NVL(GV_FACT_JOIN_REC.SRC_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	-- 5 	5	DATE
            OR NVL(GV_FACT_JOIN_REC.TARGET_CREATE_DT,SYSDATE - 93333)	  <>  	NVL(GV_FACT_JOIN_REC.SRC_CREATE_DT,SYSDATE - 93333)	-- 5 	6	DATE
            OR NVL(GV_FACT_JOIN_REC.TARGET_FAX_BATCH_SOURCE,'-?93333')	  <>  	NVL(GV_FACT_JOIN_REC.SRC_FAX_BATCH_SOURCE,'-?93333')	-- 5 	7	VARCHAR2
            OR NVL(GV_FACT_JOIN_REC.TARGET_BATCH_CLASS,'-?93333')	  <>  	NVL(GV_FACT_JOIN_REC.SRC_BATCH_CLASS,'-?93333')	-- 5 	8	VARCHAR2
            OR NVL(GV_FACT_JOIN_REC.TARGET_CANCEL_DT,SYSDATE - 93333)	  <>  	NVL(GV_FACT_JOIN_REC.SRC_CANCEL_DT,SYSDATE - 93333)	-- 5 	9	DATE
            OR NVL(GV_FACT_JOIN_REC.TARGET_REPROCESSED_FLAG,SYSDATE - 93333)	  <>  	NVL(GV_FACT_JOIN_REC.SRC_REPROCESSED_FLAG,SYSDATE - 93333)	-- 5 	10	DATE
            OR NVL(GV_FACT_JOIN_REC.TARGET_REPROCESSED_DATE,SYSDATE - 93333)	  <>  	NVL(GV_FACT_JOIN_REC.SRC_REPROCESSED_DATE,SYSDATE - 93333)	-- 5 	10	DATE
            OR NVL(GV_FACT_JOIN_REC.TARGET_BATCH_COMPLETE_DT,SYSDATE - 93333)	  <>  	NVL(GV_FACT_JOIN_REC.SRC_BATCH_COMPLETE_DT,SYSDATE - 93333)	-- 5 	11	DATE
            OR NVL(GV_FACT_JOIN_REC.TARGET_AGE_IN_BUSINESS_HOURS, -93333)	  <>  	NVL(GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_HOURS, -93333)	-- 5 	12	NUMBER
            OR NVL(GV_FACT_JOIN_REC.TARGET_AGE_IN_BUSINESS_DAYS, -93333)	  <>  	GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_DAYS
            OR NVL(GV_FACT_JOIN_REC.TARGET_CREATION_COUNT, -93333)	  <>  	NVL(GV_FACT_JOIN_REC.SRC_CREATION_COUNT, -93333)	-- 5 	14	NUMBER
            OR NVL(GV_FACT_JOIN_REC.TARGET_INVENTORY_COUNT, -93333)	  <>  	NVL(GV_FACT_JOIN_REC.SRC_INVENTORY_COUNT, -93333)	-- 5 	15	NUMBER
            OR NVL(GV_FACT_JOIN_REC.TARGET_COMPLETION_COUNT, -93333)	  <>  	NVL(GV_FACT_JOIN_REC.SRC_COMPLETION_COUNT, -93333)	-- 5 	16	NUMBER
            OR NVL(GV_FACT_JOIN_REC.TARGET_CANCELATION_COUNT, -93333)	  <>  	NVL(GV_FACT_JOIN_REC.SRC_CANCELATION_COUNT, -93333)	-- 5 	17	NUMBER
            OR NVL(GV_FACT_JOIN_REC.TARGET_REPROCESSED_COUNT, -93333)	  <>  	NVL(GV_FACT_JOIN_REC.SRC_REPROCESSED_COUNT, -93333)	-- 5 	18	NUMBER
            OR NVL(GV_FACT_JOIN_REC.TARGET_WEEKEND_FLAG,'?')                <>   NVL(GV_FACT_JOIN_REC.SRC_WEEKEND_FLAG,'X')         -- 5 	19,
            OR NVL(GV_FACT_JOIN_REC.TARGET_BUSINESS_DAY_FLAG,'?')           <>   NVL(GV_FACT_JOIN_REC.SRC_BUSINESS_DAY_FLAG,'X')        -- 5 	20,
            OR NVL(GV_FACT_JOIN_REC.TARGET_BATCH_GROUP,'?')                    <>   NVL(GV_FACT_JOIN_REC.SRC_BATCH_GROUP,'?')
            OR NVL(GV_FACT_JOIN_REC.TARGET_BATCH_PROGRAM,'?')                  <>   NVL(GV_FACT_JOIN_REC.SRC_BATCH_PROGRAM,'?')
			)
         THEN
		UPDATE F_MFB_V2_BY_DAY
 		SET
		-- THE UPDATE SQL FROM SECTION 6
            BATCH_GUID                                =  GV_FACT_JOIN_REC.SRC_BATCH_GUID,				-- 6 	1
            D_DATE                                    =  GV_FACT_JOIN_REC.SRC_D_DATE,					-- 6 	2
            MFB_V2_BI_ID                              =  GV_FACT_JOIN_REC.SRC_MFB_V2_BI_ID,				-- 6 	3
            -- MFB_V2_CREATE_DATE                        =  GV_FACT_JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 6 	4
            -- MFB_V2_UPDATE_DATE                        =  GV_FACT_JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 6 	5
            CREATE_DT                                 =  GV_FACT_JOIN_REC.SRC_CREATE_DT,				-- 6 	6
            FAX_BATCH_SOURCE                          =  GV_FACT_JOIN_REC.SRC_FAX_BATCH_SOURCE,			-- 6 	7
            BATCH_CLASS                               =  GV_FACT_JOIN_REC.SRC_BATCH_CLASS,				-- 6 	8
            CANCEL_DT                                 =  GV_FACT_JOIN_REC.SRC_CANCEL_DT,				-- 6 	9
            REPROCESSED_FLAG                          =  GV_FACT_JOIN_REC.SRC_REPROCESSED_FLAG,			-- 6 	10
            REPROCESSED_DATE                          =  GV_FACT_JOIN_REC.SRC_REPROCESSED_DATE,			-- 6 	10
            BATCH_COMPLETE_DT                         =  GV_FACT_JOIN_REC.SRC_BATCH_COMPLETE_DT,		-- 6 	11
            AGE_IN_BUSINESS_HOURS                     =  GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_HOURS,	-- 6 	12
            AGE_IN_BUSINESS_DAYS                      =  GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_DAYS,		-- 6 	13
            CREATION_COUNT                            =  GV_FACT_JOIN_REC.SRC_CREATION_COUNT,			-- 6 	14
            INVENTORY_COUNT                           =  GV_FACT_JOIN_REC.SRC_INVENTORY_COUNT,			-- 6 	15
            COMPLETION_COUNT                          =  GV_FACT_JOIN_REC.SRC_COMPLETION_COUNT,			-- 6 	16
            CANCELATION_COUNT                         =  GV_FACT_JOIN_REC.SRC_CANCELATION_COUNT,		-- 6 	17
            REPROCESSED_COUNT                         =  GV_FACT_JOIN_REC.SRC_REPROCESSED_COUNT,		-- 6 	18
            WEEKEND_FLAG                              =  GV_FACT_JOIN_REC.SRC_WEEKEND_FLAG,             -- 6 	19,
            BUSINESS_DAY_FLAG                         =  GV_FACT_JOIN_REC.SRC_BUSINESS_DAY_FLAG,         -- 6 	20,
            BATCH_GROUP                               = GV_FACT_JOIN_REC.SRC_BATCH_GROUP,
            BATCH_PROGRAM                             = GV_FACT_JOIN_REC.SRC_BATCH_PROGRAM
		WHERE ROWID = GV_FACT_JOIN_REC.TARGET_ROWID;
	--	and batch_guid = GV_FACT_JOIN_REC.SRC_BATCH_GUID;  -- <<< Really bad Performance

		GV_FACT_BY_DAY_UPDATED_COUNT := GV_FACT_BY_DAY_UPDATED_COUNT +1;

	ELSE
		NULL; -- NO UPDATE REQUIRED
	END IF;

	EXCEPTION

        WHEN OTHERS THEN

			GV_SQL_CODE 			:= SQLCODE;
			GV_LOG_MESSAGE 			:= SQLERRM;
			GV_DRIVER_KEY_NUMBER  	:= 'BATCH_GUID : '||GV_BATCH_GUID;
			GV_DRIVER_TABLE_NAME  	:= 'F_MFB_V2_BY_DAY';
			GV_ERR_LEVEL		  	:= 'LOG';
			GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.UPDATE_F_BY_DAY';

            ---- DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE FATC BY DAY '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
            ---- DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE FACT BY DAY FOR GV_FACT_JOIN_REC.SRC_BATCH_GUID '||GV_FACT_JOIN_REC.SRC_BATCH_GUID);

			POST_ERROR;

			RETURN;

	END UPDATE_F_BY_DAY;

-----------------------------------------------------
PROCEDURE INSERT_F_BY_DAY IS
-- USES SQL  FROM 7 AND 8
-----------------------------------------------------

	BEGIN

		INSERT INTO F_MFB_V2_BY_DAY
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
            REPROCESSED_FLAG,                         	-- 7 	10
            REPROCESSED_DATE,                         	-- 7 	10
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
            GV_FACT_JOIN_REC.SRC_BATCH_GUID,					-- 8 	1
            GV_FACT_JOIN_REC.SRC_D_DATE,						-- 8 	2
            GV_FACT_JOIN_REC.SRC_MFB_V2_BI_ID,					-- 8 	3
         --   GV_FACT_JOIN_REC.SRC_MFB_V2_CREATE_DATE,			-- 8 	4
         --   GV_FACT_JOIN_REC.SRC_MFB_V2_UPDATE_DATE,			-- 8 	5
            to_date(to_char(GV_FACT_JOIN_REC.SRC_CREATE_DT,'yyyymmdd hh24:mi:ss'),'yyyymmdd hh24:mi:ss'),						-- 8 	6
            GV_FACT_JOIN_REC.SRC_FAX_BATCH_SOURCE,				-- 8 	7
            GV_FACT_JOIN_REC.SRC_BATCH_CLASS,					-- 8 	8
            to_date(to_char(GV_FACT_JOIN_REC.SRC_CANCEL_DT,'yyyymmdd hh24:mi:ss'),'yyyymmdd hh24:mi:ss'),						-- 8 	9
            GV_FACT_JOIN_REC.SRC_REPROCESSED_FLAG,				-- 8 	10
            to_date(to_char(GV_FACT_JOIN_REC.SRC_REPROCESSED_DATE,'yyyymmdd hh24:mi:ss'),'yyyymmdd hh24:mi:ss'),				-- 8 	10
            to_date(to_char(GV_FACT_JOIN_REC.SRC_BATCH_COMPLETE_DT,'yyyymmdd hh24:mi:ss'),'yyyymmdd hh24:mi:ss'),				-- 8 	11
            GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_HOURS,			-- 8 	12
            GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_DAYS, 			-- GV_AGE_IN_BUSINESS_DAYS
            GV_FACT_JOIN_REC.SRC_CREATION_COUNT,				-- 8 	14
            GV_FACT_JOIN_REC.SRC_INVENTORY_COUNT,				-- 8 	15
            GV_FACT_JOIN_REC.SRC_COMPLETION_COUNT,				-- 8 	16
            GV_FACT_JOIN_REC.SRC_CANCELATION_COUNT,				-- 8 	17
            GV_FACT_JOIN_REC.SRC_REPROCESSED_COUNT,				-- 8 	18
            GV_FACT_JOIN_REC.SRC_WEEKEND_FLAG,                  -- 8 	19,
            GV_FACT_JOIN_REC.SRC_BUSINESS_DAY_FLAG,             -- 8 	20,
            GV_FACT_JOIN_REC.SRC_BATCH_GROUP,
            GV_FACT_JOIN_REC.SRC_BATCH_PROGRAM
			);

		GV_RECORD_INSERTED_COUNT := GV_RECORD_INSERTED_COUNT + 1;

            --DBMS_OUTPUT.PUT_LINE('Insert_fact_by_day.GV_FACT_JOIN_REC.SRC_BATCH_GUID: '||GV_FACT_JOIN_REC.SRC_BATCH_GUID);
            --DBMS_OUTPUT.PUT_LINE('Insert_fact_by_day.GV_end_date: '||to_char(GV_END_Date,'yyyy/mm/dd hh24:mi:ss'));
            --DBMS_OUTPUT.PUT_LINE('Insert_fact_by_day.GV_FACT_JOIN_REC.SRC_D_DATE: '||to_char(GV_FACT_JOIN_REC.src_d_date,'yyyy/mm/dd hh24:mi:ss'));
            --DBMS_OUTPUT.PUT_LINE('Insert_fact_by_day.GV_FACT_JOIN_REC.SRC_CREATE_DT: '||to_char(GV_FACT_JOIN_REC.SRC_CREATE_DT,'yyyy/mm/dd hh24:mi:ss'));						-- 8 	6
            --DBMS_OUTPUT.PUT_LINE('Insert_fact_by_day.GV_FACT_JOIN_REC.SRC_CANCEL_DT: '||to_char(GV_FACT_JOIN_REC.SRC_CANCEL_DT,'yyyy/mm/dd hh24:mi:ss'));
            --DBMS_OUTPUT.PUT_LINE('Insert_fact_by_day.GV_FACT_JOIN_REC.SRC_REPROCESSED_DATE: '||to_char(GV_FACT_JOIN_REC.SRC_REPROCESSED_DATE,'yyyy/mm/dd hh24:mi:ss'));				-- 8 	10
            --DBMS_OUTPUT.PUT_LINE('Insert_fact_by_day.GV_FACT_JOIN_REC.SRC_BATCH_COMPLETE_DT: '||to_char(GV_FACT_JOIN_REC.SRC_BATCH_COMPLETE_DT,'yyyy/mm/dd hh24:mi:ss'));				-- 8 	11

	EXCEPTION

        WHEN OTHERS THEN

			GV_SQL_CODE 			:= SQLCODE;
			GV_LOG_MESSAGE 			:= SQLERRM;
			GV_DRIVER_KEY_NUMBER  	:= 'BATCH_GUID : '||GV_FACT_JOIN_REC.SRC_BATCH_GUID;
			GV_DRIVER_TABLE_NAME  	:= 'F_MFB_V2_BY_DAY';
			GV_ERR_LEVEL		  	:= 'LOG';
			GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.INSERT_F_BY_DAY';

            DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE FATC BY DAY '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
            DBMS_OUTPUT.PUT_LINE('FAILED IN UPDATE FACT BY DAY FOR GV_FACT_JOIN_REC.SRC_BATCH_GUID '||GV_FACT_JOIN_REC.SRC_BATCH_GUID);

			POST_ERROR;

			RETURN;


	END INSERT_F_BY_DAY;

/*
-----------------------------------------------------
PROCEDURE DELETE_F_BY_DAY IS
-- IF THE JOIN CURSOR USES A FULL OUTTER JOIN THEN
-- THIS PROCEDURE CAN BE USED TO IDENTIFY
-- ROECORDS DELETED FROM THE SORCE SYSTEM
-----------------------------------------------------
	BEGIN

		IF TRUNC(GV_CANCEL_DT) <> TRUNC(SYSDATE)
		THEN

			DELETE FROM F_MFB_V2_BY_DAY
			WHERE BATCH_GUID = GV_BATCH_GUID
			AND D_DATE > TRUNC(GV_CANCEL_DT);

			GV_FACT_BY_DAY_DELETED_COUNT := GV_FACT_BY_DAY_DELETED_COUNT + sql%rowcount;

		END IF;

	EXCEPTION

		WHEN NO_DATA_FOUND
		THEN NULL;

		WHEN OTHERS
		THEN
			GV_SQL_CODE 			:= SQLCODE;
			GV_LOG_MESSAGE 			:= SQLERRM;
			GV_DRIVER_KEY_NUMBER  	:= 'BATCH_GUID : '||GV_BATCH_GUID;
			GV_DRIVER_TABLE_NAME  	:= 'F_MFB_V2_BY_DAY';
			GV_ERR_LEVEL		  	:= 'LOG';
			GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.LOAD_F_BY_DAY DELETES';
			POST_ERROR;
			RETURN;

            ---- DBMS_OUTPUT.PUT_LINE('FAILED TO DELETE FROM FACT BY DAY '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
            ---- DBMS_OUTPUT.PUT_LINE('FAILED TO DEKETE FROM FACT BY DAY FOR P_BATCH_GUID '||GV_BATCH_GUID);

		RETURN;


	END DELETE_F_BY_DAY;
*/
-----------------------------------------------------
PROCEDURE LOAD_F_BY_DAY (P_BATCH_GUID VARCHAR  default NULL)
IS
-----------------------------------------------------

	LV_AGE_IN_BUSINESS_DAYS			Number := 0;
	LV_D_DATE_COUNT                 Number := 0;
	LV_D_DATE_BEFORE_COUNT          Number := 0;
	LV_D_DATE_AFTER_COUNT           Number := 0;

    LV_P_D_DATE                     DATE := NULL;
    LV_P_START_DATE                 DATE := NULL;
    LV_P_END_DATE                   DATE := NULL;
	LV_P_AGE_IN_BUSINESS_DAYS       NUMBER := 0;


	BEGIN

		-- INITIAL SET Setup

		GV_FACT_JOIN_REC := NULL;

		LV_AGE_IN_BUSINESS_DAYS 	:= 0;

		LV_D_DATE_COUNT             := 0;
        LV_D_DATE_BEFORE_COUNT      := 0;
        LV_D_DATE_AFTER_COUNT       := 0;

        LV_P_D_DATE                 := NULL;
        LV_P_START_DATE             := NULL;
        LV_P_END_DATE               := NULL;
        LV_P_AGE_IN_BUSINESS_DAYS   := 0;

        GV_CANCEL_DT                := SYSDATE +1;
        GV_BATCH_CANCEL_DT          := TO_DATE(NULL);
        GV_BATCH_COMPLETE_DT        := TO_DATE(NULL);

		GV_BATCH_GUID := P_BATCH_GUID;

		--dbms_output.put_line('load_fact_by_day.GV_BATCH_GUID  '||GV_BATCH_GUID );
		BEGIN
			SELECT trunc(least(NVL(cancel_dt,SYSDATE+1),
						NVL(batch_complete_dt,SYSDATE+1),
						NVL(REPROCESSED_DATE,SYSDATE+1),
						sysdate+1))
			INTO GV_CANCEL_DT
			FROM NYHIX_MFB_V2_BATCH_SUMMARY
			WHERE BATCH_GUID = P_BATCH_GUID;

		EXCEPTION
			WHEN NO_DATA_FOUND
			THEN GV_CANCEL_DT := TRUNC(SYSDATE +1);

			WHEN OTHERS
			THEN RAISE;

		END;

		SELECT COUNT(*),
			SUM(CASE WHEN D_DATE < CREATE_DT THEN 1 ELSE 0 END),
			SUM(CASE WHEN D_DATE > GV_END_DATE THEN 1 ELSE 0 END)
		INTO LV_D_DATE_COUNT, LV_D_DATE_BEFORE_COUNT, LV_D_DATE_AFTER_COUNT
		FROM F_MFB_V2_BY_DAY
		WHERE BATCH_GUID = P_BATCH_GUID;

		IF LV_D_DATE_COUNT > 0
		AND LV_D_DATE_BEFORE_COUNT > 0
		THEN
			DELETE FROM F_MFB_V2_BY_DAY
			WHERE BATCH_GUID = P_BATCH_GUID
			AND D_DATE < CREATE_DT;
		END IF;

		IF LV_D_DATE_COUNT > 0
		AND LV_D_DATE_AFTER_COUNT > 0
		THEN
			DELETE FROM F_MFB_V2_BY_DAY
			WHERE BATCH_GUID = P_BATCH_GUID
			AND D_DATE > GV_END_DATE;
		END IF;

		--		IF TRUNC(GV_CANCEL_DT) <= TRUNC(SYSDATE)
		--		THEN
		--			DELETE_F_BY_DAY;
		--		END IF;

		-- Loop through the days for a specific batch_guid
		IF (F_BY_DAY_CSR%ISOPEN)
		THEN
			CLOSE F_BY_DAY_CSR;
		END IF;

		OPEN F_BY_DAY_CSR;
		GV_F_BY_DAY_CSR_OPEN := GV_F_BY_DAY_CSR_OPEN +1;

		LV_AGE_IN_BUSINESS_DAYS 	:= 0;



		LOOP -- Inner LOOP

			FETCH F_BY_DAY_CSR INTO GV_FACT_JOIN_REC;

			EXIT WHEN F_BY_DAY_CSR%NOTFOUND;

			GV_FACT_BY_DAY_PROCESSED_COUNT := GV_FACT_BY_DAY_PROCESSED_COUNT+1;

			IF GV_FACT_JOIN_REC.SRC_BUSINESS_DAY_FLAG = 'Y'
			THEN
				LV_AGE_IN_BUSINESS_DAYS := LV_AGE_IN_BUSINESS_DAYS + 1;
			END IF;

            IF GV_FACT_JOIN_REC.SRC_BUSINESS_DAY_FLAG = 'Y'
				THEN
					GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_DAYS := LV_AGE_IN_BUSINESS_DAYS;
                ELSE
                    GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_DAYS := 0;
                END IF;

                -- format the Parms for the function

                LV_P_D_DATE := GV_FACT_JOIN_REC.SRC_D_DATE;

                LV_P_START_DATE := TO_DATE(TO_CHAR(GV_FACT_JOIN_REC.SRC_CREATE_DT,'YYYYMMDD HH24:MI:SS'),'YYYYMMDD HH24:MI:SS');

                LV_P_END_DATE := TO_DATE(TO_CHAR(LEAST(SYSDATE,												-- << END_DATE  *******
												NVL(GV_FACT_JOIN_REC.SRC_BATCH_COMPLETE_DT,
--												(GV_FACT_JOIN_REC.SRC_D_DATE +19/24 )
												(TRUNC(SYSDATE) +19/24 )
											 )),'YYYYMMDD HH24:MI:SS'),'YYYYMMDD HH24:MI:SS');

                LV_P_AGE_IN_BUSINESS_DAYS := LV_AGE_IN_BUSINESS_DAYS;

				GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_HOURS
				 	:= MAXDAT.BUS_HRS_BETWEEN(
                        LV_P_D_DATE,
                        LV_P_START_DATE,
                        LV_P_END_DATE,
                        LV_P_AGE_IN_BUSINESS_DAYS );

                --	DBMS_OUTPUT.PUT_LINE('LV_P_D_DATE '||LV_P_D_DATE);
                --	DBMS_OUTPUT.PUT_LINE('LV_P_START_DATE '||LV_P_START_DATE);
                --	DBMS_OUTPUT.PUT_LINE('LV_P_END_DATE '||LV_P_END_DATE);
                --	DBMS_OUTPUT.PUT_LINE('LV_P_AGE_IN_BUSINESS_DAYS '||LV_P_AGE_IN_BUSINESS_DAYS);
				-- 	DBMS_OUTput.put_line('LV_AGE_IN_BUSINESS_DAYS: '||LV_AGE_IN_BUSINESS_DAYS);
				-- 	DBMS_OUTput.put_line('GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_DAYS: '||GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_DAYS);
				--  DBMS_OUTPUT.PUT_LINE('fact_by_day_tst.GV_end_date '||GV_END_Date);
				--  DBMS_OUTPUT.PUT_LINE('fact_by_day_tst.GV_FACT_JOIN_REC.SRC_CANCEL_DT '||nvl(to_char(GV_FACT_JOIN_REC.SRC_CANCEL_DT),'null'));
				--  DBMS_OUTPUT.PUT_LINE('fact_by_day_tst.GV_FACT_JOIN_REC.SRC_BATCH_GUID '||GV_FACT_JOIN_REC.SRC_BATCH_GUID);
				--  DBMS_OUTPUT.PUT_LINE('fact_by_day_tst.GV_FACT_JOIN_REC.src_d_date'||GV_FACT_JOIN_REC.src_d_date);
				--  DBMS_OUTPUT.PUT_LINE('fact_by_day_tst.GV_FACT_JOIN_REC.TARGET_ROWID '||GV_FACT_JOIN_REC.TARGET_ROWID);
				--  DBMS_OUTPUT.PUT_LINE('fact_by_day_tst.GV_FACT_JOIN_REC.TARGET_d_date '||GV_FACT_JOIN_REC.TARGET_d_date);

				IF GV_FACT_JOIN_REC.SRC_BATCH_GUID IS NOT NULL
				AND GV_FACT_JOIN_REC.TARGET_ROWID IS NOT NULL
				THEN
                    --DBMS_OUTPUT.PUT_LINE('Update_F_BY_DAY;');
					Update_F_BY_DAY;
				ELSIF GV_FACT_JOIN_REC.SRC_BATCH_GUID IS NOT NULL
				AND GV_FACT_JOIN_REC.TARGET_ROWID IS NULL
					THEN
                    --DBMS_OUTPUT.PUT_LINE('INSERT_F_BY_DAY;');
					INSERT_F_BY_DAY;
				ELSIF GV_FACT_JOIN_REC.SRC_BATCH_GUID IS NULL
				AND GV_FACT_JOIN_REC.TARGET_ROWID IS NOT NULL
				THEN
                    --DBMS_OUTPUT.PUT_LINE('NULL;');
					NULL;
				ELSE
					NULL;
				END IF;


		END LOOP; -- end loop

		COMMIT;


		IF (F_BY_DAY_CSR%ISOPEN)
		THEN
			CLOSE F_BY_DAY_CSR;
			GV_F_BY_DAY_CSR_CLOSE := GV_F_BY_DAY_CSR_CLOSE +1;
		END IF;

	EXCEPTION

		WHEN NO_DATA_FOUND
		THEN
			NULL;

        WHEN OTHERS THEN

			GV_SQL_CODE 			:= SQLCODE;
			GV_LOG_MESSAGE 			:= SQLERRM;
			GV_DRIVER_KEY_NUMBER  	:= 'BATCH_GUID : '||GV_BATCH_GUID;
			GV_DRIVER_TABLE_NAME  	:= 'F_MFB_V2_BY_DAY';
			GV_ERR_LEVEL		  	:= 'LOG';
			GV_FILE_NAME 			:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.LOAD_F_BY_DAY';
			POST_ERROR;

			DBMS_OUTPUT.PUT_LINE('FAILED IN  Load_F_BY_DAY for SRC_BATCH_GUID: '||GV_FACT_JOIN_REC.SRC_BATCH_GUID
			||' TARGET_BATCH_GUID: '||GV_FACT_JOIN_REC.TARGET_BATCH_GUID
			||'SQLCODE '||GV_ERROR_CODE
			||' '||GV_ERROR_MESSAGE);

			RETURN;

    END Load_F_BY_DAY;

-- *****************************************************
-- *****************************************************
-- *****************************************************

Procedure Extract_Batch_Event(P_SOURCE_SERVER VARCHAR DEFAULT 'CENTRAL', P_BATCH_GUID varchar default null) IS

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
    order by -- source_server desc,
	         nvl(END_DATE_TIME,START_DATE_TIME), 
			 START_DATE_TIME;
	--------------------------------------
	BEGIN

		IF (BATCH_EVENT_CSR%ISOPEN)
		THEN
			CLOSE BATCH_EVENT_CSR;
		END IF;

		-- SET THESE AT THE STATR OF EVERY BATCH
		-- THEN SHOULD BE SET WHENEVER THE INSTANCE_STATUS CHANGES.
		
	    GV_SRC_REC_SUMMARY.INSTANCE_STATUS		:= 'Active';
        GV_SRC_REC_SUMMARY.BATCH_DELETED 		:= 'N';
        GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT 	:= NULL;
        GV_SRC_REC_SUMMARY.CANCEL_DT		 	:= NULL;
		GV_SRC_REC_SUMMARY.COMPLETE_DT			:= NULL;
		GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT	:= NULL;
		GV_SRC_REC_SUMMARY.CANCEL_METHOD		:= NULL;
		GV_SRC_REC_SUMMARY.CANCEL_REASON		:= NULL;
		GV_SRC_REC_SUMMARY.BATCH_PRIORITY 		:= NULL;
		
		-- Note these are from STats_batch and must not be altered by EVENT procedure.
		-- GV_SRC_REC_SUMMARY.REPROCESSED_FLAG,
		-- GV_SRC_REC_SUMMARY.REPROCESSED_DATE,
		-- GV_SRC_REC_SUMMARY.BATCH_CLASS,
		-- GV_SRC_REC_SUMMARY.BATCH_CLASS_DES,
		-- GV_SRC_REC_SUMMARY.BATCH_TYPE,
		-- GV_SRC_REC_SUMMARY.CREATE_DT,
		-- GV_SBM_MAX_END_DATE_TIME,
        -- GV_SRC_REC_SUMMARY.batch_type

		OPEN BATCH_EVENT_CSR;

		LOOP  -- FOR EACH BATCH_GUID

		FETCH BATCH_EVENT_CSR
            INTO 
				GV_SRC_REC_EVENT.MFB_V2_CREATE_DATE,
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

			
			-- ONCE THE INSTANCE_STATUS GETS SET TO SOMETHING OTHER THAN 'Active'
			-- SKIP ANY OHER RECORDS

			IF GV_SRC_REC_SUMMARY.INSTANCE_STATUS <> 'Active'
			THEN
				CONTINUE;
			END IF;	

			-----------------------------------------------------------------------------
			-- START OF SETTING INSTANCE STATUS AND ASSOCATED DATES
			-----------------------------------------------------------------------------
			-- dbms_output.put_line('Event Loop '||Gv_event_count||to_char(GV_SRC_REC_EVENT.START_DATE_TIME,'yyyymmdd hh24:mi:33'));

			-- These event records are at the end of every EVENT
			-- to signify that the batch is no longer in KOFAX.
			-- These record must be skipped to avoid
			-- and incorrect setting of the Instance_statsus
			-- and completion dates.

			IF NVL(GV_SRC_REC_SUMMARY.REPROCESSED_FLAG,'N') = 'N'
			AND ( GV_SRC_REC_EVENT.USER_NAME = 'NYSOH KOFAX System'
--			      OR
--				  GV_SRC_REC_EVENT.USER_NAME = 'svc_qa_nyhixint' --<< This is for UAT 'svc_qa_nyhixint'
				 ) 
			AND ( GV_SRC_REC_EVENT.MODULENAME = 'Export'
--				OR 
--				GV_SRC_REC_EVENT.MODULENAME = 'Batch Manager'
				)  
			AND GV_SRC_REC_EVENT.BATCH_STATUS = 64
			AND GV_SRC_REC_EVENT.DELETED = 'Y'
			AND GV_SRC_REC_EVENT.MODULE_CLOSE_UNIQUE_ID IS NULL
			AND GV_SRC_REC_EVENT.MODULE_CLOSE_NAME IS NULL
			THEN
				-- dbms_output.put_line('Skip '||Gv_event_count||to_char(GV_SRC_REC_EVENT.START_DATE_TIME,'yyyymmdd hh24:mi:33'));
				-- dont change anything just skip this record
				-- It is suposed to be the LAST record but ......
				CONTINUE;
			END IF;

			-- dbms_output.put_line('NO Skip '||Gv_event_count||to_char(GV_SRC_REC_EVENT.START_DATE_TIME,'yyyymmdd hh24:mi:33'));

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

			GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT := COALESCE
													(GV_SRC_REC_EVENT.END_DATE_TIME,
													GV_SBM_MAX_END_DATE_TIME,
													GV_TARGET_REC.INSTANCE_STATUS_DT
													);

			-- LOGIC FOR 'REPROCESSED'

			IF GV_SRC_REC_SUMMARY.INSTANCE_STATUS = 'Active'
			AND NVL(GV_SRC_REC_SUMMARY.REPROCESSED_FLAG,'N') = 'Y'
			THEN
				GV_SRC_REC_SUMMARY.INSTANCE_STATUS 		:= 'Reprocessed';
				GV_SRC_REC_SUMMARY.BATCH_DELETED 		:= 'N';
				GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT 	:= NULL;
				GV_SRC_REC_SUMMARY.CANCEL_DT		 	:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.COMPLETE_DT			:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT	:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.CANCEL_METHOD		:= 'Reprocessed';
				GV_SRC_REC_SUMMARY.CANCEL_REASON		:= 'Reprocessed';
				GV_SRC_REC_SUMMARY.BATCH_PRIORITY 		:= GV_SRC_REC_EVENT.PRIORITY;

				GV_SRC_REC_SUMMARY.CANCEL_BY 			:= GV_SRC_REC_EVENT.USER_NAME;
				
				CONTINUE;
			END IF;

			-- this is a "normal" completion
			IF GV_SRC_REC_SUMMARY.INSTANCE_STATUS           = 'Active'
			AND NVL(GV_SRC_REC_SUMMARY.REPROCESSED_FLAG,'N') = 'N'
			AND GV_SRC_REC_EVENT.MODULE_CLOSE_NAME          = 'Export' --'${EXPORT_MODULE_NAME}'
			AND GV_SRC_REC_EVENT.BATCH_STATUS               = 64
			AND GV_SRC_REC_EVENT.END_DATE_TIME              IS NOT NULL
			AND NVL(GV_SRC_REC_EVENT.DELETED,'N')           = 'N'
			AND NVL(GV_SRC_REC_SUMMARY.BATCH_DELETED,'N')   = 'N'
			THEN
				GV_SRC_REC_SUMMARY.INSTANCE_STATUS			:= 'Complete';
				GV_SRC_REC_SUMMARY.BATCH_DELETED 			:= 'N';
				GV_SRC_REC_SUMMARY.CANCEL_DT 				:= NULL;
				GV_SRC_REC_SUMMARY.CANCEL_REASON 			:= NULL;
				GV_SRC_REC_SUMMARY.CANCEL_METHOD 			:= NULL;
				GV_SRC_REC_SUMMARY.COMPLETE_DT				:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT 		:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT		:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.BATCH_PRIORITY 			:= GV_SRC_REC_EVENT.PRIORITY;
				--
				GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS			:= 'Y'; --	YES_FLAG
				GV_SRC_REC_SUMMARY.ASSD_RELEASE_DMS			:= GV_SRC_REC_EVENT.START_DATE_TIME;
				GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS			:= GV_SRC_REC_EVENT.END_DATE_TIME;
				GV_SRC_REC_SUMMARY.CURRENT_BATCH_MODULE_ID 	:= GV_SRC_REC_EVENT.BATCH_MODULE_ID;
				--
				GV_SRC_REC_SUMMARY.ASF_POPULATE_REPORTS		:= 'Y';
				GV_SRC_REC_SUMMARY.ASSD_POPULATE_REPORTS 	:= GV_SRC_REC_EVENT.START_DATE_TIME;
				GV_SRC_REC_SUMMARY.ASED_POPULATE_REPORTS 	:= GV_SRC_REC_EVENT.END_DATE_TIME;

				-- DBMS_OUTPUT.PUT_LINE('UPDATE INSTANCE_STATUS: '||GV_SRC_REC_SUMMARY.INSTANCE_STATUS);

				CONTINUE;
			END IF;

			-- DBMS_OUTPUT.PUT_LINE('AFTER TEST UPDATE INSTANCE_STATUS: '||GV_SRC_REC_SUMMARY.INSTANCE_STATUS);

			-- a "NORMAL" DELETION
			IF GV_SRC_REC_SUMMARY.INSTANCE_STATUS = 'Active'
			AND NVL(GV_SRC_REC_SUMMARY.REPROCESSED_FLAG,'N') = 'N'
			AND GV_SRC_REC_EVENT.DELETED = 'Y'
			AND GV_SRC_REC_SUMMARY.CANCEL_DT IS NULL
			AND GV_SRC_REC_EVENT.MODULENAME  <> 'Export' --'${EXPORT_MODULE_NAME}'
			THEN
				GV_SRC_REC_SUMMARY.INSTANCE_STATUS 			:= 'Deleted';
				GV_SRC_REC_SUMMARY.BATCH_DELETED 			:= 'Y';
				GV_SRC_REC_SUMMARY.CANCEL_DT				:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.CANCEL_BY 				:= GV_SRC_REC_EVENT.USER_NAME;
				GV_SRC_REC_SUMMARY.CANCEL_REASON 			:= 'Deleted';
				GV_SRC_REC_SUMMARY.CANCEL_METHOD 			:= 'Normal';
				GV_SRC_REC_SUMMARY.COMPLETE_DT				:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT 		:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT		:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.BATCH_PRIORITY 			:= GV_SRC_REC_EVENT.PRIORITY;
				--
				GV_SRC_REC_SUMMARY.CURRENT_BATCH_MODULE_ID		:= NULL;
				--DBMS_OUTPUT.PUT_LINE('UPDATE BATCH_DELETED : '||GV_SRC_REC_SUMMARY.BATCH_DELETED );
				CONTINUE;
			END IF;

			-- If there is a "DELETED = 'Y' after skipping
			-- the above rows... set the cancel_dt

			IF GV_SRC_REC_SUMMARY.INSTANCE_STATUS = 'Active'
			AND NVL(GV_SRC_REC_SUMMARY.REPROCESSED_FLAG,'N') = 'N'
			AND GV_SRC_REC_EVENT.DELETED = 'Y'
			THEN
				GV_SRC_REC_SUMMARY.INSTANCE_STATUS 	:= 'Deleted';
				GV_SRC_REC_SUMMARY.CANCEL_DT 		:= GV_SRC_REC_EVENT.START_DATE_TIME;
				GV_SRC_REC_SUMMARY.CANCEL_BY 		:= GV_SRC_REC_EVENT.USER_NAME;
				GV_SRC_REC_SUMMARY.CANCEL_REASON 	:= 'Deleted';
				GV_SRC_REC_SUMMARY.CANCEL_METHOD 	:= 'Exception';
				GV_SRC_REC_SUMMARY.BATCH_DELETED 	:= 'Y';
				CONTINUE;
			END IF;

			-----------------------------------------------------------------------------
			-- END OF SETTING INSTANCE STATUS AND ASSOCATED DATES
			-----------------------------------------------------------------------------

			-- BATCH_PRIORITY -- Grab the last one
			GV_SRC_REC_SUMMARY.BATCH_PRIORITY := GV_SRC_REC_EVENT.PRIORITY;

			IF GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG IS NULL
				THEN GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG := 'N';
			END IF;

			-- Pages_Scanned Note Pages_scanned is a number
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

			-- DOCS DELETED
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

			--DBMS_OUTPUT.PUT_LINE('BEFORE END LOOP INSTANCE_STATUS: '||GV_SRC_REC_SUMMARY.INSTANCE_STATUS);

			-----------------------------------------------
			-----------------------------------------------

		END LOOP;

		-- Because the update looks at multiple 'values' these tests
		-- must be done at the end of the LOOP

		-------------------------------------------------------------------------------
		-- UPD11_010 - SET BATCH_DELETED
		-------------------------------------------------------------------------------

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

		--DBMS_OUTPUT.PUT_LINE('GV_SRC_REC_SUMMARY.BATCH_DELETED: '||GV_SRC_REC_SUMMARY.BATCH_DELETED);
		--DBMS_OUTPUT.PUT_LINE('GV_TARGET_REC.BATCH_DELETED: '||GV_TARGET_REC.BATCH_DELETED);
		--DBMS_OUTPUT.PUT_LINE('END OF EVENT INSTANCE_STATUS: '||GV_SRC_REC_SUMMARY.INSTANCE_STATUS);

	EXCEPTION
		WHEN NO_DATA_FOUND
			THEN
			-- -- DBMS_OUTPUT.PUT_LINE('Extract_Batch_Event: P_SOURCE_SERVER, p_BATCH_GUID : '||P_SOURCE_SERVER||' '||p_Batch_GUID|| 'NOT found');
			-- GV_SRC_REC_SUMMARY.BATCH_GUID := p_Batch_GUID;
			NULL;

		WHEN OTHERS THEN

			GV_SQL_CODE 			:= SQLCODE;
			GV_LOG_MESSAGE 			:= SQLERRM;
			GV_DRIVER_KEY_NUMBER  	:= 'BATCH_GUID : '||P_BATCH_GUID;
			GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_V2_BATCH_EVENT';
			GV_ERR_LEVEL		  	:= 'LOG';
			GV_FILE_NAME 		:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.Extract_Batch_Event';

			POST_ERROR;

			---- DBMS_OUTPUT.PUT_LINE('FAILED IN EXTRACT EVENT '||' '||GV_SQL_CODE||' '||GV_LOG_MESSAGE);
			---- DBMS_OUTPUT.PUT_LINE('FAILED TO EXTRACT EVENT FOR '||P_SOURCE_SERVER||' '||P_BATCH_GUID);

			RETURN;

	End Extract_Batch_Event;

		-- *****************************************************
		-- *****************************************************
		-- *****************************************************


END NYHIX_MFB_V2_BATCH_SUMMARY_PKG;
/
SHOW ERRORS