--create all NYHIX Mail Fax Doc staging tables

CREATE TABLE NYHIX_ETL_MAIL_FAX_DOC
(EEMFDB_ID NUMBER(18,0) NOT NULL,
 DCN VARCHAR2(256) NOT NULL,
 KOFAX_DCN varchar2(256) NOT NULL,
 PREVIOUS_KOFAX_DCN varchar2(256),
 CREATE_DT DATE,
 ECN VARCHAR2(256),
 INSTANCE_STATUS VARCHAR2(32) NOT NULL,
 INSTANCE_STATUS_DT DATE,
 BATCH_ID NUMBER(38,0) default 0 NOT NULL,
 BATCH_NAME VARCHAR2(255),	
 CHANNEL VARCHAR2(32) NOT NULL,
 PAGE_COUNT NUMBER(18,0) default 0,
 DOC_STATUS_CD VARCHAR2(32) NOT NULL,
 DOC_STATUS_DT DATE default sysdate,
 ENV_STATUS_CD VARCHAR2(32) default 'RECEIVED',
 ENV_STATUS_DT DATE,
 DOC_TYPE_CD VARCHAR2(32) default 'UNKNOWN' NOT NULL,
 DOC_SUBTYPE_CD VARCHAR2(32) default 'UNKNOWN' NOT NULL,
 FORM_TYPE_CD VARCHAR2(70) default 'UNKNOWN' NOT NULL,
 FREE_FORM_TXT_IND VARCHAR2(1),
 --RECEIPT_DT DATE,
 SCAN_DT DATE NOT NULL,
 RELEASE_DT DATE NOT NULL,
 ASSD_MAXE_CREATE_DOC DATE,
 ASED_MAXE_CREATE_DOC DATE,
 DOCUMENT_ID NUMBER(18,0),	
 DOC_SET_ID NUMBER(18,0),
 MAXe_DOC_CREATE_DT DATE,
 LANGUAGE VARCHAR2(32),
 CURRENT_TASK_ID number(18,0),
 CURRENT_STEP VARCHAR2(256),
 ASSD_CREATE_COMPLAINT DATE,
 ASED_CREATE_COMPLAINT DATE,
 COMPLAINT_DE_TASK_ID NUMBER(18,0),
 ASSD_CREATE_APPEAL DATE,
 ASED_CREATE_APPEAL DATE,
 APPEAL_DE_TASK_ID NUMBER(18,0),
 INCIDENT_ID NUMBER(18,0),
 ASSD_HSDE_QC DATE,
 ASED_HSDE_QC DATE,
 HSDE_ERR_IND VARCHAR2(1),
 HSDE_QC_TASK_ID NUMBER(18,0),
 ASSD_MANUAL_LINK_DOC DATE,
 ASED_MANUAL_LINK_DOC DATE,
 MANUAL_LINK_TASK_ID NUMBER(18,0),
 ASSD_DOCSETLINK_QC DATE,
 ASED_DOCSETLINK_QC DATE,
 DOCSETLINK_QC_TASK_ID NUMBER(18,0),
 ASSD_RESOLVE_ESC_TASK DATE,
 ASED_RESOLVE_ESC_TASK DATE,
 ESC_TASK_ID NUMBER(18,0),
 ASSD_DATA_ENTRY DATE,
 ASED_DATA_ENTRY DATE,
 DE_TASK_ID NUMBER(18,0),
 ASSD_MAXIMUS_QC DATE,
 ASED_MAXIMUS_QC DATE,
 MAXIMUS_QC_TASK_ID NUMBER(18,0),
 ASSD_RESOLVE_ESC_TASK2	DATE,
 ASED_RESOLVE_ESC_TASK2	DATE,
 ESC_TASK_ID2 NUMBER(18,0),
 ASSD_TRANSMIT_TO_NYHBE	DATE,
 ASED_TRANSMIT_TO_NYHBE	DATE,
 CANCEL_DT DATE,
 CANCEL_BY VARCHAR2(32),
 CANCEL_REASON VARCHAR2(32),
 CANCEL_METHOD VARCHAR2(32),
 LINK_METHOD VARCHAR2(32),
 LINK_ID NUMBER(18,0),
 LINKED_CLIENT NUMBER(18,0),
 --DOC_COMPLETE_DT date,
 COMPLETE_DT DATE,
 RESCANNED_IND VARCHAR2(1),
 RETURNED_MAIL_IND VARCHAR2(1),
 RETURNED_MAIL_REASON VARCHAR2(32),	
 RESCAN_COUNT NUMBER(18,0) default 0,
 UPDATED_BY VARCHAR2(80),
 UPDATE_DT DATE,
 TRASHED_IND VARCHAR2(1),
 NOTE_ID VARCHAR2(32),
 ORIG_DOC_TYPE_CD VARCHAR2(32),
 ORIG_DOC_FORM_TYPE_CD VARCHAR2(32),
 EXPEDITED_IND VARCHAR2(1),
 RESEARCH_REQ_IND VARCHAR2(1),
 ASF_MAXE_CREATE_DOC VARCHAR2(1) default 'N' not null,
 ASF_CREATE_COMPLAINT VARCHAR2(1) default 'N' not null,
 ASF_CREATE_APPEAL VARCHAR2(1) default 'N' not null,
 ASF_HSDE_QC VARCHAR2(1) default 'N' not null,
 ASF_MANUAL_LINK_DOC VARCHAR2(1) default 'N' not null,
 ASF_DOCSETLINK_QC VARCHAR2(1) default 'N' not null,
 ASF_RESOLVE_ESC_TASK VARCHAR2(1) default 'N' not null,
 ASF_DATA_ENTRY VARCHAR2(1) default 'N' not null,
 ASF_MAXIMUS_QC VARCHAR2(1) default 'N' not null,
 ASF_RESOLVE_ESC_TASK2 VARCHAR2(1) default 'N' not null,
 ASF_TRANSMIT_TO_NYHBE VARCHAR2(1) default 'N' not null,
 GWF_HSDE_QC_REQ VARCHAR2(1),
 GWF_AUTOLINK_SUCCESS VARCHAR2(1),
 GWF_DOCSETLINK_QC_REQ VARCHAR2(1),
 GWF_DATA_ENTRY_REQ VARCHAR2(1),
 GWF_MAXIMUS_QC_REQ VARCHAR2(1),
 STG_EXTRACT_DT DATE default SYSDATE not null,
 STAGE_DONE_DT DATE,
 STG_LAST_UPDATE_DT DATE
)TABLESPACE MAXDAT_DATA PARALLEL;


