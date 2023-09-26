
ALTER TABLE MAXDAT.NYHIX_MFB_V2_BATCH_EVENT
ADD
( MFB_V2_PARENT_JOB_ID	NUMBER(10,0),
PRIORITY	NUMBER(38,0),
SML_MODULE_NAME	VARCHAR2(32 BYTE)
);

ALTER TABLE MAXDAT.NYHIX_MFB_V2_DOCUMENT ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);
ALTER TABLE MAXDAT.NYHIX_MFB_V2_ENVELOPE ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);

ALTER TABLE MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING		ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);
ALTER TABLE MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING_OLTP	ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);

ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_BATCH	ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);
ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_BATCH	ADD	REPROCESSED_FLAG		VARCHAR2(1);
ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_BATCH	ADD REPROCESSED_DATE		DATE;

ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE					ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);
ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH			ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);
ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_OLTP		ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);
ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_OLTP_ERR	ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);
ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_OLTP				ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);
ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_OLTP_ERR			ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);
ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_OLTP					ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);
ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_BATCH_OLTP_ERR				ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);
ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE						ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);
ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE_OLTP				ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);
ALTER TABLE MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE_OLTP_ERR			ADD MFB_V2_PARENT_JOB_ID	NUMBER(10);

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
  
CREATE OR REPLACE FORCE EDITIONABLE VIEW MAXDAT.NYHIX_MFB_V2_EVENTS_OLTP_V
  AS
  with last_run_date as 
  (select min(max_date) min_date
    from (
        select to_date(value,'DD-MON-YY') as max_date 
        from maxdat.corp_etl_control where name = 'MFB_V2_REMOTE_LAST_UPDATE_DATE'
        union
        select to_date(value,'DD-MON-YY') as max_date 
        from maxdat.corp_etl_control where name = 'MFB_V2_CENTRAL_LAST_UPDATE_DATE'
        )
  )
