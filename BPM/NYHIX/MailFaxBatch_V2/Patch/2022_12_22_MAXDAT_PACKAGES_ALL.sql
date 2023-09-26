-- DROP PACKAGE MAXDAT.NYHIX_MFB_V2_BATCH_EVENT_PKG;

CREATE OR REPLACE PACKAGE MAXDAT."NYHIX_MFB_V2_BATCH_EVENT_PKG" AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $';
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    Procedure Insert_EVENTS;
    Procedure Update_EVENTS;
    Procedure Delete_EVENTS;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_EVENTS ( p_job_id number default 0);

END NYHIX_MFB_V2_BATCH_EVENT_PKG;
/


-- DROP PACKAGE MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY_PKG;

CREATE OR REPLACE Package MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $';
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';

--	function MFB_V2_BUS_DAYS_BETWEEN
--		(p_start_date in date,
--		p_end_date in date)
--		return integer;

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

    PROCEDURE LOAD_F_MFB_V2_BY_HOUR(
		P_MFB_V2_BI_ID 			NUMBER DEFAULT NULL,
		P_BATCH_GUID 			VARCHAR DEFAULT NULL,
		P_EVENT_DATE 			DATE DEFAULT NULL,
		P_CREATE_DT				DATE DEFAULT NULL,
		P_END_DATE				DATE DEFAULT NULL,
		P_CANCELLED_DT			DATE DEFAULT NULL,
		P_BATCH_COMPLETED_DT	DATE DEFAULT NULL,
		P_REPROCESSED_FLAG		VARCHAR DEFAULT  'N',
		P_REPROCESSED_DATE		DATE	DEFAULT NULL,
		P_INSTANCE_STATUS		VARCHAR DEFAULT 'Active'
        );

	-----
	Procedure Load_Run_List(P_PARENT_JOB_ID varchar default null);
	Procedure Process_Run_List (P_PARENT_JOB_ID varchar default null);
	Procedure Process_One_Batch(P_SOURCE_SERVER VARCHAR DEFAULT 'CENTRAL', P_BATCH_GUID varchar default null);

    ----  **** THIS IS THE PROCEDURE TO RUN
	Procedure Load_BATCH_SUMMARY ( p_job_id varchar default null);
	-----

    Procedure Insert_F_BY_DAY;
    Procedure Update_F_BY_DAY;
	-- Procedure Delete_F_BY_DAY;

	Procedure Load_F_BY_DAY ( p_batch_guid varchar default null);


END NYHIX_MFB_V2_BATCH_SUMMARY_PKG;
/


-- DROP PACKAGE MAXDAT.NYHIX_MFB_V2_DOCUMENT_PKG;

CREATE OR REPLACE Package MAXDAT.NYHIX_MFB_V2_DOCUMENT_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    Procedure Insert_DOCUMENT;
    Procedure Update_DOCUMENT;
    Procedure Delete_DOCUMENT;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_DOCUMENT ( p_job_id number default 0);

END NYHIX_MFB_V2_DOCUMENT_PKG;

/


-- DROP PACKAGE MAXDAT.NYHIX_MFB_V2_ENVELOPE_PKG;

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

/


-- DROP PACKAGE MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_PKG;

CREATE OR REPLACE Package MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    Procedure Insert_Load_IMAGE_TRUST_STATS_BATCH;
    Procedure Update_Load_IMAGE_TRUST_STATS_BATCH;
    Procedure Delete_Load_IMAGE_TRUST_STATS_BATCH;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_Load_IMAGE_TRUST_STATS_BATCH ( p_job_id number default 0);

END NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_PKG;
/


-- DROP PACKAGE MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING_PKG;

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


-- DROP PACKAGE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG;

CREATE OR REPLACE Package MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    Procedure Insert_STATS_BATCH_MODULE_LAUNCH;
    Procedure Update_STATS_BATCH_MODULE_LAUNCH;
    Procedure Delete_STATS_BATCH_MODULE_LAUNCH;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_STATS_BATCH_MODULE_LAUNCH(p_job_id number default 0);

END NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG;

/


-- DROP PACKAGE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_PKG;

CREATE OR REPLACE Package MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    Procedure Insert_STATS_BATCH_MODULE;
    Procedure Update_STATS_BATCH_MODULE;
    Procedure Delete_STATS_BATCH_MODULE;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_STATS_BATCH_MODULE(p_job_id number default 0);

END NYHIX_MFB_V2_STATS_BATCH_MODULE_PKG;

/


-- DROP PACKAGE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_PKG;

CREATE OR REPLACE Package MAXDAT.NYHIX_MFB_V2_STATS_BATCH_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    Procedure Insert_STATS_BATCH;
    Procedure Update_STATS_BATCH;
    Procedure Delete_STATS_BATCH;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_STATS_BATCH ( p_job_id number default 0);

END NYHIX_MFB_V2_STATS_BATCH_PKG;

/


-- DROP PACKAGE MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE_PKG;

CREATE OR REPLACE Package MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180523_1130_SC_HIERARCHY_PKG.SQL $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 23454 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-23 09:52:05 -0500 (Wed, 23 May 2018) $'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


    Procedure Insert_STATS_FORM_TYPE;
    Procedure Update_STATS_FORM_TYPE;
    Procedure Delete_STATS_FORM_TYPE;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_STATS_FORM_TYPE(p_job_id number default 0);

END NYHIX_MFB_V2_STATS_FORM_TYPE_PKG;

/


GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_BATCH_EVENT_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_DOCUMENT_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_ENVELOPE_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE_PKG TO MAXDAT_PFP_E;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_BATCH_EVENT_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_DOCUMENT_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_ENVELOPE_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE_PKG TO MAXDAT_PFP_READ_ONLY;

-- DROP PACKAGE BODY MAXDAT.NYHIX_MFB_V2_BATCH_EVENT_PKG;

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
                     SRC.MODULE_NAME                           AS SRC_MODULE_NAME,	-- 1 	5
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
                  TARGET.MODULE_NAME                        AS TARGET_MODULE_NAME,	-- 2 	5
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
                              SRC_MODULE_NAME,                         	-- 3 	5
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
                              TARGET_MODULE_NAME,                      	-- 4 	5
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
            OR NVL(JOIN_REC.TARGET_MODULE_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_NAME,'-?93333')	-- 5 	5	VARCHAR2
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
            MODULE_NAME                                =  JOIN_REC.SRC_MODULE_NAME,	-- 6 	5
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
            MODULE_NAME,                             	-- 7 	5
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
            JOIN_REC.SRC_MODULE_NAME,	-- 8 	5
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


-- DROP PACKAGE BODY MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY_PKG;

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

	-- USED FOR THE CORP_ETL_JOB_STATISTICS
	GV_JOB_NAME					VARCHAR2(120)		:= 'NYHIX_MFB_V2';
	GV_FILE_NAME              	VARCHAR2(512 BYTE)	:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG';
	GV_PARENT_JOB_ID          	NUMBER				:= 0;
	GV_JOB_ID                 	NUMBER              := 0;
	GV_RECORD_COUNT           	NUMBER				:= 0;
	GV_ERROR_COUNT            	NUMBER				:= 0;
	GV_WARNING_COUNT          	NUMBER				:= 0;
	GV_PROCESSED_COUNT        	NUMBER				:= 0;
	GV_RECORD_INSERTED_COUNT  	NUMBER				:= 0;
	GV_RECORD_UPDATED_COUNT   	NUMBER				:= 0;
	GV_JOB_START_DATE         	DATE				:= SYSDATE;

	-- USED FOR THE CORP_ETL_ERROR_LOG

	GV_PROCESS_NAME				VARCHAR2(120)		:= 'NYHIX_MFB_V2';
	GV_SQL_CODE                 NUMBER 				:= NULL;
    GV_LOG_MESSAGE              CLOB 			    := NULL;

	GV_ERROR_CODE				VARCHAR2(50)		:= NULL;
	GV_ERROR_MESSAGE			VARCHAR2(4000)		:= NULL;
	GV_ERROR_FIELD				VARCHAR2(400)		:= NULL;
	GV_ERROR_CODES				VARCHAR2(400)		:= NULL;
	GV_ERR_DATE					DATE				:= SYSDATE;
	GV_ERR_LEVEL				VARCHAR2(20)		:= 'CRITICAL';
	GV_DRIVER_TABLE_NAME  		VARCHAR2(100 BYTE)	:= 'NYHIX_MFB_V2_BATCH_SUMMARY';
	GV_DRIVER_KEY_NUMBER  		VARCHAR2(100 BYTE)	:= NULL;
	GV_NR_OF_ERROR        		NUMBER				:= 0;
    GV_UPDATE_TS                DATE                := SYSDATE;
    GV_TARGET_ROWID             ROWID               := NULL;

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
    GV_LAST_FACT_BY_DAY_DT         		DATE                := SYSDATE +1;
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
            -- SRC.MFB_V2_CREATE_DATE  		-- 1 	4
            -- SRC.MFB_V2_UPDATE_DATE 		-- 1 	5
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
		AND GV_LAST_FACT_BY_DAY_DT
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

	if GV_AGE_IN_BUSINESS_DAYS is null
	then GV_AGE_IN_BUSINESS_DAYS := BPM_COMMON.BUS_DAYS_BETWEEN(
								GV_SRC_REC_SUMMARY.CREATE_DT,
								COALESCE(GV_SRC_REC_SUMMARY.batch_complete_dt, GV_SRC_REC_SUMMARY.CANCEL_DT, GV_SRC_REC_SUMMARY.REPROCESSED_DATE, sysdate)
								);
	end if;

	bus_days		:= GV_AGE_IN_BUSINESS_DAYS;

	cal_days		:= trunc(nvl(p_batch_complete_dt,sysdate) - p_create_dt);

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
			if (cal_days < GV_timeliness_days)
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


        -- USED BY LOAD_F_BY_DAY
        GV_LAST_FACT_BY_DAY_DT      	:= SYSDATE +1;
        GV_BATCH_GUID            		:= NULL;
        GV_BATCH_CANCEL_DT          	:= TO_DATE(NULL);
        GV_BATCH_COMPLETE_DT        	:= TO_DATE(NULL);

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
	LV_CENTRAL_COUNT	NUMBER := 0;

	BEGIN

		--IF GV_RECORD_COUNT < 10  --<< DEBUG
		--THEN
			--DBMS_OUTPUT.PUT_LINE('PROCESS_ONE_BATCH  P_SOURCE_SERVER: '||P_SOURCE_SERVER);  -- DEBUG
			--DBMS_OUTPUT.PUT_LINE('PROCESS_ONE_BATCH  P_BATCH_GUID: '||P_BATCH_GUID);		-- DEBUG
		--END IF;

	    LV_RECORD_COUNT    := GV_RECORD_COUNT;

		GV_RECORD_COUNT 				:= GV_RECORD_COUNT+1;
		GV_AGE_IN_BUSINESS_DAYS 		:= 0;
		GV_END_DATE						:= TO_DATE(NULL);
		GV_START_DATE					:= TO_DATE(NULL);

		-- USED BY LOAD_F_BY_DAY
		GV_LAST_FACT_BY_DAY_DT  		:= SYSDATE +1;
		GV_BATCH_CANCEL_DT          	:= TO_DATE(NULL);
		GV_BATCH_COMPLETE_DT        	:= TO_DATE(NULL);

		--------------------------------------------------------------
		--------------------------------------------------------------
		-- If a Batch_Guid for CENTRAL exists in BATCH_SUMMARY
		-- do not process the Batch Guid for REMOTE

		LV_CENTRAL_COUNT := 0;

		IF P_SOURCE_SERVER = 'REMOTE'
		THEN
			SELECT SUM(1) INTO LV_CENTRAL_COUNT
			FROM NYHIX_MFB_V2_BATCH_SUMMARY
			WHERE SOURCE_SERVER = 'CENTRAL'
			AND BATCH_GUID = P_BATCH_GUID;
		END IF;

		-- Do not prodcess a 'REMOTE' if a CENTRAL is present

		IF LV_CENTRAL_COUNT <> 0
		THEN
			RETURN;
		END IF;

		--------------------------------------------------------------
		--------------------------------------------------------------

		INITIALIZE_GV_SRC_REC_SUMMARY;
		GV_TARGET_REC := GV_SRC_REC_SUMMARY;

		-- GET VALUES FROM CORP_ETL_CONTROL
		Extract_CORP_ETL_CONTROL;

		GV_SOURCE_SERVER 	:= P_SOURCE_SERVER;
		GV_BATCH_GUID		:= P_BATCH_GUID;

 		Extract_Target(P_SOURCE_SERVER, P_BATCH_GUID);

		Extract_Stats_Batch(P_SOURCE_SERVER, P_BATCH_GUID);

		-- Note: the SOURCE_SERVER comes from STATS_BATCH

		IF GV_SRC_REC_SUMMARY.SOURCE_SERVER IS NULL
		THEN
			-- Do Not process if there is not a STATS_BATCH record
			RETURN;
		END IF;


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
			-- dbms_output.put_line('RETURNING??'); --<< DEBUG
			RETURN;
		END IF;

        -- THE EXTRACTS MUST BE IN THE PROPER ORDER
        --
        -- Extract_Document(P_SOURCE_SERVER, P_BATCH_GUID);
        -- Extract_Envelope(P_SOURCE_SERVER, P_BATCH_GUID);
        Extract_Maxdat_Reporting(P_SOURCE_SERVER, P_BATCH_GUID);
        -- Extract_Stats_Form_Type(P_SOURCE_SERVER, P_BATCH_GUID);

        Extract_Batch_Event(P_SOURCE_SERVER, P_BATCH_GUID);

		-- NOTE if GV_EVENT_COUNT = 0 then there were no EVENTS
		-- Should  an update to BATCH_SUMMARY be made??

		-- IF GV_EVENT_COUNT = 0
		-- THEN
		--		RETURN;
		-- END IF;

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
								COALESCE(GV_SRC_REC_SUMMARY.batch_complete_dt, GV_SRC_REC_SUMMARY.CANCEL_DT, GV_SRC_REC_SUMMARY.REPROCESSED_DATE, sysdate)
								);

			GV_SRC_REC_SUMMARY.AGE_IN_BUSINESS_DAYS :=  GV_AGE_IN_BUSINESS_DAYS;

			GV_SRC_REC_SUMMARY.AGE_IN_CALENDAR_DAYS
													:= trunc(COALESCE(GV_SRC_REC_SUMMARY.batch_complete_dt,
																	  GV_SRC_REC_SUMMARY.CANCEL_DT,
																	  GV_SRC_REC_SUMMARY.REPROCESSED_DATE,
																	  sysdate)
															)
													- trunc(GV_SRC_REC_SUMMARY.CREATE_DT);

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
						GV_SRC_REC_SUMMARY.REPROCESSED_DATE,	--<< P_REPROCESSED_DATE
						GV_SRC_REC_SUMMARY.INSTANCE_STATUS 		--<< P_INSTANCE_STATUS
						);


            ELSIF GV_TARGET_ROWID IS NOT NULL
				AND GV_SRC_REC_SUMMARY.BATCH_GUID IS NOT NULL
				THEN
					GV_MFB_V2_BI_ID			:= GV_TARGET_REC.MFB_V2_BI_ID;
					GV_MFB_V2_CREATE_DATE	:= GV_TARGET_REC.CREATE_DT;
					GV_MFB_V2_UPDATE_DATE   := SYSDATE;

					dbms_output.put_line('*** PRE UPDATE'||' GV_SRC_REC_SUMMARY.CREATE_DT: '|| GV_SRC_REC_SUMMARY.CREATE_DT);
					UPDATE_BATCH_SUMMARY();
					dbms_output.put_line('*** POST UPDATE'||' GV_SRC_REC_SUMMARY.CREATE_DT: '|| GV_SRC_REC_SUMMARY.CREATE_DT);

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
						GV_SRC_REC_SUMMARY.REPROCESSED_DATE,		--<< P_REPROCESSED_DATE
						GV_SRC_REC_SUMMARY.INSTANCE_STATUS 	--<< P_INSTANCE_STATUS
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
						GV_SRC_REC_SUMMARY.REPROCESSED_DATE,	--<< P_REPROCESSED_DATE
						GV_SRC_REC_SUMMARY.INSTANCE_STATUS 	--<< P_INSTANCE_STATUS
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
	P_REPROCESSED_DATE		DATE DEFAULT NULL,
	P_INSTANCE_STATUS      VARCHAR DEFAULT 'Active'
	)
