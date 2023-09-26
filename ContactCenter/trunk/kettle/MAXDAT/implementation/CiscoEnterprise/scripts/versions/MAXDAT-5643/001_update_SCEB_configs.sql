alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - Benefits English'
where queue_number = 6374;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - Benefits Spanish'
where queue_number = 6375;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - Eligibility English'
where queue_number = 6377;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - Eligibility Spanish'
where queue_number = 6378;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - Enrollment English'
where queue_number = 6380;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - Enrollment Spanish'
where queue_number = 6381;

update cc_c_contact_queue
set queue_type = 'Escalation', unit_of_work_name = 'SCEB - Escalation'
where queue_number in (6382, 6388, 6655, 6656);

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - General English'
where queue_number = 6383;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - General Spanish'
where queue_number = 6384;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - Provider English'
where queue_number = 6386;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - Provider Spanish'
where queue_number = 6387;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - English'
where queue_number in (6389, 6652, 6654);

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - Spanish'
where queue_number in (6390, 6653, 6657);

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - Services English'
where queue_number = 6391;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - Services Spanish'
where queue_number = 6392;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - Status English'
where queue_number = 6393;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = 'SCEB - Status Spanish'
where queue_number = 6394;

update cc_c_contact_queue
set queue_type = 'IVR', unit_of_work_name = 'SCEB - Main IVR', queue_name = 'FLFP_SCEB_4642_SM1_106493'
where queue_number = 6400;

update cc_c_contact_queue
set queue_type = 'Voicemail', unit_of_work_name = 'SCEB - Voicemail'
where queue_number = 6402;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - English'
where queue_number in (6618, 6619, 6620, 6621);

update cc_c_contact_queue
set queue_type = 'Escalation', unit_of_work_name = '1095 - Escalation'
where queue_number in (6622, 6741);

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - Spanish'
where queue_number = 6623;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - Spanish'
where queue_number = 6624;

update cc_c_contact_queue
set queue_type = 'IVR', unit_of_work_name = '1095 - Main IVR', queue_name = 'FLFP_1095_7842_SM1_106493'
where queue_number = 6625;

update cc_c_contact_queue
set queue_type = 'Transfer', unit_of_work_name = 'SCEB - Spanish'
where queue_number in (6650, 6736);

update cc_c_contact_queue
set queue_type = 'Transfer', unit_of_work_name = 'SCEB - English'
where queue_number in (6651, 6735);

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - English'
where queue_number in (6704, 6705, 6707, 6708, 6737, 6738);

update cc_c_contact_queue
set queue_type = 'Transfer', unit_of_work_name = '1095 - English'
where queue_number in (6706, 6709);

update cc_c_contact_queue
set queue_name = 'FLFP_1095_7842_SECSR2_XFR'
where queue_number = 6706;

update cc_c_contact_queue
set queue_name = 'FLFP_1095_7842_SECSR_XFR'
where queue_number = 6709;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - Spanish'
where queue_number in (6711, 6712, 6715, 6716, 6739, 6740);

update cc_c_contact_queue
set queue_type = 'Transfer', unit_of_work_name = '1095 - Spanish'
where queue_number in (6713, 6717);

update cc_c_contact_queue
set queue_name = 'FLFP_1095_7842_SSCSR2_XFR'
where queue_number = 6713;

update cc_c_contact_queue
set queue_name = 'FLFP_1095_7842_SSCSR_XFR'
where queue_number = 6717;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - General English'
where queue_number = 6718;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - Address Update English'
where queue_number = 6719;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - General Spanish'
where queue_number = 6720;

update cc_c_contact_queue
set queue_type = 'Inbound', unit_of_work_name = '1095 - Address Update Spanish'
where queue_number = 6721;

update cc_c_contact_queue
set queue_type = 'Escalation', unit_of_work_name = 'SCEB - Escalation'
where queue_number = 6734;

update cc_c_contact_queue
set service_seconds = 20, interval_minutes = 15
where queue_number in (6389, 6390, 6713, 6717);

update cc_c_contact_queue
set service_seconds = 30, interval_minutes = 15
where queue_number in (6706, 6709, 6718, 6719, 6720, 6721);

update cc_c_contact_queue
set queue_name = 'FLFP_1095_7842_SSCSR2'
where queue_number = 6720;

update cc_c_contact_queue
set queue_name = 'FLFP_1095_7842_SSCSR'
where queue_number = 6721;

