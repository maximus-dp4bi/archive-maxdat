
-- CC_D_UNIT_OF_WORK

insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('STAR Plus NonFrew EN',0,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('STAR Plus NonFrew SP',0,'N','Seconds');


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.0','103','103_ADD_STARPLUS_DATA_TO_DIMENSIONAL_TABLES');

commit;