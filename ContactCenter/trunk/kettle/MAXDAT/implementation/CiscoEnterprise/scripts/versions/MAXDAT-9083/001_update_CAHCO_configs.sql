alter session set current_schema = cisco_enterprise_cc;

-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey LAO CCI','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey LAO','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CA HCO Laotian Language Voicemail','VOICE_MAIL',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 0, 1);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CHCO CCI LAO Queue','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CA HCO Laotian Language Queue','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CARC CHCO  Laotian Incoming Calls','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

--Survey UOWs

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey Engish','Survey',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey Spanish','Survey',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey Language','Survey',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey English CCI','Survey',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey Spanish CCI','Survey',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey Language CCI','Survey',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey Q1','Survey',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey Q2','Survey',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey Q3','Survey',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey Q4','Survey',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey Q5','Survey',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey Q6','Survey',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey Q7','Survey',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Survey Q8','Survey',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey LAO CCI','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey LAO','IVR', 1, 'N', 'Seconds', 0, 1);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CA HCO Laotian Language Voicemail','VOICE_MAIL', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CHCO CCI LAO Queue','INBOUND', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CA HCO Laotian Language Queue','INBOUND', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CARC CHCO  Laotian Incoming Calls','INBOUND', 1, 'N', 'Seconds', 1, 0);

--Survey UOWs

insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey Engish','Survey', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey Spanish','Survey', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey Language','Survey', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey English CCI','Survey', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey Spanish CCI','Survey', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey Language CCI','Survey', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey Q1','Survey', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey Q2','Survey', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey Q3','Survey', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey Q4','Survey', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey Q5','Survey', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey Q6','Survey', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey Q7','Survey', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Survey Q8','Survey', 1, 'N', 'Seconds', 1, 0);


commit;

-- contact queues

update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'CHCO CCI LAO Queue', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7774';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'CA HCO Laotian Language Queue', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '7772';
update cc_c_contact_queue set queue_type = 'Voicemail', Unit_of_work_name = 'CA HCO Laotian Language Voicemail', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '6140';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'CA HCO Laotian Language Queue', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '6111';
update cc_c_contact_queue set queue_type = 'Inbound', Unit_of_work_name = 'CARC CHCO  Laotian Incoming Calls', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = '6599';

--Survey call Types

update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Language CCI', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 
where queue_number in 
(
7773,
7420,
7421,
7422,
7424,
7425,
7426,
7427,
7428,
7429,
7430,
7431,
7432,
7434,
7435,
7436
);

update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Language', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 
where queue_number in 
(
7771,
7407,
7408,
7405,
7409,
7410,
7411,
7406,
7412,
7413,
7414,
7415,
7416,
7417,
7418,
7419
);

update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey English CCI', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = 7423;

update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Spanish CCI', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = 7433;

update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Engish', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = 7403;

update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Spanish', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 where queue_number = 7404;

update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q1', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 
where queue_number in 
(
7451,
7459,
7460,
7461,
7462,
7463
);

update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q2', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 
where queue_number in 
(
7452,
7464,
7465,
7466,
7467,
7468
);

update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q3', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 
where queue_number in 
(
7453,
7469,
7470,
7471,
7472,
7473
);

update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q4', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 
where queue_number in 
(
7454,
7474,
7475,
7476,
7477,
7478
);

update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q5', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 
where queue_number in 
(
7455,
7479,
7480,
7481,
7482,
7483
);

update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q6', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 
where queue_number in 
(
7456,
7484,
7485,
7486,
7487,
7488
);

update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q7', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 
where queue_number in 
(
7457,
7489,
7490,
7491,
7492,
7493
);