IS
-- *****************************************************
-- MFB_V2 REPLACEMENT FOR Update fact for BPM Semantic model - Mail Fax Batch Process
-- *****************************************************

	LV_END_DATE							DATE			:= NULL;

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

		LV_END_DATE := COALESCE(GV_SRC_REC_SUMMARY.REPROCESSED_DATE,
								GV_SRC_REC_SUMMARY.CANCEL_DT,
								GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT,
								GV_SRC_REC_SUMMARY.COMPLETE_DT,
								BPM_COMMON.GET_MAX_DATE);


		SELECT COUNT(*),
			SUM(CASE WHEN D_DATE < P_CREATE_DT THEN 1 ELSE 0 END),
			SUM(CASE WHEN D_DATE > LV_END_DATE THEN 1 ELSE 0 END)
		INTO LV_ROW_COUNT, LV_DATE_BEFORE_COUNT, LV_DATE_AFTER_COUNT
		FROM F_MFB_V2_BY_HOUR
		WHERE MFB_V2_BI_ID	=	P_MFB_V2_BI_ID;

		--DBMS_OUTPUT.PUT_LINE('**** '||'P_MFB_V2_BI_ID '||P_MFB_V2_BI_ID||
		--' P_CREATE_DT: '||NVL(TO_CHAR(P_CREATE_DT,'YYYYMMDD HH24:MI:SS'),'NULL')||
		--' LV_END_DATE: '||NVL(TO_CHAR(GV_END_DATE,'YYYYMMDD HH24:MI:SS'),'NULL')||
		--' LV_ROW_COUNT: '||LV_ROW_COUNT||
		--' before_count '||LV_DATE_BEFORE_COUNT||' after count '||LV_DATE_AFTER_COUNT);

		IF LV_DATE_BEFORE_COUNT > 0
		THEN
			DELETE FROM F_MFB_V2_BY_HOUR
			WHERE MFB_V2_BI_ID	=	P_MFB_V2_BI_ID
			AND TO_CHAR(BUCKET_START_DATE,'YYYYMMDDHH24') < TO_CHAR(P_CREATE_DT,'YYYYMMDDHH24');

            GV_F_MFB_V2_BY_HOUR_DELETE_COUNT := GV_F_MFB_V2_BY_HOUR_DELETE_COUNT + SQL%ROWCOUNT;

		END IF;


		IF LV_DATE_AFTER_COUNT > 0
		THEN
			DELETE FROM F_MFB_V2_BY_HOUR
			WHERE MFB_V2_BI_ID	=	P_MFB_V2_BI_ID
			AND TO_CHAR(BUCKET_END_DATE,'YYYYMMDDHH24') > TO_CHAR(LV_END_DATE,'YYYYMMDDHH24')
			AND NOT ( P_INSTANCE_STATUS = 'Active' AND TO_CHAR(BUCKET_END_DATE,'YYYYMMDDHH24') =  TO_CHAR(BPM_COMMON.GET_MAX_DATE,'YYYYMMDDHH24'));

            GV_F_MFB_V2_BY_HOUR_DELETE_COUNT := GV_F_MFB_V2_BY_HOUR_DELETE_COUNT + SQL%ROWCOUNT;

		END IF;

		COMMIT;

	--	IF LV_ROW_COUNT - (LV_DATE_BEFORE_COUNT + LV_DATE_AFTER_COUNT ) <= 0
	--	THEN  -- There are now rows in FACT_BY_HOUR
	--		RETURN;
	--	END IF;

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


		-- See if a Fact record was returned
		IF LV_MFB_V2_FBH_ID_OLD IS NOT NULL
		AND LV_COMPLETION_COUNT_OLD >= 1
		THEN
			-- Do not modify fact table further once an instance has EVER been
			-- completed or cancelled.
            GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT := GV_FACT_BY_HOUR_UPDATE_SKIP_COUNT + 1;
			RETURN;
		END IF;

		LV_BUCKET_START_DATE	:= TO_DATE(TO_CHAR(P_CREATE_DT,'YYYY/MM/DD HH24'),'YYYY/MM/DD HH24');
		LV_BUCKET_END_DATE	    := TO_DATE(TO_CHAR(COALESCE(LV_END_DATE,BPM_COMMON.MAX_DATE),'YYYY/MM/DD HH24'),'YYYY/MM/DD HH24');

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
			-- A RECORD WAS INSERTED -- EXIT

			RETURN;

		END IF;

		-- A RECORD WAS RETURNED - SEE IF IT NEEDS TO BE INSERTED OR UPDATED

		LV_BUCKET_START_DATE	:= TO_DATE(TO_CHAR(GREATEST(P_CREATE_DT,P_EVENT_DATE),'YYYY/MM/DD HH24'),'YYYY/MM/DD HH24');
		LV_BUCKET_END_DATE	    := TO_DATE(TO_CHAR(COALESCE(GV_END_DATE,BPM_COMMON.MAX_DATE),'YYYY/MM/DD HH24'),'YYYY/MM/DD HH24');

		IF 	P_CANCELLED_DT 			IS NULL
		AND P_BATCH_COMPLETED_DT	IS NULL
		AND P_REPROCESSED_DATE		IS NULL
		THEN	--<< it's not completed or cancelled or reprocesed or deleted
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
		-- Same bucket time.  UPDATE THE RECORD
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
			-- DIFFERENT BUCKET TIME. UPDATE THE OLD AND INSER A NEW RECORD
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
			GV_FILE_NAME 			:= 'NYHIX_MFB_V2_BATCH_SUMMARY_PKG.LOAD_F_MFB_V2_BY_HOUR';

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
        nvl(GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG,'N'),
        nvl(GV_SRC_REC_SUMMARY.DOCS_CREATED_FLAG,'N'),
        nvl(GV_SRC_REC_SUMMARY.DOCS_DELETED_FLAG,'N'),
        nvl(GV_SRC_REC_SUMMARY.PAGES_REPLACED_FLAG,'N'),
        nvl(GV_SRC_REC_SUMMARY.PAGES_DELETED_FLAG,'N'),
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
				-- Because of conversion of History data
				-- It is possibe for there to be rows in BATCH_SUMMARY
				-- and NO rows in STATS_BATCH.
				-- DO NOTHING
               -- GV_SRC_REC_SUMMARY.BATCH_GUID := p_Batch_GUID;																						-- DEBUG
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

		IF TRUNC(GV_LAST_FACT_BY_DAY_DT) <> TRUNC(SYSDATE)
		THEN

			DELETE FROM F_MFB_V2_BY_DAY
			WHERE BATCH_GUID = GV_BATCH_GUID
			AND D_DATE > TRUNC(GVLAST_FACT_BY_DAY_DT);

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

	LV_LOOP_COUNT 					Number := 0;
	LV_BUSINESS_DAY_COUNT			Number := 0;
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

		LV_BUSINESS_DAY_COUNT 	:= 0;

		LV_LOOP_COUNT 				:= 0;
		LV_D_DATE_COUNT             := 0;
        LV_D_DATE_BEFORE_COUNT      := 0;
        LV_D_DATE_AFTER_COUNT       := 0;

        LV_P_D_DATE                 := NULL;
        LV_P_START_DATE             := NULL;
        LV_P_END_DATE               := NULL;
        LV_P_AGE_IN_BUSINESS_DAYS   := 0;

        GV_LAST_FACT_BY_DAY_DT      := SYSDATE +1;
        GV_BATCH_CANCEL_DT          := TO_DATE(NULL);
        GV_BATCH_COMPLETE_DT        := TO_DATE(NULL);

		GV_BATCH_GUID := P_BATCH_GUID;

		--dbms_output.put_line('load_fact_by_day.GV_BATCH_GUID  '||GV_BATCH_GUID );
		BEGIN
			SELECT TRUNC(LEAST(NVL(CANCEL_DT,SYSDATE+1),
						NVL(BATCH_COMPLETE_DT,SYSDATE+1),
						NVL(COMPLETE_DT,SYSDATE+1),
						NVL(REPROCESSED_DATE,SYSDATE+1),
						SYSDATE+1))
			INTO GV_LAST_FACT_BY_DAY_DT
			FROM NYHIX_MFB_V2_BATCH_SUMMARY
			WHERE BATCH_GUID = P_BATCH_GUID;

		EXCEPTION
			WHEN NO_DATA_FOUND
			THEN GV_LAST_FACT_BY_DAY_DT := TRUNC(SYSDATE +1);

			WHEN OTHERS
			THEN RAISE;

		END;

		SELECT COUNT(*),
			SUM(CASE WHEN D_DATE < TRUNC(CREATE_DT) THEN 1 ELSE 0 END),
			SUM(CASE WHEN D_DATE > TRUNC(GV_LAST_FACT_BY_DAY_DT) THEN 1 ELSE 0 END)
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

		COMMIT;


		IF LV_D_DATE_COUNT > 0
		AND LV_D_DATE_AFTER_COUNT > 0
		THEN
			-- DBMS_OUTPUT.PUT_LINE('DELETING  ******* '||LV_D_DATE_AFTER_COUNT);
			DELETE FROM F_MFB_V2_BY_DAY
			WHERE BATCH_GUID = P_BATCH_GUID
			AND D_DATE > GV_LAST_FACT_BY_DAY_DT;
		END IF;

		COMMIT;

		-- Loop through the days for a specific batch_guid
		IF (F_BY_DAY_CSR%ISOPEN)
		THEN
			CLOSE F_BY_DAY_CSR;
		END IF;

		OPEN F_BY_DAY_CSR;
		GV_F_BY_DAY_CSR_OPEN := GV_F_BY_DAY_CSR_OPEN +1;

		LV_BUSINESS_DAY_COUNT 	:= 0;
		LV_LOOP_COUNT := 0;

		LOOP -- Inner LOOP

			FETCH F_BY_DAY_CSR INTO GV_FACT_JOIN_REC;

			EXIT WHEN F_BY_DAY_CSR%NOTFOUND;

			GV_FACT_BY_DAY_PROCESSED_COUNT := GV_FACT_BY_DAY_PROCESSED_COUNT+1;

			LV_LOOP_COUNT := LV_LOOP_COUNT +1;

			-- DETERMINE THE BUSINES HOURS BETWEEN THE CREATE_DATE AND END_DATE OF A BATCH

            -- format the Parms for the function

            LV_P_D_DATE := GV_FACT_JOIN_REC.SRC_D_DATE;

            LV_P_END_DATE := TO_DATE(TO_CHAR(LEAST( SYSDATE,												-- << END_DATE  *******
												    NVL( GV_FACT_JOIN_REC.SRC_BATCH_COMPLETE_DT,
												         --	(GV_FACT_JOIN_REC.SRC_D_DATE +19/24 )
													    (TRUNC(SYSDATE) +19/24 )
											           )
											      )
									        ,'YYYYMMDD HH24:MI:SS'),
								'YYYYMMDD HH24:MI:SS');

			IF GV_FACT_JOIN_REC.SRC_BUSINESS_DAY_FLAG = 'Y'
			THEN
				LV_BUSINESS_DAY_COUNT := LV_BUSINESS_DAY_COUNT + 1;
			END IF;

			IF LV_LOOP_COUNT = 1
			AND TRUNC(GV_FACT_JOIN_REC.SRC_CREATE_DT) = TRUNC(GV_FACT_JOIN_REC.SRC_BATCH_COMPLETE_DT)
			-- EVEN IT IT IS NOT A WORK DAY IF THE BATCH STARTS AND COMPLETES ON THE SAME DAY
			-- USE THE START AND END DATE
			THEN
				GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_HOURS := (GV_FACT_JOIN_REC.SRC_BATCH_COMPLETE_DT - GV_FACT_JOIN_REC.SRC_CREATE_DT )*24;
				GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_DAYS  := 0;
			ELSE
				-- USE THE FUNCTION TO DETERMINE THE HOURS AND DAYS
				-- The start date could be a NON work Day
				-- it needs to be adjusted to the start of the first work day.
				IF LV_BUSINESS_DAY_COUNT = 1
				THEN
					LV_P_START_DATE := GREATEST(GV_FACT_JOIN_REC.SRC_CREATE_DT,TO_DATE(TO_CHAR(LV_P_D_DATE,'YYYYMMDD')||'07:00','YYYYMMDDHH24:MI'));
				END IF;

				LV_P_AGE_IN_BUSINESS_DAYS := LV_BUSINESS_DAY_COUNT;  --

				--DBMS_OUTPUT.PUT_LINE('BUSINESS_DAY_FLAG '||GV_FACT_JOIN_REC.SRC_BUSINESS_DAY_FLAG);
               	--DBMS_OUTPUT.PUT_LINE('LV_P_D_DATE '||LV_P_D_DATE);
                --DBMS_OUTPUT.PUT_LINE('LV_P_START_DATE '||LV_P_START_DATE);
                --DBMS_OUTPUT.PUT_LINE('LV_P_END_DATE '||LV_P_END_DATE);
                --DBMS_OUTPUT.PUT_LINE('LV_P_AGE_IN_BUSINESS_DAYS '||LV_P_AGE_IN_BUSINESS_DAYS);


				GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_HOURS
				 	:= MAXDAT.BUS_HRS_BETWEEN(
						GV_FACT_JOIN_REC.SRC_BUSINESS_DAY_FLAG,
                        LV_P_D_DATE,
                        LV_P_START_DATE,
                        LV_P_END_DATE,
                        LV_P_AGE_IN_BUSINESS_DAYS );
       --         END IF;

                IF GV_FACT_JOIN_REC.SRC_BUSINESS_DAY_FLAG = 'Y'
                THEN
                    GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_DAYS := LV_BUSINESS_DAY_COUNT - 1 ;
                ELSE
                    GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_DAYS := 0;
                END IF;


               END IF;

                --	DBMS_OUTPUT.PUT_LINE('LV_P_D_DATE '||LV_P_D_DATE);
                --	DBMS_OUTPUT.PUT_LINE('LV_P_START_DATE '||LV_P_START_DATE);
                --	DBMS_OUTPUT.PUT_LINE('LV_P_END_DATE '||LV_P_END_DATE);
                --	DBMS_OUTPUT.PUT_LINE('LV_P_AGE_IN_BUSINESS_DAYS '||LV_P_AGE_IN_BUSINESS_DAYS);
				-- 	DBMS_OUTput.put_line('LV_BUSINESS_DAY_COUNT: '||LV_BUSINESS_DAY_COUNT);
				-- 	DBMS_OUTput.put_line('GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_DAYS: '||GV_FACT_JOIN_REC.SRC_AGE_IN_BUSINESS_DAYS);
				--  DBMS_OUTPUT.PUT_LINE('fact_by_day_tst.LV_end_date '||LV_END_Date);
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
-- *****************************************************
-- *****************************************************
-- *****************************************************
Procedure RESET_END_DATE( p_MODULE_NAME varchar default null)
IS
BEGIN

IF P_MODULE_NAME = 'Scan'
THEN -- 1
	GV_SRC_REC_SUMMARY.ASF_SCAN_BATCH 	:= 'N';
	GV_SRC_REC_SUMMARY.ASED_SCAN_BATCH := to_date(null);	 		
	--  2 
	GV_SRC_REC_SUMMARY.ASF_PERFORM_QC		:= 'N';
	GV_SRC_REC_SUMMARY.ASED_PERFORM_QC		:= to_date(null);		
	-- 3
	GV_SRC_REC_SUMMARY.ASF_RECOGNITION	:= 'N';
	GV_SRC_REC_SUMMARY.ASED_RECOGNITION := to_date(null);	
	GV_SRC_REC_SUMMARY.RECOGNITION_DT  := to_date(null);	
	-- 4
	GV_SRC_REC_SUMMARY.ASF_VALIDATE_DATA	:= 'N';
	GV_SRC_REC_SUMMARY.VALIDATION_DT	:= to_date(null);	
	GV_SRC_REC_SUMMARY.ASED_VALIDATE_DATA 	:= to_date(null);	
	-- 5
	GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION	:= 'N';
	GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION	:= to_date(null);	
	-- 6
	GV_SRC_REC_SUMMARY.ASF_CREATE_PDF	:=  'N';
	GV_SRC_REC_SUMMARY.ASED_CREATE_PDF	:= to_date(null);	
	-- 7
	GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS		:= 'N';
	GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS	:= to_date(null);	
	--
ELSIF 
	P_MODULE_NAME = 'Quality Control (FAX)'
    THEN -- 2
	GV_SRC_REC_SUMMARY.ASF_PERFORM_QC		:= 'N';
	GV_SRC_REC_SUMMARY.ASED_PERFORM_QC		:= to_date(null);		
	-- 3
	GV_SRC_REC_SUMMARY.ASF_RECOGNITION	:= 'N';
	GV_SRC_REC_SUMMARY.ASED_RECOGNITION := to_date(null);	
	GV_SRC_REC_SUMMARY.RECOGNITION_DT  := to_date(null);	
	-- 4
	GV_SRC_REC_SUMMARY.ASF_VALIDATE_DATA	:= 'N';
	GV_SRC_REC_SUMMARY.VALIDATION_DT	:= to_date(null);	
	GV_SRC_REC_SUMMARY.ASED_VALIDATE_DATA 	:= to_date(null);	
	-- 5
	GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION	:= 'N';
	GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION	:= to_date(null);	
	-- 6
	GV_SRC_REC_SUMMARY.ASF_CREATE_PDF	:=  'N';
	GV_SRC_REC_SUMMARY.ASED_CREATE_PDF	:= to_date(null);	
	-- 7
	GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS		:= 'N';
	GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS	:= to_date(null);	
	--
ELSIF 
	P_MODULE_NAME = 'KTM Server' 
    THEN 	-- 3
	GV_SRC_REC_SUMMARY.ASF_RECOGNITION	:= 'N';
	GV_SRC_REC_SUMMARY.ASED_RECOGNITION := to_date(null);	
	GV_SRC_REC_SUMMARY.RECOGNITION_DT  := to_date(null);	
	-- 4
	GV_SRC_REC_SUMMARY.ASF_VALIDATE_DATA	:= 'N';
	GV_SRC_REC_SUMMARY.VALIDATION_DT	:= to_date(null);	
	GV_SRC_REC_SUMMARY.ASED_VALIDATE_DATA 	:= to_date(null);	
	-- 5
	GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION	:= 'N';
	GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION	:= to_date(null);	
	-- 6
	GV_SRC_REC_SUMMARY.ASF_CREATE_PDF	:=  'N';
	GV_SRC_REC_SUMMARY.ASED_CREATE_PDF	:= to_date(null);	
	-- 7
	GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS		:= 'N';
	GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS	:= to_date(null);	
	--
ELSIF 
	P_MODULE_NAME = 'KTM Validation'
    THEN 	-- 4
	GV_SRC_REC_SUMMARY.ASF_VALIDATE_DATA	:= 'N';
	GV_SRC_REC_SUMMARY.VALIDATION_DT	:= to_date(null);	
	GV_SRC_REC_SUMMARY.ASED_VALIDATE_DATA 	:= to_date(null);	
	-- 5
	GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION	:= 'N';
	GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION	:= to_date(null);	
	-- 6
	GV_SRC_REC_SUMMARY.ASF_CREATE_PDF	:=  'N';
	GV_SRC_REC_SUMMARY.ASED_CREATE_PDF	:= to_date(null);	
	-- 7
	GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS		:= 'N';
	GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS	:= to_date(null);	
ELSIF 
	P_MODULE_NAME = 'KCN Server'
    THEN 	-- 5
	GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION	:= 'N';
	GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION	:= to_date(null);	
	-- 6
	GV_SRC_REC_SUMMARY.ASF_CREATE_PDF	:=  'N';
	GV_SRC_REC_SUMMARY.ASED_CREATE_PDF	:= to_date(null);	
	-- 7
	GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS		:= 'N';
	GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS	:= to_date(null);	
	--