SELECT distinct 
	sbm.Batch_Module_ID,
	sbm.Batch_GUID,
	sml.Module_Launch_ID,
	sml.Module_Unique_ID,
	(case when sml.Module_Name like 'Advanced%' then 'Advanced Reports - Data Export' else sml.Module_Name end) ModuleName,
	sbm.Module_Close_Unique_ID,
	(case when sbm.Module_Close_Name like 'Advanced%' then 'Advanced Reports - Data Export' else sbm.Module_Close_Name end) Module_Close_Name,
	sbm.Batch_Status,
	sbm.Start_Date_Time,
	sbm.End_Date_Time,
	sml.User_Name,
	replace(sml.User_ID,'MAXIMUS\') User_ID, 
	sml.Station_ID,
	sml.Site_Name,
	sml.Site_ID,
	sbm.Deleted,
	sbm.Pages_Per_Document,
	sbm.Pages_Scanned,
	sbm.Pages_Deleted,
	sbm.Documents_Created,
	sbm.Documents_Deleted,
	sbm.Pages_Replaced,
	sbm.Error_Text,
	sysdate EXTRACT_DATE,
	sbm.source_server,
	sbm.PRIORITY,
	sml.module_name as SML_MODULE_NAME
FROM NYHIX_MFB_V2_STATS_BATCH sb
JOIN NYHIX_MFB_V2_STATS_BATCH_MODULE sbm
	ON sbm.EXTERNAL_BATCH_ID = sb.EXTERNAL_BATCH_ID
JOIN NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH sml
	ON SML.Module_Launch_ID = SBM.Module_Launch_ID
and sb.batch_guid in 
( 
select batch_guid from NYHIX_MFB_V2_STATS_BATCH_oltp
union  
select batch_guid from NYHIX_MFB_V2_STATS_BATCH_module_oltp
union
select batch_guid from NYHIX_MFB_V2_STATS_BATCH
where mfb_v2_update_date >= (select min_date from last_run_date )
union
select batch_guid from NYHIX_MFB_V2_STATS_BATCH_module
where mfb_v2_update_date >= (select min_date from last_run_date )
union
select batch_guid from NYHIX_MFB_V2_MAXDAT_REPORTING
where mfb_v2_update_date >= (select min_date from last_run_date )
);


  GRANT DELETE ON MAXDAT.NYHIX_MFB_V2_EVENTS_OLTP_V TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.NYHIX_MFB_V2_EVENTS_OLTP_V TO MAXDAT_OLTP_SIUD;
  GRANT SELECT ON MAXDAT.NYHIX_MFB_V2_EVENTS_OLTP_V TO MAXDAT_READ_ONLY;
  GRANT INSERT ON MAXDAT.NYHIX_MFB_V2_EVENTS_OLTP_V TO MAXDAT_OLTP_SIU;
  GRANT SELECT ON MAXDAT.NYHIX_MFB_V2_EVENTS_OLTP_V TO MAXDAT_OLTP_SIU;
  GRANT SELECT ON MAXDAT.NYHIX_MFB_V2_EVENTS_OLTP_V TO MAXDAT_OLTP_SIUD;
  GRANT UPDATE ON MAXDAT.NYHIX_MFB_V2_EVENTS_OLTP_V TO MAXDAT_OLTP_SIUD;
  GRANT UPDATE ON MAXDAT.NYHIX_MFB_V2_EVENTS_OLTP_V TO MAXDAT_OLTP_SIU;

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

CREATE TABLE MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY 
   (	MFB_V2_CREATE_DATE DATE, 
	MFB_V2_UPDATE_DATE DATE, 
	BATCH_GUID VARCHAR2(38 BYTE), 
	EXTERNAL_BATCH_ID NUMBER, 
	BATCH_NAME VARCHAR2(255 BYTE), 
	SOURCE_SERVER VARCHAR2(255 BYTE), 
	BATCH_DESCRIPTION VARCHAR2(80 BYTE), 
	REPROCESSED_FLAG VARCHAR2(1 BYTE) DEFAULT 'N', 
	CREATION_STATION_ID VARCHAR2(32 BYTE), 
	CREATION_USER_NAME VARCHAR2(80 BYTE), 
	CREATION_USER_ID VARCHAR2(128 BYTE), 
	BATCH_CLASS VARCHAR2(32 BYTE), 
	BATCH_CLASS_DES VARCHAR2(80 BYTE), 
	BATCH_TYPE VARCHAR2(38 BYTE), 
	CREATE_DT DATE, 
	COMPLETE_DT DATE, 
	INSTANCE_STATUS VARCHAR2(30 BYTE), 
	INSTANCE_STATUS_DT DATE, 
	BATCH_PAGE_COUNT NUMBER, 
	BATCH_DOC_COUNT NUMBER, 
	BATCH_ENVELOPE_COUNT NUMBER, 
	CANCEL_DT DATE, 
	CANCEL_BY VARCHAR2(80 BYTE), 
	CANCEL_REASON VARCHAR2(80 BYTE), 
	CANCEL_METHOD VARCHAR2(80 BYTE), 
	ASF_SCAN_BATCH VARCHAR2(1 BYTE) DEFAULT 'N', 
	ASSD_SCAN_BATCH DATE, 
	ASED_SCAN_BATCH DATE, 
	ASPB_SCAN_BATCH VARCHAR2(80 BYTE), 
	ASF_PERFORM_QC VARCHAR2(1 BYTE) DEFAULT 'N', 
	ASSD_PERFORM_QC DATE, 
	ASED_PERFORM_QC DATE, 
	ASPB_PERFORM_QC VARCHAR2(80 BYTE), 
	KOFAX_QC_REASON VARCHAR2(100 BYTE), 
	ASF_CLASSIFICATION VARCHAR2(1 BYTE) DEFAULT 'N', 
	ASSD_CLASSIFICATION DATE, 
	ASED_CLASSIFICATION DATE, 
	CLASSIFICATION_DT DATE, 
	ASF_RECOGNITION VARCHAR2(1 BYTE) DEFAULT 'N', 
	ASSD_RECOGNITION DATE, 
	ASED_RECOGNITION DATE, 
	RECOGNITION_DT DATE, 
	ASF_VALIDATE_DATA VARCHAR2(1 BYTE) DEFAULT 'N', 
	ASSD_VALIDATE_DATA DATE, 
	ASED_VALIDATE_DATA DATE, 
	ASPB_VALIDATE_DATA VARCHAR2(80 BYTE), 
	VALIDATION_DT DATE, 
	ASF_CREATE_PDF VARCHAR2(1 BYTE) DEFAULT 'N', 
	ASSD_CREATE_PDF DATE, 
	ASED_CREATE_PDF DATE, 
	ASF_POPULATE_REPORTS VARCHAR2(1 BYTE) DEFAULT 'N', 
	ASSD_POPULATE_REPORTS DATE, 
	ASED_POPULATE_REPORTS DATE, 
	ASF_RELEASE_DMS VARCHAR2(1 BYTE) DEFAULT 'N', 
	ASSD_RELEASE_DMS DATE, 
	ASED_RELEASE_DMS DATE, 
	BATCH_PRIORITY NUMBER, 
	BATCH_DELETED VARCHAR2(1 BYTE), 
	PAGES_SCANNED_FLAG VARCHAR2(1 BYTE), 
	DOCS_CREATED_FLAG VARCHAR2(1 BYTE), 
	DOCS_DELETED_FLAG VARCHAR2(1 BYTE), 
	PAGES_REPLACED_FLAG VARCHAR2(1 BYTE), 
	PAGES_DELETED_FLAG VARCHAR2(1 BYTE), 
	STG_DONE_DATE DATE, 
	STG_EXTRACT_DATE DATE, 
	STG_LAST_UPDATE_DATE DATE, 
	STG_PROCESSED_DATE DATE, 
	UPDATED VARCHAR2(1 BYTE), 
	BATCH_COMPLETE_DT DATE, 
	CURRENT_BATCH_MODULE_ID VARCHAR2(250 BYTE), 
	GWF_QC_REQUIRED VARCHAR2(1 BYTE), 
	CURRENT_STEP VARCHAR2(100 BYTE), 
	CEJS_JOB_ID NUMBER, 
	ASPB_VALIDATE_DATA_USER_ID VARCHAR2(128 BYTE), 
	FAX_BATCH_SOURCE VARCHAR2(100 BYTE), 
	MFB_V2_PARENT_JOB_ID NUMBER(10,0), 
	 CONSTRAINT NYHIX_MFB_V2_BATCH_SUMMARY_PK PRIMARY KEY (BATCH_GUID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_INDX  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE MAXDAT_DATA ;

   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.BATCH_GUID IS 'Unique identifier for the batch in KOFAX.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.EXTERNAL_BATCH_ID IS 'Batch ID in KOFAX.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.BATCH_NAME IS 'Name assigned to the batch when it is created.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.BATCH_DESCRIPTION IS 'Batch Description, may contain a batch_name if reprocessed';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.REPROCESSED_FLAG IS 'Reprocessed Flag identifies records that were not previously successfully processed';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.CREATION_STATION_ID IS 'Identifies the KOFAX Capture station where the batch is created. The Station ID is assigned during the installation process.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.CREATION_USER_NAME IS 'This is the Windows login name for the user who creates the batch.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.CREATION_USER_ID IS 'If the User Profiles feature is enabled, the KOFAX Capture login ID for the user who creates the batch.  If User Profiles are not enabled, this is the Windows login name for the user who creates the batch.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.BATCH_CLASS IS 'Name of the batch class.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.BATCH_CLASS_DES IS 'Description of the batch class on which the batch is based. ';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.BATCH_TYPE IS 'The type of batch. ';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.CREATE_DT IS 'The date that the batch is initially scanned.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.COMPLETE_DT IS 'The date the batch was successfully released to DMS, cancelled, or otherwise deleted.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.INSTANCE_STATUS IS 'Instance Status indicates if the batch is in process or not. When the batch is created the status is set to ''Active'', and it remains open until the batch has been successfully released to DMS,  is cancelled, or otherwise deleted when it is then set to ''Complete''.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.INSTANCE_STATUS_DT IS 'The date and time the batch was created.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.BATCH_PAGE_COUNT IS 'The total number of pages that are scanned in a single batch.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.BATCH_DOC_COUNT IS 'Displays the total number of documents scanned in the batch.   The value is set based on the number of document separator sheets read through KOFAX.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.BATCH_ENVELOPE_COUNT IS 'The total number of envelopes in the batch.  This number is entered manually at the beginning of the scanning process.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.CANCEL_DT IS 'The date when a worker initiated the cancelling of a batch. The date/time that the batch was deleted from the source system. If the date is unknown, the date this condition was detected.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.CANCEL_BY IS 'The performer who cancelled the batch.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.CANCEL_REASON IS 'The reason the instance was cancelled.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.CANCEL_METHOD IS 'The method by which the instance was cancelled.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASF_SCAN_BATCH IS 'ASF_SCAN_BATCH';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASSD_SCAN_BATCH IS 'The date and time work started on the Scan Batch activity step.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASED_SCAN_BATCH IS 'Date and time all work was completed for the Scan Batch activity step.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASPB_SCAN_BATCH IS 'The name of the staff member who completed the Scan Batch activity step.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASF_PERFORM_QC IS 'ASF_PERFORM_QC';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASSD_PERFORM_QC IS 'The date and time work started on a batch for the Perform QC activity step.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASED_PERFORM_QC IS 'Date and time all work was completed for a batch for the Perform QC activity step.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASPB_PERFORM_QC IS 'The name of the staff member who completed the Perform QC activity step.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.KOFAX_QC_REASON IS 'The KOFAX QC Reason explains what occurred during the scanning process that requires the batch and its contents to be reviewed by a worker in the Perform QC Activity Step.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASF_CLASSIFICATION IS 'ASF_CLASSIFICATION';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASSD_CLASSIFICATION IS 'Date and time work started on a batch for the Recognition activity step.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASED_CLASSIFICATION IS 'Date and time work was completed for a batch for the Classification activity step.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.CLASSIFICATION_DT IS 'Date and time that indicates when the document was classified.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASF_RECOGNITION IS 'ASF_RECOGNITION';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASSD_RECOGNITION IS 'Date and time work started on a batch for the Recognition activity step.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASED_RECOGNITION IS 'Date and time work was completed for a batch for the Recognition activity step.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.RECOGNITION_DT IS 'Date and time that indicates when the document completed Recognition. ';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASF_VALIDATE_DATA IS 'ASF_VALIDATE_DATA';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASSD_VALIDATE_DATA IS 'Date and time work started on a batch for the Verify Results activity step.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASED_VALIDATE_DATA IS 'Date and time work was completed for a batch for the Verify Results activity step.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASPB_VALIDATE_DATA IS 'Name of the staff member who completed the Verify Results activity step.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.VALIDATION_DT IS 'Date and time that indicates when the document was validated. ';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASF_CREATE_PDF IS 'ASF_CREATE_PDF';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASSD_CREATE_PDF IS 'Date and time when the PDF Generator module begins.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASED_CREATE_PDF IS 'Date and time when the PDF Generator module completed converting each page of a document in a batch to a PDF. ';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASF_POPULATE_REPORTS IS 'ASF_POPULATE_REPORTS';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASSD_POPULATE_REPORTS IS 'Date and time when the KOFAX Advanced Reports custom workflow agent begins capturing and storing the batch  information required for reporting';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASED_POPULATE_REPORTS IS 'Date and time when the KOFAX Advanced Reports custom workflow agent completes capturing and storing the batch  information required for reporting';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASF_RELEASE_DMS IS 'ASF_RELEASE_DMS';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASSD_RELEASE_DMS IS 'Date and time when the KOFAX Export Module begins to process the scanned and imported documents through the Export engine designed to create documents with associated metadata and place them into a managed folder (DMS)';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.ASED_RELEASE_DMS IS 'Date and time when the KOFAX Export Module completed processing the scanned and imported documents through the Export engine designed to create documents with associated metadata and place them into a managed folder (DMS)';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.BATCH_PRIORITY IS 'The priority of the batch.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.BATCH_DELETED IS 'Flag that indicates that the batch was deleted during the current processing session. ';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.PAGES_SCANNED_FLAG IS 'Flag that indicates the number of pages scanned changed during the current processing session.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.DOCS_CREATED_FLAG IS 'Flag that indicates that documents were created during the current processing session.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.DOCS_DELETED_FLAG IS 'Flag that indicates that documents were replaced during the current processing session';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.PAGES_REPLACED_FLAG IS 'Flag that indicates pages replaced during the current processing session.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.PAGES_DELETED_FLAG IS 'Flag indicating that pages were deleted during at any time during processing. ';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.STG_EXTRACT_DATE IS 'STG_EXTRACT_DATE';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.STG_LAST_UPDATE_DATE IS 'STG_LAST_UPDATE_DATE';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.BATCH_COMPLETE_DT IS 'The date/timestamp that KOFAX considers the batch completed successfully (i.e. Released to DMS).';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.CURRENT_BATCH_MODULE_ID IS 'Identifier for the current record in Master Batch Module Staging.  It is NA if the batch is completed in KOFAX.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.GWF_QC_REQUIRED IS 'QC Required Gateway Flag.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.CURRENT_STEP IS 'Current Activity Step for this Instance.';
   COMMENT ON COLUMN MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY.CEJS_JOB_ID IS 'Batch Job ID from CORP_ETL_MFB_CONTROL for MicroStrategy Cache Updating';


CREATE OR REPLACE EDITIONABLE TRIGGER MAXDAT.TRG_BIU_NYHIX_MFB_V2_BATCH_SUMMARY 
BEFORE INSERT OR UPDATE ON MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY
FOR EACH ROW
BEGIN
	IF INSERTING THEN
		:NEW.MFB_V2_CREATE_DATE := SYSDATE;
		:NEW.MFB_V2_UPDATE_DATE := NULL;
	END IF;

	IF UPDATING THEN
		:NEW.MFB_V2_CREATE_DATE := :OLD.MFB_V2_CREATE_DATE;
		:NEW.MFB_V2_UPDATE_DATE := SYSDATE;
	END IF;	

END;
/
SHOW ERRORS

ALTER TRIGGER MAXDAT.TRG_BIU_NYHIX_MFB_V2_BATCH_SUMMARY ENABLE;


  GRANT DELETE ON MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY TO MAXDAT_OLTP_SIUD;
  GRANT SELECT ON MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY TO MAXDAT_READ_ONLY;
  GRANT SELECT ON MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY TO MAXDAT_OLTP_SIU;
  GRANT UPDATE ON MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY TO MAXDAT_OLTP_SIU;
  GRANT SELECT ON MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY TO MAXDAT_OLTP_SIUD;
  GRANT UPDATE ON MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY TO MAXDAT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY TO MAXDAT_OLTP_SIU;

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

create or replace Package        NYHIX_MFB_V2_BATCH_EVENT_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


    Procedure Insert_EVENTS;
    Procedure Update_EVENTS;
    Procedure Delete_EVENTS;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_EVENTS ( p_job_id number default 0);

END NYHIX_MFB_V2_BATCH_EVENT_PKG;
/
show errors

create or replace PACKAGE BODY        NYHIX_MFB_V2_BATCH_EVENT_PKG AS

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
                     SRC.MODULENAME                           AS SRC_MODULENAME,	-- 1 	5
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
                  TARGET.MODULENAME                        AS TARGET_MODULENAME,	-- 2 	5
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
                              SRC_MODULENAME,                         	-- 3 	5
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
                              TARGET_MODULENAME,                      	-- 4 	5
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

        GV_JOB_NAME	:= GV_PROCESS_NAME||' Parent ID: '||GV_PARENT_JOB_ID||' - '||'Step NYHIX_MFB_V2_BATCH_EVENT';			

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
            OR NVL(JOIN_REC.TARGET_MODULENAME,'-?93333')	  <>  	NVL(JOIN_REC.SRC_MODULENAME,'-?93333')	-- 5 	5	VARCHAR2
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
            MODULENAME                                =  JOIN_REC.SRC_MODULENAME,	-- 6 	5
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
            MODULENAME,                             	-- 7 	5
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
            JOIN_REC.SRC_MODULENAME,	-- 8 	5
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
show errors

GRANT EXECUTE ON MAXDAT.NYHIX_MFB_V2_BATCH_EVENT_PKG TO MAXDAT_READ_ONLY;

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
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

END NYHIX_MFB_V2_BATCH_SUMMARY_PKG;
/
show errors

create or replace PACKAGE BODY        NYHIX_MFB_V2_BATCH_SUMMARY_PKG AS

-- Table Relationships
-- Stats_Batch <------>> Stats_Batch_Module <<----> Stats_Batch_Module_Launch
--						
--						 Stats_Batch_Module <------->> Stats_Form_Type 
  

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


	-------------------------------------------------------------------------------------------
	-- THIS IS THE "DRIVING" CURSOR  
	-- It selects a distinct list of any  BATCH_GUID 
	-- that was Inserted or Updated
	-- based on the "Parent Job ID"
	-------------------------------------------------------------------------------------------



	CURSOR BATCH_GUID_CSR IS
	SELECT 
	MIN(SOURCE_SERVER) AS SOURCE_SERVER, 
    BATCH_GUID
	FROM (
			SELECT source_server, BATCH_GUID 
            FROM NYHIX_MFB_V2_BATCH_EVENT
			WHERE MFB_V2_PARENT_JOB_ID >= 0 
			UNION
			SELECT  'CENTRAL' as source_server, BATCH_GUID 
            FROM NYHIX_MFB_V2_DOCUMENT
			WHERE MFB_V2_PARENT_JOB_ID >= 0 
			UNION
			SELECT  'CENTRAL' as source_server, BATCH_GUID 
            FROM NYHIX_MFB_V2_ENVELOPE
			WHERE MFB_V2_PARENT_JOB_ID >= 0 
			UNION
			SELECT 'CENTRAL' as source_server, BATCH_GUID 
            FROM NYHIX_MFB_V2_MAXDAT_REPORTING
			WHERE MFB_V2_PARENT_JOB_ID >= 0 
			UNION
			SELECT source_server, BATCH_GUID 
            FROM NYHIX_MFB_V2_STATS_BATCH
			WHERE MFB_V2_PARENT_JOB_ID >= 0 
			UNION
			SELECT source_server, BATCH_GUID 
            FROM NYHIX_MFB_V2_STATS_BATCH_MODULE
			WHERE MFB_V2_PARENT_JOB_ID >= 0 
			UNION
			SELECT source_server, BATCH_GUID 
            FROM NYHIX_MFB_V2_STATS_FORM_TYPE
			WHERE MFB_V2_PARENT_JOB_ID >= 0 
		)
        GROUP BY BATCH_GUID
        ORDER BY BATCH_GUID, SOURCE_SERVER;

	GV_SRC_REC_SUMMARY          NYHIX_MFB_V2_BATCH_SUMMARY%ROWTYPE;
	GV_TARGET_REC       		NYHIX_MFB_V2_BATCH_SUMMARY%ROWTYPE;

	GV_SRC_REC_EVENT    					NYHIX_MFB_V2_BATCH_EVENT%ROWTYPE;
	GV_SRC_REC_MAXDAT_REPORTING				NYHIX_MFB_V2_MAXDAT_REPORTING%ROWTYPE;
	GV_SRC_REC_DOCUMENT						NYHIX_MFB_V2_DOCUMENT%ROWTYPE;
	GV_SRC_REC_ENVELOPE						NYHIX_MFB_V2_ENVELOPE%ROWTYPE;
	GV_SRC_REC_STATS_BATCH					NYHIX_MFB_V2_STATS_BATCH%ROWTYPE;
	GV_SRC_REC_STATS_BATCH_MODULE			NYHIX_MFB_V2_STATS_BATCH_MODULE%ROWTYPE; 
	GV_SRC_REC_STATS_BATCH_MODULE_LAUNCH	NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH%ROWTYPE;
	GV_SRC_REC_STATS_FORM_TYPE				NYHIX_MFB_V2_STATS_FORM_TYPE%ROWTYPE; 


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

		GV_JOB_ID 	:= SEQ_JOB_ID.NEXTVAL;

        GV_JOB_NAME	:= GV_PROCESS_NAME||' Parent ID: '||GV_PARENT_JOB_ID||' - '||'Step NYHIX_MFB_V2_BATCH_SUMMARY';			

		Insert_Corp_ETL_Job_Statistics;


		IF (BATCH_GUID_CSR%ISOPEN)
		THEN
			CLOSE BATCH_GUID_CSR;
		END IF;

		OPEN BATCH_GUID_CSR;

		LOOP  -- Main "Driving" Loop

			FETCH BATCH_GUID_CSR INTO GV_SOURCE_SERVER, GV_BATCH_GUID_ID;

			EXIT WHEN BATCH_GUID_CSR%NOTFOUND;

			GV_RECORD_COUNT := GV_RECORD_COUNT+1;

--			DBMS_OUTPUT.PUT_LINE('Processing BATCH_GUID: '||GV_BATCH_GUID_ID);

			GV_SRC_REC_SUMMARY := NULL;
			GV_TARGET_REC := NULL;

			Extract_Target(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);
			Extract_Stats_Batch(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);
            -- THE EXTRACTS MUST BE IN THE PROPER ORDER
            -- ALL EXTRAXTS MAY NOT BE NEEDED
            Extract_Batch_Event(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);
            Extract_Document(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);
            Extract_Envelope(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);
            Extract_Stats_Batch_Module(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);
            Extract_Maxdat_Reporting(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);
            Extract_Stats_Form_Type(GV_SOURCE_SERVER, GV_BATCH_GUID_ID);

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
--		DBMS_OUTPUT.PUT_LINE('GV_RECORD_INSERTED_COUNT: '||GV_RECORD_INSERTED_COUNT);
--		DBMS_OUTPUT.PUT_LINE('GV_RECORD_UPDATED_COUNT: '||GV_RECORD_UPDATED_COUNT);

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

/*			DBMS_OUTPUT.PUT_LINE('Main Cursor failure for '||
				'SRC_DB_RECORD_NUM: '||JOIN_REC.SRC_EXTERNAL_BATCH_ID
				||' TARGET_DB_RECORD_NUM: '||JOIN_REC.TARGET_EXTERNAL_BATCH_ID
				||'SQLCODE '||GV_ERROR_CODE
				||' '||GV_ERROR_MESSAGE);
*/
			ROLLBACK;

			RAISE;

END Load_BATCH_SUMMARY;

-----------------------------------------------------

-----------------------------------------------------
PROCEDURE UPDATE_BATCH_SUMMARY IS
PRAGMA AUTONOMOUS_TRANSACTION;
-----------------------------------------------------

	BEGIN

    NULL;

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
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.STG_DONE_DATE),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.STG_DONE_DATE),'?')					-- 	64	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.STG_EXTRACT_DATE),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.STG_EXTRACT_DATE),'?')				-- 	65	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.STG_LAST_UPDATE_DATE),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.STG_LAST_UPDATE_DATE),'?')			-- 	66	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.STG_PROCESSED_DATE),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.STG_PROCESSED_DATE),'?')				-- 	67	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.UPDATED),'?')	  					<>  	NVL(TO_CHAR(GV_TARGET_REC.UPDATED),'?')							-- 	68	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT),'?')	  		<>  	NVL(TO_CHAR(GV_TARGET_REC.BATCH_COMPLETE_DT),'?')				-- 	69	DATE
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CURRENT_BATCH_MODULE_ID),'?')	  	<>  	NVL(TO_CHAR(GV_TARGET_REC.CURRENT_BATCH_MODULE_ID),'?')			-- 	70	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.GWF_QC_REQUIRED),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.GWF_QC_REQUIRED),'?')					-- 	71	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CURRENT_STEP),'?')	  				<>  	NVL(TO_CHAR(GV_TARGET_REC.CURRENT_STEP),'?')					-- 	72	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.CEJS_JOB_ID),'?')	  				<>  	NVL(TO_CHAR(GV_TARGET_REC.CEJS_JOB_ID),'?')						-- 	73	NUMBER
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA_USER_ID),'?')	<>  	NVL(TO_CHAR(GV_TARGET_REC.ASPB_VALIDATE_DATA_USER_ID),'?')		-- 	74	VARCHAR2
       OR NVL(TO_CHAR(GV_SRC_REC_SUMMARY.FAX_BATCH_SOURCE),'?')	  			<>  	NVL(TO_CHAR(GV_TARGET_REC.FAX_BATCH_SOURCE),'?')				-- 	75	VARCHAR2
