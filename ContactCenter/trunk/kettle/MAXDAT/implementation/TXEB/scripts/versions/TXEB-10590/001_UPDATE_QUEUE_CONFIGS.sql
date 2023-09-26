-- cc_c_project_config

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_Eff_dt, record_end_dt) values
('TX Enrollment Broker', 'Star Plus Kids Interest', 'Central', 'Texas', 'n/a', 'n/a', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));

-- cc_d_program

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (6, 'Star Plus Kids Interest', 1);

--cc_c_unit_of_work

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('SPKI Spanish', 'INBOUND_CALL', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('SPKI English', 'INBOUND_CALL', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('SPKI English Transfer', 'TRANSFER', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt) values ('SPKI Spanish Transfer', 'TRANSFER', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));


--cc_d_unit_of_work

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SPKI Spanish', 'INBOUND_CALL', 0, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SPKI English', 'INBOUND_CALL', 0, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SPKI English Transfer', 'TRANSFER', 0, 'N', 'Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SPKI Spanish Transfer', 'TRANSFER', 0, 'N', 'Seconds');

/*TXEBXMDU ONLY*/

insert into cc_c_contact_queue (queue_number, queue_name, queue_type, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_Eff_dt, record_end_dt)
values (12532, 'ESS.EB_INB_SP_SPK_INTRST_Q', 'Inbound', 'SPKI Spanish', 'TX Enrollment Broker', 'Star Plus Kids Interest', 'Central', 'Texas', 'Unknown', 'Unknown','USA', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_c_contact_queue (queue_number, queue_name, queue_type, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_Eff_dt, record_end_dt)
values (12536, 'ESS.EB_INB_EN_SPK_INTRST_Q', 'Inbound', 'SPKI English', 'TX Enrollment Broker', 'Star Plus Kids Interest', 'Central', 'Texas', 'Unknown', 'Unknown','USA', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_c_contact_queue (queue_number, queue_name, queue_type, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_Eff_dt, record_end_dt)
values (12516, 'ESS.EB_XFR_EN_SPK_INTRST_Q', 'Transfer', 'SPKI English Transfer',  'TX Enrollment Broker', 'Star Plus Kids Interest', 'Central', 'Texas', 'Unknown', 'Unknown','USA', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_c_contact_queue (queue_number, queue_name, queue_type, unit_of_work_name, project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_Eff_dt, record_end_dt)
values (12519, 'ESS.EB_XFR_SP_SPK_INTRST_Q', 'Transfer', 'SPKI Spanish Transfer', 'TX Enrollment Broker', 'Star Plus Kids Interest' , 'Central', 'Texas', 'Unknown', 'Unknown','USA', to_date('1900/01/01', 'yyyy/mm/dd'), to_date('2999/12/31', 'yyyy/mm/dd'));



-- cc_c_contact_queue

update cc_c_contact_queue set queue_type = 'Inbound' ,unit_of_work_name = 'SPKI Spanish', project_name = 'TX Enrollment Broker', program_name = 'Star Plus Kids Interest' where queue_number = '12532';
update cc_c_contact_queue set queue_type = 'Inbound' ,unit_of_work_name = 'SPKI English', project_name = 'TX Enrollment Broker', program_name = 'Star Plus Kids Interest' where queue_number = '12536';

update cc_c_contact_queue set queue_type = 'Transfer' ,unit_of_work_name = 'SPKI English Transfer', project_name = 'TX Enrollment Broker', program_name = 'Star Plus Kids Interest' where queue_number = '12516';
update cc_c_contact_queue set queue_type = 'Transfer' ,unit_of_work_name = 'SPKI Spanish Transfer', project_name = 'TX Enrollment Broker', program_name = 'Star Plus Kids Interest' where queue_number = '12519';


-- cc_s_contact_queue

update cc_s_contact_queue set  queue_type = 'Inbound', unit_of_work_id =161 , project_config_id =6 where queue_number = '12532';
update cc_s_contact_queue set  queue_type = 'Inbound', unit_of_work_id =162 , project_config_id =6 where queue_number = '12536';

update cc_s_contact_queue set  queue_type = 'Transfer', unit_of_work_id =163 , project_config_id =6 where queue_number = '12516';
update cc_s_contact_queue set  queue_type = 'Transfer', unit_of_work_id =164 , project_config_id =6 where queue_number = '12519';


-- cc_d_contact_queue

update cc_d_contact_queue set queue_type = 'Inbound'  where queue_number = '12532';
update cc_d_contact_queue set queue_type = 'Inbound'  where queue_number = '12536';

update cc_d_contact_queue set queue_type = 'Transfer'  where queue_number = '12516';
update cc_d_contact_queue set queue_type = 'Transfer'  where queue_number = '12519';

commit;

-- cc_c_filter

insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '12532');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '12536');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '12516');
insert into cc_c_filter (filter_type, value) values ('ACD_CALL_TYPE_ID_INC', '12519');

commit;