ELSIF 
	P_MODULE_NAME = 'PDF Generator'
    THEN 	-- 6
	GV_SRC_REC_SUMMARY.ASF_CREATE_PDF	:=  'N';
	GV_SRC_REC_SUMMARY.ASED_CREATE_PDF	:= to_date(null);	
	-- 7
	GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS		:= 'N';
	GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS	:= to_date(null);	
	--
ELSIF 
	P_MODULE_NAME = 'Export'
    THEN 	-- 7
	GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS		:= 'N';
	GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS	:= to_date(null);	
	--

END IF;	

--END;

NULL;

EXCEPTION
    WHEN OTHERS THEN RAISE;
END RESET_END_DATE;

-- *****************************************************
-- *****************************************************
-- *****************************************************
Procedure Extract_Batch_Event(P_SOURCE_SERVER VARCHAR DEFAULT 'CENTRAL', P_BATCH_GUID varchar default null) 
IS
		-- *****************************************************
		-- This procedure is run for a Batch_Guid
		-- it loops through each Event in the batch
		-- and summarized the results into the Batc Summary table 
		-- *****************************************************
			------------------------------------------------------------------------------------------
			-- Batches from Kofax are either 'Active', 'Completed' or 'Deleted'
			--
			-- ****************************************************************
			-- *** IT IS CRITICAL THAT A BATCH REMAINS 'Active' UNLESS 		***
			-- *** IT HAS ACTUALLY BEEN 'Completed' or 'Deleted'			***  
			-- ****************************************************************
			--
			-- A batch will usually have a "Normal" Completion
			--
			-- A "Normal" completion is defined as event record having
			-- 		( Module Name = 'Export'
			-- 		Module_Close_Name = null
			-- 		Batch_Status = 64
			--		)
			--
			-- A "Normal" completion usually has Deleted = 'Y'.. This means that
			-- Determination of a 'Deleted' batch must exclude the "Normal" Completions	
			-- and "Normal" Completions "should" be the last record for the batch
			--
			-- If it was NOT a "Normal" Completion then DELETED = 'Y' indicates
			-- the batch was 'Deleted' by Kofax.		 
			-- and the record "should" be the last record for the batch
			--
			-- A batch can also be "Reprocessed" by MAXDAT. Reprocessing is 
			-- usually authorized by en Email from the "USER". 
			-- There is a Micro Strategy Screen ( tool ) which should be used 
			-- to flag a BATCH as "Reprocessed". Reprocessed batches are flagged
			-- in NYHIX_MFB_V2_STATS_BATCH (REPROCESSED_FLAG) 
			-- and NYHIX_MFB_V2_BATCH_SUMMARY (REPROCESSED_FLAG, REPROCESSED_DATE)  
			------------------------------------------------------------------------------------------
			-- Note: Reprocessing is typically initiated through micro strategy. It can be used to
			-- modify the flags by setting the reprocessed_flag on or off.
			-- Micro Startegy actually fires a procedure which then fires this process
			-- for 'one' batch.
			------------------------------------------------------------------------------------------
			-- These are the dates and flags which need to be set by the this procedure
			--
			-- INSTANCE_STATUS		<< Values are 'Active' or 'Complete' ( add 'Deleted' and 'Reprocessed' ???)
			-- INSTANCE_STATUS_DT	<< COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
			-- BATCH_COMPLETE_DT 	<< SET IN THIS PROCESS ONLY FOR "NORMAL COMPLETIONS"
			-- COMPLETE_DT   		<< SET IN THIS PROCESS FOR "NORMAL COMPLETIONS", "REPROCESSED", "DELETED" OR ???
			
			-- BATCH_DELETED 		<< SET BASED ON 'DELETED' IN BATCH_EVENT PROCESSING
			
			-- CANCEL_DT			<< SET BASED ON 'DELETED' IN BATCH_EVENT OR "Reprocessing"
			-- CANCEL_BY			<< SET BASED ON 'DELETED' IN BATCH_EVENT OR "Reprocessing"
			-- CANCEL_REASON		<< SET BASED ON 'DELETED' IN BATCH_EVENT OR "Reprocessing"
			-- CANCEL_METHOD		<< SET BASED ON 'DELETED' IN BATCH_EVENT OR "Reprocessing"
			
			-- REPROCESSED_FLAG		<< THIS IS SET IN NYHIX_MFB_V2_STATS_BATCH AND IN NYHIX_MFB_V2_BATCH_SUMMARY 
			-- REPROCESSED_DATE		
			
			----------------------------------------------------------------------------------------------------
			----------------------------------------------------------------------------------------------------
			
			-- WHEN A BATCH COMPLETES "NORMALLY
			-- SET
			-- INSTANCE_STATUS		<< 'Complete' 
			-- INSTANCE_STATUS_DT	<< COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
			-- BATCH_COMPLETE_DT 	<< SET IN THIS PROCESS ONLY FOR "NORMAL COMPLETIONS"
			-- COMPLETE_DT   		<< SET IN THIS PROCESS FOR "NORMAL COMPLETIONS", "REPROCESSED", "DELETED" OR ???
			-- BATCH_DELETED 		<< 'N'
			-- REPROCESSED_DATE		<< NULL
			-- REPROCESSED_FLAG		<< 'N'
			
			-- CANCEL_DT			<< NULL
			-- CANCEL_BY			<< NULL
			-- CANCEL_REASON		<< NULL
			-- CANCEL_METHOD		<< NULL
			
			----------------------------------------------------------------------------------------------------
			----------------------------------------------------------------------------------------------------
			
			-- WHEN A BATCH IS "REPROCESSED"
			-- SET 
			-- INSTANCE_STATUS		<< 'Complete' (  or 'Reprocessed' ???)
			-- INSTANCE_STATUS_DT	<< COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
			-- BATCH_COMPLETE_DT 	<< NULL 
			-- COMPLETE_DT   		<< NYHIX_MFB_V2_REPROCESSED_BATCH..REPROCESSED_DATE
		
			-- BATCH_DELETED 		<< 'N'
			-- REPROCESSED_DATE		<< NYHIX_MFB_V2_REPROCESSED_BATCH..REPROCESSED_DATE
			-- REPROCESSED_FLAG		<< 'Y'
			
			-- CANCEL_DT			<< NYHIX_MFB_V2_REPROCESSED_BATCH.REPROCESSED_DATE
			-- CANCEL_BY			<< NYHIX_MFB_V2_REPROCESSED_BATCH.CREATION_USER_ID
			-- CANCEL_REASON		<< NYHIX_MFB_V2_REPROCESSED_BATCH.JIRA_NUMBER
			-- CANCEL_METHOD		<< "NYHIX_MFB_V2_REPROCESS_BATCH"
			
			----------------------------------------------------------------------------------------------------
			----------------------------------------------------------------------------------------------------
			
			-- WHEN A BATCH IS 'DELETED"
			-- SET
			-- INSTANCE_STATUS		<< 'Complete' or 'Deleted' ???)
			-- INSTANCE_STATUS_DT   << << COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
			-- BATCH_COMPLETE_DT 	<< SET IN THIS PROCESS ONLY FOR "NORMAL COMPLETIONS"
			-- COMPLETE_DT   		<< SET IN THIS PROCESS FOR "NORMAL COMPLETIONS", "REPROCESSED", "DELETED" OR ???
			
			-- BATCH_DELETED 		<< 'Y'
			-- REPROCESSED_DATE		<< NULL
			-- REPROCESSED_FLAG		<< 'N'
			
			-- CANCEL_DT			<< SET BASED ON 'DELETED' IN BATCH_EVENT OR "Reprocessing"
			-- CANCEL_BY			<< SET BASED ON 'DELETED' IN BATCH_EVENT OR "Reprocessing"
			-- CANCEL_REASON		<< 'Batch Deleted' or ???
			-- CANCEL_METHOD		<< 'Kofax Processing'
			
			------------------------------------------------------------------------------------------
			------------------------------------------------------------------------------------------
			--------------------------------------------------------------------------------
			-- These are the values that can be obtained from CORP_ETL_CONTROL
			--GV_MFB_SCAN_MODULE_NAME: 				Scan
			--GV_MFB_QC_MODULE_NAME:				Quality Control
			--GV_MFB_CLASSIFICATION_MODULE_NAME: 	KCN Server		
			--GV_MFB_RECOGNITION_MODULE_NAME: 		KTM Server
			--GV_MFB_VALIDATION_MODULE_NAME: 		KTM Validation
			--------------------------------------------------------------------------------
			-- These are the Module_name values as of October 2021
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

	CURSOR BATCH_EVENT_CSR IS
	select MFB_V2_CREATE_DATE,
        MFB_V2_UPDATE_DATE,
        BATCH_MODULE_ID,
        BATCH_GUID,
        MODULE_LAUNCH_ID,
        MODULE_UNIQUE_ID,
        MODULE_NAME,
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
    FROM NYHIX_MFB_V2_BATCH_EVENT
	WHERE SOURCE_SERVER = P_SOURCE_SERVER
	AND BATCH_GUID = P_BATCH_GUID
    ORDER BY -- Note because start and end dates are date format not timestamp
			-- there are multiple cases with idnentical start times ( usually 2)
			-- OR multiple identical end times ( usually 2)
			-- The NYHIX_MFB_V2_STATS_BATCH_MODULE does have timestamp info
			-- but the target table NYHIX_MFB_V2_BATCH_EVENT does not
			-- the order by "should" be 99.99% correct
			-- see the following 2 batches out of 650K batches 
			-- where there was a event which  
			-- started before the export and ended after the export
			-- '{67a0713c-f5c2-4487-b46d-5ba59bdeb501}'
			-- '{0e1bc0c6-fcae-4923-9bbc-884d604ca951}'
			-- note Kofax deletes data after 180 days
			SOURCE_SERVER DESC,
			START_DATE_TIME,
	        NVL(END_DATE_TIME,START_DATE_TIME);
	--------------------------------------
	BEGIN

		GV_EVENT_COUNT := 0;

		IF (BATCH_EVENT_CSR%ISOPEN)
		THEN
			CLOSE BATCH_EVENT_CSR;
		END IF;

		-- SET THESE AT THE START OF EVERY BATCH
		-- THEY WILL BE SET BY THE PROCESSINGS OF EVENTS

	    GV_SRC_REC_SUMMARY.INSTANCE_STATUS		:= 'Active';
        GV_SRC_REC_SUMMARY.BATCH_DELETED 		:= 'N';
        GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT 	:= NULL;
		GV_SRC_REC_SUMMARY.COMPLETE_DT			:= NULL;
		GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT	:= NULL;
        GV_SRC_REC_SUMMARY.CANCEL_DT		 	:= NULL;
		GV_SRC_REC_SUMMARY.CANCEL_METHOD		:= NULL;
		GV_SRC_REC_SUMMARY.CANCEL_REASON		:= NULL;
		GV_SRC_REC_SUMMARY.CANCEL_BY 				:= NULL;

		GV_SRC_REC_SUMMARY.BATCH_PRIORITY 		:= NULL;

		GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG 	:= 'N';
		GV_SRC_REC_SUMMARY.PAGES_DELETED_FLAG 	:= 'N';
		GV_SRC_REC_SUMMARY.DOCS_CREATED_FLAG 	:= 'N'; 
		GV_SRC_REC_SUMMARY.DOCS_DELETED_FLAG 	:= 'N';
		GV_SRC_REC_SUMMARY.PAGES_REPLACED_FLAG 	:= 'N';

		GV_SRC_REC_SUMMARY.INSTANCE_STATUS 			:= 'Active';
		GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT 		:= NULL;
		GV_SRC_REC_SUMMARY.COMPLETE_DT				:= NULL;


		-- Note these are from STATS_BATCH and must NOT be altered by EVENT procedure.
		-- GV_SRC_REC_SUMMARY.REPROCESSED_FLAG,
		-- GV_SRC_REC_SUMMARY.REPROCESSED_DATE,
		-- GV_SRC_REC_SUMMARY.BATCH_CLASS,
		-- GV_SRC_REC_SUMMARY.BATCH_CLASS_DES,
		-- GV_SRC_REC_SUMMARY.BATCH_TYPE,
		-- GV_SRC_REC_SUMMARY.CREATE_DT,
		-- GV_SBM_MAX_END_DATE_TIME,
 
		OPEN BATCH_EVENT_CSR;
		
		-- ***************************************************************
		-- ***************************************************************
		LOOP  -- FOR EACH EVENT In a BATCH

		FETCH BATCH_EVENT_CSR
            INTO
				GV_SRC_REC_EVENT.MFB_V2_CREATE_DATE,
                GV_SRC_REC_EVENT.MFB_V2_UPDATE_DATE,
                GV_SRC_REC_EVENT.BATCH_MODULE_ID,
                GV_SRC_REC_EVENT.BATCH_GUID,
                GV_SRC_REC_EVENT.MODULE_LAUNCH_ID,
                GV_SRC_REC_EVENT.MODULE_UNIQUE_ID,
                GV_SRC_REC_EVENT.MODULE_NAME,
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

			GV_SRC_REC_SUMMARY.LAST_EVENT_MODULE_NAME 	:= GV_SRC_REC_EVENT.MODULE_NAME;
			GV_SRC_REC_SUMMARY.CURRENT_BATCH_MODULE_ID	:= GV_SRC_REC_EVENT.BATCH_MODULE_ID;

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

			GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT := COALESCE
													(GV_SRC_REC_EVENT.END_DATE_TIME,
													GV_SBM_MAX_END_DATE_TIME,
													GV_TARGET_REC.INSTANCE_STATUS_DT
													);
													

			-----------------------------------------------------------------------------
			-- These flags are set if ANY of the EVENT records 
			-- meet the criteria.  They are in effect 'Cumulative'. 
			-----------------------------------------------------------------------------
			
			-- Pages_Scanned Note Pages_scanned is a number
			IF NVL(GV_SRC_REC_EVENT.PAGES_SCANNED,0) <> 0
				THEN
					GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG := 'Y';
			END IF;

			-- Pages_Deleted
			IF 	NVL(GV_SRC_REC_EVENT.PAGES_DELETED,0) <> 0
				THEN 
					GV_SRC_REC_SUMMARY.PAGES_DELETED_FLAG := 'Y';
			END IF;

			-- DOCS_Created

			IF NVL(GV_SRC_REC_EVENT.DOCUMENTS_CREATED,0) <> 0
				THEN 
					GV_SRC_REC_SUMMARY.DOCS_CREATED_FLAG := 'Y';
			END IF;

			-- DOCS DELETED

			IF NVL(GV_SRC_REC_EVENT.DOCUMENTS_DELETED,0) <> 0
				THEN 
					GV_SRC_REC_SUMMARY.DOCS_DELETED_FLAG := 'Y';
			END IF;

			-- PAGES_REPLACED

			IF NVL(GV_SRC_REC_EVENT.PAGES_REPLACED,0) <> 0
				THEN 
					GV_SRC_REC_SUMMARY.PAGES_REPLACED_FLAG := 'Y';
			END IF;

			-- Clear ASED_% (End DATES and FlAGS for any 'Down Stream' Modules

			IF GV_SRC_REC_EVENT.MODULE_NAME IS NOT NULL
			THEN
				RESET_END_DATE(GV_SRC_REC_EVENT.MODULE_NAME);
			END IF;	
				
			IF GV_SRC_REC_EVENT.MODULE_CLOSE_NAME IS NOT NULL
			THEN
				RESET_END_DATE(GV_SRC_REC_EVENT.MODULE_CLOSE_NAME);
			END IF;	
				
			---------------------------------------------------------------------------
			-- LOGIC FOR 'REPROCESSED'  This is NOT based on a RECORD from EVENT
			-- It is from STATS_BATCH
			---------------------------------------------------------------------------

			IF NVL(GV_SRC_REC_SUMMARY.REPROCESSED_FLAG,'N') = 'Y'
			THEN
				GV_SRC_REC_SUMMARY.INSTANCE_STATUS 		:= 'Complete';
				GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT	:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT 	:= NULL;
				GV_SRC_REC_SUMMARY.COMPLETE_DT			:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.BATCH_DELETED 		:= 'N';
				GV_SRC_REC_SUMMARY.CANCEL_DT		 	:=  GV_SRC_REC_SUMMARY.REPROCESSED_DATE;
				GV_SRC_REC_SUMMARY.CANCEL_METHOD		:= 'NYHIX_MFB_V2_REPROCESS_BATCH';
				GV_SRC_REC_SUMMARY.BATCH_PRIORITY 		:= GV_SRC_REC_EVENT.PRIORITY;

				--GV_SRC_REC_SUMMARY.REPROCESSED_DATE		:= SYSDATE;   	-- << Already Set by STATS_BATCH proc
				--GV_SRC_REC_SUMMARY.REPROCESSED_FLAG		:= 'Y'			-- << Already Set by STATS_BATCH proc
				
				-- Reset ALL the END DATES
				RESET_END_DATE('Scan');
								
				BEGIN
					SELECT CREATION_USER_ID, JIRA_NUMBER
					INTO GV_SRC_REC_SUMMARY.CANCEL_BY, 	
						GV_SRC_REC_SUMMARY.CANCEL_REASON
					FROM MAXDAT.NYHIX_MFB_V2_REPROCESSED_BATCH
					WHERE NYHIX_MFB_V2_REPROCESSED_ID = ( SELECT MAX(NYHIX_MFB_V2_REPROCESSED_ID)
                            FROM MAXDAT.NYHIX_MFB_V2_REPROCESSED_BATCH
                            WHERE BATCH_NAME =  GV_SRC_REC_SUMMARY.BATCH_NAME
                            );
				EXCEPTION
					WHEN NO_DATA_FOUND THEN NULL;
					WHEN OTHERS THEN RAISE;
				
				END;		

				CONTINUE;  	--<< Because the Reprocessed flag comes from stats batch, 
							--<< all events will be skipped when Reprocessed_flag is set

			END IF;

			---------------------------------------------------------------------------
			-- Logic for DELETED Triggered by the DELETED flag in EVENT 
			-- Does NOT depend on a specific module name		
			---------------------------------------------------------------------------
			
			IF  GV_SRC_REC_EVENT.DELETED 					= 'Y'
			AND NOT ( -- A "Normal Completion"
					GV_SRC_REC_EVENT.MODULE_NAME = 'Export'
					and GV_SRC_REC_EVENT.module_close_name is null
					and GV_SRC_REC_EVENT.batch_status = 64 )
			AND GV_SRC_REC_SUMMARY.CANCEL_DT 				IS NULL
			THEN
				GV_SRC_REC_SUMMARY.INSTANCE_STATUS 			:= 'Complete';
				GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT		:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT 		:= NULL;
				GV_SRC_REC_SUMMARY.COMPLETE_DT				:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);

				GV_SRC_REC_SUMMARY.BATCH_DELETED 			:= 'Y';

				--GV_SRC_REC_SUMMARY.REPROCESSED_DATE		:= NULL;	-- << Set by STATS_BATCH proc
				--GV_SRC_REC_SUMMARY.REPROCESSED_FLAG		:= 'N'		-- << Set by STATS_BATCH proc
				
				GV_SRC_REC_SUMMARY.CANCEL_DT				:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.CANCEL_BY 				:= GV_SRC_REC_EVENT.USER_NAME;
				GV_SRC_REC_SUMMARY.CANCEL_REASON 			:= 'Kofax Processing';
				GV_SRC_REC_SUMMARY.CANCEL_METHOD 			:= 'Kofax Processing';
				
				GV_SRC_REC_SUMMARY.BATCH_PRIORITY 			:= GV_SRC_REC_EVENT.PRIORITY;

				CONTINUE;  -- skip additional processing for this record when DELETED = 'Y' ??

			END IF;

			---------------------------------------------------------------------------
			-- This is a "Normal" completion Triggered by specific EVENT values and Batch Status
			---------------------------------------------------------------------------
			IF GV_SRC_REC_EVENT.MODULE_NAME          	    	= 'Export' --'${EXPORT_MODULE_NAME}'
			AND GV_SRC_REC_EVENT.BATCH_STATUS                   = 64  -- << "Complete'
			AND GV_SRC_REC_EVENT.MODULE_CLOSE_UNIQUE_ID 	    IS NULL
			AND GV_SRC_REC_EVENT.MODULE_CLOSE_NAME 			    IS NULL
			-- be sure it is not Cancelled, Reprocessed or Deleted
			AND NVL(GV_SRC_REC_SUMMARY.REPROCESSED_FLAG,'N')    = 'N'
			AND GV_SRC_REC_SUMMARY.CANCEL_DT 			        IS NULL
			and NVL(GV_SRC_REC_SUMMARY.BATCH_DELETED,'N')       = 'N' 
			THEN  -- This is a 'Normal' completion for the batch
				-- It is suposed to be the LAST record but SOMETIMES IT IS NOT
				-- and these records usually has DELETED = 'Y' 
				-- but theses are NOT deleted batches.
				GV_SRC_REC_SUMMARY.INSTANCE_STATUS			:= 'Complete';
				GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT		:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT 		:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.COMPLETE_DT				:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
				GV_SRC_REC_SUMMARY.BATCH_DELETED 			:= 'N';
				
				--GV_SRC_REC_SUMMARY.REPROCESSED_DATE		:= NULL; 	-- << Set by STATS_BATCH proc  
				--GV_SRC_REC_SUMMARY.REPROCESSED_FLAG		:= 'N';		-- << Set by STATS_BATCH proc
				 
				GV_SRC_REC_SUMMARY.CANCEL_DT 				:= NULL;
				GV_SRC_REC_SUMMARY.CANCEL_BY				:= NULL;
				GV_SRC_REC_SUMMARY.CANCEL_REASON 			:= NULL;
				GV_SRC_REC_SUMMARY.CANCEL_METHOD 			:= NULL;
				--
				GV_SRC_REC_SUMMARY.BATCH_PRIORITY 			:= GV_SRC_REC_EVENT.PRIORITY;
				--
				GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS			:= 'Y'; 
				GV_SRC_REC_SUMMARY.ASSD_RELEASE_DMS			:= GV_SRC_REC_EVENT.START_DATE_TIME;
				GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS			:= GV_SRC_REC_EVENT.END_DATE_TIME;
