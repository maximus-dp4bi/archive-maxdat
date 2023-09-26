-- D_NYHIX_MFD_CURRENT NYHIX_MFD_BI_ID
create table D_NYHIX_MFD_CURRENT 
  (NYHIX_MFD_BI_ID number	not null,
   DCN varchar2(256),
   KOFAX_DCN varchar2(256),
   CREATE_DT date,
   ECN varchar2(256),
   INSTANCE_STATUS varchar2(50),
   INSTANCE_STATUS_DT date,
   BATCH_ID number,
   CHANNEL varchar2(256),
   PAGE_COUNT number,
   DOCUMENT_STATUS varchar2(32),
   DOCUMENT_STATUS_DT date,
   ENVELOPE_STATUS varchar2(50),
   ENVELOPE_STATUS_DT date,
   DOCUMENT_TYPE varchar2(60),
   DOCUMENT_SUBTYPE varchar2(60),
   FORM_TYPE varchar2(256),
   FREE_FORM_TEXT varchar2(256),
   SCAN_DT date,
   RELEASE_DT date,
   MAXE_CREATE_DOC_START date,
   MAXE_CREATE_DOC_END date,
   DOCUMENT_ID number,
   DOCUMENT_SET_ID number,
   MAXE_DOC_CREATE_DT date,
   LANGUAGE varchar2(256),
   CURRENT_TASK_ID number(18,0),
   CURRENT_STEP varchar2(256),
   CREATE_COMPLAINT_START date,
   CREATE_COMPLAINT_END date,
   COMPLAINT_DATA_ENTRY_TASK_ID number,
   CREATE_APPEAL_START date,
   CREATE_APPEAL_END date,
   APPEAL_DATA_ENTRY_TASK_ID number,
   INCIDENT_ID number,
   RESOLVE_HSDE_QC_TASK_START date,
   RESOLVE_HSDE_QC_TASK_END date,
   HSDE_ERROR varchar2(256),
   HSDE_QC_TASK_ID number,
   MANUAL_LINK_DOCUMENT_START date,
   MANUAL_LINK_DOCUMENT_END date,
   MANUAL_LINKING_TASK_ID number,
   DOC_SET_LINK_QC_START date,
   DOC_SET_LINK_QC_END date,
   DOC_SET_LINK_QC_TASK_ID number,
   RESOLVE_ESC_TASK_START date,
   RESOLVE_ESC_TASK_END date,
   ESCALATED_TASK_ID number,
   DATA_ENTRY_START date,
   DATA_ENTRY_END	date,
   DATA_ENTRY_TASK_ID number,
   MAXIMUS_QC_START date,
   MAXIMUS_QC_END	date,
   MAXIMUS_QC_TASK_ID number,
   RESOLVE_ESC_TASK2_START date,
   RESOLVE_ESC_TASK2_END date,
   ESCALATED_TASK_ID2 number,
   TRANSMIT_TO_NYHBE_START date,
   TRANSMIT_TO_NYHBE_END date,
   CANCEL_DT date,
   CANCEL_BY varchar2(256),
   CANCEL_REASON varchar2(256),
   CANCEL_METHOD varchar2(256),
   LINK_METHOD varchar2(15),
   LINK_ID number,
   LINKED_CLIENT varchar2(256),
   COMPLETE_DT date,
   RESCANNED varchar2(1),
   RETURNED_MAIL varchar2(1),
   RETURNED_MAIL_REASON varchar2(256),
   RESCAN_COUNT number,
   LAST_UPDATED_BY varchar2(256),
   LAST_UPDATED_DT date,
   DOCUMENT_TRASHED varchar2(1),
   DOCUMENT_NOTE_ID number,
   ORIGINAL_DOC_TYPE varchar2(256),
   ORIGINAL_FORM_TYPE varchar2(256),
   EXPEDITED varchar2(1),
   RESEARCH_REQUESTED varchar2(1),
   PAPER_SLA_TIME_STATUS varchar2(256) default 'Not Complete' not null,
   AGE_IN_BUSINESS_DAYS number,
   AGE_IN_CALENDAR_DAYS number,
   TIMELINESS_STATUS varchar2(32),
   TIMELINESS_DAYS number,
   TIMELINESS_DAYS_TYPE varchar2(1),
   TIMELINESS_DATE date,
   JEOPARDY_FLAG varchar2(2),
   JEOPARDY_DAYS number,
   JEOPARDY_DAYS_TYPE varchar2(1),
   JEOPARDY_DATE date,
   TARGET_DAYS number,
   ORIGINATION_DT date not null,
   INSTANCE_START_DATE date, 
   INSTANCE_END_DATE date) 
tablespace MAXDAT_DATA parallel 4;

