insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values('Kokua',0,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values('Voice Mail',0,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values('WebChat Kokua',0,'N','Seconds');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.4','100','100_ADD_KOKUA_QUEUE_DETAILS_HCCHIX-329');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.4','101','101_INSERT_KOKUA_CC_D_UNIT_OF_WORK');

commit;