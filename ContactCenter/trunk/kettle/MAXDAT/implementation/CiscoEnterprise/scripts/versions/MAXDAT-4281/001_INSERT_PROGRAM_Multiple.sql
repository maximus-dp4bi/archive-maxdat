alter session set current_schema = cisco_enterprise_cc;

update cc_c_lookup
set lookup_value = 'Multiple'
where lookup_type = 'ACD_DESKSETTING_PROGRAM'
and lookup_key in (5039,
5040,
5010,
5011,
5044,
5045,
5035,
5036
);

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('Health Colorado', 'Multiple', 'West', 'Colorado', 'Unknown', 'Unknown', 'USA', to_date('01/01/1900','mm/dd/yyyy'), to_date('12/31/2999','mm/dd/yyyy'));

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('GA IES', 'Multiple', 'Eastern', 'Georgia', 'Unknown', 'Unknown', 'USA', to_date('01/01/1900','mm/dd/yyyy'), to_date('12/31/2999','mm/dd/yyyy'));

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('MIEB', 'Multiple', 'Eastern', 'Michigan', 'Unknown', 'Unknown', 'USA', to_date('01/01/1900','mm/dd/yyyy'), to_date('12/31/2999','mm/dd/yyyy'));

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('VA EB', 'Multiple', 'Eastern', 'Virginia', 'Unknown', 'Unknown', 'USA', to_date('01/01/1900','mm/dd/yyyy'), to_date('12/31/2999','mm/dd/yyyy'));

insert into cc_d_program (program_id, program_name, include_in_reports_flag)
values (SEQ_CC_D_PROGRAM.nextval, 'Multiple', 1);

commit;