comment on column D_NYHIX_MFD_CURRENT.NYHIX_MFD_BI_ID is 'Sequence ';
comment on column D_NYHIX_MFD_CURRENT.DCN is 'Unique identifier to track individual documents. The dcn is created in dms and saved in the source system.';
comment on column D_NYHIX_MFD_CURRENT.CREATE_DT is 'The date that the dcn is assigned by dms.';
comment on column D_NYHIX_MFD_CURRENT.ECN is 'Unique number assigned to each envelope for tracking.';
comment on column D_NYHIX_MFD_CURRENT.INSTANCE_STATUS is 'Indicates if the document instance is in process or not. When the document is created the status is set to active, and it remains active until the document has been successfully processed  is cancelled, or otherwise deleted when it is then set to complete.';
comment on column D_NYHIX_MFD_CURRENT.INSTANCE_STATUS_DT is 'The date that the instance status is set';
comment on column D_NYHIX_MFD_CURRENT.BATCH_ID is 'Unique identifier for the batch from which the document was received from kofax. ';
comment on column D_NYHIX_MFD_CURRENT.CHANNEL is 'The channel identifies the channel from which the document was originally received (mail or fax) into kofax or via the web.';
comment on column D_NYHIX_MFD_CURRENT.PAGE_COUNT is 'Count of individual pages in a document.';
comment on column D_NYHIX_MFD_CURRENT.DOCUMENT_STATUS is 'This is the document status assigned by the system during the imaging process.  ';
comment on column D_NYHIX_MFD_CURRENT.DOCUMENT_STATUS_DT is 'This is the status date for the current document status.';
comment on column D_NYHIX_MFD_CURRENT.ENVELOPE_STATUS is 'This is the envelope status assigned by the system during the imaging process.  ';
comment on column D_NYHIX_MFD_CURRENT.ENVELOPE_STATUS_DT is 'This is the status date for the current envelope status.';
comment on column D_NYHIX_MFD_CURRENT.DOCUMENT_TYPE is 'The document type is the high level description of a document in an envelope.';
comment on column D_NYHIX_MFD_CURRENT.DOCUMENT_SUBTYPE is 'The document subtype is a specification of the general document type for the document';
comment on column D_NYHIX_MFD_CURRENT.FORM_TYPE is 'The document form type is the description of the form returned by the client.';
comment on column D_NYHIX_MFD_CURRENT.FREE_FORM_TEXT is 'Indicates whether the document is flagged as free form text ';
comment on column D_NYHIX_MFD_CURRENT.RECEIPT_DT is 'The date the document was received in the mailroom or by nyhbe system';
comment on column D_NYHIX_MFD_CURRENT.SCAN_DT is 'The date the document was scanned into kofax';
comment on column D_NYHIX_MFD_CURRENT.RELEASE_DT is 'The date the document was released from kofax';
comment on column D_NYHIX_MFD_CURRENT.MAXE_CREATE_DOC_START is 'The time stamp when the maxe create doc activity step starts.';
comment on column D_NYHIX_MFD_CURRENT.MAXE_CREATE_DOC_END is 'The time stamp when the maxe create doc activity step ends.';
comment on column D_NYHIX_MFD_CURRENT.DOCUMENT_ID is 'Unique identifier for a document record in maxe';
comment on column D_NYHIX_MFD_CURRENT.DOCUMENT_SET_ID is 'Unique identifier of a set of documents in maxe';
comment on column D_NYHIX_MFD_CURRENT.MAXE_DOC_CREATE_DT is 'The date that the document is created in maxe';
comment on column D_NYHIX_MFD_CURRENT.LANGUAGE is 'The documents language';
comment on column D_NYHIX_MFD_CURRENT.CREATE_COMPLAINT_START is 'The date stamp when the create complaint activity step starts.';
comment on column D_NYHIX_MFD_CURRENT.CREATE_COMPLAINT_END is 'The date stamp when the create complaint activity step ends. ';
comment on column D_NYHIX_MFD_CURRENT.COMPLAINT_DATA_ENTRY_TASK_ID is ' Task id for a complaint data entry task from the document';
comment on column D_NYHIX_MFD_CURRENT.CREATE_APPEAL_START is 'The date stamp when the create appeal activity step starts.';
comment on column D_NYHIX_MFD_CURRENT.CREATE_APPEAL_END is 'The date stamp when the create appeal activity step ends.';
comment on column D_NYHIX_MFD_CURRENT.APPEAL_DATA_ENTRY_TASK_ID is 'Task id for an appeal from the document';
comment on column D_NYHIX_MFD_CURRENT.INCIDENT_ID is 'The incident initiated by a document created for either a complaint or appeal ';
comment on column D_NYHIX_MFD_CURRENT.RESOLVE_HSDE_QC_TASK_START is 'The date stamp when the hsde qc activity step starts.';
comment on column D_NYHIX_MFD_CURRENT.RESOLVE_HSDE_QC_TASK_END is 'The date stamp when the hsde qc activity step ends.';
comment on column D_NYHIX_MFD_CURRENT.HSDE_ERROR is 'Indicates whether this document has an hsde error or whether it is simply in an envelope with another document that has an error';
comment on column D_NYHIX_MFD_CURRENT.HSDE_QC_TASK_ID is 'Task id for hsde qc ';
comment on column D_NYHIX_MFD_CURRENT.MANUAL_LINK_DOCUMENT_START is 'The date stamp when the manual link doc activity step starts.  ';
comment on column D_NYHIX_MFD_CURRENT.MANUAL_LINK_DOCUMENT_END is 'The date stamp when the manual link doc activity step ends.  ';
comment on column D_NYHIX_MFD_CURRENT.MANUAL_LINKING_TASK_ID is 'Task id for manual linking doc set ';
comment on column D_NYHIX_MFD_CURRENT.DOC_SET_LINK_QC_START is 'The date stamp when the doc set link activity step starts. ';
comment on column D_NYHIX_MFD_CURRENT.DOC_SET_LINK_QC_END is 'The date stamp when the doc set link activity step ends. ';
comment on column D_NYHIX_MFD_CURRENT.DOC_SET_LINK_QC_TASK_ID is ' Task id for doc set link qc task';
comment on column D_NYHIX_MFD_CURRENT.RESOLVE_ESC_TASK_START is 'The date stamp when the resolve escalated activity step starts. ';
comment on column D_NYHIX_MFD_CURRENT.RESOLVE_ESC_TASK_END is 'The date stamp when the resolve escalated activity step ends. ';
comment on column D_NYHIX_MFD_CURRENT.ESCALATED_TASK_ID is 'Task id for escalated task';
comment on column D_NYHIX_MFD_CURRENT.DATA_ENTRY_START is 'The date stamp when the data entry activity step starts. ';
comment on column D_NYHIX_MFD_CURRENT.DATA_ENTRY_END is 'The date stamp when the data entry activity step ends. ';
comment on column D_NYHIX_MFD_CURRENT.DATA_ENTRY_TASK_ID is 'Task id for data entry task';
comment on column D_NYHIX_MFD_CURRENT.MAXIMUS_QC_START is 'The date stamp when the maximus qc activity step starts.  ';
comment on column D_NYHIX_MFD_CURRENT.MAXIMUS_QC_END is 'The date stamp when the maximus qc activity step ends.  ';
comment on column D_NYHIX_MFD_CURRENT.MAXIMUS_QC_TASK_ID is 'Task id for maximus qc task';
comment on column D_NYHIX_MFD_CURRENT.RESOLVE_ESC_TASK2_START is 'The date stamp when the resolve escalated task2 activity step starts.  ';
comment on column D_NYHIX_MFD_CURRENT.RESOLVE_ESC_TASK2_END is 'The date stamp when the resolve escalated task2 activity step ends.  ';
comment on column D_NYHIX_MFD_CURRENT.ESCALATED_TASK_ID2 is 'Task id for escalated task';
comment on column D_NYHIX_MFD_CURRENT.TRANSMIT_TO_NYHBE_START is 'The date when the document is transmit to nyhbe starts';
comment on column D_NYHIX_MFD_CURRENT.TRANSMIT_TO_NYHBE_END is 'The date when the document is transmit to nyhbe ends';
comment on column D_NYHIX_MFD_CURRENT.CANCEL_DT is 'The cancel date is set when the instance is confirmed cancelled, logically deleted, or otherwise discarded.';
comment on column D_NYHIX_MFD_CURRENT.CANCEL_BY is 'The performer who cancelled the batch.  Note that the performer may be a system';
comment on column D_NYHIX_MFD_CURRENT.CANCEL_REASON is 'The reason the instance was cancelled';
comment on column D_NYHIX_MFD_CURRENT.CANCEL_METHOD is 'The method by which the instance was cancelled';
comment on column D_NYHIX_MFD_CURRENT.LINK_METHOD is 'Link method';
comment on column D_NYHIX_MFD_CURRENT.LINK_ID is 'The id of the document link record';
comment on column D_NYHIX_MFD_CURRENT.LINKED_CLIENT is 'The client that the document is associated with ';
comment on column D_NYHIX_MFD_CURRENT.COMPLETE_DT is 'Date the image was sent to nyhbe, incident created, or follow up work created (terminal state).';
comment on column D_NYHIX_MFD_CURRENT.RESCANNED is 'Indicator for if a doc is rescanned';
comment on column D_NYHIX_MFD_CURRENT.RETURNED_MAIL is 'Indicator for if a doc is returned mail';
comment on column D_NYHIX_MFD_CURRENT.RETURNED_MAIL_REASON is 'Reason code for why a doc is returned mail';
comment on column D_NYHIX_MFD_CURRENT.RESCAN_COUNT is 'Number of times a document was rescanned';
comment on column D_NYHIX_MFD_CURRENT.LAST_UPDATED_BY is 'Last user to update the document in maxe';
comment on column D_NYHIX_MFD_CURRENT.LAST_UPDATED_DT is 'Date of the last update to the document in maxe';
comment on column D_NYHIX_MFD_CURRENT.DOCUMENT_TRASHED is 'Indicator for if a document is trashed in maxe';
comment on column D_NYHIX_MFD_CURRENT.DOCUMENT_NOTE_ID is 'Id of a note related to a document in maxe';
comment on column D_NYHIX_MFD_CURRENT.ORIGINAL_DOC_TYPE is 'Original document type if a document is reclassified';
comment on column D_NYHIX_MFD_CURRENT.ORIGINAL_FORM_TYPE is 'Original document type if a document is reclassified';
comment on column D_NYHIX_MFD_CURRENT.EXPEDITED is 'Indicator for if the document was marked as expedited in maxe';
comment on column D_NYHIX_MFD_CURRENT.RESEARCH_REQUESTED is 'Indicator for if research has been requested on a  document';
comment on column D_NYHIX_MFD_CURRENT.AGE_IN_BUSINESS_DAYS is 'The document Age is the difference between the KOFAX document Creation Date and the current date/time or completion date/time in business days.';
comment on column D_NYHIX_MFD_CURRENT.AGE_IN_CALENDAR_DAYS is 'The document Age is the difference between the KOFAX document Creation Date and the current date/time or completion date/time in calendar days.';
comment on column D_NYHIX_MFD_CURRENT.TIMELINESS_STATUS is 'The document Timeliness Status indicates whether a document was processed within the business defined thresholds.';
comment on column D_NYHIX_MFD_CURRENT.TIMELINESS_DAYS is 'The number of days after which the instance is determined to be processed untimely.';
comment on column D_NYHIX_MFD_CURRENT.TIMELINESS_DAYS_TYPE is 'Type of days for Timeliness measure Business or Calendar';
comment on column D_NYHIX_MFD_CURRENT.TIMELINESS_DATE is 'First date on which the instance is consideredu ntimely, this is the date that the Timeliness Status was or will be set to "Processed Untimely"';
comment on column D_NYHIX_MFD_CURRENT.JEOPARDY_FLAG is 'The Jeopardy Flag indicates if an in-process document is at risk of becoming untimely.';
comment on column D_NYHIX_MFD_CURRENT.JEOPARDY_DAYS is 'The age at which the instance is determined to be in jeopardy of becoming untimely';
comment on column D_NYHIX_MFD_CURRENT.JEOPARDY_DAYS_TYPE is 'Type of days for Jeopardy Business or Calendar';
comment on column D_NYHIX_MFD_CURRENT.JEOPARDY_DATE is 'First date on which the document is considered in Jeopardy, this is the date that the  document Jeopardy Flag was or will be set to "Y"';
comment on column D_NYHIX_MFD_CURRENT.TARGET_DAYS is 'Age at which the document processing cycle is determined to be untimely based on target goals set by the business. If no target has been defined then this value is null. ';
comment on column D_NYHIX_MFD_CURRENT.CURRENT_TASK_ID is 'This is the date/time that MAXe considers the Document Complete';
--comment on column D_NYHIX_MFD_CURRENT.DOC_COMPLETE_DT is 'This is the current task ID associated with the Document';

