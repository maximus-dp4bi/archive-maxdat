
create or replace sequence seq_active_pnr_coms_log_id;

DROP TABLE IF EXISTS ineo_active_pioneer_team_coms_log_history;
CREATE TABLE ineo_active_pioneer_team_coms_log_history
(active_pnr_coms_log_id NUMBER NOT NULL DEFAULT seq_active_pnr_coms_log_id.nextval ,
added_by VARCHAR,
communication_content_and_summary VARCHAR,
date DATE,
employee_id VARCHAR,
evaluation_score FLOAT,
filename VARCHAR,
first_last_name VARCHAR,
initial_or_follow_up VARCHAR,
reports_to VARCHAR,
topic VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

alter table ineo_active_pioneer_team_coms_log_history add primary key (active_pnr_coms_log_id);

--no need to deploy this in prod since there is nothing on the record for PIONEER_TEAM_COMS_LOG_ACTIVE file that could make it unique
/*DROP TABLE IF EXISTS ineo_active_pioneer_team_coms_log;
CREATE TABLE ineo_active_pioneer_team_coms_log
(added_by VARCHAR,
communication_content_and_summary VARCHAR,
date DATE,
employee_id VARCHAR,
evaluation_score FLOAT,
filename VARCHAR,
first_last_name VARCHAR,
initial_or_follow_up VARCHAR,
reports_to VARCHAR,
topic VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());
--alter table ineo_active_pioneer_team_coms_log add primary key (active_unsched_absence_id);*/

create or replace sequence seq_archive_pnr_coms_log_id;

DROP TABLE IF EXISTS ineo_archive_pioneer_team_coms_log_history;
CREATE TABLE ineo_archive_pioneer_team_coms_log_history
(archive_pnr_coms_log_id NUMBER NOT NULL DEFAULT seq_archive_pnr_coms_log_id.nextval ,
added_by VARCHAR,
communication_content_and_summary VARCHAR,
date DATE,
employee_id VARCHAR,
evaluation_score FLOAT,
filename VARCHAR,
first_last_name VARCHAR,
initial_or_follow_up VARCHAR,
reports_to VARCHAR,
topic VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

alter table ineo_archive_pioneer_team_coms_log_history add primary key (archive_pnr_coms_log_id);

--no need to deploy this in prod since there is nothing on the record for PIONEER_TEAM_COMS_LOG_ACTIVE file that could make it unique
/*DROP TABLE IF EXISTS ineo_archive_pioneer_team_coms_log;
CREATE TABLE ineo_archive_pioneer_team_coms_log
(added_by VARCHAR,
communication_content_and_summary VARCHAR,
date DATE,
employee_id VARCHAR,
evaluation_score FLOAT,
filename VARCHAR,
first_last_name VARCHAR,
initial_or_follow_up VARCHAR,
reports_to VARCHAR,
topic VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());
--alter table ineo_archive_pioneer_team_coms_log add primary key (active_unsched_absence_id);*/

create or replace sequence seq_pioneer_staff_roster_id;

DROP TABLE IF EXISTS ineo_pioneer_team_staff_roster_history;
CREATE TABLE ineo_pioneer_team_staff_roster_history
(pioneer_staff_roster_id NUMBER NOT NULL DEFAULT seq_pioneer_staff_roster_id.nextval ,
agency_hire_date DATE,
department VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
hr_specialist VARCHAR,
manager VARCHAR,
maximus_email VARCHAR,
position_title VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
region VARCHAR,
regions_supporting VARCHAR,
sr_operations_manager VARCHAR,
supervisor VARCHAR,
term_date DATE,
training_status VARCHAR,
work_order_end_date DATE,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
preferred_name);

alter table ineo_pioneer_team_staff_roster_history add primary key (pioneer_staff_roster_id);

DROP TABLE IF EXISTS ineo_pioneer_team_staff_roster;
CREATE TABLE ineo_pioneer_team_staff_roster
(agency_hire_date DATE,
department VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
hr_specialist VARCHAR,
manager VARCHAR,
maximus_email VARCHAR,
position_title VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
region VARCHAR,
regions_supporting VARCHAR,
sr_operations_manager VARCHAR,
supervisor VARCHAR,
term_date DATE,
training_status VARCHAR,
work_order_end_date DATE,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
preferred_name);

alter table ineo_pioneer_team_staff_roster add primary key (employee_id);

create or replace sequence seq_active_qa_app_scorecard_id;

DROP TABLE IF EXISTS ineo_active_quality_app_scorecard_history;
CREATE TABLE ineo_active_quality_app_scorecard_history(
active_qa_app_scorecard_id NUMBER NOT NULL DEFAULT seq_active_qa_app_scorecard_id.nextval ,
ap_1_comments VARCHAR,
ap_10_comments VARCHAR,
ap_10a VARCHAR,
ap_11_comments VARCHAR,
ap_11a VARCHAR,
ap_11b VARCHAR,
ap_11c VARCHAR,
ap_12_comments VARCHAR,
ap_12a VARCHAR,
ap_13_comments VARCHAR,
ap_13a VARCHAR,
ap_14_comments VARCHAR,
ap_14a VARCHAR,
ap_15_comments VARCHAR,
ap_15a VARCHAR,
ap_15b VARCHAR,
ap_16_comments VARCHAR,
ap_16a VARCHAR,
ap_16b VARCHAR,
ap_17_comments VARCHAR,
ap_17a VARCHAR,
ap_17b VARCHAR,
ap_18_comments VARCHAR,
ap_18a VARCHAR,
ap_18b VARCHAR,
ap_19_comments VARCHAR,
ap_19a VARCHAR,
ap_1a VARCHAR,
ap_1b VARCHAR,
ap_2_comments VARCHAR,
ap_20_comments VARCHAR,
ap_20a VARCHAR,
ap_20b VARCHAR,
ap_20c VARCHAR,
ap_20d VARCHAR,
ap_20e VARCHAR,
ap_20f VARCHAR,
ap_2a VARCHAR,
ap_2b VARCHAR,
ap_2c VARCHAR,
ap_2d VARCHAR,
ap_2e VARCHAR,
ap_2f VARCHAR,
ap_3_comments VARCHAR,
ap_3a VARCHAR,
ap_3b VARCHAR,
ap_3c VARCHAR,
ap_3d VARCHAR,
ap_3e VARCHAR,
ap_3f VARCHAR,
ap_4_comments VARCHAR,
ap_4a VARCHAR,
ap_4b VARCHAR,
ap_4c VARCHAR,
ap_4d VARCHAR,
ap_4e VARCHAR,
ap_4f VARCHAR,
ap_4g VARCHAR,
ap_4h VARCHAR,
ap_4i VARCHAR,
ap_4j VARCHAR,
ap_5_comments VARCHAR,
ap_5a VARCHAR,
ap_5b VARCHAR,
ap_5c VARCHAR,
ap_5d VARCHAR,
ap_5e VARCHAR,
ap_5f VARCHAR,
ap_5g VARCHAR,
ap_5h VARCHAR,
ap_5i VARCHAR,
ap_6_comments VARCHAR,
ap_6a VARCHAR,
ap_6b VARCHAR,
ap_7_comments VARCHAR,
ap_7a VARCHAR,
ap_7b VARCHAR,
ap_7c VARCHAR,
ap_7d VARCHAR,
ap_7e VARCHAR,
ap_7f VARCHAR,
ap_7g VARCHAR,
ap_7h VARCHAR,
ap_7i VARCHAR,
ap_8_comments VARCHAR,
ap_8a VARCHAR,
ap_8b VARCHAR,
ap_8c VARCHAR,
ap_8d VARCHAR,
ap_8e VARCHAR,
ap_8f VARCHAR,
ap_8g VARCHAR,
ap_8h VARCHAR,
ap_9_comments VARCHAR,
ap_9a VARCHAR,
ap_9b VARCHAR,
ap_9c VARCHAR,
ap_9d VARCHAR,
ap_9e VARCHAR,
ap_9f VARCHAR,
ap_9g VARCHAR,
ap_9h VARCHAR,
ap_9i VARCHAR,
autonumber VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
manager VARCHAR,
maximus_email VARCHAR,
overall_comments VARCHAR,
position_title VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
record_id VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
regions_supporting VARCHAR,
score FLOAT,
send_to_trash VARCHAR,
status VARCHAR,
submitted_employee_name VARCHAR,
supervisor VARCHAR,
task_sequence_number VARCHAR,
time_zone VARCHAR,
training_status VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp()
);

alter table ineo_active_quality_app_scorecard_history add primary key (active_qa_app_scorecard_id);

DROP TABLE IF EXISTS ineo_active_quality_app_scorecard;
CREATE TABLE ineo_active_quality_app_scorecard(
ap_1_comments VARCHAR,
ap_10_comments VARCHAR,
ap_10a VARCHAR,
ap_11_comments VARCHAR,
ap_11a VARCHAR,
ap_11b VARCHAR,
ap_11c VARCHAR,
ap_12_comments VARCHAR,
ap_12a VARCHAR,
ap_13_comments VARCHAR,
ap_13a VARCHAR,
ap_14_comments VARCHAR,
ap_14a VARCHAR,
ap_15_comments VARCHAR,
ap_15a VARCHAR,
ap_15b VARCHAR,
ap_16_comments VARCHAR,
ap_16a VARCHAR,
ap_16b VARCHAR,
ap_17_comments VARCHAR,
ap_17a VARCHAR,
ap_17b VARCHAR,
ap_18_comments VARCHAR,
ap_18a VARCHAR,
ap_18b VARCHAR,
ap_19_comments VARCHAR,
ap_19a VARCHAR,
ap_1a VARCHAR,
ap_1b VARCHAR,
ap_2_comments VARCHAR,
ap_20_comments VARCHAR,
ap_20a VARCHAR,
ap_20b VARCHAR,
ap_20c VARCHAR,
ap_20d VARCHAR,
ap_20e VARCHAR,
ap_20f VARCHAR,
ap_2a VARCHAR,
ap_2b VARCHAR,
ap_2c VARCHAR,
ap_2d VARCHAR,
ap_2e VARCHAR,
ap_2f VARCHAR,
ap_3_comments VARCHAR,
ap_3a VARCHAR,
ap_3b VARCHAR,
ap_3c VARCHAR,
ap_3d VARCHAR,
ap_3e VARCHAR,
ap_3f VARCHAR,
ap_4_comments VARCHAR,
ap_4a VARCHAR,
ap_4b VARCHAR,
ap_4c VARCHAR,
ap_4d VARCHAR,
ap_4e VARCHAR,
ap_4f VARCHAR,
ap_4g VARCHAR,
ap_4h VARCHAR,
ap_4i VARCHAR,
ap_4j VARCHAR,
ap_5_comments VARCHAR,
ap_5a VARCHAR,
ap_5b VARCHAR,
ap_5c VARCHAR,
ap_5d VARCHAR,
ap_5e VARCHAR,
ap_5f VARCHAR,
ap_5g VARCHAR,
ap_5h VARCHAR,
ap_5i VARCHAR,
ap_6_comments VARCHAR,
ap_6a VARCHAR,
ap_6b VARCHAR,
ap_7_comments VARCHAR,
ap_7a VARCHAR,
ap_7b VARCHAR,
ap_7c VARCHAR,
ap_7d VARCHAR,
ap_7e VARCHAR,
ap_7f VARCHAR,
ap_7g VARCHAR,
ap_7h VARCHAR,
ap_7i VARCHAR,
ap_8_comments VARCHAR,
ap_8a VARCHAR,
ap_8b VARCHAR,
ap_8c VARCHAR,
ap_8d VARCHAR,
ap_8e VARCHAR,
ap_8f VARCHAR,
ap_8g VARCHAR,
ap_8h VARCHAR,
ap_9_comments VARCHAR,
ap_9a VARCHAR,
ap_9b VARCHAR,
ap_9c VARCHAR,
ap_9d VARCHAR,
ap_9e VARCHAR,
ap_9f VARCHAR,
ap_9g VARCHAR,
ap_9h VARCHAR,
ap_9i VARCHAR,
autonumber VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
manager VARCHAR,
maximus_email VARCHAR,
overall_comments VARCHAR,
position_title VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
record_id VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
regions_supporting VARCHAR,
score FLOAT,
send_to_trash VARCHAR,
status VARCHAR,
submitted_employee_name VARCHAR,
supervisor VARCHAR,
task_sequence_number VARCHAR,
time_zone VARCHAR,
training_status VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp()
);

alter table ineo_active_quality_app_scorecard add primary key (record_id);

create or replace sequence seq_active_qa_change_scorecard_id;

DROP TABLE IF EXISTS ineo_active_quality_change_scorecard_history;
CREATE TABLE ineo_active_quality_change_scorecard_history(
active_qa_change_scorecard_id NUMBER NOT NULL DEFAULT seq_active_qa_change_scorecard_id.nextval ,
autonumber VARCHAR,
cp_10a VARCHAR,
cp_10b VARCHAR,
cp_10c VARCHAR,
cp_10comments VARCHAR,
cp_10d VARCHAR,
cp_10e VARCHAR,
cp_10f VARCHAR,
cp_10g VARCHAR,
cp_10h VARCHAR,
cp_10i VARCHAR,
cp_11a VARCHAR,
cp_11b VARCHAR,
cp_11c VARCHAR,
cp_11comments VARCHAR,
cp_11d VARCHAR,
cp_11e VARCHAR,
cp_11f VARCHAR,
cp_11g VARCHAR,
cp_11h VARCHAR,
cp_12a VARCHAR,
cp_12b VARCHAR,
cp_12c VARCHAR,
cp_12comments VARCHAR,
cp_12d VARCHAR,
cp_12e VARCHAR,
cp_12f VARCHAR,
cp_12g VARCHAR,
cp_12h VARCHAR,
cp_12i VARCHAR,
cp_13a VARCHAR,
cp_13comments VARCHAR,
cp_14a VARCHAR,
cp_14comments VARCHAR,
cp_15a VARCHAR,
cp_15b VARCHAR,
cp_15c VARCHAR,
cp_15comments VARCHAR,
cp_16a VARCHAR,
cp_16b VARCHAR,
cp_16comments VARCHAR,
cp_17a VARCHAR,
cp_17b VARCHAR,
cp_17c VARCHAR,
cp_17comments VARCHAR,
cp_17d VARCHAR,
cp_17e VARCHAR,
cp_17f VARCHAR,
cp_18a VARCHAR,
cp_18comments VARCHAR,
cp_19a VARCHAR,
cp_19comments VARCHAR,
cp_1a VARCHAR,
cp_1b VARCHAR,
cp_1c VARCHAR,
cp_1comments VARCHAR,
cp_1d VARCHAR,
cp_1e VARCHAR,
cp_1f VARCHAR,
cp_1g VARCHAR,
cp_1h VARCHAR,
cp_1i VARCHAR,
cp_1j VARCHAR,
cp_20a VARCHAR,
cp_20b VARCHAR,
cp_20comments VARCHAR,
cp_21a VARCHAR,
cp_21b VARCHAR,
cp_21comments VARCHAR,
cp_22a VARCHAR,
cp_22comments VARCHAR,
cp_23a VARCHAR,
cp_23comments VARCHAR,
cp_24a VARCHAR,
cp_24comments VARCHAR,
cp_25a VARCHAR,
cp_25comments VARCHAR,
cp_26a VARCHAR,
cp_26b VARCHAR,
cp_26comments VARCHAR,
cp_27a VARCHAR,
cp_27b VARCHAR,
cp_27c VARCHAR,
cp_27comments VARCHAR,
cp_28a VARCHAR,
cp_28comments VARCHAR,
cp_29a VARCHAR,
cp_29b VARCHAR,
cp_29c VARCHAR,
cp_29comments VARCHAR,
cp_29d VARCHAR,
cp_29e VARCHAR,
cp_29f VARCHAR,
cp_2a VARCHAR,
cp_2b VARCHAR,
cp_2comments VARCHAR,
cp_3a VARCHAR,
cp_3b VARCHAR,
cp_3c VARCHAR,
cp_3comments VARCHAR,
cp_3d VARCHAR,
cp_3e VARCHAR,
cp_3f VARCHAR,
cp_4a VARCHAR,
cp_4b VARCHAR,
cp_4c VARCHAR,
cp_4comments VARCHAR,
cp_4d VARCHAR,
cp_4e VARCHAR,
cp_4f VARCHAR,
cp_5a VARCHAR,
cp_5b VARCHAR,
cp_5c VARCHAR,
cp_5comments VARCHAR,
cp_5d VARCHAR,
cp_5e VARCHAR,
cp_5f VARCHAR,
cp_5g VARCHAR,
cp_5h VARCHAR,
cp_5i VARCHAR,
cp_5j VARCHAR,
cp_5k VARCHAR,
cp_5l VARCHAR,
cp_6a VARCHAR,
cp_6b VARCHAR,
cp_6c VARCHAR,
cp_6comments VARCHAR,
cp_6d VARCHAR,
cp_7a VARCHAR,
cp_7b VARCHAR,
cp_7c VARCHAR,
cp_7comments VARCHAR,
cp_7d VARCHAR,
cp_7e VARCHAR,
cp_7f VARCHAR,
cp_7g VARCHAR,
cp_7h VARCHAR,
cp_7i VARCHAR,
cp_8a VARCHAR,
cp_8b VARCHAR,
cp_8c VARCHAR,
cp_8comments VARCHAR,
cp_9a VARCHAR,
cp_9b VARCHAR,
cp_9c VARCHAR,
cp_9comments VARCHAR,
cp_9d VARCHAR,
cp_9e VARCHAR,
cp_9f VARCHAR,
cp_9g VARCHAR,
cp_9h VARCHAR,
cp_9i VARCHAR,
cp_9j VARCHAR,
cp_9k VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
manager VARCHAR,
maximus_email VARCHAR,
overall_comments VARCHAR,
position_title VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
record_id VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
regions_supporting VARCHAR,
score FLOAT,
send_to_trash VARCHAR,
status VARCHAR,
submitted_employee_name VARCHAR,
supervisor VARCHAR,
task_sequence_number VARCHAR,
time_zone VARCHAR,
training_status VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp()
);

alter table ineo_active_quality_change_scorecard_history add primary key (active_qa_change_scorecard_id);

DROP TABLE IF EXISTS ineo_active_quality_change_scorecard;
CREATE TABLE ineo_active_quality_change_scorecard(
autonumber VARCHAR,
cp_10a VARCHAR,
cp_10b VARCHAR,
cp_10c VARCHAR,
cp_10comments VARCHAR,
cp_10d VARCHAR,
cp_10e VARCHAR,
cp_10f VARCHAR,
cp_10g VARCHAR,
cp_10h VARCHAR,
cp_10i VARCHAR,
cp_11a VARCHAR,
cp_11b VARCHAR,
cp_11c VARCHAR,
cp_11comments VARCHAR,
cp_11d VARCHAR,
cp_11e VARCHAR,
cp_11f VARCHAR,
cp_11g VARCHAR,
cp_11h VARCHAR,
cp_12a VARCHAR,
cp_12b VARCHAR,
cp_12c VARCHAR,
cp_12comments VARCHAR,
cp_12d VARCHAR,
cp_12e VARCHAR,
cp_12f VARCHAR,
cp_12g VARCHAR,
cp_12h VARCHAR,
cp_12i VARCHAR,
cp_13a VARCHAR,
cp_13comments VARCHAR,
cp_14a VARCHAR,
cp_14comments VARCHAR,
cp_15a VARCHAR,
cp_15b VARCHAR,
cp_15c VARCHAR,
cp_15comments VARCHAR,
cp_16a VARCHAR,
cp_16b VARCHAR,
cp_16comments VARCHAR,
cp_17a VARCHAR,
cp_17b VARCHAR,
cp_17c VARCHAR,
cp_17comments VARCHAR,
cp_17d VARCHAR,
cp_17e VARCHAR,
cp_17f VARCHAR,
cp_18a VARCHAR,
cp_18comments VARCHAR,
cp_19a VARCHAR,
cp_19comments VARCHAR,
cp_1a VARCHAR,
cp_1b VARCHAR,
cp_1c VARCHAR,
cp_1comments VARCHAR,
cp_1d VARCHAR,
cp_1e VARCHAR,
cp_1f VARCHAR,
cp_1g VARCHAR,
cp_1h VARCHAR,
cp_1i VARCHAR,
cp_1j VARCHAR,
cp_20a VARCHAR,
cp_20b VARCHAR,
cp_20comments VARCHAR,
cp_21a VARCHAR,
cp_21b VARCHAR,
cp_21comments VARCHAR,
cp_22a VARCHAR,
cp_22comments VARCHAR,
cp_23a VARCHAR,
cp_23comments VARCHAR,
cp_24a VARCHAR,
cp_24comments VARCHAR,
cp_25a VARCHAR,
cp_25comments VARCHAR,
cp_26a VARCHAR,
cp_26b VARCHAR,
cp_26comments VARCHAR,
cp_27a VARCHAR,
cp_27b VARCHAR,
cp_27c VARCHAR,
cp_27comments VARCHAR,
cp_28a VARCHAR,
cp_28comments VARCHAR,
cp_29a VARCHAR,
cp_29b VARCHAR,
cp_29c VARCHAR,
cp_29comments VARCHAR,
cp_29d VARCHAR,
cp_29e VARCHAR,
cp_29f VARCHAR,
cp_2a VARCHAR,
cp_2b VARCHAR,
cp_2comments VARCHAR,
cp_3a VARCHAR,
cp_3b VARCHAR,
cp_3c VARCHAR,
cp_3comments VARCHAR,
cp_3d VARCHAR,
cp_3e VARCHAR,
cp_3f VARCHAR,
cp_4a VARCHAR,
cp_4b VARCHAR,
cp_4c VARCHAR,
cp_4comments VARCHAR,
cp_4d VARCHAR,
cp_4e VARCHAR,
cp_4f VARCHAR,
cp_5a VARCHAR,
cp_5b VARCHAR,
cp_5c VARCHAR,
cp_5comments VARCHAR,
cp_5d VARCHAR,
cp_5e VARCHAR,
cp_5f VARCHAR,
cp_5g VARCHAR,
cp_5h VARCHAR,
cp_5i VARCHAR,
cp_5j VARCHAR,
cp_5k VARCHAR,
cp_5l VARCHAR,
cp_6a VARCHAR,
cp_6b VARCHAR,
cp_6c VARCHAR,
cp_6comments VARCHAR,
cp_6d VARCHAR,
cp_7a VARCHAR,
cp_7b VARCHAR,
cp_7c VARCHAR,
cp_7comments VARCHAR,
cp_7d VARCHAR,
cp_7e VARCHAR,
cp_7f VARCHAR,
cp_7g VARCHAR,
cp_7h VARCHAR,
cp_7i VARCHAR,
cp_8a VARCHAR,
cp_8b VARCHAR,
cp_8c VARCHAR,
cp_8comments VARCHAR,
cp_9a VARCHAR,
cp_9b VARCHAR,
cp_9c VARCHAR,
cp_9comments VARCHAR,
cp_9d VARCHAR,
cp_9e VARCHAR,
cp_9f VARCHAR,
cp_9g VARCHAR,
cp_9h VARCHAR,
cp_9i VARCHAR,
cp_9j VARCHAR,
cp_9k VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
manager VARCHAR,
maximus_email VARCHAR,
overall_comments VARCHAR,
position_title VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
record_id VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
regions_supporting VARCHAR,
score FLOAT,
send_to_trash VARCHAR,
status VARCHAR,
submitted_employee_name VARCHAR,
supervisor VARCHAR,
task_sequence_number VARCHAR,
time_zone VARCHAR,
training_status VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp()
);

alter table ineo_active_quality_change_scorecard add primary key (record_id);

create or replace sequence seq_active_qa_redets_scorecard_id;

DROP TABLE IF EXISTS ineo_active_quality_redets_scorecard_history;
CREATE TABLE ineo_active_quality_redets_scorecard_history(
active_qa_redets_scorecard_id NUMBER NOT NULL DEFAULT seq_active_qa_redets_scorecard_id.nextval ,
autonumber VARCHAR,
created TIMESTAMP_NTZ(9),
created_by VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
latest_comment VARCHAR,
manager VARCHAR,
maximus_email VARCHAR,
move_to_trash VARCHAR,
overall_comments VARCHAR,
position_title VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
rd_1_comments VARCHAR,
rd_10_comments VARCHAR,
rd_10a VARCHAR,
rd_10b VARCHAR,
rd_10c VARCHAR,
rd_10d VARCHAR,
rd_10e VARCHAR,
rd_10f VARCHAR,
rd_10g VARCHAR,
rd_10h VARCHAR,
rd_10i VARCHAR,
rd_11_comments VARCHAR,
rd_11a VARCHAR,
rd_12_comments VARCHAR,
rd_12a VARCHAR,
rd_13_comments VARCHAR,
rd_13a VARCHAR,
rd_13b VARCHAR,
rd_14_comments VARCHAR,
rd_14a VARCHAR,
rd_14b VARCHAR,
rd_14c VARCHAR,
rd_15_comments VARCHAR,
rd_15a VARCHAR,
rd_16_comments VARCHAR,
rd_16a VARCHAR,
rd_17_comments VARCHAR,
rd_17a VARCHAR,
rd_17b VARCHAR,
rd_18_comments VARCHAR,
rd_18a VARCHAR,
rd_18b VARCHAR,
rd_19_comments VARCHAR,
rd_19a VARCHAR,
rd_1a VARCHAR,
rd_1b VARCHAR,
rd_2_comments VARCHAR,
rd_20_comments VARCHAR,
rd_20a VARCHAR,
rd_21_comments VARCHAR,
rd_21a VARCHAR,
rd_21b VARCHAR,
rd_22_comments VARCHAR,
rd_22a VARCHAR,
rd_22b VARCHAR,
rd_23_comments VARCHAR,
rd_23a VARCHAR,
rd_24_comments VARCHAR,
rd_24a VARCHAR,
rd_24b VARCHAR,
rd_24c VARCHAR,
rd_24d VARCHAR,
rd_24e VARCHAR,
rd_24f VARCHAR,
rd_2a VARCHAR,
rd_2b VARCHAR,
rd_3_comments VARCHAR,
rd_3a VARCHAR,
rd_3b VARCHAR,
rd_3c VARCHAR,
rd_3d VARCHAR,
rd_3e VARCHAR,
rd_3f VARCHAR,
rd_4_comments VARCHAR,
rd_4a VARCHAR,
rd_4b VARCHAR,
rd_4c VARCHAR,
rd_4d VARCHAR,
rd_4e VARCHAR,
rd_4f VARCHAR,
rd_4g VARCHAR,
rd_4h VARCHAR,
rd_4i VARCHAR,
rd_4j VARCHAR,
rd_4k VARCHAR,
rd_4l VARCHAR,
rd_5_comments VARCHAR,
rd_5a VARCHAR,
rd_5b VARCHAR,
rd_5c VARCHAR,
rd_5d VARCHAR,
rd_5e VARCHAR,
rd_5f VARCHAR,
rd_5g VARCHAR,
rd_5h VARCHAR,
rd_5i VARCHAR,
rd_6_comments VARCHAR,
rd_6a VARCHAR,
rd_6b VARCHAR,
rd_7_comments VARCHAR,
rd_7a VARCHAR,
rd_7b VARCHAR,
rd_7c VARCHAR,
rd_7d VARCHAR,
rd_7e VARCHAR,
rd_7f VARCHAR,
rd_7g VARCHAR,
rd_7h VARCHAR,
rd_7i VARCHAR,
rd_7j VARCHAR,
rd_7k VARCHAR,
rd_8_comments VARCHAR,
rd_8a VARCHAR,
rd_8b VARCHAR,
rd_8c VARCHAR,
rd_8d VARCHAR,
rd_8e VARCHAR,
rd_8f VARCHAR,
rd_8g VARCHAR,
rd_8h VARCHAR,
rd_8i VARCHAR,
rd_9_comments VARCHAR,
rd_9a VARCHAR,
rd_9b VARCHAR,
rd_9c VARCHAR,
rd_9d VARCHAR,
rd_9e VARCHAR,
rd_9f VARCHAR,
rd_9g VARCHAR,
rd_9h VARCHAR,
record_id VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
regions_supporting VARCHAR,
score FLOAT,
status VARCHAR,
submitted_employee_name VARCHAR,
supervisor VARCHAR,
task_sequence_number VARCHAR,
time_zone VARCHAR,
training_status VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp()
);

alter table ineo_active_quality_redets_scorecard_history add primary key (active_qa_redets_scorecard_id);

DROP TABLE IF EXISTS ineo_active_quality_redets_scorecard;
CREATE TABLE ineo_active_quality_redets_scorecard(
autonumber VARCHAR,
created TIMESTAMP_NTZ(9),
created_by VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
latest_comment VARCHAR,
manager VARCHAR,
maximus_email VARCHAR,
move_to_trash VARCHAR,
overall_comments VARCHAR,
position_title VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
rd_1_comments VARCHAR,
rd_10_comments VARCHAR,
rd_10a VARCHAR,
rd_10b VARCHAR,
rd_10c VARCHAR,
rd_10d VARCHAR,
rd_10e VARCHAR,
rd_10f VARCHAR,
rd_10g VARCHAR,
rd_10h VARCHAR,
rd_10i VARCHAR,
rd_11_comments VARCHAR,
rd_11a VARCHAR,
rd_12_comments VARCHAR,
rd_12a VARCHAR,
rd_13_comments VARCHAR,
rd_13a VARCHAR,
rd_13b VARCHAR,
rd_14_comments VARCHAR,
rd_14a VARCHAR,
rd_14b VARCHAR,
rd_14c VARCHAR,
rd_15_comments VARCHAR,
rd_15a VARCHAR,
rd_16_comments VARCHAR,
rd_16a VARCHAR,
rd_17_comments VARCHAR,
rd_17a VARCHAR,
rd_17b VARCHAR,
rd_18_comments VARCHAR,
rd_18a VARCHAR,
rd_18b VARCHAR,
rd_19_comments VARCHAR,
rd_19a VARCHAR,
rd_1a VARCHAR,
rd_1b VARCHAR,
rd_2_comments VARCHAR,
rd_20_comments VARCHAR,
rd_20a VARCHAR,
rd_21_comments VARCHAR,
rd_21a VARCHAR,
rd_21b VARCHAR,
rd_22_comments VARCHAR,
rd_22a VARCHAR,
rd_22b VARCHAR,
rd_23_comments VARCHAR,
rd_23a VARCHAR,
rd_24_comments VARCHAR,
rd_24a VARCHAR,
rd_24b VARCHAR,
rd_24c VARCHAR,
rd_24d VARCHAR,
rd_24e VARCHAR,
rd_24f VARCHAR,
rd_2a VARCHAR,
rd_2b VARCHAR,
rd_3_comments VARCHAR,
rd_3a VARCHAR,
rd_3b VARCHAR,
rd_3c VARCHAR,
rd_3d VARCHAR,
rd_3e VARCHAR,
rd_3f VARCHAR,
rd_4_comments VARCHAR,
rd_4a VARCHAR,
rd_4b VARCHAR,
rd_4c VARCHAR,
rd_4d VARCHAR,
rd_4e VARCHAR,
rd_4f VARCHAR,
rd_4g VARCHAR,
rd_4h VARCHAR,
rd_4i VARCHAR,
rd_4j VARCHAR,
rd_4k VARCHAR,
rd_4l VARCHAR,
rd_5_comments VARCHAR,
rd_5a VARCHAR,
rd_5b VARCHAR,
rd_5c VARCHAR,
rd_5d VARCHAR,
rd_5e VARCHAR,
rd_5f VARCHAR,
rd_5g VARCHAR,
rd_5h VARCHAR,
rd_5i VARCHAR,
rd_6_comments VARCHAR,
rd_6a VARCHAR,
rd_6b VARCHAR,
rd_7_comments VARCHAR,
rd_7a VARCHAR,
rd_7b VARCHAR,
rd_7c VARCHAR,
rd_7d VARCHAR,
rd_7e VARCHAR,
rd_7f VARCHAR,
rd_7g VARCHAR,
rd_7h VARCHAR,
rd_7i VARCHAR,
rd_7j VARCHAR,
rd_7k VARCHAR,
rd_8_comments VARCHAR,
rd_8a VARCHAR,
rd_8b VARCHAR,
rd_8c VARCHAR,
rd_8d VARCHAR,
rd_8e VARCHAR,
rd_8f VARCHAR,
rd_8g VARCHAR,
rd_8h VARCHAR,
rd_8i VARCHAR,
rd_9_comments VARCHAR,
rd_9a VARCHAR,
rd_9b VARCHAR,
rd_9c VARCHAR,
rd_9d VARCHAR,
rd_9e VARCHAR,
rd_9f VARCHAR,
rd_9g VARCHAR,
rd_9h VARCHAR,
record_id VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
regions_supporting VARCHAR,
score FLOAT,
status VARCHAR,
submitted_employee_name VARCHAR,
supervisor VARCHAR,
task_sequence_number VARCHAR,
time_zone VARCHAR,
training_status VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp()
);

alter table ineo_active_quality_redets_scorecard add primary key (record_id);

create or replace sequence seq_quality_staff_roster_id;

DROP TABLE IF EXISTS ineo_quality_staff_roster_history;
CREATE TABLE ineo_quality_staff_roster_history
(quality_staff_roster_id NUMBER NOT NULL DEFAULT seq_quality_staff_roster_id.nextval ,
department VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
employee_type VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
genesys_i3_id VARCHAR,
hr_specialist VARCHAR,
incumbent_transition VARCHAR,
manager VARCHAR,
maximus_email VARCHAR,
nesting_end_date DATE,
nesting_start_date DATE,
position_title VARCHAR,
previous_stateconduent_employee VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
regions_supporting VARCHAR,
supervisor VARCHAR,
term_date DATE,
time_zone VARCHAR,
training_class_id VARCHAR,
training_end_date DATE,
training_start_date DATE,
training_status VARCHAR,
transition_team_lead VARCHAR,
work_group VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
preferred_name);

alter table ineo_quality_staff_roster_history add primary key (quality_staff_roster_id);

DROP TABLE IF EXISTS ineo_quality_staff_roster;
CREATE TABLE ineo_quality_staff_roster
(department VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
employee_status VARCHAR,
employee_type VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
genesys_i3_id VARCHAR,
hr_specialist VARCHAR,
incumbent_transition VARCHAR,
manager VARCHAR,
maximus_email VARCHAR,
nesting_end_date DATE,
nesting_start_date DATE,
position_title VARCHAR,
previous_stateconduent_employee VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
regions_supporting VARCHAR,
supervisor VARCHAR,
term_date DATE,
time_zone VARCHAR,
training_class_id VARCHAR,
training_end_date DATE,
training_start_date DATE,
training_status VARCHAR,
transition_team_lead VARCHAR,
work_group VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
preferred_name);

alter table ineo_quality_staff_roster add primary key (employee_id);

create or replace sequence seq_active_qa_task_notif_id;

DROP TABLE IF EXISTS ineo_active_quality_task_notifications_history;
CREATE TABLE ineo_active_quality_task_notifications_history
(active_qa_task_notif_id NUMBER NOT NULL DEFAULT seq_active_qa_task_notif_id.nextval ,
autonumber VARCHAR,
comments VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
genesys_i3_id VARCHAR,
maximus_email VARCHAR,
move_to_trash VARCHAR,
position_title VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
record_id VARCHAR,
region VARCHAR,
regional_team_leads VARCHAR,
regions_supporting VARCHAR,
scorecard VARCHAR,
status VARCHAR,
submission_date DATE,
submitted_employee_name VARCHAR,
supervisor VARCHAR,
task_sequence_number  VARCHAR,
time_zone VARCHAR,
training_status VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp()
);

alter table ineo_active_quality_task_notifications_history add primary key (active_qa_task_notif_id);

DROP TABLE IF EXISTS ineo_active_quality_task_notifications;
CREATE TABLE ineo_active_quality_task_notifications
(autonumber VARCHAR,
comments VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
genesys_i3_id VARCHAR,
maximus_email VARCHAR,
move_to_trash VARCHAR,
position_title VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
record_id VARCHAR,
region VARCHAR,
regional_team_leads VARCHAR,
regions_supporting VARCHAR,
scorecard VARCHAR,
status VARCHAR,
submission_date DATE,
submitted_employee_name VARCHAR,
supervisor VARCHAR,
task_sequence_number  VARCHAR,
time_zone VARCHAR,
training_status VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp()
);

alter table ineo_active_quality_task_notifications add primary key (record_id);

create or replace sequence seq_archive_qa_task_notif_id;

DROP TABLE IF EXISTS ineo_archive_quality_task_notifications_history;
CREATE TABLE ineo_archive_quality_task_notifications_history
(archive_qa_task_notif_id NUMBER NOT NULL DEFAULT seq_archive_qa_task_notif_id.nextval ,
autonumber VARCHAR,
comments VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
genesys_i3_id VARCHAR,
maximus_email VARCHAR,
move_to_trash VARCHAR,
position_title VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
record_id VARCHAR,
region VARCHAR,
regional_team_leads VARCHAR,
regions_supporting VARCHAR,
scorecard VARCHAR,
status VARCHAR,
submission_date DATE,
submitted_employee_name VARCHAR,
supervisor VARCHAR,
task_sequence_number  VARCHAR,
time_zone VARCHAR,
training_status VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp()
);

alter table ineo_archive_quality_task_notifications_history add primary key (archive_qa_task_notif_id);

DROP TABLE IF EXISTS ineo_archive_quality_task_notifications;
CREATE TABLE ineo_archive_quality_task_notifications
(autonumber VARCHAR,
comments VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
genesys_i3_id VARCHAR,
maximus_email VARCHAR,
move_to_trash VARCHAR,
position_title VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
record_id VARCHAR,
region VARCHAR,
regional_team_leads VARCHAR,
regions_supporting VARCHAR,
scorecard VARCHAR,
status VARCHAR,
submission_date DATE,
submitted_employee_name VARCHAR,
supervisor VARCHAR,
task_sequence_number  VARCHAR,
time_zone VARCHAR,
training_status VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp()
);

alter table ineo_archive_quality_task_notifications add primary key (record_id);

create or replace sequence seq_archive_qa_app_scorecard_id;

DROP TABLE IF EXISTS ineo_archive_quality_app_scorecard_history;
CREATE TABLE ineo_archive_quality_app_scorecard_history
(archive_qa_app_scorecard_id NUMBER NOT NULL DEFAULT seq_archive_qa_app_scorecard_id.nextval ,
ap_1_comments VARCHAR,
ap_10_comments VARCHAR,
ap_10a VARCHAR,
ap_11_comments VARCHAR,
ap_11a VARCHAR,
ap_11b VARCHAR,
ap_11c VARCHAR,
ap_12_comments VARCHAR,
ap_12a VARCHAR,
ap_12b VARCHAR,
ap_13_comments VARCHAR,
ap_13a VARCHAR,
ap_14_comments VARCHAR,
ap_14a VARCHAR,
ap_15_comments VARCHAR,
ap_15a VARCHAR,
ap_15b VARCHAR,
ap_16_comments VARCHAR,
ap_16a VARCHAR,
ap_16b VARCHAR,
ap_17_comments VARCHAR,
ap_17a VARCHAR,
ap_17b VARCHAR,
ap_18_comments VARCHAR,
ap_18a VARCHAR,
ap_18b VARCHAR,
ap_19_comments VARCHAR,
ap_19a VARCHAR,
ap_1a VARCHAR,
ap_1b VARCHAR,
ap_2_comments VARCHAR,
ap_20_comments VARCHAR,
ap_20a VARCHAR,
ap_20b VARCHAR,
ap_20c VARCHAR,
ap_20d VARCHAR,
ap_20e VARCHAR,
ap_20f VARCHAR,
ap_2a VARCHAR,
ap_2b VARCHAR,
ap_2c VARCHAR,
ap_2d VARCHAR,
ap_2e VARCHAR,
ap_2f VARCHAR,
ap_3_comments VARCHAR,
ap_3a VARCHAR,
ap_3b VARCHAR,
ap_3c VARCHAR,
ap_3d VARCHAR,
ap_3e VARCHAR,
ap_3f VARCHAR,
ap_3g VARCHAR,
ap_4_comments VARCHAR,
ap_4a VARCHAR,
ap_4b VARCHAR,
ap_4c VARCHAR,
ap_4d VARCHAR,
ap_4e VARCHAR,
ap_4f VARCHAR,
ap_4g VARCHAR,
ap_4h VARCHAR,
ap_4i VARCHAR,
ap_4j VARCHAR,
ap_5_comments VARCHAR,
ap_5a VARCHAR,
ap_5b VARCHAR,
ap_5c VARCHAR,
ap_5d VARCHAR,
ap_5e VARCHAR,
ap_5f VARCHAR,
ap_5g VARCHAR,
ap_5h VARCHAR,
ap_5i VARCHAR,
ap_5j VARCHAR,
ap_5k VARCHAR,
ap_6_comments VARCHAR,
ap_6a VARCHAR,
ap_6b VARCHAR,
ap_7_comments VARCHAR,
ap_7a VARCHAR,
ap_7b VARCHAR,
ap_7c VARCHAR,
ap_7d VARCHAR,
ap_7e VARCHAR,
ap_7f VARCHAR,
ap_7g VARCHAR,
ap_7h VARCHAR,
ap_7i VARCHAR,
ap_8_comments VARCHAR,
ap_8a VARCHAR,
ap_8b VARCHAR,
ap_8c VARCHAR,
ap_8d VARCHAR,
ap_8e VARCHAR,
ap_8f VARCHAR,
ap_8g VARCHAR,
ap_8h VARCHAR,
ap_9_comments VARCHAR,
ap_9a VARCHAR,
ap_9b VARCHAR,
ap_9c VARCHAR,
ap_9d VARCHAR,
ap_9e VARCHAR,
ap_9f VARCHAR,
ap_9g VARCHAR,
ap_9h VARCHAR,
ap_9i VARCHAR,
autonumber VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
manager VARCHAR,
maximus_email VARCHAR,
overall_comments VARCHAR,
position_title VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
record_id VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
regions_supporting VARCHAR,
score FLOAT,
send_to_trash VARCHAR,
status VARCHAR,
submitted_employee_name VARCHAR,
supervisor VARCHAR,
task_sequence_number  VARCHAR,
time_zone VARCHAR,
training_status VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp()
);

alter table ineo_archive_quality_app_scorecard_history add primary key (archive_qa_app_scorecard_id);

DROP TABLE IF EXISTS ineo_archive_quality_app_scorecard;
CREATE TABLE ineo_archive_quality_app_scorecard
(ap_1_comments VARCHAR,
ap_10_comments VARCHAR,
ap_10a VARCHAR,
ap_11_comments VARCHAR,
ap_11a VARCHAR,
ap_11b VARCHAR,
ap_11c VARCHAR,
ap_12_comments VARCHAR,
ap_12a VARCHAR,
ap_12b VARCHAR,
ap_13_comments VARCHAR,
ap_13a VARCHAR,
ap_14_comments VARCHAR,
ap_14a VARCHAR,
ap_15_comments VARCHAR,
ap_15a VARCHAR,
ap_15b VARCHAR,
ap_16_comments VARCHAR,
ap_16a VARCHAR,
ap_16b VARCHAR,
ap_17_comments VARCHAR,
ap_17a VARCHAR,
ap_17b VARCHAR,
ap_18_comments VARCHAR,
ap_18a VARCHAR,
ap_18b VARCHAR,
ap_19_comments VARCHAR,
ap_19a VARCHAR,
ap_1a VARCHAR,
ap_1b VARCHAR,
ap_2_comments VARCHAR,
ap_20_comments VARCHAR,
ap_20a VARCHAR,
ap_20b VARCHAR,
ap_20c VARCHAR,
ap_20d VARCHAR,
ap_20e VARCHAR,
ap_20f VARCHAR,
ap_2a VARCHAR,
ap_2b VARCHAR,
ap_2c VARCHAR,
ap_2d VARCHAR,
ap_2e VARCHAR,
ap_2f VARCHAR,
ap_3_comments VARCHAR,
ap_3a VARCHAR,
ap_3b VARCHAR,
ap_3c VARCHAR,
ap_3d VARCHAR,
ap_3e VARCHAR,
ap_3f VARCHAR,
ap_3g VARCHAR,
ap_4_comments VARCHAR,
ap_4a VARCHAR,
ap_4b VARCHAR,
ap_4c VARCHAR,
ap_4d VARCHAR,
ap_4e VARCHAR,
ap_4f VARCHAR,
ap_4g VARCHAR,
ap_4h VARCHAR,
ap_4i VARCHAR,
ap_4j VARCHAR,
ap_5_comments VARCHAR,
ap_5a VARCHAR,
ap_5b VARCHAR,
ap_5c VARCHAR,
ap_5d VARCHAR,
ap_5e VARCHAR,
ap_5f VARCHAR,
ap_5g VARCHAR,
ap_5h VARCHAR,
ap_5i VARCHAR,
ap_5j VARCHAR,
ap_5k VARCHAR,
ap_6_comments VARCHAR,
ap_6a VARCHAR,
ap_6b VARCHAR,
ap_7_comments VARCHAR,
ap_7a VARCHAR,
ap_7b VARCHAR,
ap_7c VARCHAR,
ap_7d VARCHAR,
ap_7e VARCHAR,
ap_7f VARCHAR,
ap_7g VARCHAR,
ap_7h VARCHAR,
ap_7i VARCHAR,
ap_8_comments VARCHAR,
ap_8a VARCHAR,
ap_8b VARCHAR,
ap_8c VARCHAR,
ap_8d VARCHAR,
ap_8e VARCHAR,
ap_8f VARCHAR,
ap_8g VARCHAR,
ap_8h VARCHAR,
ap_9_comments VARCHAR,
ap_9a VARCHAR,
ap_9b VARCHAR,
ap_9c VARCHAR,
ap_9d VARCHAR,
ap_9e VARCHAR,
ap_9f VARCHAR,
ap_9g VARCHAR,
ap_9h VARCHAR,
ap_9i VARCHAR,
autonumber VARCHAR,
employee_id VARCHAR,
employee_name VARCHAR,
filename VARCHAR,
fssa_email VARCHAR,
fssa_id VARCHAR,
manager VARCHAR,
maximus_email VARCHAR,
overall_comments VARCHAR,
position_title VARCHAR,
qi_supervisor VARCHAR,
qisc VARCHAR,
record_id VARCHAR,
region VARCHAR,
regional_supervisors VARCHAR,
regions_supporting VARCHAR,
score FLOAT,
send_to_trash VARCHAR,
status VARCHAR,
submitted_employee_name VARCHAR,
supervisor VARCHAR,
task_sequence_number  VARCHAR,
time_zone VARCHAR,
training_status VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp()
);

alter table ineo_archive_quality_app_scorecard add primary key (record_id);