-- Create/Recreate indexes 
--Unique
create unique index  NYHIX_ETL_MFD_IX1 on  NYHIX_ETL_MAIL_FAX_DOC (DCN)  tablespace MAXDAT_INDX;

--indexes
create index IDX_MAILFAXDOC_ECN on NYHIX_ETL_MAIL_FAX_DOC (ECN) TABLESPACE  MAXDAT_INDX ;
create index IDX_MAILFAXDOC_BATCH_ID on NYHIX_ETL_MAIL_FAX_DOC (BATCH_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX_MAILFAXDOC_COMP_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC (COMPLAINT_DE_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX_MAILFAXDOC_APPEAL_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC (APPEAL_DE_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX_MAILFAXDOC_HSDE_QC_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC (HSDE_QC_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX_MAILFAXDOC_MAN_LINK_TSK_ID on NYHIX_ETL_MAIL_FAX_DOC (MANUAL_LINK_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX_MAILFAXDOC_DOCS_QC_TSK_ID on NYHIX_ETL_MAIL_FAX_DOC (DOCSETLINK_QC_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX_MAILFAXDOC_ESC_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC (ESC_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX_MAILFAXDOC_DE_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC (DE_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX_MAILFAXDOC_MAX_QC_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC (MAXIMUS_QC_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX_MAILFAXDOC_ESC_TASK_ID2 on NYHIX_ETL_MAIL_FAX_DOC (ESC_TASK_ID2) TABLESPACE MAXDAT_INDX ;
create index IDX_MAILFAXDOC_DOC_SET_ID on NYHIX_ETL_MAIL_FAX_DOC (DOC_SET_ID) TABLESPACE MAXDAT_INDX ;
create index IDX_MAILFAXDOC_INCIDENT_ID on NYHIX_ETL_MAIL_FAX_DOC (INCIDENT_ID) TABLESPACE MAXDAT_INDX ;
create index IDX_MAILFAXDOC_LINK_ID on NYHIX_ETL_MAIL_FAX_DOC (LINK_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX_MAILFAXDOC_LINKED_CLIENT on NYHIX_ETL_MAIL_FAX_DOC (LINKED_CLIENT) TABLESPACE MAXDAT_INDX;
create index IDX_MAILFAXDOC_KOFAX_DCN on NYHIX_ETL_MAIL_FAX_DOC (KOFAX_DCN) TABLESPACE MAXDAT_INDX;



--Constraints

alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_ASF_MAXE_CREATE_DOC check (ASF_MAXE_CREATE_DOC in('Y','N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_ASF_CREATE_COMPLAINT check (ASF_CREATE_COMPLAINT in('Y','N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_ASF_CREATE_APPEAL check (ASF_CREATE_APPEAL in('Y','N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_ASF_HSDE_QC check (ASF_HSDE_QC in ('Y','N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_ASF_MANUAL_LINK_DOC check (ASF_MANUAL_LINK_DOC in('Y','N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_ASF_DOCSETLINK_QC check (ASF_DOCSETLINK_QC in('Y','N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_ASF_RESOLVE_ESC_TASK check (ASF_RESOLVE_ESC_TASK in('Y','N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_ASF_DATA_ENTRY check (ASF_DATA_ENTRY in ('Y','N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_ASF_MAXIMUS_QC check (ASF_MAXIMUS_QC in ('Y','N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MF_ASF_RESOLVE_ESC_TASK2 check (ASF_RESOLVE_ESC_TASK2 in('Y','N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_ASF_TRAN_TO_NYHBE check (ASF_TRANSMIT_TO_NYHBE in('Y','N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_RESEARCH_REQU_IND check (RESEARCH_REQ_IND in('Y', 'N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_EXPEDITED_IND check (EXPEDITED_IND in ('Y', 'N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_FREE_FORM_TXT_IND check (FREE_FORM_TXT_IND in('Y', 'N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_HSDE_ERR_IND check (HSDE_ERR_IND in('Y', 'N', 'N/A'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_RESCANNED_IND check (RESCANNED_IND in ('Y', 'N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_RETURNED_MAIL_IND check  (RETURNED_MAIL_IND in('Y', 'N'));
alter table NYHIX_ETL_MAIL_FAX_DOC add constraint CHECK_MFD_TRASHED_IND check (TRASHED_IND in('Y', 'N'));



--Comments
comment on column NYHIX_ETL_MAIL_FAX_DOC.EEMFDB_ID is 'Sequence';
comment on column NYHIX_ETL_MAIL_FAX_DOC.DCN is 'Unique identifier to track individual documents. The dcn is created in dms and saved in the source system.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.CREATE_DT is 'The date that the dcn is assigned by dms.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ECN is 'Unique number assigned to each envelope for tracking.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.INSTANCE_STATUS is 'Indicates if the document instance is in process or not. When the document is created the status is set to active, and it remains active until the document has been successfully processed  is cancelled, or otherwise deleted when it is then set to complete.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.INSTANCE_STATUS_DT is 'The date that the instance status is set';
comment on column NYHIX_ETL_MAIL_FAX_DOC.BATCH_ID is 'Unique identifier for the batch from which the document was received from kofax. ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.CHANNEL is 'The channel identifies the channel from which the document was originally received (mail or fax) into kofax or via the web.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.PAGE_COUNT is 'Count of individual pages in a document.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.DOC_STATUS_CD is 'This is the document status assigned by the system during the imaging process. ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.DOC_STATUS_DT is 'This is the status date for the current document status.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ENV_STATUS_CD is 'This is the envelope status assigned by the system during the imaging process.  ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ENV_STATUS_DT is 'This is the status date for the current envelope status.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.DOC_TYPE_CD is 'The document type is the high level description of a document in an envelope.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.DOC_SUBTYPE_CD is 'The document subtype is a specification of the general document type for the document';
comment on column NYHIX_ETL_MAIL_FAX_DOC.FORM_TYPE_CD is 'The document form type is the description of the form returned by the client.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.FREE_FORM_TXT_IND is 'Indicates whether the document is flagged as free form text ';
--comment on column NYHIX_ETL_MAIL_FAX_DOC.RECEIPT_DT is 'The date the document was received in the mailroom or by nyhbe system';
comment on column NYHIX_ETL_MAIL_FAX_DOC.SCAN_DT is 'The date the document was scanned into kofax';
comment on column NYHIX_ETL_MAIL_FAX_DOC.RELEASE_DT is 'The date the document was released from kofax';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASSD_MAXE_CREATE_DOC is 'The time stamp when the maxe create doc activity step starts.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASED_MAXE_CREATE_DOC is 'The time stamp when the maxe create doc activity step ends.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.DOCUMENT_ID is 'Unique identifier for a document record in maxe';
comment on column NYHIX_ETL_MAIL_FAX_DOC.DOC_SET_ID is 'Unique identifier of a set of documents in maxe';
comment on column NYHIX_ETL_MAIL_FAX_DOC.MAXe_DOC_CREATE_DT is 'The date that the document is created in maxe';
comment on column NYHIX_ETL_MAIL_FAX_DOC.LANGUAGE is 'The documents language';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASSD_CREATE_COMPLAINT is 'The date stamp when the create complaint activity step starts.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASED_CREATE_COMPLAINT is 'The date stamp when the create complaint activity step ends. ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.COMPLAINT_DE_TASK_ID is ' Task id for a complaint data entry task from the document';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASSD_CREATE_APPEAL is 'The date stamp when the create appeal activity step starts.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASED_CREATE_APPEAL is 'The date stamp when the create appeal activity step ends.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.APPEAL_DE_TASK_ID is 'Task id for an appeal from the document';
comment on column NYHIX_ETL_MAIL_FAX_DOC.INCIDENT_ID is 'The incident initiated by a document created for either a complaint or appeal ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASSD_HSDE_QC is 'The date stamp when the hsde qc activity step starts.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASED_HSDE_QC is 'The date stamp when the hsde qc activity step ends.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.HSDE_ERR_IND is 'Indicates whether this document has an hsde error or whether it is simply in an envelope with another document that has an error';
comment on column NYHIX_ETL_MAIL_FAX_DOC.HSDE_QC_TASK_ID is 'Task id for hsde qc ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASSD_MANUAL_LINK_DOC is 'The date stamp when the manual link doc activity step starts.  ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASED_MANUAL_LINK_DOC is 'The date stamp when the manual link doc activity step ends.  ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.MANUAL_LINK_TASK_ID is 'Task id for manual linking doc set ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASSD_DOCSETLINK_QC is 'The date stamp when the doc set link activity step starts. ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASED_DOCSETLINK_QC is 'The date stamp when the doc set link activity step ends. ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.DOCSETLINK_QC_TASK_ID is ' Task id for doc set link qc task';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASSD_RESOLVE_ESC_TASK is 'The date stamp when the resolve escalated activity step starts. ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASED_RESOLVE_ESC_TASK is 'The date stamp when the resolve escalated activity step ends. ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ESC_TASK_ID is 'Task id for escalated task';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASSD_DATA_ENTRY is 'The date stamp when the data entry activity step starts. ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASED_DATA_ENTRY is 'The date stamp when the data entry activity step ends. ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.DE_TASK_ID is 'Task id for data entry task';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASSD_MAXIMUS_QC is 'The date stamp when the maximus qc activity step starts.  ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASED_MAXIMUS_QC is 'The date stamp when the maximus qc activity step ends.  ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.MAXIMUS_QC_TASK_ID is 'Task id for maximus qc task';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASSD_RESOLVE_ESC_TASK2 is 'The date stamp when the resolve escalated task2 activity step starts.  ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASED_RESOLVE_ESC_TASK2 is 'The date stamp when the resolve escalated task2 activity step ends.  ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ESC_TASK_ID2 is 'Task id for escalated task';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASSD_TRANSMIT_TO_NYHBE is 'The date when the document is transmit to nyhbe starts';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASED_TRANSMIT_TO_NYHBE is 'The date when the document is transmit to nyhbe ends';
comment on column NYHIX_ETL_MAIL_FAX_DOC.CANCEL_DT is 'The cancel date is set when the instance is confirmed cancelled, logically deleted, or otherwise discarded.';
comment on column NYHIX_ETL_MAIL_FAX_DOC.CANCEL_BY is 'The performer who cancelled the batch.  Note that the performer may be a system';
comment on column NYHIX_ETL_MAIL_FAX_DOC.CANCEL_REASON is 'The reason the instance was cancelled';
comment on column NYHIX_ETL_MAIL_FAX_DOC.CANCEL_METHOD is 'The method by which the instance was cancelled';
comment on column NYHIX_ETL_MAIL_FAX_DOC.LINK_METHOD is 'Link method';
comment on column NYHIX_ETL_MAIL_FAX_DOC.LINK_ID is 'The id of the document link record';
comment on column NYHIX_ETL_MAIL_FAX_DOC.LINKED_CLIENT is 'The client that the document is associated with ';
comment on column NYHIX_ETL_MAIL_FAX_DOC.COMPLETE_DT is 'Date the image was sent to nyhbe, incident created, or follow up work created (terminal state).';
comment on column NYHIX_ETL_MAIL_FAX_DOC.RESCANNED_IND is 'Indicator for if a doc is rescanned';
comment on column NYHIX_ETL_MAIL_FAX_DOC.RETURNED_MAIL_IND is 'Indicator for if a doc is returned mail';
comment on column NYHIX_ETL_MAIL_FAX_DOC.RETURNED_MAIL_REASON is 'Reason code for why a doc is returned mail';
comment on column NYHIX_ETL_MAIL_FAX_DOC.RESCAN_COUNT is 'Number of times a document was rescanned';
comment on column NYHIX_ETL_MAIL_FAX_DOC.UPDATED_BY is 'Last user to update the document in maxe';
comment on column NYHIX_ETL_MAIL_FAX_DOC.UPDATE_DT is 'Date of the last update to the document in maxe';
comment on column NYHIX_ETL_MAIL_FAX_DOC.TRASHED_IND is 'Indicator for if a document is trashed in maxe';
comment on column NYHIX_ETL_MAIL_FAX_DOC.NOTE_ID is 'Id of a note related to a document in maxe';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ORIG_DOC_TYPE_CD is 'Original document type if a document is reclassified';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ORIG_DOC_FORM_TYPE_CD is 'Original document type if a document is reclassified';
comment on column NYHIX_ETL_MAIL_FAX_DOC.EXPEDITED_IND is 'Indicator for if the document was marked as expedited in maxe';
comment on column NYHIX_ETL_MAIL_FAX_DOC.RESEARCH_REQ_IND is 'Indicator for if research has been requested on a  document';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASF_MAXE_CREATE_DOC is 'Maxe create doc activity step flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASF_CREATE_COMPLAINT is 'Create complaint activity step flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASF_CREATE_APPEAL is 'Create appeal activity step flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASF_HSDE_QC is 'Resolve hsde qc task activity step flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASF_MANUAL_LINK_DOC is 'Manual link doc activity step flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASF_DOCSETLINK_QC is 'Doc set link qc activity step flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASF_RESOLVE_ESC_TASK is 'Resolve escalated task activity step flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASF_DATA_ENTRY is 'Data entry activity step flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASF_MAXIMUS_QC is 'Maximus qc activity step flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASF_RESOLVE_ESC_TASK2 is 'Resolve escalated task 2 activity step flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.ASF_TRANSMIT_TO_NYHBE is 'Transmit to nyhbe activity step flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.GWF_HSDE_QC_REQ is 'Hsde qc req gateway flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.GWF_AUTOLINK_SUCCESS is 'Autolink successful gateway flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.GWF_DOCSETLINK_QC_REQ is 'Doc set link qc req gateway flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.GWF_DATA_ENTRY_REQ is 'Data entry req gateway flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.GWF_MAXIMUS_QC_REQ is 'Maximus qc req gateway flag';
comment on column NYHIX_ETL_MAIL_FAX_DOC.STG_EXTRACT_DT is 'Date the document was extracted';
comment on column NYHIX_ETL_MAIL_FAX_DOC.STAGE_DONE_DT is '';
comment on column NYHIX_ETL_MAIL_FAX_DOC.STG_LAST_UPDATE_DT is 'Last updated date';

--CREATE PRIMARY KEY
alter table  NYHIX_ETL_MAIL_FAX_DOC add primary key (EEMFDB_ID)  using index   tablespace MAXDAT_INDX;

--GRANTS & PUBLIC SYNONYMNS
create or replace public synonym NYHIX_ETL_MAIL_FAX_DOC for NYHIX_ETL_MAIL_FAX_DOC;

Grant select on NYHIX_ETL_MAIL_FAX_DOC to MAXDAT_READ_ONLY;

--CREATE OLTP TABLE
CREATE TABLE NYHIX_ETL_MAIL_FAX_DOC_OLTP
(EEMFDB_ID NUMBER(18,0) NOT NULL,
 DCN VARCHAR2(256) NOT NULL,
 KOFAX_DCN varchar2(256) NOT NULL,
 PREVIOUS_KOFAX_DCN varchar2(256),
 CREATE_DT DATE,
 ECN VARCHAR2(256),
 INSTANCE_STATUS VARCHAR2(32) NOT NULL,
 INSTANCE_STATUS_DT DATE,
 BATCH_ID NUMBER(38,0) default 0 NOT NULL,
 BATCH_NAME VARCHAR2(255),
 CHANNEL VARCHAR2(32) NOT NULL,
 PAGE_COUNT NUMBER(18,0) default 0,
 DOC_STATUS_CD VARCHAR2(32) NOT NULL,
 DOC_STATUS_DT DATE default sysdate,
 ENV_STATUS_CD VARCHAR2(32) default 'RECEIVED',
 ENV_STATUS_DT DATE,
 DOC_TYPE_CD VARCHAR2(32) default 'UNKNOWN' NOT NULL,
 DOC_SUBTYPE_CD VARCHAR2(32) default 'UNKNOWN' NOT NULL,
 FORM_TYPE_CD VARCHAR2(70) default 'UNKNOWN' NOT NULL,
 FREE_FORM_TXT_IND VARCHAR2(1),
 --RECEIPT_DT DATE,
 SCAN_DT DATE NOT NULL,
 RELEASE_DT DATE NOT NULL,
 ASSD_MAXE_CREATE_DOC DATE,
 ASED_MAXE_CREATE_DOC DATE,
 DOCUMENT_ID NUMBER(18,0),	
 DOC_SET_ID NUMBER(18,0),
 MAXe_DOC_CREATE_DT DATE,
 LANGUAGE VARCHAR2(32),
 CURRENT_TASK_ID number(18,0),
 CURRENT_STEP VARCHAR2(256),
 APP_DOC_TRACKER_ID number(18,0),
 DOCUMENT_NOTIFICATION_ID number(18,0),
 ACCOUNT_ID number(18,0),
 ASSD_CREATE_COMPLAINT DATE,
 ASED_CREATE_COMPLAINT DATE,
 COMPLAINT_DE_TASK_ID NUMBER(18,0),
 ASSD_CREATE_APPEAL DATE,
 ASED_CREATE_APPEAL DATE,
 APPEAL_DE_TASK_ID NUMBER(18,0),
 INCIDENT_ID NUMBER(18,0),
 ASSD_HSDE_QC DATE,
 ASED_HSDE_QC DATE,
 HSDE_ERR_IND VARCHAR2(1),
 HSDE_QC_TASK_ID NUMBER(18,0),
 ASSD_MANUAL_LINK_DOC DATE,
 ASED_MANUAL_LINK_DOC DATE,
 MANUAL_LINK_TASK_ID NUMBER(18,0),
 ASSD_DOCSETLINK_QC DATE,
 ASED_DOCSETLINK_QC DATE,
 DOCSETLINK_QC_TASK_ID NUMBER(18,0),
 ASSD_RESOLVE_ESC_TASK DATE,
 ASED_RESOLVE_ESC_TASK DATE,
 ESC_TASK_ID NUMBER(18,0),
 ASSD_DATA_ENTRY DATE,
 ASED_DATA_ENTRY DATE,
 DE_TASK_ID NUMBER(18,0),
 ASSD_MAXIMUS_QC DATE,
 ASED_MAXIMUS_QC DATE,
 MAXIMUS_QC_TASK_ID NUMBER(18,0),
 ASSD_RESOLVE_ESC_TASK2	DATE,
 ASED_RESOLVE_ESC_TASK2	DATE,
 ESC_TASK_ID2 NUMBER(18,0),
 ASSD_TRANSMIT_TO_NYHBE	DATE,
 ASED_TRANSMIT_TO_NYHBE	DATE,
 CANCEL_DT DATE,
 CANCEL_BY VARCHAR2(32),
 CANCEL_REASON VARCHAR2(32),
 CANCEL_METHOD VARCHAR2(32),
 LINK_METHOD VARCHAR2(32),
 LINK_ID NUMBER(18,0),
 LINKED_CLIENT NUMBER(18,0),
 --DOC_COMPLETE_DT date,
 COMPLETE_DT DATE,
 RESCANNED_IND VARCHAR2(1),
 RETURNED_MAIL_IND VARCHAR2(1),
 RETURNED_MAIL_REASON VARCHAR2(32),	
 RESCAN_COUNT NUMBER(18,0) default 0,
 UPDATED_BY VARCHAR2(80),
 UPDATE_DT DATE,
 TRASHED_IND VARCHAR2(1),
 NOTE_ID VARCHAR2(32),
 ORIG_DOC_TYPE_CD VARCHAR2(32),
 ORIG_DOC_FORM_TYPE_CD VARCHAR2(32),
 EXPEDITED_IND VARCHAR2(1),
 RESEARCH_REQ_IND VARCHAR2(1),
 ASF_MAXE_CREATE_DOC VARCHAR2(1) default 'N' not null,
 ASF_CREATE_COMPLAINT VARCHAR2(1) default 'N' not null,
 ASF_CREATE_APPEAL VARCHAR2(1) default 'N' not null,
 ASF_HSDE_QC VARCHAR2(1) default 'N' not null,
 ASF_MANUAL_LINK_DOC VARCHAR2(1) default 'N' not null,
 ASF_DOCSETLINK_QC VARCHAR2(1) default 'N' not null,
 ASF_RESOLVE_ESC_TASK VARCHAR2(1) default 'N' not null,
 ASF_DATA_ENTRY VARCHAR2(1) default 'N' not null,
 ASF_MAXIMUS_QC VARCHAR2(1) default 'N' not null,
 ASF_RESOLVE_ESC_TASK2 VARCHAR2(1) default 'N' not null,
 ASF_TRANSMIT_TO_NYHBE VARCHAR2(1) default 'N' not null,
 GWF_HSDE_QC_REQ VARCHAR2(1),
 GWF_AUTOLINK_SUCCESS VARCHAR2(1),
 GWF_DOCSETLINK_QC_REQ VARCHAR2(1),
 GWF_DATA_ENTRY_REQ VARCHAR2(1),
 GWF_MAXIMUS_QC_REQ VARCHAR2(1),
 STG_EXTRACT_DT DATE default SYSDATE not null,
 STAGE_DONE_DT DATE,
 STG_LAST_UPDATE_DT DATE,
 UPDATED varchar2(1),
 STG_INSERT_UPDATE varchar2(1),
 STG_INSERT_JOB_ID number(18,0),
 APP_DOC_DATA_ID NUMBER(32), 
 LINK_REF_ID NUMBER(32),
 PROCESS_INSTANCE_ID number(18,0),
 ACCOUNT_ID number(18,0),
 DOCUMENT_NOTIFICATION_ID number(18,0)
)TABLESPACE MAXDAT_DATA PARALLEL;

--indexes OLTP
--Unique
create unique index  NYHIX_ETL_MFD_OLTP_IX1 on  NYHIX_ETL_MAIL_FAX_DOC_OLTP (DCN)  tablespace MAXDAT_INDX;

create index IDX1_MAILFAXDOC_EEMFDB_ID on NYHIX_ETL_MAIL_FAX_DOC_OLTP (EEMFDB_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX1_MAILFAXDOC_ECN on NYHIX_ETL_MAIL_FAX_DOC_OLTP (ECN) TABLESPACE  MAXDAT_INDX ;
create index IDX1_MAILFAXDOC_BATCH_ID on NYHIX_ETL_MAIL_FAX_DOC_OLTP (BATCH_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX1_MAILFAXDOC_COMP_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC_OLTP (COMPLAINT_DE_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX1_MAILFAXDOC_APPEAL_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC_OLTP (APPEAL_DE_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX1_MAILFAXDOC_HSDEQC_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC_OLTP (HSDE_QC_TASK_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX1_MAILFAXDOC_MAN_LNK_TSK_ID on NYHIX_ETL_MAIL_FAX_DOC_OLTP (MANUAL_LINK_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX1_MAILFAXDOC_DOCS_QC_TSK_ID on NYHIX_ETL_MAIL_FAX_DOC_OLTP (DOCSETLINK_QC_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX1_MAILFAXDOC_ESC_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC_OLTP (ESC_TASK_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX1_MAILFAXDOC_DE_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC_OLTP (DE_TASK_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX1_MAILFAXDOC_MAX_QC_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC_OLTP (MAXIMUS_QC_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX1_MAILFAXDOC_ESC_TASK_ID2 on NYHIX_ETL_MAIL_FAX_DOC_OLTP (ESC_TASK_ID2) TABLESPACE  MAXDAT_INDX ;
create index IDX1_MAILFAXDOC_DOC_SET_ID on NYHIX_ETL_MAIL_FAX_DOC_OLTP (DOC_SET_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX1_MAILFAXDOC_INCIDENT_ID on NYHIX_ETL_MAIL_FAX_DOC_OLTP (INCIDENT_ID) TABLESPACE MAXDAT_INDX ;
create index IDX1_MAILFAXDOC_LINK_ID on NYHIX_ETL_MAIL_FAX_DOC_OLTP (LINK_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX1_MAILFAXDOC_LINKED_CLIENT on NYHIX_ETL_MAIL_FAX_DOC_OLTP (LINKED_CLIENT) TABLESPACE  MAXDAT_INDX;
create index IDX1_MAILFAXDOC_KOFAX_DCN on NYHIX_ETL_MAIL_FAX_DOC_OLTP (KOFAX_DCN) TABLESPACE MAXDAT_INDX;


--GRANTS & PUBLIC SYNONYMNS
create or replace public synonym NYHIX_ETL_MAIL_FAX_DOC_OLTP for NYHIX_ETL_MAIL_FAX_DOC_OLTP;

Grant select on NYHIX_ETL_MAIL_FAX_DOC_OLTP to MAXDAT_READ_ONLY;

--CREATE WIP BPM TABLE 
CREATE TABLE NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM
(EEMFDB_ID NUMBER(18,0) NOT NULL,
 DCN VARCHAR2(256) NOT NULL,
 KOFAX_DCN varchar2(256) NOT NULL,
 PREVIOUS_KOFAX_DCN varchar2(256),
 CREATE_DT DATE,
 ECN VARCHAR2(256),
 INSTANCE_STATUS VARCHAR2(32) NOT NULL,
 INSTANCE_STATUS_DT DATE,
 BATCH_ID NUMBER(38,0) default 0 NOT NULL,
  BATCH_NAME VARCHAR2(255),	
 CHANNEL VARCHAR2(32) NOT NULL,
 PAGE_COUNT NUMBER(18,0) default 0,
 DOC_STATUS_CD VARCHAR2(32) NOT NULL,
 DOC_STATUS_DT DATE default sysdate,
 ENV_STATUS_CD VARCHAR2(32) default 'RECEIVED',
 ENV_STATUS_DT DATE,
 DOC_TYPE_CD VARCHAR2(32) default 'UNKNOWN' NOT NULL,
 DOC_SUBTYPE_CD VARCHAR2(32) default 'UNKNOWN' NOT NULL,
 FORM_TYPE_CD VARCHAR2(70) default 'UNKNOWN' NOT NULL,
 FREE_FORM_TXT_IND VARCHAR2(1),
 --RECEIPT_DT DATE,
 SCAN_DT DATE NOT NULL,
 RELEASE_DT DATE NOT NULL,
 ASSD_MAXE_CREATE_DOC DATE,
 ASED_MAXE_CREATE_DOC DATE,
 DOCUMENT_ID NUMBER(18,0),	
 DOC_SET_ID NUMBER(18,0),
 MAXe_DOC_CREATE_DT DATE,
 LANGUAGE VARCHAR2(32),
 CURRENT_TASK_ID number(18,0),
 CURRENT_STEP VARCHAR2(256),
 ASSD_CREATE_COMPLAINT DATE,
 ASED_CREATE_COMPLAINT DATE,
 COMPLAINT_DE_TASK_ID NUMBER(18,0),
 ASSD_CREATE_APPEAL DATE,
 ASED_CREATE_APPEAL DATE,
 APPEAL_DE_TASK_ID NUMBER(18,0),
 INCIDENT_ID NUMBER(18,0),
 ASSD_HSDE_QC DATE,
 ASED_HSDE_QC DATE,
 HSDE_ERR_IND VARCHAR2(1),
 HSDE_QC_TASK_ID NUMBER(18,0),
 ASSD_MANUAL_LINK_DOC DATE,
 ASED_MANUAL_LINK_DOC DATE,
 MANUAL_LINK_TASK_ID NUMBER(18,0),
 ASSD_DOCSETLINK_QC DATE,
 ASED_DOCSETLINK_QC DATE,
 DOCSETLINK_QC_TASK_ID NUMBER(18,0),
 ASSD_RESOLVE_ESC_TASK DATE,
 ASED_RESOLVE_ESC_TASK DATE,
 ESC_TASK_ID NUMBER(18,0),
 ASSD_DATA_ENTRY DATE,
 ASED_DATA_ENTRY DATE,
 DE_TASK_ID NUMBER(18,0),
 ASSD_MAXIMUS_QC DATE,
 ASED_MAXIMUS_QC DATE,
 MAXIMUS_QC_TASK_ID NUMBER(18,0),
 ASSD_RESOLVE_ESC_TASK2	DATE,
 ASED_RESOLVE_ESC_TASK2	DATE,
 ESC_TASK_ID2 NUMBER(18,0),
 ASSD_TRANSMIT_TO_NYHBE	DATE,
 ASED_TRANSMIT_TO_NYHBE	DATE,
 CANCEL_DT DATE,
 CANCEL_BY VARCHAR2(32),
 CANCEL_REASON VARCHAR2(32),
 CANCEL_METHOD VARCHAR2(32),
 LINK_METHOD VARCHAR2(32),
 LINK_ID NUMBER(18,0),
 LINKED_CLIENT NUMBER(18,0),
 --DOC_COMPLETE_DT date,
 COMPLETE_DT DATE,
 RESCANNED_IND VARCHAR2(1),
 RETURNED_MAIL_IND VARCHAR2(1),
 RETURNED_MAIL_REASON VARCHAR2(32),	
 RESCAN_COUNT NUMBER(18,0) default 0,
 UPDATED_BY VARCHAR2(80),
 UPDATE_DT DATE,
 TRASHED_IND VARCHAR2(1),
 NOTE_ID VARCHAR2(32),
 ORIG_DOC_TYPE_CD VARCHAR2(32),
 ORIG_DOC_FORM_TYPE_CD VARCHAR2(32),
 EXPEDITED_IND VARCHAR2(1),
 RESEARCH_REQ_IND VARCHAR2(1),
 ASF_MAXE_CREATE_DOC VARCHAR2(1) default 'N' not null,
 ASF_CREATE_COMPLAINT VARCHAR2(1) default 'N' not null,
 ASF_CREATE_APPEAL VARCHAR2(1) default 'N' not null,
 ASF_HSDE_QC VARCHAR2(1) default 'N' not null,
 ASF_MANUAL_LINK_DOC VARCHAR2(1) default 'N' not null,
 ASF_DOCSETLINK_QC VARCHAR2(1) default 'N' not null,
 ASF_RESOLVE_ESC_TASK VARCHAR2(1) default 'N' not null,
 ASF_DATA_ENTRY VARCHAR2(1) default 'N' not null,
 ASF_MAXIMUS_QC VARCHAR2(1) default 'N' not null,
 ASF_RESOLVE_ESC_TASK2 VARCHAR2(1) default 'N' not null,
 ASF_TRANSMIT_TO_NYHBE VARCHAR2(1) default 'N' not null,
 GWF_HSDE_QC_REQ VARCHAR2(1),
 GWF_AUTOLINK_SUCCESS VARCHAR2(1),
 GWF_DOCSETLINK_QC_REQ VARCHAR2(1),
 GWF_DATA_ENTRY_REQ VARCHAR2(1),
 GWF_MAXIMUS_QC_REQ VARCHAR2(1),
 STG_EXTRACT_DT DATE default SYSDATE not null,
 STAGE_DONE_DT DATE,
 STG_LAST_UPDATE_DT DATE,
 UPDATED varchar(1)
)TABLESPACE MAXDAT_DATA PARALLEL;


--indexes WIP
--Unique
create unique index  NYHIX_ETL_MFD_WIP_BPM_IX1 on  NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (DCN)  tablespace MAXDAT_INDX;

create index IDX2_MAILFAXDOC_EEMFDB_ID on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (EEMFDB_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX2_MAILFAXDOC_ECN on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (ECN) TABLESPACE  MAXDAT_INDX ;
create index IDX2_MAILFAXDOC_BATCH_ID on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (BATCH_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX2_MAILFAXDOC_COMP_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (COMPLAINT_DE_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX2_MAILFAXDOC_APPEAL_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (APPEAL_DE_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX2_MAILFAXDOC_HSDEQC_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (HSDE_QC_TASK_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX2_MAILFAXDOC_MAN_LNK_TSK_ID on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (MANUAL_LINK_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX2_MAILFAXDOC_DOCS_QC_TSK_ID on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (DOCSETLINK_QC_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX2_MAILFAXDOC_ESC_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (ESC_TASK_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX2_MAILFAXDOC_DE_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (DE_TASK_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX2_MAILFAXDOC_MAX_QC_TASK_ID on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (MAXIMUS_QC_TASK_ID) TABLESPACE MAXDAT_INDX ;
create index IDX2_MAILFAXDOC_ESC_TASK_ID2 on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (ESC_TASK_ID2) TABLESPACE  MAXDAT_INDX ;
create index IDX2_MAILFAXDOC_DOC_SET_ID on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (DOC_SET_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX2_MAILFAXDOC_INCIDENT_ID on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (INCIDENT_ID) TABLESPACE MAXDAT_INDX ;
create index IDX2_MAILFAXDOC_LINK_ID on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (LINK_ID) TABLESPACE  MAXDAT_INDX ;
create index IDX2_MAILFAXDOC_LINKED_CLIENT on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (LINKED_CLIENT) TABLESPACE  MAXDAT_INDX;
create index IDX2_MAILFAXDOC_KOFAX_DCN on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM (KOFAX_DCN) TABLESPACE  MAXDAT_INDX;

--GRANTS & PUBLIC SYNONYMNS
create or replace public synonym NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM for NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM;

Grant select on NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM to MAXDAT_READ_ONLY;