alter table D_NYHIX_MFD_CURRENT add constraint DNMFD_PK primary key (NYHIX_MFD_BI_ID) using index tablespace MAXDAT_INDX;

create index DNMFDCUR_IX1 on D_NYHIX_MFD_CURRENT (BATCH_ID) online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index DNMFDCUR_IX2 on D_NYHIX_MFD_CURRENT (CANCEL_DT) online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index DNMFDCUR_IX3 on D_NYHIX_MFD_CURRENT (ENVELOPE_STATUS_DT) online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index DNMFDCUR_IX4 on D_NYHIX_MFD_CURRENT (DCN) online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index DNMFDCUR_IX5 on D_NYHIX_MFD_CURRENT (CANCEL_BY) online tablespace MAXDAT_INDX parallel 4 compute statistics;

grant select on D_NYHIX_MFD_CURRENT to MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW D_NYHIX_MFD_CURRENT_SV AS
SELECT NYHIX_MFD_BI_ID,
  DCN,
  CREATE_DT,
  ECN,
  INSTANCE_STATUS,
  INSTANCE_STATUS_DT,
  BATCH_ID,
  CHANNEL,
  PAGE_COUNT,
  DOCUMENT_STATUS,
  DOCUMENT_STATUS_DT,
  ENVELOPE_STATUS,
  ENVELOPE_STATUS_DT,
  DOCUMENT_TYPE,
  DOCUMENT_SUBTYPE,
  FORM_TYPE,
  FREE_FORM_TEXT,
  SCAN_DT,
  RELEASE_DT,
  MAXE_CREATE_DOC_START,
  MAXE_CREATE_DOC_END,
  DOCUMENT_ID,
  DOCUMENT_SET_ID,
  MAXE_DOC_CREATE_DT,
  LANGUAGE,
  COMPLAINT_DATA_ENTRY_TASK_ID,
  CREATE_COMPLAINT_START,
  CREATE_COMPLAINT_END,
  APPEAL_DATA_ENTRY_TASK_ID,
  CREATE_APPEAL_START,
  CREATE_APPEAL_END,
  INCIDENT_ID,
  HSDE_QC_TASK_ID,
  RESOLVE_HSDE_QC_TASK_START,
  RESOLVE_HSDE_QC_TASK_END,
  HSDE_ERROR,
  MANUAL_LINKING_TASK_ID,
  MANUAL_LINK_DOCUMENT_START,
  MANUAL_LINK_DOCUMENT_END,
  DOC_SET_LINK_QC_TASK_ID,
  DOC_SET_LINK_QC_START,
  DOC_SET_LINK_QC_END,
  ESCALATED_TASK_ID,
  RESOLVE_ESC_TASK_START,
  RESOLVE_ESC_TASK_END,
  DATA_ENTRY_TASK_ID,
  DATA_ENTRY_START,
  DATA_ENTRY_END,
  MAXIMUS_QC_TASK_ID,
  MAXIMUS_QC_START,
  MAXIMUS_QC_END,
  ESCALATED_TASK_ID2,
  RESOLVE_ESC_TASK2_START,
  RESOLVE_ESC_TASK2_END,
  TRANSMIT_TO_NYHBE_START,
  TRANSMIT_TO_NYHBE_END,
  CANCEL_DT,
  CASE
    WHEN length(S.LAST_NAME || ', ' || S.FIRST_NAME) > 2 THEN S.LAST_NAME || ', ' || S.FIRST_NAME
    WHEN length(E.LAST_NAME || ', ' || E.FIRST_NAME) > 2 THEN E.LAST_NAME || ', ' || E.FIRST_NAME
    ELSE C.CANCEL_BY
  END CANCEL_BY,
  CANCEL_REASON,
  CANCEL_METHOD,
  LINK_METHOD,
  LINK_ID,
  LINKED_CLIENT,
  COMPLETE_DT,
  RESCANNED,
  RETURNED_MAIL,
  RETURNED_MAIL_REASON,
  RESCAN_COUNT,
  LAST_UPDATED_BY,
  LAST_UPDATED_DT,
  DOCUMENT_TRASHED,
  DOCUMENT_NOTE_ID,
  ORIGINAL_DOC_TYPE,
  ORIGINAL_FORM_TYPE,
  EXPEDITED,
  RESEARCH_REQUESTED,
  AGE_IN_BUSINESS_DAYS,
  AGE_IN_CALENDAR_DAYS,
  TIMELINESS_STATUS,
  TIMELINESS_DAYS,
  TIMELINESS_DAYS_TYPE,
  TIMELINESS_DATE,
  JEOPARDY_FLAG,
  JEOPARDY_DAYS,
  JEOPARDY_DAYS_TYPE,
  JEOPARDY_DATE,
  TARGET_DAYS,
  CURRENT_TASK_ID,
  KOFAX_DCN,
  CURRENT_STEP,
  BATCH_NAME,
  ORIGINATION_DT,
  PREVIOUS_KOFAX_DCN,
  PAPER_SLA_TIME_STATUS,
  APP_DOC_TRACKER_ID,
  DOC_NOTIFICATION_ID,
  DOC_NOTIFICATION_STATUS,
  HX_ACCOUNT_ID,
  HXID,
  INSTANCE_START_DATE,
  INSTANCE_END_DATE,
  ACCOUNT_ID
