/*
Created on 11-Apr-2013 by Raj A.
This script adds the CASE_ID and Client_ID columns to the Step_Instance_Stg table.

Indexes for the columns.
*/
alter table step_instance_stg
add (
case_ID NUMBER(18),
client_ID NUMBER(18),
stage_update_ts date
);

create index IDX_STEP_INST_STG_case_id   on STEP_INSTANCE_STG (case_id);
create index IDX_STEP_INST_STG_client_id on STEP_INSTANCE_STG (client_id);