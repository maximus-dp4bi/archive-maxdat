/*
Created on 16-Aug-2012 by Raj A.
Description:
This is the Process MI Change Data Capture stage table and hold the MI Task info.
and any MIs assessed on the Application. The key driver to this table is the presence of 
a MI Task (State Data Entry Task-MI and State Review Task - MI Reprocess Result) on the 
application.

v1 Raj A. 16-Aug-2012 Creation.
v2 Raj A. 21-Aug-2012 Added new table Letters_STG and deleted MI_Letters_STG table.
v3 Raj A. 22-Aug-2012 Added few more columns to the Letters_STG table.
*/
create table APP_MIS_STG
(
  MI_TASK_ID             NUMBER(18) not null,
  MI_TASK_CREATION_DATE  DATE,
  MI_TASK_CREATED_BY     VARCHAR2(80),
  MI_TASK_TYPE           VARCHAR2(100),
  MI_TASK_APP_ID         NUMBER(18),
  MI_MISSING_INFO_ID     NUMBER(18) not null,
  MI_APP_INDIVIDUAL_ID   NUMBER(18),
  MI_CREATION_DATE       DATE,
  MI_REPORTED_DATE       DATE,
  MI_SATISFIED_DATE      DATE,
  MI_SATISFIED_BY        VARCHAR2(50),
  MI_TYPE_CD             VARCHAR2(32),
  MI_TYPE_DOC_DATA       VARCHAR2(8),
  MI_SATISFIED_REASON_CD VARCHAR2(32),
  PROCESS_MI_START_TIME  DATE
);

/*
Description:
This is the Process MI Change Data Capture stage table and hold the MI Documents associated to the MI tasks in the APP_MIS_STG table.
*/
create table MI_DOCS_STG
(
  APPLICATION_ID         NUMBER(18),
  APP_DOC_DATA_ID        NUMBER(18) not null,
  ECN                    VARCHAR2(32),
  DCN                    VARCHAR2(32),
  ENVELOPE_RECEIVED_DATE DATE,
  DOCUMENT_LINKED_DATE   DATE,
  DOCUMENT_LINKED_BY     VARCHAR2(80),
  ENVELOPE_TYPE_CD       VARCHAR2(32),
  ENVELOPE_STATUS        VARCHAR2(32),
  ENVELOPE_STATUS_DATE   DATE,
  ENVELOPE_MEDIA_CD      VARCHAR2(32)
);

/*
Description:
This is the Process MI Change Data Capture stage table and hold all the letters associated to the 
Applications (both in-process and completed apps in the past 31 days).
*/
create table LETTERS_STG
(
  LETTER_ID           NUMBER(18) not null,
  LETTER_REQUESTED_ON DATE,
  LETTER_STATUS_CD    VARCHAR2(32),
  LETTER_STATUS_REPORT_LABEL VARCHAR2 (64),
  LETTER_CREATE_TS    DATE,
  LETTER_UPDATE_TS    DATE,
  LETTER_SENT_ON      DATE,
  LETTER_MAILED_DATE  DATE,
  LETTER_APP_ID       NUMBER(18),
  LETTER_CASE_ID      NUMBER(18),
  LETTER_PARENT_LMREQ_ID     NUMBER (18),
  LETTER_REF_TYPE     VARCHAR2(40),
  LETTER_TYPE_CD      VARCHAR2(40),
  LETTER_TYPE         VARCHAR2(4000),
  LETTER_REQUEST_TYPE VARCHAR2(2),
  LETTER_LANG_CD      VARCHAR2 (32),   
  LETTER_DRIVER_TYPE  VARCHAR2 (4),
  LET_MATERIAL_REQUEST_ID  NUMBER (18),
  MW_PROCESSED varchar2(1) default 'N',
  AP_PROCESSED varchar2(1) default 'N',
  MIB_PROCESSED varchar2(1) default 'N',
  MI_PROCESSED varchar2(1) default 'N',
  SR_PROCESSED varchar2(1) default 'N',
  TP_PROCESSED varchar2(1) default 'N',
  IR_PROCESSED varchar2(1) default 'N',
  ALL_PROC_DONE_DATE DATE
);

/*
Description:
This is the Process MI Change Data Capture stage table and hold the MI Call Campaign events associated to the MI tasks in the APP_MIS_STG table.
*/
create table MI_CAMPAIGN_STG
(
  EVENT_ID      NUMBER(18) not null,
  EVENT_TYPE_CD VARCHAR2(32),
  CREATE_TS     DATE,
  APP_ID        NUMBER(18)
);

