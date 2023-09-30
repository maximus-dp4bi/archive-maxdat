/*
Created on 05-Dec-2012 by Raj A.
*/
--------------------------------------------------------------------------
--Create table and constraints for STATE_REVIEW_STG table.
--------------------------------------------------------------------------
create table STATE_REVIEW_STG
(
  NESR_ID                   NUMBER not null,
  ITM_INSERT                VARCHAR2(1),
  ITM_INSERT_TS             DATE,
  ITM_UPDATE                VARCHAR2(1),
  ITM_UPDATE_TS             DATE,
  APP_ID                    NUMBER,
  STAGE_DONE_DATE           DATE,
  STG_EXTRACT_DATE          DATE,
  STG_LAST_UPDATE_DATE      DATE,
  INSTANCE_COMPLETE_DT      DATE,
  INSTANCE_STATUS           VARCHAR2(50),
  GWF_TASK_WORKED_BY        VARCHAR2(1),
  GWF_STATE_RESULT          VARCHAR2(1),
  GWF_RESEARCH              VARCHAR2(1),
  GWF_MI_REQUIRED           VARCHAR2(1),
  ASF_RECEIVE_STATE_REVIEW  VARCHAR2(1)  default 'N',
  ASF_PROCESS_DC            VARCHAR2(1)  default 'N',
  ASF_RESEARCH              VARCHAR2(1)  default 'N',
  ASF_REQUEST_MI_NOTICE     VARCHAR2(1)  default 'N',
  AGE_IN_BUSINESS_DAYS      NUMBER,
  AGE_IN_CALENDAR_DAYS      NUMBER,
  ALL_MI_SATISFIED          VARCHAR2(1),
  AUTO_CLOSE_FLAG           VARCHAR2(1),
  CALL_CAMPAIGN_ID          NUMBER,
  CALL_CAMPAIGN_FLAG        VARCHAR2(1),
  CANCEL_DT                 DATE,
  CURRENT_TASK_ID           NUMBER,
  LETTER_REQ_ID             NUMBER,
  LETTER_STATUS             VARCHAR2(20),
  NEW_MI_FLAG               VARCHAR2(1),
  NEW_STATE_REVIEW_TASK_ID  NUMBER,
  RFE_STATUS_FLAG           VARCHAR2(1),
  STATE_ACCEPT_IND          VARCHAR2(1),
  STATE_REVIEW_OUTCOME      VARCHAR2(20),
  STATE_REVIEW_TASK_ID      NUMBER,
  ASED_RECEIVE_STATE_REVIEW DATE,
  ASPB_RECEIVE_STATE_REVIEW VARCHAR2(100),
  ASSD_RECEIVE_STATE_REVIEW DATE,
  ASED_PROCESS_DC           DATE,
  ASPB_PROCESS_DC           VARCHAR2(100),
  ASSD_PROCESS_DC           DATE,
  ASED_RESEARCH             DATE,
  ASPB_RESEARCH             VARCHAR2(100),
  ASSD_RESEARCH             DATE,
  ASED_REQUEST_MI_NOTICE    DATE,
  ASSD_REQUEST_MI_NOTICE    DATE,
  CURRENT_TASK_TYPE         VARCHAR2(15),
  LETTER_STATUS_DATE        DATE,
  RFE_STATUS                VARCHAR2(32),
  FPBP_FLAG                 VARCHAR2(1),
  STEP_INSTANCE_HISTORY_ID  NUMBER,
  DATA_CORRECTION_TASK_ID   NUMBER,
  RESEARCH_TASK_ID          NUMBER,
  NEW_MI_CREATION_DATE      DATE,
  AUTO_REJECT_FLAG          VARCHAR2(1),
  STRW_TASK_CLAIMED_DATE    DATE,
  HEART_APP_STATUS          VARCHAR2(50),
  APP_STATUS_GROUP          VARCHAR2(30),
  NEW_MI_SATISFIED          VARCHAR2(1),
  GWF_NEW_MI_SATISFIED      VARCHAR2(1),
  LETTER_SENT_FLAG          VARCHAR2(1),
  process_STRW_Start_time   DATE
);

-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.STATE_REVIEW_STG
  add primary key (NESR_ID);

alter table MAXDAT.STATE_REVIEW_STG
  add unique (APP_ID, STATE_REVIEW_TASK_ID);

