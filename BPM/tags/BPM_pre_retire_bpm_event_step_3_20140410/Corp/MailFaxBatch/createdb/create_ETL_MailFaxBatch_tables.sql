declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_BATCH_ARS_OLTP';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_BATCH_ARS_OLTP cascade constraints';
   end if;
end;
/
create table CORP_ETL_MFB_BATCH_ARS_OLTP(
 BATCH_GUID VARCHAR2(38) NOT NULL,
 BATCH_TYPE varchar2(255) NULL,
 CREATE_DT DATE NOT NULL,
 BATCH_PAGE_COUNT NUMBER NOT NULL,
 BATCH_DOC_COUNT NUMBER NOT NULL,
 BATCH_ENVELOPE_COUNT NUMBER NOT NULL,
 CLASSIFICATION_DT DATE NULL,
 RECOGNITION_DT DATE NULL,
 VALIDATION_DT DATE NULL,
 STG_EXTRACT_DATE DATE DEFAULT SYSDATE NOT NULL)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_BATCH_ARS_OLTP.BATCH_GUID is 'Unique identifier for the batch in KOFAX.';
comment on column CORP_ETL_MFB_BATCH_ARS_OLTP.BATCH_TYPE is 'The type of batch.';
comment on column CORP_ETL_MFB_BATCH_ARS_OLTP.CREATE_DT is 'The date that the batch is initially scanned.';
comment on column CORP_ETL_MFB_BATCH_ARS_OLTP.BATCH_PAGE_COUNT is 'The total number of pages that are scanned in a single batch.';
comment on column CORP_ETL_MFB_BATCH_ARS_OLTP.BATCH_DOC_COUNT is 'Displays the total number of documents scanned in the batch.   The value is set based on the number of document separator sheets read through KOFAX.';
comment on column CORP_ETL_MFB_BATCH_ARS_OLTP.BATCH_ENVELOPE_COUNT is 'The total number of envelopes in the batch.  This number is entered manually at the beginning of the scanning process.';
comment on column CORP_ETL_MFB_BATCH_ARS_OLTP.CLASSIFICATION_DT is 'Date and time that indicates when the document was classified.';
comment on column CORP_ETL_MFB_BATCH_ARS_OLTP.RECOGNITION_DT is 'Date and time that indicates when the document completed Recognition. ';
comment on column CORP_ETL_MFB_BATCH_ARS_OLTP.VALIDATION_DT is 'Date and time that indicates when the document was validated. ';

create or replace public synonym CORP_ETL_MFB_BATCH_ARS_OLTP for MAXDAT.CORP_ETL_MFB_BATCH_ARS_OLTP;
grant select on CORP_ETL_MFB_BATCH_ARS_OLTP to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_BATCH_ARS_STG';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_BATCH_ARS_STG cascade constraints';
   end if;
end;
/
create table CORP_ETL_MFB_BATCH_ARS_STG(
 CEMFBAB_ID NUMBER NOT NULL,
 BATCH_GUID VARCHAR2(38) NOT NULL,
 BATCH_TYPE varchar2(255) NULL,
 CREATE_DT DATE NOT NULL,
 BATCH_PAGE_COUNT NUMBER NOT NULL,
 BATCH_DOC_COUNT NUMBER NOT NULL,
 BATCH_ENVELOPE_COUNT NUMBER NOT NULL,
 CLASSIFICATION_DT DATE NULL,
 RECOGNITION_DT DATE NULL,
 VALIDATION_DT DATE NULL,
 STG_EXTRACT_DATE DATE NOT NULL,
 STG_LAST_UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
 STG_PROCESSED_DATE DATE NULL,
 INSERT_UPDATE VARCHAR2(1) NULL,
 STG_INSERT_JOB_ID NUMBER NOT NULL)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


comment on column CORP_ETL_MFB_BATCH_ARS_STG.CEMFBAB_ID is 'Sequence.';
comment on column CORP_ETL_MFB_BATCH_ARS_STG.BATCH_GUID is 'Unique identifier for the batch in KOFAX.';
comment on column CORP_ETL_MFB_BATCH_ARS_STG.BATCH_TYPE is 'The type of batch.';
comment on column CORP_ETL_MFB_BATCH_ARS_STG.CREATE_DT is 'The date that the batch is initially scanned.';
comment on column CORP_ETL_MFB_BATCH_ARS_STG.BATCH_PAGE_COUNT is 'The total number of pages that are scanned in a single batch.';
comment on column CORP_ETL_MFB_BATCH_ARS_STG.BATCH_DOC_COUNT is 'Displays the total number of documents scanned in the batch.   The value is set based on the number of document separator sheets read through KOFAX.';
comment on column CORP_ETL_MFB_BATCH_ARS_STG.BATCH_ENVELOPE_COUNT is 'The total number of envelopes in the batch.  This number is entered manually at the beginning of the scanning process.';
comment on column CORP_ETL_MFB_BATCH_ARS_STG.CLASSIFICATION_DT is 'Date and time that indicates when the document was classified.';
comment on column CORP_ETL_MFB_BATCH_ARS_STG.RECOGNITION_DT is 'Date and time that indicates when the document completed Recognition. ';
comment on column CORP_ETL_MFB_BATCH_ARS_STG.VALIDATION_DT is 'Date and time that indicates when the document was validated. ';
comment on column CORP_ETL_MFB_BATCH_ARS_STG.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_BATCH_ARS_STG.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_BATCH_ARS_STG.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';


alter table CORP_ETL_MFB_BATCH_ARS_STG  add primary key (CEMFBAB_ID) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

create or replace public synonym CORP_ETL_MFB_BATCH_ARS_STG for MAXDAT.CORP_ETL_MFB_BATCH_ARS_STG;
grant select on CORP_ETL_MFB_BATCH_ARS_STG to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_BATCH_OLTP';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_BATCH_OLTP cascade constraints';
   end if;
end;
/
create table CORP_ETL_MFB_BATCH_OLTP(
  BATCH_GUID VARCHAR2(38) NOT NULL,
  BATCH_ID NUMBER NOT NULL,
  BATCH_NAME VARCHAR2(255) NOT NULL,
  CREATION_STATION_ID VARCHAR2(32) NOT NULL,
  CREATION_USER_NAME VARCHAR2(80) NULL,
  CREATION_USER_ID VARCHAR2(50) NOT NULL,
  BATCH_CLASS VARCHAR2(32) NOT NULL,
  BATCH_CLASS_DES VARCHAR2(80) NULL,
  BATCH_TYPE VARCHAR2(38) NULL,
  CREATE_DT DATE NOT NULL,
  COMPLETE_DT DATE NULL,
  INSTANCE_STATUS VARCHAR2(30) NOT NULL,
  INSTANCE_STATUS_DT DATE NOT NULL,
  BATCH_PAGE_COUNT NUMBER NULL,
  BATCH_DOC_COUNT NUMBER NULL,
  BATCH_ENVELOPE_COUNT NUMBER NULL,
  CANCEL_DT DATE NULL,
  CANCEL_BY VARCHAR2(80) NULL,
  CANCEL_REASON VARCHAR2(80) NULL,
  CANCEL_METHOD VARCHAR2(80) NULL,
  ASF_SCAN_BATCH VARCHAR2(1) default 'N' NOT NULL,
  ASSD_SCAN_BATCH DATE NULL,
  ASED_SCAN_BATCH DATE NULL,
  ASPB_SCAN_BATCH VARCHAR2(80) NULL,
  ASF_PERFORM_QC VARCHAR2(1) default 'N' NOT NULL,
  ASSD_PERFORM_QC DATE NULL,
  ASED_PERFORM_QC DATE NULL,
  ASPB_PERFORM_QC VARCHAR2(80) NULL,
  KOFAX_QC_REASON VARCHAR2(100) NULL,
  ASF_CLASSIFICATION VARCHAR2(1) default 'N' NOT NULL,
  ASSD_CLASSIFICATION DATE NULL,
  ASED_CLASSIFICATION DATE NULL,
  CLASSIFICATION_DT DATE NULL,
  ASF_RECOGNITION VARCHAR2(1) default 'N' NOT NULL,
  ASSD_RECOGNITION DATE NULL,
  ASED_RECOGNITION DATE NULL,
  RECOGNITION_DT DATE NULL,
  ASF_VALIDATE_DATA VARCHAR2(1) default 'N' NOT NULL,
  ASSD_VALIDATE_DATA DATE NULL,
  ASED_VALIDATE_DATA DATE NULL,
  ASPB_VALIDATE_DATA VARCHAR2(80) NULL,
  VALIDATION_DT DATE NULL,
  ASF_CREATE_PDF VARCHAR2(1) default 'N' NOT NULL,
  ASSD_CREATE_PDF DATE NULL,
  ASED_CREATE_PDF DATE NULL,
  ASF_POPULATE_REPORTS VARCHAR2(1) default 'N' NOT NULL,
  ASSD_POPULATE_REPORTS DATE NULL,
  ASED_POPULATE_REPORTS DATE NULL,
  ASF_RELEASE_DMS VARCHAR2(1) default 'N' NOT NULL,
  ASSD_RELEASE_DMS DATE NULL,
  ASED_RELEASE_DMS DATE NULL,
  BATCH_PRIORITY NUMBER NOT NULL,
  BATCH_DELETED VARCHAR2(1) NULL,
  PAGES_SCANNED_FLAG VARCHAR2(1) NULL,
  DOCS_CREATED_FLAG VARCHAR2(1) NULL,
  DOCS_DELETED_FLAG VARCHAR2(1) NULL,
  PAGES_REPLACED_FLAG VARCHAR2(1) NULL,
  PAGES_DELETED_FLAG VARCHAR2(1) NULL,
  STG_EXTRACT_DATE DATE DEFAULT SYSDATE NOT NULL,
  BATCH_COMPLETE_DT date null,
  CURRENT_BATCH_MODULE_ID varchar2(38) null,
  GWF_QC_REQUIRED varchar2(1) null,
  CURRENT_STEP varchar2(100) null,
  SOURCE_SERVER varchar2(255) null)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


comment on column CORP_ETL_MFB_BATCH_OLTP.GWF_QC_REQUIRED is 'QC Required Gateway Flag.';
comment on column CORP_ETL_MFB_BATCH_OLTP.BATCH_COMPLETE_DT is 'The date/timestamp that KOFAX considers the batch completed successfully (i.e. Released to DMS).';
comment on column CORP_ETL_MFB_BATCH_OLTP.CURRENT_BATCH_MODULE_ID is 'Identifier for the current record in Master Batch Module Staging.  It is NA if the batch is completed in KOFAX.';

comment on column CORP_ETL_MFB_BATCH_OLTP.BATCH_GUID is 'Unique identifier for the batch in KOFAX.';
comment on column CORP_ETL_MFB_BATCH_OLTP.BATCH_ID is 'Batch ID in KOFAX.';
comment on column CORP_ETL_MFB_BATCH_OLTP.BATCH_NAME is 'Name assigned to the batch when it is created.';
comment on column CORP_ETL_MFB_BATCH_OLTP.CREATION_STATION_ID is 'Identifies the KOFAX Capture station where the batch is created. The Station ID is assigned during the installation process.';
comment on column CORP_ETL_MFB_BATCH_OLTP.CREATION_USER_NAME is 'This is the Windows login name for the user who creates the batch.';
comment on column CORP_ETL_MFB_BATCH_OLTP.CREATION_USER_ID is 'If the User Profiles feature is enabled, the KOFAX Capture login ID for the user who creates the batch.  If User Profiles are not enabled, this is the Windows login name for the user who creates the batch.';
comment on column CORP_ETL_MFB_BATCH_OLTP.BATCH_CLASS is 'Name of the batch class.';
comment on column CORP_ETL_MFB_BATCH_OLTP.BATCH_CLASS_DES is 'Description of the batch class on which the batch is based. ';
comment on column CORP_ETL_MFB_BATCH_OLTP.BATCH_TYPE is 'The type of batch. ';
comment on column CORP_ETL_MFB_BATCH_OLTP.CREATE_DT is 'The date that the batch is initially scanned.';
comment on column CORP_ETL_MFB_BATCH_OLTP.COMPLETE_DT is 'The date the batch was successfully released to DMS, cancelled, or otherwise deleted.';
comment on column CORP_ETL_MFB_BATCH_OLTP.INSTANCE_STATUS is 'Instance Status indicates if the batch is in process or not. When the batch is created the status is set to ''Active'', and it remains open until the batch has been successfully released to DMS,  is cancelled, or otherwise deleted when it is then set to ''Complete''.';
comment on column CORP_ETL_MFB_BATCH_OLTP.INSTANCE_STATUS_DT is 'The date and time the batch was created.';
comment on column CORP_ETL_MFB_BATCH_OLTP.BATCH_PAGE_COUNT is 'The total number of pages that are scanned in a single batch.';
comment on column CORP_ETL_MFB_BATCH_OLTP.BATCH_DOC_COUNT is 'Displays the total number of documents scanned in the batch.   The value is set based on the number of document separator sheets read through KOFAX.';
comment on column CORP_ETL_MFB_BATCH_OLTP.BATCH_ENVELOPE_COUNT is 'The total number of envelopes in the batch.  This number is entered manually at the beginning of the scanning process.';
comment on column CORP_ETL_MFB_BATCH_OLTP.CANCEL_DT is 'The date when a worker initiated the cancelling of a batch. The date/time that the batch was deleted from the source system. If the date is unknown, the date this condition was detected.';
comment on column CORP_ETL_MFB_BATCH_OLTP.CANCEL_BY is 'The performer who cancelled the batch.';
comment on column CORP_ETL_MFB_BATCH_OLTP.CANCEL_REASON is 'The reason the instance was cancelled.';
comment on column CORP_ETL_MFB_BATCH_OLTP.CANCEL_METHOD is 'The method by which the instance was cancelled.';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASSD_SCAN_BATCH is 'The date and time work started on the Scan Batch activity step.';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASED_SCAN_BATCH is 'Date and time all work was completed for the Scan Batch activity step.';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASPB_SCAN_BATCH is 'The name of the staff member who completed the Scan Batch activity step.';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASSD_PERFORM_QC is 'The date and time work started on a batch for the Perform QC activity step.';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASED_PERFORM_QC is 'Date and time all work was completed for a batch for the Perform QC activity step.';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASPB_PERFORM_QC is 'The name of the staff member who completed the Perform QC activity step.';
comment on column CORP_ETL_MFB_BATCH_OLTP.KOFAX_QC_REASON is 'The KOFAX QC Reason explains what occurred during the scanning process that requires the batch and its contents to be reviewed by a worker in the Perform QC Activity Step.';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASSD_CLASSIFICATION is 'Date and time work started on a batch for the Recognition activity step.';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASED_CLASSIFICATION is 'Date and time work was completed for a batch for the Classification activity step.';
comment on column CORP_ETL_MFB_BATCH_OLTP.CLASSIFICATION_DT is 'Date and time that indicates when the document was classified.';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASSD_RECOGNITION is 'Date and time work started on a batch for the Recognition activity step.';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASED_RECOGNITION is 'Date and time work was completed for a batch for the Recognition activity step.';
comment on column CORP_ETL_MFB_BATCH_OLTP.RECOGNITION_DT is 'Date and time that indicates when the document completed Recognition. ';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASSD_VALIDATE_DATA is 'Date and time work started on a batch for the Verify Results activity step.';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASED_VALIDATE_DATA is 'Date and time work was completed for a batch for the Verify Results activity step.';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASPB_VALIDATE_DATA is 'Name of the staff member who completed the Verify Results activity step.';
comment on column CORP_ETL_MFB_BATCH_OLTP.VALIDATION_DT is 'Date and time that indicates when the document was validated. ';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASSD_CREATE_PDF is 'Date and time when the PDF Generator module begins.';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASED_CREATE_PDF is 'Date and time when the PDF Generator module completed converting each page of a document in a batch to a PDF. ';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASSD_POPULATE_REPORTS is 'Date and time when the KOFAX Advanced Reports custom workflow agent begins capturing and storing the batch  information required for reporting';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASED_POPULATE_REPORTS is 'Date and time when the KOFAX Advanced Reports custom workflow agent completes capturing and storing the batch  information required for reporting';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASSD_RELEASE_DMS is 'Date and time when the KOFAX Export Module begins to process the scanned and imported documents through the Export engine designed to create documents with associated metadata and place them into a managed folder (DMS)';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASED_RELEASE_DMS is 'Date and time when the KOFAX Export Module completed processing the scanned and imported documents through the Export engine designed to create documents with associated metadata and place them into a managed folder (DMS)';
comment on column CORP_ETL_MFB_BATCH_OLTP.BATCH_PRIORITY is 'The priority of the batch.';
comment on column CORP_ETL_MFB_BATCH_OLTP.BATCH_DELETED is 'Flag that indicates that the batch was deleted during the current processing session. ';
comment on column CORP_ETL_MFB_BATCH_OLTP.PAGES_SCANNED_FLAG is 'Flag that indicates the number of pages scanned changed during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_OLTP.DOCS_CREATED_FLAG is 'Flag that indicates that documents were created during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_OLTP.DOCS_DELETED_FLAG is 'Flag that indicates that documents were replaced during the current processing session';
comment on column CORP_ETL_MFB_BATCH_OLTP.PAGES_REPLACED_FLAG is 'Flag that indicates pages replaced during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_OLTP.PAGES_DELETED_FLAG is 'Flag indicating that pages were deleted during at any time during processing. ';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASF_SCAN_BATCH is 'ASF_SCAN_BATCH';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASF_PERFORM_QC is 'ASF_PERFORM_QC';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASF_CLASSIFICATION is 'ASF_CLASSIFICATION';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASF_RECOGNITION is 'ASF_RECOGNITION';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASF_VALIDATE_DATA is 'ASF_VALIDATE_DATA';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASF_CREATE_PDF is 'ASF_CREATE_PDF';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASF_POPULATE_REPORTS is 'ASF_POPULATE_REPORTS';
comment on column CORP_ETL_MFB_BATCH_OLTP.ASF_RELEASE_DMS is 'ASF_RELEASE_DMS';
comment on column CORP_ETL_MFB_BATCH_OLTP.GWF_QC_REQUIRED is 'QC Required Gateway Flag.';
comment on column CORP_ETL_MFB_BATCH_OLTP.BATCH_COMPLETE_DT is 'The date/timestamp that KOFAX considers the batch completed successfully (i.e. Released to DMS).';
comment on column CORP_ETL_MFB_BATCH_OLTP.CURRENT_BATCH_MODULE_ID is 'Identifier for the current record in Master Batch Module Staging.  It is NA if the batch is completed in KOFAX.';
comment on column CORP_ETL_MFB_BATCH_OLTP.CURRENT_STEP is 'Current Activity Step for this Instance.';