/************ Process MI Pre-BPM Stage table *************/
/*
Data massaging is done in this table. Inserts, Updates and transformations happen here.
When data massaging is done, data is moved to the Final BPM Stage table i.e., NYEC_ETL_PROCESS_MI.
*/
create table Process_MI_STG 
(
PMS_ID	NUMBER primary key,
STAGE_DONE_DATE	DATE,
STG_EXTRACT_DATE	DATE default sysdate,
STG_LAST_UPDATE_DATE	DATE  default sysdate,
INSTANCE_COMPLETE_DT	DATE,
INSTANCE_STATUS	VARCHAR2(50),
Insert_Flg	VARCHAR(1),
Update_Flg 	VARCHAR(1),
GWF_CHANNEL	VARCHAR(1),
CANCEL_DATE	DATE,
GWF_PHONE_QC_REQ	VARCHAR(1) default 'N',
GWF_UPDATE_STATE	VARCHAR(1) default 'N',
GWF_MANUAL_LETTER	VARCHAR(1) default 'N',
GWF_SEND_RESEARCH	VARCHAR(1),
GWF_QC_REQUIRED	VARCHAR(1),
GWF_QC_Outcome	VARCHAR(1),
GWF_MI_Outcome	VARCHAR(1),
ASF_RECEIVE_MI	VARCHAR(1) default 'N' not null,
ASF_CREATE_STATE_ACCEPT	VARCHAR(1) default 'N'  not null,
ASF_DETERMINE_MI_OUTCOME	VARCHAR(1) default 'N'   not null,
ASF_COMPLETE_MI_TASK	VARCHAR(1) default 'N'   not null,
ASF_PERFORM_QC	VARCHAR(1)  default 'N' not null,
ASF_PERFORM_RESEARCH	VARCHAR(1)  default 'N',
ASF_SEND_MI_LETTER	VARCHAR(1)  default 'N',
AGE_IN_BUSINESS_DAYS	NUMBER  default 0 not null ,
AGE_IN_CALENDAR_DAYS	NUMBER  ,
ALL_MI_SATISFIED	VARCHAR2(1),  -- Added by Raj.
APP_ID	NUMBER  not null ,
CURRENT_TASK_ID	NUMBER,
JEOPARDY_FLAG	VARCHAR(1) default 'N'  not null,
MI_DOC_ECN                VARCHAR2(32),
MI_RECEIPT_DT             DATE,
MI_DOC_LINKED_DATE        DATE,
MI_DOC_LINKED_BY          VARCHAR2(100),
MI_TYPE	VARCHAR2(50),
MI_CHANNEL	VARCHAR2(20),
MI_TASK_TYPE	VARCHAR2(50)  not null ,
MI_TASK_ID	NUMBER  not null ,
MI_TASK_CREATE_DATE	DATE,
MI_TASK_CREATED_BY      VARCHAR2(100),
MI_task_claimed_date    date,
MI_task_claimed_by      VARCHAR2(100),
MI_TASK_COMPLETE_DATE	DATE,
MI_TASK_COMPLETED_BY    VARCHAR2(100),
MI_CYCLE_BUS_DAYS	NUMBER,
MI_CYCLE_END_DT	DATE,
MI_CYCLE_START_DT	DATE,
MI_CALL_CAMPAIGN	VARCHAR2(50),
MI_LETTER_REQUEST_ID	NUMBER,
MI_LETTER_STATUS	VARCHAR2(50),
MI_letter_Requested_On  date,
MI_Letter_Sent_On       date,
MAN_LETTER_ID	NUMBER,
MAN_LETTER_SENT_DT	DATE,
NEW_MI_CREATION_DATE	DATE,
QC_TASK_ID	NUMBER,
QC_task_claimed_date date,
QC_task_claimed_by   VARCHAR2(100),
QC_task_completed_date date,
QC_task_Completed_By VARCHAR2(100),
RESEARCH_TASK_ID	NUMBER,
Rsrch_task_claimed_date date,
Rsrch_task_claimed_by   VARCHAR2(100),
Rsrch_task_completed_date date,
Rsrch_task_Completed_By VARCHAR2(100),
RESEARCH_REASON	VARCHAR2(50),
PENDING_MI_TYPE	VARCHAR2(100),
SLA_DAYS	NUMBER,
SLA_DAYS_TYPE	VARCHAR2(20),
SLA_JEOPARDY_DT	DATE,
SLA_JEOPARDY_DAYS	NUMBER,
SLA_TARGET_DAYS	NUMBER,
STATE_REVIEW_TASK_ID	NUMBER,
StRw_task_claimed_date date,
StRw_task_claimed_by   VARCHAR2(100),
StRw_task_completed_date date,
StRw_task_Completed_By VARCHAR2(100),
TIMELINESS_STATUS	VARCHAR2(20),
ASED_CREATE_STATE_ACCEPT	DATE,
ASPB_CREATE_STATE_ACCEPT	VARCHAR2(100),
ASSD_CREATE_STATE_ACCEPT	DATE,
ASED_DETERMINE_MI_OUTCOME	DATE,
ASPB_DETERMINE_MI_OUTCOME	VARCHAR2(100),
ASSD_DETERMINE_MI_OUTCOME	DATE,
ASED_PERFORM_QC	DATE,
ASPB_PERFORM_QC	VARCHAR2(100),
ASSD_PERFORM_QC	DATE,
ASED_PERFORM_RESEARCH	DATE,
ASPB_PERFORM_RESEARCH	VARCHAR2(100),
ASSD_PERFORM_RESEARCH	DATE,
ASED_SEND_MI_LETTER	DATE,
ASPB_SEND_MI_LETTER	VARCHAR2(100),
ASSD_SEND_MI_LETTER	DATE,
ASED_RECEIVE_MI	DATE,
ASPB_RECEIVE_MI	VARCHAR2(100),
ASSD_RECEIVE_MI	DATE,
ASED_COMPLETE_MI_TASK	DATE,
ASPB_COMPLETE_MI_TASK	VARCHAR2(100),
ASSD_COMPLETE_MI_TASK	DATE
);

