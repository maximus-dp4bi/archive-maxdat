CREATE OR REPLACE SEQUENCE seq_agent_availability_id;
CREATE OR REPLACE SEQUENCE seq_task_created_prior_day_id;

CREATE OR REPLACE TABLE INEO_AGENT_AVAILABILITY_HISTORY (
agent_availability_id NUMBER NOT NULL DEFAULT seq_agent_availability_id.nextval,
date DATE,
userid VARCHAR,
last_name VARCHAR,
first_name VARCHAR,
business_phone VARCHAR,
org_name VARCHAR,
department VARCHAR,
loc_name VARCHAR,
first_activity VARCHAR,
last_activity VARCHAR,
tot_activity_time VARCHAR,
logged_in VARCHAR,
acd_logged_in VARCHAR,
non_acd_logged_in VARCHAR,
dnd VARCHAR,
acw VARCHAR,
non_task_work VARCHAR,
available_noacd VARCHAR,
available VARCHAR,
follow_up VARCHAR,
available_followme VARCHAR,
available_forward VARCHAR,
at_break VARCHAR,
at_lunch VARCHAR,
away_from_desk VARCHAR,
do_not_disturb VARCHAR,
quality_session VARCHAR,
in_a_meeting VARCHAR,
at_a_training_session VARCHAR,
gone_home VARCHAR,
on_vacation VARCHAR,
out_of_town VARCHAR,
out_of_office VARCHAR,
working_at_home VARCHAR,
interactions NUMBER,
avgtalk VARCHAR,
totaltalk VARCHAR,
avgacw VARCHAR,
totalacw VARCHAR,
avgspeedans VARCHAR,
local_disconnected NUMBER,
load_ratio VARCHAR,
inbound NUMBER,
avg_in_talk VARCHAR,
tot_time_in VARCHAR,
outbound NUMBER,
avg_out_talk VARCHAR,
tot_time_out VARCHAR,
filename VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

ALTER TABLE INEO_AGENT_AVAILABILITY_HISTORY ADD PRIMARY KEY(agent_availability_id);

CREATE OR REPLACE TABLE INEO_TASKS_CREATED_PRIOR_DAY_HISTORY (
task_created_prior_day_id NUMBER NOT NULL DEFAULT seq_task_created_prior_day_id.nextval,
filename VARCHAR,
task_id NUMBER,
task_name VARCHAR,
work_queue_name VARCHAR,
task_status VARCHAR,
assigned_to VARCHAR,
user_type VARCHAR,
user_primary_office VARCHAR,
task_created_date TIMESTAMP_NTZ(9),
task_created_by VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

ALTER TABLE INEO_TASKS_CREATED_PRIOR_DAY_HISTORY ADD PRIMARY KEY(task_created_prior_day_id);

CREATE OR REPLACE TABLE INEO_TASKS_CREATED_PRIOR_DAY (
filename VARCHAR,
task_id NUMBER,
task_name VARCHAR,
work_queue_name VARCHAR,
task_status VARCHAR,
assigned_to VARCHAR,
user_type VARCHAR,
user_primary_office VARCHAR,
task_created_date TIMESTAMP_NTZ(9),
task_created_by VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

ALTER TABLE INEO_TASKS_CREATED_PRIOR_DAY ADD PRIMARY KEY(task_id);