create or replace public synonym CORP_ETL_MFB_BATCH_OLTP for MAXDAT.CORP_ETL_MFB_BATCH_OLTP;
grant select on CORP_ETL_MFB_BATCH_OLTP to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_BATCH_STG';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_BATCH_STG cascade constraints';
   end if;
end;
/
create table CORP_ETL_MFB_BATCH_STG(
  CEMFBB_ID NUMBER NOT NULL,
  BATCH_GUID VARCHAR2(38) NOT NULL,
  BATCH_ID NUMBER NOT NULL,
  BATCH_NAME VARCHAR2(255) NOT NULL,
  CREATION_STATION_ID VARCHAR2(32) NOT NULL,
  CREATION_USER_NAME VARCHAR2(80) NULL,
  CREATION_USER_ID VARCHAR2(50) NOT NULL,
  BATCH_CLASS VARCHAR2(32) NOT NULL,
  BATCH_CLASS_DES VARCHAR2(80) NULL,
  BATCH_TYPE VARCHAR2(38) NULL,
  CREATE_DT DATE NOT NULL,
  COMPLETE_DT DATE NULL,
  INSTANCE_STATUS VARCHAR2(30) NOT NULL,
  INSTANCE_STATUS_DT DATE NOT NULL,
  BATCH_PAGE_COUNT NUMBER NULL,
  BATCH_DOC_COUNT NUMBER NULL,
  BATCH_ENVELOPE_COUNT NUMBER NULL,
  CANCEL_DT DATE NULL,
  CANCEL_BY VARCHAR2(80) NULL,
  CANCEL_REASON VARCHAR2(80) NULL,
  CANCEL_METHOD VARCHAR2(80) NULL,
  ASF_SCAN_BATCH VARCHAR2(1) default 'N' NOT NULL,
  ASSD_SCAN_BATCH DATE NULL,
  ASED_SCAN_BATCH DATE NULL,
  ASPB_SCAN_BATCH VARCHAR2(80) NULL,
  ASF_PERFORM_QC VARCHAR2(1) default 'N' NOT NULL,
  ASSD_PERFORM_QC DATE NULL,
  ASED_PERFORM_QC DATE NULL,
  ASPB_PERFORM_QC VARCHAR2(80) NULL,
  KOFAX_QC_REASON VARCHAR2(100) NULL,
  ASF_CLASSIFICATION VARCHAR2(1) default 'N' NOT NULL,
  ASSD_CLASSIFICATION DATE NULL,
  ASED_CLASSIFICATION DATE NULL,
  CLASSIFICATION_DT DATE NULL,
  ASF_RECOGNITION VARCHAR2(1) default 'N' NOT NULL,
  ASSD_RECOGNITION DATE NULL,
  ASED_RECOGNITION DATE NULL,
  RECOGNITION_DT DATE NULL,
  ASF_VALIDATE_DATA VARCHAR2(1) default 'N' NOT NULL,
  ASSD_VALIDATE_DATA DATE NULL,
  ASED_VALIDATE_DATA DATE NULL,
  ASPB_VALIDATE_DATA VARCHAR2(80) NULL,
  VALIDATION_DT DATE NULL,
  ASF_CREATE_PDF VARCHAR2(1) default 'N' NOT NULL,
  ASSD_CREATE_PDF DATE NULL,
  ASED_CREATE_PDF DATE NULL,
  ASF_POPULATE_REPORTS VARCHAR2(1) default 'N' NOT NULL,
  ASSD_POPULATE_REPORTS DATE NULL,
  ASED_POPULATE_REPORTS DATE NULL,
  ASF_RELEASE_DMS VARCHAR2(1) default 'N' NOT NULL,
  ASSD_RELEASE_DMS DATE NULL,
  ASED_RELEASE_DMS DATE NULL,
  BATCH_PRIORITY NUMBER NOT NULL,
  BATCH_DELETED VARCHAR2(1) NULL,
  PAGES_SCANNED_FLAG VARCHAR2(1) NULL,
  DOCS_CREATED_FLAG VARCHAR2(1) NULL,
  DOCS_DELETED_FLAG VARCHAR2(1) NULL,
  PAGES_REPLACED_FLAG VARCHAR2(1) NULL,
  PAGES_DELETED_FLAG VARCHAR2(1) NULL,
  STG_DONE_DATE DATE NULL,
  STG_EXTRACT_DATE DATE NOT NULL,
  STG_LAST_UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  STG_PROCESSED_DATE DATE NULL,
  INSERT_UPDATE VARCHAR2(1) NULL,
  STG_INSERT_JOB_ID NUMBER NOT NULL,
  BATCH_COMPLETE_DT date null,
  CURRENT_BATCH_MODULE_ID varchar2(38) null,
  GWF_QC_REQUIRED varchar2(1) null,
  CURRENT_STEP varchar2(100) null,
  SOURCE_SERVER varchar2(255) null)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_BATCH_STG.CEMFBB_ID is 'sequence';
comment on column CORP_ETL_MFB_BATCH_STG.BATCH_GUID is 'Unique identifier for the batch in KOFAX.';
comment on column CORP_ETL_MFB_BATCH_STG.BATCH_ID is 'Batch ID in KOFAX.';
comment on column CORP_ETL_MFB_BATCH_STG.BATCH_NAME is 'Name assigned to the batch when it is created.';
comment on column CORP_ETL_MFB_BATCH_STG.CREATION_STATION_ID is 'Identifies the KOFAX Capture station where the batch is created. The Station ID is assigned during the installation process.';
comment on column CORP_ETL_MFB_BATCH_STG.CREATION_USER_NAME is 'This is the Windows login name for the user who creates the batch.';
comment on column CORP_ETL_MFB_BATCH_STG.CREATION_USER_ID is 'If the User Profiles feature is enabled, the KOFAX Capture login ID for the user who creates the batch.  If User Profiles are not enabled, this is the Windows login name for the user who creates the batch.';
comment on column CORP_ETL_MFB_BATCH_STG.BATCH_CLASS is 'Name of the batch class.';
comment on column CORP_ETL_MFB_BATCH_STG.BATCH_CLASS_DES is 'Description of the batch class on which the batch is based. ';
comment on column CORP_ETL_MFB_BATCH_STG.BATCH_TYPE is 'The type of batch. ';
comment on column CORP_ETL_MFB_BATCH_STG.CREATE_DT is 'The date that the batch is initially scanned.';
comment on column CORP_ETL_MFB_BATCH_STG.COMPLETE_DT is 'The date the batch was successfully released to DMS, cancelled, or otherwise deleted.';
comment on column CORP_ETL_MFB_BATCH_STG.INSTANCE_STATUS is 'Instance Status indicates if the batch is in process or not. When the batch is created the status is set to ''Active'', and it remains open until the batch has been successfully released to DMS,  is cancelled, or otherwise deleted when it is then set to ''Complete''.';
comment on column CORP_ETL_MFB_BATCH_STG.INSTANCE_STATUS_DT is 'The date and time the batch was created.';
comment on column CORP_ETL_MFB_BATCH_STG.BATCH_PAGE_COUNT is 'The total number of pages that are scanned in a single batch.';
comment on column CORP_ETL_MFB_BATCH_STG.BATCH_DOC_COUNT is 'Displays the total number of documents scanned in the batch.   The value is set based on the number of document separator sheets read through KOFAX.';
comment on column CORP_ETL_MFB_BATCH_STG.BATCH_ENVELOPE_COUNT is 'The total number of envelopes in the batch.  This number is entered manually at the beginning of the scanning process.';
comment on column CORP_ETL_MFB_BATCH_STG.CANCEL_DT is 'The date when a worker initiated the cancelling of a batch. The date/time that the batch was deleted from the source system. If the date is unknown, the date this condition was detected.';
comment on column CORP_ETL_MFB_BATCH_STG.CANCEL_BY is 'The performer who cancelled the batch.';
comment on column CORP_ETL_MFB_BATCH_STG.CANCEL_REASON is 'The reason the instance was cancelled.';
comment on column CORP_ETL_MFB_BATCH_STG.CANCEL_METHOD is 'The method by which the instance was cancelled.';
comment on column CORP_ETL_MFB_BATCH_STG.ASSD_SCAN_BATCH is 'The date and time work started on the Scan Batch activity step.';
comment on column CORP_ETL_MFB_BATCH_STG.ASED_SCAN_BATCH is 'Date and time all work was completed for the Scan Batch activity step.';
comment on column CORP_ETL_MFB_BATCH_STG.ASPB_SCAN_BATCH is 'The name of the staff member who completed the Scan Batch activity step.';
comment on column CORP_ETL_MFB_BATCH_STG.ASSD_PERFORM_QC is 'The date and time work started on a batch for the Perform QC activity step.';
comment on column CORP_ETL_MFB_BATCH_STG.ASED_PERFORM_QC is 'Date and time all work was completed for a batch for the Perform QC activity step.';
comment on column CORP_ETL_MFB_BATCH_STG.ASPB_PERFORM_QC is 'The name of the staff member who completed the Perform QC activity step.';
comment on column CORP_ETL_MFB_BATCH_STG.KOFAX_QC_REASON is 'The KOFAX QC Reason explains what occurred during the scanning process that requires the batch and its contents to be reviewed by a worker in the Perform QC Activity Step.';
comment on column CORP_ETL_MFB_BATCH_STG.ASSD_CLASSIFICATION is 'Date and time work started on a batch for the Recognition activity step.';
comment on column CORP_ETL_MFB_BATCH_STG.ASED_CLASSIFICATION is 'Date and time work was completed for a batch for the Classification activity step.';
comment on column CORP_ETL_MFB_BATCH_STG.CLASSIFICATION_DT is 'Date and time that indicates when the document was classified.';
comment on column CORP_ETL_MFB_BATCH_STG.ASSD_RECOGNITION is 'Date and time work started on a batch for the Recognition activity step.';
comment on column CORP_ETL_MFB_BATCH_STG.ASED_RECOGNITION is 'Date and time work was completed for a batch for the Recognition activity step.';
comment on column CORP_ETL_MFB_BATCH_STG.RECOGNITION_DT is 'Date and time that indicates when the document completed Recognition. ';
comment on column CORP_ETL_MFB_BATCH_STG.ASSD_VALIDATE_DATA is 'Date and time work started on a batch for the Verify Results activity step.';
comment on column CORP_ETL_MFB_BATCH_STG.ASED_VALIDATE_DATA is 'Date and time work was completed for a batch for the Verify Results activity step.';
comment on column CORP_ETL_MFB_BATCH_STG.ASPB_VALIDATE_DATA is 'Name of the staff member who completed the Verify Results activity step.';
comment on column CORP_ETL_MFB_BATCH_STG.VALIDATION_DT is 'Date and time that indicates when the document was validated. ';
comment on column CORP_ETL_MFB_BATCH_STG.ASSD_CREATE_PDF is 'Date and time when the PDF Generator module begins.';
comment on column CORP_ETL_MFB_BATCH_STG.ASED_CREATE_PDF is 'Date and time when the PDF Generator module completed converting each page of a document in a batch to a PDF. ';
comment on column CORP_ETL_MFB_BATCH_STG.ASSD_POPULATE_REPORTS is 'Date and time when the KOFAX Advanced Reports custom workflow agent begins capturing and storing the batch  information required for reporting';
comment on column CORP_ETL_MFB_BATCH_STG.ASED_POPULATE_REPORTS is 'Date and time when the KOFAX Advanced Reports custom workflow agent completes capturing and storing the batch  information required for reporting';
comment on column CORP_ETL_MFB_BATCH_STG.ASSD_RELEASE_DMS is 'Date and time when the KOFAX Export Module begins to process the scanned and imported documents through the Export engine designed to create documents with associated metadata and place them into a managed folder (DMS)';
comment on column CORP_ETL_MFB_BATCH_STG.ASED_RELEASE_DMS is 'Date and time when the KOFAX Export Module completed processing the scanned and imported documents through the Export engine designed to create documents with associated metadata and place them into a managed folder (DMS)';
comment on column CORP_ETL_MFB_BATCH_STG.BATCH_PRIORITY is 'The priority of the batch.';
comment on column CORP_ETL_MFB_BATCH_STG.BATCH_DELETED is 'Flag that indicates that the batch was deleted during the current processing session. ';
comment on column CORP_ETL_MFB_BATCH_STG.PAGES_SCANNED_FLAG is 'Flag that indicates the number of pages scanned changed during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_STG.DOCS_CREATED_FLAG is 'Flag that indicates that documents were created during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_STG.DOCS_DELETED_FLAG is 'Flag that indicates that documents were replaced during the current processing session';
comment on column CORP_ETL_MFB_BATCH_STG.PAGES_REPLACED_FLAG is 'Flag that indicates pages replaced during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_STG.PAGES_DELETED_FLAG is 'Flag indicating that pages were deleted during at any time during processing. ';
comment on column CORP_ETL_MFB_BATCH_STG.ASF_SCAN_BATCH is 'ASF_SCAN_BATCH';
comment on column CORP_ETL_MFB_BATCH_STG.ASF_PERFORM_QC is 'ASF_PERFORM_QC';
comment on column CORP_ETL_MFB_BATCH_STG.ASF_CLASSIFICATION is 'ASF_CLASSIFICATION';
comment on column CORP_ETL_MFB_BATCH_STG.ASF_RECOGNITION is 'ASF_RECOGNITION';
comment on column CORP_ETL_MFB_BATCH_STG.ASF_VALIDATE_DATA is 'ASF_VALIDATE_DATA';
comment on column CORP_ETL_MFB_BATCH_STG.ASF_CREATE_PDF is 'ASF_CREATE_PDF';
comment on column CORP_ETL_MFB_BATCH_STG.ASF_POPULATE_REPORTS is 'ASF_POPULATE_REPORTS';
comment on column CORP_ETL_MFB_BATCH_STG.ASF_RELEASE_DMS is 'ASF_RELEASE_DMS';
comment on column CORP_ETL_MFB_BATCH_STG.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_BATCH_STG.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_BATCH_STG.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';
comment on column CORP_ETL_MFB_BATCH_STG.GWF_QC_REQUIRED is 'QC Required Gateway Flag.';
comment on column CORP_ETL_MFB_BATCH_STG.BATCH_COMPLETE_DT is 'The date/timestamp that KOFAX considers the batch completed successfully (i.e. Released to DMS).';
comment on column CORP_ETL_MFB_BATCH_STG.CURRENT_BATCH_MODULE_ID is 'Identifier for the current record in Master Batch Module Staging.  It is NA if the batch is completed in KOFAX.';
comment on column CORP_ETL_MFB_BATCH_STG.CURRENT_STEP is 'Current Activity Step for this Instance.';

