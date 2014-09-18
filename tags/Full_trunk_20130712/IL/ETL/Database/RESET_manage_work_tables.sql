truncate table corp_etl_manage_work;
truncate table Corp_Etl_Manage_Work_Tmp;
update step_instance_stg sis
set sis.mw_processed = 'N';



