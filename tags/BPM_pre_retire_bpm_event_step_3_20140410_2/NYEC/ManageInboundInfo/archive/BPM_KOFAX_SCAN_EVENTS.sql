-- Staging Table - Batch

create table BPM_KOFAX_SCAN_EVENTS
  (BATCH_NAME varchar2(200) not null,
   BATCH_SOURCE varchar2(30) not null,
   BATCH_STAGE varchar2(30) not null,
   BATCH_TYPE varchar2(30) not null,
   BKSE_ID number,
   BPMS_PROCESSED varchar2(1),
   CREATED_BY varchar2(30) not null,
   CREATION_DATE date not null,
   DOCUMENT_COUNT number,
   ENVELOPE_COUNT number,
   KOFAX_CREATION_DATE DATE not null,
   RECEIVED_DATE date not null,
   STAGE_DONE_DATE date,
   STG_LAST_UPDATE_DATE date not null,
   DELETE_BATCH_DATE date,
   BATCH_ID number not null,
   DELETE_BATCH_FLAG varchar2(1),
   BATCH_CLASS varchar2(30),
   BATCH_CURR_STEP varchar2(30),
   BATCH_TIMELINESS_STATUS varchar2(30),
   CANCEL_COMPLETED_BY varchar2(30),
   KOFAX_QC_REASON varchar2(30),
   BATCH_JEOPARDY_STATUS varchar2(30),
   STAGE_CMPLT_BY varchar2(30),
   STAGE_CMPLT_AGE number,
   ASF_CANCEL_BATCH varchar2(1),
   ASF_SAVE_SCAN_RESULT varchar2(1),
   ASF_CMPLT_KOFAX_QC varchar2(1),
   ASF_CMPLT_KOFAX_VAL varchar2(1),
   GWF_QC_REQUIRED varchar2(1),
   BATCH_PAGE_COUNT number);

alter table BPM_KOFAX_SCAN_EVENTS add constraint BKSE_BATCH_STAGE check (BATCH_STAGE in ('QC','SCAN','VALIDATION'));
alter table BPM_KOFAX_SCAN_EVENTS add constraint BKSE_BPMS_PROCESSED check (BPMS_PROCESSED in ('N','Y'));
alter table BPM_KOFAX_SCAN_EVENTS add constraint BKSE_BATCH_CURR_STEP check (BATCH_CURR_STEP in ('QC','SCAN','VALIDATION'));
alter table BPM_KOFAX_SCAN_EVENTS add constraint BKSE_BATCH_JEOPARDY_STATUS check (BATCH_JEOPARDY_STATUS in ('N','NA','Y'));
alter table BPM_KOFAX_SCAN_EVENTS add constraint BKSE_BATCH_TIMELINESS_STATUS check (BATCH_TIMELINESS_STATUS in ('Not Processed','Processes Timely','Processed Untimely'));
alter table BPM_KOFAX_SCAN_EVENTS add constraint BKSE_DELETE_BATCH_FLAG check (DELETE_BATCH_FLAG in ('N','Y'));
alter table BPM_KOFAX_SCAN_EVENTS add constraint BKSE_ASF_CANCEL_BATCH check (ASF_CANCEL_BATCH in ('N','Y'));
alter table BPM_KOFAX_SCAN_EVENTS add constraint BKSE_ASF_SAVE_SCAN_RESULT check (ASF_SAVE_SCAN_RESULT in ('N','Y')); 
alter table BPM_KOFAX_SCAN_EVENTS add constraint BKSE_ASF_CMPLT_KOFAX_QC check (ASF_CMPLT_KOFAX_QC in ('N','Y'));
alter table BPM_KOFAX_SCAN_EVENTS add constraint BKSE_ASF_CMPLT_KOFAX_VAL check (ASF_CMPLT_KOFAX_VAL in ('N','Y'));
alter table BPM_KOFAX_SCAN_EVENTS add constraint BKSE_GWF_QC_REQUIRED check (GWF_QC_REQUIRED in ('N','Y'));