update cc_c_contact_queue set queue_type = 'Survey', Unit_of_work_name = 'Survey Q8', project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California', service_seconds = 20, interval_minutes = 15 
where queue_number in 
(
7458,
7494,
7495,
7496,
7497,
7498
);

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'CHCO CCI LAO Queue'), service_seconds = 20, interval_minutes = 15 where queue_number = '7774';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'CA HCO Laotian Language Queue'), service_seconds = 20, interval_minutes = 15 where queue_number = '7772';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Voicemail', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'CA HCO Laotian Language Voicemail'), service_seconds = 20, interval_minutes = 15 where queue_number = '6140';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'CA HCO Laotian Language Queue'), service_seconds = 20, interval_minutes = 15 where queue_number = '6111';
update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Inbound', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'CARC CHCO  Laotian Incoming Calls'), service_seconds = 20, interval_minutes = 15 where queue_number = '6599';

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Survey', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Survey Language CCI'), service_seconds = 20, interval_minutes = 15 
where queue_number in 
(
7773,
7420,
7421,
7422,
7424,
7425,
7426,
7427,
7428,
7429,
7430,
7431,
7432,
7434,
7435,
7436
);

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Survey', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Survey Language'), service_seconds = 20, interval_minutes = 15 
where queue_number in 
(
7771,
7407,
7408,
7405,
7409,
7410,
7411,
7406,
7412,
7413,
7414,
7415,
7416,
7417,
7418,
7419
);

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Survey', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Survey English CCI'), service_seconds = 20, interval_minutes = 15 
where queue_number = 7423;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Survey', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Survey Spanish CCI'), service_seconds = 20, interval_minutes = 15 
where queue_number = 7433;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Survey English', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Survey English CCI'), service_seconds = 20, interval_minutes = 15 
where queue_number = 7403;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Survey Spanish', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Survey English CCI'), service_seconds = 20, interval_minutes = 15 
where queue_number = 7404;

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Survey Q1', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Survey English CCI'), service_seconds = 20, interval_minutes = 15 
where queue_number in
(
7451,
7459,
7460,
7461,
7462,
7463
);

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Survey Q2', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Survey English CCI'), service_seconds = 20, interval_minutes = 15 
where queue_number in
(
7452,
7464,
7465,
7466,
7467,
7468
);

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Survey Q3', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Survey English CCI'), service_seconds = 20, interval_minutes = 15 
where queue_number in
(
7453,
7469,
7470,
7471,
7472,
7473
);

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Survey Q4', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Survey English CCI'), service_seconds = 20, interval_minutes = 15 
where queue_number in
(
7454,
7474,
7475,
7476,
7477,
7478
);

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Survey Q5', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Survey English CCI'), service_seconds = 20, interval_minutes = 15 
where queue_number in
(
7455,
7479,
7480,
7481,
7482,
7483
);

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Survey Q6', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Survey English CCI'), service_seconds = 20, interval_minutes = 15 
where queue_number in
(
7456,
7484,
7485,
7486,
7487,
7488
);

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Survey Q7', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Survey English CCI'), service_seconds = 20, interval_minutes = 15 
where queue_number in
(
7457,
7489,
7490,
7491,
7492,
7493
);

update cc_s_contact_queue set project_config_id = (select project_config_id from cc_c_project_config where project_name = 'CA HCO' and program_name = 'Medi-Cal'), queue_type = 'Survey Q8', unit_of_work_id = (select unit_of_work_id from cc_c_unit_of_work where unit_of_work_name = 'Survey English CCI'), service_seconds = 20, interval_minutes = 15 
where queue_number in
(
7458,
7494,
7495,
7496,
7497,
7498
);


update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'CHCO CCI LAO Queue'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 20, interval_minutes = 15 where queue_number = '7774';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'CA HCO Laotian Language Queue'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 20, interval_minutes = 15 where queue_number = '7772';
update cc_d_contact_queue set queue_type = 'Voicemail', d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'CA HCO Laotian Language Voicemail'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 20, interval_minutes = 15 where queue_number = '6140';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'CA HCO Laotian Language Queue'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 20, interval_minutes = 15 where queue_number = '6111';
update cc_d_contact_queue set queue_type = 'Inbound', d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'CARC CHCO  Laotian Incoming Calls'), d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),service_seconds= 20, interval_minutes = 15 where queue_number = '6599';

