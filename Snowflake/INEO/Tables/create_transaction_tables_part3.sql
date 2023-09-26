
create or replace sequence seq_active_unsched_history_id;

DROP TABLE IF EXISTS ineo_active_unsched_absences_production_history;
CREATE TABLE ineo_active_unsched_absences_production_history
(active_unsched_history_id NUMBER NOT NULL DEFAULT seq_unsched_absence_history_id.nextval ,
active_unsched_absence_id VARCHAR,
absence_date DATE,
absence_description VARCHAR,
absence_end_time VARCHAR,
absence_start_time VARCHAR,
absence_type VARCHAR,
archive_error VARCHAR,
arrival_time VARCHAR,
departure_time VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
employee_type VARCHAR,
filename VARCHAR, 
manager VARCHAR,
maximus_email VARCHAR,
point_value VARCHAR,
position_title VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
submission_comments VARCHAR,
submission_date DATE,
submission_timestamp TIMESTAMP_NTZ(9),
submitted_employee_name  VARCHAR,
supervisor VARCHAR,
time_zone  VARCHAR,
training_status  VARCHAR,
transition_team_lead VARCHAR,
wfm_absence_description  VARCHAR,
regions_supporting VARCHAR,
employee_total FLOAT,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
preferred_name);

alter table ineo_active_unsched_absences_production_history add primary key (active_unsched_history_id);

DROP TABLE IF EXISTS ineo_active_unsched_absences_production;
CREATE TABLE ineo_active_unsched_absences_production
(active_unsched_absence_id VARCHAR,
absence_date DATE,
absence_description VARCHAR,
absence_end_time VARCHAR,
absence_start_time VARCHAR,
absence_type VARCHAR,
archive_error VARCHAR,
arrival_time VARCHAR,
departure_time VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
employee_type VARCHAR,
filename VARCHAR, 
manager VARCHAR,
maximus_email VARCHAR,
point_value VARCHAR,
position_title VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
submission_comments VARCHAR,
submission_date DATE,
submission_timestamp TIMESTAMP_NTZ(9),
submitted_employee_name  VARCHAR,
supervisor VARCHAR,
time_zone  VARCHAR,
training_status  VARCHAR,
transition_team_lead VARCHAR,
wfm_absence_description  VARCHAR,
regions_supporting VARCHAR,
employee_total FLOAT,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
preferred_name);

alter table ineo_active_unsched_absences_production add primary key (active_unsched_absence_id);

create or replace sequence seq_prov_staff_roster_history_id;

