CREATE TABLE arena_task_data(task_id NUMBER,
task_type_id NUMBER,
create_date DATE,
instance_start_date DATE,
last_update_date DATE,
status_date DATE,
task_status VARCHAR2(32),
work_receipt_date DATE,
claim_date DATE,
complete_date DATE,
program VARCHAR2(200),
source_process_instance_id NUMBER,
owner_staff_id NUMBER,
stg_create_date DATE,
stg_file_num NUMBER) TABLESPACE MAXDAT_DATA;

CREATE INDEX idx01_arenatask ON arena_task_data(task_id) TABLESPACE  MAXDAT_INDX;
CREATE INDEX idx02_arenatask ON arena_task_data(task_type_id) TABLESPACE  MAXDAT_INDX;
CREATE INDEX idx03_arenatask ON arena_task_data(TRUNC(stg_create_date)) TABLESPACE  MAXDAT_INDX;