---------	   
	THEN
		UPDATE NYHIX_MFB_V2_BATCH_SUMMARY
		SET
			MFB_V2_CREATE_DATE 			= GV_SRC_REC_SUMMARY.MFB_V2_CREATE_DATE,    		--	1
			MFB_V2_UPDATE_DATE 			= GV_SRC_REC_SUMMARY.MFB_V2_UPDATE_DATE,   	 		--	2
			BATCH_GUID 					= GV_SRC_REC_SUMMARY.BATCH_GUID,    				--	3
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
			STG_DONE_DATE 				= GV_SRC_REC_SUMMARY.STG_DONE_DATE,    				--	64
			STG_EXTRACT_DATE 			= GV_SRC_REC_SUMMARY.STG_EXTRACT_DATE,    			--	65
			STG_LAST_UPDATE_DATE 		= GV_SRC_REC_SUMMARY.STG_LAST_UPDATE_DATE,    		--	66
			STG_PROCESSED_DATE 			= GV_SRC_REC_SUMMARY.STG_PROCESSED_DATE,    		--	67
			UPDATED 					= GV_SRC_REC_SUMMARY.UPDATED,    					--	68
			BATCH_COMPLETE_DT 			= GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT,    			--	69
			CURRENT_BATCH_MODULE_ID 	= GV_SRC_REC_SUMMARY.CURRENT_BATCH_MODULE_ID,    	--	70
			GWF_QC_REQUIRED 			= GV_SRC_REC_SUMMARY.GWF_QC_REQUIRED,    			--	71
			CURRENT_STEP 				= GV_SRC_REC_SUMMARY.CURRENT_STEP,    				--	72
			CEJS_JOB_ID 				= GV_SRC_REC_SUMMARY.CEJS_JOB_ID,    				--	73
			ASPB_VALIDATE_DATA_USER_ID 	= GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA_USER_ID,    --	74
			FAX_BATCH_SOURCE 			= GV_SRC_REC_SUMMARY.FAX_BATCH_SOURCE,    			--	75
			MFB_V2_PARENT_JOB_ID 		= GV_PARENT_JOB_ID    						--	76		
		WHERE ROWID = GV_TARGET_ROWID; 

	if GV_SRC_REC_SUMMARY.batch_guid = '{0015d100-97cf-4a3e-bf8f-5cdd04cf789e}'
	then 
		dbms_output.put_line('Pre GV_SRC_REC_SUMMARY.create_dt '||GV_SRC_REC_SUMMARY.create_dt);
		dbms_output.put_line('Pre GV_TARGET_REC.CREATE_DT '||GV_TARGET_REC.CREATE_DT);
		dbms_output.put_line('Pre GV_SRC_REC_SUMMARY.complete_DT '||GV_SRC_REC_SUMMARY.complete_dt);
		dbms_output.put_line('Pre GV_TARGET_REC.complete_DT '||GV_TARGET_REC.complete_DT);
	end if;	

    END IF;

    COMMIT;

	if GV_SRC_REC_SUMMARY.batch_guid = '{0015d100-97cf-4a3e-bf8f-5cdd04cf789e}'
	then 
		dbms_output.put_line('POST GV_SRC_REC_SUMMARY.create_dt '||GV_SRC_REC_SUMMARY.create_dt);
		dbms_output.put_line('POST GV_TARGET_REC.CREATE_DT '||GV_TARGET_REC.CREATE_DT);
		dbms_output.put_line('POST GV_SRC_REC_SUMMARY.complete_DT '||GV_SRC_REC_SUMMARY.complete_dt);
		dbms_output.put_line('POST GV_TARGET_REC.complete_DT '||GV_TARGET_REC.complete_DT);
	end if;	

	EXCEPTION

        WHEN OTHERS THEN

