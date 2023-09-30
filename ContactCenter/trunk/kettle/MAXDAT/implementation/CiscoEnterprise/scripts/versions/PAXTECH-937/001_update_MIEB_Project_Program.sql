alter session set current_schema = cisco_enterprise_cc;

--MI APS, MI CSCC, MI Bridges, MI PSS, MIEB, MIWR, MI AFS Updates
--Project and Program

--MI APS
insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Atypical Provider Services', 'Atypical Provider Services', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Atypical Provider Services', 'Michigan Services - Multiple', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

------------------------------------------------------------
insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Atypical Provider Services', 'Nursing Facility Transition Services', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));
------------------------------------------------------------

insert into cc_d_project (project_id, project_name, segment_id, include_in_reports_flag) values (SEQ_CC_D_PROJECT.nextval, 'Atypical Provider Services', 2, 1);

insert into cc_d_project_targets (d_project_targets_id, project_id, version, average_handle_time_target, utilization_target, cost_per_call_target, occupancy_target, labor_cost_per_call_target, record_eff_dt, record_end_dt)
values (SEQ_CC_D_PROJECT_TARGETS.nextval, (select project_id from cc_d_project where project_name = 'Atypical Provider Services'), 1, 0, 0, 0, 0, 0, to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Atypical Provider Services', 1);
insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Michigan Services - Multiple', 1);

---------------------------------------------------------
insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Nursing Facility Transition Services', 1);
-----------------------------------------------------------

--MI Bridges
insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('MI Bridges Support Helpdesk', 'MI Bridges Support Helpdesk', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('MI Bridges Support Helpdesk', 'Michigan Services - Multiple', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

-----------------------------------------------
insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('MI Bridges Support Helpdesk', 'Mandated Online Reporting', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));
-------------------------------------------------

insert into cc_d_project (project_id, project_name, segment_id, include_in_reports_flag) values (SEQ_CC_D_PROJECT.nextval, 'MI Bridges Support Helpdesk', 2, 1 );

insert into cc_d_project_targets (d_project_targets_id, project_id, version, average_handle_time_target, utilization_target, cost_per_call_target, occupancy_target, labor_cost_per_call_target, record_eff_dt, record_end_dt)
values (SEQ_CC_D_PROJECT_TARGETS.nextval, (select project_id from cc_d_project where project_name = 'MI Bridges Support Helpdesk'), 1, 0, 0, 0, 0, 0, to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'MI Bridges Support Helpdesk', 1 );

----------------------------------------
insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Mandated Online Reporting', 1 );
---------------------------------------

--MI CSCC
insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Customer Support Services', 'Customer Support Services', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Customer Support Services', 'Michigan Services - Multiple', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_project (project_id, project_name, segment_id, include_in_reports_flag) values (SEQ_CC_D_PROJECT.nextval, 'Customer Support Services', 2, 1 );

insert into cc_d_project_targets (d_project_targets_id, project_id, version, average_handle_time_target, utilization_target, cost_per_call_target, occupancy_target, labor_cost_per_call_target, record_eff_dt, record_end_dt)
values (SEQ_CC_D_PROJECT_TARGETS.nextval, (select project_id from cc_d_project where project_name = 'Customer Support Services'), 1, 0, 0, 0, 0, 0, to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Customer Support Services', 1 );

--MI PSS
insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Provider Support Services', 'Provider Support Services', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_project (project_id, project_name, segment_id, include_in_reports_flag) values (SEQ_CC_D_PROJECT.nextval, 'Provider Support Services', 2, 1 );

insert into cc_d_project_targets (d_project_targets_id, project_id, version, average_handle_time_target, utilization_target, cost_per_call_target, occupancy_target, labor_cost_per_call_target, record_eff_dt, record_end_dt)
values (SEQ_CC_D_PROJECT_TARGETS.nextval, (select project_id from cc_d_project where project_name = 'Provider Support Services'), 1, 0, 0, 0, 0, 0, to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Provider Support Services', 1 );

--MIEB
insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Michigan Enrollment Broker Services', 'Beneficiary Helpline', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Michigan Enrollment Broker Services', 'MI Enrolls', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Michigan Enrollment Broker Services', 'MI Healthcare Helpline', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Michigan Enrollment Broker Services', 'MIChild', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Michigan Enrollment Broker Services', 'Phone Application Helpline', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Michigan Enrollment Broker Services', 'Michigan Services - Multiple', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_project (project_id, project_name, segment_id, include_in_reports_flag) values (SEQ_CC_D_PROJECT.nextval, 'Michigan Enrollment Broker Services', 2, 1 );

insert into cc_d_project_targets (d_project_targets_id, project_id, version, average_handle_time_target, utilization_target, cost_per_call_target, occupancy_target, labor_cost_per_call_target, record_eff_dt, record_end_dt)
values (SEQ_CC_D_PROJECT_TARGETS.nextval, (select project_id from cc_d_project where project_name = 'Michigan Enrollment Broker Services'), 1, 0, 0, 0, 0, 0, to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Beneficiary Helpline', 1 );
insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'MI Enrolls', 1 );
insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'MI Healthcare Helpline', 1 );
insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'MIChild', 1 );
insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Phone Application Helpline', 1 );
--insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Michigan Services - Multiple', 1 );

--------------------------------------------------------------------------------------------------------------------------------------------
--MIWR

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Work Requirements', 'Work Requirements', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_project (project_id, project_name, segment_id, include_in_reports_flag) values (SEQ_CC_D_PROJECT.nextval, 'Work Requirements', 2, 1 );

insert into cc_d_project_targets (d_project_targets_id, project_id, version, average_handle_time_target, utilization_target, cost_per_call_target, occupancy_target, labor_cost_per_call_target, record_eff_dt, record_end_dt)
values (SEQ_CC_D_PROJECT_TARGETS.nextval, (select project_id from cc_d_project where project_name = 'Work Requirements'), 1, 0, 0, 0, 0, 0, to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Work Requirements', 1 );

--MI AFS

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Atypical Provider Services', 'Adult Foster Care', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag) values (SEQ_CC_D_PROGRAM.nextval, 'Adult Foster Care', 1 );

----------------------------------------------------------------------------------------------------------------------------------------------

commit;


-- Units of work

--MI APS

update cc_c_unit_of_work
set unit_of_work_name = 'MIEB NFTS No Agent'
where unit_of_work_name = 'MIEB NFTS No Agent ';

update cc_d_unit_of_work
set unit_of_work_name = 'MIEB NFTS No Agent'
where unit_of_work_name = 'MIEB NFTS No Agent ';



-- Contact Queues

--MI PSS

update cc_c_contact_queue 
set queue_type = 'IVR', 
Unit_of_work_name = 'IVR ERROR', 
project_name = 'Provider Support Services', 
program_name = 'Provider Support Services', 
region_name = 'Eastern', 
state_name = 'Michigan', 
service_percent = 0, 
service_seconds = 0, 
interval_minutes = 15 
where queue_number in 
(7169,
7170,
7171,
7172,
7173
);

update cc_c_contact_queue 
set project_name = 'Provider Support Services', program_name = 'Provider Support Services'
where queue_number in 
(7164,
7165,
7166,
7167,
7168,
7161,
7162,
7163,
7174,
7175,
7966,
7967,
7968,
8006
);

--MI Bridges
update cc_c_contact_queue 
set project_name = 'MI Bridges Support Helpdesk', program_name = 'MI Bridges Support Helpdesk'
where queue_number in 
(6839,
6840,
6841,
6842,
6843,
6844,
6845,
6846,
6847,
6848
/*,
7924,
7925,
7926*/
);

---------------------------------------------------
update cc_c_contact_queue 
set project_name = 'MI Bridges Support Helpdesk', program_name = 'Mandated Online Reporting'
where queue_number in 
(7924,
7925,
7926
);
-------------------------------------------------

--MI CSCC
update cc_c_contact_queue 
set project_name = 'Customer Support Services', program_name = 'Customer Support Services'
where queue_number in 
(5510,
5511,
5512,
5513,
5514,
5515,
5516,
5517,
5518,
5524,
5525,
6606,
6607,
6611,
6612
);

--------------------------------------------------
update cc_c_contact_queue
set queue_type = 'IVR', unit_of_work_name = 'IVR After Hours'
where queue_number in (5510, 5512);

update cc_c_contact_queue
set queue_type = 'Transfer'
where queue_number in (6606, 6607);
-------------------------------------------------

--MI APS
update cc_c_contact_queue 
set project_name = 'Atypical Provider Services', program_name = 'Atypical Provider Services'
where queue_number in
(5824,
5825,
5826,
5827,
5828,
5829,
5830,
5831,
5832,
5833,
5855,
5856 /*,
7369,
7370,
7371,
7372,
7373,
7374,
7375 */
);

--------------------------------
update cc_c_contact_queue 
set project_name = 'Atypical Provider Services', program_name = 'Nursing Facility Transition Services'
where queue_number in
(7369,
7370,
7371,
7372,
7373,
7374,
7375);
--------------------------------

update cc_c_contact_queue
set unit_of_work_name = 'MIEB NFTS No Agent'
where unit_of_work_name = 'MIEB NFTS No Agent ';

--MIEB
update cc_c_contact_queue 
set project_name = 'Michigan Enrollment Broker Services', program_name = 'MI Enrolls'
where queue_number in
(5268,
5275,
5282,
5283,
5284,
5285,
5286,
5287,
5288,
5289,
5296,
5298,
5299,
5300,
5302,
5303,
5482,
8253
);

update cc_c_contact_queue 
set project_name = 'Michigan Enrollment Broker Services', program_name = 'MI Healthcare Helpline'
where queue_number in
(5269,
5271,
5273
);

update cc_c_contact_queue 
set project_name = 'Michigan Enrollment Broker Services', program_name = 'Phone Application Helpline'
where queue_number in
(5270,
5272,
5274,
8254
);

update cc_c_contact_queue 
set project_name = 'Michigan Enrollment Broker Services', program_name = 'MIChild'
where queue_number in
(5276,
5277,
5278,
5279,
5280
);

update cc_c_contact_queue 
set project_name = 'Michigan Enrollment Broker Services', program_name = 'Beneficiary Helpline'
where queue_number in
(5281,
5297,
5301
);

update cc_c_contact_queue
set unit_of_work_name = 'MIEL_MIEB_0853_SEENROLL'
where queue_number = 8253;

update cc_c_contact_queue
set unit_of_work_name = 'MIEL_MIEB_0854_SEAPPLICATION'
where queue_number = 8254;

----------------------------------------------------------------------------------------
--MIWR

update cc_c_contact_queue 
set project_name = 'Work Requirements', program_name = 'Work Requirements'
where queue_number in
(8137,
8199,
8200,
8201,
8202,
8203,
8204,
8205,
8206,
8207,
8208,
8209,
8210,
8211,
8212,
8213,
8214,
8222
);

----------------------------------------------------------------------------------------

commit;

-- Agent Routing groups

--MI APS

update cc_c_agent_rtg_grp 
set project_name = 'Atypical Provider Services', 
program_name = 'Atypical Provider Services' 
where agent_routing_group_number in 
(5113,
5114,
5115
)
and agent_routing_group_type = 'Precision Queue';

---------------------------------------------
update cc_c_agent_rtg_grp 
set project_name = 'Atypical Provider Services', 
program_name = 'Nursing Facility Transition Services' 
where agent_routing_group_number = 5358
and agent_routing_group_type = 'Precision Queue';

------------------------------------------

--MI Bridges

update cc_c_agent_rtg_grp 
set project_name = 'MI Bridges Support Helpdesk', 
program_name = 'MI Bridges Support Helpdesk'
where agent_routing_group_number in 
(5249,
5250,
5251,
5252,
5253--,
--5467
)
and agent_routing_group_type = 'Precision Queue';

------------------------------------------------------
update cc_c_agent_rtg_grp 
set project_name = 'MI Bridges Support Helpdesk', 
program_name = 'Mandated Online Reporting'
where agent_routing_group_number = 5467
and agent_routing_group_type = 'Precision Queue';
-----------------------------------------------------

--MI CSCC

update cc_c_agent_rtg_grp 
set project_name = 'Customer Support Services', 
program_name = 'Customer Support Services' 
where agent_routing_group_number in 
(5073,
5074,
5075,
5076
)
and agent_routing_group_type = 'Precision Queue';

--MI PSS

update cc_c_agent_rtg_grp 
set project_name = 'Provider Support Services', 
program_name = 'Provider Support Services' 
where agent_routing_group_number in 
(5320,
5321,
5322,
5472
)
and agent_routing_group_type = 'Precision Queue';

--MIEB

update cc_c_agent_rtg_grp 
set project_name = 'Michigan Enrollment Broker Services', 
program_name = 'MI Healthcare Helpline'
where agent_routing_group_number in 
(5033)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp 
set project_name = 'Michigan Enrollment Broker Services', 
program_name = 'MI Enrolls' 
where agent_routing_group_number in 
(5034, 5035, 5037, 5440)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp 
set project_name = 'Michigan Enrollment Broker Services', 
program_name = 'Beneficiary Helpline'
where agent_routing_group_number in 
(5036)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp 
set project_name = 'Michigan Enrollment Broker Services', 
program_name = 'MIChild'
where agent_routing_group_number in 
(5038)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp 
set project_name = 'Michigan Enrollment Broker Services', 
program_name = 'Phone Application Helpline'
where agent_routing_group_number in 
(5441)
and agent_routing_group_type = 'Precision Queue';

--MIEB

update cc_c_agent_rtg_grp
set agent_routing_group_name = 'MIEL_MIEB_005_SEENROLLMENT'
where agent_routing_group_number = 5440
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp
set agent_routing_group_name = 'MIEL_MIEB_005_SEAPPLICATION'
where agent_routing_group_number = 5441
and agent_routing_group_type = 'Precision Queue';

------------------------------------------------------------------------------------
--MIWR

update cc_c_agent_rtg_grp 
set project_name = 'Work Requirements', 
program_name = 'Work Requirements'
where agent_routing_group_number in 
(5493,
5494,
5495,
5496,
5498
)
and agent_routing_group_type = 'Precision Queue';

update cc_c_agent_rtg_grp 
set region_name = 'Eastern', 
state_name = 'Michigan' 
where agent_routing_group_number in (5498)
and agent_routing_group_type = 'Precision Queue';

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5498);
---------------------------------------------------------------------------------------

commit;

-- corp_etl_lkup
update cc_a_list_lkup
set out_var = '5123,5124,5185,5186,5106,5107,5177,5178,5171,5172,5175,5176,5169,5170,5167,5168,5163,5164,5165,5166,5145,5146,5147,5148,5141,5142,5137,5138,5111,5112,5104,5105,5102,5103,5094,5095,5092,5093,5004,5005,5090,5091,5074,5075,5086,5087,5084,5085,5083,5082,5010,5011,5004,5005,5006,5007,5008,5009,5014,5015,5021,5022,5019,5020,5023,5024,5033,5034,5016,5017,5035,5036,5025,5026,5027,5028,5029,5030,5031,5032,5037,5038,5039,5040,5042,5043,5050,5051,5048,5049,5044,5045,5052,5053,5012,5013,5054,5055,5056,5057,5065,5066,5071,5072,5061,5062,5076,5077,5073,5080,5081,5113,5114,5116,5117,5133,5134,5131,5132,5100,5101,5139,5140,5143,5144,5151,5152,5149,5150,5155,5156'
where name = 'Desk_settings_ids';

commit;

-- cc_c_lookup agent desk settings

--MI APS
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5123', 'East Lansing');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5123', 'Atypical Provider Services');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5123', 'Michigan Services - Multiple');

insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_SITE', '5124', 'East Lansing');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROJECT', '5124', 'Atypical Provider Services');
insert into cc_c_lookup (lookup_type, lookup_key, lookup_value) values ('ACD_DESKSETTING_PROGRAM', '5124', 'Michigan Services - Multiple');

