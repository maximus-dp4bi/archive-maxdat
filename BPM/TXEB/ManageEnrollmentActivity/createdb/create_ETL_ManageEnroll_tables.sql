/*
Created on 19-Aug-2013 by Raj A.
Team: MAXDAT.
Business Process: Manage Enrollment Activity.

Description:
Three stage tables are created for this process.
1.corp_etl_Manage_enroll
2.corp_etl_Manage_enroll_oltp
3.corp_etl_Manage_enroll_wip

Five stage tables to capture the OLTP Source data. These are oltp table copies.
1.CLIENT_ENROLL_STATUS_STG
2.SELECTION_TXN_STG
3.ENUM_ENROLL_TRANS_SOURCE_STG
4.CLIENT_ELIG_STATUS_STG
5.COST_SHARE_DETAILS_STG
*/

create table corp_etl_Manage_enroll
(
CEME_ID                 number(18), --PK.
client_enroll_status_id number(18),  --unique instance.
client_id               NUMBER(18),
create_dt              date,
case_id                number(18),
client_cin             VARCHAR2(32),
newborn_flg            VARCHAR2(1) default 'N',
service_area           VARCHAR2(32),
county_code            VARCHAR2(32),
zip_code               VARCHAR2(32),
enrollment_status_code VARCHAR2(32),
enrollment_status_dt   date,
aa_due_dt              date,
enrl_pack_id           number(18),
enrl_pack_request_dt   date,
enroll_fee_amnt_due    number default 0, 
enroll_fee_amnt_paid   number default 0,
enroll_fee_paid_dt     DATE,
fee_paid_flg           VARCHAR2(1),
chip_hpc_id            number(18),
chip_hpc_mailed_dt     date,
chip_emi_id            number(18),
chip_emi_mailed_dt     date,
plan_type              VARCHAR2(32),
program_type           varchar2(32),
subprogram_type        varchar2(32),
slct_auto_proc      varchar2(1),
slct_method         VARCHAR2(32),   
slct_create_by_name VARCHAR2(80),
slct_create_dt date,
slct_last_update_by_name VARCHAR2(80),
slct_last_update_dt  date,
--
assd_selection_recd date,
ased_selection_recd date,
assd_send_enroll_packet date,
ased_send_enroll_packet date,
first_followup_id        varchar2(37),
first_followup_type_code varchar2(40),
assd_first_followup date,
ased_first_followup date,
second_followup_id varchar2(37),
second_followup_type_code varchar2(40),
assd_second_followup date,
ased_second_followup date,
third_followup_id varchar2(37), 
third_followup_type_code varchar2(40),
assd_third_followup date,
ased_third_followup date,
fourth_followup_id varchar2(37),
fourth_followup_type_code varchar2(40),
assd_fourth_followup date,
ased_fourth_followup date,
assd_auto_assign date,
ased_auto_assign date,
assd_wait_for_fee date,
ased_wait_for_fee date,
--
asf_cancel_enrl_activity varchar2(1) default 'N',
asf_send_enroll_packet  VARCHAR2(1)  default 'N',
asf_selection_recd      VARCHAR2(1)  default 'N',
asf_first_followup      VARCHAR2(1)  default 'N',
asf_second_followup     VARCHAR2(1)  default 'N',
asf_third_followup      VARCHAR2(1)  default 'N',
asf_fourth_followup     VARCHAR2(1)  default 'N',
asf_auto_assign         VARCHAR2(1)  default 'N',
asf_wait_for_fee        VARCHAR2(1)  default 'N',
--
gwf_enrl_pack_req       VARCHAR2(1),
gwf_first_followup_req  VARCHAR2(1),
gwf_second_followup_req VARCHAR2(1),
gwf_third_followup_req  VARCHAR2(1),
gwf_fourth_followup_req VARCHAR2(1),
gwf_required_fee_paid   VARCHAR2(1),
--
generic_field_1 varchar2(50),
generic_field_2 varchar2(50),
generic_field_3 varchar2(50),
generic_field_4 varchar2(50),
generic_field_5 varchar2(50),
--
instance_status        VARCHAR2(10) default 'Active' not null, 
complete_dt            date,
cancel_dt              date,
cancel_reason          varchar2(100),
cancel_method          varchar2(20),
cancel_by              varchar2(80),
STG_EXTRACT_DATE       date not null,
STG_LAST_UPDATE_DATE   date  not null,
STAGE_DONE_DATE        date
) tablespace MAXDAT_DATA;