alter table Process_MI_STG
add constraint c_pro_mi_instance_status
check (INSTANCE_STATUS in ('ACTIVE','COMPLETE'));

alter table Process_MI_STG
add constraint c_pro_mi_gwf_channel
check (GWF_CHANNEL in ('M','P','S'));

alter table Process_MI_STG
add constraint c_pro_mi_gwf_phone_qc_req
check (GWF_PHONE_QC_REQ in ('Y','N'));

alter table Process_MI_STG
add constraint c_pro_mi_gwf_upd_state
check (GWF_UPDATE_STATE in ('Y','N'));

alter table Process_MI_STG
add constraint c_pro_mi_gwf_manual_let
check (GWF_MANUAL_LETTER in ('Y','N'));

alter table Process_MI_STG
add constraint c_pro_mi_gwf_send_research
check (GWF_SEND_RESEARCH in ('Y','N'));

alter table Process_MI_STG
add constraint c_pro_mi_gwf_
check (GWF_QC_REQUIRED in ('Y','N'));

alter table Process_MI_STG
add constraint c_pro_mi_gwf_qc_outc
check (GWF_QC_Outcome in ('Y','R'));

alter table Process_MI_STG
add constraint c_pro_mi_gwf_mi_outc
check (GWF_MI_Outcome in ('S','M','A'));

--------------------
alter table Process_MI_STG
add constraint c_pro_mi_asf_receive_Mi
check (ASF_RECEIVE_MI in ('Y','N'));

alter table Process_MI_STG
add constraint c_pro_mi_asf_crt_state_accept
check (ASF_CREATE_STATE_ACCEPT in ('Y','N'));

alter table Process_MI_STG
add constraint c_pro_mi_asf_det_mi_outcome
check (ASF_DETERMINE_MI_OUTCOME in ('Y','N'));

alter table Process_MI_STG
add constraint c_pro_mi_asf_compl_mi_task
check (ASF_COMPLETE_MI_TASK in ('Y','N'));

alter table Process_MI_STG
add constraint c_pro_mi_asf_perf_QC
check (ASF_PERFORM_QC in ('Y','N'));

alter table Process_MI_STG
add constraint c_pro_mi_asf_perf_Research
check (ASF_PERFORM_RESEARCH in ('Y','N'));

alter table Process_MI_STG
add constraint c_pro_mi_asf_send_mi_let
 check (ASF_SEND_MI_LETTER in ('Y','N'));

alter table Process_MI_STG
add constraint c_pro_mi_jeopardy_flag
check (JEOPARDY_FLAG in ('Y','N'));

alter table Process_MI_STG
 add constraint c_pro_mi_mi_type 
 check (MI_TYPE in ('Data','Document','Both',null));