FROM D_NYHIX_MFD_CURRENT C
LEFT OUTER JOIN D_STAFF S
ON C.CANCEL_BY = to_char(S.STAFF_ID)
LEFT OUTER JOIN D_STAFF E
ON C.CANCEL_BY = E.EXT_STAFF_NUMBER;

grant select on D_NYHIX_MFD_CURRENT_SV to MAXDAT_READ_ONLY;


-- D_NYHIX_MFD_INS_STATUS  DNMFIS_ID
create sequence SEQ_DNMFDIS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYHIX_MFD_INS_STATUS 
 (DNMFDIS_ID number not null,
  INSTANCE_STATUS varchar2(32) not null)
tablespace MAXDAT_DATA;

alter table D_NYHIX_MFD_INS_STATUS add constraint DNMFDIS_PK primary key (DNMFDIS_ID) using index tablespace MAXDAT_INDX;

create unique index DNMFDIS_UIX1 on D_NYHIX_MFD_INS_STATUS ("INSTANCE_STATUS") online tablespace 
MAXDAT_INDX compute statistics; 

grant select on D_NYHIX_MFD_INS_STATUS to MAXDAT_READ_ONLY;

create or replace view D_NYHIX_MFD_INS_STATUS_SV as
select * from D_NYHIX_MFD_INS_STATUS
with read only;