/*        DBMS_OUTPUT.PUT_LINE('UPDATE FAILURE '
            ||JOIN_REC.SRC_BATCH_GUID||' '
            ||JOIN_REC.SRC_rowid||' '
            ||JOIN_REC.target_rowid);
*/
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
        STG_DONE_DATE,
        STG_EXTRACT_DATE,
        STG_LAST_UPDATE_DATE,
        STG_PROCESSED_DATE,
        UPDATED,
        BATCH_COMPLETE_DT,
        CURRENT_BATCH_MODULE_ID,
        GWF_QC_REQUIRED,
        CURRENT_STEP,
        CEJS_JOB_ID,
        ASPB_VALIDATE_DATA_USER_ID,
        FAX_BATCH_SOURCE,
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
        NVL(GV_SRC_REC_SUMMARY.STG_DONE_DATE,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.STG_EXTRACT_DATE,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.STG_LAST_UPDATE_DATE,TO_DATE(NULL)),
        NVL(GV_SRC_REC_SUMMARY.STG_PROCESSED_DATE,TO_DATE(NULL)),
        GV_SRC_REC_SUMMARY.UPDATED,
        NVL(GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT,TO_DATE(NULL)),
        GV_SRC_REC_SUMMARY.CURRENT_BATCH_MODULE_ID,
        GV_SRC_REC_SUMMARY.GWF_QC_REQUIRED,
        GV_SRC_REC_SUMMARY.CURRENT_STEP,
        NVL(GV_SRC_REC_SUMMARY.CEJS_JOB_ID,0),
        GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA_USER_ID,
        GV_SRC_REC_SUMMARY.FAX_BATCH_SOURCE,
        NVL(GV_PARENT_JOB_ID,-999)
	);

   -- ROLLBACK;

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