alter table corp_etl_Manage_enroll
  add constraint Manage_enrl_PK primary key (CEME_ID) using index tablespace MAXDAT_INDX;

alter table corp_etl_Manage_enroll
  add constraint Manage_enrl_UNQ unique (client_enroll_status_id) using index tablespace MAXDAT_INDX;  

alter table corp_etl_Manage_enroll
  add constraint corp_etl_Manage_enroll_C1
  check (asf_send_enroll_packet IN ('Y','N'));

alter table corp_etl_Manage_enroll
  add constraint corp_etl_Manage_enroll_C2
  check (asf_selection_recd IN ('Y','N'));
  
alter table corp_etl_Manage_enroll
  add constraint corp_etl_Manage_enroll_C3
  check (asf_first_followup IN ('Y','N'));
  
alter table corp_etl_Manage_enroll
  add constraint corp_etl_Manage_enroll_C4
  check (asf_second_followup IN ('Y','N'));
  
alter table corp_etl_Manage_enroll
  add constraint corp_etl_Manage_enroll_C5
  check (asf_third_followup IN ('Y','N'));
  
alter table corp_etl_Manage_enroll
  add constraint corp_etl_Manage_enroll_C6
  check (asf_fourth_followup IN ('Y','N'));
  
alter table corp_etl_Manage_enroll
  add constraint corp_etl_Manage_enroll_C7
  check (asf_auto_assign IN ('Y','N'));
  
alter table corp_etl_Manage_enroll
  add constraint corp_etl_Manage_enroll_C8
  check (asf_wait_for_fee IN ('Y','N'));
  
alter table corp_etl_Manage_enroll
  add constraint corp_etl_Manage_enroll_C9
  check (gwf_enrl_pack_req IN ('Y','N'));
  
alter table corp_etl_Manage_enroll
  add constraint corp_etl_Manage_enroll_C10
  check (gwf_first_followup_req IN ('Y','N'));
  
alter table corp_etl_Manage_enroll
  add constraint corp_etl_Manage_enroll_C11
  check (gwf_second_followup_req IN ('Y','N'));  

alter table corp_etl_Manage_enroll
  add constraint corp_etl_Manage_enroll_C12
  check (gwf_third_followup_req IN ('Y','N'));

alter table corp_etl_Manage_enroll
  add constraint corp_etl_Manage_enroll_C13
  check (gwf_fourth_followup_req IN ('Y','N'));
  
alter table corp_etl_Manage_enroll
  add constraint corp_etl_Manage_enroll_C14
  check (gwf_required_fee_paid IN ('Y','N'));

alter table corp_etl_Manage_enroll
  add constraint corp_etl_Manage_enroll_C15
  check (instance_status IN ('Active','Complete'));

create or replace public synonym corp_etl_Manage_enroll for corp_etl_Manage_enroll;
grant select on corp_etl_Manage_enroll to MAXDAT_READ_ONLY;