grant select on D_NYHIX_MFD_INS_STATUS_SV to MAXDAT_READ_ONLY;


-- D_NYHIX_MFD_DOC_TYPE  DNMFDDT_ID
create sequence SEQ_DNMFDDT_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYHIX_MFD_DOC_TYPE
  (DNMFDDT_ID number not null,
   DOCUMENT_TYPE varchar2(64) not null)
tablespace MAXDAT_DATA;

alter table D_NYHIX_MFD_DOC_TYPE add constraint DNMFDDT_PK primary key (DNMFDDT_ID) using index tablespace MAXDAT_INDX;

create unique index DNMFDDT_UIX1 on D_NYHIX_MFD_DOC_TYPE ("DOCUMENT_TYPE") online tablespace 
MAXDAT_INDX compute statistics; 

grant select on D_NYHIX_MFD_DOC_TYPE to MAXDAT_READ_ONLY;

create or replace view D_NYHIX_MFD_DOC_TYPE_SV as
select * from D_NYHIX_MFD_DOC_TYPE
with read only;

grant select on D_NYHIX_MFD_DOC_TYPE_SV to MAXDAT_READ_ONLY;


-- D_NYHIX_MFD_DOC_STATUS  DNMFDDS_ID
create sequence SEQ_DNMFDDS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYHIX_MFD_DOC_STATUS 
  (DNMFDDS_ID number not null,
   DOCUMENT_STATUS varchar2(32) not null)
tablespace MAXDAT_DATA;

alter table D_NYHIX_MFD_DOC_STATUS add constraint DNMFDDS_PK primary key (DNMFDDS_ID) using index tablespace MAXDAT_INDX;

create unique index DNMFDDS_UIX1 on D_NYHIX_MFD_DOC_STATUS ("DOCUMENT_STATUS") online tablespace 
MAXDAT_INDX compute statistics; 

grant select on D_NYHIX_MFD_DOC_STATUS to MAXDAT_READ_ONLY;

create or replace view D_NYHIX_MFD_DOC_STATUS_SV as
select * from D_NYHIX_MFD_DOC_STATUS
with read only;

grant select on D_NYHIX_MFD_DOC_STATUS_SV to MAXDAT_READ_ONLY;