/*        DBMS_OUTPUT.PUT_LINE('DELETE FAILURE'||' '
            ||JOIN_REC.SRC_rowid||' '
            ||JOIN_REC.target_rowid);
*/
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


/*			INSERT INTO MAXDAT.NYHIX_MFB_V2_STATS_BATCH_OLTP_ERR
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

        COMMIT;
*/



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
		GV_TARGET_REC := NULL;

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
		NVL(ASED_CREATE_PDF,TO_DATE(NULL))
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
		GV_TARGET_REC.ASED_CREATE_PDF
	FROM NYHIX_MFB_V2_BATCH_SUMMARY
	WHERE BATCH_GUID = p_Batch_GUID;

	-- BECAUSE THE GV_SRC_REC IS POPULATED FROM MULTIPLE TABLES
	-- AND SOME OF THE TABLES MAY NOT HAVE THE SPECIFIC BATCH_GUID
	-- THE GV_TARGET_REC IS LOADED INTO THE GV_SRC_REC

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
			COUNT(DISTINCT batch_doc_count)	    AS BATCH_PAGE_COUNT,
			COUNT(distinct dcn )				AS BATCH_DOC_COUNT,
			COUNT(distinct ecn )			    AS BATCH_ENVELOPE_COUNT,
		--	MIN(CLASSIFICATION_DT)				AS CLASSIFICATION_DT,
		--	MIN(RECOGNITION_DT)					AS RECOGNITION_DT,
		--	MIN(VALIDATION_DaTe)				AS VALIDATION_DT,
			MAX(FAX_BATCH_SOURCE)				AS FAX_BATCH_SOURCE
		INTO 
			GV_SRC_REC_SUMMARY.BATCH_PAGE_COUNT,
			GV_SRC_REC_SUMMARY.BATCH_DOC_COUNT,
			GV_SRC_REC_SUMMARY.BATCH_ENVELOPE_COUNT,
		--	GV_SRC_REC_SUMMARY.CLASSIFICATION_DT,
		--	GV_SRC_REC_SUMMARY.RECOGNITION_DT,
		--	GV_SRC_REC_SUMMARY.VALIDATION_DATE,
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
		PRIORITY
    from NYHIX_MFB_V2_BATCH_EVENT
	where batch_guid = p_Batch_GUID
    order by nvl(END_DATE_TIME,sysdate), START_DATE_TIME;

	--------------------------------------	
	BEGIN

		IF (BATCH_EVENT_CSR%ISOPEN)
		THEN
			CLOSE BATCH_EVENT_CSR;
		END IF;

		OPEN BATCH_EVENT_CSR;

		LOOP  -- 

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
				GV_SRC_REC_EVENT.PRIORITY;

			GV_EVENT_COUNT	:= 	GV_EVENT_COUNT+1;

			EXIT WHEN BATCH_EVENT_CSR%NOTFOUND;

--			DBMS_OUTPUT.PUT_LINE('Processing BATCH_EVENT_CSR: '||GV_BATCH_GUID_ID);

-- UPD_001 BATCH_PRIORITY

IF ( GV_SRC_REC_SUMMARY.BATCH_PRIORITY IS NULL
OR GV_SRC_REC_SUMMARY.BATCH_PRIORITY  = 0 )
AND GV_SRC_REC_EVENT.PRIORITY IS NOT NULL
AND GV_SRC_REC_EVENT.MODULENAME = 'Scan' -- '${SCAN_MODULE_NAME}'
THEN 
	GV_SRC_REC_SUMMARY.BATCH_PRIORITY := GV_SRC_REC_EVENT.PRIORITY;
END IF;

-- UPD1_BATCH_Pages_Scanned Note Pages_scanned is a number 

IF GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG IS NULL
 THEN GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG := 'N';
END IF; 

IF NVL(GV_SRC_REC_EVENT.PAGES_SCANNED,'0') <> 0
AND NVL(GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG,'N') = 'N' 
THEN 
    GV_SRC_REC_SUMMARY.PAGES_SCANNED_FLAG := 'Y';
END IF;	

-- UPD1_BATCH_Pages_Deleted
IF GV_SRC_REC_SUMMARY.PAGES_DELETED_FLAG IS NULL
THEN GV_SRC_REC_SUMMARY.PAGES_DELETED_FLAG := 'N';
END IF;

IF NVL(GV_SRC_REC_EVENT.PAGES_DELETED,'0') <> 0
AND NVL(GV_SRC_REC_SUMMARY.PAGES_DELETED_FLAG,'N') = 'N' 
THEN GV_SRC_REC_SUMMARY.PAGES_DELETED_FLAG := 'Y';
END IF;

-- UPD1_BATCH_DOCS_Created
IF GV_SRC_REC_SUMMARY.DOCS_CREATED_FLAG IS NULL
THEN GV_SRC_REC_SUMMARY.DOCS_CREATED_FLAG := 'N';
END IF;

IF NVL(GV_SRC_REC_EVENT.DOCUMENTS_CREATED,'0') <> '0'
AND NVL(GV_SRC_REC_SUMMARY.DOCS_CREATED_FLAG,'N') = 'N'
THEN GV_SRC_REC_SUMMARY.DOCS_CREATED_FLAG := 'Y';
END IF;	

-- UPD1_BATCH_DOCS_DELETED
IF GV_SRC_REC_SUMMARY.DOCS_DELETED_FLAG IS NULL
THEN GV_SRC_REC_SUMMARY.DOCS_DELETED_FLAG := 'N';
END IF;

