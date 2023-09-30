/*
Created on 11-Jun-2013 by Raj A.
Project: ILEB.
Business Process: Manage Enrollment Activity.

Description:
Three stage tables are created for this process.
1.corp_etl_Manage_enroll
2.corp_etl_Manage_enroll_oltp
3.corp_etl_Manage_enroll_wip
*/
create table corp_etl_Manage_enroll
(
CEME_ID                   NUMBER(18), --PK.
client_enroll_status_id   NUMBER(18),  --unique instance.
client_id                 NUMBER(18),
create_dt                 DATE,
case_id                   NUMBER(18),
client_cin                VARCHAR2(32),
newborn_flg               VARCHAR2(1) default 'N',
service_area              VARCHAR2(32),
county_code               VARCHAR2(32),
zip_code               	  VARCHAR2(32),
enrollment_status_code    VARCHAR2(32),
enrollment_status_dt      DATE,
aa_due_dt                 DATE,
enrl_pack_id              NUMBER(18),
enrl_pack_request_dt      DATE,
enroll_fee_amnt_due       NUMBER default 0, 
enroll_fee_amnt_paid      NUMBER default 0,
enroll_fee_paid_dt        DATE,
chip_hpc_id               NUMBER(18),
chip_hpc_mailed_dt        DATE,
chip_emi_id               NUMBER(18),
chip_emi_mailed_dt        DATE,
plan_type                 VARCHAR2(32),
program_type              VARCHAR2(32),
slct_auto_proc            VARCHAR2(1),
slct_method               VARCHAR2(32),   
slct_create_by_name       VARCHAR2(80),
slct_create_dt            DATE,
slct_last_update_by_name  VARCHAR2(80),
slct_last_update_dt       DATE,
assd_selection_recd       DATE,
ased_selection_recd       DATE,
assd_send_enroll_packet   DATE,
ased_send_enroll_packet   DATE,
first_followup_id         VARCHAR2(37),
first_followup_type_code  VARCHAR2(40),
assd_first_followup       DATE,
ased_first_followup       DATE,
second_followup_id        VARCHAR2(37),
second_followup_type_code VARCHAR2(40),
assd_second_followup      DATE,
ased_second_followup      DATE,
third_followup_id         VARCHAR2(37), 
third_followup_type_code  VARCHAR2(40),
assd_third_followup       DATE,
ased_third_followup       DATE,
fourth_followup_id        VARCHAR2(37),
fourth_followup_type_code VARCHAR2(40),
assd_fourth_followup      DATE,
ased_fourth_followup      DATE,
assd_auto_assign          DATE,
ased_auto_assign          DATE,
assd_wait_for_fee         DATE,
ased_wait_for_fee         DATE,
asf_cancel_enrl_activity  VARCHAR2(1) default 'N',
asf_send_enroll_packet    VARCHAR2(1)  default 'N',
asf_selection_recd        VARCHAR2(1)  default 'N',
asf_first_followup        VARCHAR2(1)  default 'N',
asf_second_followup       VARCHAR2(1)  default 'N',
asf_third_followup        VARCHAR2(1)  default 'N',
asf_fourth_followup       VARCHAR2(1)  default 'N',
asf_auto_assign           VARCHAR2(1)  default 'N',
asf_wait_for_fee          VARCHAR2(1)  default 'N',
gwf_enrl_pack_req         VARCHAR2(1),
gwf_first_followup_req    VARCHAR2(1),
gwf_second_followup_req   VARCHAR2(1),
gwf_third_followup_req    VARCHAR2(1),
gwf_fourth_followup_req   VARCHAR2(1),
gwf_required_fee_paid     VARCHAR2(1),
generic_field_1           VARCHAR2(50),
generic_field_2           VARCHAR2(50),
generic_field_3           VARCHAR2(50),
generic_field_4           VARCHAR2(50),
generic_field_5           VARCHAR2(50),
instance_status           VARCHAR2(10) default 'Active' not null, 
complete_dt               DATE,
cancel_dt                 DATE,
cancel_reason             VARCHAR2(100),
cancel_method             VARCHAR2(20),
cancel_by                 VARCHAR2(80),
STG_EXTRACT_DATE          DATE not null,
STG_LAST_UPDATE_DATE      DATE  not null,
STAGE_DONE_DATE           DATE,
SUBPROGRAM_TYPE           VARCHAR2(32),
FEE_PAID_FLG              VARCHAR2(1)
);

alter table corp_etl_Manage_enroll
  add constraint Manage_enrl_PK primary key (CEME_ID) ;

alter table corp_etl_Manage_enroll
  add constraint Manage_enrl_UNQ unique (client_enroll_status_id) ;  

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

