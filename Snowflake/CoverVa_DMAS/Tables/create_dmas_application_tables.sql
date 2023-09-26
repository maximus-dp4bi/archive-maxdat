create table coverva_dmas.dmas_application_bak
as
select * from coverva_dmas.dmas_application;

create table coverva_dmas.dmas_excluded_application_bak
as
select * from coverva_dmas.dmas_excluded_application;

drop table coverva_dmas.manual_cpu_tracking;
drop table coverva_dmas.manual_cviu_tracking;
CREATE TABLE coverva_dmas.manual_cpu_tracking(
SUPERVISOR	VARCHAR(16777216),
EW	VARCHAR(16777216),
ALLOCATION	VARCHAR(16777216),
SOURCE	VARCHAR(16777216),
TIMESTAMP	VARCHAR(16777216),
NOA	VARCHAR(16777216),
VCL	VARCHAR(16777216),
APPROVED	VARCHAR(16777216),
DENIED	VARCHAR(16777216),
COLUMN1	VARCHAR(16777216),
COMMENTS	VARCHAR(16777216),
FILENAME	VARCHAR(16777216),
RECORD_ID	VARCHAR(16777216),
ACTIVITY_DATE	VARCHAR(16777216),
MWS_DATE	VARCHAR(16777216),
SENT_TO_LDSS	VARCHAR(16777216),
CLOSE_SUP	VARCHAR(16777216),
CLOSE_W	VARCHAR(16777216),
T	VARCHAR(16777216),
DMAS_ACTION_NEEDEDSENT_TO_SUPERVISOR	VARCHAR(16777216),
RESEARCHSENT_TO_SUPERVISOR	VARCHAR(16777216),
APPLICATION_NUMBER	VARCHAR(16777216));

alter table coverva_dmas.manual_cpu_tracking add primary key(record_id);

CREATE TABLE coverva_dmas.manual_cviu_tracking(
EMAIL	VARCHAR(16777216),
ALLOCATION	VARCHAR(16777216),
SOURCE	VARCHAR(16777216),
STATUS	VARCHAR(16777216),
"EMPTY-24"	VARCHAR(16777216),
OUTCOME	VARCHAR(16777216),
FILENAME	VARCHAR(16777216),
RECORD_ID	VARCHAR(16777216),
ACTIVITY_DATE	VARCHAR(16777216),
START_TIME	VARCHAR(16777216),
COMPLETION_TIME	VARCHAR(16777216),
MY_SUPERVISOR_IS	VARCHAR(16777216),
CASE_NUMBER	VARCHAR(16777216),
MWS_DATE	VARCHAR(16777216),
ACTION_AGE	VARCHAR(16777216),
BUSINESS_DAYS	VARCHAR(16777216),
T	VARCHAR(16777216),
NAME_EW	VARCHAR(16777216),
IS_THIS_APPLICATION_FOR_A_PREGNANT_WOMAN_1YES_0NO	VARCHAR(16777216),
COVERAGE_CORRECTION_NEEDED_1YES_0NO	VARCHAR(16777216),
NOA_1YES_0NO	VARCHAR(16777216),
VCL_1YES_0NO	VARCHAR(16777216),
MANUAL_VCL_1YES_0NO	VARCHAR(16777216),
SENT_TO_LDSS_1YES_0NO	VARCHAR(16777216),
DMAS_ACTION_NEEDEDSENT_TO_SUPERVISOR_1YES_0NO	VARCHAR(16777216),
RESEARCHSENT_TO_SUPERVISOR	VARCHAR(16777216),
COMM_FORM_1YES_0NO	VARCHAR(16777216),
T_SEARCH	VARCHAR(16777216),
APPLICATION_NUMBER	VARCHAR(16777216));


alter table coverva_dmas.manual_cviu_tracking add primary key(record_id);

CREATE OR REPLACE sequence coverva_dmas.seq_dmas_application_id;
CREATE OR REPLACE sequence coverva_dmas.seq_dmas_current_app_id;
CREATE OR REPLACE sequence coverva_dmas.seq_dmas_excluded_appid;
CREATE OR REPLACE sequence coverva_dmas.seq_dmas_eventid;

alter table COVERVA_DMAS.DMAS_Application drop primary key;
alter table COVERVA_DMAS.DMAS_Excluded_Application drop primary key;
alter table coverva_dmas.dmas_application drop (Ignore_Application_Indicator,Ignore_Application_Reason);
truncate table coverva_dmas.dmas_application;
alter table coverva_dmas.dmas_application add (DMAS_Application_ID NUMBER NOT NULL DEFAULT coverva_dmas.seq_dmas_application_id.nextval,state_app_received_date TIMESTAMP_NTZ NULL,cp_application_type VARCHAR NULL);
alter table COVERVA_DMAS.DMAS_Application add primary key (DMAS_Application_ID);
truncate table coverva_dmas.dmas_excluded_application;
alter table coverva_dmas.dmas_excluded_application add (DMAS_Excluded_Application_ID NUMBER NOT NULL DEFAULT coverva_dmas.seq_dmas_excluded_appid.nextval);
alter table COVERVA_DMAS.DMAS_Excluded_Application add primary key (DMAS_Excluded_Application_ID);