---------------------------------------------------------------------------------------
create table corp_etl_Manage_enroll_oltp
(
CEME_ID                 number(18), --PK.
client_enroll_status_id number(18),  --unique instance.
client_id               NUMBER(18),
create_dt              date,
case_id                number(18),
client_cin             VARCHAR2(32),
newborn_flg            VARCHAR2(1) default 'N',
service_area           VARCHAR2(32),
county_code            VARCHAR2(32),
zip_code               VARCHAR2(32),
enrollment_status_code VARCHAR2(32),
enrollment_status_dt   date,
aa_due_dt              date,
enrl_pack_id           number(18),
enrl_pack_request_dt   date,
enroll_fee_amnt_due    number default 0,
enroll_fee_amnt_paid   number default 0,
enroll_fee_paid_dt     date,
fee_paid_flg           VARCHAR2(1),
chip_hpc_id            number(18),
chip_hpc_mailed_dt     date,
chip_emi_id            number(18),
chip_emi_mailed_dt     date,
plan_type              VARCHAR2(32),
program_type           varchar2(32),
subprogram_type        varchar2(32),
slct_auto_proc      varchar2(1),
slct_method            VARCHAR2(32),   
slct_create_by_name    VARCHAR2(80),
slct_create_dt         date,
slct_last_update_by_name VARCHAR2(80),
slct_last_update_dt      date,
--
assd_selection_recd date,
ased_selection_recd date,
assd_send_enroll_packet date,
ased_send_enroll_packet date,
first_followup_id    varchar2(37),
first_followup_type_code varchar2(40),
assd_first_followup date,
ased_first_followup date,
second_followup_id varchar2(37),
second_followup_type_code varchar2(40),
assd_second_followup date,
ased_second_followup date,
third_followup_id varchar2(37),
third_followup_type_code varchar2(40),
assd_third_followup date,
ased_third_followup date,
fourth_followup_id varchar2(37),
fourth_followup_type_code varchar2(40),
assd_fourth_followup date,
ased_fourth_followup date,
assd_auto_assign date,
ased_auto_assign date,
assd_wait_for_fee date,
ased_wait_for_fee date,
--
asf_cancel_enrl_activity varchar2(1) default 'N',
asf_send_enroll_packet  VARCHAR2(1)  default 'N',
asf_selection_recd      VARCHAR2(1)  default 'N',
asf_first_followup      VARCHAR2(1)  default 'N',
asf_second_followup     VARCHAR2(1)  default 'N',
asf_third_followup      VARCHAR2(1)  default 'N',
asf_fourth_followup     VARCHAR2(1)  default 'N',
asf_auto_assign         VARCHAR2(1)  default 'N',
asf_wait_for_fee        VARCHAR2(1)  default 'N',
--
gwf_enrl_pack_req       VARCHAR2(1),
gwf_first_followup_req  VARCHAR2(1),
gwf_second_followup_req VARCHAR2(1),
gwf_third_followup_req  VARCHAR2(1),
gwf_fourth_followup_req VARCHAR2(1),
gwf_required_fee_paid   VARCHAR2(1),
--
generic_field_1 varchar2(50),
generic_field_2 varchar2(50),
generic_field_3 varchar2(50),
generic_field_4 varchar2(50),
generic_field_5 varchar2(50),
--
instance_status        VARCHAR2(10) default 'Active'  not null,
complete_dt            date,
cancel_dt              date,
cancel_reason          varchar2(100),
cancel_method          varchar2(20),
cancel_by              varchar2(80),
STG_EXTRACT_DATE       date  not null,
STG_LAST_UPDATE_DATE   date  not null,
STAGE_DONE_DATE        date,
age_in_calendar_days   number(18),
age_in_business_days   number(18)
) tablespace MAXDAT_DATA;

create or replace public synonym corp_etl_Manage_enroll_oltp for corp_etl_Manage_enroll_oltp;
grant select on corp_etl_Manage_enroll_oltp to MAXDAT_READ_ONLY;