--Survey Call Types

update cc_d_contact_queue 
set queue_type = 'Survey', 
d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Survey Language CCI'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),
service_seconds= 20, interval_minutes = 15 
where queue_number in 
(
7773,
7420,
7421,
7422,
7424,
7425,
7426,
7427,
7428,
7429,
7430,
7431,
7432,
7434,
7435,
7436
);

update cc_d_contact_queue 
set queue_type = 'Survey', 
d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Survey Language'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),
service_seconds= 20, interval_minutes = 15 
where queue_number in 
(
7771,
7407,
7408,
7405,
7409,
7410,
7411,
7406,
7412,
7413,
7414,
7415,
7416,
7417,
7418,
7419
);

update cc_d_contact_queue 
set queue_type = 'Survey', 
d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Survey English CCI'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),
service_seconds= 20, interval_minutes = 15 
where queue_number = 7423;

update cc_d_contact_queue 
set queue_type = 'Survey', 
d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Survey Spanish CCI'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),
service_seconds= 20, interval_minutes = 15 
where queue_number = 7433;

update cc_d_contact_queue 
set queue_type = 'Survey', 
d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Survey English'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),
service_seconds= 20, interval_minutes = 15 
where queue_number = 7403;

update cc_d_contact_queue 
set queue_type = 'Survey', 
d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Survey Spanish'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),
service_seconds= 20, interval_minutes = 15 
where queue_number = 7404;

update cc_d_contact_queue 
set queue_type = 'Survey', 
d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Survey Q1'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),
service_seconds= 20, interval_minutes = 15 
where queue_number in 
(
7451,
7459,
7460,
7461,
7462,
7463
);

update cc_d_contact_queue 
set queue_type = 'Survey', 
d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Survey Q2'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),
service_seconds= 20, interval_minutes = 15 
where queue_number in 
(
7452,
7464,
7465,
7466,
7467,
7468
);

update cc_d_contact_queue 
set queue_type = 'Survey', 
d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Survey Q3'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),
service_seconds= 20, interval_minutes = 15 
where queue_number in 
(
7453,
7469,
7470,
7471,
7472,
7473
);

update cc_d_contact_queue 
set queue_type = 'Survey', 
d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Survey Q4'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),
service_seconds= 20, interval_minutes = 15 
where queue_number in 
(
7454,
7474,
7475,
7476,
7477,
7478
);

update cc_d_contact_queue 
set queue_type = 'Survey', 
d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Survey Q5'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),
service_seconds= 20, interval_minutes = 15 
where queue_number in 
(
7455,
7479,
7480,
7481,
7482,
7483
);

update cc_d_contact_queue 
set queue_type = 'Survey', 
d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Survey Q6'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),
service_seconds= 20, interval_minutes = 15 
where queue_number in 
(
7456,
7484,
7485,
7486,
7487,
7488
);

update cc_d_contact_queue 
set queue_type = 'Survey', 
d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Survey Q7'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),
service_seconds= 20, interval_minutes = 15 
where queue_number in 
(
7457,
7489,
7490,
7491,
7492,
7493
);

update cc_d_contact_queue 
set queue_type = 'Survey', 
d_project_id = (select project_id from cc_d_project where project_name = 'CA HCO'), 
d_program_id = (select program_id from cc_d_program where program_name = 'Medi-Cal'), 
d_unit_of_work_id = (select uow_id from cc_d_unit_of_work where unit_of_work_name = 'Survey Q8'), 
d_geography_master_id = (select geography_master_id from cc_d_geography_master where geography_name = 'California'),
service_seconds= 20, interval_minutes = 15 
where queue_number in 
(
7458,
7494,
7495,
7496,
7497,
7498
);


commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp set project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California' where agent_routing_group_number = 5437;
update cc_c_agent_rtg_grp set project_name = 'CA HCO', program_name = 'Medi-Cal', region_name = 'West', state_name = 'California' where agent_routing_group_number = 5438;

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5437);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5438);

commit;


				