alter table coverva_dmas.DMAS_Application rename column application_id to tracking_number;
alter table coverva_dmas.DMAS_Excluded_Application rename column application_id to tracking_number;
alter table coverva_dmas.cp_application_inventory rename column t_number to tracking_number;
alter table coverva_dmas.cp_initial_application_review rename column external_app_id to tracking_number;

CREATE TABLE coverva_dmas.DMAS_Application_Current(
DMAS_Application_Current_ID NUMBER NOT NULL DEFAULT coverva_dmas.seq_dmas_current_app_id.nextval,
Tracking_Number VARCHAR NOT NULL,
Source VARCHAR NULL,
App_Received_Date TIMESTAMP_NTZ NULL,
Processing_Unit VARCHAR NULL,
Application_Type VARCHAR NULL, 
Current_State VARCHAR NULL,
Initial_Review_Complete_Date TIMESTAMP_NTZ NULL,
Application_Processing_End_Date TIMESTAMP_NTZ NULL,
Last_Employee VARCHAR NULL,
Applicant_Name VARCHAR NULL,  
Case_Number VARCHAR NULL, 
Override_Value_Indicator VARCHAR NULL,
FP_Create_Dt TIMESTAMP_NTZ NULL, 
FP_Update_Dt TIMESTAMP_NTZ NULL,
File_ID VARCHAR NULL,
In_CP_Indicator VARCHAR NULL,
Migrated_App_Indicator VARCHAR NULL,
Initial_Review_DT_Null_Reason VARCHAR NULL,
Last_Employee_Null_Reason VARCHAR NULL,
End_Date_Null_Reason VARCHAR NULL,
VCL_Due_Date TIMESTAMP_NTZ NULL,
Intake_Date TIMESTAMP_NTZ NULL,
Complete_Date TIMESTAMP_NTZ NULL,
File_Inventory_Date TIMESTAMP_NTZ NULL,
maximus_source_date TIMESTAMP_NTZ,
state_app_received_date TIMESTAMP_NTZ NULL,
cp_application_type VARCHAR NULL);

alter table COVERVA_DMAS.DMAS_Application_Current add primary key (DMAS_Application_Current_ID);

