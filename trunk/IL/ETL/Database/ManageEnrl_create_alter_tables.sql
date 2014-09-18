/*
Created on 8-Jul-2013 by Raj A.
Team: MAXDAT.
Business Process: Manage Enrollment Activity.

v1 Raj A. 8-Jul-2013 Initial creation.
v2 Raj A. 12-Jul-2013 Incorrect tables created. should be client_enroll_status_stg , not client_enroll_status. 
		      should be selection_txn_stg , not selection_txn.
*/

alter table corp_etl_manage_enroll
drop (
AGE_IN_BUSINESS_DAYS,
AGE_IN_CALENDAR_DAYS
);


create table Rule_lkup_mng_enrl_sla
(
mes_id         number(18),
sla_days_type  varchar2(1),
sla_days       number(18),
sla_type       varchar2(50),	
newborn_flag   varchar2(1),
created_ts     date,
updated_ts     date
);

    
alter table Rule_lkup_mng_enrl_sla
add constraint Mng_Enrl_sla_UNQ unique (sla_days_type, sla_type, newborn_flag);

create table CLIENT_ENROLL_STATUS_STG
(
  CLIENT_ENROLL_STATUS_ID NUMBER(18) not null,
  PLAN_TYPE_CD            VARCHAR2(32),
  ENROLL_STATUS_CD        VARCHAR2(32),
  START_DATE              DATE,
  END_DATE                DATE,
  CREATE_TS               DATE,
  CREATED_BY              VARCHAR2(80),
  UPDATE_TS               DATE,
  UPDATED_BY              VARCHAR2(80),
  CLIENT_ID               NUMBER(18),
  PROGRAM_CD              VARCHAR2(32) not null,
  START_NDT               NUMBER(18) not null,
  END_NDT                 NUMBER(18) not null,
  DISPOSITION_CD          VARCHAR2(32)
);