comment on column BPM_KOFAX_SCAN_EVENTS.BATCH_NAME is 'The Batch Name is a unique identifier assigned to each batch.';
comment on column BPM_KOFAX_SCAN_EVENTS.BATCH_SOURCE is 'The Batch Source identifies the channel from which the envelope was originally received. Values for NY are Mail and Fax.';
comment on column BPM_KOFAX_SCAN_EVENTS.BATCH_STAGE	is 'The Batch Stage identifies where in the process the batch currently resides.  The batch stages for New York are: Scan, QC, and Validation. The stages are set when the modules are completed.';
comment on column BPM_KOFAX_SCAN_EVENTS.BATCH_TYPE is 'The Batch Type identifies the group of envelopes that are scanned together.  The business defines the various batch types based on the types of envelopes the project receives. In NY, the batch types are Renewals, Supporting, Undeliverable Recertifications, Rescan, Manual Notice (outbound), Other, Research Faxes (printed from separate fax machine).';
comment on column BPM_KOFAX_SCAN_EVENTS.BKSE_ID is 'This is the unique identifier of the batch instance in the staging table.';
comment on column BPM_KOFAX_SCAN_EVENTS.BPMS_PROCESSED is 'This is set when the updates are processed in the bpms.';
comment on column BPM_KOFAX_SCAN_EVENTS.CREATED_BY is 'The Batch Created By identifies the name of the performer who initiated the batch scanning process.';
comment on column BPM_KOFAX_SCAN_EVENTS.CREATION_DATE is 'The Batch Create Date/Time is the date that the batch is initially scanned. This date may or not be the same day as the envelope receipt date.';
comment on column BPM_KOFAX_SCAN_EVENTS.DOCUMENT_COUNT is 'The Batch Document Count displays total number of documents scanned. This does not represent the number of documents in a single envelope.  The value is set based on the number of document separator sheets read through KOFAX.';
comment on column BPM_KOFAX_SCAN_EVENTS.ENVELOPE_COUNT is 'The Batch Envelope Count represents the number of envelopes in each individual batch.  This number is entered manually at the beginning of the scanning process.';
comment on column BPM_KOFAX_SCAN_EVENTS.KOFAX_CREATION_DATE is 'The KOFAX Creation Date is the date that the scanned batch was successfully created in KOFAX.';
comment on column BPM_KOFAX_SCAN_EVENTS.RECEIVED_DATE	is 'The Batch Receipt Date is the business translation of the creation date for information received outside of business hours.';
comment on column BPM_KOFAX_SCAN_EVENTS.STAGE_DONE_DATE is 'This is the date that the stage was completed.';
comment on column BPM_KOFAX_SCAN_EVENTS.STG_LAST_UPDATE_DATE is 'This is the date that the most recent updates were performed on the instance.';
comment on column BPM_KOFAX_SCAN_EVENTS.DELETE_BATCH_DATE	is 'The Delete Batch Date/Time is set when the batch is deleted or discarded.';
comment on column BPM_KOFAX_SCAN_EVENTS.BATCH_ID is 'The Batch ID is set by KOFAX and is a unique identifier for each batch.';
comment on column BPM_KOFAX_SCAN_EVENTS.BATCH_CLASS is 'The Batch Class is the name of the server submitting the batch for scanning.';
comment on column BPM_KOFAX_SCAN_EVENTS.BATCH_CURR_STEP is 'The Current Activity Step identies where the instances is in the process.  If the Batch has completed scanning with no errors, and there is no QC required or QC is complete, and validation is NOT complete, then the current step is Validation. If the Batch has completed scanning with no errors, and QC is required and QC is not complete, then the current step is QC. If the batch has been created but the scan is not complete, then the current step is Scan. If the batch has completed validation, then the current step is End.';
comment on column BPM_KOFAX_SCAN_EVENTS.BATCH_JEOPARDY_STATUS is 'The Batch Scan Jeopardy Status indicates if an in-process batch is at risk of becoming untimely. Set the flag to "Y" when the batch creation date is greater than or equal to 24 hours from the current date and the batch has not completed the process. Set the flag to "N" when the batch creation date is less than 24 hours from the current date and the batch has not completed the process. Set the flag to NA when the instance is complete.';
comment on column BPM_KOFAX_SCAN_EVENTS.BATCH_TIMELINESS_STATUS is 'The Batch Scanning Timeliness Status indicates whether a batch is processed within the business defined thresholds.  Set the status to "Processed Timely" if the batch complete date (date validation is complete or date the batch is cancelled) is less than 24 hours from batch creation date. Set the status to "Processed Untimely" when the batch complete date is greater than or equal to 24 hours from the batch creation date. Set the status to "Not Processed" when the batch complete date is null OR the batch was cancelled.';
comment on column BPM_KOFAX_SCAN_EVENTS.DELETE_BATCH_FLAG	is 'The Delete Batch Flag is set when a batch is manually or systematically deleted in KOFAX.';
comment on column BPM_KOFAX_SCAN_EVENTS.CANCEL_COMPLETED_BY is 'The Delete Batch Completed By is the performer who deleted or discarded the batch.';
comment on column BPM_KOFAX_SCAN_EVENTS.KOFAX_QC_REASON is 'The KOFAX QC Reason explains what occurred durring the scanning process that requires the envelope and its contents to be reviewed by a worker.';
comment on column BPM_KOFAX_SCAN_EVENTS.STAGE_CMPLT_BY is 'The Stage Completed By is the name of performer who completed the Scanning, QC, or Validation module in KOFAX.';
comment on column BPM_KOFAX_SCAN_EVENTS.STAGE_CMPLT_AGE	is 'The Stage Age is the number of days, hours, and minutes between the creation date and the stage done date.';
comment on column BPM_KOFAX_SCAN_EVENTS.ASF_CANCEL_BATCH is 'The batch is deleted of no longer exists in KOFAX.';
comment on column BPM_KOFAX_SCAN_EVENTS.ASF_SAVE_SCAN_RESULT is 'The batch scanning module is completed by a worker.';
comment on column BPM_KOFAX_SCAN_EVENTS.ASF_CMPLT_KOFAX_QC is 'The batch QC module is completed in KOFAX.';
comment on column BPM_KOFAX_SCAN_EVENTS.ASF_CMPLT_KOFAX_VAL is 'The KOFAX Validation and Post Validation modules are completed.';
comment on column BPM_KOFAX_SCAN_EVENTS.GWF_QC_REQUIRED is 'Envelope QC is required due to issues during scanning and reading of OCR/ICR information.';
comment on column BPM_KOFAX_SCAN_EVENTS.BATCH_PAGE_COUNT is 'The Batch Page Count is the total number of pages that are scanned in a single batch.';

