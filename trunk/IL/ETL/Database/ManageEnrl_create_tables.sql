/*
Created on 11-Jun-2013 by Raj A.
Team: MAXDAT.
Project: ICEB.
Business Process: Manage Enrollment Activity.

Description:
Three stage tables are created for this process.
1.corp_etl_Manage_enroll
2.corp_etl_Manage_enroll_oltp
3.corp_etl_Manage_enroll_wip
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
enroll_fee_paid_dt     date,
chip_hpc_id            number(18),
chip_hpc_mailed_dt     date,
chip_emi_id            number(18),
chip_emi_mailed_dt     date,
plan_type              VARCHAR2(32),
program_type           VARCHAR2(32),
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
first_followup_id        number(18),
first_followup_type_code varchar2(40),
assd_first_followup date,
ased_first_followup date,
second_followup_id number(18),
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
STAGE_DONE_DATE        date,
age_in_calendar_days   number(18),
age_in_business_days   number(18)
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
chip_hpc_id            number(18),
chip_hpc_mailed_dt     date,
chip_emi_id            number(18),
chip_emi_mailed_dt     date,
plan_type              VARCHAR2(32),
program_type           VARCHAR2(32),
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
first_followup_id    number(18),
first_followup_type_code varchar2(40),
assd_first_followup date,
ased_first_followup date,
second_followup_id number(18),
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
);

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
chip_hpc_id            number(18),
chip_hpc_mailed_dt     date,
chip_emi_id            number(18),
chip_emi_mailed_dt     date,
plan_type              VARCHAR2(32),
program_type           VARCHAR2(32),
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
first_followup_id    number(18),
first_followup_type_code varchar2(40),
assd_first_followup date,
ased_first_followup date,
second_followup_id number(18),
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
);


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
);

    
alter table Rule_lkup_mng_enrl_followup
add constraint Mng_Enrl_FU_UNQ unique (followup_type_code, plan_type, program_type, start_date); 