create table corp_etl_Manage_enroll_oltp
(
CEME_ID                   NUMBER(18), --PK.
client_enroll_status_id   NUMBER(18),  --unique instance.
client_id                 NUMBER(18),
create_dt                 DATE,
case_id                   NUMBER(18),
client_cin                VARCHAR2(32),
newborn_flg               VARCHAR2(1) default 'N',
service_area              VARCHAR2(32),
county_code               VARCHAR2(32),
zip_code                  VARCHAR2(32),
enrollment_status_code    VARCHAR2(32),
enrollment_status_dt      DATE,
aa_due_dt                 DATE,
enrl_pack_id              NUMBER(18),
enrl_pack_request_dt      DATE,
enroll_fee_amnt_due       NUMBER default 0,
enroll_fee_amnt_paid      NUMBER default 0,
enroll_fee_paid_dt        DATE,
chip_hpc_id               NUMBER(18),
chip_hpc_mailed_dt        DATE,
chip_emi_id               NUMBER(18),
chip_emi_mailed_dt        DATE,
plan_type                 VARCHAR2(32),
program_type              VARCHAR2(32),
slct_auto_proc            VARCHAR2(1),
slct_method               VARCHAR2(32),   
slct_create_by_name       VARCHAR2(80),
slct_create_dt            DATE,
slct_last_update_by_name  VARCHAR2(80),
slct_last_update_dt       DATE,
assd_selection_recd       DATE,
ased_selection_recd       DATE,
assd_send_enroll_packet   DATE,
ased_send_enroll_packet   DATE,
first_followup_id         VARCHAR2(37),
first_followup_type_code  VARCHAR2(40),
assd_first_followup       DATE,
ased_first_followup 	  DATE,
second_followup_id        VARCHAR2(37),
second_followup_type_code VARCHAR2(40),
assd_second_followup      DATE,
ased_second_followup      DATE,
third_followup_id         VARCHAR2(37),
third_followup_type_code  VARCHAR2(40),
assd_third_followup       DATE,
ased_third_followup       DATE,
fourth_followup_id        VARCHAR2(37),
fourth_followup_type_code VARCHAR2(40),
assd_fourth_followup      DATE,
ased_fourth_followup      DATE,
assd_auto_assign          DATE,
ased_auto_assign          DATE,
assd_wait_for_fee         DATE,
ased_wait_for_fee         DATE,
asf_cancel_enrl_activity  VARCHAR2(1) default 'N',
asf_send_enroll_packet    VARCHAR2(1)  default 'N',
asf_selection_recd        VARCHAR2(1)  default 'N',
asf_first_followup        VARCHAR2(1)  default 'N',
asf_second_followup       VARCHAR2(1)  default 'N',
asf_third_followup        VARCHAR2(1)  default 'N',
asf_fourth_followup       VARCHAR2(1)  default 'N',
asf_auto_assign           VARCHAR2(1)  default 'N',
asf_wait_for_fee          VARCHAR2(1)  default 'N',
gwf_enrl_pack_req         VARCHAR2(1),
gwf_first_followup_req    VARCHAR2(1),
gwf_second_followup_req   VARCHAR2(1),
gwf_third_followup_req    VARCHAR2(1),
gwf_fourth_followup_req   VARCHAR2(1),
gwf_required_fee_paid     VARCHAR2(1),
generic_field_1 	      VARCHAR2(50),
generic_field_2           VARCHAR2(50),
generic_field_3           VARCHAR2(50),
generic_field_4           VARCHAR2(50),
generic_field_5           VARCHAR2(50),
instance_status           VARCHAR2(10) default 'Active'  not null,
complete_dt               DATE,
cancel_dt                 DATE,
cancel_reason             VARCHAR2(100),
cancel_method             VARCHAR2(20),
cancel_by                 VARCHAR2(80),
STG_EXTRACT_DATE          DATE  not null,
STG_LAST_UPDATE_DATE      DATE  not null,
STAGE_DONE_DATE           DATE,
AGE_IN_CALENDAR_DAYS      NUMBER(18),
AGE_IN_BUSINESS_DAYS      NUMBER(18),
SUBPROGRAM_TYPE           VARCHAR2(32),
FEE_PAID_FLG              VARCHAR2(1)
);

