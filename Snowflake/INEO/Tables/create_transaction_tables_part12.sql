CREATE OR REPLACE SEQUENCE seq_qual_metric_sc_trash_id;

CREATE OR REPLACE TABLE INEO_QUALITY_METRIC_SCORECARDS_TRASH_HISTORY (qual_metric_sc_trash_id NUMBER NOT NULL DEFAULT seq_qual_metric_sc_trash_id.nextval,
autonumber VARCHAR,
region VARCHAR,
supervisor VARCHAR,
manager VARCHAR,
status VARCHAR,
filename VARCHAR,
supervisor_name VARCHAR,
send_to_trash VARCHAR,
employee_id VARCHAR,
fssa_id VARCHAR,
art_id NUMBER,
employee_name VARCHAR,
submitted_employee_name VARCHAR,
training_status VARCHAR,
record_id VARCHAR,
scoring_date DATE,
task_sequence_number VARCHAR,
sf_create_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp(),
sf_update_ts TIMESTAMP_NTZ(9) DEFAULT current_timestamp());
 
ALTER TABLE INEO_QUALITY_METRIC_SCORECARDS_TRASH_HISTORY ADD PRIMARY KEY(qual_metric_sc_trash_id);