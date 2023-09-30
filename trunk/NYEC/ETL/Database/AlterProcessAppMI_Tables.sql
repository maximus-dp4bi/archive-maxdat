Prompt drop column created by and rfe_not_approved_count from process_app_mi

Alter table process_app_mi_stg drop column created_by;
Alter table process_app_mi_stg drop column rfe_not_approved_count;

Prompt drop column Reprocess_task_create_dt and sde_task_complete_Dt from nyec_etl_process_app_mi

Alter table nyec_etl_process_app_mi drop column Reprocess_task_create_dt;
Alter table nyec_etl_process_app_mi drop column sde_task_complete_Dt;