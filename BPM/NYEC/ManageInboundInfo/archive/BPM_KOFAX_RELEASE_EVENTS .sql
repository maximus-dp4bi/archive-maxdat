-- Staging Table - Envelope

create table BPM_KOFAX_RELEASE_EVENTS
  (BATCH_CLASS varchar2(30) not null,
   BATCH_NAME varchar2(200) not null,
   BKRE_ID number,
   BPMS_PROCESSED varchar2(1),
   CREATED_BY date not null,
   CREATION_DATE date not null,
   DOCUMENT_COUNT number not null,
   ENVELOPE_ID number not null,
   BATCH_ID number not null,
   DMS_DOC_COUNT number,
   DMS_STATUS varchar2(30),
   DMS_STATUS_DT date,
   INBOUND_INFO_AGE date,
   KOFAX_DIR_STATUS varchar2(30) not null,
   KOFAX_DIR_STATUS_DT date not null,
   MAXE_DOC_COUNT varchar2(30),
   MAXE_STATUS varchar2(30),
   MAXE_STATUS_DT date,
   STAGE_DONE_DATE date,
   STG_LAST_UPDATE_DATE date,
   WORK_REQUIRED_FLAG varchar2(2),
   WORK_TASK_ID number,
   WORK_TYPE_CREATED varchar2(30),
   WORK_CREATE_DATE date,
   ENV_DISCARD_DATE date,
   CURR_TASK_TYPE date,
   WHEN_ATTEMPTED_DATE date,
   XML_RESPONSE_CODE number,
   APPLICATION_ID number,
   CASE_NUMBER number,
   CURR_TASK_ID number,
   DISCARD_ENV_FLAG varchar2(1),
   ENV_CURR_STEP varchar2(30),
   ENV_JEOPARDY_STATUS varchar2(30),
   ENV_RECEIPT_DATE date,
   ENV_REL_CYC_AGE number,
   ENV_RESEARCH_REASON varchar2(30),
   ENV_REL_TIME_STATUS varchar2(30),
   ENV_TIMELINESS_STATUS varchar2(30),
   MAXE_ECN number,
   PROX_MATCH_AGE number,
   PROX_MATCH_CMPLT_BY varchar2(30),
   PROX_MATCH_CMPLT_DATE date,
   RELEASE_AGE number,
   ENV_DISCARD_BY number,
   ASF_SAVE_ECN_KOFAX_DIR varchar2(1),
   ASF_COLLECT_ECN varchar2(1),
   ASF_SEND_ECN_DCN varchar2(1),
   ASF_COMPLETE_PROX_MATCH varchar2(1),
   ASF_CREATE_WORK varchar2(1),
   GWF_DIR_RELEASE_STATUS varchar2(1),
   GWF_DMS_DIR_CAPTURE varchar2(1),
   GWF_WORK_REQUIRED varchar2(1),
   GWF_SEND_MAXE varchar2(1));
   
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_BPMS_PROCESSED check (BPMS_PROCESSED in ('N','Y'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_DMS_STATUS check (DMS_STATUS in ('Fail','Pass'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_KOFAX_DIR_STATUS check (KOFAX_DIR_STATUS in ('Fail','Pass'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_MAXE_STATUS check (MAXE_STATUS in ('Fail','Pass'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_WORK_REQUIRED_FLAG check (WORK_REQUIRED_FLAG in ('N','NA','Y'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_WORK_TYPE_CREATED check (WORK_TYPE_CREATED in ('Application','Fair Hearing','Missing Information','Research','Other'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_DISCARD_ENV_FLAG check (DISCARD_ENV_FLAG in ('N','NA','Y'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_ENV_CURR_STEP check (ENV_CURR_STEP in ('DMS Release','KOFAX Release','MAXe Release','Proximal Match','Create Work'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_ENV_JEOPARDY_STATUS check (ENV_JEOPARDY_STATUS in ('N','NA','Y'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_ENV_REL_TIME_STATUS check (ENV_REL_TIME_STATUS in ('Not Processed','Processes Timely','Processed Untimely'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_ENV_TIMELINESS_STATUS check (ENV_TIMELINESS_STATUS in ('Not Processed','Processes Timely','Processed Untimely'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_ENV_DISCARD_BY check (ENV_DISCARD_BY in ('DMS','KOFAX','NA'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_ASF_SAVE_ECN_KOFAX_DIR check (ASF_SAVE_ECN_KOFAX_DIR in ('N','Y'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_ASF_COLLECT_ECN check (ASF_COLLECT_ECN in ('N','Y'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_ASF_SEND_ECN_DCN check (ASF_SEND_ECN_DCN in ('N','Y'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_ASF_COMPLETE_PROX_MATCH check (ASF_COMPLETE_PROX_MATCH in ('N','Y'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_ASF_CREATE_WORK check (ASF_CREATE_WORK in ('N','Y'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_GWF_DIR_RELEASE_STATUS check (GWF_DIR_RELEASE_STATUS in ('N','Y'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_GWF_DMS_DIR_CAPTURE check (GWF_DMS_DIR_CAPTURE in ('N','Y'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_GWF_WORK_REQUIRED check (GWF_WORK_REQUIRED in ('N','Y'));
alter table BPM_KOFAX_RELEASE_EVENTS add constraint BKRE_GWF_SEND_MAXE check (GWF_SEND_MAXE in ('N','Y'));

comment on column BPM_KOFAX_RELEASE_EVENTS.BATCH_CLASS is 'The Batch Class is the name of the server submitting the batch for scanning.';
comment on column BPM_KOFAX_RELEASE_EVENTS.BATCH_NAME	is 'The Batch Name is a unique identifier assigned to each batch.';
comment on column BPM_KOFAX_RELEASE_EVENTS.BKRE_ID is 'This is the unique identifier of the envelope instance in the staging table.';
comment on column BPM_KOFAX_RELEASE_EVENTS.BPMS_PROCESSED	is 'This is set when the updates are processed in the bpms.';
comment on column BPM_KOFAX_RELEASE_EVENTS.CREATED_BY	is 'The Created By is the name of the performer who created the envelope.';
comment on column BPM_KOFAX_RELEASE_EVENTS.CREATION_DATE is 'The Creation Date is the date that the envelope is created in MAXe.';
comment on column BPM_KOFAX_RELEASE_EVENTS.DOCUMENT_COUNT	is 'The  Document Count is the number of generic DCNs saved in the KOFAX Directory.';
comment on column BPM_KOFAX_RELEASE_EVENTS.ENVELOPE_ID is 'The Envelope ID is a unique number assigned to each envelope for tracking.';
comment on column BPM_KOFAX_RELEASE_EVENTS.BATCH_ID	is 'The Batch ID is set by KOFAX and is a unique identifier for each batch.';
comment on column BPM_KOFAX_RELEASE_EVENTS.DMS_DOC_COUNT is 'The DMS Document count is the number of DCNs that DMS created for the envelope.';
comment on column BPM_KOFAX_RELEASE_EVENTS.DMS_STATUS	is 'The DMS Status indicates whether the ECN was successfully saved and processed in DMS.  If there is no error returned when DMS collects the ECN from the KOFAX directory, then the status is set to "Pass." If there is an error when DMS attempts to get the Envelope from the KOFAX directory, then the status is set to "Fail." This field can be updated if a subsequent attempt passed.';
comment on column BPM_KOFAX_RELEASE_EVENTS.DMS_STATUS_DT is 'The DMS Status date indicates the date and time that DMS attempted to collect the ECN from the KOFAX Directory.  This date can be updated at each attempt.';
comment on column BPM_KOFAX_RELEASE_EVENTS.INBOUND_INFO_AGE	is 'The Inbound Info Cycle Age is the days, hours, minutes, and seconds from the Batch Create Date/Time to  one of the following:  - Envelope Discarded Date/Time  - Batch Cancel Date/Time  - Proximal Match Complete Date/Time when no work is required,  - Create Work Complete Date/Time.';
comment on column BPM_KOFAX_RELEASE_EVENTS.KOFAX_DIR_STATUS	is 'The KOFAX Directory status indicates whether the ECN and XML were saved in the KOFAX Directory.';
comment on column BPM_KOFAX_RELEASE_EVENTS.KOFAX_DIR_STATUS_DT is 'The KOFAX Directory status date is the date that the envelope was passed to the KOFAX Directory.';
comment on column BPM_KOFAX_RELEASE_EVENTS.MAXE_DOC_COUNT	is 'The MAXe Document count is the number of  DCNs created in MAXe after DMS releases the envelope';
comment on column BPM_KOFAX_RELEASE_EVENTS.MAXE_STATUS is 'The MAXe Status indicates whether the envelope was successfully passed from DMS to MAXe.  If there is an error in DMS when DMS attempts to release the information to MAXe, then the status is "Fail." If there is no error, then the status is "Pass."';
comment on column BPM_KOFAX_RELEASE_EVENTS.MAXE_STATUS_DT	is 'The MAXe Status date indicates the date that DMS attempts to release the ECN to MAXe.';
comment on column BPM_KOFAX_RELEASE_EVENTS.STAGE_DONE_DATE is 'This is the date that the stage was completed.';
comment on column BPM_KOFAX_RELEASE_EVENTS.STG_LAST_UPDATE_DATE	is 'This is the date that the most recent updates were performed on the instance.';
comment on column BPM_KOFAX_RELEASE_EVENTS.CURR_TASK_TYPE	is 'The Current Task Type is the name of the task, if one exists, associated to the envelope in MAXe.';
comment on column BPM_KOFAX_RELEASE_EVENTS.WORK_REQUIRED_FLAG	is 'The Work Required Flag indicates whether a work task should be generated based on the envelope contents and current case information. Work is required when:  - envelope is autolinked  - application document is linked, there is no open system generated task, and the case status is in Renewal  - Fair Hearing document is linked  - Supporting information is linked to a case with an in-process application and no data entry or QC tasks system generated task exists.  If a State Review task exists, then a new data entry task should be created. 
Work is NOT required when:  - no case exists in MAXe  - the document is an application or supporting information for an in-process application and there is an open system generated task that is NOT in State Review  - the envelope is linked to an application that has been completed and is beyond the grace period for reprocessing (each document status is set to ""valid no link"")  - the envelope is linked to a case with no application record in MAXe (each document status is set to ""link no app"")  - the envelope is trashed';
comment on column BPM_KOFAX_RELEASE_EVENTS.WORK_TASK_ID	is 'The Task ID is the ID of the task created AFTER all proximal match tasks are completed. This TASK ID does not represent the HSDE-QC, Link Document Set, or Document Problem Resolution task.';
comment on column BPM_KOFAX_RELEASE_EVENTS.WORK_TYPE_CREATED is 'The Work Type created defines the data entry or research work that is created once Proximal Match is completed.  If no work is created, then the value will be null. Valid worktypes are Renewal Application, Missing Information, Research, or Other.';
comment on column BPM_KOFAX_RELEASE_EVENTS.WHEN_ATTEMPTED_DATE is 'The Envelope Release Attempt Date/Time is set when KOFAX attempts to release envelope and document data into the Document Management System (DMS).';
comment on column BPM_KOFAX_RELEASE_EVENTS.XML_RESPONSE_CODE is 'The KOFAX Release Status describes the results of the Document Management System (DMS) creating the Envelope and Document IDs and electonic data, and then releasing the data to MAXe.';
comment on column BPM_KOFAX_RELEASE_EVENTS.APPLICATION_ID	is 'The Application ID is the unique application to which an envelope is linked. This should be populated once the ECN is linked to an application in MAXe.';
comment on column BPM_KOFAX_RELEASE_EVENTS.CASE_NUMBER is 'The Case Number is the unique Case in MAXe to which an envelope is linked, or the case to which the clients belong.';
comment on column BPM_KOFAX_RELEASE_EVENTS.CURR_TASK_ID	is 'The Current Task ID is the unique identifier of the task, if one exists, associated to the envelope in MAXe.  This could be the HSDE-QC task, Link Document Set task, Application Problem Resolution task, or the work type created task.  When the instance is completed, this field should be null.';
comment on column BPM_KOFAX_RELEASE_EVENTS.DISCARD_ENV_FLAG	is 'The Discard Envelope Flag is set when an envelope cannot be released and must be rescanned. This can happen in KOFAX or in DMS.';
comment on column BPM_KOFAX_RELEASE_EVENTS.ENV_CURR_STEP is 'The Current Activity Step identifes where the instance is in the process.';
comment on column BPM_KOFAX_RELEASE_EVENTS.ENV_JEOPARDY_STATUS is 'The Release Jeopardy Status indicates if an envelope is at risk of becoming untimely.  The Status is set to "Y" if the ECN does not exist in MAXe, and the DMS Status is Pass, and the DMS status date timestamp is equal to or greater than 45 minutes. The Status is set to "N" if the ECN does not exist in MAXe, and the DMS Status is Pass, and the DMS status date timestamp is less than 45 minutes. The status is set to "NA" if the ECN exists in MAXe or if the instance is complete.';
comment on column BPM_KOFAX_RELEASE_EVENTS.ENV_RECEIPT_DATE	is 'The Envelope Receipt Date is the business date that the envelope is received.  If an envelope is received outside of normal business hours, then the date is pushed forward to the next available business day.';
comment on column BPM_KOFAX_RELEASE_EVENTS.ENV_REL_CYC_AGE is 'The Envelope Release Cycle age is the days, hours, minutes, and seconds from the Envelope Release Attempt Date/Time to one of the following:  - Envelope Discarded Date/Time  - Proximal Match Complete Date/Time when no work is required  - Create Work Complete Date/Time.';
comment on column BPM_KOFAX_RELEASE_EVENTS.ENV_RESEARCH_REASON is 'The Envelope Research Reason is a value set (manually or automatically) that explains to users why an envelope was sent to research.';
comment on column BPM_KOFAX_RELEASE_EVENTS.ENV_REL_TIME_STATUS is 'The Envelope Release Timeliness Status indicates if an envelope was RELEASED timely, untimely, or has not been released. The Status is set to "Processed Untimely" if the MAXE Status is Pass, and the difference from the KOFAX Status date and the MAXE status date timestamp is equal to or greater than 60 minutes. The Status is set to "Processed Timely" if the MAXE Status is passed, and the difference from the KOFAX status date and the MAXE status date timestamp is less than 60 minutes. The Status is set to "Not Processed" when the MAXE Status is fail or null.';
comment on column BPM_KOFAX_RELEASE_EVENTS.ENV_TIMELINESS_STATUS is 'The Envelope Timeliness Status indicates if an envelope was processed timely, untimely, or has not been completed. Set the status to "Processed Timely" if when the proximal match is completed in 3 or less business days. Set the status to "Processed Untimely" when the proximal match is completed in more than 3 business days. Set the status to "Not Processed" when the proximal match is not completed.';
comment on column BPM_KOFAX_RELEASE_EVENTS.MAXE_ECN	is 'The MAXe ECN is the ECN saved in MAXe. This is used to reconcile envelopes from KOFAX to MAXE.';
comment on column BPM_KOFAX_RELEASE_EVENTS.PROX_MATCH_AGE	is 'The Proximal Match Age is the days, hours, minutes, and seconds from the MAXE_STATUS_DATE to the Proximal Match Complete Date/Time when the MAXE_STATUS = Pass.';
comment on column BPM_KOFAX_RELEASE_EVENTS.PROX_MATCH_CMPLT_BY is 'The Proximal Match Completed By is the name of the performer who processed and linked all documents within an envelope.  Use the name of the worker who completed the Link Document Set tasks when no Document Problem Resolution task was created after. Use the name of the worker who completed the Document Problem Resolution task if one was created.';
comment on column BPM_KOFAX_RELEASE_EVENTS.PROX_MATCH_CMPLT_DATE is 'The Proximal Match Complete Date/Time represents the date that the envelope and its corresponding documents are all processed (linked, or discarded for a valid reason).';
comment on column BPM_KOFAX_RELEASE_EVENTS.RELEASE_AGE is 'The Release Age is the days, hours, minutes, and seconds from the KOFAX Status Date when KOFAX Status = Pass to one of the following:  - Envelope Discard Date  - MAXe Status Date when MAXe Status = Pass';
comment on column BPM_KOFAX_RELEASE_EVENTS.WORK_CREATE_DATE	is 'The Work Created Date/Time is the date that the application, fair hearing, case maintenance, or missing information work is created.';
comment on column BPM_KOFAX_RELEASE_EVENTS.ENV_DISCARD_BY	is 'The Envelope Discarded By is the name of the performer who removed the envelope for rescanning.  If KOFAX deletes the envelope because it cannot be saved to the directory, then the performer is KOFAX.  If DMS deletes the envelope because it cannot be pulled from the directory or saved to MAXe, then the performer is DMS.';
comment on column BPM_KOFAX_RELEASE_EVENTS.ENV_DISCARD_DATE	is 'The Envelope Discarded Date/Time is set when the envelope is removed from DMS and KOFAX because it cannot be released to MAXe.';
comment on column BPM_KOFAX_RELEASE_EVENTS.ASF_SAVE_ECN_KOFAX_DIR is 'KOFAX successfully saves or cannot save ECN to directory.';
comment on column BPM_KOFAX_RELEASE_EVENTS.ASF_COLLECT_ECN is 'The DMS saves failing or passing status after scheduled attempt to collect ECN from KOFAX directory.';
comment on column BPM_KOFAX_RELEASE_EVENTS.ASF_SEND_ECN_DCN is 'Each ECN and DCN in DMS has corresponding ECN and DCN in MAXe; DMS status shows passing status or not every ECN and DCN in DMS has corresponding ECN and DCN in MAXe; DMS status shows failing status.';
comment on column BPM_KOFAX_RELEASE_EVENTS.ASF_COMPLETE_PROX_MATCH is 'The envelope is autolinked or Link Document Set is completed and (no Document Problem Resolution or Alternate Document Processing task(s) are created or the subsequent Document Problem Resolution is completed and no Alternate Document Processing task(s) are created or the subsequent Document Problem Resolution is completed and the subsequent Alternate Document Processing task is completed.';
comment on column BPM_KOFAX_RELEASE_EVENTS.ASF_CREATE_WORK is 'All documents within an envelope are processed and (a data entry task type (for application, missing information, research, or appeal-related work) is created or with a valid-no link or link - no app status).';
comment on column BPM_KOFAX_RELEASE_EVENTS.GWF_DIR_RELEASE_STATUS is ' Envelope response message returned to KOFAX after attempting to save the ECN to the KOFAX Directory has an outcome that means the envelope and all of the documents in the envelope were NOT successfully saved.';
comment on column BPM_KOFAX_RELEASE_EVENTS.GWF_DMS_DIR_CAPTURE is 'KOFAX ECN matches the ECN in DMS.';
comment on column BPM_KOFAX_RELEASE_EVENTS.GWF_WORK_REQUIRED is 'Envelope, application document, fair heqaring document or supporting information is linked.';
comment on column BPM_KOFAX_RELEASE_EVENTS.GWF_SEND_MAXE is 'KOFAX ECN matches the ECN in MAXe.';