--------------------------------------------------------------------------------------------
create table corp_etl_Manage_enroll_wip
(
CEME_ID                 number(18), --PK.
client_enroll_status_id number(18),  --unique instance.
client_id               NUMBER(18),
--job_id NUMBER(18),
create_dt              date,
case_id                number(18),
client_cin             VARCHAR2(32),
newborn_flg            VARCHAR2(1) default 'N',
service_area           VARCHAR2(32),
county_code            VARCHAR2(32),
zip_code               VARCHAR2(32),
enrollment_status_code VARCHAR2(32),
enrollment_status_dt   date,
aa_due_dt              date,
enrl_pack_id           number(18),
enrl_pack_request_dt   date,
enroll_fee_amnt_due    number default 0,
enroll_fee_amnt_paid   number default 0,
enroll_fee_paid_dt     date,
fee_paid_flg           VARCHAR2(1),
chip_hpc_id            number(18),
chip_hpc_mailed_dt     date,
chip_emi_id            number(18),
chip_emi_mailed_dt     date,
plan_type              VARCHAR2(32),
program_type           varchar2(32),
subprogram_type        varchar2(32),
slct_auto_proc      varchar2(1),
slct_method         VARCHAR2(32),   
slct_create_by_name VARCHAR2(80),
slct_create_dt date,
slct_last_update_by_name VARCHAR2(80),
slct_last_update_dt  date,
--
assd_selection_recd date,
ased_selection_recd date,
assd_send_enroll_packet date,
ased_send_enroll_packet date,
first_followup_id    varchar2(37),
first_followup_type_code varchar2(40),
assd_first_followup date,
ased_first_followup date,
second_followup_id varchar2(37),
second_followup_type_code varchar2(40),
assd_second_followup date,
ased_second_followup date,
third_followup_id varchar2(37),
third_followup_type_code varchar2(40),
assd_third_followup date,
ased_third_followup date,
fourth_followup_id varchar2(37),
fourth_followup_type_code varchar2(40),
assd_fourth_followup date,
ased_fourth_followup date,
assd_auto_assign date,
ased_auto_assign date,
assd_wait_for_fee date,
ased_wait_for_fee date,
--
asf_cancel_enrl_activity varchar2(1) default 'N',
asf_send_enroll_packet  VARCHAR2(1)  default 'N',
asf_selection_recd      VARCHAR2(1)  default 'N',
asf_first_followup      VARCHAR2(1)  default 'N',
asf_second_followup     VARCHAR2(1)  default 'N',
asf_third_followup      VARCHAR2(1)  default 'N',
asf_fourth_followup     VARCHAR2(1)  default 'N',
asf_auto_assign         VARCHAR2(1)  default 'N',
asf_wait_for_fee        VARCHAR2(1)  default 'N',
--
gwf_enrl_pack_req       VARCHAR2(1),
gwf_first_followup_req  VARCHAR2(1),
gwf_second_followup_req VARCHAR2(1),
gwf_third_followup_req  VARCHAR2(1),
gwf_fourth_followup_req VARCHAR2(1),
gwf_required_fee_paid   VARCHAR2(1),
--
generic_field_1 varchar2(50),
generic_field_2 varchar2(50),
generic_field_3 varchar2(50),
generic_field_4 varchar2(50),
generic_field_5 varchar2(50),
--
instance_status        VARCHAR2(10) default 'Active'  not null,
complete_dt            date,
cancel_dt              date,
cancel_reason          varchar2(100),
cancel_method          varchar2(20),
cancel_by              varchar2(80),
STG_EXTRACT_DATE       date  not null,
STG_LAST_UPDATE_DATE   date  not null,
STAGE_DONE_DATE        date,
update_flg             varchar2(1),
age_in_calendar_days   number(18),
age_in_business_days   number(18)
) tablespace MAXDAT_DATA;

create or replace public synonym corp_etl_Manage_enroll_wip for corp_etl_Manage_enroll_wip;
grant select on corp_etl_Manage_enroll_wip to MAXDAT_READ_ONLY;


