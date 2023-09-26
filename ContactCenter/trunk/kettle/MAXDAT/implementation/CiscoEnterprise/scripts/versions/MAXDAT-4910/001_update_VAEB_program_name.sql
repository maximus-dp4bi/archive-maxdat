alter session set current_schema = cisco_enterprise_cc;

insert into cc_c_project_config (project_name, program_name, region_name, state_name, province_name, district_name, country_name, record_eff_dt, record_end_dt)
values ('VA EB', 'Medallion', 'Eastern', 'Virginia', 'Unknown', 'Unknown', 'USA', to_date('01/01/1900','mm/dd/yyyy'), to_date('12/31/2999','mm/dd/yyyy'));

update cc_c_project_config
set program_name = 'CCC'
where project_name = 'VA EB'
and program_name = 'VA EB';

update cc_c_contact_queue
set unit_of_work_name = 'Medallion English'
where queue_number in (5726, 5727);

update cc_c_contact_queue
set program_name = 'Medallion'
where queue_number in (5721,
5722,
5726,
5727,
5730,
5736
);

update cc_c_contact_queue
set program_name = 'CCC'
where queue_number in (5728,
5729
);

update cc_c_lookup
set lookup_value = 'Medallion'
where lookup_type = 'ACD_PQ_PROGRAM'
and lookup_key in (5092,
5093,
5095);

update cc_c_lookup
set lookup_value = 'CCC'
where lookup_type = 'ACD_PQ_PROGRAM'
and lookup_key in (5091,
5094);

update cc_d_program
set program_name = 'CCC'
where program_name = 'VA EB';

insert into cc_d_program (program_id, program_name, include_in_reports_flag)
values (SEQ_CC_D_PROGRAM.nextval, 'Medallion', 1);

commit;