--				GV_SRC_REC_SUMMARY.CURRENT_BATCH_MODULE_ID 	:= GV_SRC_REC_EVENT.BATCH_MODULE_ID;
				--
				GV_SRC_REC_SUMMARY.ASF_POPULATE_REPORTS		:= 'Y';
				GV_SRC_REC_SUMMARY.ASSD_POPULATE_REPORTS 	:= GV_SRC_REC_EVENT.START_DATE_TIME;
				GV_SRC_REC_SUMMARY.ASED_POPULATE_REPORTS 	:= GV_SRC_REC_EVENT.END_DATE_TIME;

				-- DBMS_OUTPUT.PUT_LINE('UPDATE INSTANCE_STATUS: '||GV_SRC_REC_SUMMARY.INSTANCE_STATUS);

				CONTINUE;

			END IF;


			GV_SRC_REC_SUMMARY.INSTANCE_STATUS 			:= 'Active';
			GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT		:= COALESCE(GV_SRC_REC_EVENT.END_DATE_TIME,GV_SRC_REC_EVENT.START_DATE_TIME);
			GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT 		:= NULL;
			GV_SRC_REC_SUMMARY.COMPLETE_DT				:= NULL;
			GV_SRC_REC_SUMMARY.BATCH_DELETED 			:= 'N';

			--GV_SRC_REC_SUMMARY.REPROCESSED_DATE		:= NULL; 	-- << Set by STATS_BATCH proc
			--GV_SRC_REC_SUMMARY.REPROCESSED_FLAG		:= 'N'		-- << Set by STATS_BATCH proc

			GV_SRC_REC_SUMMARY.CANCEL_DT				:= NULL;
			GV_SRC_REC_SUMMARY.CANCEL_BY 				:= NULL;
			GV_SRC_REC_SUMMARY.CANCEL_REASON 			:= NULL;
			GV_SRC_REC_SUMMARY.CANCEL_METHOD 			:= NULL;
			
			GV_SRC_REC_SUMMARY.BATCH_PRIORITY 			:= GV_SRC_REC_EVENT.PRIORITY;

			-----------------------------------------------------------------------------
			-- START OF SETTING Field associated with specific Modules
			-----------------------------------------------------------------------------
			
			-----------------------------------------------------------
			-- THE FOLLOWING USE THE MODULE_NAME OR SML_MODULE_NAME
			-- FROM AN INDIVIDULE EVENT RECORD TO POPULATES THE
			-- 'AS%' COLUMNS.
			--
			-- NOTE: ANY TESTS WHICH REQUIRE DATA FROM MORE THAT ONE EVENT
			-- ARE DONE AT THE CLOSE OF THE LOOP
			
			-- The AS% "Start Date" is captured on the FIRST occurence
			-- of the Module Name. The "End Date" is captured / over written
			-- on each occurrence. The  End Date sould be the last occurece
			-- of the Module Name.	
			-----------------------------------------------------------

			-----------------------------------------------------------
			-- 'Scan'
			-----------------------------------------------------------

			IF GV_SRC_REC_EVENT.MODULE_NAME = 'Scan' --<<'${SCAN_MODULE_NAME}'
			AND GV_SRC_REC_SUMMARY.ASSD_SCAN_BATCH IS NULL
				THEN -- CAPTURE THE FIRST DATE AS THE START DATE
					GV_SRC_REC_SUMMARY.ASF_SCAN_BATCH	:= 'N';
					GV_SRC_REC_SUMMARY.ASSD_SCAN_BATCH  := GV_SRC_REC_EVENT.START_DATE_TIME;
					GV_SRC_REC_SUMMARY.ASPB_SCAN_BATCH 	:= GV_SRC_REC_EVENT.USER_NAME;
			END IF;
			
			IF GV_SRC_REC_EVENT.MODULE_NAME = 'Scan' --<<'${SCAN_MODULE_NAME}'
			AND GV_SRC_REC_EVENT.BATCH_STATUS = 64  --<< 'Complete'
			THEN
				GV_SRC_REC_SUMMARY.ASF_SCAN_BATCH	:= 'Y';
				GV_SRC_REC_SUMMARY.ASED_SCAN_BATCH 	:= GV_SRC_REC_EVENT.END_DATE_TIME;
			END IF;

			-------------------------------------------------------------------------------
			-- 'Quality Control' 'Quality Control (FAX)'
			-------------------------------------------------------------------------------

			IF 1=1
			AND (
				gv_src_rec_event.MODULE_CLOSE_NAME = 'Quality Control' -- '${QC_MODULE_NAME}'
				OR gv_src_rec_event.MODULE_CLOSE_NAME = 'Quality Control (FAX)' -- '${QC_MODULE_NAME}'
				)
			AND gv_src_rec_summary.ASSD_PERFORM_QC IS NULL	
			THEN -- CAPTURE THE FIRST DATE AS THE START DATE
				gv_src_rec_summary.GWF_QC_REQUIRED 	:= 'N';
				gv_src_rec_summary.ASSD_PERFORM_QC 	:= gv_src_rec_event.START_DATE_TIME;
				gv_src_rec_summary.ASPB_PERFORM_QC := gv_src_rec_event.user_name;
			END IF;

			IF 1=1
			AND (
				gv_src_rec_event.MODULE_CLOSE_NAME = 'Quality Control' -- '${QC_MODULE_NAME}'
				OR gv_src_rec_event.MODULE_CLOSE_NAME = 'Quality Control (FAX)' -- '${QC_MODULE_NAME}'
				)
			AND GV_SRC_REC_EVENT.BATCH_STATUS = 64  --<< 'Complete'
			THEN
				gv_src_rec_summary.GWF_QC_REQUIRED 	:= 'Y';
				gv_src_rec_summary.ASED_PERFORM_QC := gv_src_rec_event.END_date_time;
			END IF;

			-------------------------------------------------------------------------------
			-- 'KCN Server' 	
			-------------------------------------------------------------------------------

			IF GV_SRC_REC_EVENT.MODULE_NAME =  'KCN Server' 		--'${CLASSIFICATION_MODULE_NAME}'
			AND  GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION IS NULL
			THEN -- CAPTURE THE FIRST DATE AS THE START DATE
				GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION	:= 'N';
				GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION	:= GV_SRC_REC_EVENT.END_DATE_TIME;
			END IF;

			IF GV_SRC_REC_EVENT.MODULE_NAME =  'KCN Server' 		--'${CLASSIFICATION_MODULE_NAME}'
			AND GV_SRC_REC_EVENT.BATCH_STATUS = 64  --<< 'Complete'
			THEN
				GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION	:= 'Y';
				GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION	:= GV_SRC_REC_EVENT.END_DATE_TIME;
			END IF;

			-------------------------------------------------------------------------------
			-- 'KTM Server'
			-------------------------------------------------------------------------------

			IF  GV_SRC_REC_EVENT.SML_MODULE_NAME = 'KTM Server' --'${RECOGNITION_MODULE_NAME}'
			AND GV_SRC_REC_SUMMARY.ASSD_RECOGNITION	 IS NULL
			THEN -- CAPTURE THE FIRST DATE AS THE START DATE
				GV_SRC_REC_SUMMARY.ASF_RECOGNITION  := 'N';		
				GV_SRC_REC_SUMMARY.ASSD_RECOGNITION	:= GV_SRC_REC_EVENT.START_DATE_TIME;
			END IF;

			IF GV_SRC_REC_EVENT.SML_MODULE_NAME = 'KTM Server' --'${RECOGNITION_MODULE_NAME}'
			AND GV_SRC_REC_EVENT.BATCH_STATUS = 64
			THEN
				GV_SRC_REC_SUMMARY.ASF_RECOGNITION  := 'Y';		
				GV_SRC_REC_SUMMARY.ASED_RECOGNITION	:= GV_SRC_REC_EVENT.END_DATE_TIME;
			END IF;

			-------------------------------------------------------------------------------
			-- KTM VALIDATION
			-------------------------------------------------------------------------------

			IF NVL(GV_SRC_REC_EVENT.SML_MODULE_NAME,'?') =  'KTM Validation'
			AND GV_SRC_REC_SUMMARY.ASSD_VALIDATE_DATA IS NULL
			THEN -- CAPTURE THE FIRST DATE AS THE START DATE
				GV_SRC_REC_SUMMARY.ASF_VALIDATE_DATA 	:= 'N';
				GV_SRC_REC_SUMMARY.ASSD_VALIDATE_DATA	:= GV_SRC_REC_EVENT.START_DATE_TIME;
				GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA	:= GV_SRC_REC_EVENT.USER_ID;
				GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA_USER_ID := GV_SRC_REC_EVENT.USER_NAME;
			END IF;


			IF NVL(GV_SRC_REC_EVENT.SML_MODULE_NAME,'?') = 'KTN Server'
			AND GV_SRC_REC_EVENT.BATCH_STATUS = 64
			THEN
				GV_SRC_REC_SUMMARY.ASF_VALIDATE_DATA 	:= 'Y';
				GV_SRC_REC_SUMMARY.ASED_VALIDATE_DATA	:= GV_SRC_REC_EVENT.END_DATE_TIME;
				GV_SRC_REC_SUMMARY.VALIDATION_DT 		:= GV_SRC_REC_EVENT.END_DATE_TIME; 
			END IF;

			-------------------------------------------------------------------------------
			-- CLASSIFICATION
			-------------------------------------------------------------------------------

			IF NVL(GV_SRC_REC_EVENT.SML_MODULE_NAME,'?') = 'KTN Server'
			AND GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION IS NULL
			THEN -- CAPTURE THE FIRST DATE AS THE START DATE
				GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION 	:= 'N';
				GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION 	:= GV_SRC_REC_EVENT.START_DATE_TIME;
			END IF;

			IF NVL(GV_SRC_REC_EVENT.SML_MODULE_NAME,'?') = 'KTN Server'
			AND GV_SRC_REC_EVENT.BATCH_STATUS = 64
			THEN
				GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION := 'Y';
				GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION := GV_SRC_REC_EVENT.END_DATE_TIME;
				GV_SRC_REC_SUMMARY.Classification_DT   := GV_SRC_REC_EVENT.END_DATE_TIME;
			END IF;	

			-------------------------------------------------------------------------------
			-- PDF DATA
			-------------------------------------------------------------------------------

			IF 1=1
			AND GV_SRC_REC_EVENT.MODULE_NAME = 'PDF Generator' --'${PDF_MODULE_NAME}'
			AND GV_SRC_REC_SUMMARY.ASSD_CREATE_PDF IS NULL
			THEN -- CAPTURE THE FIRST DATE AS THE START DATE
				GV_SRC_REC_SUMMARY.ASF_CREATE_PDF			:= 'N';
				GV_SRC_REC_SUMMARY.ASF_POPULATE_REPORTS		:= 'N';
				GV_SRC_REC_SUMMARY.ASSD_CREATE_PDF			:=  GV_SRC_REC_EVENT.START_DATE_TIME;
			END  IF;
			
			IF 1=1
			AND GV_SRC_REC_EVENT.MODULE_NAME = 'PDF Generator' --'${PDF_MODULE_NAME}'
			AND GV_SRC_REC_EVENT.BATCH_STATUS=64    
			THEN
				GV_SRC_REC_SUMMARY.ASF_CREATE_PDF			:= 'Y';
				GV_SRC_REC_SUMMARY.ASF_POPULATE_REPORTS		:= 'Y';
				GV_SRC_REC_SUMMARY.ASED_CREATE_PDF 			:=  GV_SRC_REC_EVENT.END_DATE_TIME;
				GV_SRC_REC_SUMMARY.ASED_POPULATE_REPORTS 	:=  GV_SRC_REC_EVENT.START_DATE_TIME;
			END IF;

			--DBMS_OUTPUT.PUT_LINE('BEFORE END LOOP INSTANCE_STATUS: '||GV_SRC_REC_SUMMARY.INSTANCE_STATUS);

			-----------------------------------------------
			-----------------------------------------------

		END LOOP;
		-- ***************************************************************
		-- ***************************************************************

		-- Because the update looks at multiple 'values' these tests
		-- must be done at the end of the LOOP


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


-- DROP PACKAGE BODY MAXDAT.NYHIX_MFB_V2_DOCUMENT_PKG;