IF NVL(GV_SRC_REC_EVENT.DOCUMENTS_DELETED,'0') <> '0'
AND NVL(GV_SRC_REC_SUMMARY.DOCS_DELETED_FLAG,'N') = 'N'
THEN GV_SRC_REC_SUMMARY.DOCS_DELETED_FLAG := 'Y';
END IF;	

-- UPD1_BATCH_PAGES_REPLACED
IF GV_SRC_REC_SUMMARY.PAGES_REPLACED_FLAG IS NULL
THEN GV_SRC_REC_SUMMARY.PAGES_REPLACED_FLAG := 'N';
END IF;

IF NVL(GV_SRC_REC_EVENT.PAGES_REPLACED,'0') <> 0
AND NVL(GV_SRC_REC_SUMMARY.PAGES_REPLACED_FLAG,'N') = 'N' 
THEN GV_SRC_REC_SUMMARY.PAGES_REPLACED_FLAG := 'Y';
END IF;

-----------------------------------------------------------
-----------------------------------------------------------

-- UPD1_600 - SET BATCH_COMPLETE_DATE
IF gv_src_rec_event.MODULENAME = 'Export' --<< '${EXPORT_MODULE_NAME}'
and gv_src_rec_event.BATCH_STATUS = 64
and GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT is NULL
and gv_src_rec_event.END_DATE_TIME is not NULL
and ( gv_src_rec_event.END_DATE_TIME > GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT
    OR GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT IS NULL )
then GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT := gv_src_rec_event.END_DATE_TIME;
end if;

-- UPD1_610 - SET CURRENT_BATCH_MODULE_ID ( FOR INCOMPLETE BATCHES )
IF GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT is NULL 
AND gv_src_rec_event.MODULENAME <> 'Scan' --<< '${EXPORT_MODULE_NAME}'
and gv_src_rec_event.BATCH_STATUS = 64
and gv_src_rec_event.END_DATE_TIME is not NULL
and ( gv_src_rec_event.END_DATE_TIME > GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT
    OR GV_SRC_REC_SUMMARY.BATCH_COMPLETE_DT IS NULL )
then GV_SRC_REC_SUMMARY.CURRENT_BATCH_MODULE_ID := gv_src_rec_event.batch_module_id;
end if;

-- UPD2_010 
-- IF GV_TARGET_REC.CANCEL_DT IS NULL
-- AND GV_SRC_REC_SUMMARY.CANCEL_DT IS NULL
IF gv_src_rec_event.MODULENAME= 'Scan' --<<'${SCAN_MODULE_NAME}'
AND gv_src_rec_event.BATCH_STATUS=64
AND gv_src_rec_event.START_DATE_TIME IS NOT NULL
AND ( gv_src_rec_event.START_DATE_TIME <= GV_SRC_REC_SUMMARY.ASSD_SCAN_BATCH
     OR GV_SRC_REC_SUMMARY.ASSD_SCAN_BATCH IS NULL )
THEN
	GV_SRC_REC_SUMMARY.ASSD_SCAN_BATCH := gv_src_rec_event.START_DATE_TIME;
	gv_src_rec_summary.ASED_SCAN_BATCH 	:= gv_src_rec_event.START_DATE_TIME;
	gv_src_rec_summary.ASPB_SCAN_BATCH 	:= gv_src_rec_event.USER_NAME; 
	gv_src_rec_summary.ASF_SCAN_BATCH	:= 'Y';
END IF;

-------------------------------------------------------------------------------
-- UPD3_010
-------------------------------------------------------------------------------
IF GV_SRC_REC_SUMMARY.GWF_QC_REQUIRED IS NULL
THEN	
	GV_SRC_REC_SUMMARY.GWF_QC_REQUIRED := 'N';
END IF;	


IF 1=1
--AND GV_TARGET_REC.CANCEL_DT IS NULL
--AND GV_SRC_REC_SUMMARY.CANCEL_DT IS NULL
--AND gv_src_rec_summary.ASSD_PERFORM_QC is null
--AND gv_src_rec_summary.ASED_SCAN_BATCH is null  -- ASSD_CLASSIFICATION
AND gv_src_rec_event.MODULENAME= 'Scan' --<<'${SCAN_MODULE_NAME}'
AND gv_src_rec_event.MODULE_CLOSE_NAME = 'Quality Control' -- '${QC_MODULE_NAME}'
AND gv_src_rec_event.START_DATE_TIME IS NOT NULL
AND gv_src_rec_event.END_DATE_TIME IS NULL
THEN 
	gv_src_rec_summary.ASSD_PERFORM_QC 	:= gv_src_rec_event.END_DATE_TIME;
	gv_src_rec_summary.GWF_QC_REQUIRED 	:= 'Y';
END IF;	


-------------------------------------------------------------------------------
-- UPD3_030
-------------------------------------------------------------------------------
 IF  1=1
 -- AND GV_SRC_REC_SUMMARY.CANCEL_DT IS NULL
 -- AND GV_SRC_REC_SUMMARY.ASED_SCAN_BATCH IS NOT NULL
 -- AND GV_SRC_REC_SUMMARY.ASSD_PERFORM_QC is null
 -- AND GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION is null
 -- AND GV_SRC_REC_SUMMARY.GWF_QC_REQUIRED = IS NULL

AND (GV_SRC_REC_SUMMARY.GWF_QC_REQUIRED <> 'N'
	 OR GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION	IS NULL
	 OR GV_SRC_REC_SUMMARY.ASSD_RECOGNITION IS NULL 
	 )
 AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
 AND GV_SRC_REC_EVENT.MODULENAME='Scan' -- '${SCAN_MODULE_NAME}'
 AND gv_src_rec_event.MODULE_CLOSE_NAME <> 'Quality Control' -- '${QC_MODULE_NAME}'
THEN
	GV_SRC_REC_SUMMARY.GWF_QC_REQUIRED := 'N';
	GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION	:=	gv_src_rec_event.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASSD_RECOGNITION		:=	gv_src_rec_event.END_DATE_TIME;
END IF;

-------------------------------------------------------------------------------
-- UPD4_010
-------------------------------------------------------------------------------
 IF GV_SRC_REC_SUMMARY.ASF_PERFORM_QC IS NULL
 THEN GV_SRC_REC_SUMMARY.ASF_PERFORM_QC := 'N';
 END IF;

 IF 1=1
 -- AND GV_SRC_REC_SUMMARY.ASED_PERFORM_QC IS NULL
 -- AND ASSD_PERFORM_QC IS NOT NULL
 AND GV_SRC_REC_EVENT.MODULENAME = 'Quality Control'	--	'${QC_MODULE_NAME}'
 AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
 AND GV_SRC_REC_EVENT.BATCH_STATUS = 64
THEN 
	GV_SRC_REC_SUMMARY.ASED_PERFORM_QC		:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASPB_PERFORM_QC		:= GV_SRC_REC_EVENT.USER_NAME;
	GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION	:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASF_PERFORM_QC		:= 'Y';
END IF;



-------------------------------------------------------------------------------
-- UPD5_010
-------------------------------------------------------------------------------

-- UPD5_010

IF GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION	IS NULL
THEN
	GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION	:= 'N';
END IF;

IF GV_TARGET_REC.CANCEL_DT IS NULL
	AND GV_SRC_REC_SUMMARY.ASSD_CLASSIFICATION IS NOT NULL
	AND GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION IS NULL
	AND GV_SRC_REC_EVENT.MODULENAME =  'KCN Server' 		--'${CLASSIFICATION_MODULE_NAME}'
	AND GV_SRC_REC_EVENT.MODULE_CLOSE_NAME = 'KTM Server'	--'${RECOGNITION_MODULE_NAME}'
	AND GV_SRC_REC_EVENT.BATCH_STATUS=64
	AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