-- D_NYHIX_MFD_ENV_STATUS  DNMFDES_ID
create sequence SEQ_DNMFDES_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYHIX_MFD_ENV_STATUS 
  (DNMFDES_ID number not null, 
   ENVELOPE_STATUS varchar2(32) not null) 
tablespace MAXDAT_DATA;

alter table D_NYHIX_MFD_ENV_STATUS add constraint DNMFDES_PK primary key (DNMFDES_ID) using index tablespace MAXDAT_INDX;

alter table D_NYHIX_MFD_ENV_STATUS add constraint DNMFDES_PK primary key (DNMFDES_ID);
alter index DNMFDES_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNMFDES_UIX1 on D_NYHIX_MFD_ENV_STATUS ("ENVELOPE_STATUS") online tablespace 
MAXDAT_INDX compute statistics; 

grant select on D_NYHIX_MFD_ENV_STATUS to MAXDAT_READ_ONLY;

create or replace view D_NYHIX_MFD_ENV_STATUS_SV as
select * from D_NYHIX_MFD_ENV_STATUS
with read only;

grant select on D_NYHIX_MFD_ENV_STATUS_SV to MAXDAT_READ_ONLY;


-- D_NYHIX_MFD_DOC_SUB_TYPE  DNMFDDST_ID
create sequence SEQ_DNMFDDST_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYHIX_MFD_DOC_SUB_TYPE 
  (DNMFDDST_ID number not null,
   DOCUMENT_SUBTYPE varchar2(32) not null) 
tablespace MAXDAT_DATA;

alter table D_NYHIX_MFD_DOC_SUB_TYPE add constraint DNMFDDST_PK primary key (DNMFDDST_ID) using index tablespace MAXDAT_INDX;

create unique index DNMFDDST_UIX1 on D_NYHIX_MFD_DOC_SUB_TYPE ("DOCUMENT_SUBTYPE") online tablespace 
MAXDAT_INDX compute statistics; 

grant select on D_NYHIX_MFD_DOC_SUB_TYPE to MAXDAT_READ_ONLY;

create or replace view D_NYHIX_MFD_DOC_SUB_TYPE_SV as
select * from D_NYHIX_MFD_DOC_SUB_TYPE
with read only;

grant select on D_NYHIX_MFD_DOC_SUB_TYPE_SV to MAXDAT_READ_ONLY;


-- D_NYHIX_MFD_FORM_TYPE  DNMFFT_ID
create sequence SEQ_DNMFDFT_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYHIX_MFD_FORM_TYPE
  (DNMFDFT_ID number not null, 
   FORM_TYPE varchar2(32) not null)
tablespace MAXDAT_DATA;

alter table D_NYHIX_MFD_FORM_TYPE add constraint DNMFDFT_PK primary key (DNMFDFT_ID) using index tablespace MAXDAT_INDX;

create unique index DNMFDFT_UIX1 on D_NYHIX_MFD_FORM_TYPE ("FORM_TYPE") online tablespace MAXDAT_INDX compute statistics; 

grant select on D_NYHIX_MFD_FORM_TYPE to MAXDAT_READ_ONLY;

create or replace view D_NYHIX_MFD_FORM_TYPE_SV as
select * from D_NYHIX_MFD_FORM_TYPE
with read only;

grant select on D_NYHIX_MFD_FORM_TYPE_SV to MAXDAT_READ_ONLY;


-- D_NYHIX_MFD_TIME_STATUS  DNMFTS_ID
create sequence SEQ_DNMFDTS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYHIX_MFD_TIME_STATUS 
  (DNMFDTS_ID number not null, 
   DCN_TIMELINESS_STATUS varchar2(32) not null)
tablespace MAXDAT_DATA;

alter table D_NYHIX_MFD_TIME_STATUS add constraint DNMFDTS_PK primary key (DNMFDTS_ID) using index tablespace MAXDAT_INDX;

create unique index DNMFDTS_UIX1 on D_NYHIX_MFD_TIME_STATUS ("DCN_TIMELINESS_STATUS") online 
tablespace MAXDAT_INDX compute statistics; 

grant select on D_NYHIX_MFD_TIME_STATUS to MAXDAT_READ_ONLY;

create or replace view D_NYHIX_MFD_TIME_STATUS_SV as
select * from D_NYHIX_MFD_TIME_STATUS
with read only;

grant select on D_NYHIX_MFD_TIME_STATUS_SV to MAXDAT_READ_ONLY;


-- F_NYHIX_MFD_BY_DATE FNMFDBD_ID
create sequence SEQ_FNMFDBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;
drop table F_NYHIX_MFD_BY_DATE ;