CREATE OR REPLACE PACKAGE BODY MAXDAT.NYHIX_MFB_V2_DOCUMENT_PKG AS

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
	GV_DRIVER_TABLE_NAME  		VARCHAR2(100 BYTE)	:= 'NYHIX_MFB_V2_DOCUMENT';
	GV_DRIVER_KEY_NUMBER  		VARCHAR2(100 BYTE)	:= NULL;
	GV_NR_OF_ERROR        		NUMBER				:= 0;
    GV_UPDATE_TS                DATE                := SYSDATE;

	-- USED FOR THE CORP_ETL_JOB_STATISTICS
	GV_JOB_ID                 	NUMBER              := 0;
	GV_JOB_STATUS_CD          	VARCHAR2(20 BYTE)   := 'STARTED';
	GV_FILE_NAME              	VARCHAR2(512 BYTE)	:= 'NYHIX_MFB_V2_DOCUMENT';
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
            SRC.BATCH_GUID                           AS SRC_BATCH_GUID,	-- 1 	3
            SRC.ECN                                  AS SRC_ECN,	-- 1 	4
            SRC.DOCUMENT_NUMBER                      AS SRC_DOCUMENT_NUMBER,	-- 1 	5
            SRC.DCN                                  AS SRC_DCN,	-- 1 	6
            SRC.ORDERNUMBER                          AS SRC_ORDERNUMBER,	-- 1 	7
            SRC.FORM_TYPE                            AS SRC_FORM_TYPE,	-- 1 	8
            SRC.DOC_CLASS                            AS SRC_DOC_CLASS,	-- 1 	9
            SRC.DOC_RECEIPT_DT                       AS SRC_DOC_RECEIPT_DT,	-- 1 	10
            SRC.DOC_CREATION_DT                      AS SRC_DOC_CREATION_DT,	-- 1 	11
            SRC.DOC_PAGE_COUNT                       AS SRC_DOC_PAGE_COUNT,	-- 1 	12
            SRC.CLASSIFIED_DOC                       AS SRC_CLASSIFIED_DOC,	-- 1 	13
            SRC.DELETED                              AS SRC_DELETED,	-- 1 	14
            SRC.CONFIDENCE                           AS SRC_CONFIDENCE,	-- 1 	15
            SRC.CONFIDENT                            AS SRC_CONFIDENT	-- 1 	16    
			FROM MAXDAT.NYHIX_MFB_V2_DOCUMENT_OLTP_V SRC
	),
	TARGET AS
	(
	SELECT 
		ROWID    						  AS TARGET_ROWID,
		-- Insert SQL from Query 1 section 2 Here
	--	TARGET.MFB_V2_CREATE_DATE                AS TARGET_MFB_V2_CREATE_DATE,	-- 2 	1
	--	TARGET.MFB_V2_UPDATE_DATE                AS TARGET_MFB_V2_UPDATE_DATE,	-- 2 	2
        TARGET.BATCH_GUID                        AS TARGET_BATCH_GUID,	-- 2 	3
        TARGET.ECN                               AS TARGET_ECN,	-- 2 	4
        TARGET.DOCUMENT_NUMBER                   AS TARGET_DOCUMENT_NUMBER,	-- 2 	5
        TARGET.DCN                               AS TARGET_DCN,	-- 2 	6
        TARGET.ORDERNUMBER                       AS TARGET_ORDERNUMBER,	-- 2 	7
        TARGET.FORM_TYPE                         AS TARGET_FORM_TYPE,	-- 2 	8
        TARGET.DOC_CLASS                         AS TARGET_DOC_CLASS,	-- 2 	9
        TARGET.DOC_RECEIPT_DT                    AS TARGET_DOC_RECEIPT_DT,	-- 2 	10
        TARGET.DOC_CREATION_DT                   AS TARGET_DOC_CREATION_DT,	-- 2 	11
        TARGET.DOC_PAGE_COUNT                    AS TARGET_DOC_PAGE_COUNT,	-- 2 	12
        TARGET.CLASSIFIED_DOC                    AS TARGET_CLASSIFIED_DOC,	-- 2 	13
        TARGET.DELETED                           AS TARGET_DELETED,	-- 2 	14
        TARGET.CONFIDENCE                        AS TARGET_CONFIDENCE,	-- 2 	15
        TARGET.CONFIDENT                         AS TARGET_CONFIDENT	-- 2 	16    
		FROM MAXDAT.NYHIX_MFB_V2_DOCUMENT TARGET
	)
	SELECT 
	--	SRC_ROWID,
		TARGET_ROWID,
		-- insert SQL from 3 and 4 here
	--	SRC_MFB_V2_CREATE_DATE,                                               	-- 3 	1
	--	SRC_MFB_V2_UPDATE_DATE,                                               	-- 3 	2
                              SRC_BATCH_GUID,                         	-- 3 	3
                              SRC_ECN,                                	-- 3 	4
                              SRC_DOCUMENT_NUMBER,                    	-- 3 	5
                              SRC_DCN,                                	-- 3 	6
                              SRC_ORDERNUMBER,                        	-- 3 	7
                              SRC_FORM_TYPE,                          	-- 3 	8
                              SRC_DOC_CLASS,                          	-- 3 	9
                              SRC_DOC_RECEIPT_DT,                     	-- 3 	10
                              SRC_DOC_CREATION_DT,                    	-- 3 	11
                              SRC_DOC_PAGE_COUNT,                     	-- 3 	12
                              SRC_CLASSIFIED_DOC,                     	-- 3 	13
                              SRC_DELETED,                            	-- 3 	14
                              SRC_CONFIDENCE,                         	-- 3 	15
                              SRC_CONFIDENT,                          	-- 3 	16
--                              TARGET_MFB_V2_CREATE_DATE,              	-- 4 	1
--                              TARGET_MFB_V2_UPDATE_DATE,              	-- 4 	2
                              TARGET_BATCH_GUID,                      	-- 4 	3
                              TARGET_ECN,                             	-- 4 	4
                              TARGET_DOCUMENT_NUMBER,                 	-- 4 	5
                              TARGET_DCN,                             	-- 4 	6
                              TARGET_ORDERNUMBER,                     	-- 4 	7
                              TARGET_FORM_TYPE,                       	-- 4 	8
                              TARGET_DOC_CLASS,                       	-- 4 	9
                              TARGET_DOC_RECEIPT_DT,                  	-- 4 	10
                              TARGET_DOC_CREATION_DT,                 	-- 4 	11
                              TARGET_DOC_PAGE_COUNT,                  	-- 4 	12
                              TARGET_CLASSIFIED_DOC,                  	-- 4 	13
                              TARGET_DELETED,                         	-- 4 	14
                              TARGET_CONFIDENCE,                      	-- 4 	15
                              TARGET_CONFIDENT                       	-- 4 	16    
							  FROM SRC
	LEFT OUTER JOIN TARGET
	ON SRC_DCN = TARGET_DCN;

-----------------------------------------------------

	JOIN_REC   JOIN_CSR%ROWTYPE;

-----------------------------------------------------
PROCEDURE LOAD_DOCUMENT (P_JOB_ID number default 0) 
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

			IF JOIN_REC.SRC_DCN IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN Update_DOCUMENT;
			ELSIF JOIN_REC.SRC_DCN IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NULL 
                --then null;
				THEN INSERT_DOCUMENT;
			ELSIF JOIN_REC.SRC_DCN IS NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN DELETE_DOCUMENT;
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
				'SRC_DCN: '||JOIN_REC.SRC_DCN
				||' TARGET_DCN: '||JOIN_REC.TARGET_DCN
				||'SQLCODE '||GV_ERROR_CODE
				||' '||GV_ERROR_MESSAGE);

			ROLLBACK;

			RAISE;

END Load_DOCUMENT;

-----------------------------------------------------

-----------------------------------------------------
PROCEDURE UPDATE_DOCUMENT IS
-- USES SQL FROM 5 AND 6
-----------------------------------------------------

	BEGIN

	-- COMPARE
		IF 1=2
        --    OR NVL(JOIN_REC.TARGET_MFB_V2_CREATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_CREATE_DATE,SYSDATE - 93333)	-- 5 	1	DATE
        --   OR NVL(JOIN_REC.TARGET_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	-- 5 	2	DATE
            OR NVL(JOIN_REC.TARGET_BATCH_GUID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_GUID,'-?93333')	-- 5 	3	VARCHAR2
            OR NVL(JOIN_REC.TARGET_ECN,'-?93333')	  <>  	NVL(JOIN_REC.SRC_ECN,'-?93333')	-- 5 	4	VARCHAR2
            OR NVL(JOIN_REC.TARGET_DOCUMENT_NUMBER, -93333)	  <>  	NVL(JOIN_REC.SRC_DOCUMENT_NUMBER, -93333)	-- 5 	5	NUMBER
            OR NVL(JOIN_REC.TARGET_DCN,'-?93333')	  <>  	NVL(JOIN_REC.SRC_DCN,'-?93333')	-- 5 	6	VARCHAR2
            OR NVL(JOIN_REC.TARGET_ORDERNUMBER, -93333)	  <>  	NVL(JOIN_REC.SRC_ORDERNUMBER, -93333)	-- 5 	7	NUMBER
            OR NVL(JOIN_REC.TARGET_FORM_TYPE,'-?93333')	  <>  	NVL(JOIN_REC.SRC_FORM_TYPE,'-?93333')	-- 5 	8	VARCHAR2
            OR NVL(JOIN_REC.TARGET_DOC_CLASS,'-?93333')	  <>  	NVL(JOIN_REC.SRC_DOC_CLASS,'-?93333')	-- 5 	9	VARCHAR2
            OR NVL(JOIN_REC.TARGET_DOC_RECEIPT_DT,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_DOC_RECEIPT_DT,SYSDATE - 93333)	-- 5 	10	DATE
            OR NVL(JOIN_REC.TARGET_DOC_CREATION_DT,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_DOC_CREATION_DT,SYSDATE - 93333)	-- 5 	11	DATE
            OR NVL(JOIN_REC.TARGET_DOC_PAGE_COUNT, -93333)	  <>  	NVL(JOIN_REC.SRC_DOC_PAGE_COUNT, -93333)	-- 5 	12	NUMBER
            OR NVL(JOIN_REC.TARGET_CLASSIFIED_DOC,'?')	  <>  	NVL(JOIN_REC.SRC_CLASSIFIED_DOC,'?')	-- 5 	13	CHAR
            OR NVL(JOIN_REC.TARGET_DELETED,'-?93333')	  <>  	NVL(JOIN_REC.SRC_DELETED,'-?93333')	-- 5 	14	VARCHAR2
            OR NVL(JOIN_REC.TARGET_CONFIDENCE,'-?93333')	  <>  	NVL(JOIN_REC.SRC_CONFIDENCE,'-?93333')	-- 5 	15	VARCHAR2
            OR NVL(JOIN_REC.TARGET_CONFIDENT,'-?93333')	  <>  	NVL(JOIN_REC.SRC_CONFIDENT,'-?93333')	-- 5 	16	VARCHAR2			
			THEN
		UPDATE MAXDAT.NYHIX_MFB_V2_DOCUMENT
		SET  
		-- THE UPDATE
        --    MFB_V2_CREATE_DATE                        =  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 6 	1
        --    MFB_V2_UPDATE_DATE                        =  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 6 	2
            BATCH_GUID                                =  JOIN_REC.SRC_BATCH_GUID,	-- 6 	3
            ECN                                       =  JOIN_REC.SRC_ECN,	-- 6 	4
            DOCUMENT_NUMBER                           =  JOIN_REC.SRC_DOCUMENT_NUMBER,	-- 6 	5
            DCN                                       =  JOIN_REC.SRC_DCN,	-- 6 	6
            ORDERNUMBER                               =  JOIN_REC.SRC_ORDERNUMBER,	-- 6 	7
            FORM_TYPE                                 =  JOIN_REC.SRC_FORM_TYPE,	-- 6 	8
            DOC_CLASS                                 =  JOIN_REC.SRC_DOC_CLASS,	-- 6 	9
            DOC_RECEIPT_DT                            =  JOIN_REC.SRC_DOC_RECEIPT_DT,	-- 6 	10
            DOC_CREATION_DT                           =  JOIN_REC.SRC_DOC_CREATION_DT,	-- 6 	11
            DOC_PAGE_COUNT                            =  JOIN_REC.SRC_DOC_PAGE_COUNT,	-- 6 	12
            CLASSIFIED_DOC                            =  JOIN_REC.SRC_CLASSIFIED_DOC,	-- 6 	13
            DELETED                                   =  JOIN_REC.SRC_DELETED,	-- 6 	14
            CONFIDENCE                                =  JOIN_REC.SRC_CONFIDENCE,	-- 6 	15
            CONFIDENT                                 =  JOIN_REC.SRC_CONFIDENT,	-- 6 	16
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

	--	GV_DRIVER_KEY_NUMBER  	:= 'SRC_ROWID : '||JOIN_REC.DCN;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_DOCUMENT_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_DOCUMENT';

		POST_ERROR;

	END UPDATE_DOCUMENT;	

-----------------------------------------------------
PROCEDURE INSERT_DOCUMENT IS
-- USES SQL  FROM 7 AND 8
-----------------------------------------------------

	BEGIN

		INSERT INTO MAXDAT.NYHIX_MFB_V2_DOCUMENT
		(   
         --   MFB_V2_CREATE_DATE,                     	-- 7 	1
          --  MFB_V2_UPDATE_DATE,                     	-- 7 	2
            BATCH_GUID,                             	-- 7 	3
            ECN,                                    	-- 7 	4
            DOCUMENT_NUMBER,                        	-- 7 	5
            DCN,                                    	-- 7 	6
            ORDERNUMBER,                            	-- 7 	7
            FORM_TYPE,                              	-- 7 	8
            DOC_CLASS,                              	-- 7 	9
            DOC_RECEIPT_DT,                         	-- 7 	10
            DOC_CREATION_DT,                        	-- 7 	11
            DOC_PAGE_COUNT,                         	-- 7 	12
            CLASSIFIED_DOC,                         	-- 7 	13
            DELETED,                                	-- 7 	14
            CONFIDENCE,                             	-- 7 	15
            CONFIDENT,                             		-- 7 	16
			MFB_V2_PARENT_JOB_ID
			)
		VALUES (
          --  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	1
          --  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	2
            JOIN_REC.SRC_BATCH_GUID,			-- 8 	3
            JOIN_REC.SRC_ECN,					-- 8 	4
            JOIN_REC.SRC_DOCUMENT_NUMBER,		-- 8 	5
            JOIN_REC.SRC_DCN,					-- 8 	6
            JOIN_REC.SRC_ORDERNUMBER,			-- 8 	7
            JOIN_REC.SRC_FORM_TYPE,				-- 8 	8
            JOIN_REC.SRC_DOC_CLASS,				-- 8 	9
            JOIN_REC.SRC_DOC_RECEIPT_DT,		-- 8 	10
            JOIN_REC.SRC_DOC_CREATION_DT,		-- 8 	11
            JOIN_REC.SRC_DOC_PAGE_COUNT,		-- 8 	12
            JOIN_REC.SRC_CLASSIFIED_DOC,		-- 8 	13
            JOIN_REC.SRC_DELETED,				-- 8 	14
            JOIN_REC.SRC_CONFIDENCE,			-- 8 	15
            JOIN_REC.SRC_CONFIDENT,				-- 8 	16
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
		GV_DRIVER_KEY_NUMBER  	:= 'SRC DCN : '||JOIN_REC.SRC_DCN;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_DOCUMENT_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_DOCUMENT';

		POST_ERROR;

	END INSERT_DOCUMENT;	

-----------------------------------------------------
PROCEDURE DELETE_DOCUMENT IS
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
            ||JOIN_REC.SRC_DCN||' '
            ||JOIN_REC.target_DCN);

		Post_Error;

	END DELETE_DOCUMENT;	


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

END NYHIX_MFB_V2_DOCUMENT_PKG;

/


-- DROP PACKAGE BODY MAXDAT.NYHIX_MFB_V2_ENVELOPE_PKG;

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

/


-- DROP PACKAGE BODY MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_PKG;

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
		SRC.BATCH_CLASS_NAME                     AS SRC_BATCH_CLASS_NAME               	-- 1 	30
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
		TARGET.BATCH_CLASS_NAME                  AS TARGET_BATCH_CLASS_NAME            	-- 2 	30
	  FROM MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH TARGET
	)
	SELECT 
	--	SRC_ROWID,
		TARGET_ROWID,
		-- insert SQL from 3 and 4 here
	--	SRC_MFB_V2_CREATE_DATE,                                               	-- 3 	1
	--	SRC_MFB_V2_UPDATE_DATE,                                               	-- 3 	2
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
                              TARGET_BATCH_CLASS_NAME                	-- 4 	30
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
			THEN
		UPDATE MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH
		SET  
		-- THE UPDATE
        --    MFB_V2_CREATE_DATE                        =  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 6 	1
        --    MFB_V2_UPDATE_DATE                        =  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 6 	2
            STATS_BATCH_ID                            =  JOIN_REC.SRC_STATS_BATCH_ID,	-- 6 	1
            BATCH_ID                                  =  JOIN_REC.SRC_BATCH_ID,	-- 6 	2
            BATCH_U_UID                               =  JOIN_REC.SRC_BATCH_U_UID,	-- 6 	3
            NODE_ID                                   =  JOIN_REC.SRC_NODE_ID,	-- 6 	4
            NODE_U_UID                                =  JOIN_REC.SRC_NODE_U_UID,	-- 6 	5
            FLD_COUNT                                 =  JOIN_REC.SRC_FLD_COUNT,	-- 6 	6
            DOC_COUNT                                 =  JOIN_REC.SRC_DOC_COUNT,	-- 6 	7
            PAGE_COUNT                                =  JOIN_REC.SRC_PAGE_COUNT,	-- 6 	8
            JOB_ID                                    =  JOIN_REC.SRC_JOB_ID,	-- 6 	9
            PRIVAT                                    =  JOIN_REC.SRC_PRIVAT,	-- 6 	10
            START_DATE                                =  JOIN_REC.SRC_START_DATE,	-- 6 	11
            END_DATE                                  =  JOIN_REC.SRC_END_DATE,	-- 6 	12
            INDEXED_BATCH_COUNT                       =  JOIN_REC.SRC_INDEXED_BATCH_COUNT,	-- 6 	13
            INDEXED_DOC_COUNT                         =  JOIN_REC.SRC_INDEXED_DOC_COUNT,	-- 6 	14
            INDEXED_FLD_COUNT                         =  JOIN_REC.SRC_INDEXED_FLD_COUNT,	-- 6 	15
            USER_ID                                   =  JOIN_REC.SRC_USER_ID,	-- 6 	16
            DELETED                                   =  JOIN_REC.SRC_DELETED,	-- 6 	17
            SESSION_ID                                =  JOIN_REC.SRC_SESSION_ID,	-- 6 	18
            QUEUE                                     =  JOIN_REC.SRC_QUEUE,	-- 6 	19
            QUEUE_MODE                                =  JOIN_REC.SRC_QUEUE_MODE,	-- 6 	20
            VERSION                                   =  JOIN_REC.SRC_VERSION,	-- 6 	21
            ORIG_BATCH_ID                             =  JOIN_REC.SRC_ORIG_BATCH_ID,	-- 6 	22
            LAST_SCANNER_NAME                         =  JOIN_REC.SRC_LAST_SCANNER_NAME,	-- 6 	23
            REASON                                    =  JOIN_REC.SRC_REASON,	-- 6 	24
            COPIED_FROM_BATCH_ID                      =  JOIN_REC.SRC_COPIED_FROM_BATCH_ID,	-- 6 	25
            BATCH_NAME                                =  JOIN_REC.SRC_BATCH_NAME,	-- 6 	26
            BATCH_PRIORITY                            =  JOIN_REC.SRC_BATCH_PRIORITY,	-- 6 	27
            STATS_BATCH_SESSION_ID                    =  JOIN_REC.SRC_STATS_BATCH_SESSION_ID,	-- 6 	28
            BATCH_RELEASE_RUN_ID                      =  JOIN_REC.SRC_BATCH_RELEASE_RUN_ID,	-- 6 	29
            BATCH_CLASS_NAME                          =  JOIN_REC.SRC_BATCH_CLASS_NAME	-- 6 	30
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
            BATCH_CLASS_NAME                       	-- 7 	30
			)
		VALUES (
          --  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	1
          --  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	2
            JOIN_REC.SRC_STATS_BATCH_ID,	-- 8 	1
            JOIN_REC.SRC_BATCH_ID,	-- 8 	2
            JOIN_REC.SRC_BATCH_U_UID,	-- 8 	3
            JOIN_REC.SRC_NODE_ID,	-- 8 	4
            JOIN_REC.SRC_NODE_U_UID,	-- 8 	5
            JOIN_REC.SRC_FLD_COUNT,	-- 8 	6
            JOIN_REC.SRC_DOC_COUNT,	-- 8 	7
            JOIN_REC.SRC_PAGE_COUNT,	-- 8 	8
            JOIN_REC.SRC_JOB_ID,	-- 8 	9
            JOIN_REC.SRC_PRIVAT,	-- 8 	10
            JOIN_REC.SRC_START_DATE,	-- 8 	11
            JOIN_REC.SRC_END_DATE,	-- 8 	12
            JOIN_REC.SRC_INDEXED_BATCH_COUNT,	-- 8 	13
            JOIN_REC.SRC_INDEXED_DOC_COUNT,	-- 8 	14
            JOIN_REC.SRC_INDEXED_FLD_COUNT,	-- 8 	15
            JOIN_REC.SRC_USER_ID,	-- 8 	16
            JOIN_REC.SRC_DELETED,	-- 8 	17
            JOIN_REC.SRC_SESSION_ID,	-- 8 	18
            JOIN_REC.SRC_QUEUE,	-- 8 	19
            JOIN_REC.SRC_QUEUE_MODE,	-- 8 	20
            JOIN_REC.SRC_VERSION,	-- 8 	21
            JOIN_REC.SRC_ORIG_BATCH_ID,	-- 8 	22
            JOIN_REC.SRC_LAST_SCANNER_NAME,	-- 8 	23
            JOIN_REC.SRC_REASON,	-- 8 	24
            JOIN_REC.SRC_COPIED_FROM_BATCH_ID,	-- 8 	25
            JOIN_REC.SRC_BATCH_NAME,	-- 8 	26
            JOIN_REC.SRC_BATCH_PRIORITY,	-- 8 	27
            JOIN_REC.SRC_STATS_BATCH_SESSION_ID,	-- 8 	28
            JOIN_REC.SRC_BATCH_RELEASE_RUN_ID,	-- 8 	29
            JOIN_REC.SRC_BATCH_CLASS_NAME	-- 8 	30
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


-- DROP PACKAGE BODY MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING_PKG;

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


-- DROP PACKAGE BODY MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG;

CREATE OR REPLACE PACKAGE BODY MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG AS

	-- USED FOR THE CORP_ETL_ERROR_LOG
	GV_PARENT_JOB_ID          	NUMBER				:= 0;
	GV_ERROR_CODE				VARCHAR2(50)		:= NULL;
	GV_ERROR_MESSAGE			VARCHAR2(4000)		:= NULL;
	GV_ERROR_FIELD				VARCHAR2(400)		:= NULL;
	GV_ERROR_CODES				VARCHAR2(400)		:= NULL;
	GV_ERR_DATE					DATE				:= SYSDATE;
	GV_ERR_LEVEL				VARCHAR2(20)		:= 'CRITICAL';
	GV_PROCESS_NAME				VARCHAR2(120)		:= 'NYHIX_MFB_V2';
	GV_JOB_NAME					VARCHAR2(120)		:= ''; --'Mail Fax Batch V2'
	GV_DRIVER_TABLE_NAME  		VARCHAR2(100 BYTE)	:= 'NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH';
	GV_DRIVER_KEY_NUMBER  		VARCHAR2(100 BYTE)	:= NULL;
	GV_NR_OF_ERROR        		NUMBER				:= 0;
    GV_UPDATE_TS                DATE                := SYSDATE;

	-- USED FOR THE CORP_ETL_JOB_STATISTICS
	GV_JOB_ID                 	NUMBER              := 0;
	GV_JOB_STATUS_CD          	VARCHAR2(20 BYTE)   := 'STARTED';
	GV_FILE_NAME              	VARCHAR2(512 BYTE)	:= 'NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH';
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
		ROWID    							 	AS SRC_ROWID,

		-- SQL FROM QUERY 1
		SRC.OLTP_LOAD_SEQ						AS SRC_OLTP_LOAD_SEQ,
		SRC.OLTP_LOAD_DATE_TIME					AS SRC_OLTP_LOAD_DATE_TIME,
        SRC.SOURCE_SERVER                       AS SRC_SOURCE_SERVER,	-- 1 	1
         --            SRC.BATCH_GUID                           AS SRC_BATCH_GUID,	-- 1 	2
         --    SRC.MFB_V2_CREATE_DATE                   AS SRC_MFB_V2_CREATE_DATE,	-- 1 	3
         --    SRC.MFB_V2_UPDATE_DATE                   AS SRC_MFB_V2_UPDATE_DATE,	-- 1 	4
        SRC.MODULE_LAUNCH_ID                    AS SRC_MODULE_LAUNCH_ID,	-- 1 	5
        SRC.START_DATE_TIME                     AS SRC_START_DATE_TIME,	-- 1 	6
        SRC.END_DATE_TIME                       AS SRC_END_DATE_TIME,	-- 1 	7
        SRC.MODULE_UNIQUE_ID                    AS SRC_MODULE_UNIQUE_ID,	-- 1 	8
        SRC.MODULE_NAME                         AS SRC_MODULE_NAME,	-- 1 	9
        SRC.USER_ID                             AS SRC_USER_ID,	-- 1 	10
        SRC.USER_NAME                           AS SRC_USER_NAME,	-- 1 	11
        SRC.STATION_ID                          AS SRC_STATION_ID,	-- 1 	12
        SRC.SITE_NAME                           AS SRC_SITE_NAME,	-- 1 	13
        SRC.SITE_ID                             AS SRC_SITE_ID,	-- 1 	14
        SRC.IN_PROCESS_TID                      AS SRC_IN_PROCESS_TID,	-- 1 	15
        SRC.ORPHANED                            AS SRC_ORPHANED,	-- 1 	16
        SRC.COMPLETED_TID                       AS SRC_COMPLETED_TID		-- 1 	17
	FROM MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_OLTP SRC
	),
	TARGET AS
	(
	SELECT 
		ROWID    						  AS TARGET_ROWID,
		-- SQL FROM QUERY 2
        TARGET.SOURCE_SERVER                     AS TARGET_SOURCE_SERVER,	-- 2 	1
     --             TARGET.BATCH_GUID                        AS TARGET_BATCH_GUID,	-- 2 	2
    --      TARGET.MFB_V2_CREATE_DATE                AS TARGET_MFB_V2_CREATE_DATE,	-- 2 	3
   --       TARGET.MFB_V2_UPDATE_DATE                AS TARGET_MFB_V2_UPDATE_DATE,	-- 2 	4
        TARGET.MODULE_LAUNCH_ID                  AS TARGET_MODULE_LAUNCH_ID,	-- 2 	5
        TARGET.START_DATE_TIME                   AS TARGET_START_DATE_TIME,	-- 2 	6
        TARGET.END_DATE_TIME                     AS TARGET_END_DATE_TIME,	-- 2 	7
        TARGET.MODULE_UNIQUE_ID                  AS TARGET_MODULE_UNIQUE_ID,	-- 2 	8
        TARGET.MODULE_NAME                       AS TARGET_MODULE_NAME,	-- 2 	9
        TARGET.USER_ID                           AS TARGET_USER_ID,	-- 2 	10
        TARGET.USER_NAME                         AS TARGET_USER_NAME,	-- 2 	11
        TARGET.STATION_ID                        AS TARGET_STATION_ID,	-- 2 	12
        TARGET.SITE_NAME                         AS TARGET_SITE_NAME,	-- 2 	13
        TARGET.SITE_ID                           AS TARGET_SITE_ID,	-- 2 	14
        TARGET.IN_PROCESS_TID                    AS TARGET_IN_PROCESS_TID,	-- 2 	15
        TARGET.ORPHANED                          AS TARGET_ORPHANED,	-- 2 	16
        TARGET.COMPLETED_TID                     AS TARGET_COMPLETED_TID		-- 2 	17
	FROM MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH TARGET
	)
	SELECT 
		SRC_ROWID,
		TARGET_ROWID,
		-- insert SQL from 3 and 4 here
		SRC_OLTP_LOAD_SEQ,
		SRC_OLTP_LOAD_DATE_TIME,
                              SRC_SOURCE_SERVER,                      	-- 3 	1
                    --          SRC_BATCH_GUID,                         	-- 3 	2
                    --        SRC_MFB_V2_CREATE_DATE,                 	-- 3 	3
                    --          SRC_MFB_V2_UPDATE_DATE,                 	-- 3 	4
                              SRC_MODULE_LAUNCH_ID,                   	-- 3 	5
                              SRC_START_DATE_TIME,                    	-- 3 	6
                              SRC_END_DATE_TIME,                      	-- 3 	7
                              SRC_MODULE_UNIQUE_ID,                   	-- 3 	8
                              SRC_MODULE_NAME,                        	-- 3 	9
                              SRC_USER_ID,                            	-- 3 	10
                              SRC_USER_NAME,                          	-- 3 	11
                              SRC_STATION_ID,                         	-- 3 	12
                              SRC_SITE_NAME,                          	-- 3 	13
                              SRC_SITE_ID,                            	-- 3 	14
                              SRC_IN_PROCESS_TID,                     	-- 3 	15
                              SRC_ORPHANED,                           	-- 3 	16
                              SRC_COMPLETED_TID,                      	-- 3 	17
                              TARGET_SOURCE_SERVER,                   	-- 4 	1
                          --    TARGET_BATCH_GUID,                      	-- 4 	2
                          --    TARGET_MFB_V2_CREATE_DATE,              	-- 4 	3
                         --     TARGET_MFB_V2_UPDATE_DATE,              	-- 4 	4
                              TARGET_MODULE_LAUNCH_ID,                	-- 4 	5
                              TARGET_START_DATE_TIME,                 	-- 4 	6
                              TARGET_END_DATE_TIME,                   	-- 4 	7
                              TARGET_MODULE_UNIQUE_ID,                	-- 4 	8
                              TARGET_MODULE_NAME,                     	-- 4 	9
                              TARGET_USER_ID,                         	-- 4 	10
                              TARGET_USER_NAME,                       	-- 4 	11
                              TARGET_STATION_ID,                      	-- 4 	12
                              TARGET_SITE_NAME,                       	-- 4 	13
                              TARGET_SITE_ID,                         	-- 4 	14
                              TARGET_IN_PROCESS_TID,                  	-- 4 	15
                              TARGET_ORPHANED,                        	-- 4 	16
                              TARGET_COMPLETED_TID                   	-- 4 	17
	FROM SRC
	LEFT OUTER JOIN TARGET
	ON SRC_Module_Launch_ID = TARGET_Module_Launch_ID
