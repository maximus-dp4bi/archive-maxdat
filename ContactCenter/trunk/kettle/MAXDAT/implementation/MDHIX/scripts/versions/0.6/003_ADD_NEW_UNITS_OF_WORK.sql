insert into cc_c_unit_of_work(unit_of_work_name,unit_of_work_category,record_eff_dt,record_end_dt)values('MEDICAID','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,unit_of_work_category,record_eff_dt,record_end_dt)values('SPECIALTY','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,unit_of_work_category,record_eff_dt,record_end_dt)values('QHP','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,unit_of_work_category,record_eff_dt,record_end_dt)values('MEDICAID - SPA','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,unit_of_work_category,record_eff_dt,record_end_dt)values('SPECIALTY - SPA','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,unit_of_work_category,record_eff_dt,record_end_dt)values('QHP - SPA','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,unit_of_work_category,record_eff_dt,record_end_dt)values('TECH SUPPORT','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,unit_of_work_category,record_eff_dt,record_end_dt)values('TECH SUPPORT - SPA','INBOUND_CALL',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_c_unit_of_work(unit_of_work_name,unit_of_work_category,record_eff_dt,record_end_dt)values('TRANSFER','TRANSFER',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name,unit_of_work_category,record_eff_dt,record_end_dt)values('TRANSFER - SPA','TRANSFER',to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));

commit;

insert into cc_d_unit_of_work(unit_of_work_name,unit_of_work_category,production_plan_id,hourly_flag,handle_time_unit)values('MEDICAID','INBOUND_CALL',1,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,unit_of_work_category,production_plan_id,hourly_flag,handle_time_unit)values('SPECIALTY','INBOUND_CALL',2,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,unit_of_work_category,production_plan_id,hourly_flag,handle_time_unit)values('QHP','INBOUND_CALL',3,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,unit_of_work_category,production_plan_id,hourly_flag,handle_time_unit)values('MEDICAID - SPA','INBOUND_CALL',4,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,unit_of_work_category,production_plan_id,hourly_flag,handle_time_unit)values('SPECIALTY - SPA','INBOUND_CALL',5,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,unit_of_work_category,production_plan_id,hourly_flag,handle_time_unit)values('QHP - SPA','INBOUND_CALL',6,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,unit_of_work_category,production_plan_id,hourly_flag,handle_time_unit)values('TECH SUPPORT','INBOUND_CALL',7,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,unit_of_work_category,production_plan_id,hourly_flag,handle_time_unit)values('TECH SUPPORT - SPA','INBOUND_CALL',8,'N','Seconds');

insert into cc_d_unit_of_work(unit_of_work_name,unit_of_work_category,production_plan_id,hourly_flag,handle_time_unit)values('TRANSFER','TRANSFER',9,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name,unit_of_work_category,production_plan_id,hourly_flag,handle_time_unit)values('TRANSFER - SPA','TRANSFER',10,'N','Seconds');

commit;