create table F_NYHIX_MFD_BY_DATE 
  (FNMFDBD_ID number not null,
   D_DATE	date not null,
   BUCKET_START_DATE date not null,
   BUCKET_END_DATE date not null,
   NYHIX_MFD_BI_ID number not null,
   DNMFDDT_ID number not null,
   DNMFDDS_ID number not null,	
   DNMFDES_ID number not null,
   DNMFDDST_ID number not null,
   DNMFDFT_ID number not null,
   DNMFDTS_ID number not null,
   DNMFDIS_ID number not null,
   INSTANCE_STATUS_DT date not null,
   DOCUMENT_STATUS_DT date not null,
   ENVELOPE_STATUS_DT date,
   SCAN_DT date not null,
   RELEASE_DT date not null,
   JEOPARDY_FLAG varchar2(2) not null,
   CREATION_COUNT	number not null,
   INVENTORY_COUNT number	not null,
   COMPLETION_COUNT number not null) 
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (TO_DATE('20130101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel 4;

comment on column F_NYHIX_MFD_BY_DATE.FNMFDBD_ID is 'Sequence ';
comment on column F_NYHIX_MFD_BY_DATE.NYHIX_MFD_BI_ID is 'BI ID ';
comment on column F_NYHIX_MFD_BY_DATE.INSTANCE_STATUS_DT is 'The date that the instance status is set';
comment on column F_NYHIX_MFD_BY_DATE.DOCUMENT_STATUS_DT is 'This is the status date for the current document status.';
comment on column F_NYHIX_MFD_BY_DATE.ENVELOPE_STATUS_DT is 'This is the status date for the current envelope status.';
comment on column F_NYHIX_MFD_BY_DATE.SCAN_DT is 'The date the document was scanned into kofax';
comment on column F_NYHIX_MFD_BY_DATE.RELEASE_DT is 'The date the document was released from kofax';
comment on column F_NYHIX_MFD_BY_DATE.JEOPARDY_FLAG is 'The Jeopardy Flag indicates if an in-process document is at risk of becoming untimely.';

alter table F_NYHIX_MFD_BY_DATE add constraint FNMFDBD_PK primary key (FNMFDBD_ID) using index tablespace MAXDAT_INDX;
alter table F_NYHIX_MFD_BY_DATE add constraint FNMFDBD_DNMFDDT_FK foreign key (DNMFDDT_ID) references D_NYHIX_MFD_DOC_TYPE (DNMFDDT_ID);
alter table F_NYHIX_MFD_BY_DATE add constraint FNMFDBD_DNMFDDS_FK foreign key (DNMFDDS_ID) references D_NYHIX_MFD_DOC_STATUS (DNMFDDS_ID);
alter table F_NYHIX_MFD_BY_DATE add constraint FNMFDBD_DNMFDES_FK foreign key (DNMFDES_ID) references D_NYHIX_MFD_ENV_STATUS (DNMFDES_ID);
alter table F_NYHIX_MFD_BY_DATE add constraint FNMFDBD_DNMFDDST_FK foreign key (DNMFDDST_ID) references D_NYHIX_MFD_DOC_SUB_TYPE (DNMFDDST_ID);
alter table F_NYHIX_MFD_BY_DATE add constraint FNMFDBD_DNMFDFT_FK foreign key (DNMFDFT_ID) references D_NYHIX_MFD_FORM_TYPE (DNMFDFT_ID);
alter table F_NYHIX_MFD_BY_DATE add constraint FNMFDBD_DNMFDTS_FK foreign key (DNMFDTS_ID) references D_NYHIX_MFD_TIME_STATUS (DNMFDTS_ID);
alter table F_NYHIX_MFD_BY_DATE add constraint FNMFDBD_NYHIX_MFD_BI_ID_FK foreign key (NYHIX_MFD_BI_ID) references D_NYHIX_MFD_CURRENT(NYHIX_MFD_BI_ID);
alter table F_NYHIX_MFD_BY_DATE add constraint FNMFDBD_DNMFDIS_FK foreign key (DNMFDIS_ID) references D_NYHIX_MFD_INS_STATUS(DNMFDIS_ID);

create unique index FNMFDBD_UIX1 on F_NYHIX_MFD_BY_DATE (NYHIX_MFD_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel 4 compute statistics; 
create unique index FNMFDBD_UIX2 on F_NYHIX_MFD_BY_DATE (NYHIX_MFD_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel 4 compute statistics;

create index FNMFDBD_IX1 on F_NYHIX_MFD_BY_DATE (INSTANCE_STATUS_DT) online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index FNMFDBD_IX2 on F_NYHIX_MFD_BY_DATE (DOCUMENT_STATUS_DT) online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index FNMFDBD_IX4 on F_NYHIX_MFD_BY_DATE (SCAN_DT) online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index FNMFDBD_IX5 on F_NYHIX_MFD_BY_DATE (RELEASE_DT) online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index FNMFDBD_IX6 on F_NYHIX_MFD_BY_DATE (ENVELOPE_STATUS_DT) online tablespace MAXDAT_INDX parallel 4 compute statistics;

create index FNMFDBD_IXL1 on F_NYHIX_MFD_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index FNMFDBD_IXL2 on F_NYHIX_MFD_BY_DATE (NYHIX_MFD_BI_ID) local online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index FNMFDBD_IXL3 on F_NYHIX_MFD_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel 4 compute statistics;
create index FNMFDBD_IXL4 on F_NYHIX_MFD_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel 4 compute statistics;

grant select on F_NYHIX_MFD_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_NYHIX_MFD_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  f.FNMFDBD_ID,
  f.BUCKET_START_DATE D_DATE,
  f.NYHIX_MFD_BI_ID,
  f.DNMFDDT_ID,
  f.DNMFDDS_ID,
  f.DNMFDES_ID,
  f.DNMFDDST_ID,
  f.DNMFDFT_ID,
  f.DNMFDTS_ID,
  f.DNMFDIS_ID,
  f.INSTANCE_STATUS_DT,
  f.DOCUMENT_STATUS_DT,
  f.ENVELOPE_STATUS_DT,
  f.SCAN_DT,
  f.RELEASE_DT,
  f.JEOPARDY_FLAG,
  f.CREATION_COUNT,
  f.INVENTORY_COUNT,
  f.COMPLETION_COUNT,
  case 
    When 
      f.BUCKET_START_DATE = trunc(d.ENVELOPE_STATUS_DT)
      and d.envelope_status = 'COMPLETEDRELEASED'
      and d.cancel_dt is null
      and d.channel != 'WEB'
      then 1 
    else 0 
    end as SLA_SATISFIED_COUNT
  from F_NYHIX_MFD_BY_DATE f, D_NYHIX_MFD_CURRENT d
where
  f.NYHIX_MFD_BI_ID = d.NYHIX_MFD_BI_ID
  and D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  f.FNMFDBD_ID,
  bdd.D_DATE,
  f.NYHIX_MFD_BI_ID,
  f.DNMFDDT_ID,
  f.DNMFDDS_ID,
  f.DNMFDES_ID,
  f.DNMFDDST_ID,
  f.DNMFDFT_ID,
  f.DNMFDTS_ID,
  f.DNMFDIS_ID,
  f.INSTANCE_STATUS_DT,
  f.DOCUMENT_STATUS_DT,
  f.ENVELOPE_STATUS_DT,
  f.SCAN_DT,
  f.RELEASE_DT,
  f.JEOPARDY_FLAG,
  0 CREATION_COUNT,
  f.INVENTORY_COUNT,
  f.COMPLETION_COUNT,
  case 
    When 
      bdd.D_DATE = trunc(d.ENVELOPE_STATUS_DT)
      and d.envelope_status = 'COMPLETEDRELEASED'
      and d.cancel_dt is null
      and d.channel != 'WEB'
      then 1 
    else 0 
    end as SLA_SATISFIED_COUNT
from 
  F_NYHIX_MFD_BY_DATE f, 
  D_NYHIX_MFD_CURRENT d,
  BPM_D_DATES bdd
where
  f.NYHIX_MFD_BI_ID = d.NYHIX_MFD_BI_ID
  and bdd.D_DATE >= f.BUCKET_START_DATE
  and bdd.D_DATE < f.BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  f.FNMFDBD_ID,
  bdd.D_DATE,
  f.NYHIX_MFD_BI_ID,
  f.DNMFDDT_ID,
  f.DNMFDDS_ID,
  f.DNMFDES_ID,
  f.DNMFDDST_ID,
  f.DNMFDFT_ID,
  f.DNMFDTS_ID,
  f.DNMFDIS_ID,
  f.INSTANCE_STATUS_DT,
  f.DOCUMENT_STATUS_DT,
  f.ENVELOPE_STATUS_DT,
  f.SCAN_DT,
  f.RELEASE_DT,
  f.JEOPARDY_FLAG,
  0 CREATION_COUNT,
  f.INVENTORY_COUNT,
  f.COMPLETION_COUNT,
  case 
    when 
      bdd.D_DATE = trunc(d.ENVELOPE_STATUS_DT)
      and d.envelope_status = 'COMPLETEDRELEASED'
      and d.cancel_dt is null
      and d.channel != 'WEB'
      then 1 
    else 0 
    end as SLA_SATISFIED_COUNT
from
  BPM_D_DATES bdd,
  F_NYHIX_MFD_BY_DATE f,
  D_NYHIX_MFD_CURRENT d
where
  f.NYHIX_MFD_BI_ID = d.NYHIX_MFD_BI_ID
  and bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  f.FNMFDBD_ID,
  bdd.D_DATE,
  f.NYHIX_MFD_BI_ID,
  f.DNMFDDT_ID,
  f.DNMFDDS_ID,
  f.DNMFDES_ID,
  f.DNMFDDST_ID,
  f.DNMFDFT_ID,
  f.DNMFDTS_ID,
  f.DNMFDIS_ID,
  f.INSTANCE_STATUS_DT,
  f.DOCUMENT_STATUS_DT,
  f.ENVELOPE_STATUS_DT,
  f.SCAN_DT,
  f.RELEASE_DT,
  f.JEOPARDY_FLAG,
  f.CREATION_COUNT,
  f.INVENTORY_COUNT,
  f.COMPLETION_COUNT,
  case 
    when 
      bdd.D_DATE = trunc(d.ENVELOPE_STATUS_DT)
      and d.envelope_status = 'COMPLETEDRELEASED'
      and d.cancel_dt is null
      and d.channel != 'WEB'
      then 1 
    else 0 
    end as SLA_SATISFIED_COUNT
from
  BPM_D_DATES bdd,
  F_NYHIX_MFD_BY_DATE f,
  D_NYHIX_MFD_CURRENT d
where
  f.NYHIX_MFD_BI_ID = d.NYHIX_MFD_BI_ID
  and bdd.D_DATE >= f.BUCKET_START_DATE
  and bdd.D_DATE = f.BUCKET_END_DATE
  and f.CREATION_COUNT = 0
  and f.COMPLETION_COUNT = 1
with read only; 

grant select on F_NYHIX_MFD_BY_DATE_SV to MAXDAT_READ_ONLY;

--Replace current view for Paper_sla_time_status and previous_kofax_dcn additions to table 
create or replace view D_NYHIX_MFD_CURRENT_SV as
select * from D_NYHIX_MFD_CURRENT
with read only;

grant select on D_NYHIX_MFD_CURRENT_SV to MAXDAT_READ_ONLY;