--	and SRC_BATCH_GUID = TARGET_BATCH_GUID
--	and SRC_Batch_Module_ID = TARGET_Batch_Module_ID
--	AND NOT (SRC_SOURCE_SERVER = 'REMOTE'
--	AND TARGET_SOURCE_SERVER = 'CENTRAL' )
	ORDER BY 
--	SRC_BATCH_GUID, SRC_Batch_Module_ID, 
	SRC_START_DATE_TIME;

	JOIN_REC   JOIN_CSR%ROWTYPE;

-----------------------------------------------------
PROCEDURE LOAD_STATS_BATCH_MODULE_LAUNCH (P_JOB_ID number default 0) 
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

			IF JOIN_REC.SRC_ROWID IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN Update_STATS_BATCH_MODULE_LAUNCH;
			ELSIF JOIN_REC.SRC_ROWID IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NULL 
                --then null;
				THEN INSERT_STATS_BATCH_MODULE_LAUNCH;
			ELSIF JOIN_REC.SRC_ROWID IS NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN DELETE_STATS_BATCH_MODULE_LAUNCH;
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
				'SRC_DB_RECORD_NUM: '||JOIN_REC.SRC_MODULE_LAUNCH_ID
				||' TARGET_DB_RECORD_NUM: '||JOIN_REC.TARGET_MODULE_LAUNCH_ID
				||'SQLCODE '||GV_ERROR_CODE
				||' '||GV_ERROR_MESSAGE);

			ROLLBACK;

			RAISE;

END Load_STATS_BATCH_MODULE_LAUNCH;

-----------------------------------------------------

