-- CC_D_CONTACT_QUEUE & CC_D_UNIT_OF_WORK

update cc_d_contact_queue
set queue_type='Outbound'
where queue_number in (
5048
,5077
,5078
,5079
,5080
,5081
,5082
,5241
,5245);


insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('EBS_OUTBOUND',0,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('THS_OUTBOUND',0,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('CHIP_OUTBOUND',0,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('CHIP_OUTBOUND_ENRL',0,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('CHIP_OUTBOUND_MI',0,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('CHIP_OUTBOUND_PMI',0,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('CHIP_OUTBOUND_XFR',0,'N','Seconds');




INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.2.3','107','107_ADD_OUTBOUND_DATA_TO_DIMENSIONAL_TABLES');

commit;