-- Create/Recreate check constraints 
alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C01
  check (GWF_TASK_WORKED_BY IN ('C','R','W'));

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C02
  check (GWF_STATE_RESULT IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C03
  check (GWF_RESEARCH IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C04
  check (GWF_MI_Required IN ( 'S', 'M', 'A'));

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C05
  check (ASF_RECEIVE_STATE_REVIEW IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C06
  check (ASF_PROCESS_DC IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C07
  check (ASF_RESEARCH IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C08
  check (ASF_REQUEST_MI_NOTICE IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C09
  check (ALL_MI_SATISFIED IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C10
  check (AUTO_CLOSE_FLAG IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C11
  check (CALL_CAMPAIGN_FLAG IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C12
  check (INSTANCE_STATUS IN ('ACTIVE','COMPLETE'));

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C13
  check (NEW_MI_FLAG IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C14
  check (RFE_STATUS_FLAG IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C15
  check (STATE_ACCEPT_IND IN ('Y','N'));

alter table state_review_stg
  add constraint state_review_stg_C16
  check (STATE_REVIEW_OUTCOME IN ('ACCEPTED','REJECTED','BOTH','AUTO-REJECTED','CANCELLED','AUTO-CLOSED'));  

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C17
  check (CURRENT_TASK_TYPE IN ('State Review', 'Data Correction', 'Research'));

alter table MAXDAT.STATE_REVIEW_STG
  add constraint STATE_REVIEW_STG_C19
  check (RFE_STATUS IN (
'AWAITING_MI',
'ACCEPTED',
'REJECTED',
'DISREGARDED',
'RENEWAL_INITIATED',
'AWAITING_STATE_ACCEPTANCE',
'AWAITING_DATA_CORRECTION',
'AWAITING_MAX-QC_VALIDATION',
'WITHDRAWN',
'AWAITING_RESEARCH',
'AWAITING_STATE_DATA_ENTRY',
'TIMEOUT',
'RESTARTED'
));

--------------------------------------------------------------------------
--Create table and constraints for STATE_REVIEW_STG_TMP table.
--------------------------------------------------------------------------
-- Create table
create table MAXDAT.STATE_REVIEW_STG_TMP
(
  NESR_ID                   NUMBER not null,
  ITM_INSERT                VARCHAR2(1),
  ITM_INSERT_TS             DATE,
  ITM_UPDATE                VARCHAR2(1),
  ITM_UPDATE_TS             DATE,
  APP_ID                    NUMBER,
  STAGE_DONE_DATE           DATE,
  STG_EXTRACT_DATE          DATE,
  STG_LAST_UPDATE_DATE      DATE,
  INSTANCE_COMPLETE_DT      DATE,
  INSTANCE_STATUS           VARCHAR2(50),
  GWF_TASK_WORKED_BY        VARCHAR2(1),
  GWF_STATE_RESULT          VARCHAR2(1),
  GWF_RESEARCH              VARCHAR2(1),
  GWF_MI_REQUIRED           VARCHAR2(1),
  ASF_RECEIVE_STATE_REVIEW  VARCHAR2(1) default 'N',
  ASF_PROCESS_DC            VARCHAR2(1) default 'N',
  ASF_RESEARCH              VARCHAR2(1) default 'N',
  ASF_REQUEST_MI_NOTICE     VARCHAR2(1) default 'N',
  AGE_IN_BUSINESS_DAYS      NUMBER,
  AGE_IN_CALENDAR_DAYS      NUMBER,
  ALL_MI_SATISFIED          VARCHAR2(1),
  AUTO_CLOSE_FLAG           VARCHAR2(1) default 'N',
  CALL_CAMPAIGN_ID          NUMBER,
  CALL_CAMPAIGN_FLAG        VARCHAR2(1) default 'N',
  CANCEL_DT                 DATE,
  CURRENT_TASK_ID           NUMBER,
  LETTER_REQ_ID             NUMBER,
  LETTER_STATUS             VARCHAR2(20),
  NEW_MI_FLAG               VARCHAR2(1),
  NEW_STATE_REVIEW_TASK_ID  NUMBER,
  RFE_STATUS_FLAG           VARCHAR2(1),
  STATE_ACCEPT_IND          VARCHAR2(1),
  STATE_REVIEW_OUTCOME      VARCHAR2(20),
  STATE_REVIEW_TASK_ID      NUMBER,
  ASED_RECEIVE_STATE_REVIEW DATE,
  ASPB_RECEIVE_STATE_REVIEW VARCHAR2(100),
  ASSD_RECEIVE_STATE_REVIEW DATE,
  ASED_PROCESS_DC           DATE,
  ASPB_PROCESS_DC           VARCHAR2(100),
  ASSD_PROCESS_DC           DATE,
  ASED_RESEARCH             DATE,
  ASPB_RESEARCH             VARCHAR2(100),
  ASSD_RESEARCH             DATE,
  ASED_REQUEST_MI_NOTICE    DATE,
  ASSD_REQUEST_MI_NOTICE    DATE,
  CURRENT_TASK_TYPE         VARCHAR2(15),
  LETTER_STATUS_DATE        DATE,
  RFE_STATUS                VARCHAR2(20),
  FPBP_FLAG                 VARCHAR2(1),
  STEP_INSTANCE_HISTORY_ID  NUMBER,
  DATA_CORRECTION_TASK_ID   NUMBER,
  RESEARCH_TASK_ID          NUMBER,
  NEW_MI_CREATION_DATE      DATE,
  AUTO_REJECT_FLAG          VARCHAR2(1) default 'N',
  HEART_APP_STATUS          VARCHAR2(50),
  APP_STATUS_GROUP          VARCHAR2(30),
  STRW_TASK_CLAIMED_DATE    DATE,
  NEW_MI_SATISFIED          VARCHAR2(1),
  GWF_NEW_MI_SATISFIED      VARCHAR2(1),
  LETTER_SENT_FLAG          VARCHAR2(1)
);

-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.STATE_REVIEW_STG_TMP
  add primary key (NESR_ID);

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add unique (APP_ID, STATE_REVIEW_TASK_ID);

-- Create/Recreate check constraints 
alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C01
  check (GWF_TASK_WORKED_BY IN ('C','R','W'));

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C02
  check (GWF_STATE_RESULT IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C03
  check (GWF_RESEARCH IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C04
  check (GWF_MI_Required IN ( 'S', 'M', 'A'));

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C05
  check (ASF_RECEIVE_STATE_REVIEW IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C06
  check (ASF_PROCESS_DC IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C07
  check (ASF_RESEARCH IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C08
  check (ASF_REQUEST_MI_NOTICE IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C09
  check (ALL_MI_SATISFIED IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C10
  check (AUTO_CLOSE_FLAG IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C11
  check (CALL_CAMPAIGN_FLAG IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C12
  check (INSTANCE_STATUS IN ('ACTIVE','COMPLETE'));

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C13
  check (NEW_MI_FLAG IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C14
  check (RFE_STATUS_FLAG IN ('Y','N'));

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C15
  check (STATE_ACCEPT_IND IN ('Y','N'));

alter table state_review_stg_tmp
  add constraint state_review_stg_tmp_C16
  check (STATE_REVIEW_OUTCOME IN ('ACCEPTED','REJECTED','BOTH','AUTO-REJECTED','CANCELLED','AUTO-CLOSED'));  

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C17
  check (CURRENT_TASK_TYPE IN ('State Review', 'Data Correction', 'Research'));

alter table MAXDAT.STATE_REVIEW_STG_TMP
  add constraint STATE_REVIEW_STG_TMP_C19
  check (RFE_STATUS IN (
'AWAITING_MI',
'ACCEPTED',
'REJECTED',
'DISREGARDED',
'RENEWAL_INITIATED',
'AWAITING_STATE_ACCEPTANCE',
'AWAITING_DATA_CORRECTION',
'AWAITING_MAX-QC_VALIDATION',
'WITHDRAWN',
'AWAITING_RESEARCH',
'AWAITING_STATE_DATA_ENTRY',
'TIMEOUT',
'RESTARTED'
));

--------------------------------------------------------------------------
--Create table and constraints for NYEC_ETL_STATE_REVIEW table.
--------------------------------------------------------------------------
-- Create table
create table MAXDAT.NYEC_ETL_STATE_REVIEW
(
  NESR_ID                   NUMBER not null,
  APP_ID                    NUMBER,
  STAGE_DONE_DATE           DATE,
  STG_EXTRACT_DATE          DATE default SYSDATE not null,
  STG_LAST_UPDATE_DATE      DATE default SYSDATE not null,
  INSTANCE_COMPLETE_DT      DATE,
  INSTANCE_STATUS           VARCHAR2(50) default 'ACTIVE',
  GWF_TASK_WORKED_BY        VARCHAR2(1),
  GWF_STATE_RESULT          VARCHAR2(1),
  GWF_RESEARCH              VARCHAR2(1),
  GWF_MI_REQUIRED           VARCHAR2(1),
  ASF_RECEIVE_STATE_REVIEW  VARCHAR2(1) default 'N',
  ASF_PROCESS_DC            VARCHAR2(1) default 'N',
  ASF_RESEARCH              VARCHAR2(1) default 'N',
  ASF_REQUEST_MI_NOTICE     VARCHAR2(1) default 'N',
  AGE_IN_BUSINESS_DAYS      NUMBER default 0 not null,
  AGE_IN_CALENDAR_DAYS      NUMBER default 0 not null,
  ALL_MI_SATISFIED          VARCHAR2(1) default 'N' not null,
  AUTO_CLOSE_FLAG           VARCHAR2(1) default 'N' not null,
  CALL_CAMPAIGN_ID          NUMBER,
  CALL_CAMPAIGN_FLAG        VARCHAR2(1) default 'N' not null,
  CANCEL_DT                 DATE,
  CURRENT_TASK_ID           NUMBER,
  LETTER_REQ_ID             NUMBER,
  LETTER_STATUS             VARCHAR2(20),
  NEW_MI_FLAG               VARCHAR2(1),
  NEW_STATE_REVIEW_TASK_ID  NUMBER,
  RFE_STATUS_FLAG           VARCHAR2(1) default 'N' not null,
  STATE_ACCEPT_IND          VARCHAR2(1) default 'N' not null,
  STATE_REVIEW_OUTCOME      VARCHAR2(20),
  STATE_REVIEW_TASK_ID      NUMBER not null,
  ASED_RECEIVE_STATE_REVIEW DATE,
  ASPB_RECEIVE_STATE_REVIEW VARCHAR2(100),
  ASSD_RECEIVE_STATE_REVIEW DATE,
  ASED_PROCESS_DC           DATE,
  ASPB_PROCESS_DC           VARCHAR2(100),
  ASSD_PROCESS_DC           DATE,
  ASED_RESEARCH             DATE,
  ASPB_RESEARCH             VARCHAR2(100),
  ASSD_RESEARCH             DATE,
  ASED_REQUEST_MI_NOTICE    DATE,
  ASSD_REQUEST_MI_NOTICE    DATE,
  CURRENT_TASK_TYPE         VARCHAR2(15),
  LETTER_STATUS_DATE        DATE,
  RFE_STATUS                VARCHAR2(20),
  FPBP_FLAG                 VARCHAR2(1),
  STEP_INSTANCE_HISTORY_ID  NUMBER,
  DATA_CORRECTION_TASK_ID   NUMBER,
  RESEARCH_TASK_ID          NUMBER,
  NEW_MI_CREATION_DATE      DATE,
  AUTO_REJECT_FLAG          VARCHAR2(1),
  STRW_TASK_CLAIMED_DATE    DATE,
  HEART_APP_STATUS          VARCHAR2(50),
  APP_STATUS_GROUP          VARCHAR2(30),  
  NEW_MI_SATISFIED          VARCHAR2(1),
  GWF_NEW_MI_SATISFIED      VARCHAR2(1),
  LETTER_SENT_FLAG          VARCHAR2(1)  
);

-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add primary key (NESR_ID);

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add unique (APP_ID, STATE_REVIEW_TASK_ID);

-- Create/Recreate check constraints 
alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C01
  check (GWF_TASK_WORKED_BY IN ('C','R','W'));

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C02
  check (GWF_STATE_RESULT IN ('Y','N'));

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C03
  check (GWF_RESEARCH IN ('Y','N'));

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C04
  check (GWF_MI_Required IN ( 'S', 'M', 'A'));

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C05
  check (ASF_RECEIVE_STATE_REVIEW IN ('Y','N'));

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C06
  check (ASF_PROCESS_DC IN ('Y','N'));

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C07
  check (ASF_RESEARCH IN ('Y','N'));

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C08
  check (ASF_REQUEST_MI_NOTICE IN ('Y','N'));

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C09
  check (ALL_MI_SATISFIED IN ('Y','N'));

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C10
  check (AUTO_CLOSE_FLAG IN ('Y','N'));

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C11
  check (CALL_CAMPAIGN_FLAG IN ('Y','N'));

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C12
  check (INSTANCE_STATUS IN ('ACTIVE','COMPLETE'));

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C13
  check (NEW_MI_FLAG IN ('Y','N'));

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C14
  check (RFE_STATUS_FLAG IN ('Y','N'));

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C15
  check (STATE_ACCEPT_IND IN ('Y','N'));

alter table nyec_etl_state_review
  add constraint nyec_etl_state_review_C16
  check (STATE_REVIEW_OUTCOME IN ('ACCEPTED','REJECTED','BOTH','AUTO-REJECTED','CANCELLED','AUTO-CLOSED'));

alter table MAXDAT.NYEC_ETL_STATE_REVIEW
  add constraint NYEC_ETL_STATE_REVIEW_C19
  check (RFE_STATUS IN (
'AWAITING_MI',
'ACCEPTED',
'REJECTED',
'DISREGARDED',
'RENEWAL_INITIATED',
'AWAITING_STATE_ACCEPTANCE',
'AWAITING_DATA_CORRECTION',
'AWAITING_MAX-QC_VALIDATION',
'WITHDRAWN',
'AWAITING_RESEARCH',
'AWAITING_STATE_DATA_ENTRY',
'TIMEOUT',
'RESTARTED'
));