--MI CSCC
update cc_c_lookup
set lookup_value = 'Customer Support Services'
where lookup_key in ('5023', '5024')
and lookup_type = 'ACD_DESKSETTING_PROJECT';

update cc_c_lookup
set lookup_value = 'Michigan Services - Multiple'
where lookup_key in ('5023', '5024')
and lookup_type = 'ACD_DESKSETTING_PROGRAM';

--MI Bridges
update cc_c_lookup
set lookup_value = 'MI Bridges Support Helpdesk'
where lookup_key in ('5092', '5093')
and lookup_type = 'ACD_DESKSETTING_PROJECT';

update cc_c_lookup
set lookup_value = 'Michigan Services - Multiple'
where lookup_key in ('5092', '5093')
and lookup_type = 'ACD_DESKSETTING_PROGRAM';

--MI EB
update cc_c_lookup
set lookup_value = 'Michigan Enrollment Broker Services'
where lookup_key in ('5010', '5011')
and lookup_type = 'ACD_DESKSETTING_PROJECT';

update cc_c_lookup
set lookup_value = 'Michigan Services - Multiple'
where lookup_key in ('5010', '5011')
and lookup_type = 'ACD_DESKSETTING_PROGRAM';

---------------------------------------------------------------
--MIWR

update cc_c_lookup
set lookup_value = 'Work Requirements'
where lookup_key in ('5167', '5168')
and lookup_type in ('ACD_DESKSETTING_PROGRAM', 'ACD_DESKSETTING_PROJECT');

