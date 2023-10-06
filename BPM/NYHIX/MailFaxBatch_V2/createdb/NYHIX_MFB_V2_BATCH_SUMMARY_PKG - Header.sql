create or replace Package MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/MailFaxBatch_V2/createdb/NYHIX_MFB_V2_BATCH_SUMMARY_PKG.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 34187 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2023-09-06 10:35:26 -0400 (Wed, 06 Sep 2023) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: gt83345 $';

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