-----------------------------------------------------
PROCEDURE UPDATE_STATS_BATCH_MODULE_LAUNCH IS
PRAGMA AUTONOMOUS_TRANSACTION;
-- USES SQL FROM 5 AND 6
-----------------------------------------------------

	BEGIN

	-- COMPARE  -- SQL FROM QUERY 5
		IF 1=2
            OR NVL(JOIN_REC.TARGET_MODULE_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_NAME,'-?93333')	-- 5 	9	VARCHAR2
            OR NVL(JOIN_REC.TARGET_USER_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_USER_ID,'-?93333')	-- 5 	10	VARCHAR2
            OR NVL(JOIN_REC.TARGET_USER_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_USER_NAME,'-?93333')	-- 5 	11	VARCHAR2
            OR NVL(JOIN_REC.TARGET_STATION_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_STATION_ID,'-?93333')	-- 5 	12	VARCHAR2
            OR NVL(JOIN_REC.TARGET_SITE_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_SITE_NAME,'-?93333')	-- 5 	13	VARCHAR2
            OR NVL(JOIN_REC.TARGET_SITE_ID, -93333)	  <>  	NVL(JOIN_REC.SRC_SITE_ID, -93333)	-- 5 	14	NUMBER
            OR NVL(JOIN_REC.TARGET_IN_PROCESS_TID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_IN_PROCESS_TID,'-?93333')	-- 5 	15	VARCHAR2
            OR NVL(JOIN_REC.TARGET_ORPHANED, -93333)	  <>  	NVL(JOIN_REC.SRC_ORPHANED, -93333)	-- 5 	16	NUMBER
            OR NVL(JOIN_REC.TARGET_COMPLETED_TID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_COMPLETED_TID,'-?93333')	-- 5 	17	VARCHAR2
            OR NVL(JOIN_REC.TARGET_SOURCE_SERVER,'-?93333')	  <>  	NVL(JOIN_REC.SRC_SOURCE_SERVER,'-?93333')	-- 5 	1	VARCHAR2
         --   OR NVL(JOIN_REC.TARGET_BATCH_GUID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_GUID,'-?93333')	-- 5 	2	VARCHAR2
         --   OR NVL(JOIN_REC.TARGET_MFB_V2_CREATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_CREATE_DATE,SYSDATE - 93333)	-- 5 	3	DATE
         --   OR NVL(JOIN_REC.TARGET_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	-- 5 	4	DATE
            OR NVL(JOIN_REC.TARGET_MODULE_LAUNCH_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_LAUNCH_ID,'-?93333')	-- 5 	5	VARCHAR2
            ---
			OR to_char(JOIN_REC.TARGET_START_DATE_TIME,'yyyymmdd hh24:mi:ss') <> to_char(to_timestamp(join_rec.src_start_date_time,'dd-mon-yy hh.mi.ss.ff am'),'yyyymmdd hh24:mi:ss')	-- 5 	6	DATE
            ---
			OR to_char(JOIN_REC.TARGET_END_DATE_TIME,'yyyymmdd hh24:mi:ss')  <> to_char(to_timestamp(join_rec.src_end_date_time,'dd-mon-yy hh.mi.ss.ff am'),'yyyymmdd hh24:mi:ss')	-- 5 	7	DATE
            ---
			OR NVL(JOIN_REC.TARGET_MODULE_UNIQUE_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULE_UNIQUE_ID,'-?93333')	-- 5 	8	VARCHAR2
	THEN
		UPDATE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH
		SET  
		-- THE UPDATE  SQL FROM QUERY 6
            SOURCE_SERVER                             =  JOIN_REC.SRC_SOURCE_SERVER,	-- 6 	1
         --   BATCH_GUID                                =  JOIN_REC.SRC_BATCH_GUID,	-- 6 	2
        --    MFB_V2_CREATE_DATE                        =  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 6 	3
        --    MFB_V2_UPDATE_DATE                        =  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 6 	4
            MODULE_LAUNCH_ID                          =  JOIN_REC.SRC_MODULE_LAUNCH_ID,	-- 6 	5
            START_DATE_TIME                           =  to_timestamp(JOIN_REC.SRC_START_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 6 	6
            END_DATE_TIME                             =  to_timestamp(JOIN_REC.SRC_END_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 6 	7
            MODULE_UNIQUE_ID                          =  JOIN_REC.SRC_MODULE_UNIQUE_ID,	-- 6 	8
            MODULE_NAME                               =  JOIN_REC.SRC_MODULE_NAME,	-- 6 	9
            USER_ID                                   =  JOIN_REC.SRC_USER_ID,	-- 6 	10
            USER_NAME                                 =  JOIN_REC.SRC_USER_NAME,	-- 6 	11
            STATION_ID                                =  JOIN_REC.SRC_STATION_ID,	-- 6 	12
            SITE_NAME                                 =  JOIN_REC.SRC_SITE_NAME,	-- 6 	13
            SITE_ID                                   =  JOIN_REC.SRC_SITE_ID,	-- 6 	14
            IN_PROCESS_TID                            =  JOIN_REC.SRC_IN_PROCESS_TID,	-- 6 	15
            ORPHANED                                  =  JOIN_REC.SRC_ORPHANED,	-- 6 	16
            COMPLETED_TID                             =  JOIN_REC.SRC_COMPLETED_TID,		-- 6 	17
			MFB_V2_PARENT_JOB_ID					  =  GV_PARENT_JOB_ID	
		WHERE ROWID = JOIN_REC.TARGET_ROWID;


		DBMS_OUTPUT.PUT_LINE('UPDATE MADE TO TARGET ROW_ID '||JOIN_REC.TARGET_ROWID);

		COMMIT;

		GV_RECORD_UPDATED_COUNT := GV_RECORD_UPDATED_COUNT + 1;
		GV_PROCESSED_COUNT := GV_PROCESSED_COUNT + 1;

	ELSE
		NULL; -- NO UPDATE REQUIRED
	END IF;	

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('UPDATE FAILURE '
            ||JOIN_REC.SRC_MODULE_LAUNCH_ID||' '
            ||JOIN_REC.SRC_rowid||' '
            ||JOIN_REC.target_rowid);

		GV_DRIVER_KEY_NUMBER  	:= 'SRC_OLTP_LOAD_SEQ : '||JOIN_REC.SRC_OLTP_LOAD_SEQ;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_STATS_BATCH_MODULE_LAUNCH_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
--		GV_PROCESS_NAME 		:= 'Update_STATS_BATCH_MODULE_LAUNCH';

		POST_ERROR;

	END UPDATE_STATS_BATCH_MODULE_LAUNCH;	

-----------------------------------------------------
PROCEDURE INSERT_STATS_BATCH_MODULE_LAUNCH IS
-- USES SQL  FROM 7 AND 8
-----------------------------------------------------

	BEGIN

		INSERT INTO MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH
		(   -- INSERT PART 1 SQL FROM QUERY 7
            SOURCE_SERVER,                          	-- 7 	1
         --   BATCH_GUID,                             	-- 7 	2
        --    MFB_V2_CREATE_DATE,                     	-- 7 	3
        --    MFB_V2_UPDATE_DATE,                     	-- 7 	4
            MODULE_LAUNCH_ID,                       	-- 7 	5
            START_DATE_TIME,                        	-- 7 	6
            END_DATE_TIME,                          	-- 7 	7
            MODULE_UNIQUE_ID,                       	-- 7 	8
            MODULE_NAME,                            	-- 7 	9
            USER_ID,                                	-- 7 	10
            USER_NAME,                              	-- 7 	11
            STATION_ID,                             	-- 7 	12
            SITE_NAME,                              	-- 7 	13
            SITE_ID,                                	-- 7 	14
            IN_PROCESS_TID,                         	-- 7 	15
            ORPHANED,                               	-- 7 	16
            COMPLETED_TID,                          	-- 7 	17
			MFB_V2_PARENT_JOB_ID
		)
		VALUES ( -- INSERT PART 2 SQL FROM QUERY 8
            JOIN_REC.SRC_SOURCE_SERVER,		-- 8 	1
         --   JOIN_REC.SRC_BATCH_GUID,		-- 8 	2
         --   JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	3
         --   JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	4
            JOIN_REC.SRC_MODULE_LAUNCH_ID,	-- 8 	5
            to_timestamp(JOIN_REC.SRC_START_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 8 	6
            to_timestamp(JOIN_REC.SRC_END_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 8 	7
            JOIN_REC.SRC_MODULE_UNIQUE_ID,	-- 8 	8
            JOIN_REC.SRC_MODULE_NAME,		-- 8 	9
            JOIN_REC.SRC_USER_ID,			-- 8 	10
            JOIN_REC.SRC_USER_NAME,			-- 8 	11
            JOIN_REC.SRC_STATION_ID,		-- 8 	12
            JOIN_REC.SRC_SITE_NAME,			-- 8 	13
            JOIN_REC.SRC_SITE_ID,			-- 8 	14
            JOIN_REC.SRC_IN_PROCESS_TID,	-- 8 	15
            JOIN_REC.SRC_ORPHANED,			-- 8 	16
            JOIN_REC.SRC_COMPLETED_TID,		-- 8 	17
			GV_PARENT_JOB_ID	
			);

		GV_RECORD_INSERTED_COUNT := GV_RECORD_INSERTED_COUNT + 1;

		GV_PROCESSED_COUNT := GV_PROCESSED_COUNT + 1;

	EXCEPTION

        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('INSERT FAILURE '
 --           ||JOIN_REC.SRC_DB_RECORD_NUM||' '
            ||JOIN_REC.SRC_rowid||' '
            ||JOIN_REC.target_rowid);

        -- '${MFB_V2_REMOTE_START_DATE}'
		GV_DRIVER_KEY_NUMBER  	:= 'SRC_OLTP_LOAD_SEQ : '||JOIN_REC.SRC_OLTP_LOAD_SEQ;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_STATS_BATCH_MODULE_LAUNCH_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
--		GV_PROCESS_NAME 		:= 'Update_STATS_BATCH_MODULE_LAUNCH';

		POST_ERROR;

	END INSERT_STATS_BATCH_MODULE_LAUNCH;	

-----------------------------------------------------
PROCEDURE DELETE_STATS_BATCH_MODULE_LAUNCH IS
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

	END DELETE_STATS_BATCH_MODULE_LAUNCH;	


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

			INSERT INTO MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_OLTP_ERR
		(   -- INSERT PART 1 SQL FROM QUERY 7
		    OLTP_LOAD_SEQ,
			OLTP_LOAD_DATE_TIME,
            SOURCE_SERVER,                          	-- 7 	1
         --   BATCH_GUID,                             	-- 7 	2
        --    MFB_V2_CREATE_DATE,                     	-- 7 	3
        --    MFB_V2_UPDATE_DATE,                     	-- 7 	4
            MODULE_LAUNCH_ID,                       	-- 7 	5
            START_DATE_TIME,                        	-- 7 	6
            END_DATE_TIME,                          	-- 7 	7
            MODULE_UNIQUE_ID,                       	-- 7 	8
            MODULE_NAME,                            	-- 7 	9
            USER_ID,                                	-- 7 	10
            USER_NAME,                              	-- 7 	11
            STATION_ID,                             	-- 7 	12
            SITE_NAME,                              	-- 7 	13
            SITE_ID,                                	-- 7 	14
            IN_PROCESS_TID,                         	-- 7 	15
            ORPHANED,                               	-- 7 	16
            COMPLETED_TID                          	-- 7 	17
		)
		VALUES ( -- INSERT PART 2 SQL FROM QUERY 8
			JOIN_REC.SRC_OLTP_LOAD_SEQ,
			JOIN_REC.SRC_OLTP_LOAD_DATE_TIME,
            JOIN_REC.SRC_SOURCE_SERVER,	-- 8 	1
         --   JOIN_REC.SRC_BATCH_GUID,	-- 8 	2
         --   JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	3
         --   JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	4
            JOIN_REC.SRC_MODULE_LAUNCH_ID,	-- 8 	5
            JOIN_REC.SRC_START_DATE_TIME,	-- 8 	6
            JOIN_REC.SRC_END_DATE_TIME,	-- 8 	7
            JOIN_REC.SRC_MODULE_UNIQUE_ID,	-- 8 	8
            JOIN_REC.SRC_MODULE_NAME,	-- 8 	9
            JOIN_REC.SRC_USER_ID,	-- 8 	10
            JOIN_REC.SRC_USER_NAME,	-- 8 	11
            JOIN_REC.SRC_STATION_ID,	-- 8 	12
            JOIN_REC.SRC_SITE_NAME,	-- 8 	13
            JOIN_REC.SRC_SITE_ID,	-- 8 	14
            JOIN_REC.SRC_IN_PROCESS_TID,	-- 8 	15
            JOIN_REC.SRC_ORPHANED,	-- 8 	16
            JOIN_REC.SRC_COMPLETED_TID	-- 8 	17
			);

	COMMIT;


EXCEPTION

	When Others then 
		GV_ERROR_CODE := SQLCODE;
		GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 3000);                 
	DBMS_OUTPUT.PUT_LINE('Procedure Post_Error failed with '||GV_Error_Code||': '||GV_Error_Message);

	--RAISE;


END;

END NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG;

/


-- DROP PACKAGE BODY MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_PKG;

CREATE OR REPLACE PACKAGE BODY MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_PKG AS

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
			OR NVL(to_char(JOIN_REC.TARGET_START_DATE_TIME,'yyyymmdd hh24:mi:ss'),'X') <> NVL(to_char(to_timestamp(join_rec.src_start_date_time,'dd-mon-yy hh.mi.ss.ff am'),'yyyymmdd hh24:mi:ss'),'X')	-- 5 	6	DATE
            ---
			OR NVL(to_char(JOIN_REC.TARGET_END_DATE_TIME,'yyyymmdd hh24:mi:ss'),'X')  <> NVL(to_char(to_timestamp(join_rec.src_end_date_time,'dd-mon-yy hh.mi.ss.ff am'),'yyyymmdd hh24:mi:ss'),'X')	-- 5 	7	DATE
            ---

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
            START_DATE_TIME                           =  TO_TIMESTAMP(JOIN_REC.SRC_START_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 6 	12
            END_DATE_TIME                             =  TO_TIMESTAMP(JOIN_REC.SRC_END_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 6 	13
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
            TRANSFER_ID                               =  JOIN_REC.SRC_TRANSFER_ID,	-- 6 	29
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
            TRANSFER_ID,                            	-- 7 	29
			MFB_V2_PARENT_JOB_ID
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
            TO_TIMESTAMP(JOIN_REC.SRC_START_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 8 	12
            TO_TIMESTAMP(JOIN_REC.SRC_END_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 8 	13
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
            JOIN_REC.SRC_TRANSFER_ID,	-- 8 	29
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


-- DROP PACKAGE BODY MAXDAT.NYHIX_MFB_V2_STATS_BATCH_PKG;

CREATE OR REPLACE PACKAGE BODY MAXDAT.NYHIX_MFB_V2_STATS_BATCH_PKG AS

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
            SBM_MAX_END_DATE_TIME                     =  TO_TIMESTAMP(JOIN_REC.SRC_SBM_MAX_END_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 6 	4
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
			SBM_MAX_END_DATE_TIME,
			MFB_V2_PARENT_JOB_ID
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
            TO_TIMESTAMP(JOIN_REC.SRC_SBM_MAX_END_DATE_TIME,'dd-mon-yy hh.mi.ss.ff am'),	-- 8 	4
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


-- DROP PACKAGE BODY MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE_PKG;

CREATE OR REPLACE PACKAGE BODY MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE_PKG AS

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
	GV_DRIVER_TABLE_NAME  		VARCHAR2(100 BYTE)	:= 'NYHIX_MFB_V2_STATS_FORM_TYPE';
	GV_DRIVER_KEY_NUMBER  		VARCHAR2(100 BYTE)	:= NULL;
	GV_NR_OF_ERROR        		NUMBER				:= 0;
    GV_UPDATE_TS                DATE                := SYSDATE;

	-- USED FOR THE CORP_ETL_JOB_STATISTICS
	GV_JOB_ID                 	NUMBER              := 0;
	GV_JOB_STATUS_CD          	VARCHAR2(20 BYTE)   := 'STARTED';
	GV_FILE_NAME              	VARCHAR2(512 BYTE)	:= 'NYHIX_MFB_V2_STATS_FORM_TYPE';
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
		ROWID    							 	AS SRC_ROWID,
		SRC.OLTP_LOAD_SEQ						AS SRC_OLTP_LOAD_SEQ,
		SRC.OLTP_LOAD_DATE_TIME					AS SRC_OLTP_LOAD_DATE_TIME,
		-- SQL FROM QUERY 1
		SRC.SOURCE_SERVER                        AS SRC_SOURCE_SERVER,	-- 1 	1
        SRC.BATCH_GUID                           AS SRC_BATCH_GUID,	-- 1 	2
        SRC.FORM_TYPE_ENTRY_ID                    AS SRC_FORM_TYPE_ENTRY_ID,	-- 1 	5
        SRC.BATCH_MODULE_ID                      AS SRC_BATCH_MODULE_ID,	-- 1 	6
        SRC.FORM_TYPE_NAME                       AS SRC_FORM_TYPE_NAME,	-- 1 	7
        SRC.DOC_CLASS_NAME                       AS SRC_DOC_CLASS_NAME,	-- 1 	8
        SRC.DOCUMENTS                            AS SRC_DOCUMENTS,	-- 1 	9
        SRC.REJECTED_DOCS                        AS SRC_REJECTED_DOCS,	-- 1 	10
        SRC.PAGES                                AS SRC_PAGES,	-- 1 	11
        SRC.REJECTED_PAGES                       AS SRC_REJECTED_PAGES,	-- 1 	12
        SRC.KS_MANUAL                            AS SRC_KS_MANUAL,	-- 1 	13
        SRC.KS_OCR_REPAIR                        AS SRC_KS_OCR_REPAIR,	-- 1 	14
        SRC.KS_ICR_REPAIR                        AS SRC_KS_ICR_REPAIR,	-- 1 	15
        SRC.KS_BCR_REPAIR                         AS SRC_KS_BCR_REPAIR,	-- 1 	16
        SRC.KS_OMR_REPAIR                        AS SRC_KS_OMR_REPAIR,	-- 1 	17
        SRC.COMPLETED_DOCS                       AS SRC_COMPLETED_DOCS,	-- 1 	18
        SRC.COMPLETED_PAGES                      AS SRC_COMPLETED_PAGES,	-- 1 	19
        SRC.TRANSFER_ID                          AS SRC_TRANSFER_ID		-- 1 	20
	FROM MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE_OLTP SRC
	),
	TARGET AS
	(
	SELECT 
		ROWID    						  AS TARGET_ROWID,
		-- SQL FROM QUERY 2
               TARGET.SOURCE_SERVER                     AS TARGET_SOURCE_SERVER,	-- 2 	1
                  TARGET.BATCH_GUID                        AS TARGET_BATCH_GUID,	-- 2 	2
    --      TARGET.MFB_V2_CREATE_DATE                AS TARGET_MFB_V2_CREATE_DATE,	-- 2 	3
    --      TARGET.MFB_V2_UPDATE_DATE                AS TARGET_MFB_V2_UPDATE_DATE,	-- 2 	4
           TARGET.FORM_TYPE_ENTRY_ID                 AS TARGET_FORM_TYPE_ENTRY_ID,	-- 2 	5
             TARGET.BATCH_MODULE_ID                   AS TARGET_BATCH_MODULE_ID,	-- 2 	6
              TARGET.FORM_TYPE_NAME                    AS TARGET_FORM_TYPE_NAME,	-- 2 	7
              TARGET.DOC_CLASS_NAME                    AS TARGET_DOC_CLASS_NAME,	-- 2 	8
                   TARGET.DOCUMENTS                         AS TARGET_DOCUMENTS,	-- 2 	9
               TARGET.REJECTED_DOCS                     AS TARGET_REJECTED_DOCS,	-- 2 	10
                       TARGET.PAGES                             AS TARGET_PAGES,	-- 2 	11
              TARGET.REJECTED_PAGES                    AS TARGET_REJECTED_PAGES,	-- 2 	12
                   TARGET.KS_MANUAL                         AS TARGET_KS_MANUAL,	-- 2 	13
               TARGET.KS_OCR_REPAIR                     AS TARGET_KS_OCR_REPAIR,	-- 2 	14
               TARGET.KS_ICR_REPAIR                     AS TARGET_KS_ICR_REPAIR,	-- 2 	15
                TARGET.KS_BCR_REPAIR                      AS TARGET_KS_BCR_REPAIR,	-- 2 	16
               TARGET.KS_OMR_REPAIR                     AS TARGET_KS_OMR_REPAIR,	-- 2 	17
              TARGET.COMPLETED_DOCS                    AS TARGET_COMPLETED_DOCS,	-- 2 	18
             TARGET.COMPLETED_PAGES                   AS TARGET_COMPLETED_PAGES,	-- 2 	19
                 TARGET.TRANSFER_ID                       AS TARGET_TRANSFER_ID		-- 2 	20
	FROM MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE TARGET
	)
	SELECT 
		SRC_ROWID,
		TARGET_ROWID,
		SRC_OLTP_LOAD_SEQ,
		SRC_OLTP_LOAD_DATE_TIME,
		-- insert SQL from 3 and 4 here
        SRC_SOURCE_SERVER,                      	-- 3 	1
        SRC_BATCH_GUID,                         	-- 3 	2
        SRC_FORM_TYPE_ENTRY_ID,                  	-- 3 	5
        SRC_BATCH_MODULE_ID,                    	-- 3 	6
        SRC_FORM_TYPE_NAME,                     	-- 3 	7
        SRC_DOC_CLASS_NAME,                     	-- 3 	8
        SRC_DOCUMENTS,                          	-- 3 	9
        SRC_REJECTED_DOCS,                      	-- 3 	10
        SRC_PAGES,                              	-- 3 	11
        SRC_REJECTED_PAGES,                     	-- 3 	12
        SRC_KS_MANUAL,                          	-- 3 	13
        SRC_KS_OCR_REPAIR,                      	-- 3 	14
        SRC_KS_ICR_REPAIR,                      	-- 3 	15
        SRC_KS_BCR_REPAIR,                       	-- 3 	16
        SRC_KS_OMR_REPAIR,                      	-- 3 	17
        SRC_COMPLETED_DOCS,                     	-- 3 	18
        SRC_COMPLETED_PAGES,                    	-- 3 	19
        SRC_TRANSFER_ID,                        	-- 3 	20
        TARGET_SOURCE_SERVER,                   	-- 4 	1
        TARGET_BATCH_GUID,                      	-- 4 	2
--      TARGET_MFB_V2_CREATE_DATE,              	-- 4 	3
--      TARGET_MFB_V2_UPDATE_DATE,              	-- 4 	4
        TARGET_FORM_TYPE_ENTRY_ID,               	-- 4 	5
        TARGET_BATCH_MODULE_ID,                 	-- 4 	6
        TARGET_FORM_TYPE_NAME,                  	-- 4 	7
        TARGET_DOC_CLASS_NAME,                  	-- 4 	8
        TARGET_DOCUMENTS,                       	-- 4 	9
        TARGET_REJECTED_DOCS,                   	-- 4 	10
        TARGET_PAGES,                           	-- 4 	11
        TARGET_REJECTED_PAGES,                  	-- 4 	12
        TARGET_KS_MANUAL,                       	-- 4 	13
        TARGET_KS_OCR_REPAIR,                   	-- 4 	14
        TARGET_KS_ICR_REPAIR,                   	-- 4 	15
        TARGET_KS_BCR_REPAIR,                    	-- 4 	16
        TARGET_KS_OMR_REPAIR,                   	-- 4 	17
        TARGET_COMPLETED_DOCS,                  	-- 4 	18
        TARGET_COMPLETED_PAGES,                 	-- 4 	19
        TARGET_TRANSFER_ID	                     	-- 4 	20
	FROM SRC
	LEFT OUTER JOIN TARGET
	ON SRC_SOURCE_SERVER = TARGET_SOURCE_SERVER
        AND SRC_FORM_TYPE_ENTRY_ID = TARGET_FORM_TYPE_ENTRY_ID
		AND NOT (SRC_SOURCE_SERVER = 'REMOTE'
	AND TARGET_SOURCE_SERVER = 'CENTRAL' );


	JOIN_REC   JOIN_CSR%ROWTYPE;

-----------------------------------------------------
PROCEDURE LOAD_STATS_FORM_TYPE (P_JOB_ID number default 0) 
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

			IF JOIN_REC.SRC_ROWID IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN Update_STATS_FORM_TYPE;
			ELSIF JOIN_REC.SRC_ROWID IS NOT NULL 
			AND JOIN_REC.TARGET_ROWID IS NULL 
                --then null;
				THEN INSERT_STATS_FORM_TYPE;
			ELSIF JOIN_REC.SRC_ROWID IS NULL 
			AND JOIN_REC.TARGET_ROWID IS NOT NULL 
                --then null;
				THEN DELETE_STATS_FORM_TYPE;
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
				'SRC_FORM_TYPE_ENTRY_ID: '||JOIN_REC.SRC_FORM_TYPE_ENTRY_ID
				||' TARGET_FORM_TYPE_ENTRY_ID: '||JOIN_REC.TARGET_FORM_TYPE_ENTRY_ID
				||'SQLCODE '||GV_ERROR_CODE
				||' '||GV_ERROR_MESSAGE);

			ROLLBACK;

			RAISE;

END Load_STATS_FORM_TYPE;

-----------------------------------------------------

-----------------------------------------------------
PROCEDURE UPDATE_STATS_FORM_TYPE IS
-- USES SQL FROM 5 AND 6
-----------------------------------------------------

	BEGIN

	-- COMPARE  -- SQL FROM QUERY 5
		IF 1=2
        --    OR NVL(JOIN_REC.TARGET_SOURCE_SERVER,'-?93333')	  <>  	NVL(JOIN_REC.SRC_SOURCE_SERVER,'-?93333')	-- 5 	1	VARCHAR2
            OR NVL(JOIN_REC.TARGET_BATCH_GUID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_GUID,'-?93333')	-- 5 	2	VARCHAR2
        --    OR NVL(JOIN_REC.TARGET_MFB_V2_CREATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_CREATE_DATE,SYSDATE - 93333)	-- 5 	3	DATE
        --    OR NVL(JOIN_REC.TARGET_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	  <>  	NVL(JOIN_REC.SRC_MFB_V2_UPDATE_DATE,SYSDATE - 93333)	-- 5 	4	DATE
            OR NVL(JOIN_REC.TARGET_FORM_TYPE_ENTRY_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_FORM_TYPE_ENTRY_ID,'-?93333')	-- 5 	5	VARCHAR2
            OR NVL(JOIN_REC.TARGET_BATCH_MODULE_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_BATCH_MODULE_ID,'-?93333')	-- 5 	6	VARCHAR2
            OR NVL(JOIN_REC.TARGET_FORM_TYPE_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_FORM_TYPE_NAME,'-?93333')	-- 5 	7	VARCHAR2
            OR NVL(JOIN_REC.TARGET_DOC_CLASS_NAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_DOC_CLASS_NAME,'-?93333')	-- 5 	8	VARCHAR2
            OR NVL(JOIN_REC.TARGET_DOCUMENTS, -93333)	  <>  	NVL(JOIN_REC.SRC_DOCUMENTS, -93333)	-- 5 	9	NUMBER
            OR NVL(JOIN_REC.TARGET_REJECTED_DOCS, -93333)	  <>  	NVL(JOIN_REC.SRC_REJECTED_DOCS, -93333)	-- 5 	10	NUMBER
            OR NVL(JOIN_REC.TARGET_PAGES, -93333)	  <>  	NVL(JOIN_REC.SRC_PAGES, -93333)	-- 5 	11	NUMBER
            OR NVL(JOIN_REC.TARGET_REJECTED_PAGES, -93333)	  <>  	NVL(JOIN_REC.SRC_REJECTED_PAGES, -93333)	-- 5 	12	NUMBER
            OR NVL(JOIN_REC.TARGET_KS_MANUAL, -93333)	  <>  	NVL(JOIN_REC.SRC_KS_MANUAL, -93333)	-- 5 	13	NUMBER
            OR NVL(JOIN_REC.TARGET_KS_OCR_REPAIR, -93333)	  <>  	NVL(JOIN_REC.SRC_KS_OCR_REPAIR, -93333)	-- 5 	14	NUMBER
            OR NVL(JOIN_REC.TARGET_KS_ICR_REPAIR, -93333)	  <>  	NVL(JOIN_REC.SRC_KS_ICR_REPAIR, -93333)	-- 5 	15	NUMBER
            OR NVL(JOIN_REC.TARGET_KS_BCR_REPAIR, -93333)	  <>  	NVL(JOIN_REC.SRC_KS_BCR_REPAIR, -93333)	-- 5 	16	NUMBER
            OR NVL(JOIN_REC.TARGET_KS_OMR_REPAIR, -93333)	  <>  	NVL(JOIN_REC.SRC_KS_OMR_REPAIR, -93333)	-- 5 	17	NUMBER
            OR NVL(JOIN_REC.TARGET_COMPLETED_DOCS, -93333)	  <>  	NVL(JOIN_REC.SRC_COMPLETED_DOCS, -93333)	-- 5 	18	NUMBER
            OR NVL(JOIN_REC.TARGET_COMPLETED_PAGES, -93333)	  <>  	NVL(JOIN_REC.SRC_COMPLETED_PAGES, -93333)	-- 5 	19	NUMBER
            OR NVL(JOIN_REC.TARGET_TRANSFER_ID,'-?93333')	  <>  	NVL(JOIN_REC.SRC_TRANSFER_ID,'-?93333')	-- 5 	20	VARCHAR2
	THEN
		UPDATE MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE
		SET  
		-- THE UPDATE  SQL FROM QUERY 6
        --    SOURCE_SERVER                             =  JOIN_REC.SRC_SOURCE_SERVER,	-- 6 	1
            BATCH_GUID                                =  JOIN_REC.SRC_BATCH_GUID,	-- 6 	2
        --    MFB_V2_CREATE_DATE                        =  JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 6 	3
        --    MFB_V2_UPDATE_DATE                        =  JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 6 	4
            FORM_TYPE_ENTRY_ID                         =  JOIN_REC.SRC_FORM_TYPE_ENTRY_ID,	-- 6 	5
            BATCH_MODULE_ID                           =  JOIN_REC.SRC_BATCH_MODULE_ID,	-- 6 	6
            FORM_TYPE_NAME                            =  JOIN_REC.SRC_FORM_TYPE_NAME,	-- 6 	7
            DOC_CLASS_NAME                            =  JOIN_REC.SRC_DOC_CLASS_NAME,	-- 6 	8
            DOCUMENTS                                 =  JOIN_REC.SRC_DOCUMENTS,	-- 6 	9
            REJECTED_DOCS                             =  JOIN_REC.SRC_REJECTED_DOCS,	-- 6 	10
            PAGES                                     =  JOIN_REC.SRC_PAGES,	-- 6 	11
            REJECTED_PAGES                            =  JOIN_REC.SRC_REJECTED_PAGES,	-- 6 	12
            KS_MANUAL                                 =  JOIN_REC.SRC_KS_MANUAL,	-- 6 	13
            KS_OCR_REPAIR                             =  JOIN_REC.SRC_KS_OCR_REPAIR,	-- 6 	14
            KS_ICR_REPAIR                             =  JOIN_REC.SRC_KS_ICR_REPAIR,	-- 6 	15
            KS_BCR_REPAIR                              =  JOIN_REC.SRC_KS_BCR_REPAIR,	-- 6 	16
            KS_OMR_REPAIR                             =  JOIN_REC.SRC_KS_OMR_REPAIR,	-- 6 	17
            COMPLETED_DOCS                            =  JOIN_REC.SRC_COMPLETED_DOCS,	-- 6 	18
            COMPLETED_PAGES                           =  JOIN_REC.SRC_COMPLETED_PAGES,	-- 6 	19
            TRANSFER_ID                               =  JOIN_REC.SRC_TRANSFER_ID,		-- 6 	20
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
            ||JOIN_REC.SRC_rowid||' '
            ||JOIN_REC.target_rowid);

		GV_DRIVER_KEY_NUMBER  	:= 'SRC_OLTP_LOAD_SEQ : '||JOIN_REC.SRC_OLTP_LOAD_SEQ;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_STATS_FORM_TYPE_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_STATS_FORM_TYPE';

		POST_ERROR;

	END UPDATE_STATS_FORM_TYPE;	

-----------------------------------------------------
PROCEDURE INSERT_STATS_FORM_TYPE IS
-- USES SQL  FROM 7 AND 8
-----------------------------------------------------

	BEGIN

		INSERT INTO MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE
		(   -- INSERT PART 1 SQL FROM QUERY 7
            SOURCE_SERVER,                          	-- 7 	1
            BATCH_GUID,                             	-- 7 	2
        --    MFB_V2_CREATE_DATE,                     	-- 7 	3
        --    MFB_V2_UPDATE_DATE,                     	-- 7 	4
            FORM_TYPE_ENTRY_ID,                      	-- 7 	5
            BATCH_MODULE_ID,                        	-- 7 	6
            FORM_TYPE_NAME,                         	-- 7 	7
            DOC_CLASS_NAME,                         	-- 7 	8
            DOCUMENTS,                              	-- 7 	9
            REJECTED_DOCS,                          	-- 7 	10
            PAGES,                                  	-- 7 	11
            REJECTED_PAGES,                         	-- 7 	12
            KS_MANUAL,                              	-- 7 	13
            KS_OCR_REPAIR,                          	-- 7 	14
            KS_ICR_REPAIR,                          	-- 7 	15
            KS_BCR_REPAIR,                           	-- 7 	16
            KS_OMR_REPAIR,                          	-- 7 	17
            COMPLETED_DOCS,                         	-- 7 	18
            COMPLETED_PAGES,                        	-- 7 	19
            TRANSFER_ID,                            	-- 7 	20
			MFB_V2_PARENT_JOB_ID
		)
		VALUES ( -- INSERT PART 2 SQL FROM QUERY 8
            JOIN_REC.SRC_SOURCE_SERVER,	-- 8 	1
            JOIN_REC.SRC_BATCH_GUID,	-- 8 	2
         --   JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	3
         --   JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	4
            JOIN_REC.SRC_FORM_TYPE_ENTRY_ID,	-- 8 	5
            JOIN_REC.SRC_BATCH_MODULE_ID,	-- 8 	6
            JOIN_REC.SRC_FORM_TYPE_NAME,	-- 8 	7
            JOIN_REC.SRC_DOC_CLASS_NAME,	-- 8 	8
            JOIN_REC.SRC_DOCUMENTS,	-- 8 	9
            JOIN_REC.SRC_REJECTED_DOCS,	-- 8 	10
            JOIN_REC.SRC_PAGES,	-- 8 	11
            JOIN_REC.SRC_REJECTED_PAGES,	-- 8 	12
            JOIN_REC.SRC_KS_MANUAL,	-- 8 	13
            JOIN_REC.SRC_KS_OCR_REPAIR,	-- 8 	14
            JOIN_REC.SRC_KS_ICR_REPAIR,	-- 8 	15
            JOIN_REC.SRC_KS_BCR_REPAIR,	-- 8 	16
            JOIN_REC.SRC_KS_OMR_REPAIR,	-- 8 	17
            JOIN_REC.SRC_COMPLETED_DOCS,	-- 8 	18
            JOIN_REC.SRC_COMPLETED_PAGES,	-- 8 	19
            JOIN_REC.SRC_TRANSFER_ID,		-- 8 	20
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

        -- '${MFB_V2_REMOTE_START_DATE}'
		GV_DRIVER_KEY_NUMBER  	:= 'SRC_OLTP_LOAD_SEQ : '||JOIN_REC.SRC_OLTP_LOAD_SEQ;
		GV_DRIVER_TABLE_NAME  	:= 'NYHIX_MFB_MAXDAT_V2_STATS_FORM_TYPE_OLTP';	
		GV_ERR_LEVEL		  	:= 'Warning';
		GV_PROCESS_NAME 		:= 'Update_STATS_FORM_TYPE';

		POST_ERROR;

	END INSERT_STATS_FORM_TYPE;	

-----------------------------------------------------
PROCEDURE DELETE_STATS_FORM_TYPE IS
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

	END DELETE_STATS_FORM_TYPE;	


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

			INSERT INTO MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE_OLTP_ERR
		(   
			OLTP_LOAD_SEQ,
			OLTP_LOAD_DATE_TIME,
			-- INSERT PART 1 SQL FROM QUERY 7
            SOURCE_SERVER,                          	-- 7 	1
            BATCH_GUID,                             	-- 7 	2
			--    MFB_V2_CREATE_DATE,                     	-- 7 	3
			--    MFB_V2_UPDATE_DATE,                     	-- 7 	4
            FORM_TYPE_ENTRY_ID,                      	-- 7 	5
            BATCH_MODULE_ID,                        	-- 7 	6
            FORM_TYPE_NAME,                         	-- 7 	7
            DOC_CLASS_NAME,                         	-- 7 	8
            DOCUMENTS,                              	-- 7 	9
            REJECTED_DOCS,                          	-- 7 	10
            PAGES,                                  	-- 7 	11
            REJECTED_PAGES,                         	-- 7 	12
            KS_MANUAL,                              	-- 7 	13
            KS_OCR_REPAIR,                          	-- 7 	14
            KS_ICR_REPAIR,                          	-- 7 	15
            KS_BCR_REPAIR,                           	-- 7 	16
            KS_OMR_REPAIR,                          	-- 7 	17
            COMPLETED_DOCS,                         	-- 7 	18
            COMPLETED_PAGES,                        	-- 7 	19
            TRANSFER_ID	                            	-- 7 	20
		)
		VALUES ( -- INSERT PART 2 SQL FROM QUERY 8
			JOIN_REC.SRC_OLTP_LOAD_SEQ,
			JOIN_REC.SRC_OLTP_LOAD_DATE_TIME,
            JOIN_REC.SRC_SOURCE_SERVER,	-- 8 	1
            JOIN_REC.SRC_BATCH_GUID,	-- 8 	2
         --   JOIN_REC.SRC_MFB_V2_CREATE_DATE,	-- 8 	3
         --   JOIN_REC.SRC_MFB_V2_UPDATE_DATE,	-- 8 	4
            JOIN_REC.SRC_FORM_TYPE_ENTRY_ID,	-- 8 	5
            JOIN_REC.SRC_BATCH_MODULE_ID,	-- 8 	6
            JOIN_REC.SRC_FORM_TYPE_NAME,	-- 8 	7
            JOIN_REC.SRC_DOC_CLASS_NAME,	-- 8 	8
            JOIN_REC.SRC_DOCUMENTS,	-- 8 	9
            JOIN_REC.SRC_REJECTED_DOCS,	-- 8 	10
            JOIN_REC.SRC_PAGES,	-- 8 	11
            JOIN_REC.SRC_REJECTED_PAGES,	-- 8 	12
            JOIN_REC.SRC_KS_MANUAL,	-- 8 	13
            JOIN_REC.SRC_KS_OCR_REPAIR,	-- 8 	14
            JOIN_REC.SRC_KS_ICR_REPAIR,	-- 8 	15
            JOIN_REC.SRC_KS_BCR_REPAIR,	-- 8 	16
            JOIN_REC.SRC_KS_OMR_REPAIR,	-- 8 	17
            JOIN_REC.SRC_COMPLETED_DOCS,	-- 8 	18
            JOIN_REC.SRC_COMPLETED_PAGES,	-- 8 	19
            JOIN_REC.SRC_TRANSFER_ID		-- 8 	20
			);

		COMMIT;

EXCEPTION

	When Others then 
		GV_ERROR_CODE := SQLCODE;
		GV_ERROR_MESSAGE := SUBSTR(SQLERRM, 1, 3000);                 
	DBMS_OUTPUT.PUT_LINE('Procedure Post_Error failed with '||GV_Error_Code||': '||GV_Error_Message);

	--RAISE;


END;



END NYHIX_MFB_V2_STATS_FORM_TYPE_PKG;

/


GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_BATCH_EVENT_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_DOCUMENT_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_ENVELOPE_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_PKG TO MAXDAT_PFP_E;

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE_PKG TO MAXDAT_PFP_E;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_BATCH_EVENT_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_DOCUMENT_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_ENVELOPE_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_IMAGE_TRUST_STATS_BATCH_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_PKG TO MAXDAT_PFP_READ_ONLY;

GRANT DEBUG ON MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE_PKG TO MAXDAT_PFP_READ_ONLY;