alter table CORP_ETL_MFB_BATCH_STG add primary key (CEMFBB_ID) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_INSTANCE_STATUS check (INSTANCE_STATUS in('Active','Complete'));
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_BATCH_PRIORITY check (BATCH_PRIORITY in(0,1,2,3,4,5,6,7,8,9,10));
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_BATCH_DELETED check (BATCH_DELETED in('Y','N'));
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_PAGES_SCAN_F check (PAGES_SCANNED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_DOCS_CREATED_F check (DOCS_CREATED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_DOCS_DEL_F check (DOCS_DELETED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_PAGES_REPL_F check (PAGES_REPLACED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_PAGES_DEL_F check (PAGES_DELETED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_ASF_SCAN_BATCH check (ASF_SCAN_BATCH in('Y','N'));
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_ASF_PERFORM_QC check (ASF_PERFORM_QC in('Y','N'));
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_ASF_CLASS check (ASF_CLASSIFICATION in('Y','N'));
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_ASF_REC check (ASF_RECOGNITION in('Y','N'));
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_ASF_VAL_DATA check (ASF_VALIDATE_DATA in('Y','N'));
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_ASF_CREATE_PDF check (ASF_CREATE_PDF in('Y','N'));
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_ASF_POP_REPORTS check (ASF_POPULATE_REPORTS in('Y','N'));
alter table CORP_ETL_MFB_BATCH_STG add constraint CHECK_MFB_BS_ASF_REL_DMS check (ASF_RELEASE_DMS in('Y','N'));

create or replace public synonym CORP_ETL_MFB_BATCH_STG for MAXDAT.CORP_ETL_MFB_BATCH_STG;
grant select on CORP_ETL_MFB_BATCH_STG to MAXDAT_READ_ONLY;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_BATCH_WIP';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_BATCH_WIP cascade constraints';
   end if;
end;
/
create table CORP_ETL_MFB_BATCH_WIP(
  CEMFBB_ID NUMBER NOT NULL,
  BATCH_GUID VARCHAR2(38) NOT NULL,
  BATCH_ID NUMBER NOT NULL,
  BATCH_NAME VARCHAR2(255) NOT NULL,
  CREATION_STATION_ID VARCHAR2(32) NOT NULL,
  CREATION_USER_NAME VARCHAR2(80) NULL,
  CREATION_USER_ID VARCHAR2(50) NOT NULL,
  BATCH_CLASS VARCHAR2(32) NOT NULL,
  BATCH_CLASS_DES VARCHAR2(80) NULL,
  BATCH_TYPE VARCHAR2(38) NULL,
  CREATE_DT DATE NOT NULL,
  COMPLETE_DT DATE NULL,
  INSTANCE_STATUS VARCHAR2(30) NOT NULL,
  INSTANCE_STATUS_DT DATE NOT NULL,
  BATCH_PAGE_COUNT NUMBER NULL,
  BATCH_DOC_COUNT NUMBER NULL,
  BATCH_ENVELOPE_COUNT NUMBER NULL,
  CANCEL_DT DATE NULL,
  CANCEL_BY VARCHAR2(80) NULL,
  CANCEL_REASON VARCHAR2(80) NULL,
  CANCEL_METHOD VARCHAR2(80) NULL,
  ASF_SCAN_BATCH VARCHAR2(1) default 'N' NOT NULL,
  ASSD_SCAN_BATCH DATE NULL,
  ASED_SCAN_BATCH DATE NULL,
  ASPB_SCAN_BATCH VARCHAR2(80) NULL,
  ASF_PERFORM_QC VARCHAR2(1) default 'N' NOT NULL,
  ASSD_PERFORM_QC DATE NULL,
  ASED_PERFORM_QC DATE NULL,
  ASPB_PERFORM_QC VARCHAR2(80) NULL,
  KOFAX_QC_REASON VARCHAR2(100) NULL,
  ASF_CLASSIFICATION VARCHAR2(1) default 'N' NOT NULL,
  ASSD_CLASSIFICATION DATE NULL,
  ASED_CLASSIFICATION DATE NULL,
  CLASSIFICATION_DT DATE NULL,
  ASF_RECOGNITION VARCHAR2(1) default 'N' NOT NULL,
  ASSD_RECOGNITION DATE NULL,
  ASED_RECOGNITION DATE NULL,
  RECOGNITION_DT DATE NULL,
  ASF_VALIDATE_DATA VARCHAR2(1) default 'N' NOT NULL,
  ASSD_VALIDATE_DATA DATE NULL,
  ASED_VALIDATE_DATA DATE NULL,
  ASPB_VALIDATE_DATA VARCHAR2(80) NULL,
  VALIDATION_DT DATE NULL,
  ASF_CREATE_PDF VARCHAR2(1) default 'N' NOT NULL,
  ASSD_CREATE_PDF DATE NULL,
  ASED_CREATE_PDF DATE NULL,
  ASF_POPULATE_REPORTS VARCHAR2(1) default 'N' NOT NULL,
  ASSD_POPULATE_REPORTS DATE NULL,
  ASED_POPULATE_REPORTS DATE NULL,
  ASF_RELEASE_DMS VARCHAR2(1) default 'N' NOT NULL,
  ASSD_RELEASE_DMS DATE NULL,
  ASED_RELEASE_DMS DATE NULL,
  BATCH_PRIORITY NUMBER NOT NULL,
  BATCH_DELETED VARCHAR2(1) NULL,
  PAGES_SCANNED_FLAG VARCHAR2(1) NULL,
  DOCS_CREATED_FLAG VARCHAR2(1) NULL,
  DOCS_DELETED_FLAG VARCHAR2(1) NULL,
  PAGES_REPLACED_FLAG VARCHAR2(1) NULL,
  PAGES_DELETED_FLAG VARCHAR2(1) NULL,
  STG_DONE_DATE DATE NULL,
  STG_EXTRACT_DATE DATE NOT NULL,
  STG_LAST_UPDATE_DATE DATE NOT NULL,
  STG_PROCESSED_DATE DATE NULL,
  UPDATED VARCHAR2(1) NULL,
  BATCH_COMPLETE_DT date null,
  CURRENT_BATCH_MODULE_ID varchar2(38) null,
  GWF_QC_REQUIRED varchar2(1) null,
  CURRENT_STEP varchar2(100) null)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_BATCH_WIP.CEMFBB_ID is 'sequence';
comment on column CORP_ETL_MFB_BATCH_WIP.BATCH_GUID is 'Unique identifier for the batch in KOFAX.';
comment on column CORP_ETL_MFB_BATCH_WIP.BATCH_ID is 'Batch ID in KOFAX.';
comment on column CORP_ETL_MFB_BATCH_WIP.BATCH_NAME is 'Name assigned to the batch when it is created.';
comment on column CORP_ETL_MFB_BATCH_WIP.CREATION_STATION_ID is 'Identifies the KOFAX Capture station where the batch is created. The Station ID is assigned during the installation process.';
comment on column CORP_ETL_MFB_BATCH_WIP.CREATION_USER_NAME is 'This is the Windows login name for the user who creates the batch.';
comment on column CORP_ETL_MFB_BATCH_WIP.CREATION_USER_ID is 'If the User Profiles feature is enabled, the KOFAX Capture login ID for the user who creates the batch.  If User Profiles are not enabled, this is the Windows login name for the user who creates the batch.';
comment on column CORP_ETL_MFB_BATCH_WIP.BATCH_CLASS is 'Name of the batch class.';
comment on column CORP_ETL_MFB_BATCH_WIP.BATCH_CLASS_DES is 'Description of the batch class on which the batch is based. ';
comment on column CORP_ETL_MFB_BATCH_WIP.BATCH_TYPE is 'The type of batch. ';
comment on column CORP_ETL_MFB_BATCH_WIP.CREATE_DT is 'The date that the batch is initially scanned.';
comment on column CORP_ETL_MFB_BATCH_WIP.COMPLETE_DT is 'The date the batch was successfully released to DMS, cancelled, or otherwise deleted.';
comment on column CORP_ETL_MFB_BATCH_WIP.INSTANCE_STATUS is 'Instance Status indicates if the batch is in process or not. When the batch is created the status is set to ''Active'', and it remains open until the batch has been successfully released to DMS,  is cancelled, or otherwise deleted when it is then set to ''Complete''.';
comment on column CORP_ETL_MFB_BATCH_WIP.INSTANCE_STATUS_DT is 'The date and time the batch was created.';
comment on column CORP_ETL_MFB_BATCH_WIP.BATCH_PAGE_COUNT is 'The total number of pages that are scanned in a single batch.';
comment on column CORP_ETL_MFB_BATCH_WIP.BATCH_DOC_COUNT is 'Displays the total number of documents scanned in the batch.   The value is set based on the number of document separator sheets read through KOFAX.';
comment on column CORP_ETL_MFB_BATCH_WIP.BATCH_ENVELOPE_COUNT is 'The total number of envelopes in the batch.  This number is entered manually at the beginning of the scanning process.';
comment on column CORP_ETL_MFB_BATCH_WIP.CANCEL_DT is 'The date when a worker initiated the cancelling of a batch. The date/time that the batch was deleted from the source system. If the date is unknown, the date this condition was detected.';
comment on column CORP_ETL_MFB_BATCH_WIP.CANCEL_BY is 'The performer who cancelled the batch.';
comment on column CORP_ETL_MFB_BATCH_WIP.CANCEL_REASON is 'The reason the instance was cancelled.';
comment on column CORP_ETL_MFB_BATCH_WIP.CANCEL_METHOD is 'The method by which the instance was cancelled.';
comment on column CORP_ETL_MFB_BATCH_WIP.ASSD_SCAN_BATCH is 'The date and time work started on the Scan Batch activity step.';
comment on column CORP_ETL_MFB_BATCH_WIP.ASED_SCAN_BATCH is 'Date and time all work was completed for the Scan Batch activity step.';
comment on column CORP_ETL_MFB_BATCH_WIP.ASPB_SCAN_BATCH is 'The name of the staff member who completed the Scan Batch activity step.';
comment on column CORP_ETL_MFB_BATCH_WIP.ASSD_PERFORM_QC is 'The date and time work started on a batch for the Perform QC activity step.';
comment on column CORP_ETL_MFB_BATCH_WIP.ASED_PERFORM_QC is 'Date and time all work was completed for a batch for the Perform QC activity step.';
comment on column CORP_ETL_MFB_BATCH_WIP.ASPB_PERFORM_QC is 'The name of the staff member who completed the Perform QC activity step.';
comment on column CORP_ETL_MFB_BATCH_WIP.KOFAX_QC_REASON is 'The KOFAX QC Reason explains what occurred during the scanning process that requires the batch and its contents to be reviewed by a worker in the Perform QC Activity Step.';
comment on column CORP_ETL_MFB_BATCH_WIP.ASSD_CLASSIFICATION is 'Date and time work started on a batch for the Recognition activity step.';
comment on column CORP_ETL_MFB_BATCH_WIP.ASED_CLASSIFICATION is 'Date and time work was completed for a batch for the Classification activity step.';
comment on column CORP_ETL_MFB_BATCH_WIP.CLASSIFICATION_DT is 'Date and time that indicates when the document was classified.';
comment on column CORP_ETL_MFB_BATCH_WIP.ASSD_RECOGNITION is 'Date and time work started on a batch for the Recognition activity step.';
comment on column CORP_ETL_MFB_BATCH_WIP.ASED_RECOGNITION is 'Date and time work was completed for a batch for the Recognition activity step.';
comment on column CORP_ETL_MFB_BATCH_WIP.RECOGNITION_DT is 'Date and time that indicates when the document completed Recognition. ';
comment on column CORP_ETL_MFB_BATCH_WIP.ASSD_VALIDATE_DATA is 'Date and time work started on a batch for the Verify Results activity step.';
comment on column CORP_ETL_MFB_BATCH_WIP.ASED_VALIDATE_DATA is 'Date and time work was completed for a batch for the Verify Results activity step.';
comment on column CORP_ETL_MFB_BATCH_WIP.ASPB_VALIDATE_DATA is 'Name of the staff member who completed the Verify Results activity step.';
comment on column CORP_ETL_MFB_BATCH_WIP.VALIDATION_DT is 'Date and time that indicates when the document was validated. ';
comment on column CORP_ETL_MFB_BATCH_WIP.ASSD_CREATE_PDF is 'Date and time when the PDF Generator module begins.';
comment on column CORP_ETL_MFB_BATCH_WIP.ASED_CREATE_PDF is 'Date and time when the PDF Generator module completed converting each page of a document in a batch to a PDF. ';
comment on column CORP_ETL_MFB_BATCH_WIP.ASSD_POPULATE_REPORTS is 'Date and time when the KOFAX Advanced Reports custom workflow agent begins capturing and storing the batch  information required for reporting';
comment on column CORP_ETL_MFB_BATCH_WIP.ASED_POPULATE_REPORTS is 'Date and time when the KOFAX Advanced Reports custom workflow agent completes capturing and storing the batch  information required for reporting';
comment on column CORP_ETL_MFB_BATCH_WIP.ASSD_RELEASE_DMS is 'Date and time when the KOFAX Export Module begins to process the scanned and imported documents through the Export engine designed to create documents with associated metadata and place them into a managed folder (DMS)';
comment on column CORP_ETL_MFB_BATCH_WIP.ASED_RELEASE_DMS is 'Date and time when the KOFAX Export Module completed processing the scanned and imported documents through the Export engine designed to create documents with associated metadata and place them into a managed folder (DMS)';
comment on column CORP_ETL_MFB_BATCH_WIP.BATCH_PRIORITY is 'The priority of the batch.';
comment on column CORP_ETL_MFB_BATCH_WIP.BATCH_DELETED is 'Flag that indicates that the batch was deleted during the current processing session. ';
comment on column CORP_ETL_MFB_BATCH_WIP.PAGES_SCANNED_FLAG is 'Flag that indicates the number of pages scanned changed during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_WIP.DOCS_CREATED_FLAG is 'Flag that indicates that documents were created during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_WIP.DOCS_DELETED_FLAG is 'Flag that indicates that documents were replaced during the current processing session';
comment on column CORP_ETL_MFB_BATCH_WIP.PAGES_REPLACED_FLAG is 'Flag that indicates pages replaced during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_WIP.PAGES_DELETED_FLAG is 'Flag indicating that pages were deleted during at any time during processing. ';
comment on column CORP_ETL_MFB_BATCH_WIP.ASF_SCAN_BATCH is 'ASF_SCAN_BATCH';
comment on column CORP_ETL_MFB_BATCH_WIP.ASF_PERFORM_QC is 'ASF_PERFORM_QC';
comment on column CORP_ETL_MFB_BATCH_WIP.ASF_CLASSIFICATION is 'ASF_CLASSIFICATION';
comment on column CORP_ETL_MFB_BATCH_WIP.ASF_RECOGNITION is 'ASF_RECOGNITION';
comment on column CORP_ETL_MFB_BATCH_WIP.ASF_VALIDATE_DATA is 'ASF_VALIDATE_DATA';
comment on column CORP_ETL_MFB_BATCH_WIP.ASF_CREATE_PDF is 'ASF_CREATE_PDF';
comment on column CORP_ETL_MFB_BATCH_WIP.ASF_POPULATE_REPORTS is 'ASF_POPULATE_REPORTS';
comment on column CORP_ETL_MFB_BATCH_WIP.ASF_RELEASE_DMS is 'ASF_RELEASE_DMS';
comment on column CORP_ETL_MFB_BATCH_WIP.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_BATCH_WIP.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_BATCH_WIP.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';
comment on column CORP_ETL_MFB_BATCH_WIP.GWF_QC_REQUIRED is 'QC Required Gateway Flag.';
comment on column CORP_ETL_MFB_BATCH_WIP.BATCH_COMPLETE_DT is 'The date/timestamp that KOFAX considers the batch completed successfully (i.e. Released to DMS).';
comment on column CORP_ETL_MFB_BATCH_WIP.CURRENT_BATCH_MODULE_ID is 'Identifier for the current record in Master Batch Module Staging.  It is NA if the batch is completed in KOFAX.';
comment on column CORP_ETL_MFB_BATCH_WIP.CURRENT_STEP is 'Current Activity Step for this Instance.';

alter table CORP_ETL_MFB_BATCH_WIP  add primary key (CEMFBB_ID) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_INSTANCE_STATUS check (INSTANCE_STATUS in('Active','Complete'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_BATCH_PRIORITY check (BATCH_PRIORITY in(0,1,2,3,4,5,6,7,8,9,10));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_BATCH_DELETED check (BATCH_DELETED in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_PAGES_SCAN_F check (PAGES_SCANNED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_DOCS_CREATED_F check (DOCS_CREATED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_DOCS_DEL_F check (DOCS_DELETED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_PAGES_REPL_F check (PAGES_REPLACED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_PAGES_DEL_F check (PAGES_DELETED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_SCAN_BATCH check (ASF_SCAN_BATCH in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_PERFORM_QC check (ASF_PERFORM_QC in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_CLASS check (ASF_CLASSIFICATION in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_REC check (ASF_RECOGNITION in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_VAL_DATA check (ASF_VALIDATE_DATA in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_CREATE_PDF check (ASF_CREATE_PDF in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_POP_REPORTS check (ASF_POPULATE_REPORTS in('Y','N'));
alter table CORP_ETL_MFB_BATCH_WIP add constraint CHECK_MFB_BW_ASF_REL_DMS check (ASF_RELEASE_DMS in('Y','N'));

create or replace public synonym CORP_ETL_MFB_BATCH_WIP for MAXDAT.CORP_ETL_MFB_BATCH_WIP;
grant select on CORP_ETL_MFB_BATCH_WIP to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_BATCH';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_BATCH cascade constraints';
   end if;
end;
/
create table CORP_ETL_MFB_BATCH(
  CEMFBB_ID NUMBER NOT NULL,
  BATCH_GUID VARCHAR2(38) NOT NULL,
  BATCH_ID NUMBER NOT NULL,
  BATCH_NAME VARCHAR2(255) NOT NULL,
  CREATION_STATION_ID VARCHAR2(32) NOT NULL,
  CREATION_USER_NAME VARCHAR2(80) NULL,
  CREATION_USER_ID VARCHAR2(50) NOT NULL,
  BATCH_CLASS VARCHAR2(32) NOT NULL,
  BATCH_CLASS_DES VARCHAR2(80) NULL,
  BATCH_TYPE VARCHAR2(38) NULL,
  CREATE_DT DATE NOT NULL,
  COMPLETE_DT DATE NULL,
  INSTANCE_STATUS VARCHAR2(30) NOT NULL,
  INSTANCE_STATUS_DT DATE NOT NULL,
  BATCH_PAGE_COUNT NUMBER NULL,
  BATCH_DOC_COUNT NUMBER NULL,
  BATCH_ENVELOPE_COUNT NUMBER NULL,
  CANCEL_DT DATE NULL,
  CANCEL_BY VARCHAR2(80) NULL,
  CANCEL_REASON VARCHAR2(80) NULL,
  CANCEL_METHOD VARCHAR2(80) NULL,
  ASF_SCAN_BATCH VARCHAR2(1) default 'N' NOT NULL,
  ASSD_SCAN_BATCH DATE NULL,
  ASED_SCAN_BATCH DATE NULL,
  ASPB_SCAN_BATCH VARCHAR2(80) NULL,
  ASF_PERFORM_QC VARCHAR2(1) default 'N' NOT NULL,
  ASSD_PERFORM_QC DATE NULL,
  ASED_PERFORM_QC DATE NULL,
  ASPB_PERFORM_QC VARCHAR2(80) NULL,
  KOFAX_QC_REASON VARCHAR2(100) NULL,
  ASF_CLASSIFICATION VARCHAR2(1) default 'N' NOT NULL,
  ASSD_CLASSIFICATION DATE NULL,
  ASED_CLASSIFICATION DATE NULL,
  CLASSIFICATION_DT DATE NULL,
  ASF_RECOGNITION VARCHAR2(1) default 'N' NOT NULL,
  ASSD_RECOGNITION DATE NULL,
  ASED_RECOGNITION DATE NULL,
  RECOGNITION_DT DATE NULL,
  ASF_VALIDATE_DATA VARCHAR2(1) default 'N' NOT NULL,
  ASSD_VALIDATE_DATA DATE NULL,
  ASED_VALIDATE_DATA DATE NULL,
  ASPB_VALIDATE_DATA VARCHAR2(80) NULL,
  VALIDATION_DT DATE NULL,
  ASF_CREATE_PDF VARCHAR2(1) default 'N' NOT NULL,
  ASSD_CREATE_PDF DATE NULL,
  ASED_CREATE_PDF DATE NULL,
  ASF_POPULATE_REPORTS VARCHAR2(1) default 'N' NOT NULL,
  ASSD_POPULATE_REPORTS DATE NULL,
  ASED_POPULATE_REPORTS DATE NULL,
  ASF_RELEASE_DMS VARCHAR2(1) default 'N' NOT NULL,
  ASSD_RELEASE_DMS DATE NULL,
  ASED_RELEASE_DMS DATE NULL,
  BATCH_PRIORITY NUMBER NOT NULL,
  BATCH_DELETED VARCHAR2(1) NULL,
  PAGES_SCANNED_FLAG VARCHAR2(1) NULL,
  DOCS_CREATED_FLAG VARCHAR2(1) NULL,
  DOCS_DELETED_FLAG VARCHAR2(1) NULL,
  PAGES_REPLACED_FLAG VARCHAR2(1) NULL,
  PAGES_DELETED_FLAG VARCHAR2(1) NULL,
  STG_DONE_DATE DATE NULL,
  STG_EXTRACT_DATE DATE NOT NULL,
  STG_LAST_UPDATE_DATE DATE NOT NULL,
  STG_PROCESSED_DATE DATE NULL,
  UPDATED VARCHAR2(1) NULL,
  BATCH_COMPLETE_DT date null,
  CURRENT_BATCH_MODULE_ID varchar2(38) null,
  GWF_QC_REQUIRED varchar2(1) null,
  CURRENT_STEP varchar2(100) null)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_BATCH.CEMFBB_ID is 'sequence';
comment on column CORP_ETL_MFB_BATCH.BATCH_GUID is 'Unique identifier for the batch in KOFAX.';
comment on column CORP_ETL_MFB_BATCH.BATCH_ID is 'Batch ID in KOFAX.';
comment on column CORP_ETL_MFB_BATCH.BATCH_NAME is 'Name assigned to the batch when it is created.';
comment on column CORP_ETL_MFB_BATCH.CREATION_STATION_ID is 'Identifies the KOFAX Capture station where the batch is created. The Station ID is assigned during the installation process.';
comment on column CORP_ETL_MFB_BATCH.CREATION_USER_NAME is 'This is the Windows login name for the user who creates the batch.';
comment on column CORP_ETL_MFB_BATCH.CREATION_USER_ID is 'If the User Profiles feature is enabled, the KOFAX Capture login ID for the user who creates the batch.  If User Profiles are not enabled, this is the Windows login name for the user who creates the batch.';
comment on column CORP_ETL_MFB_BATCH.BATCH_CLASS is 'Name of the batch class.';
comment on column CORP_ETL_MFB_BATCH.BATCH_CLASS_DES is 'Description of the batch class on which the batch is based. ';
comment on column CORP_ETL_MFB_BATCH.BATCH_TYPE is 'The type of batch. ';
comment on column CORP_ETL_MFB_BATCH.CREATE_DT is 'The date that the batch is initially scanned.';
comment on column CORP_ETL_MFB_BATCH.COMPLETE_DT is 'The date the batch was successfully released to DMS, cancelled, or otherwise deleted.';
comment on column CORP_ETL_MFB_BATCH.INSTANCE_STATUS is 'Instance Status indicates if the batch is in process or not. When the batch is created the status is set to ''Active'', and it remains open until the batch has been successfully released to DMS,  is cancelled, or otherwise deleted when it is then set to ''Complete''.';
comment on column CORP_ETL_MFB_BATCH.INSTANCE_STATUS_DT is 'The date and time the batch was created.';
comment on column CORP_ETL_MFB_BATCH.BATCH_PAGE_COUNT is 'The total number of pages that are scanned in a single batch.';
comment on column CORP_ETL_MFB_BATCH.BATCH_DOC_COUNT is 'Displays the total number of documents scanned in the batch.   The value is set based on the number of document separator sheets read through KOFAX.';
comment on column CORP_ETL_MFB_BATCH.BATCH_ENVELOPE_COUNT is 'The total number of envelopes in the batch.  This number is entered manually at the beginning of the scanning process.';
comment on column CORP_ETL_MFB_BATCH.CANCEL_DT is 'The date when a worker initiated the cancelling of a batch. The date/time that the batch was deleted from the source system. If the date is unknown, the date this condition was detected.';
comment on column CORP_ETL_MFB_BATCH.CANCEL_BY is 'The performer who cancelled the batch.';
comment on column CORP_ETL_MFB_BATCH.CANCEL_REASON is 'The reason the instance was cancelled.';
comment on column CORP_ETL_MFB_BATCH.CANCEL_METHOD is 'The method by which the instance was cancelled.';
comment on column CORP_ETL_MFB_BATCH.ASSD_SCAN_BATCH is 'The date and time work started on the Scan Batch activity step.';
comment on column CORP_ETL_MFB_BATCH.ASED_SCAN_BATCH is 'Date and time all work was completed for the Scan Batch activity step.';
comment on column CORP_ETL_MFB_BATCH.ASPB_SCAN_BATCH is 'The name of the staff member who completed the Scan Batch activity step.';
comment on column CORP_ETL_MFB_BATCH.ASSD_PERFORM_QC is 'The date and time work started on a batch for the Perform QC activity step.';
comment on column CORP_ETL_MFB_BATCH.ASED_PERFORM_QC is 'Date and time all work was completed for a batch for the Perform QC activity step.';
comment on column CORP_ETL_MFB_BATCH.ASPB_PERFORM_QC is 'The name of the staff member who completed the Perform QC activity step.';
comment on column CORP_ETL_MFB_BATCH.KOFAX_QC_REASON is 'The KOFAX QC Reason explains what occurred during the scanning process that requires the batch and its contents to be reviewed by a worker in the Perform QC Activity Step.';
comment on column CORP_ETL_MFB_BATCH.ASSD_CLASSIFICATION is 'Date and time work started on a batch for the Recognition activity step.';
comment on column CORP_ETL_MFB_BATCH.ASED_CLASSIFICATION is 'Date and time work was completed for a batch for the Classification activity step.';
comment on column CORP_ETL_MFB_BATCH.CLASSIFICATION_DT is 'Date and time that indicates when the document was classified.';
comment on column CORP_ETL_MFB_BATCH.ASSD_RECOGNITION is 'Date and time work started on a batch for the Recognition activity step.';
comment on column CORP_ETL_MFB_BATCH.ASED_RECOGNITION is 'Date and time work was completed for a batch for the Recognition activity step.';
comment on column CORP_ETL_MFB_BATCH.RECOGNITION_DT is 'Date and time that indicates when the document completed Recognition. ';
comment on column CORP_ETL_MFB_BATCH.ASSD_VALIDATE_DATA is 'Date and time work started on a batch for the Verify Results activity step.';
comment on column CORP_ETL_MFB_BATCH.ASED_VALIDATE_DATA is 'Date and time work was completed for a batch for the Verify Results activity step.';
comment on column CORP_ETL_MFB_BATCH.ASPB_VALIDATE_DATA is 'Name of the staff member who completed the Verify Results activity step.';
comment on column CORP_ETL_MFB_BATCH.VALIDATION_DT is 'Date and time that indicates when the document was validated. ';
comment on column CORP_ETL_MFB_BATCH.ASSD_CREATE_PDF is 'Date and time when the PDF Generator module begins.';
comment on column CORP_ETL_MFB_BATCH.ASED_CREATE_PDF is 'Date and time when the PDF Generator module completed converting each page of a document in a batch to a PDF. ';
comment on column CORP_ETL_MFB_BATCH.ASSD_POPULATE_REPORTS is 'Date and time when the KOFAX Advanced Reports custom workflow agent begins capturing and storing the batch  information required for reporting';
comment on column CORP_ETL_MFB_BATCH.ASED_POPULATE_REPORTS is 'Date and time when the KOFAX Advanced Reports custom workflow agent completes capturing and storing the batch  information required for reporting';
comment on column CORP_ETL_MFB_BATCH.ASSD_RELEASE_DMS is 'Date and time when the KOFAX Export Module begins to process the scanned and imported documents through the Export engine designed to create documents with associated metadata and place them into a managed folder (DMS)';
comment on column CORP_ETL_MFB_BATCH.ASED_RELEASE_DMS is 'Date and time when the KOFAX Export Module completed processing the scanned and imported documents through the Export engine designed to create documents with associated metadata and place them into a managed folder (DMS)';
comment on column CORP_ETL_MFB_BATCH.BATCH_PRIORITY is 'The priority of the batch.';
comment on column CORP_ETL_MFB_BATCH.BATCH_DELETED is 'Flag that indicates that the batch was deleted during the current processing session. ';
comment on column CORP_ETL_MFB_BATCH.PAGES_SCANNED_FLAG is 'Flag that indicates the number of pages scanned changed during the current processing session.';
comment on column CORP_ETL_MFB_BATCH.DOCS_CREATED_FLAG is 'Flag that indicates that documents were created during the current processing session.';
comment on column CORP_ETL_MFB_BATCH.DOCS_DELETED_FLAG is 'Flag that indicates that documents were replaced during the current processing session';
comment on column CORP_ETL_MFB_BATCH.PAGES_REPLACED_FLAG is 'Flag that indicates pages replaced during the current processing session.';
comment on column CORP_ETL_MFB_BATCH.PAGES_DELETED_FLAG is 'Flag indicating that pages were deleted during at any time during processing. ';
comment on column CORP_ETL_MFB_BATCH.ASF_SCAN_BATCH is 'ASF_SCAN_BATCH';
comment on column CORP_ETL_MFB_BATCH.ASF_PERFORM_QC is 'ASF_PERFORM_QC';
comment on column CORP_ETL_MFB_BATCH.ASF_CLASSIFICATION is 'ASF_CLASSIFICATION';
comment on column CORP_ETL_MFB_BATCH.ASF_RECOGNITION is 'ASF_RECOGNITION';
comment on column CORP_ETL_MFB_BATCH.ASF_VALIDATE_DATA is 'ASF_VALIDATE_DATA';
comment on column CORP_ETL_MFB_BATCH.ASF_CREATE_PDF is 'ASF_CREATE_PDF';
comment on column CORP_ETL_MFB_BATCH.ASF_POPULATE_REPORTS is 'ASF_POPULATE_REPORTS';
comment on column CORP_ETL_MFB_BATCH.ASF_RELEASE_DMS is 'ASF_RELEASE_DMS';
comment on column CORP_ETL_MFB_BATCH.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_BATCH_STG.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_BATCH.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';
comment on column CORP_ETL_MFB_BATCH.GWF_QC_REQUIRED is 'QC Required Gateway Flag.';
comment on column CORP_ETL_MFB_BATCH.BATCH_COMPLETE_DT is 'The date/timestamp that KOFAX considers the batch completed successfully (i.e. Released to DMS).';
comment on column CORP_ETL_MFB_BATCH.CURRENT_BATCH_MODULE_ID is 'Identifier for the current record in Master Batch Module Staging.  It is NA if the batch is completed in KOFAX.';
comment on column CORP_ETL_MFB_BATCH.CURRENT_STEP is 'Current Activity Step for this Instance.';


create unique index CORP_ETL_MFB_BATCH_IX1 on CORP_ETL_MFB_BATCH(CEMFBB_ID) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage(initial 64K next 1M minextents 1 maxextents unlimited);

alter table CORP_ETL_MFB_BATCH add primary key (BATCH_GUID) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_INSTANCE_STATUS check (INSTANCE_STATUS in('Active','Complete'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_BATCH_PRIORITY check (BATCH_PRIORITY in(0,1,2,3,4,5,6,7,8,9,10));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_BATCH_DELETED check (BATCH_DELETED in('Y','N'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_PAGES_SCANNED_FLAG check (PAGES_SCANNED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_DOCS_CREATED_FLAG check (DOCS_CREATED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_DOCS_DELETED_FLAG check (DOCS_DELETED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_PAGES_REPL_F check (PAGES_REPLACED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_PAGES_DEL_F check (PAGES_DELETED_FLAG in('Y','N'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_ASF_SCAN_BATCH check (ASF_SCAN_BATCH in('Y','N'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_ASF_PERFORM_QC check (ASF_PERFORM_QC in('Y','N'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_ASF_CLASS check (ASF_CLASSIFICATION in('Y','N'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_ASF_REC check (ASF_RECOGNITION in('Y','N'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_ASF_VAL_DATA check (ASF_VALIDATE_DATA in('Y','N'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_ASF_CREATE_PDF check (ASF_CREATE_PDF in('Y','N'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_ASF_POP_REPORTS check (ASF_POPULATE_REPORTS in('Y','N'));
alter table CORP_ETL_MFB_BATCH add constraint CHECK_MFB_B_ASF_REL_DMS check (ASF_RELEASE_DMS in('Y','N'));

create or replace public synonym CORP_ETL_MFB_BATCH for MAXDAT.CORP_ETL_MFB_BATCH;
grant select on CORP_ETL_MFB_BATCH to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_BATCH_EVENTS_OLTP';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_BATCH_EVENTS_OLTP cascade constraints';
   end if;
end;
/
create table CORP_ETL_MFB_BATCH_EVENTS_OLTP(
  BATCH_MODULE_ID VARCHAR2(38) NOT NULL,
  BATCH_GUID VARCHAR2(38) NOT NULL,
  MODULE_LAUNCH_ID VARCHAR2(38) NOT NULL,
  MODULE_UNIQUE_ID VARCHAR2(250) NOT NULL,
  MODULE_NAME VARCHAR2(32) NOT NULL,
  MODULE_CLOSE_ID VARCHAR2(250) NULL,
  MODULE_CLOSE_NAME VARCHAR2(32) NULL,
  MODULE_START_DT DATE NOT NULL,
  MODULE_END_DT DATE NULL,
  BATCH_STATUS NUMBER NOT NULL,
  USER_NAME VARCHAR2(80) NULL,
  STATION_ID VARCHAR2(32) NOT NULL,
  SITE_NAME VARCHAR2(32) NULL,
  SITE_ID NUMBER NOT NULL,
  BATCH_DELETED VARCHAR2(1) NULL,
  DOC_PAGES NUMBER NULL,
  PAGES_SCANNED NUMBER NULL,
  PAGES_DELETED NUMBER NULL,
  DOCS_CREATED NUMBER NULL,
  DOCS_DELETED NUMBER NULL,
  PAGES_REPLACED NUMBER NULL,
  STG_EXTRACT_DATE DATE DEFAULT SYSDATE NOT NULL,
  SOURCE_SERVER varchar2(255) null)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.BATCH_GUID is 'Unique identifier for the batch.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.MODULE_LAUNCH_ID is 'Unique value assigned to each KOFAX Capture processing module.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.MODULE_UNIQUE_ID is 'Unique identifier for the KOFAX Capture module that was launched. If that module has the same literal name as another module, this identifier distinguishes one module from the other.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.MODULE_NAME is 'Literal name of the KOFAX Capture module that was launched.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.MODULE_CLOSE_ID is 'Unique ID for the next module in the workflow.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.MODULE_CLOSE_NAME is 'Name of the next module in the workflow (i.e. “Recognition Server”).';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.MODULE_START_DT is 'Date and time when the module was launched. ';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.MODULE_END_DT is 'Date and time when the module was closed. ';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.BATCH_STATUS is 'A value that identifies the status of the batch at the time the batch was closed. The possible values are: 2 - Ready, 4 - In Progress, 8 - Suspended, 32 - Error, 64 - Completed, 128 – Reserved.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.USER_NAME is 'Windows login name for the user who launched the module.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.STATION_ID is 'Identifies the KOFAX Capture station where the module was launched. The Station ID is assigned during the installation process.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.SITE_NAME is 'Identifies the KOFAX Capture installation site where the module was launched. ';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.SITE_ID is 'Identifies the KOFAX Capture installation site where the module was launched. The Site ID is assigned during the installation process.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.BATCH_DELETED is 'Flag that indicates that the batch was deleted in this session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.DOC_PAGES is 'Number of pages per document. Valid only if fixed page separation is in effect.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.PAGES_SCANNED is 'Number of pages scanned during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.PAGES_DELETED is 'Number of pages deleted during the current processing session';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.DOCS_CREATED is 'Number of documents created during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.DOCS_DELETED is 'Number of documents deleted during the current processing session';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.PAGES_REPLACED is 'Number of pages replaced during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';

create or replace public synonym CORP_ETL_MFB_BATCH_EVENTS_OLTP for MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_OLTP;
grant select on CORP_ETL_MFB_BATCH_EVENTS_OLTP to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_BATCH_EVENTS_STG';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_BATCH_EVENTS_STG cascade constraints';
   end if;
end;
/
create table CORP_ETL_MFB_BATCH_EVENTS_STG(
  CEMFBBE_ID NUMBER NOT NULL,
  BATCH_MODULE_ID VARCHAR2(38) NOT NULL,
  BATCH_GUID VARCHAR2(38) NOT NULL,
  MODULE_LAUNCH_ID VARCHAR2(38) NOT NULL,
  MODULE_UNIQUE_ID VARCHAR2(250) NOT NULL,
  MODULE_NAME VARCHAR2(32) NOT NULL,
  MODULE_CLOSE_ID VARCHAR2(250) NULL,
  MODULE_CLOSE_NAME VARCHAR2(32) NULL,
  MODULE_START_DT DATE NOT NULL,
  MODULE_END_DT DATE NULL,
  BATCH_STATUS NUMBER NOT NULL,
  USER_NAME VARCHAR2(80) NULL,
  STATION_ID VARCHAR2(32) NOT NULL,
  SITE_NAME VARCHAR2(32) NULL,
  SITE_ID NUMBER NOT NULL,
  BATCH_DELETED VARCHAR2(1) NULL,
  DOC_PAGES NUMBER NULL,
  PAGES_SCANNED NUMBER NULL,
  PAGES_DELETED NUMBER NULL,
  DOCS_CREATED NUMBER NULL,
  DOCS_DELETED NUMBER NULL,
  PAGES_REPLACED NUMBER NULL,
  STG_EXTRACT_DATE DATE NOT NULL,
  STG_LAST_UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  STG_PROCESSED_DATE DATE NULL,
  INSERT_UPDATE VARCHAR2(1) NULL,
  STG_INSERT_JOB_ID NUMBER NOT NULL,
  SOURCE_SERVER varchar2(255) null)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.CEMFBBE_ID is 'sequence';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.BATCH_GUID is 'Unique identifier for the batch.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.MODULE_LAUNCH_ID is 'Unique value assigned to each KOFAX Capture processing module.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.MODULE_UNIQUE_ID is 'Unique identifier for the KOFAX Capture module that was launched. If that module has the same literal name as another module, this identifier distinguishes one module from the other.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.MODULE_NAME is 'Literal name of the KOFAX Capture module that was launched.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.MODULE_CLOSE_ID is 'Unique ID for the next module in the workflow.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.MODULE_CLOSE_NAME is 'Name of the next module in the workflow (i.e. “Recognition Server”).';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.MODULE_START_DT is 'Date and time when the module was launched. ';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.MODULE_END_DT is 'Date and time when the module was closed. ';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.BATCH_STATUS is 'A value that identifies the status of the batch at the time the batch was closed. The possible values are: 2 - Ready, 4 - In Progress, 8 - Suspended, 32 - Error, 64 - Completed, 128 – Reserved.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.USER_NAME is 'Windows login name for the user who launched the module.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.STATION_ID is 'Identifies the KOFAX Capture station where the module was launched. The Station ID is assigned during the installation process.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.SITE_NAME is 'Identifies the KOFAX Capture installation site where the module was launched. ';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.SITE_ID is 'Identifies the KOFAX Capture installation site where the module was launched. The Site ID is assigned during the installation process.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.BATCH_DELETED is 'Flag that indicates that the batch was deleted in this session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.DOC_PAGES is 'Number of pages per document. Valid only if fixed page separation is in effect.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.PAGES_SCANNED is 'Number of pages scanned during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.PAGES_DELETED is 'Number of pages deleted during the current processing session';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.DOCS_CREATED is 'Number of documents created during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.DOCS_DELETED is 'Number of documents deleted during the current processing session';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.PAGES_REPLACED is 'Number of pages replaced during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_STG.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';

alter table CORP_ETL_MFB_BATCH_EVENTS_STG  add primary key (CEMFBBE_ID) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
alter table CORP_ETL_MFB_BATCH_EVENTS_STG add constraint CHECK_MFB_EVENTS_STG_B_STATUS check (BATCH_STATUS in(0,1,2,4,8,16,32,64,128,256,512));

create or replace public synonym CORP_ETL_MFB_BATCH_EVENTS_STG for MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_STG;
grant select on CORP_ETL_MFB_BATCH_EVENTS_STG to MAXDAT_READ_ONLY;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_BATCH_EVENTS_WIP';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_BATCH_EVENTS_WIP cascade constraints';
   end if;
end;
/
create table CORP_ETL_MFB_BATCH_EVENTS_WIP(
  CEMFBBE_ID NUMBER NOT NULL,
  BATCH_MODULE_ID VARCHAR2(38) NOT NULL,
  BATCH_GUID VARCHAR2(38) NOT NULL,
  MODULE_LAUNCH_ID VARCHAR2(38) NOT NULL,
  MODULE_UNIQUE_ID VARCHAR2(250) NOT NULL,
  MODULE_NAME VARCHAR2(32) NOT NULL,
  MODULE_CLOSE_ID VARCHAR2(250) NULL,
  MODULE_CLOSE_NAME VARCHAR2(32) NULL,
  MODULE_START_DT DATE NOT NULL,
  MODULE_END_DT DATE NULL,
  BATCH_STATUS NUMBER NOT NULL,
  USER_NAME VARCHAR2(80) NULL,
  STATION_ID VARCHAR2(32) NOT NULL,
  SITE_NAME VARCHAR2(32) NULL,
  SITE_ID NUMBER NOT NULL,
  BATCH_DELETED VARCHAR2(1) NULL,
  DOC_PAGES NUMBER NULL,
  PAGES_SCANNED NUMBER NULL,
  PAGES_DELETED NUMBER NULL,
  DOCS_CREATED NUMBER NULL,
  DOCS_DELETED NUMBER NULL,
  PAGES_REPLACED NUMBER NULL,
  STG_EXTRACT_DATE DATE NOT NULL,
  STG_LAST_UPDATE_DATE DATE NOT NULL,
  STG_PROCESSED_DATE DATE NULL,
  UPDATED VARCHAR2(1) NULL)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.CEMFBBE_ID is 'sequence';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.BATCH_GUID is 'Unique identifier for the batch.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.MODULE_LAUNCH_ID is 'Unique value assigned to each KOFAX Capture processing module.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.MODULE_UNIQUE_ID is 'Unique identifier for the KOFAX Capture module that was launched. If that module has the same literal name as another module, this identifier distinguishes one module from the other.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.MODULE_NAME is 'Literal name of the KOFAX Capture module that was launched.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.MODULE_CLOSE_ID is 'Unique ID for the next module in the workflow.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.MODULE_CLOSE_NAME is 'Name of the next module in the workflow (i.e. “Recognition Server”).';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.MODULE_START_DT is 'Date and time when the module was launched. ';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.MODULE_END_DT is 'Date and time when the module was closed. ';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.BATCH_STATUS is 'A value that identifies the status of the batch at the time the batch was closed. The possible values are: 2 - Ready, 4 - In Progress, 8 - Suspended, 32 - Error, 64 - Completed, 128 – Reserved.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.USER_NAME is 'Windows login name for the user who launched the module.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.STATION_ID is 'Identifies the KOFAX Capture station where the module was launched. The Station ID is assigned during the installation process.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.SITE_NAME is 'Identifies the KOFAX Capture installation site where the module was launched. ';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.SITE_ID is 'Identifies the KOFAX Capture installation site where the module was launched. The Site ID is assigned during the installation process.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.BATCH_DELETED is 'Flag that indicates that the batch was deleted in this session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.DOC_PAGES is 'Number of pages per document. Valid only if fixed page separation is in effect.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.PAGES_SCANNED is 'Number of pages scanned during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.PAGES_DELETED is 'Number of pages deleted during the current processing session';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.DOCS_CREATED is 'Number of documents created during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.DOCS_DELETED is 'Number of documents deleted during the current processing session';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.PAGES_REPLACED is 'Number of pages replaced during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_BATCH_EVENTS_WIP.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';

alter table CORP_ETL_MFB_BATCH_EVENTS_WIP  add primary key (CEMFBBE_ID) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
alter table CORP_ETL_MFB_BATCH_EVENTS_WIP add constraint CHECK_MFB_EVENTS_WIP_B_STATUS check (BATCH_STATUS in(0,1,2,4,8,16,32,64,128,256,512));

create or replace public synonym CORP_ETL_MFB_BATCH_EVENTS_WIP for MAXDAT.CORP_ETL_MFB_BATCH_EVENTS_WIP;
grant select on CORP_ETL_MFB_BATCH_EVENTS_WIP to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_BATCH_EVENTS';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_BATCH_EVENTS';
   end if;
end;
/
create table CORP_ETL_MFB_BATCH_EVENTS(
CEMFBBE_ID NUMBER NOT NULL,
BATCH_MODULE_ID VARCHAR2(38) NOT NULL,
BATCH_GUID VARCHAR2(38) NOT NULL,
MODULE_LAUNCH_ID VARCHAR2(38) NOT NULL,
MODULE_UNIQUE_ID VARCHAR2(250) NOT NULL,
MODULE_NAME VARCHAR2(32) NOT NULL,
MODULE_CLOSE_ID VARCHAR2(250) NULL,
MODULE_CLOSE_NAME VARCHAR2(32) NULL,
MODULE_START_DT DATE NOT NULL,
MODULE_END_DT DATE NULL,
BATCH_STATUS NUMBER NOT NULL,
USER_NAME VARCHAR2(80) NULL,
STATION_ID VARCHAR2(32) NOT NULL,
SITE_NAME VARCHAR2(32) NULL,
SITE_ID NUMBER NOT NULL,
BATCH_DELETED VARCHAR2(1) NULL,
DOC_PAGES NUMBER NULL,
PAGES_SCANNED NUMBER NULL,
PAGES_DELETED NUMBER NULL,
DOCS_CREATED NUMBER NULL,
DOCS_DELETED NUMBER NULL,
PAGES_REPLACED NUMBER NULL,
STG_EXTRACT_DATE DATE NOT NULL,
STG_LAST_UPDATE_DATE DATE NOT NULL,
STG_PROCESSED_DATE DATE NULL,
UPDATED VARCHAR2(1) NULL)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_BATCH_EVENTS.CEMFBBE_ID is 'sequence';
comment on column CORP_ETL_MFB_BATCH_EVENTS.BATCH_GUID is 'Unique identifier for the batch.';
comment on column CORP_ETL_MFB_BATCH_EVENTS.MODULE_LAUNCH_ID is 'Unique value assigned to each KOFAX Capture processing module.';
comment on column CORP_ETL_MFB_BATCH_EVENTS.MODULE_UNIQUE_ID is 'Unique identifier for the KOFAX Capture module that was launched. If that module has the same literal name as another module, this identifier distinguishes one module from the other.';
comment on column CORP_ETL_MFB_BATCH_EVENTS.MODULE_NAME is 'Literal name of the KOFAX Capture module that was launched.';
comment on column CORP_ETL_MFB_BATCH_EVENTS.MODULE_CLOSE_ID is 'Unique ID for the next module in the workflow.';
comment on column CORP_ETL_MFB_BATCH_EVENTS.MODULE_CLOSE_NAME is 'Name of the next module in the workflow (i.e. “Recognition Server”).';
comment on column CORP_ETL_MFB_BATCH_EVENTS.MODULE_START_DT is 'Date and time when the module was launched. ';
comment on column CORP_ETL_MFB_BATCH_EVENTS.MODULE_END_DT is 'Date and time when the module was closed. ';
comment on column CORP_ETL_MFB_BATCH_EVENTS_OLTP.BATCH_STATUS is 'A value that identifies the status of the batch at the time the batch was closed. The possible values are: 2 - Ready, 4 - In Progress, 8 - Suspended, 32 - Error, 64 - Completed, 128 – Reserved.';
comment on column CORP_ETL_MFB_BATCH_EVENTS.USER_NAME is 'Windows login name for the user who launched the module.';
comment on column CORP_ETL_MFB_BATCH_EVENTS.STATION_ID is 'Identifies the KOFAX Capture station where the module was launched. The Station ID is assigned during the installation process.';
comment on column CORP_ETL_MFB_BATCH_EVENTS.SITE_NAME is 'Identifies the KOFAX Capture installation site where the module was launched. ';
comment on column CORP_ETL_MFB_BATCH_EVENTS.SITE_ID is 'Identifies the KOFAX Capture installation site where the module was launched. The Site ID is assigned during the installation process.';
comment on column CORP_ETL_MFB_BATCH_EVENTS.BATCH_DELETED is 'Flag that indicates that the batch was deleted in this session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS.DOC_PAGES is 'Number of pages per document. Valid only if fixed page separation is in effect.';
comment on column CORP_ETL_MFB_BATCH_EVENTS.PAGES_SCANNED is 'Number of pages scanned during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS.PAGES_DELETED is 'Number of pages deleted during the current processing session';
comment on column CORP_ETL_MFB_BATCH_EVENTS.DOCS_CREATED is 'Number of documents created during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS.DOCS_DELETED is 'Number of documents deleted during the current processing session';
comment on column CORP_ETL_MFB_BATCH_EVENTS.PAGES_REPLACED is 'Number of pages replaced during the current processing session.';
comment on column CORP_ETL_MFB_BATCH_EVENTS.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_BATCH_EVENTS.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_BATCH_EVENTS.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';

create unique index CORP_ETL_MFB_BATCH_EVENTS_IX1 on CORP_ETL_MFB_BATCH_EVENTS(CEMFBBE_ID) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage(initial 64K next 1M minextents 1 maxextents unlimited);
alter table CORP_ETL_MFB_BATCH_EVENTS  add primary key (BATCH_MODULE_ID) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

alter table CORP_ETL_MFB_BATCH_EVENTS add constraint CHECK_MFB_EVENTS_B_STATUS check (BATCH_STATUS in(0,1,2,4,8,16,32,64,128,256,512));

alter table CORP_ETL_MFB_BATCH_EVENTS add constraint CORP_ETL_MFBB_BATCH_GUID foreign key(BATCH_GUID) references CORP_ETL_MFB_BATCH(BATCH_GUID);

create or replace public synonym CORP_ETL_MFB_BATCH_EVENTS for MAXDAT.CORP_ETL_MFB_BATCH_EVENTS;
grant select on CORP_ETL_MFB_BATCH_EVENTS to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_FORM_OLTP';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_FORM_OLTP';
   end if;
end;
/
create table CORP_ETL_MFB_FORM_OLTP(
  BATCH_GUID VARCHAR2(38) NOT NULL,
  FORM_TYPE_ENTRY_ID VARCHAR2(38) NOT NULL,
  BATCH_MODULE_ID VARCHAR2(38) NOT NULL,
  TYPE_NAME VARCHAR2(32) NULL,
  DOC_CLASS_NAME VARCHAR2(32) NULL,
  DOC_COUNT NUMBER NULL,
  REJECTED_DOCS NUMBER NULL,
  PAGES NUMBER NULL,
  REJECTED_PAGES NUMBER NULL,
  COMPLETED_DOCS NUMBER NULL,
  COMPLETED_PAGES NUMBER NULL,
  STG_EXTRACT_DATE DATE DEFAULT SYSDATE NOT NULL,
  SOURCE_SERVER varchar2(255) null)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_FORM_OLTP.BATCH_GUID is 'Unique identifier for the batch.';
comment on column CORP_ETL_MFB_FORM_OLTP.FORM_TYPE_ENTRY_ID is 'Unique value to identify each form type record created';
comment on column CORP_ETL_MFB_FORM_OLTP.BATCH_MODULE_ID is 'Unique identifier that indicates the KOFAX Capture module associated with the batch for which a form type record was created. Foreign key to associated record in the StatsBatchModule table.';
comment on column CORP_ETL_MFB_FORM_OLTP.TYPE_NAME is 'Name of the form type. If the entry is “Loose,” it relates to pages that do not belong to a document. If the entry is “None,” it relates to documents that have not been assigned a form type.';
comment on column CORP_ETL_MFB_FORM_OLTP.DOC_CLASS_NAME is 'Name of the document class associated with the form type. This is empty when the FormTypeName is Loose or Empty.';
comment on column CORP_ETL_MFB_FORM_OLTP.DOC_COUNT is 'Number of documents using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM_OLTP.REJECTED_DOCS is 'Number of rejected documents using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM_OLTP.PAGES is 'Number of pages using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM_OLTP.REJECTED_PAGES is 'Number of rejected pages using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM_OLTP.COMPLETED_DOCS is 'For this form type, the number of documents that have completed processing in the batch.';
comment on column CORP_ETL_MFB_FORM_OLTP.COMPLETED_PAGES is 'For this form type, the number of pages that have been reviewed in the Quality Control queue. Reviewed pages are tracked if “Require review of scanned pages” is selected in the Quality Control queue properties for the batch class.';
comment on column CORP_ETL_MFB_FORM_OLTP.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';

create or replace public synonym CORP_ETL_MFB_FORM_OLTP for MAXDAT.CORP_ETL_MFB_FORM_OLTP;
grant select on CORP_ETL_MFB_FORM_OLTP to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_FORM_STG';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_FORM_STG';
   end if;
end;
/
create table CORP_ETL_MFB_FORM_STG(
  CEMFBF_ID NUMBER NOT NULL,
  BATCH_GUID VARCHAR2(38) NOT NULL,
  FORM_TYPE_ENTRY_ID VARCHAR2(38) NOT NULL,
  BATCH_MODULE_ID VARCHAR2(38) NOT NULL,
  TYPE_NAME VARCHAR2(32) NULL,
  DOC_CLASS_NAME VARCHAR2(32) NULL,
  DOC_COUNT NUMBER NULL,
  REJECTED_DOCS NUMBER NULL,
  PAGES NUMBER NULL,
  REJECTED_PAGES NUMBER NULL,
  COMPLETED_DOCS NUMBER NULL,
  COMPLETED_PAGES NUMBER NULL,
  STG_EXTRACT_DATE DATE NOT NULL,
  STG_LAST_UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  STG_PROCESSED_DATE DATE NULL,
  INSERT_UPDATE VARCHAR2(1) NULL,
  STG_INSERT_JOB_ID NUMBER NOT NULL,
  SOURCE_SERVER varchar2(255) null)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_FORM_STG.CEMFBF_ID is 'sequence';
comment on column CORP_ETL_MFB_FORM_STG.BATCH_GUID is 'Unique identifier for the batch.';
comment on column CORP_ETL_MFB_FORM_STG.FORM_TYPE_ENTRY_ID is 'Unique value to identify each form type record created';
comment on column CORP_ETL_MFB_FORM_STG.BATCH_MODULE_ID is 'Unique identifier that indicates the KOFAX Capture module associated with the batch for which a form type record was created. Foreign key to associated record in the StatsBatchModule table.';
comment on column CORP_ETL_MFB_FORM_STG.TYPE_NAME is 'Name of the form type. If the entry is “Loose,” it relates to pages that do not belong to a document. If the entry is “None,” it relates to documents that have not been assigned a form type.';
comment on column CORP_ETL_MFB_FORM_STG.DOC_CLASS_NAME is 'Name of the document class associated with the form type. This is empty when the FormTypeName is Loose or Empty.';
comment on column CORP_ETL_MFB_FORM_STG.DOC_COUNT is 'Number of documents using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM_STG.REJECTED_DOCS is 'Number of rejected documents using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM_STG.PAGES is 'Number of pages using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM_STG.REJECTED_PAGES is 'Number of rejected pages using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM_STG.COMPLETED_DOCS is 'For this form type, the number of documents that have completed processing in the batch.';
comment on column CORP_ETL_MFB_FORM_STG.COMPLETED_PAGES is 'For this form type, the number of pages that have been reviewed in the Quality Control queue. Reviewed pages are tracked if “Require review of scanned pages” is selected in the Quality Control queue properties for the batch class.';
comment on column CORP_ETL_MFB_FORM_STG.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_FORM_STG.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_FORM_STG.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';

alter table CORP_ETL_MFB_FORM_STG add primary key (CEMFBF_ID) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

create or replace public synonym CORP_ETL_MFB_FORM_STG for MAXDAT.CORP_ETL_MFB_FORM_STG;
grant select on CORP_ETL_MFB_FORM_STG to MAXDAT_READ_ONLY;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_FORM_WIP';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_FORM_WIP';
   end if;
end;
/
create table CORP_ETL_MFB_FORM_WIP(
  CEMFBF_ID NUMBER NOT NULL,
  BATCH_GUID VARCHAR2(38) NOT NULL,
  FORM_TYPE_ENTRY_ID VARCHAR2(38) NOT NULL,
  BATCH_MODULE_ID VARCHAR2(38) NOT NULL,
  TYPE_NAME VARCHAR2(32) NULL,
  DOC_CLASS_NAME VARCHAR2(32) NULL,
  DOC_COUNT NUMBER NULL,
  REJECTED_DOCS NUMBER NULL,
  PAGES NUMBER NULL,
  REJECTED_PAGES NUMBER NULL,
  COMPLETED_DOCS NUMBER NULL,
  COMPLETED_PAGES NUMBER NULL,
  STG_EXTRACT_DATE DATE NOT NULL,
  STG_LAST_UPDATE_DATE DATE NOT NULL,
  STG_PROCESSED_DATE DATE NULL,
  UPDATED VARCHAR2(1) NULL)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_FORM_WIP.CEMFBF_ID is 'sequence';
comment on column CORP_ETL_MFB_FORM_WIP.BATCH_GUID is 'Unique identifier for the batch.';
comment on column CORP_ETL_MFB_FORM_WIP.FORM_TYPE_ENTRY_ID is 'Unique value to identify each form type record created';
comment on column CORP_ETL_MFB_FORM_WIP.BATCH_MODULE_ID is 'Unique identifier that indicates the KOFAX Capture module associated with the batch for which a form type record was created. Foreign key to associated record in the StatsBatchModule table.';
comment on column CORP_ETL_MFB_FORM_WIP.TYPE_NAME is 'Name of the form type. If the entry is “Loose,” it relates to pages that do not belong to a document. If the entry is “None,” it relates to documents that have not been assigned a form type.';
comment on column CORP_ETL_MFB_FORM_WIP.DOC_CLASS_NAME is 'Name of the document class associated with the form type. This is empty when the FormTypeName is Loose or Empty.';
comment on column CORP_ETL_MFB_FORM_WIP.DOC_COUNT is 'Number of documents using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM_WIP.REJECTED_DOCS is 'Number of rejected documents using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM_WIP.PAGES is 'Number of pages using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM_WIP.REJECTED_PAGES is 'Number of rejected pages using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM_WIP.COMPLETED_DOCS is 'For this form type, the number of documents that have completed processing in the batch.';
comment on column CORP_ETL_MFB_FORM_WIP.COMPLETED_PAGES is 'For this form type, the number of pages that have been reviewed in the Quality Control queue. Reviewed pages are tracked if “Require review of scanned pages” is selected in the Quality Control queue properties for the batch class.';
comment on column CORP_ETL_MFB_FORM_WIP.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_FORM_WIP.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_FORM_WIP.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';

create unique index CORP_ETL_MFB_FORM_WIP_IX1 on CORP_ETL_MFB_FORM_WIP(CEMFBF_ID) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage(initial 64K next 1M minextents 1 maxextents unlimited);
alter table CORP_ETL_MFB_FORM_WIP  add primary key (FORM_TYPE_ENTRY_ID) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

create or replace public synonym CORP_ETL_MFB_FORM_WIP for MAXDAT.CORP_ETL_MFB_FORM_WIP;
grant select on CORP_ETL_MFB_FORM_WIP to MAXDAT_READ_ONLY;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_FORM';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_FORM';
   end if;
end;
/
create table CORP_ETL_MFB_FORM(
  CEMFBF_ID NUMBER NOT NULL,
  BATCH_GUID VARCHAR2(38) NOT NULL,
  FORM_TYPE_ENTRY_ID VARCHAR2(38) NOT NULL,
  BATCH_MODULE_ID VARCHAR2(38) NOT NULL,
  TYPE_NAME VARCHAR2(32) NULL,
  DOC_CLASS_NAME VARCHAR2(32) NULL,
  DOC_COUNT NUMBER NULL,
  REJECTED_DOCS NUMBER NULL,
  PAGES NUMBER NULL,
  REJECTED_PAGES NUMBER NULL,
  COMPLETED_DOCS NUMBER NULL,
  COMPLETED_PAGES NUMBER NULL,
  STG_EXTRACT_DATE DATE NOT NULL,
  STG_LAST_UPDATE_DATE DATE NOT NULL,
  STG_PROCESSED_DATE DATE NULL,
  UPDATED VARCHAR2(1) NULL)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_FORM.CEMFBF_ID is 'sequence';
comment on column CORP_ETL_MFB_FORM.BATCH_GUID is 'Unique identifier for the batch.';
comment on column CORP_ETL_MFB_FORM.FORM_TYPE_ENTRY_ID is 'Unique value to identify each form type record created';
comment on column CORP_ETL_MFB_FORM.BATCH_MODULE_ID is 'Unique identifier that indicates the KOFAX Capture module associated with the batch for which a form type record was created. Foreign key to associated record in the StatsBatchModule table.';
comment on column CORP_ETL_MFB_FORM.TYPE_NAME is 'Name of the form type. If the entry is “Loose,” it relates to pages that do not belong to a document. If the entry is “None,” it relates to documents that have not been assigned a form type.';
comment on column CORP_ETL_MFB_FORM.DOC_CLASS_NAME is 'Name of the document class associated with the form type. This is empty when the FormTypeName is Loose or Empty.';
comment on column CORP_ETL_MFB_FORM.DOC_COUNT is 'Number of documents using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM.REJECTED_DOCS is 'Number of rejected documents using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM.PAGES is 'Number of pages using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM.REJECTED_PAGES is 'Number of rejected pages using this form type in the batch.';
comment on column CORP_ETL_MFB_FORM.COMPLETED_DOCS is 'For this form type, the number of documents that have completed processing in the batch.';
comment on column CORP_ETL_MFB_FORM.COMPLETED_PAGES is 'For this form type, the number of pages that have been reviewed in the Quality Control queue. Reviewed pages are tracked if “Require review of scanned pages” is selected in the Quality Control queue properties for the batch class.';
comment on column CORP_ETL_MFB_FORM.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_FORM.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_FORM.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';


create unique index CORP_ETL_MFB_FORM_IX1 on CORP_ETL_MFB_FORM(CEMFBF_ID) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage(initial 64K next 1M minextents 1 maxextents unlimited);
alter table CORP_ETL_MFB_FORM  add primary key (FORM_TYPE_ENTRY_ID) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

alter table CORP_ETL_MFB_FORM add constraint CORP_ETL_MFBF_BATCH_GUID foreign key(BATCH_GUID) references CORP_ETL_MFB_BATCH(BATCH_GUID);

create or replace public synonym CORP_ETL_MFB_FORM for MAXDAT.CORP_ETL_MFB_FORM;
grant select on CORP_ETL_MFB_FORM to MAXDAT_READ_ONLY;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_ENVELOPE_OLTP';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_ENVELOPE_OLTP';
   end if;
end;
/
create table CORP_ETL_MFB_ENVELOPE_OLTP(
  BATCH_GUID VARCHAR2(38) NOT NULL,
  ECN varchar2(255) NOT NULL,
  ENV_RECEIPT_DATE DATE NULL,
  ENV_CREATION_DATE DATE NULL,
  ENV_DOC_COUNT NUMBER NULL,
  ENV_PAGE_COUNT NUMBER NULL,
  STG_EXTRACT_DATE DATE DEFAULT SYSDATE NOT NULL)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_ENVELOPE_OLTP.BATCH_GUID is 'Unique identifier for the batch.';
comment on column CORP_ETL_MFB_ENVELOPE_OLTP.ECN is 'Unique number assigned to each envelope for tracking.';
comment on column CORP_ETL_MFB_ENVELOPE_OLTP.ENV_RECEIPT_DATE is 'The business date that the envelope is received.  If an envelope is received outside of normal business hours, then the date is pushed forward to the next available business day.';
comment on column CORP_ETL_MFB_ENVELOPE_OLTP.ENV_CREATION_DATE is 'The Envelope Creation Date is the date that the envelope is scanned in KOFAX.';
comment on column CORP_ETL_MFB_ENVELOPE_OLTP.ENV_DOC_COUNT is 'The total number of documents that are scanned in a single envelope';
comment on column CORP_ETL_MFB_ENVELOPE_OLTP.ENV_PAGE_COUNT is 'The total number of pages that are scanned in a single envelope.';
comment on column CORP_ETL_MFB_ENVELOPE_OLTP.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';

create or replace public synonym CORP_ETL_MFB_ENVELOPE_OLTP for MAXDAT.CORP_ETL_MFB_ENVELOPE_OLTP;
grant select on CORP_ETL_MFB_ENVELOPE_OLTP to MAXDAT_READ_ONLY;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_ENVELOPE_STG';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_ENVELOPE_STG';
   end if;
end;
/
create table CORP_ETL_MFB_ENVELOPE_STG(
CEMFBE_ID NUMBER NOT NULL,
BATCH_GUID VARCHAR2(38) NOT NULL,
ECN varchar2(255) NOT NULL,
ENV_RECEIPT_DATE DATE NULL,
ENV_CREATION_DATE DATE NULL,
ENV_DOC_COUNT NUMBER NULL,
ENV_PAGE_COUNT NUMBER NULL,
STG_EXTRACT_DATE DATE NOT NULL,
STG_LAST_UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
STG_PROCESSED_DATE DATE NULL,
INSERT_UPDATE VARCHAR2(1) NULL,
STG_INSERT_JOB_ID NUMBER NOT NULL)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_ENVELOPE_STG.CEMFBE_ID is 'sequence';
comment on column CORP_ETL_MFB_ENVELOPE_STG.BATCH_GUID is 'Unique identifier for the batch.';
comment on column CORP_ETL_MFB_ENVELOPE_STG.ECN is 'Unique number assigned to each envelope for tracking.';
comment on column CORP_ETL_MFB_ENVELOPE_STG.ENV_RECEIPT_DATE is 'The business date that the envelope is received.  If an envelope is received outside of normal business hours, then the date is pushed forward to the next available business day.';
comment on column CORP_ETL_MFB_ENVELOPE_STG.ENV_CREATION_DATE is 'The Envelope Creation Date is the date that the envelope is scanned in KOFAX.';
comment on column CORP_ETL_MFB_ENVELOPE_STG.ENV_DOC_COUNT is 'The total number of documents that are scanned in a single envelope';
comment on column CORP_ETL_MFB_ENVELOPE_STG.ENV_PAGE_COUNT is 'The total number of pages that are scanned in a single envelope.';
comment on column CORP_ETL_MFB_ENVELOPE_STG.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_ENVELOPE_STG.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_ENVELOPE_STG.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';

alter table CORP_ETL_MFB_ENVELOPE_STG add primary key (CEMFBE_ID) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

create or replace public synonym CORP_ETL_MFB_ENVELOPE_STG for MAXDAT.CORP_ETL_MFB_ENVELOPE_STG;
grant select on CORP_ETL_MFB_ENVELOPE_STG to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_ENVELOPE_WIP';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_ENVELOPE_WIP';
   end if;
end;
/
create table CORP_ETL_MFB_ENVELOPE_WIP(
  CEMFBE_ID NUMBER NOT NULL,
  BATCH_GUID VARCHAR2(38) NOT NULL,
  ECN varchar2(255) NOT NULL,
  ENV_RECEIPT_DATE DATE NULL,
  ENV_CREATION_DATE DATE NULL,
  ENV_DOC_COUNT NUMBER NULL,
  ENV_PAGE_COUNT NUMBER NULL,
  STG_EXTRACT_DATE DATE NOT NULL,
  STG_LAST_UPDATE_DATE DATE NOT NULL,
  STG_PROCESSED_DATE DATE NULL,
  UPDATED VARCHAR2(1) NULL)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_ENVELOPE_WIP.CEMFBE_ID is 'sequence';
comment on column CORP_ETL_MFB_ENVELOPE_WIP.BATCH_GUID is 'Unique identifier for the batch.';
comment on column CORP_ETL_MFB_ENVELOPE_WIP.ECN is 'Unique number assigned to each envelope for tracking.';
comment on column CORP_ETL_MFB_ENVELOPE_WIP.ENV_RECEIPT_DATE is 'The business date that the envelope is received.  If an envelope is received outside of normal business hours, then the date is pushed forward to the next available business day.';
comment on column CORP_ETL_MFB_ENVELOPE_WIP.ENV_CREATION_DATE is 'The Envelope Creation Date is the date that the envelope is scanned in KOFAX.';
comment on column CORP_ETL_MFB_ENVELOPE_WIP.ENV_DOC_COUNT is 'The total number of documents that are scanned in a single envelope';
comment on column CORP_ETL_MFB_ENVELOPE_WIP.ENV_PAGE_COUNT is 'The total number of pages that are scanned in a single envelope.';
comment on column CORP_ETL_MFB_ENVELOPE_WIP.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_ENVELOPE_WIP.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_ENVELOPE_WIP.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';

alter table CORP_ETL_MFB_ENVELOPE_WIP add primary key (CEMFBE_ID) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

create or replace public synonym CORP_ETL_MFB_ENVELOPE_WIP for MAXDAT.CORP_ETL_MFB_ENVELOPE_WIP;
grant select on CORP_ETL_MFB_ENVELOPE_WIP to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_ENVELOPE';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_ENVELOPE';
   end if;
end;
/
create table CORP_ETL_MFB_ENVELOPE(
  CEMFBE_ID NUMBER NOT NULL,
  BATCH_GUID VARCHAR2(38) NOT NULL,
  ECN varchar2(255) NOT NULL,
  ENV_RECEIPT_DATE DATE NULL,
  ENV_CREATION_DATE DATE NULL,
  ENV_DOC_COUNT NUMBER NULL,
  ENV_PAGE_COUNT NUMBER NULL,
  STG_EXTRACT_DATE DATE NOT NULL,
  STG_LAST_UPDATE_DATE DATE NOT NULL,
  STG_PROCESSED_DATE DATE NULL,
  UPDATED VARCHAR2(1) NULL)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_ENVELOPE.CEMFBE_ID is 'sequence';
comment on column CORP_ETL_MFB_ENVELOPE.BATCH_GUID is 'Unique identifier for the batch.';
comment on column CORP_ETL_MFB_ENVELOPE.ECN is 'Unique number assigned to each envelope for tracking.';
comment on column CORP_ETL_MFB_ENVELOPE.ENV_RECEIPT_DATE is 'The business date that the envelope is received.  If an envelope is received outside of normal business hours, then the date is pushed forward to the next available business day.';
comment on column CORP_ETL_MFB_ENVELOPE.ENV_CREATION_DATE is 'The Envelope Creation Date is the date that the envelope is scanned in KOFAX.';
comment on column CORP_ETL_MFB_ENVELOPE.ENV_DOC_COUNT is 'The total number of documents that are scanned in a single envelope';
comment on column CORP_ETL_MFB_ENVELOPE.ENV_PAGE_COUNT is 'The total number of pages that are scanned in a single envelope.';
comment on column CORP_ETL_MFB_ENVELOPE.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_ENVELOPE.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_ENVELOPE.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';

create unique index CORP_ETL_MFB_ENVELOPE_IX1 on CORP_ETL_MFB_ENVELOPE(CEMFBE_ID) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage(initial 64K next 1M minextents 1 maxextents unlimited);

--alter table CORP_ETL_MFB_ENVELOPE add primary key (BATCH_GUID,ECN) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

alter table CORP_ETL_MFB_ENVELOPE add constraint CORP_ETL_MFBEN_BATCH_GUID foreign key(BATCH_GUID) references CORP_ETL_MFB_BATCH(BATCH_GUID);

create or replace public synonym CORP_ETL_MFB_ENVELOPE for MAXDAT.CORP_ETL_MFB_ENVELOPE;
grant select on CORP_ETL_MFB_ENVELOPE to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_DOCUMENT_OLTP';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_DOCUMENT_OLTP';
   end if;
end;
/
CREATE TABLE CORP_ETL_MFB_DOCUMENT_OLTP(
  BATCH_GUID VARCHAR2(38) NOT NULL,
  ECN varchar2(255) NULL,
  DOC_ID NUMBER NOT NULL,
  DCN VARCHAR2(255) NOT NULL,
  DOC_ORDER_NUMBER NUMBER NOT NULL,
  TYPE_NAME VARCHAR2(50) NOT NULL,
  DOC_CLASS VARCHAR2(50) NOT NULL,
  DOC_RECEIPT_DT DATE NULL,
  DOC_CREATION_DT DATE NULL,
  DOC_PAGE_COUNT NUMBER NOT NULL,
  CLASSIFIED_DOC VARCHAR2(1) NULL,
  DELETED VARCHAR2(1) NOT NULL,
  CONFIDENCE FLOAT(8) NULL,
  CONFIDENT VARCHAR2(1) NULL,
  STG_EXTRACT_DATE DATE DEFAULT SYSDATE NOT NULL)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_DOCUMENT_OLTP.BATCH_GUID is 'The unique number assigned by KOFAX to each envelope within a batch for tracking.';
comment on column CORP_ETL_MFB_DOCUMENT_OLTP.ECN is 'Unique number assigned to each envelope for tracking.';
comment on column CORP_ETL_MFB_DOCUMENT_OLTP.DOC_ID is 'Unique identifier for the document in KOFAX.';
comment on column CORP_ETL_MFB_DOCUMENT_OLTP.DCN is 'Unique identifier to track individual documents. The DCN is created in DMS and saved in the source system.';
comment on column CORP_ETL_MFB_DOCUMENT_OLTP.DOC_ORDER_NUMBER is 'The order number for the document within the batch';
comment on column CORP_ETL_MFB_DOCUMENT_OLTP.TYPE_NAME is 'The document form type name for a given document';
comment on column CORP_ETL_MFB_DOCUMENT_OLTP.DOC_CLASS is 'The document class for the given document ';
comment on column CORP_ETL_MFB_DOCUMENT_OLTP.DOC_RECEIPT_DT is 'The business date that the Document is received. ';
comment on column CORP_ETL_MFB_DOCUMENT_OLTP.DOC_CREATION_DT is 'The Document Creation Date is the date that the Document is scanned in KOFAX.';
comment on column CORP_ETL_MFB_DOCUMENT_OLTP.DOC_PAGE_COUNT is 'The total number of pages that are scanned in a single document.';
comment on column CORP_ETL_MFB_DOCUMENT_OLTP.CLASSIFIED_DOC is 'A flag that indicates that the document is a Classified Document. ';
comment on column CORP_ETL_MFB_DOCUMENT_OLTP.DELETED is 'A flag that indicates that the document was deleted. ';
comment on column CORP_ETL_MFB_DOCUMENT_OLTP.CONFIDENCE is 'The confidence score given to the document during the classification phase.';
comment on column CORP_ETL_MFB_DOCUMENT_OLTP.CONFIDENT is 'The flag that indicates that the system confidently classified the document.';
comment on column CORP_ETL_MFB_DOCUMENT_OLTP.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';

create or replace public synonym CORP_ETL_MFB_DOCUMENT_OLTP for MAXDAT.CORP_ETL_MFB_DOCUMENT_OLTP;
grant select on CORP_ETL_MFB_DOCUMENT_OLTP to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_DOCUMENT_STG';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_DOCUMENT_STG';
   end if;
end;
/
CREATE TABLE CORP_ETL_MFB_DOCUMENT_STG(
  CEMFBD_ID NUMBER NOT NULL,
  BATCH_GUID VARCHAR2(38) NOT NULL,
  ECN varchar2(255) NULL,
  DOC_ID NUMBER NOT NULL,
  DCN VARCHAR2(255) NOT NULL,
  DOC_ORDER_NUMBER NUMBER NOT NULL,
  TYPE_NAME VARCHAR2(50) NOT NULL,
  DOC_CLASS VARCHAR2(50) NOT NULL,
  DOC_RECEIPT_DT DATE NULL,
  DOC_CREATION_DT DATE NULL,
  DOC_PAGE_COUNT NUMBER NOT NULL,
  CLASSIFIED_DOC VARCHAR2(1) NULL,
  DELETED VARCHAR2(1) NOT NULL,
  CONFIDENCE FLOAT(8) NULL,
  CONFIDENT VARCHAR2(1) NULL,
  STG_EXTRACT_DATE DATE NOT NULL,
  STG_LAST_UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  STG_PROCESSED_DATE DATE NULL,
  INSERT_UPDATE VARCHAR2(1) NULL,
  STG_INSERT_JOB_ID NUMBER NOT NULL)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_DOCUMENT_STG.CEMFBD_ID is 'sequence';
comment on column CORP_ETL_MFB_DOCUMENT_STG.BATCH_GUID is 'The unique number assigned by KOFAX to each envelope within a batch for tracking.';
comment on column CORP_ETL_MFB_DOCUMENT_STG.ECN is 'Unique number assigned to each envelope for tracking.';
comment on column CORP_ETL_MFB_DOCUMENT_STG.DOC_ID is 'Unique identifier for the document in KOFAX.';
comment on column CORP_ETL_MFB_DOCUMENT_STG.DCN is 'Unique identifier to track individual documents. The DCN is created in DMS and saved in the source system.';
comment on column CORP_ETL_MFB_DOCUMENT_STG.DOC_ORDER_NUMBER is 'The order number for the document within the batch';
comment on column CORP_ETL_MFB_DOCUMENT_STG.TYPE_NAME is 'The document form type name for a given document';
comment on column CORP_ETL_MFB_DOCUMENT_STG.DOC_CLASS is 'The document class for the given document ';
comment on column CORP_ETL_MFB_DOCUMENT_STG.DOC_RECEIPT_DT is 'The business date that the Document is received. ';
comment on column CORP_ETL_MFB_DOCUMENT_STG.DOC_CREATION_DT is 'The Document Creation Date is the date that the Document is scanned in KOFAX.';
comment on column CORP_ETL_MFB_DOCUMENT_STG.DOC_PAGE_COUNT is 'The total number of pages that are scanned in a single document.';
comment on column CORP_ETL_MFB_DOCUMENT_STG.CLASSIFIED_DOC is 'A flag that indicates that the document is a Classified Document. ';
comment on column CORP_ETL_MFB_DOCUMENT_STG.DELETED is 'A flag that indicates that the document was deleted. ';
comment on column CORP_ETL_MFB_DOCUMENT_STG.CONFIDENCE is 'The confidence score given to the document during the classification phase.';
comment on column CORP_ETL_MFB_DOCUMENT_STG.CONFIDENT is 'The flag that indicates that the system confidently classified the document.';
comment on column CORP_ETL_MFB_DOCUMENT_STG.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_DOCUMENT_STG.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_DOCUMENT_STG.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';

alter table CORP_ETL_MFB_DOCUMENT_STG  add primary key (CEMFBD_ID) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

--alter table CORP_ETL_MFB_DOCUMENT_STG add constraint CHECK_MFB_DS_DOC_TYPE_NM check (TYPE_NAME in('Financial Assistance Application','Non-Financial Assistance Application','SHOP Employer Application','SHOP Employee Application','Birth Certificate','Driver''s License','Passport','Social Security Card','Income Proof','Correspondence','Proof of Legal Status','Loose','None'));
--alter table CORP_ETL_MFB_DOCUMENT_STG add constraint CHECK_MFB_DS_DOC_CLASS check (DOC_CLASS in('Application','Verification'));

create or replace public synonym CORP_ETL_MFB_DOCUMENT_STG for MAXDAT.CORP_ETL_MFB_DOCUMENT_STG;
grant select on CORP_ETL_MFB_DOCUMENT_STG to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_DOCUMENT_WIP';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_DOCUMENT_WIP';
   end if;
end;
/
CREATE TABLE CORP_ETL_MFB_DOCUMENT_WIP(
  CEMFBD_ID NUMBER NOT NULL,
  BATCH_GUID VARCHAR2(38) NOT NULL,
  ECN varchar2(255) NULL,
  DOC_ID NUMBER NOT NULL,
  DCN VARCHAR2(255) NOT NULL,
  DOC_ORDER_NUMBER NUMBER NOT NULL,
  TYPE_NAME VARCHAR2(50) NOT NULL,
  DOC_CLASS VARCHAR2(50) NOT NULL,
  DOC_RECEIPT_DT DATE NULL,
  DOC_CREATION_DT DATE NULL,
  DOC_PAGE_COUNT NUMBER NOT NULL,
  CLASSIFIED_DOC VARCHAR2(1) NULL,
  DELETED VARCHAR2(1) NOT NULL,
  CONFIDENCE FLOAT(8) NULL,
  CONFIDENT VARCHAR2(1) NULL,
  STG_EXTRACT_DATE DATE NOT NULL,
  STG_LAST_UPDATE_DATE DATE NOT NULL,
  STG_PROCESSED_DATE DATE NULL,
  UPDATED VARCHAR2(1) NULL)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_DOCUMENT_WIP.CEMFBD_ID is 'sequence';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.BATCH_GUID is 'The unique number assigned by KOFAX to each envelope within a batch for tracking.';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.ECN is 'Unique number assigned to each envelope for tracking.';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.DOC_ID is 'Unique identifier for the document in KOFAX.';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.DCN is 'Unique identifier to track individual documents. The DCN is created in DMS and saved in the source system.';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.DOC_ORDER_NUMBER is 'The order number for the document within the batch';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.TYPE_NAME is 'The document form type name for a given document';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.DOC_CLASS is 'The document class for the given document ';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.DOC_RECEIPT_DT is 'The business date that the Document is received. ';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.DOC_CREATION_DT is 'The Document Creation Date is the date that the Document is scanned in KOFAX.';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.DOC_PAGE_COUNT is 'The total number of pages that are scanned in a single document.';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.CLASSIFIED_DOC is 'A flag that indicates that the document is a Classified Document. ';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.DELETED is 'A flag that indicates that the document was deleted. ';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.CONFIDENCE is 'The confidence score given to the document during the classification phase.';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.CONFIDENT is 'The flag that indicates that the system confidently classified the document.';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_DOCUMENT_WIP.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';

alter table CORP_ETL_MFB_DOCUMENT_WIP  add primary key (CEMFBD_ID) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

create or replace public synonym CORP_ETL_MFB_DOCUMENT_WIP for MAXDAT.CORP_ETL_MFB_DOCUMENT_WIP;
grant select on CORP_ETL_MFB_DOCUMENT_WIP to MAXDAT_READ_ONLY;


declare  c int;
begin
   select count(*) into c from user_tables where table_name ='CORP_ETL_MFB_DOCUMENT';
   if c = 1 then
      execute immediate 'drop table CORP_ETL_MFB_DOCUMENT';
   end if;
end;
/
CREATE TABLE CORP_ETL_MFB_DOCUMENT(
  CEMFBD_ID NUMBER NOT NULL,
  BATCH_GUID VARCHAR2(38) NOT NULL,
  ECN varchar2(255) NULL,
  DOC_ID NUMBER NOT NULL,
  DCN VARCHAR2(255) NOT NULL,
  DOC_ORDER_NUMBER NUMBER NOT NULL,
  TYPE_NAME VARCHAR2(50) NOT NULL,
  DOC_CLASS VARCHAR2(50) NOT NULL,
  DOC_RECEIPT_DT DATE NULL,
  DOC_CREATION_DT DATE NULL,
  DOC_PAGE_COUNT NUMBER NOT NULL,
  CLASSIFIED_DOC VARCHAR2(1) NULL,
  DELETED VARCHAR2(1) NOT NULL,
  CONFIDENCE FLOAT(8) NULL,
  CONFIDENT VARCHAR2(1) NULL,
  STG_EXTRACT_DATE DATE NOT NULL,
  STG_LAST_UPDATE_DATE DATE NOT NULL,
  STG_PROCESSED_DATE DATE NULL,
  UPDATED VARCHAR2(1) NULL)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on column CORP_ETL_MFB_DOCUMENT.CEMFBD_ID is 'sequence';
comment on column CORP_ETL_MFB_DOCUMENT.BATCH_GUID is 'The unique number assigned by KOFAX to each envelope within a batch for tracking.';
comment on column CORP_ETL_MFB_DOCUMENT.ECN is 'Unique number assigned to each envelope for tracking.';
comment on column CORP_ETL_MFB_DOCUMENT.DOC_ID is 'Unique identifier for the document in KOFAX.';
comment on column CORP_ETL_MFB_DOCUMENT.DCN is 'Unique identifier to track individual documents. The DCN is created in DMS and saved in the source system.';
comment on column CORP_ETL_MFB_DOCUMENT.DOC_ORDER_NUMBER is 'The order number for the document within the batch';
comment on column CORP_ETL_MFB_DOCUMENT.TYPE_NAME is 'The document form type name for a given document';
comment on column CORP_ETL_MFB_DOCUMENT.DOC_CLASS is 'The document class for the given document ';
comment on column CORP_ETL_MFB_DOCUMENT.DOC_RECEIPT_DT is 'The business date that the Document is received. ';
comment on column CORP_ETL_MFB_DOCUMENT.DOC_CREATION_DT is 'The Document Creation Date is the date that the Document is scanned in KOFAX.';
comment on column CORP_ETL_MFB_DOCUMENT.DOC_PAGE_COUNT is 'The total number of pages that are scanned in a single document.';
comment on column CORP_ETL_MFB_DOCUMENT.CLASSIFIED_DOC is 'A flag that indicates that the document is a Classified Document. ';
comment on column CORP_ETL_MFB_DOCUMENT.DELETED is 'A flag that indicates that the document was deleted. ';
comment on column CORP_ETL_MFB_DOCUMENT.CONFIDENCE is 'The confidence score given to the document during the classification phase.';
comment on column CORP_ETL_MFB_DOCUMENT.CONFIDENT is 'The flag that indicates that the system confidently classified the document.';
comment on column CORP_ETL_MFB_DOCUMENT.STG_EXTRACT_DATE is 'STG_EXTRACT_DATE';
comment on column CORP_ETL_MFB_DOCUMENT.STG_PROCESSED_DATE is 'Date that this row was successfully loaded to ETL.';
comment on column CORP_ETL_MFB_DOCUMENT.STG_LAST_UPDATE_DATE is 'STG_LAST_UPDATE_DATE';

alter table CORP_ETL_MFB_DOCUMENT add primary key (CEMFBD_ID,DOC_ID) using index tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

alter table CORP_ETL_MFB_DOCUMENT add constraint CORP_ETL_MFBD_BATCH_GUID foreign key(BATCH_GUID) references CORP_ETL_MFB_BATCH(BATCH_GUID);

--alter table CORP_ETL_MFB_DOCUMENT add constraint CHECK_MFB_D_DOC_TYPE_NM check (TYPE_NAME in('Financial Assistance Application','Non-Financial Assistance Application','SHOP Employer Application','SHOP Employee Application','Birth Certificate','Driver''s License','Passport','Social Security Card','Income Proof','Correspondence','Proof of Legal Status','Loose','None'));
--alter table CORP_ETL_MFB_DOCUMENT add constraint CHECK_MFB_D_DOC_CLASS check (DOC_CLASS in('Application','Verification'));

create or replace public synonym CORP_ETL_MFB_DOCUMENT for MAXDAT.CORP_ETL_MFB_DOCUMENT;
grant select on CORP_ETL_MFB_DOCUMENT to MAXDAT_READ_ONLY;



