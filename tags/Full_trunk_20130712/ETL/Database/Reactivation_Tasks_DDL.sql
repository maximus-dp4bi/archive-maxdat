/*
Created on 28-Feb-2012 by Raj A.
Description:
For MissingInfo process to start tracking the new reactivation MI task, I had to modify the constraint.
Also, BPM stage table, NYEC_ETL_Process_MI, is missing this constraint; so added it. process_mi_stg has it though from initial deployment.
*/

alter table Process_MI_STG
drop constraint c_pro_mi_task_type;

alter table Process_MI_STG
drop constraint c1_pro_mi_task_type;

alter table Process_MI_STG
add constraint c_pro_mi_task_type
 check (MI_TASK_TYPE in ('State Data Entry Task - MI','State Review Task - MI Reprocess Result','State Data Entry - MI Reactivation'));

alter table NYEC_ETL_Process_MI
add constraint c1_pro_mi_task_type
 check (MI_TASK_TYPE in ('State Data Entry Task - MI','State Review Task - MI Reprocess Result','State Data Entry - MI Reactivation'));