DROP TABLE IF EXISTS ineo_provisioning_staff_roster_history;
CREATE TABLE ineo_provisioning_staff_roster_history(
prov_staff_roster_history_id NUMBER NOT NULL DEFAULT seq_prov_staff_roster_history_id.nextval,
provisioning_staff_roster_id VARCHAR,
agency_hire_date DATE,
cognos_needed VARCHAR,
cognos_received DATE,
cognos_requested DATE,
department VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
filename VARCHAR,
fssa_id VARCHAR,
fssa_received DATE,
fssa_requested DATE,
genesys_i3_id VARCHAR,
genesys_requested DATE,
iedss_received DATE,
iedss_requested DATE,
manager VARCHAR,
maximus_email VARCHAR,
maximus_hire_date DATE,
position_title VARCHAR,
psid VARCHAR,
psid_overdue VARCHAR,
psid_received DATE,
psid_requested DATE,
region VARCHAR,
supervisor VARCHAR,
term_date DATE,
time_zone VARCHAR,
training_class_id VARCHAR,
training_co_facilitator VARCHAR,
training_facilitator VARCHAR,
training_start_date DATE,
training_status VARCHAR,
transition_team_lead VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

alter table ineo_provisioning_staff_roster_history add primary key (prov_staff_roster_history_id);

DROP TABLE IF EXISTS ineo_provisioning_staff_roster;
CREATE TABLE ineo_provisioning_staff_roster(
provisioning_staff_roster_id VARCHAR,
agency_hire_date DATE,
cognos_needed VARCHAR,
cognos_received DATE,
cognos_requested DATE,
department VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
filename VARCHAR,
fssa_id VARCHAR,
fssa_received DATE,
fssa_requested DATE,
genesys_i3_id VARCHAR,
genesys_requested DATE,
iedss_received DATE,
iedss_requested DATE,
manager VARCHAR,
maximus_email VARCHAR,
maximus_hire_date DATE,
position_title VARCHAR,
psid VARCHAR,
psid_overdue VARCHAR,
psid_received DATE,
psid_requested DATE,
region VARCHAR,
supervisor VARCHAR,
term_date DATE,
time_zone VARCHAR,
training_class_id VARCHAR,
training_co_facilitator VARCHAR,
training_facilitator VARCHAR,
training_start_date DATE,
training_status VARCHAR,
transition_team_lead VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

alter table ineo_provisioning_staff_roster add primary key (provisioning_staff_roster_id);

create or replace sequence seq_active_timeoff_req_history_id;

DROP TABLE IF EXISTS INEO_ACTIVE_TIME_OFF_REQUESTS_HISTORY;
CREATE TABLE INEO_ACTIVE_TIME_OFF_REQUESTS_HISTORY
(active_timeoff_req_history_id NUMBER NOT NULL DEFAULT seq_active_timeoff_req_history_id.nextval,
active_timeoff_request_id VARCHAR,
 absence_date DATE,
absence_description VARCHAR,
absence_end_time  VARCHAR,
absence_start_time  VARCHAR,
absence_type  VARCHAR,
archive_error  VARCHAR,
arrival_time  VARCHAR,
departure_time  VARCHAR,
employee_id  VARCHAR,
employee_name  VARCHAR,
employee_status  VARCHAR,
employee_type  VARCHAR,
filename  VARCHAR,
latest_comment VARCHAR,
manager VARCHAR,
maximus_email VARCHAR,
month_number NUMBER,
month_name VARCHAR,
operations_approval_date DATE,
operations_approval_status VARCHAR,
position_title VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
submission_comments VARCHAR,
submission_date DATE,
submission_timestamp TIMESTAMP_NTZ(9),
submitted_employee_name VARCHAR,
supervisor VARCHAR,
time_zone VARCHAR,
training_status VARCHAR,
transition_team_lead VARCHAR,
wfm_absence_description VARCHAR,
wfm_approval_date DATE,
wfm_approval_status VARCHAR,
regions_supporting VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
preferred_name,
);

alter table INEO_ACTIVE_TIME_OFF_REQUESTS_HISTORY add primary key (active_timeoff_req_history_id);

DROP TABLE IF EXISTS INEO_ACTIVE_TIME_OFF_REQUESTS;
CREATE TABLE INEO_ACTIVE_TIME_OFF_REQUESTS
(active_timeoff_request_id VARCHAR,
 absence_date DATE,
absence_description VARCHAR,
absence_end_time  VARCHAR,
absence_start_time  VARCHAR,
absence_type  VARCHAR,
archive_error  VARCHAR,
arrival_time  VARCHAR,
departure_time  VARCHAR,
employee_id  VARCHAR,
employee_name  VARCHAR,
employee_status  VARCHAR,
employee_type  VARCHAR,
filename  VARCHAR,
latest_comment VARCHAR,
manager VARCHAR,
maximus_email VARCHAR,
month_number NUMBER,
month_name VARCHAR,
operations_approval_date DATE,
operations_approval_status VARCHAR,
position_title VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
submission_comments VARCHAR,
submission_date DATE,
submission_timestamp TIMESTAMP_NTZ(9),
submitted_employee_name VARCHAR,
supervisor VARCHAR,
time_zone VARCHAR,
training_status VARCHAR,
transition_team_lead VARCHAR,
wfm_absence_description VARCHAR,
wfm_approval_date DATE,
wfm_approval_status VARCHAR,
regions_supporting VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
preferred_name);

alter table INEO_ACTIVE_TIME_OFF_REQUESTS add primary key (active_timeoff_request_id);

create or replace sequence seq_training_newhire_tracker_history_id;

DROP TABLE IF EXISTS INEO_TRAINING_NEWHIRE_CLASS_TRACKER_HISTORY;
CREATE TABLE INEO_TRAINING_NEWHIRE_CLASS_TRACKER_HISTORY(
training_newhire_tracker_history_id NUMBER NOT NULL DEFAULT seq_training_newhire_tracker_history_id.nextval,
training_newhire_tracker_id VARCHAR,
actual_attendees NUMBER,
attrition_rate_to_date FLOAT,
block_1_average_attempts FLOAT,
block_1_class_average FLOAT,
block_2_average_attempts FLOAT,
block_2_class_average FLOAT,
block_3_average_attempts FLOAT,
block_3_class_average FLOAT,
block_4_average_attempts FLOAT,
block_4_class_average FLOAT,
block_5_a_average_attempts FLOAT,
block_5_a_class_average FLOAT,
block_5_b_average_attempts FLOAT,
block_5_b_class_average FLOAT,
block_6_7_average_attempts FLOAT,
block_6_7_class_average FLOAT,
conduent_trainer VARCHAR,
expected_attendees NUMBER,
filename VARCHAR,
maximus_co_facilitator VARCHAR,
maximus_facilitator VARCHAR,
nesting_end_date DATE,
nesting_start_date DATE,
region VARCHAR,
training_class_id VARCHAR,
training_end_date DATE,
training_start_date DATE,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

alter table INEO_TRAINING_NEWHIRE_CLASS_TRACKER_HISTORY add primary key (training_newhire_tracker_history_id);

DROP TABLE IF EXISTS INEO_TRAINING_NEWHIRE_CLASS_TRACKER;
CREATE TABLE INEO_TRAINING_NEWHIRE_CLASS_TRACKER(
training_newhire_tracker_id VARCHAR,
actual_attendees NUMBER,
attrition_rate_to_date FLOAT,
block_1_average_attempts FLOAT,
block_1_class_average FLOAT,
block_2_average_attempts FLOAT,
block_2_class_average FLOAT,
block_3_average_attempts FLOAT,
block_3_class_average FLOAT,
block_4_average_attempts FLOAT,
block_4_class_average FLOAT,
block_5_a_average_attempts FLOAT,
block_5_a_class_average FLOAT,
block_5_b_average_attempts FLOAT,
block_5_b_class_average FLOAT,
block_6_7_average_attempts FLOAT,
block_6_7_class_average FLOAT,
conduent_trainer VARCHAR,
expected_attendees NUMBER,
filename VARCHAR,
maximus_co_facilitator VARCHAR,
maximus_facilitator VARCHAR,
nesting_end_date DATE,
nesting_start_date DATE,
region VARCHAR,
training_class_id VARCHAR,
training_end_date DATE,
training_start_date DATE,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

alter table INEO_TRAINING_NEWHIRE_CLASS_TRACKER add primary key (training_newhire_tracker_id);

create or replace sequence seq_training_newhire_exam_history_id;

DROP TABLE IF EXISTS INEO_ACTIVE_TRAINING_NEWHIRE_EXAM_TRACKER_HISTORY;
CREATE TABLE INEO_ACTIVE_TRAINING_NEWHIRE_EXAM_TRACKER_HISTORY(
training_newhire_exam_history_id NUMBER NOT NULL DEFAULT seq_training_newhire_exam_history_id.nextval,
training_newhire_exam_id VARCHAR,
block_1_attempt_1 FLOAT,
block_1_attempt_2 FLOAT,
block_1_attempt_3 FLOAT,
block_1_average FLOAT,
block_1_count_of_attempts FLOAT,
block_2_attempt_1 FLOAT,
block_2_attempt_2 FLOAT,
block_2_attempt_3 FLOAT,
block_2_average FLOAT,
block_2_count_of_attempts FLOAT,
block_3_attempt_1 FLOAT,
block_3_attempt_2 FLOAT,
block_3_attempt_3 FLOAT,
block_3_average FLOAT,
block_3_count_of_attempts FLOAT,
block_4_attempt_1 FLOAT,
block_4_attempt_2 FLOAT,
block_4_attempt_3 FLOAT,
block_4_average FLOAT,
block_4_count_of_attempts FLOAT,
block_5_a_attempt_1 FLOAT,
block_5_a_attempt_2 FLOAT,
block_5_a_attempt_3 FLOAT,
block_5_a_average FLOAT,
block_5_a_count_of_attempts FLOAT,
block_5_b_attempt_1 FLOAT,
block_5_b_attempt_2 FLOAT,
block_5_b_attempt_3 FLOAT,
block_5_b_average FLOAT,
block_5_b_count_of_attempts FLOAT,
block_6_7_attempt_1 FLOAT,
block_6_7_attempt_2 FLOAT,
block_6_7_attempt_3 FLOAT,
block_6_7_average FLOAT,
block_6_7_count_of_attempts FLOAT,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
exam_average FLOAT,
filename VARCHAR,
region VARCHAR,
training_class_id VARCHAR,
training_end_date DATE,
training_start_date DATE,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

alter table INEO_ACTIVE_TRAINING_NEWHIRE_EXAM_TRACKER_HISTORY add primary key (training_newhire_exam_history_id);

DROP TABLE IF EXISTS INEO_ACTIVE_TRAINING_NEWHIRE_EXAM_TRACKER;
CREATE TABLE INEO_ACTIVE_TRAINING_NEWHIRE_EXAM_TRACKER(
training_newhire_exam_id VARCHAR,
block_1_attempt_1 FLOAT,
block_1_attempt_2 FLOAT,
block_1_attempt_3 FLOAT,
block_1_average FLOAT,
block_1_count_of_attempts FLOAT,
block_2_attempt_1 FLOAT,
block_2_attempt_2 FLOAT,
block_2_attempt_3 FLOAT,
block_2_average FLOAT,
block_2_count_of_attempts FLOAT,
block_3_attempt_1 FLOAT,
block_3_attempt_2 FLOAT,
block_3_attempt_3 FLOAT,
block_3_average FLOAT,
block_3_count_of_attempts FLOAT,
block_4_attempt_1 FLOAT,
block_4_attempt_2 FLOAT,
block_4_attempt_3 FLOAT,
block_4_average FLOAT,
block_4_count_of_attempts FLOAT,
block_5_a_attempt_1 FLOAT,
block_5_a_attempt_2 FLOAT,
block_5_a_attempt_3 FLOAT,
block_5_a_average FLOAT,
block_5_a_count_of_attempts FLOAT,
block_5_b_attempt_1 FLOAT,
block_5_b_attempt_2 FLOAT,
block_5_b_attempt_3 FLOAT,
block_5_b_average FLOAT,
block_5_b_count_of_attempts FLOAT,
block_6_7_attempt_1 FLOAT,
block_6_7_attempt_2 FLOAT,
block_6_7_attempt_3 FLOAT,
block_6_7_average FLOAT,
block_6_7_count_of_attempts FLOAT,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
exam_average FLOAT,
filename VARCHAR,
region VARCHAR,
training_class_id VARCHAR,
training_end_date DATE,
training_start_date DATE,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

alter table INEO_ACTIVE_TRAINING_NEWHIRE_EXAM_TRACKER add primary key (training_newhire_exam_id);

create or replace sequence seq_active_trn_staff_roster_history_id;

DROP TABLE IF EXISTS INEO_ACTIVE_TRAINING_STAFF_ROSTER_HISTORY;
CREATE TABLE INEO_ACTIVE_TRAINING_STAFF_ROSTER_HISTORY(
active_trn_staff_roster_history_id NUMBER NOT NULL DEFAULT seq_active_trn_staff_roster_history_id.nextval,
active_training_staff_roster_id VARCHAR,
average_cpc_training_exam_score FLOAT, 
conduent_trainer VARCHAR,
department VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
filename VARCHAR,
manager VARCHAR,
maximus_co_facilitator VARCHAR,
maximus_email VARCHAR,
maximus_facilitator VARCHAR,
nesting_end_date DATE,
nesting_start_date DATE,
personal_email VARCHAR,
position_title VARCHAR,
previous_stateconduent_employee VARCHAR,
psid_form_submission VARCHAR,
region VARCHAR,
send_welcome_email VARCHAR,
staffing_agency VARCHAR,
time_zone VARCHAR,
training_class_id VARCHAR,
training_end_date DATE,
training_hours_missed FLOAT,
training_start_date DATE,
training_status VARCHAR,
transition_team_lead VARCHAR,
fssa_email VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
preferred_name);

alter table INEO_ACTIVE_TRAINING_STAFF_ROSTER_HISTORY add primary key (active_trn_staff_roster_history_id);

DROP TABLE IF EXISTS INEO_ACTIVE_TRAINING_STAFF_ROSTER;
CREATE TABLE INEO_ACTIVE_TRAINING_STAFF_ROSTER(
active_training_staff_roster_id VARCHAR,
average_cpc_training_exam_score FLOAT, 
conduent_trainer VARCHAR,
department VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
filename VARCHAR,
manager VARCHAR,
maximus_co_facilitator VARCHAR,
maximus_email VARCHAR,
maximus_facilitator VARCHAR,
nesting_end_date DATE,
nesting_start_date DATE,
personal_email VARCHAR,
position_title VARCHAR,
previous_stateconduent_employee VARCHAR,
psid_form_submission VARCHAR,
region VARCHAR,
send_welcome_email VARCHAR,
staffing_agency VARCHAR,
time_zone VARCHAR,
training_class_id VARCHAR,
training_end_date DATE,
training_hours_missed FLOAT,
training_start_date DATE,
training_status VARCHAR,
transition_team_lead VARCHAR,
fssa_email VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
preferred_name);

alter table INEO_ACTIVE_TRAINING_STAFF_ROSTER add primary key (active_training_staff_roster_id);

create or replace sequence seq_active_training_unsched_history_id;

DROP TABLE IF EXISTS ineo_active_training_unsched_absences_history;
CREATE TABLE ineo_active_training_unsched_absences_history
(active_training_unsched_history_id NUMBER NOT NULL DEFAULT seq_active_training_unsched_history_id.nextval ,
active_training_unsched_absence_id VARCHAR,
absence_date DATE,
absence_description VARCHAR,
absence_end_time VARCHAR,
absence_start_time VARCHAR,
absence_type VARCHAR,
archive_error VARCHAR,
arrival_time VARCHAR,
departure_time VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
employee_type VARCHAR,
filename VARCHAR, 
manager VARCHAR,
maximus_email VARCHAR,
position_title VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
submission_comments VARCHAR,
submission_date DATE,
submission_timestamp TIMESTAMP_NTZ(9),
submitted_employee_name  VARCHAR,
supervisor VARCHAR,
time_zone  VARCHAR,
training_class_id  VARCHAR,
training_end_date DATE,
training_start_date DATE,
training_status VARCHAR,
transition_team_lead VARCHAR,
wfm_absence_description  VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
preferred_name);

alter table ineo_active_training_unsched_absences_history add primary key (active_training_unsched_history_id);

DROP TABLE IF EXISTS ineo_active_training_unsched_absences;
CREATE TABLE ineo_active_training_unsched_absences
(active_training_unsched_absence_id VARCHAR,
absence_date DATE,
absence_description VARCHAR,
absence_end_time VARCHAR,
absence_start_time VARCHAR,
absence_type VARCHAR,
archive_error VARCHAR,
arrival_time VARCHAR,
departure_time VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
employee_type VARCHAR,
filename VARCHAR, 
manager VARCHAR,
maximus_email VARCHAR,
position_title VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
submission_comments VARCHAR,
submission_date DATE,
submission_timestamp TIMESTAMP_NTZ(9),
submitted_employee_name  VARCHAR,
supervisor VARCHAR,
time_zone  VARCHAR,
training_class_id  VARCHAR,
training_end_date DATE,
training_start_date DATE,
training_status VARCHAR,
transition_team_lead VARCHAR,
wfm_absence_description  VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
preferred_name);

alter table ineo_active_training_unsched_absences add primary key (active_training_unsched_absence_id);

create or replace sequence seq_active_wfm_trn_form_submission_history_id;

DROP TABLE IF EXISTS ineo_active_wfm_training_form_submissions_history;
CREATE TABLE ineo_active_wfm_training_form_submissions_history
(active_wfm_trn_form_submission_history_id NUMBER NOT NULL DEFAULT seq_active_wfm_trn_form_submission_history_id.nextval ,
active_wfm_training_form_submission_id VARCHAR,
absence_type  VARCHAR,
comments VARCHAR,
date_of_absence DATE,
delete_record VARCHAR,
emailed_submitted_form_for_absence VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
filename VARCHAR,
hours_missed FLOAT,
position_title VARCHAR,
reason_for_absence VARCHAR,
region VARCHAR,
submitted_employee_name VARCHAR,
training_class_id VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

alter table ineo_active_wfm_training_form_submissions_history add primary key (active_wfm_trn_form_submission_history_id);

--no need to deploy this in prod since there is nothing on the record for WFM_TRAINING_FORM_SUBMISSIONS_ACTIVE file that could make it unique
DROP TABLE IF EXISTS ineo_active_wfm_training_form_submissions;
CREATE TABLE ineo_active_wfm_training_form_submissions
(active_wfm_training_form_submission_id VARCHAR,
absence_type  VARCHAR,
comments VARCHAR,
date_of_absence DATE,
delete_record VARCHAR,
emailed_submitted_form_for_absence VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
filename VARCHAR,
hours_missed FLOAT,
position_title VARCHAR,
reason_for_absence VARCHAR,
region VARCHAR,
submitted_employee_name VARCHAR,
training_class_id VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

alter table ineo_active_wfm_training_form_submissions add primary key (active_wfm_training_form_submission_id);