create table Rule_lkup_mng_enrl_followup
(
mefr_id             number(18),
followup_name       varchar2(15),
followup_req        varchar2(1),	
followup_type_code  varchar2(40),	
followup_type       varchar2(200),	
followup_cal_days   number(18),
plan_type           varchar2(15),
program_type        varchar2(15),
start_date          date,
end_date            date,
created_ts          date,
updated_ts          date
) tablespace MAXDAT_DATA;    

ALTER TABLE RULE_LKUP_MNG_ENRL_FOLLOWUP
ADD CONSTRAINT MNG_ENRL_FU_UNQ UNIQUE (FOLLOWUP_NAME, PLAN_TYPE, PROGRAM_TYPE, START_DATE) using index tablespace MAXDAT_INDX; 

create or replace public synonym Rule_lkup_mng_enrl_followup for Rule_lkup_mng_enrl_followup;
grant select on Rule_lkup_mng_enrl_followup to MAXDAT_READ_ONLY;


create table Rule_lkup_mng_enrl_sla
(
mes_id         number(18),
sla_days_type  varchar2(1),
sla_days       number(18),
sla_type       varchar2(50),	
newborn_flag   varchar2(1),
created_ts     date,
updated_ts     date
) tablespace MAXDAT_DATA;    

alter table Rule_lkup_mng_enrl_sla
add constraint Mng_Enrl_sla_UNQ unique (sla_days_type, sla_type, newborn_flag) using index tablespace MAXDAT_INDX;

create or replace public synonym Rule_lkup_mng_enrl_sla for Rule_lkup_mng_enrl_sla;
grant select on Rule_lkup_mng_enrl_sla to MAXDAT_READ_ONLY;


create table RULE_LKUP_MNG_ENRL_PACKET
(
MEP_ID             NUMBER(18),
PLAN_TYPE         varchar2(32),
PROGRAM_TYPE       varchar2(32),
SUBPROGRAM_TYPE    VARCHAR2(32),	
ENROLL_PACKET_NAME varchar2(10),
CREATED_TS         DATE,
UPDATED_TS         DATE
) tablespace MAXDAT_DATA;

create or replace public synonym RULE_LKUP_MNG_ENRL_PACKET for RULE_LKUP_MNG_ENRL_PACKET;
grant select on RULE_LKUP_MNG_ENRL_PACKET to MAXDAT_READ_ONLY;


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
) tablespace MAXDAT_DATA;

create or replace public synonym CLIENT_ENROLL_STATUS_STG for CLIENT_ENROLL_STATUS_STG;
grant select on CLIENT_ENROLL_STATUS_STG to MAXDAT_READ_ONLY;


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
--  PRIOR_PROVIDER_FIRST_NAME     VARCHAR2(25),
  PRIOR_PROVIDER_FIRST_NAME varchar2(64),
  PRIOR_PROVIDER_MIDDLE_NAME    VARCHAR2(25),
--  PRIOR_PROVIDER_LAST_NAME      VARCHAR2(35),
  PRIOR_PROVIDER_LAST_NAME varchar2(64),
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
) tablespace MAXDAT_DATA;

create or replace public synonym SELECTION_TXN_STG for SELECTION_TXN_STG;
grant select on SELECTION_TXN_STG to MAXDAT_READ_ONLY;


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
) tablespace MAXDAT_DATA;

create or replace public synonym ENUM_ENROLL_TRANS_SOURCE_STG for ENUM_ENROLL_TRANS_SOURCE_STG;
grant select on ENUM_ENROLL_TRANS_SOURCE_STG to MAXDAT_READ_ONLY;


