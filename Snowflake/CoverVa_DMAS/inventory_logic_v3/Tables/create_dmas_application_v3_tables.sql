CREATE OR REPLACE sequence coverva_dmas.seq_dmas_application_v3_inv_id;
CREATE OR REPLACE sequence coverva_dmas.seq_dmas_application_v3_current_id;
CREATE OR REPLACE sequence coverva_dmas.seq_dmas_application_v3_excluded_id;
CREATE OR REPLACE sequence coverva_dmas.seq_dmas_application_v3_event_id;

ALTER TABLE coverva_dmas.dmas_file_load_lkup ADD(use_in_v3_inventory VARCHAR);
ALTER TABLE coverva_dmas.dmas_file_log ADD(cdc_v3_processed VARCHAR DEFAULT 'N',cdc_v3_processed_date TIMESTAMP_NTZ(9));

CREATE OR REPLACE TABLE coverva_dmas.DMAS_Application_V3_Inventory(
DMAS_Application_ID NUMBER NOT NULL DEFAULT coverva_dmas.seq_dmas_application_v3_inv_id.nextval,
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
cp_application_type VARCHAR NULL,
cm044_verified VARCHAR(3),
non_maximus_initial_date TIMESTAMP_NTZ(9),
non_maximus_returned_date TIMESTAMP_NTZ(9),
vcl_sent_date DATE,
Case_Type VARCHAR,
SD_Stage VARCHAR,
NOA_Generation_Date DATE,
Application_Incarcerated_Indicator VARCHAR,
Case_Incarcerated_Indicator VARCHAR,
renewal_closure_date TIMESTAMP_NTZ(9),
auto_closure_date TIMESTAMP_NTZ(9),
denial_reason VARCHAR,
status_date TIMESTAMP_NTZ(9),
actual_app_end_date TIMESTAMP_NTZ(9),
intake_state_first_date TIMESTAMP_NTZ(9),
wir_state_first_date TIMESTAMP_NTZ(9),
wfvd_state_first_date TIMESTAMP_NTZ(9),
irc_state_first_date TIMESTAMP_NTZ(9),
approved_state_first_date TIMESTAMP_NTZ(9),
denied_state_first_date TIMESTAMP_NTZ(9),
ttldss_state_first_date TIMESTAMP_NTZ(9),
nma_state_first_date TIMESTAMP_NTZ(9),
complete_state_first_date TIMESTAMP_NTZ(9),
previous_processing_end_date DATE,
previous_initial_review_date DATE,
previous_current_state VARCHAR
);

alter table COVERVA_DMAS.DMAS_Application_V3_Inventory add primary key (DMAS_Application_ID);

CREATE OR REPLACE TABLE coverva_dmas.DMAS_Excluded_V3_Application(
DMAS_Excluded_Application_ID NUMBER NOT NULL DEFAULT coverva_dmas.seq_dmas_application_v3_excluded_id.nextval,
Tracking_Number VARCHAR NOT NULL,
Ignore_Application_Reason VARCHAR NULL,
File_ID VARCHAR NULL,
File_Inventory_Date TIMESTAMP_NTZ NULL,
FP_Create_Dt TIMESTAMP_NTZ NULL, 
FP_Update_Dt TIMESTAMP_NTZ NULL
);

alter table COVERVA_DMAS.DMAS_Excluded_V3_Application add primary key (DMAS_Excluded_Application_ID);

CREATE OR REPLACE TABLE coverva_dmas.DMAS_Application_V3_Current(
DMAS_Application_Current_ID NUMBER NOT NULL DEFAULT coverva_dmas.seq_dmas_application_v3_current_id.nextval,
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
cp_application_type VARCHAR NULL,
cm044_verified VARCHAR(3),
non_maximus_initial_date TIMESTAMP_NTZ(9),
non_maximus_returned_date TIMESTAMP_NTZ(9),
vcl_sent_date DATE,
Case_Type VARCHAR,
SD_Stage VARCHAR,
NOA_Generation_Date DATE,
Application_Incarcerated_Indicator VARCHAR,
Case_Incarcerated_Indicator VARCHAR,
renewal_closure_date TIMESTAMP_NTZ(9),
auto_closure_date TIMESTAMP_NTZ(9),
denial_reason VARCHAR,
status_date TIMESTAMP_NTZ(9),
actual_app_end_date TIMESTAMP_NTZ(9),
intake_state_first_date TIMESTAMP_NTZ(9),
wir_state_first_date TIMESTAMP_NTZ(9),
wfvd_state_first_date TIMESTAMP_NTZ(9),
irc_state_first_date TIMESTAMP_NTZ(9),
approved_state_first_date TIMESTAMP_NTZ(9),
denied_state_first_date TIMESTAMP_NTZ(9),
ttldss_state_first_date TIMESTAMP_NTZ(9),
nma_state_first_date TIMESTAMP_NTZ(9),
complete_state_first_date TIMESTAMP_NTZ(9));

