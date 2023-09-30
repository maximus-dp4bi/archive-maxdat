alter session set current_schema = cisco_enterprise_cc;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Voicemail - After Hours','VOICE_MAIL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Voicemail - Business Hours','VOICE_MAIL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Voicemail - After Hours','VOICE_MAIL', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Voicemail - Business Hours','VOICE_MAIL', 1, 'N', 'Seconds', 1, 0);

commit;


-- contact queues

update cc_c_contact_queue 
set Unit_of_work_name = 'Voicemail - After Hours'
where queue_number = '6275';

update cc_c_contact_queue 
set queue_type = 'Voicemail', 
Unit_of_work_name = 'Voicemail - Business Hours', 
project_name = 'Wyoming Dept of Health', 
program_name = 'Medicaid / CHIP' ,
region_name = 'West', 
state_name = 'Wyoming', 
interval_minutes = 15
where queue_number = '8183';

update cc_s_contact_queue 
set unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Voicemail - After Hours')
where queue_number = '6275';

update cc_s_contact_queue 
set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'Wyoming Dept of Health' and program_name = 'Medicaid / CHIP'), 
queue_type = 'Voicemail', 
unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Voicemail - Business Hours')
where queue_number = '8183';


update cc_d_contact_queue 
set queue_type = 'Voicemail', 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Voicemail - After Hours')
where queue_number = '6275';

update cc_d_contact_queue 
set queue_type = 'Voicemail', 
d_project_id = (select project_id from cc_d_project where project_name = 'Wyoming Dept of Health'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medicaid / CHIP'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Voicemail - Business Hours')
where queue_number = '8183';

commit;


-- cc_a_list_lkup

update cc_a_list_lkup
set out_var = '5163,5164,5165,5166,5145,5146,5147,5148,5141,5142,5137,5138,5111,5112,5104,5105,5102,5103,5094,5095,5092,5093,5004,5005,5090,5091,5074,5075,5086,5087,5084,5085,5083,5082,5010,5011,5004,5005,5006,5007,5008,5009,5014,5015,5021,5022,5019,5020,5023,5024,5033,5034,5016,5017,5035,5036,5025,5026,5027,5028,5029,5030,5031,5032,5037,5038,5039,5040,5042,5043,5050,5051,5048,5049,5044,5045,5052,5053,5012,5013,5054,5055,5056,5057,5065,5066,5071,5072,5061,5062,5076,5077,5073,5080,5081,5113,5114,5116,5117,5133,5134,5131,5132,5100,5101,5139,5140,5143,5144,5151,5152,5149,5150,5155,5156'
where name = 'Desk_settings_ids';

commit;

-- cc_c_lookup agent desk settings

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5163', 'Hampton');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5163', 'Wyoming Dept of Health');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5163', 'Medicaid / CHIP');

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5164', 'Hampton');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5164', 'Wyoming Dept of Health');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5164', 'Medicaid / CHIP');

commit;

-- cc_c_filter

insert into cc_c_filter (filter_type, value) values ('ACD_DESKSETTING_INC', '5163');
insert into cc_c_filter (filter_type, value) values ('ACD_DESKSETTING_INC', '5164');

commit;	

-- Calls Offered Formula

UPDATE cc_a_list_lkup
SET OUT_VAR = 'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
where value = 'Wyoming Dept of Health'
and upper(out_var) like 'SELECT (%'
AND LIST_TYPE = 'CC_S_ACD_INTERVAL-CALLS_OFFERED';


UPDATE cc_a_list_lkup
SET OUT_VAR = 'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
where value = 'Wyoming Dept of Health'
and upper(out_var) like 'SELECT (%'
AND LIST_TYPE = 'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED';

commit;
					