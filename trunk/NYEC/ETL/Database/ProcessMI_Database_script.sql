truncate table process_mi_stg;
truncate table nyec_etl_process_mi;

alter table process_mi_stg add new_mi_satisfied_date date;
alter table nyec_etl_process_mi add new_mi_satisfied_date date;


alter table process_mi_stg add mi_letter_req_created_by VARCHAR2(100);
alter table nyec_etl_process_mi add mi_letter_req_created_by VARCHAR2(100);

alter table process_mi_stg 
drop constraint C_PRO_MI_INSTANCE_STATUS;

alter table process_mi_stg
add constraint c_pro_mi_instance_status
check (INSTANCE_STATUS in ('Active','Complete'));


alter table nyec_etl_process_mi 
drop constraint C1_PRO_MI_INSTANCE_STATUS;

alter table nyec_etl_process_mi
add constraint C1_PRO_MI_INSTANCE_STATUS
check (INSTANCE_STATUS in ('Active','Complete'));

--This update sets the Process MI Global control table to 31 days for initial setup. Right after deployment, this will be changed to 5 days.
update corp_etl_control
   set value = 31,
       updated_ts = sysdate      	
 where name = 'PRO_MI_CDC_MI_TASKS';
commit;