create table SELECTION_TXN_STG
(
  SELECTION_TXN_ID              NUMBER(18) not null,
  SELECTION_TXN_GROUP_ID        NUMBER(18),
  PROGRAM_TYPE_CD               VARCHAR2(32),
  TRANSACTION_TYPE_CD           VARCHAR2(32),
  SELECTION_SOURCE_CD           VARCHAR2(32),
  REF_SOURCE_ID                 NUMBER(18),
  REF_SOURCE_TYPE               VARCHAR2(32),
  REF_EXT_TXN_ID                VARCHAR2(80),
  PLAN_TYPE_CD                  VARCHAR2(32),
  PLAN_ID                       NUMBER(18),
  PLAN_ID_EXT                   VARCHAR2(30),
  CONTRACT_ID                   NUMBER(18),
  NETWORK_ID                    NUMBER(18),
  PROVIDER_ID                   NUMBER(18),
  PROVIDER_ID_EXT               VARCHAR2(64),
  PROVIDER_FIRST_NAME           VARCHAR2(64),
  PROVIDER_MIDDLE_NAME          VARCHAR2(25),
  PROVIDER_LAST_NAME            VARCHAR2(64),
  START_DATE                    DATE,
  END_DATE                      DATE,
  CHOICE_REASON_CD              VARCHAR2(32),
  DISENROLL_REASON_CD_1         VARCHAR2(32),
  DISENROLL_REASON_CD_2         VARCHAR2(32),
  OVERRIDE_REASON_CD            VARCHAR2(32),
  FOLLOWUP_REASON_CD            VARCHAR2(32),
  FOLLOWUP_CALL_DATE            DATE,
  FOLLOWUP_FORM_RCV_DATE        DATE,
  FOLLOWUP_BY                   VARCHAR2(80),
  MISSING_INFO_ID               NUMBER(18),
  MISSING_SIGNATURE_IND         NUMBER(1),
  OUTREACH_SESSION_ID           NUMBER(18),
  BENEFITS_PACKAGE_CD           VARCHAR2(32),
  SELECTION_SEGMENT_ID          NUMBER(18),
  CLIENT_ID                     NUMBER(18),
  STATUS_CD                     VARCHAR2(32),
  STATUS_DATE                   DATE,
  CLIENT_AID_CATEGORY_CD        VARCHAR2(32),
  COUNTY                        VARCHAR2(32),
  ZIPCODE                       VARCHAR2(32),
  CLIENT_RESIDENCE_ADDRESS_ID   NUMBER(18),
  PRIOR_SELECTION_SEGMENT_ID    NUMBER(18),
  PRIOR_SELECTION_START_DATE    DATE,
  PRIOR_SELECTION_END_DATE      DATE,
  PRIOR_PLAN_ID                 NUMBER(18),
  PRIOR_PLAN_ID_EXT             VARCHAR2(32),
  PRIOR_PROVIDER_ID             NUMBER(18),
  PRIOR_PROVIDER_ID_EXT         VARCHAR2(32),
  PRIOR_PROVIDER_FIRST_NAME     VARCHAR2(25),
  PRIOR_PROVIDER_MIDDLE_NAME    VARCHAR2(25),
  PRIOR_PROVIDER_LAST_NAME      VARCHAR2(35),
  REF_SELECTION_TXN_ID          NUMBER(18),
  SURPLUS_INFO                  NUMBER(10,2),
  CREATED_BY                    VARCHAR2(80),
  CREATE_TS                     DATE,
  UPDATED_BY                    VARCHAR2(80),
  UPDATE_TS                     DATE,
  PRIOR_CONTRACT_ID             NUMBER(18),
  PRIOR_NETWORK_ID              NUMBER(18),
  START_ND                      NUMBER(8) not null,
  END_ND                        NUMBER(8) not null,
  PRIOR_CHOICE_REASON_CD        VARCHAR2(32),
  PRIOR_DISENROLL_REASON_CD_1   VARCHAR2(32),
  PRIOR_DISENROLL_REASON_CD_2   VARCHAR2(32),
  PRIOR_CLIENT_AID_CATEGORY_CD  VARCHAR2(32),
  PRIOR_COUNTY_CD               VARCHAR2(32),
  PRIOR_ZIPCODE                 VARCHAR2(32),
  ORIGINAL_START_DATE           DATE,
  ORIGINAL_END_DATE             DATE,
  SELECTION_GENERIC_FIELD1_DATE DATE,
  SELECTION_GENERIC_FIELD2_DATE DATE,
  SELECTION_GENERIC_FIELD3_NUM  NUMBER(18),
  SELECTION_GENERIC_FIELD4_NUM  NUMBER(18),
  SELECTION_GENERIC_FIELD5_TXT  VARCHAR2(256),
  SELECTION_GENERIC_FIELD6_TXT  VARCHAR2(256),
  SELECTION_GENERIC_FIELD7_TXT  VARCHAR2(256),
  SELECTION_GENERIC_FIELD8_TXT  VARCHAR2(256),
  SELECTION_GENERIC_FIELD9_TXT  VARCHAR2(256),
  SELECTION_GENERIC_FIELD10_TXT VARCHAR2(256)
);

create table ENUM_ENROLL_TRANS_SOURCE_STG
(
  VALUE                VARCHAR2(32) not null,
  DESCRIPTION          VARCHAR2(256),
  REPORT_LABEL         VARCHAR2(64),
  SCOPE                VARCHAR2(128),
  CREATED_BY           VARCHAR2(80),
  CREATE_TS            DATE,
  UPDATED_BY           VARCHAR2(80),
  UPDATE_TS            DATE,
  ORDER_BY_DEFAULT     NUMBER(10),
  EFFECTIVE_END_DATE   DATE,
  EFFECTIVE_START_DATE DATE,
  DEFAULT_PROPERTY     VARCHAR2(128),
  PERMISSION           VARCHAR2(1000),
  IS_CHOICE_IND        NUMBER(1)
); 

drop table CLIENT_ENROLL_STATUS;
drop table SELECTION_TXN;