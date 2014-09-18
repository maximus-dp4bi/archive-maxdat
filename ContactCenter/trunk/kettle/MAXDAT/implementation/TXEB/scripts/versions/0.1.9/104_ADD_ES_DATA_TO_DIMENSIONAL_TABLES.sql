-- CC_D_PROJECT
insert into cc_d_project(project_id,project_name,segment_id)values(2,'TX Eligibility Support',2);

-- CC_D_PROGRAM
insert into cc_d_program(program_id,program_name)values(4,'ES');

-- CC_D_UNIT_OF_WORK
insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('ES EN',0,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('ES SP',0,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('ES SEU EN',0,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('ES SEU SP',0,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('ES SEU  EN and ES SLAQ EN',0,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,production_plan_id,hourly_flag,handle_time_unit)values ('ES SEU  SP and ES SLAQ SP',0,'N','Seconds');

-- CC_D_PROJECT_TARGETS
insert into cc_d_project_targets(project_id,version,average_handle_time_target,utilization_target,cost_per_call_target,occupancy_target,labor_cost_per_call_target,record_eff_dt,record_end_dt)
values(2,1,90,90,100,80,80,to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('0.1.9','104','104_ADD_ES_DATA_TO_DIMENSIONAL_TABLES');

commit;