update cc_c_contact_queue
set queue_name = 'FLFP_SCEB_4642_ESC'
where queue_number = 6734;

update cc_c_contact_queue
set queue_name = 'FLFP_SCEB_4642_SEGEN_XFER'
where queue_number = 6735;

update cc_c_contact_queue
set queue_name = 'FLFP_SCEB_4642_SSGEN_XFER'
where queue_number = 6736;

insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Benefits English','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Benefits Spanish','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
--insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - After Hours','After Hours',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Eligibility English','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Eligibility Spanish','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Enrollment English','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Enrollment Spanish','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - General English','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - General Spanish','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Provider English','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Provider Spanish','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
--insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Escalation','Escalation',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - English','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Spanish','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Services English','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Services Spanish','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Status English','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Status Spanish','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Main IVR','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
--insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('SCEB - Voicemail','Voicemail',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
--insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - After Hours','After Hours',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - English','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - Escalation','Escalation',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - Spanish','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - Main IVR','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - General English','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - Address Update English','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - General Spanish','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);
insert into cc_c_unit_of_work(unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, ACD, IVR) values ('1095 - Address Update Spanish','Inbound',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'),1,0);

update cc_c_unit_of_work
set unit_of_work_category = 'After Hours'
where unit_of_work_name in ('SCEB - After Hours', '1095 - After Hours');

insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Benefits English','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Benefits Spanish','Inbound',15,'N','Seconds');
--insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - After Hours','After Hours',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Eligibility English','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Eligibility Spanish','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Enrollment English','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Enrollment Spanish','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - General English','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - General Spanish','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Provider English','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Provider Spanish','Inbound',15,'N','Seconds');
--insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Escalation','Escalation',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - English','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Spanish','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Services English','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Services Spanish','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Status English','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Status Spanish','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Main IVR','IVR',15,'N','Seconds');
--insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('SCEB - Voicemail','Voicemail',15,'N','Seconds');
--insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - After Hours','After Hours',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - English','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - Escalation','Escalation',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - Spanish','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - Main IVR','IVR',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - General English','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - Address Update English','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - General Spanish','Inbound',15,'N','Seconds');
insert into cc_d_unit_of_work(unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit) values ('1095 - Address Update Spanish','Inbound',15,'N','Seconds');

update cc_d_unit_of_work
set unit_of_work_category = 'After Hours'
where unit_of_work_name in ('SCEB - After Hours', '1095 - After Hours');

UPDATE CC_A_LIST_LKUP
SET OUT_VAR = 'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS - AGENT_ERROR_COUNT - ERROR_COUNT - CALLS_ROUTED_NON_AGENT - RETURN_RELEASE - CALLS_RONA - RETURN_BUSY - NETWORK_DEFAULT_ROUTED - ICR_DEFAULT_ROUTED - RETURN_RING - INCOMPLETE_CALLS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
WHERE VALUE = 'SCEB' 
AND LIST_TYPE = 'CC_S_ACD_INTERVAL-CALLS_OFFERED';

UPDATE CC_A_LIST_LKUP
SET OUT_VAR = 'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS - AGENT_ERROR_COUNT - ERROR_COUNT - CALLS_ROUTED_NON_AGENT - RETURN_RELEASE - CALLS_RONA - RETURN_BUSY - NETWORK_DEFAULT_ROUTED - ICR_DEFAULT_ROUTED - RETURN_RING - INCOMPLETE_CALLS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
WHERE VALUE = 'SCEB' 
AND LIST_TYPE = 'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED';

update cc_c_contact_queue
set project_name = 'SCEB', program_name = 'Managed Care', region_name = 'Eastern', state_name = 'South Carolina'
where queue_number in (6374,
6375,
6376,
6377,
6378,
6380,
6381,
6382,
6383,
6384,
6385,
6386,
6387,
6388,
6389,
6390,
6391,
6392,
6393,
6394,
6400,
6401,
6402,
6613,
6616,
6618,
6619,
6620,
6621,
6622,
6623,
6624,
6625,
6650,
6651,
6652,
6653,
6654,
6655,
6656,
6657,
6704,
6705,
6706,
6707,
6708,
6709,
6711,
6712,
6713,
6715,
6716,
6717,
6718,
6719,
6720,
6721,
6734,
6735,
6736,
6737,
6738,
6739,
6740,
6741
);

commit;