--------------------------------------------------------------

commit;

-- cc_c_filter

insert into cc_c_filter (filter_type, value) values ('ACD_DESKSETTING_INC', '5123');
insert into cc_c_filter (filter_type, value) values ('ACD_DESKSETTING_INC', '5124');

commit;

-- Calls offered formula 

--MI APS
insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'MI APS CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'Atypical Provider Services'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);
					
insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'MI APS CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'Atypical Provider Services'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);	
					
--MI CSCC

insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'MI CSCC CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'Customer Support Services'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);
					
insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'MI CSCC CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'Customer Support Services'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);

--MI Bridges

insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'MI Bridges CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'MI Bridges Support Helpdesk'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);
					
insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'MI Bridges CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'MI Bridges Support Helpdesk'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);

--MI PSS

insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'MI PSS CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'Provider Support Services'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);
					
insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'MI PSS CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'Provider Support Services'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);

--MIEB

insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'MI Enrollment Broker CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'Michigan Enrollment Broker Services'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);
					
insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'MI Enrollment Broker CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'Michigan Enrollment Broker Services'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);					

------------------------------------------------------------------------------
--MIWR

insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'Work Requirements CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_INTERVAL-CALLS_OFFERED'
					,'Work Requirements'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);
					