THEN 
	GV_SRC_REC_SUMMARY.ASED_CLASSIFICATION	:= GV_SRC_REC_EVENT.END_DATE_TIME; 
	GV_SRC_REC_SUMMARY.ASSD_RECOGNITION		:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASF_CLASSIFICATION	:= 'Y';
END IF;	

--IF GV_TARGET_REC.CANCEL_DT IS NULL
--AND GV_SRC_REC_SUMMARY.CANCEL_DT IS NULL
--IF gv_src_rec_event.MODULENAME= 'Scan' --<<'${SCAN_MODULE_NAME}'
--AND gv_src_rec_event.BATCH_STATUS=64
--AND gv_src_rec_event.START_DATE_TIME IS NOT NULL
--AND gv_src_rec_event.END_DATE_TIME IS NULL
--THEN 
--	gv_src_rec_summary.ASED_SCAN_BATCH 	:= gv_src_rec_event.START_DATE_TIME;
--	gv_src_rec_summary.ASPB_SCAN_BATCH 	:= gv_src_rec_event.USER_NAME; 
--	gv_src_rec_summary.ASF_SCAN_BATCH	:= 'Y';
--END IF;	

-------------------------------------------------------------------------------
-- UPD6_010
-------------------------------------------------------------------------------
-- UPD6_010

IF GV_SRC_REC_SUMMARY.ASF_RECOGNITION	IS NULL
THEN 
	GV_SRC_REC_SUMMARY.ASF_RECOGNITION			:= 'Y';
END IF;	

 IF  GV_SRC_REC_SUMMARY.ASSD_RECOGNITION IS NOT NULL
 AND GV_SRC_REC_SUMMARY.ASED_RECOGNITION IS NULL
 AND GV_SRC_REC_EVENT.MODULENAME = 'KTM Server' --'${RECOGNITION_MODULE_NAME}'
 AND GV_SRC_REC_EVENT.BATCH_STATUS =64
 AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
THEN
	GV_SRC_REC_SUMMARY.ASED_RECOGNITION			:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASSD_VALIDATE_DATA		:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASF_RECOGNITION			:= 'Y';
END IF;

-------------------------------------------------------------------------------
-- UPD7_020 KTM VALIDATION
-------------------------------------------------------------------------------

IF NVL(GV_SRC_REC_EVENT.SML_MODULE_NAME,'?') <>  'KTM Validation'
	THEN
        NULL;
    ELSIF    
		GV_SRC_REC_SUMMARY.VALIDATION_DT IS NULL
		OR 	( GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
			AND GV_SRC_REC_EVENT.END_DATE_TIME > GV_SRC_REC_SUMMARY.VALIDATION_DT
			)
	THEN  
			GV_SRC_REC_SUMMARY.VALIDATION_DT := GV_SRC_REC_EVENT.END_DATE_TIME;
	END IF;


IF NVL(GV_SRC_REC_EVENT.SML_MODULE_NAME,'?') <> 'KTM Server'
	THEN
        NULL;
    ELSIF    
		GV_SRC_REC_SUMMARY.RECOGNITION_DT IS NULL
		OR 	( GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
			AND GV_SRC_REC_EVENT.END_DATE_TIME > GV_SRC_REC_SUMMARY.RECOGNITION_DT
			)
    THEN  
		GV_SRC_REC_SUMMARY.RECOGNITION_DT := GV_SRC_REC_EVENT.END_DATE_TIME;
	END IF;

GV_SRC_REC_SUMMARY.Classification_DT := GV_SRC_REC_SUMMARY.RECOGNITION_DT;

-- UPD7_020 KTM VALIDATION
IF GV_SRC_REC_SUMMARY.ASF_VALIDATE_DATA IS NULL
THEN
	GV_SRC_REC_SUMMARY.ASF_VALIDATE_DATA := 'N';
END IF;	

IF 1=1
 AND GV_SRC_REC_EVENT.MODULENAME = 'KTM Validation' 	-- '${VALIDATION_MODULE_NAME}'
 AND GV_SRC_REC_EVENT.BATCH_STATUS	=	64
 AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
THEN
	GV_SRC_REC_SUMMARY.ASED_VALIDATE_DATA			:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA			:= GV_SRC_REC_EVENT.USER_NAME;
	GV_SRC_REC_SUMMARY.ASPB_VALIDATE_DATA_USER_ID	:= GV_SRC_REC_EVENT.USER_ID;
	GV_SRC_REC_SUMMARY.ASSD_CREATE_PDF				:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASF_VALIDATE_DATA			:= 'Y';
	GV_SRC_REC_SUMMARY.VALIDATION_DT				:= GV_SRC_REC_EVENT.END_DATE_TIME;
END IF;

-- UPD8_010 - Create PDF
IF GV_SRC_REC_SUMMARY.ASF_CREATE_PDF IS NULL
THEN GV_SRC_REC_SUMMARY.ASF_CREATE_PDF := 'N';
END IF;

IF 1=1
-- AND CANCEL_DT IS NULL
-- AND GV_SRC_REC_SUMMARY.ASSD_CREATE_PDF IS NOT NULL
-- AND GV_SRC_REC_SUMMARY.ASED_CREATE_PDF IS NULL
 AND GV_SRC_REC_EVENT.MODULENAME = 'PDF Generator' --'${PDF_MODULE_NAME}'
 AND GV_SRC_REC_EVENT.BATCH_STATUS=64
 AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
THEN
	GV_SRC_REC_SUMMARY.ASED_CREATE_PDF 			:=  GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASSD_POPULATE_REPORTS 	:=  GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASF_CREATE_PDF			:= 'Y';
END IF;

-- UPD9_010 - ASED_POPULATE_REPORTS

IF GV_SRC_REC_SUMMARY.ASF_POPULATE_REPORTS IS NULL
THEN
	GV_SRC_REC_SUMMARY.ASF_POPULATE_REPORTS := 'N';
END IF;	

IF 1=1
-- AND ASSD_POPULATE_REPORTS IS NOT NULL
-- AND ASED_POPULATE_REPORTS IS NULL
 AND GV_SRC_REC_EVENT.MODULENAME   = 'Export' --${EXPORT_MODULE_NAME}'
 AND GV_SRC_REC_EVENT.BATCH_STATUS = 64
 AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
THEN
	GV_SRC_REC_SUMMARY.ASED_POPULATE_REPORTS 	:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASSD_RELEASE_DMS			:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASF_POPULATE_REPORTS		:= 'Y';
END IF;


-- UPD11_010 - SET BATCH_DELETED

IF  GV_SRC_REC_SUMMARY.BATCH_DELETED IS NULL
THEN GV_SRC_REC_SUMMARY.BATCH_DELETED := 'N';
END IF;

--?????  {0015d100-97cf-4a3e-bf8f-5cdd04cf789e}
IF GV_SRC_REC_SUMMARY.BATCH_GUID =  '{0015d100-97cf-4a3e-bf8f-5cdd04cf789e}'
OR GV_SRC_REC_EVENT.BATCH_GUID =  '{0015d100-97cf-4a3e-bf8f-5cdd04cf789e}'
THEN
DBMS_OUTPUT.PUT_LINE('BEFORE');
DBMS_OUTPUT.PUT_LINE('GV_SRC_REC_SUMMARY.CANCEL_DT :'||GV_SRC_REC_SUMMARY.CANCEL_DT);
DBMS_OUTPUT.PUT_LINE('GV_SRC_REC_EVENT.DELETED :'||GV_SRC_REC_EVENT.DELETED);
DBMS_OUTPUT.PUT_LINE('GV_SRC_REC_EVENT.MODULENAME : '||GV_SRC_REC_EVENT.MODULENAME);
END IF;
--?????


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
	GV_SRC_REC_SUMMARY.CANCEL_DT					:= GV_SRC_REC_EVENT.END_DATE_TIME;
END IF;