CREATE TABLE CLIENT_ELIG_STATUS_STG
(
CLIENT_ELIG_STATUS_ID	NUMBER(18),
PLAN_TYPE_CD	VARCHAR2(32),
ELIG_STATUS_CD	VARCHAR2(32),
START_DATE	DATE,
END_DATE	DATE,
CREATE_TS	DATE,
CREATED_BY	VARCHAR2(80),
UPDATE_TS	DATE,
UPDATED_BY	VARCHAR2(80),
CLIENT_ID	NUMBER(18),
PROGRAM_CD	VARCHAR2(32),
SUB_STATUS_CODES	VARCHAR2(256),
REASONS	VARCHAR2(256),
MVX_CORE_REASON	VARCHAR2(256),
DEBUG	VARCHAR2(2000),
START_NDT	NUMBER(18),
END_NDT	NUMBER(18),
DISPOSITION_CD	VARCHAR2(32),
SUBPROGRAM_TYPE	VARCHAR2(32)
) tablespace MAXDAT_DATA;

create or replace public synonym CLIENT_ELIG_STATUS_STG for CLIENT_ELIG_STATUS_STG;
grant select on CLIENT_ELIG_STATUS_STG to MAXDAT_READ_ONLY;


CREATE table COST_SHARE_DETAILS_STG
(
CS_DETAILS_ID	NUMBER(10),
CASE_ID	NUMBER,
PAYMENT_LIMIT	NUMBER,
CAP_AMOUNT	NUMBER,
CAP_MET_DATE	DATE,
CAP_MET_AMOUNT	NUMBER,
CS_PERIOD_START_DATE	DATE,
CS_PERIOD_END_DATE	DATE,
ENROLLMENT_START_DATE	DATE,
ENROLLMENT_END_DATE	DATE,
TOTAL_EXPENSE_AMOUNT	NUMBER,
FPIL	NUMBER,
NET_AMOUNT	NUMBER,
FAMILY_SIZE	NUMBER,
FEE_EXEMPT	VARCHAR2(10),
ENROLLMENT_FEE	NUMBER,
CREATED_BY	VARCHAR2(256),
CREATE_TS	DATE,
UPDATED_BY	VARCHAR2(256),
UPDATE_TS	DATE,
DATE_FEE_PAID	DATE,
FEE_PAID_FLAG	VARCHAR2(1),
NSF_FLAG	VARCHAR2(1),
PLAN_NOTIFIED_DATE	DATE,
P030_EXCLUDE	VARCHAR2(1),
CE_FLAG	VARCHAR2(1 BYTE),
ORIGINAL_TRAN_TYPE	VARCHAR2(10)
) tablespace MAXDAT_DATA;

create or replace public synonym COST_SHARE_DETAILS_STG for COST_SHARE_DETAILS_STG;
grant select on COST_SHARE_DETAILS_STG to MAXDAT_READ_ONLY;

create table CUTOFF_CALENDAR_STG
(
  cutoff_id                  NUMBER(18),
  plan_type                  VARCHAR2(32),
  program_type_cd            VARCHAR2(32),
  program_status             VARCHAR2(128),
  sub_program_types          VARCHAR2(128),
  plan_service_types         VARCHAR2(128),
  scope                      VARCHAR2(400),
  transaction_type_cd        VARCHAR2(32),
  month_year                 VARCHAR2(10),
  state_cutoff_date_1        DATE,
  maximus_cutoff_date_1      DATE,
  retro_elig_cutoff_date_1   DATE,
  start_date_before_cutoff_1 DATE,
  start_date_after_cutoff_1  DATE,
  created_by                 VARCHAR2(80),
  create_ts                  DATE,
  updated_by                 VARCHAR2(80),
  update_ts                  DATE,
  state_cutoff_date_2        DATE,
  maximus_cutoff_date_2      DATE,
  retro_elig_cutoff_date_2   DATE,
  start_date_before_cutoff_2 DATE,
  start_date_after_cutoff_2  DATE,
  maximus_cutoff_time1       VARCHAR2(32),
  MAXIMUS_CUTOFF_TIME2       VARCHAR2(32)
) tablespace MAXDAT_DATA;

create or replace public synonym CUTOFF_CALENDAR_STG for CUTOFF_CALENDAR_STG;
grant select on CUTOFF_CALENDAR_STG to MAXDAT_READ_ONLY;