create table corp_etl_Manage_enroll_wip
(
CEME_ID                   NUMBER(18), --PK.
client_enroll_status_id   NUMBER(18),  --unique instance.
client_id                 NUMBER(18),
create_dt                 DATE,
case_id                   NUMBER(18),
client_cin                VARCHAR2(32),
newborn_flg               VARCHAR2(1) default 'N',
service_area              VARCHAR2(32),
county_code               VARCHAR2(32),
zip_code                  VARCHAR2(32),
enrollment_status_code    VARCHAR2(32),
enrollment_status_dt      DATE,
aa_due_dt                 DATE,
enrl_pack_id              NUMBER(18),
enrl_pack_request_dt      DATE,
enroll_fee_amnt_due       NUMBER default 0,
enroll_fee_amnt_paid      NUMBER default 0,
enroll_fee_paid_dt        DATE,
chip_hpc_id               NUMBER(18),
chip_hpc_mailed_dt        DATE,
chip_emi_id               NUMBER(18),
chip_emi_mailed_dt        DATE,
plan_type                 VARCHAR2(32),
program_type              VARCHAR2(32),
slct_auto_proc            VARCHAR2(1),
slct_method               VARCHAR2(32),   
slct_create_by_name       VARCHAR2(80),
slct_create_dt            DATE,
slct_last_update_by_name  VARCHAR2(80),
slct_last_update_dt       DATE,
assd_selection_recd       DATE,
ased_selection_recd       DATE,
assd_send_enroll_packet   DATE,
ased_send_enroll_packet   DATE,
first_followup_id         VARCHAR2(37),
first_followup_type_code  VARCHAR2(40),
assd_first_followup       DATE,
ased_first_followup       DATE,
second_followup_id        VARCHAR2(37),
second_followup_type_code VARCHAR2(40),
assd_second_followup      DATE,
ased_second_followup      DATE,
third_followup_id         VARCHAR2(37),
third_followup_type_code  VARCHAR2(40),
assd_third_followup       DATE,
ased_third_followup       DATE,
fourth_followup_id        VARCHAR2(37),
fourth_followup_type_code VARCHAR2(40),
assd_fourth_followup      DATE,
ased_fourth_followup      DATE,
assd_auto_assign          DATE,
ased_auto_assign          DATE,
assd_wait_for_fee         DATE,
ased_wait_for_fee         DATE,
asf_cancel_enrl_activity  VARCHAR2(1)  default 'N',
asf_send_enroll_packet    VARCHAR2(1)  default 'N',
asf_selection_recd        VARCHAR2(1)  default 'N',
asf_first_followup        VARCHAR2(1)  default 'N',
asf_second_followup       VARCHAR2(1)  default 'N',
asf_third_followup        VARCHAR2(1)  default 'N',
asf_fourth_followup       VARCHAR2(1)  default 'N',
asf_auto_assign           VARCHAR2(1)  default 'N',
asf_wait_for_fee          VARCHAR2(1)  default 'N',
gwf_enrl_pack_req         VARCHAR2(1),
gwf_first_followup_req    VARCHAR2(1),
gwf_second_followup_req   VARCHAR2(1),
gwf_third_followup_req    VARCHAR2(1),
gwf_fourth_followup_req   VARCHAR2(1),
gwf_required_fee_paid     VARCHAR2(1),
generic_field_1 	      VARCHAR2(50),
generic_field_2           VARCHAR2(50),
generic_field_3           VARCHAR2(50),
generic_field_4           VARCHAR2(50),
generic_field_5           VARCHAR2(50),
instance_status           VARCHAR2(10) default 'Active'  not null,
complete_dt               DATE,
cancel_dt                 DATE,
cancel_reason             VARCHAR2(100),
cancel_method             VARCHAR2(20),
cancel_by                 VARCHAR2(80),
STG_EXTRACT_DATE          DATE  not null,
STG_LAST_UPDATE_DATE      DATE  not null,
STAGE_DONE_DATE           DATE,
update_flg                VARCHAR2(1),
SUBPROGRAM_TYPE           VARCHAR2(32),
FEE_PAID_FLG              VARCHAR2(1)
);


create table Rule_lkup_mng_enrl_followup
(
mefr_id             NUMBER(18),
followup_name       VARCHAR2(15),
followup_req        VARCHAR2(1),	
followup_type_code  VARCHAR2(40),	
followup_type       VARCHAR2(200),	
followup_cal_days   NUMBER(18),
plan_type           VARCHAR2(15),
program_type        VARCHAR2(15),
subprogram_type     VARCHAR2(32),
start_date          date,
end_date            date,
created_ts          date,
updated_ts          date
);

alter table Rule_lkup_mng_enrl_followup
add constraint Mng_Enrl_FU_UNQ unique (followup_type_code, plan_type, program_type, subprogram_type, start_date); 

create table Rule_lkup_mng_enrl_sla
(
mes_id         NUMBER(18),
sla_days_type  VARCHAR2(1),
sla_days       NUMBER(18),
sla_type       VARCHAR2(50),	
newborn_flag   VARCHAR2(1),
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