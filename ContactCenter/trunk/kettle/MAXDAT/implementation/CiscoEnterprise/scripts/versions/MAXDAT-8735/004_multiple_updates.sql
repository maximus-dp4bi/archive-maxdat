alter session set current_schema = cisco_enterprise_cc;


-- Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MCAER Campaign','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('SSPE Campaign','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MNPAY Campaign','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('AMCAP Campaign','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('SMCAP Campaign','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MCAER Campaign','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('SSPE Campaign','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MNPAY Campaign','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('AMCAP Campaign','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('SMCAP Campaign','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);

commit;

-- contact queues

update cc_c_contact_queue set program_name = 'Medi-Cal Access Program - MCAP' where queue_number = 7649;

update cc_c_contact_queue set queue_type = 'Predictive Dialer', Unit_of_work_name = 'MCAER Campaign', project_name = 'Medi-Cal For Families', program_name = 'Medi-Cal For Families Program - MFP', region_name = 'West', state_name = 'California', interval_minutes = 15 
where queue_number in (7338,7339,7642,7600,7601,7602,7603,7604,7605,7606,7607,7608);

update cc_c_contact_queue
set queue_name = 'CAFM_FSPD_2611_MACERENG_01'
where queue_number in (7338);

update cc_c_contact_queue
set queue_name = 'CAFM_FSPD_2611_MACERSPA_01'
where queue_number in (7339);

update cc_c_contact_queue set queue_type = 'Predictive Dialer', Unit_of_work_name = 'MNPAY Campaign', project_name = 'Medi-Cal For Families', program_name = 'Medi-Cal For Families Program - MFP', region_name = 'West', state_name = 'California', interval_minutes = 15 
where queue_number in (7621,7622,7623,7624,7625,7626,7627,7628,7629,7630,7631,7632);

update cc_c_contact_queue set queue_type = 'Predictive Dialer', Unit_of_work_name = 'SSPE Campaign', project_name = 'Medi-Cal For Families', program_name = 'Medi-Cal For Families Program - MFP', region_name = 'West', state_name = 'California', interval_minutes = 15 
where queue_number in (7612,7609,7610,7611,7613,7614,7615,7616,7617,7618,7619,7620);

update cc_c_contact_queue set queue_type = 'Predictive Dialer', Unit_of_work_name = 'AMCAP Campaign', project_name = 'Medi-Cal For Families', program_name = 'Medi-Cal Access Program - MCAP', region_name = 'West', state_name = 'California', interval_minutes = 15 
where queue_number in (7633,7635,7634);

update cc_c_contact_queue set queue_type = 'Predictive Dialer', Unit_of_work_name = 'SMCAP Campaign', project_name = 'Medi-Cal For Families', program_name = 'Medi-Cal Access Program - MCAP', region_name = 'West', state_name = 'California', interval_minutes = 15 
where queue_number in (7636,7637,7638);

commit;


-- Agent Routing groups

update cc_c_agent_rtg_grp set project_name = 'Medi-Cal For Families', program_name = 'Medi-Cal For Families Program - MFP', 
region_name = 'West', state_name = 'California' where agent_routing_group_number = 5416;

update cc_c_agent_rtg_grp set project_name = 'Medi-Cal For Families', program_name = 'Medi-Cal For Families Program - MFP', 
region_name = 'West', state_name = 'California' where agent_routing_group_number = 5417;

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5416);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5417);

update cc_c_agent_rtg_grp set project_name = 'Medi-Cal For Families', program_name = 'Medi-Cal For Families Program - MFP', 
region_name = 'West', state_name = 'California' where agent_routing_group_number in (5391,5392,5393,5394,5395,5396,5397,5398,5399,5400,5401);

update cc_c_agent_rtg_grp set project_name = 'Medi-Cal For Families', program_name = 'Medi-Cal Access Program - MCAP', 
region_name = 'West', state_name = 'California' where agent_routing_group_number in (5402,5403,5404,5405,5406,5407,5408,5409,5410,5411,5412);

commit;

				