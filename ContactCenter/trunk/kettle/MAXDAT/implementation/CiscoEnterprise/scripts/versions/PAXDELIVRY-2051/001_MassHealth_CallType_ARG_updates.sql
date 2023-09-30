alter session set current_schema = cisco_enterprise_cc;

insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CAC','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CAC Forced Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('CAC IVR ingress','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('EDI Support','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('EDI Support IVR ingress','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('EDISUPPR Forced Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('External Premium Billing Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Health Safety Net','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Health Safety Net IVR ingress','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('HLTSAFNE Forced Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Internal Transfer','TRANSFER',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MBRELGB Spanish Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MBRELGPLN Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MBRENROLL Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MBRHLTHPLN Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MBRMAP Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MBRS','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MBRS Forced Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Application Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Phone App Spanish Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Member Transportation Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MHPBS','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('MHPBS Forced Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('One Care English Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Provider Claims','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Provider Claims IVR ingress','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Provider Special Projects','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Provider Special Projects IVR ingress','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('PROVS','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('PROVS Forced Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('PRVCLAIM Forced Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('PRVPEC','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('PRVPEC Forced Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('PRVPEC IVR ingress','IVR',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('PRVSPLPR Forced Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Self Service Eligibility Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Self Service Transportation Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Spanish External Premium Billing Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Spanish MBRENROLL Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Spanish MBRHLTHPLN Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Spanish Member Transportation Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('TEST','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('TRANSPOR Forced Callback','Callback',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);
insert into cc_c_unit_of_work (unit_of_work_name, unit_of_work_category, record_eff_dt, record_end_dt, acd, ivr) values ('Transportation','INBOUND',to_date('1900/01/01', 'yyyy/mm/dd'),to_date('2999/12/31', 'yyyy/mm/dd'), 1, 0);


insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CAC','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CAC Forced Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('CAC IVR ingress','IVR',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('EDI Support','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('EDI Support IVR ingress','IVR',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('EDISUPPR Forced Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('External Premium Billing Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Health Safety Net','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Health Safety Net IVR ingress','IVR',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('HLTSAFNE Forced Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Internal Transfer','TRANSFER',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MBRELGB Spanish Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MBRELGPLN Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MBRENROLL Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MBRHLTHPLN Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MBRMAP Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MBRS','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MBRS Forced Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Application Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Phone App Spanish Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Member Transportation Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MHPBS','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('MHPBS Forced Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('One Care English Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Provider Claims','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Provider Claims IVR ingress','IVR',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Provider Special Projects','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Provider Special Projects IVR ingress','IVR',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('PROVS','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('PROVS Forced Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('PRVCLAIM Forced Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('PRVPEC','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('PRVPEC Forced Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('PRVPEC IVR ingress','IVR',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('PRVSPLPR Forced Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Self Service Eligibility Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Self Service Transportation Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Spanish External Premium Billing Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Spanish MBRENROLL Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Spanish MBRHLTHPLN Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Spanish Member Transportation Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('TEST','INBOUND',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('TRANSPOR Forced Callback','Callback',1, 'N', 'Seconds', 1, 0);
insert into cc_d_unit_of_work (unit_of_work_name, unit_of_work_category, production_plan_id, hourly_flag, handle_time_unit, acd, ivr) values ('Transportation','INBOUND',1, 'N', 'Seconds', 1, 0);


update cc_c_contact_queue set queue_type = 'IVR',Unit_of_work_name = 'CAC IVR ingress', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9068;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'CAC', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9069;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'CAC Forced Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9070;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'EDISUPPR Forced Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9071;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'HLTSAFNE Forced Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9072;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'MBRS Forced Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9105;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'MHPBS Forced Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9106;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'PROVS Forced Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9107;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'PRVCLAIM Forced Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9073;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'PRVPEC Forced Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9074;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'PRVSPLPR Forced Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9075;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'TRANSPOR Forced Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9108;
update cc_c_contact_queue set queue_type = 'IVR',Unit_of_work_name = 'EDI Support IVR ingress', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9076;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'EDI Support', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9077;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'External Premium Billing Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9086;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'Spanish External Premium Billing Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9091;
update cc_c_contact_queue set queue_type = 'IVR',Unit_of_work_name = 'Health Safety Net IVR ingress', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9078;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Health Safety Net', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9079;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'Member Application Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9087;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'MBRELGB Spanish Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9126;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'MBRELGPLN Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9125;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'MBRENROLL Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9065;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'Spanish MBRENROLL Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9127;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'MBRHLTHPLN Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9093;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'Spanish MBRHLTHPLN Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9129;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'MBRMAP Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9128;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'Member Phone App Spanish Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9130;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'MBRS', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9109;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'Member Transportation Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9088;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'Spanish Member Transportation Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9092;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'MHPBS', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9110;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'One Care English Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9090;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'PROVS', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9111;
update cc_c_contact_queue set queue_type = 'IVR',Unit_of_work_name = 'Provider Claims IVR ingress', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9080;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Provider Claims', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9081;
update cc_c_contact_queue set queue_type = 'IVR',Unit_of_work_name = 'PRVPEC IVR ingress', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9082;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'PRVPEC', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9083;
update cc_c_contact_queue set queue_type = 'IVR',Unit_of_work_name = 'Provider Special Projects IVR ingress', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9084;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Provider Special Projects', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9085;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'Self Service Eligibility Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9067;
update cc_c_contact_queue set queue_type = 'Callback',Unit_of_work_name = 'Self Service Transportation Callback', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9089;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'Transportation', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9112;
update cc_c_contact_queue set queue_type = 'Inbound',Unit_of_work_name = 'TEST', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9066;
update cc_c_contact_queue set queue_type = 'Transfer',Unit_of_work_name = 'Internal Transfer', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9113;
update cc_c_contact_queue set queue_type = 'Transfer',Unit_of_work_name = 'Internal Transfer', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9114;
update cc_c_contact_queue set queue_type = 'Transfer',Unit_of_work_name = 'Internal Transfer', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9064;
update cc_c_contact_queue set queue_type = 'Transfer',Unit_of_work_name = 'Internal Transfer', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9115;
update cc_c_contact_queue set queue_type = 'Transfer',Unit_of_work_name = 'Internal Transfer', project_name = 'Mass Health',  program_name = 'Customer Service Center', region_name = 'Eastern', state_name = 'Massachusetts', service_percent = 0, service_seconds = 30, interval_minutes = 15 where queue_number =9116;

update cc_c_contact_queue
set bucketintervalid = 5047
where queue_number = 9086;

--Agent Routing Groups

update cc_c_agent_rtg_grp 
set project_name = 'Mass Health', 
program_name = 'Customer Service Center', 
region_name = 'Eastern', 
state_name = 'Massachusetts' 
where agent_routing_group_number in 
(5599,
5600,
5601,
5602,
5603,
5604,
5605,
5606,
5607,
5608
);

insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5599);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5600);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5601);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5602);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5603);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5604);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5605);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5606);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5607);
insert into cc_c_filter (filter_type, value) values ('ACD_PQ_ID_INC', 5608);

commit;