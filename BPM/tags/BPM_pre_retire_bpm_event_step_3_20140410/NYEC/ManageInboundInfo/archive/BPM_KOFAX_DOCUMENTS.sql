-- Staging Table - Documents

create table BPM_KOFAX_DOCUMENTS
  (DCN number,
   DOCUMENT_TYPE varchar2(30) not null,
   DOCUMENT_SUB_TYPE varchar2(30) not null,
   CREATION_DATE date not null,
   FORM_TYPE varchar2(30) not null,
   BATCH_NAME varchar2(200) not null,
   ENVELOPE_ID number not null,
   CASE_NUMBER number,
   CREATED_BY varchar2(30) not null,
   KOFAX_DCN number not null,
   BATCH_ID number not null,
   CEPA_ID number not null,
   STAGE_DONE_DATE date,
   STG_EXTRACT_DATE date,
   STG_LAST_UPDATE_DATE date,
   MAXE_STATUS varchar2(30),
   DOCUMENT_PAGE_COUNT number);
   
alter table BPM_KOFAX_DOCUMENTS add constraint BKD_MAXE_STATUS check (MAXE_STATUS in ('DCN in MAXe','DCN Not in MAXe'));

comment on column BPM_KOFAX_DOCUMENTS.DCN	is 'The Document ID is the unique identifier to track individual documents in an envelope. This Document ID is created in DMS and saved in MAXe.';
comment on column BPM_KOFAX_DOCUMENTS.DOCUMENT_TYPE	is 'The Document Type is the high level description of a document in an envelope.';
comment on column BPM_KOFAX_DOCUMENTS.DOCUMENT_SUB_TYPE is 'The Document Sub-Type is the description of the information inside an envelope.';
comment on column BPM_KOFAX_DOCUMENTS.CREATION_DATE is 'The Document Create Date is the date that the document ID is assigned by DMS.';
comment on column BPM_KOFAX_DOCUMENTS.FORM_TYPE	is 'The Document Form type is the description of the form returned by the client.';
comment on column BPM_KOFAX_DOCUMENTS.BATCH_NAME is 'The Batch Name is a unique identifier assigned to each batch.';
comment on column BPM_KOFAX_DOCUMENTS.ENVELOPE_ID	is 'The Envelope ID is a unique number assigned to each envelope for tracking.';
comment on column BPM_KOFAX_DOCUMENTS.CASE_NUMBER	is 'The Case Number is the unique Case to which an envelope is linked, or the case to which the clients belong.';
comment on column BPM_KOFAX_DOCUMENTS.CREATED_BY is 'The Created By is the name of the performer who created the document.';
comment on column BPM_KOFAX_DOCUMENTS.KOFAX_DCN is 'The KOFAX Document ID is assigned by KOFAX and sent to DMS, but is not passed to MAXe.';
comment on column BPM_KOFAX_DOCUMENTS.MAXE_STATUS is 'The MAXe status indicates if the DCN was saved in MAXe.';
comment on column BPM_KOFAX_DOCUMENTS.BATCH_ID is 'The Batch ID is set by KOFAX and is a unique identifier for each batch.';
comment on column BPM_KOFAX_DOCUMENTS.DOCUMENT_PAGE_COUNT is 'The document page count is the count of individual pages in a document.';