alter table COVERVA_DMAS.DMAS_Application_V3_Current add primary key (DMAS_Application_Current_ID);

CREATE OR REPLACE TABLE coverva_dmas.DMAS_Application_V3_Event(
Application_Event_ID  NUMBER DEFAULT coverva_dmas.seq_dmas_application_v3_event_id.nextval,
tracking_number VARCHAR NOT NULL,
event_date TIMESTAMP_NTZ NULL,
in_app_metric VARCHAR NULL,
in_cm043 VARCHAR NULL,
in_rp190 VARCHAR NULL,
in_cviu_liaison VARCHAR NULL,
in_running_cviu_liaison VARCHAR NULL, 
in_running_app_metric VARCHAR NULL, 
in_running_cm043 VARCHAR NULL,
in_running_rp190 VARCHAR NULL,
am_worker_id VARCHAR NULL,  
running_am_worker_id  VARCHAR NULL,  
am_wid_in_ldap  VARCHAR NULL, 
case_type VARCHAR,
sd_stage VARCHAR,
cm_status VARCHAR NULL,
cm_authorized_date TIMESTAMP_NTZ NULL,
cm_worker VARCHAR,  
override_status VARCHAR NULL,
override_app_end_date TIMESTAMP_NTZ NULL,
override_last_employee VARCHAR,  
cp_iar_action_taken VARCHAR NULL,
cp_iar_ldss_created_on TIMESTAMP_NTZ NULL,
cp_iar_ldss_end_date TIMESTAMP_NTZ NULL, 
cp_iar_ldss_worker VARCHAR,
cp_inv_ad_disposition VARCHAR NULL,
cp_inv_ad_create_date TIMESTAMP_NTZ NULL,
cp_inv_ad_status_date TIMESTAMP_NTZ NULL,
cp_inv_ad_complete_date TIMESTAMP_NTZ NULL,
cp_inv_ad_worker VARCHAR NULL, 
cp_iar_ad_disposition VARCHAR NULL,
cp_iar_ad_created_on TIMESTAMP_NTZ NULL,
cp_iar_ad_status_date TIMESTAMP_NTZ NULL, 
cp_iar_ad_worker VARCHAR,
cp_inv_pend_disposition VARCHAR NULL,
cp_inv_pend_create_date TIMESTAMP_NTZ NULL,
cp_inv_pend_status_date TIMESTAMP_NTZ NULL,
cp_inv_pend_complete_date TIMESTAMP_NTZ NULL,
cp_inv_pend_worker VARCHAR NULL, 
cp_iar_pend_disposition VARCHAR NULL,
cp_iar_pend_created_on TIMESTAMP_NTZ NULL,
cp_iar_pend_status_date TIMESTAMP_NTZ NULL, 
cp_iar_pend_worker VARCHAR,  
cp_inv_action_taken VARCHAR,
cp_inv_ldss_create_date TIMESTAMP_NTZ,
cp_inv_ldss_status_date TIMESTAMP_NTZ,
cp_inv_ldss_end_date TIMESTAMP_NTZ,
cp_inv_ldss_worker VARCHAR,
cp_vcl_due_date TIMESTAMP_NTZ,
iar_vcl_due_date TIMESTAMP_NTZ,  
rp265_sending_agency VARCHAR,
rp265_transfer_date TIMESTAMP_NTZ,  
rp266_sending_agency VARCHAR,
rp266_transfer_date TIMESTAMP_NTZ,    
rp269_vcl_generation_date TIMESTAMP_NTZ,      
rp270_vcl_generation_date TIMESTAMP_NTZ,
mio_prod_status VARCHAR,
mio_orig_status VARCHAR,
mio_complete_date TIMESTAMP_NTZ,
mio_last_employee VARCHAR,
mio_vcl_due_date TIMESTAMP_NTZ,
mio_update_date TIMESTAMP_NTZ,
mio_term_last_employee VARCHAR,
mio_term_complete_date TIMESTAMP_NTZ,
mio_term_update_date TIMESTAMP_NTZ,
mio_term_vcl_due_date TIMESTAMP_NTZ, 
mio_term_orig_status VARCHAR, 
mio_term_state VARCHAR,
am_processing_unit VARCHAR,
running_am_processing_unit VARCHAR,
am_ldss_date DATE,
running_am_ldss_date DATE,
cviu_liaison_worker VARCHAR,
previous_current_state VARCHAR,
previous_end_date DATE,
manual_cviu_status VARCHAR,
manual_cpu_status VARCHAR,
mcviu_activity_date DATE,
mcpu_activity_date DATE);

alter table COVERVA_DMAS.DMAS_Application_V3_Event add primary key (Application_Event_ID);