CREATE TABLE coverva_dmas.DMAS_Application_Event(
Event_ID  NUMBER DEFAULT coverva_dmas.seq_dmas_eventid.nextval,
tracking_number VARCHAR NOT NULL,
event_date TIMESTAMP_NTZ NULL,
in_app_metric VARCHAR NULL,
in_app_metric_pw VARCHAR NULL,
in_ppit VARCHAR NULL,
in_cm043 VARCHAR NULL,
in_cm044 VARCHAR NULL,
in_cviu VARCHAR NULL,
in_cpu_incarcerated VARCHAR NULL,
in_cpu VARCHAR NULL,
cpu_status VARCHAR NULL,
cpu_app_received_date TIMESTAMP_NTZ NULL,
cm044_status VARCHAR NULL,
cm044_authorized_date TIMESTAMP_NTZ NULL,
override_status VARCHAR NULL,
cviu_processing_status VARCHAR NULL,
cpui_processing_status VARCHAR NULL,
pending_due_vcl_pw VARCHAR NULL,
pending_due_vcl_am VARCHAR NULL,
ppit_worker VARCHAR NULL,
cpui_worker VARCHAR NULL,
cviu_worker VARCHAR NULL,
cpu_worker VARCHAR NULL,
am_worker VARCHAR NULL,
pw_worker VARCHAR NULL,
vcl_due_date_am TIMESTAMP_NTZ NULL,
vcl_due_date_pw TIMESTAMP_NTZ NULL,
override_app_end_date TIMESTAMP_NTZ NULL,
override_last_employee VARCHAR,
in_app_override VARCHAR,
cm044_worker VARCHAR,
cm043_status VARCHAR NULL,
prev_current_state VARCHAR NULL,
prev_app_end_date TIMESTAMP_NTZ NULL,
running_cpu_status VARCHAR NULL,
running_cpu_app_received_date TIMESTAMP_NTZ NULL,
event_create_date TIMESTAMP_NTZ NULL,
event_update_dateTIMESTAMP_NTZ NULL,
cp_iar_action_taken VARCHAR NULL,
cp_iar_ldss_created_on TIMESTAMP_NTZ NULL,
cp_iar_ldss_end_date TIMESTAMP_NTZ NULL, 
cp_inv_ad_disposition VARCHAR NULL,
cp_inv_ad_create_date TIMESTAMP_NTZ NULL,
cp_inv_ad_status_date TIMESTAMP_NTZ NULL,
cp_inv_ad_complete_date TIMESTAMP_NTZ NULL,
cp_inv_ad_worker VARCHAR NULL, 
cp_iar_ad_disposition VARCHAR NULL,
cp_iar_ad_created_on TIMESTAMP_NTZ NULL,
cp_iar_ad_status_date TIMESTAMP_NTZ NULL, 
cp_inv_pend_disposition VARCHAR NULL,
cp_inv_pend_create_date TIMESTAMP_NTZ NULL,
cp_inv_pend_status_date TIMESTAMP_NTZ NULL,
cp_inv_pend_complete_date TIMESTAMP_NTZ NULL,
cp_inv_pend_worker VARCHAR NULL, 
cp_iar_pend_disposition VARCHAR NULL,
cp_iar_pend_created_on TIMESTAMP_NTZ NULL,
cp_iar_pend_status_date TIMESTAMP_NTZ NULL, 
manual_cpu_status VARCHAR NULL,
mcpu_activity_date TIMESTAMP_NTZ NULL,
mcpu_last_employee VARCHAR NULL, 
manual_cviu_status VARCHAR NULL,
mcviu_activity_date TIMESTAMP_NTZ NULL, 
manual_prod_status VARCHAR NULL,
mpt_orig_status VARCHAR NULL,
mpt_complete_date TIMESTAMP_NTZ NULL,
mpt_last_employee VARCHAR NULL,
cp_inv_action_taken VARCHAR,
cp_inv_ldss_create_date TIMESTAMP_NTZ,
cp_inv_ldss_status_date TIMESTAMP_NTZ,
cp_inv_ldss_end_date TIMESTAMP_NTZ,
cp_inv_ldss_worker VARCHAR,
running_cpu_worker VARCHAR,
running_cpu_file_date TIMESTAMP_NTZ,
mpt_vcl_due_date TIMESTAMP_NTZ,
cp_vcl_due_date TIMESTAMP_NTZ,
iar_vcl_due_date TIMESTAMP_NTZ,
running_am_worker VARCHAR,
running_ppit_worker VARCHAR,
running_cviu_worker VARCHAR,
running_cviu_status VARCHAR,
running_cpui_worker VARCHAR,
running_cpui_status VARCHAR,
in_running_am VARCHAR,
in_running_ppit VARCHAR,
in_running_pw VARCHAR,
in_running_cm043 VARCHAR,
in_running_cviu VARCHAR,
in_running_cpui VARCHAR,
in_running_cpu VARCHAR,
mio_prod_status VARCHAR,
mio_orig_status VARCHAR,
mio_complete_date TIMESTAMP_NTZ,
mio_last_employee VARCHAR,
mio_vcl_due_date TIMESTAMP_NTZ);

alter table COVERVA_DMAS.DMAS_Application_Event add primary key (Event_ID);

CREATE OR REPLACE sequence coverva_dmas.seq_mpt_data_id;

CREATE TABLE coverva_dmas.manual_prod_tracker_full_load(
mpt_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_mpt_data_id.nextval,
record_id NUMBER NULL,
email VARCHAR NULL,
name VARCHAR NULL,
start_time TIMESTAMP_NTZ NULL,
completion_time TIMESTAMP_NTZ NULL,
noa_sent_indicator VARCHAR NULL,
reason_for_denial VARCHAR NULL,
vcl_due_date TIMESTAMP_NTZ NULL,
transferred_to_ldss_reason VARCHAR NULL,
additional_case_outcomes VARCHAR NULL,
error_description VARCHAR NULL,
number_of_approved_applicants VARCHAR NULL,
vcl_sent_date TIMESTAMP_NTZ NULL,
document_type_requested VARCHAR NULL,
pw_case_indicator VARCHAR NULL,
staff_supervisor VARCHAR NULL, 
t_number VARCHAR NULL,
status VARCHAR NULL,
dmas_action_needed VARCHAR NULL,
research_needed VARCHAR NULL,
tracking_number VARCHAR NULL,
filename VARCHAR NULL);

alter table COVERVA_DMAS.manual_prod_tracker_full_load add primary key (mpt_data_id);

CREATE OR REPLACE sequence coverva_dmas.seq_elig_verification_id;
CREATE OR REPLACE sequence coverva_dmas.seq_skipped_case_id;