insert into cc_a_list_lkup     (	cc_cell_id
					,name
					,list_type
					,value
					,out_var
					,ref_type
					,ref_id
					,start_date
					,end_date
					,comments
					,created_ts
					,updated_ts)
			values (	seq_cc_cell_id.NEXTVAL
					,'Work Requirements CALLS_OFFERED_FORMULA'
					,'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED'
					,'Work Requirements'
					,'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
					,null
					,1
					,trunc(SYSDATE)
					,to_date('07-JUL-7777','DD-MON-YYYY')
					,'Calls offered formula for various projects in the enterprise'
					,SYSDATE
					,SYSDATE);					

-----------------------------------------------------------------------------

commit;		


/* Below IVR and Survey configs are deployed as a part of PAXTECH-1190
--IVR DNIS config updates

update cc_a_list_lkup
set out_var = 'Atypical Provider Services', ref_type = 'Atypical Provider Services'
where out_var = 'MI APCC'
and ref_type = 'MI Provider Support'
and name = 'IVR_DATA_FILE_NAMES';

update cc_a_list_lkup
set out_var = 'Customer Support Services', ref_type = 'Customer Support Services'
where out_var = 'MI CSCC'
and ref_type = 'Customer Support'
and name = 'IVR_DATA_FILE_NAMES';

update cc_a_list_lkup
set out_var = 'MI Bridges Support Helpdesk', ref_type = 'Michigan Services - Multiple'
where out_var = 'MIEB'
and ref_type = 'Multiple – MI Bridges'
and name = 'IVR_DATA_FILE_NAMES';

update cc_a_list_lkup
set out_var = 'Provider Support Services', ref_type = 'Provider Support Services'
where out_var = 'MIEB'
and ref_type = 'Multiple - Provider Support Services'
and name = 'IVR_DATA_FILE_NAMES';

update cc_a_list_lkup
set out_var = 'Michigan Enrollment Broker Services', ref_type = 'Michigan Services - Multiple'
where out_var = 'MIEB'
and ref_type = 'MIEB'
and name = 'IVR_DATA_FILE_NAMES';

commit;

--Survey config updates

update cc_a_list_lkup
set out_var = 'Michigan Enrollment Broker Services'
where out_var = 'MIEB'
and name = 'MI_Survey_project_lookup';

update cc_a_list_lkup
set out_var = 'Customer Support Services'
where out_var = 'MI CSCC'
and name = 'MI_Survey_project_lookup';

update cc_a_list_lkup
set out_var = 'Atypical Provider Services '
where out_var = 'MI APCC'
and name = 'MI_Survey_project_lookup';

commit;

update cc_c_survey_lkup
set project_name = 'Michigan Enrollment Broker Services', program_name = 'MI Enrolls'
where project_name = 'MIEB'
and program_name = 'MIEB' 
and sub_program_code = 11;

update cc_c_survey_lkup
set project_name = 'Michigan Enrollment Broker Services', program_name = 'Beneficiary Helpline'
where project_name = 'MIEB'
and program_name = 'MIEB' 
and sub_program_code = 13;

update cc_c_survey_lkup
set project_name = 'Michigan Enrollment Broker Services', program_name = 'MIChild'
where project_name = 'MIEB'
and program_name = 'MIEB' 
and sub_program_code = 14;
					
update cc_c_survey_lkup
set project_name = 'Customer Support Services', program_name = 'Michigan Services - Multiple'
where project_name = 'MI CSCC'
and program_name = 'Multiple' 
and sub_program_code = 16;

update cc_c_survey_lkup
set project_name = 'Atypical Provider Services', program_name = 'Atypical Provider Services'
where project_name = 'MI APCC'
and program_name = 'MI Provider Support' 
and sub_program_code = 17;

update cc_c_survey_lkup
set project_name = 'Michigan Enrollment Broker Services', program_name = 'Michigan Services - Multiple'
where project_name = 'MIEB'
and program_name = 'Multiple - Provider Support Services' 
and sub_program_code = 18;

update cc_c_survey_lkup
set project_name = 'MI Bridges Support Helpdesk', program_name = 'Michigan Services - Multiple'
where project_name = 'MIEB'
and program_name = 'Multiple – MI Bridges' 
and sub_program_code = 19;

commit;
*/
					