alter table Process_MI_STG
add constraint c_pro_mi_mi_channel
 check (MI_CHANNEL in ('Phone','Mail','Fax','Online','Interface',null));

alter table Process_MI_STG
add constraint c_pro_mi_task_type
 check (MI_TASK_TYPE in ('State Data Entry Task - MI','State Review Task - MI Reprocess Result'));
 
alter table  Process_MI_STG
add constraint c_pro_mi_task_ID_UK
  unique ( MI_TASK_ID);


/************ Final Process MI BPM Stage table *************/
/*
No Data massaging is done in this table. 
Inserts, Updates and transformations all happen in Pre-BPM stage table i.e., PROCESS_MI_STG.
Finally, data is moved to this Final BPM Stage table i.e., NYEC_ETL_PROCESS_MI.

NOTE: The Primary key of the process_mi_stg i.e., PMS_ID is used to populate the NEPM_ID.
*/
create table NYEC_ETL_Process_MI 
(
NEPM_ID	NUMBER primary key,
STAGE_DONE_DATE	DATE,
STG_EXTRACT_DATE	DATE default sysdate,
STG_LAST_UPDATE_DATE	DATE  default sysdate,
INSTANCE_COMPLETE_DT	DATE,
INSTANCE_STATUS	VARCHAR2(50),
GWF_CHANNEL	VARCHAR(1),
CANCEL_DATE	DATE,
GWF_PHONE_QC_REQ	VARCHAR(1) default 'N',
GWF_UPDATE_STATE	VARCHAR(1) default 'N',
GWF_MANUAL_LETTER	VARCHAR(1) default 'N',
GWF_SEND_RESEARCH	VARCHAR(1),
GWF_QC_REQUIRED	VARCHAR(1),
GWF_QC_Outcome	VARCHAR(1),
GWF_MI_Outcome	VARCHAR(1),
ASF_RECEIVE_MI	VARCHAR(1) default 'N' not null,
ASF_CREATE_STATE_ACCEPT	VARCHAR(1) default 'N'  not null,
ASF_DETERMINE_MI_OUTCOME	VARCHAR(1) default 'N'   not null,
ASF_COMPLETE_MI_TASK	VARCHAR(1) default 'N'   not null,
ASF_PERFORM_QC	VARCHAR(1)  default 'N' not null,
ASF_PERFORM_RESEARCH	VARCHAR(1)  default 'N',
ASF_SEND_MI_LETTER	VARCHAR(1)  default 'N',
AGE_IN_BUSINESS_DAYS	NUMBER  default 0 not null ,
AGE_IN_CALENDAR_DAYS	NUMBER,
ALL_MI_SATISFIED	VARCHAR2(1),
APP_ID	NUMBER  not null ,
CURRENT_TASK_ID	NUMBER,
JEOPARDY_FLAG	VARCHAR(1) default 'N'  not null,
MI_DOC_ECN                VARCHAR2(32),
MI_RECEIPT_DT             DATE,
MI_DOC_LINKED_DATE        DATE,
MI_DOC_LINKED_BY          VARCHAR2(100),
MI_TYPE	VARCHAR2(50),
MI_CHANNEL	VARCHAR2(20),
MI_TASK_TYPE	VARCHAR2(50)  not null ,
MI_TASK_ID	NUMBER  not null ,
MI_TASK_CREATE_DATE	DATE,
MI_TASK_CREATED_BY      VARCHAR2(100),
MI_task_claimed_date    date,
MI_task_claimed_by      VARCHAR2(100),
MI_TASK_COMPLETE_DATE	DATE,
MI_TASK_COMPLETED_BY    VARCHAR2(100),
MI_CYCLE_BUS_DAYS	NUMBER,
MI_CYCLE_END_DT	DATE,
MI_CYCLE_START_DT	DATE,
MI_CALL_CAMPAIGN	VARCHAR2(50),
MI_LETTER_REQUEST_ID	NUMBER,
MI_LETTER_STATUS	VARCHAR2(50),
MI_letter_Requested_On  date,
MI_Letter_Sent_On       date,
MAN_LETTER_ID	NUMBER,
MAN_LETTER_SENT_DT	DATE,
NEW_MI_CREATION_DATE	DATE,
QC_TASK_ID	NUMBER,
QC_task_claimed_date date,
QC_task_claimed_by   VARCHAR2(100),
QC_task_completed_date date,
QC_task_Completed_By VARCHAR2(100),
RESEARCH_TASK_ID	NUMBER,
Rsrch_task_claimed_date date,
Rsrch_task_claimed_by   VARCHAR2(100),
Rsrch_task_completed_date date,
Rsrch_task_Completed_By VARCHAR2(100),
RESEARCH_REASON	VARCHAR2(50),
PENDING_MI_TYPE	VARCHAR2(100),
SLA_DAYS	NUMBER,
SLA_DAYS_TYPE	VARCHAR2(20),
SLA_JEOPARDY_DT	DATE,
SLA_JEOPARDY_DAYS	NUMBER,
SLA_TARGET_DAYS	NUMBER,
STATE_REVIEW_TASK_ID	NUMBER,
StRw_task_claimed_date date,
StRw_task_claimed_by   VARCHAR2(100),
StRw_task_completed_date date,
StRw_task_Completed_By VARCHAR2(100),
ST_ACCEPT_TASK_ID         NUMBER,
ST_ACCEPT_COMPLETE_DATE   DATE,
ST_ACCEPT_COMPLETED_BY    VARCHAR2(100),
TIMELINESS_STATUS	VARCHAR2(20),
ASED_CREATE_STATE_ACCEPT	DATE,
ASPB_CREATE_STATE_ACCEPT	VARCHAR2(100),
ASSD_CREATE_STATE_ACCEPT	DATE,
ASED_DETERMINE_MI_OUTCOME	DATE,
ASPB_DETERMINE_MI_OUTCOME	VARCHAR2(100),
ASSD_DETERMINE_MI_OUTCOME	DATE,
ASED_PERFORM_QC	DATE,
ASPB_PERFORM_QC	VARCHAR2(100),
ASSD_PERFORM_QC	DATE,
ASED_PERFORM_RESEARCH	DATE,
ASPB_PERFORM_RESEARCH	VARCHAR2(100),
ASSD_PERFORM_RESEARCH	DATE,
ASED_SEND_MI_LETTER	DATE,
ASPB_SEND_MI_LETTER	VARCHAR2(100),
ASSD_SEND_MI_LETTER	DATE,
ASED_RECEIVE_MI	DATE,
ASPB_RECEIVE_MI	VARCHAR2(100),
ASSD_RECEIVE_MI	DATE,
ASED_COMPLETE_MI_TASK	DATE,
ASPB_COMPLETE_MI_TASK	VARCHAR2(100),
ASSD_COMPLETE_MI_TASK	DATE
);

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_instance_status
check (INSTANCE_STATUS in ('ACTIVE','COMPLETE'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_gwf_channel
check (GWF_CHANNEL in ('M','P','S'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_gwf_phone_qc_req
check (GWF_PHONE_QC_REQ in ('Y','N'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_gwf_upd_state
check (GWF_UPDATE_STATE in ('Y','N'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_gwf_manual_let
check (GWF_MANUAL_LETTER in ('Y','N'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_gwf_send_research
check (GWF_SEND_RESEARCH in ('Y','N'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_gwf_
check (GWF_QC_REQUIRED in ('Y','N'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_gwf_qc_outc
check (GWF_QC_Outcome in ('Y','R'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_gwf_mi_outc
check (GWF_MI_Outcome in ('S','M','A'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_asf_receive_Mi
check (ASF_RECEIVE_MI in ('Y','N'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_asf_crt_state_accept
check (ASF_CREATE_STATE_ACCEPT in ('Y','N'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_asf_det_mi_outcome
check (ASF_DETERMINE_MI_OUTCOME in ('Y','N'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_asf_compl_mi_task
check (ASF_COMPLETE_MI_TASK in ('Y','N'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_asf_perf_QC
check (ASF_PERFORM_QC in ('Y','N'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_asf_perf_Research
check (ASF_PERFORM_RESEARCH in ('Y','N'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_asf_send_mi_let
 check (ASF_SEND_MI_LETTER in ('Y','N'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_jeopardy_flag
check (JEOPARDY_FLAG in ('Y','N'));

alter table NYEC_ETL_Process_MI
 add constraint c1_pro_mi_mi_type 
 check (MI_TYPE in ('Data','Document','Both',null));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_mi_channel
 check (MI_CHANNEL in ('Phone','Mail','Fax','Online','Interface',null));

alter table Process_MI_STG
add constraint c1_pro_mi_task_type
 check (MI_TASK_TYPE in ('State Data Entry Task - MI','State Review Task - MI Reprocess Result'));
 
alter table  NYEC_ETL_Process_MI
add constraint c1_pro_mi_task_ID_UK
  unique ( MI_TASK_ID);