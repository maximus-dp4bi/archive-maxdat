alter session set current_schema = cisco_enterprise_cc;

--Campaigns

update cc_c_campaign
set project_name = 'CA Lifeline', Program_name = 'Customer Service Center', region_name = 'West', state_name = 'California'
where campaign_id in (5099,
5100,
5101,
5102,
5103,
5104,
5105,
5106,
5107,
5108,
5109,
5110,
5111,
5112,
5113,
5114,
5115,
5116,
5117,
5118,
5119,
5120,
5121,
5122,
5123,
5124,
5125,
5126
);

commit;

--Units of work

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD A03 ENG','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD A21ENG','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD R03ENG','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD A21JPN','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD A21KOR','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD A21SPA','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD A21TGL','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD A21VIE','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD A03JPN','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD A03KOR','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD A03SPA','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD A03TGL','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD A03VIE','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD A21CHI','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD A03CHI','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD R03CHI','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD R03JPN','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD R03KOR','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD R03SPA','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD R03TGL','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD R03VIE','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD R21CHI','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD R21ENG','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD R21JPN','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD R21KOR','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD R21SPA','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD R21TGL','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CALL LLPD R21VIE','Predictive Dialer',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD A03 ENG','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD A21ENG','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD R03ENG','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD A21JPN','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD A21KOR','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD A21SPA','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD A21TGL','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD A21VIE','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD A03JPN','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD A03KOR','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD A03SPA','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD A03TGL','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD A03VIE','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD A21CHI','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD A03CHI','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD R03CHI','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD R03JPN','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD R03KOR','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD R03SPA','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD R03TGL','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD R03VIE','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD R21CHI','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD R21ENG','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD R21JPN','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD R21KOR','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD R21SPA','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD R21TGL','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CALL LLPD R21VIE','Predictive Dialer', 1, 'N', 'Seconds', 1, 0);
	   
commit;

--Contact Queues

update cc_c_contact_queue
set queue_type = 'Predictive Dialer', interval_minutes = 15, project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California' 
where queue_number in (7793,
7800,
7807,
7801,
7802,
7803,
7804,
7805,
7794,
7795,
7796,
7797,
7798,
7799,
7792,
7806,
7808,
7809,
7810,
7811,
7812,
7813,
7814,
7815,
7816,
7817,
7818,
7819
);

update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD A03 ENG' where queue_number = 7793;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD A21ENG' where queue_number = 7800;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD R03ENG' where queue_number = 7807;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD A21JPN' where queue_number = 7801;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD A21KOR' where queue_number = 7802;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD A21SPA' where queue_number = 7803;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD A21TGL' where queue_number = 7804;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD A21VIE' where queue_number = 7805;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD A03JPN' where queue_number = 7794;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD A03KOR' where queue_number = 7795;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD A03SPA' where queue_number = 7796;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD A03TGL' where queue_number = 7797;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD A03VIE' where queue_number = 7798;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD A21CHI' where queue_number = 7799;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD A03CHI' where queue_number = 7792;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD R03CHI' where queue_number = 7806;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD R03JPN' where queue_number = 7808;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD R03KOR' where queue_number = 7809;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD R03SPA' where queue_number = 7810;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD R03TGL' where queue_number = 7811;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD R03VIE' where queue_number = 7812;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD R21CHI' where queue_number = 7813;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD R21ENG' where queue_number = 7814;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD R21JPN' where queue_number = 7815;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD R21KOR' where queue_number = 7816;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD R21SPA' where queue_number = 7817;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD R21TGL' where queue_number = 7818;
update cc_c_contact_queue set unit_of_work_name = 'CALL LLPD R21VIE' where queue_number = 7819;

commit;

-- Agent Routing groups

update cc_c_agent_rtg_grp
set project_name = 'CA Lifeline', program_name = 'Customer Service Center', region_name = 'West', state_name = 'California'
where agent_routing_Group_number in (17872,
17873,
17874,
17875,
17876,
17877,
17878,
17879,
17880,
17881,
17882,
17883,
17884,
17885,
17886,
17887,
17888,
17889,
17890,
17891,
17892,
17893,
17894,
17895,
17896,
17897,
17898,
17899
);

insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17872);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17873);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17874);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17875);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17876);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17877);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17878);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17879);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17880);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17881);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17882);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17883);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17884);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17885);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17886);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17887);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17888);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17889);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17890);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17891);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17892);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17893);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17894);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17895);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17896);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17897);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17898);
insert into cc_c_filter (filter_type, value) values ('ACD_SKILL_GROUP_INC', 17899);

commit;