--?????
IF GV_SRC_REC_SUMMARY.BATCH_GUID =  '{0015d100-97cf-4a3e-bf8f-5cdd04cf789e}'
OR GV_SRC_REC_EVENT.BATCH_GUID =  '{0015d100-97cf-4a3e-bf8f-5cdd04cf789e}'
THEN
DBMS_OUTPUT.PUT_LINE('AFTER');
DBMS_OUTPUT.PUT_LINE('GV_SRC_REC_SUMMARY.CANCEL_DT :'||GV_SRC_REC_SUMMARY.CANCEL_DT);
DBMS_OUTPUT.PUT_LINE('GV_SRC_REC_EVENT.DELETED :'||GV_SRC_REC_EVENT.DELETED);
DBMS_OUTPUT.PUT_LINE('GV_SRC_REC_EVENT.MODULENAME : '||GV_SRC_REC_EVENT.MODULENAME);
END IF;
--?????


-- UPD10_010

IF GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS IS NULL
THEN 
	GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS := 'N';
END IF;

IF 	GV_SRC_REC_EVENT.MODULENAME  = 'Export' --'${EXPORT_MODULE_NAME}'
AND GV_SRC_REC_SUMMARY.CANCEL_DT IS NULL
AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
AND GV_TARGET_REC.ASED_RELEASE_DMS IS NULL
AND GV_SRC_REC_EVENT.BATCH_STATUS=64
AND GV_SRC_REC_EVENT.END_DATE_TIME IS NOT NULL
THEN 
	GV_SRC_REC_SUMMARY.ASED_RELEASE_DMS		:= GV_SRC_REC_EVENT.END_DATE_TIME;
	GV_SRC_REC_SUMMARY.ASF_RELEASE_DMS		:= 'Y'; --	YES_FLAG
	GV_SRC_REC_SUMMARY.COMPLETE_DT			:= GV_SRC_REC_EVENT.END_DATE_TIME;	--ASED_RELEASE_DMS
	GV_SRC_REC_SUMMARY.INSTANCE_STATUS		:= 'Complete'; 
	GV_SRC_REC_SUMMARY.INSTANCE_STATUS_DT	:= GV_SRC_REC_EVENT.END_DATE_TIME;	--ASED_RELEASE_DMS
END IF;



-----------------------------------------------
-----------------------------------------------

		END LOOP;

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



	End;
	--------------------------------------	

END NYHIX_MFB_V2_BATCH_SUMMARY_PKG;
/
show errors

grant execute on maxdat.NYHIX_MFB_V2_BATCH_SUMMARY_PKG to maxdat_read_only;

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
create or replace Package        NYHIX_MFB_V2_DOCUMENT_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


    Procedure Insert_DOCUMENT;
    Procedure Update_DOCUMENT;
    Procedure Delete_DOCUMENT;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_DOCUMENT ( p_job_id number default 0);

END NYHIX_MFB_V2_DOCUMENT_PKG;
/
show errors

create or replace PACKAGE BODY        NYHIX_MFB_V2_DOCUMENT_PKG AS

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

        GV_JOB_NAME	:= GV_PROCESS_NAME||' Parent ID: '||GV_PARENT_JOB_ID||' - '||'Step NYHIX_MFB_V2_DOCUMENT';			

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
show errors

grant execute on maxdat.NYHIX_MFB_V2_DOCUMENT_PKG to maxdat_read_only;


-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
create or replace Package        NYHIX_MFB_V2_ENVELOPE_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


    Procedure Insert_ENVELOPE;
    Procedure Update_ENVELOPE;
    Procedure Delete_ENVELOPE;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_ENVELOPE ( p_job_id number default 0);

END NYHIX_MFB_V2_ENVELOPE_PKG;
/
show errors


create or replace PACKAGE BODY        NYHIX_MFB_V2_ENVELOPE_PKG AS

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

        GV_JOB_NAME	:= GV_PROCESS_NAME||' Parent ID: '||GV_PARENT_JOB_ID||' - '||'Step NYHIX_MFB_V2_ENVELOPE';			

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
show errors

grant execute on maxdat.NYHIX_MFB_V2_ENVELOPE_PKG to maxdat_read_only;



-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

create or replace Package        NYHIX_MFB_V2_MAXDAT_REPORTING_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


    Procedure Insert_MAXDAT_REPORTING;
    Procedure Update_MAXDAT_REPORTING;
    Procedure Delete_MAXDAT_REPORTING;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_MAXDAT_REPORTING ( p_job_id number default 0);

END NYHIX_MFB_V2_MAXDAT_REPORTING_PKG;
/
show errors


create or replace PACKAGE BODY        NYHIX_MFB_V2_MAXDAT_REPORTING_PKG AS

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

        GV_JOB_NAME	:= GV_PROCESS_NAME||' Parent ID: '||GV_PARENT_JOB_ID||' - '||'Step NYHIX_MFB_V2_MAXDAT_REPORTING';			

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
show errors

grant execute on maxdat.NYHIX_MFB_V2_MAXDAT_REPORTING_PKG to maxdat_read_only;


-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

create or replace Package        NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


    Procedure Insert_STATS_BATCH_MODULE_LAUNCH;
    Procedure Update_STATS_BATCH_MODULE_LAUNCH;
    Procedure Delete_STATS_BATCH_MODULE_LAUNCH;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_STATS_BATCH_MODULE_LAUNCH(p_job_id number default 0);

END NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG;
/
show errors


create or replace PACKAGE BODY        NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG AS

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

        GV_JOB_NAME	:= SUBSTR(GV_PROCESS_NAME||' Parent ID: '||GV_PARENT_JOB_ID||' - '||'Step NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH',1,80);			

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
show errors

grant execute on maxdat.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PKG to maxdat_read_only;


-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

create or replace Package        NYHIX_MFB_V2_STATS_BATCH_MODULE_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


    Procedure Insert_STATS_BATCH_MODULE;
    Procedure Update_STATS_BATCH_MODULE;
    Procedure Delete_STATS_BATCH_MODULE;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_STATS_BATCH_MODULE(p_job_id number default 0);

END NYHIX_MFB_V2_STATS_BATCH_MODULE_PKG;
/
show errors


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
show errors

grant execute on maxdat.NYHIX_MFB_V2_STATS_BATCH_MODULE_PKG to maxdat_read_only;

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

create or replace Package        NYHIX_MFB_V2_STATS_BATCH_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


    Procedure Insert_STATS_BATCH;
    Procedure Update_STATS_BATCH;
    Procedure Delete_STATS_BATCH;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_STATS_BATCH ( p_job_id number default 0);

END NYHIX_MFB_V2_STATS_BATCH_PKG;
/
show errors


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
show errors

grant execute on maxdat.NYHIX_MFB_V2_STATS_BATCH_PKG to maxdat_read_only;

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

create or replace Package NYHIX_MFB_V2_STATS_FORM_TYPE_PKG AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


    Procedure Insert_STATS_FORM_TYPE;
    Procedure Update_STATS_FORM_TYPE;
    Procedure Delete_STATS_FORM_TYPE;
	Procedure Post_Error;
	Procedure Insert_Corp_ETL_Job_Statistics;
	Procedure Update_Corp_ETL_Job_Statistics;
	Procedure Load_STATS_FORM_TYPE(p_job_id number default 0);

END NYHIX_MFB_V2_STATS_FORM_TYPE_PKG;
/
show errors


create or replace PACKAGE BODY        NYHIX_MFB_V2_STATS_FORM_TYPE_PKG AS

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

        GV_JOB_NAME	:= GV_PROCESS_NAME||' Parent ID: '||GV_PARENT_JOB_ID||' - '||'Step NYHIX_MFB_V2_STATS_FORM_TYPE';			

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
show errors

grant execute on maxdat.NYHIX_MFB_V2_STATS_FORM_TYPE_PKG to maxdat_read_only;
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

--SET TIMING ON
--SET SERVEROUTPUT ON SIZE 40000
--EXEC NYHIX_MFB_V2_BATCH_EVENT_PKG.LOAD_EVENTS(0);
--EXEC NYHIX_MFB_V2_BATCH_SUMMARY_PKG.Load_BATCH_SUMMARY (0);