CREATE TABLE coverva_dmas.eligibility_verification_full_load
(elig_verification_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_elig_verification_id.nextval,
 record_id NUMBER,
 email VARCHAR NULL,
 name VARCHAR NULL,
 filename VARCHAR NULL,
 start_time TIMESTAMP_NTZ NULL,
 completion_time TIMESTAMP_NTZ NULL,
 outcome VARCHAR NULL,
 tracking_number VARCHAR NULL,
 record_id2 VARCHAR NULL,
 ew_reviewed_by VARCHAR NULL,
 ews_supervisor VARCHAR NULL);

ALTER TABLE coverva_dmas.eligibility_verification_full_load ADD primary key(elig_verification_id);

CREATE TABLE coverva_dmas.skipped_cases_full_load
(skipped_case_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_skipped_case_id.nextval,
 record_id NUMBER,
 email VARCHAR NULL,
 name VARCHAR NULL,
 filename VARCHAR NULL,
 start_time TIMESTAMP_NTZ NULL,
 completion_time TIMESTAMP_NTZ NULL,
 staff_supervisor VARCHAR NULL,
 skipped_case_reason VARCHAR NULL,
 tracking_number VARCHAR NULL,
 pw_case_indicator VARCHAR NULL,
 outbound_call_indicator VARCHAR NULL);

ALTER TABLE coverva_dmas.skipped_cases_full_load ADD primary key(skipped_case_id);


INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory)
VALUES('MPT','MANUAL_PROD_TRACKER_FULL_LOAD','COVERVA_DMAS',
      'record_id,email,name,start_time,completion_time,noa_sent_indicator,reason_for_denial,vcl_due_date,transferred_to_ldss_reason,additional_case_outcomes,error_description,number_of_approved_applicants,vcl_sent_date,document_type_requested,pw_case_indicator,staff_supervisor,t_number,status,dmas_action_needed,research_needed,tracking_number,filename'
      ,'id,email,name,TO_TIMESTAMP(REGEXP_REPLACE(start_time,''[^A-Za-z0-9 -:/*]'',''''),''mm/dd/yy hh24:mi:ss'') start_time,TO_TIMESTAMP(REGEXP_REPLACE(completion_time,''[^A-Za-z0-9 -:/*]'',''''),''mm/dd/yy hh24:mi:ss'') completion_time,was_a_noa_sent,reason_for_denial,CAST(REGEXP_REPLACE(vcl_due_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) vcl_due_date,reason_case_was_transferred_to_ldss,
additional_case_outcomes,clear_description_of_the_error_you_are_experiencing,number_of_approved_applicants,CAST(REGEXP_REPLACE(vcl_sent_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) vcl_sent_date,document_type_requested,is_this_a_pw_case,
who_is_your_supervisor,t_number_copy__paste_from_your_daily_work_distro_spreadsheet,status,dmas_action_needed_case_sent_to_supervisor,additional_research_needed_case_sent_to_supervisor,converted_t_,filename'
      ,'WHERE converted_t_ IS NOT NULL','Y','Y');  
      
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory)
VALUES('EVT','ELIGIBILITY_VERIFICATION_FULL_LOAD','COVERVA_DMAS',
      'record_id,email,name,start_time,completion_time,outcome,record_id2,ew_reviewed_by,ews_supervisor,tracking_number,filename'
      ,'id,email,name,TO_TIMESTAMP(REGEXP_REPLACE(start_time,''[^A-Za-z0-9 -:/*]'',''''),''mm/dd/yy hh24:mi:ss'') start_time,TO_TIMESTAMP(REGEXP_REPLACE(completion_time,''[^A-Za-z0-9 -:/*]'',''''),''mm/dd/yy hh24:mi:ss'') completion_time,outcome,id__,ew_reviewed_by,ews_supervisor,t_number,filename'
      ,'WHERE 1=1','Y','Y');          

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory)
VALUES('SC','SKIPPED_CASES_FULL_LOAD','COVERVA_DMAS',
      'record_id,email,name,start_time,completion_time,staff_supervisor,skipped_case_reason,tracking_number,pw_case_indicator,outbound_call_indicator,filename'
      ,'id,email,name,TO_TIMESTAMP(REGEXP_REPLACE(start_time,''[^A-Za-z0-9 -:/*]'',''''),''mm/dd/yy hh24:mi:ss'') start_time,TO_TIMESTAMP(REGEXP_REPLACE(completion_time,''[^A-Za-z0-9 -:/*]'',''''),''mm/dd/yy hh24:mi:ss'') completion_time,who_is_your_supervisor,reason_the_case_was_skipped,what_is_the_t_number_that_was_skipped,is_this_a_pw_case,did_you_make_an_outbound_call_to_acquire_necessary_info,filename'
      ,'WHERE 1=1','Y','Y');   

