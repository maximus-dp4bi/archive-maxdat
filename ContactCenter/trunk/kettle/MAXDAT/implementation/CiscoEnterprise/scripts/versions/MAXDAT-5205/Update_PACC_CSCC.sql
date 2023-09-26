
update cc_d_project set project_name = 'MI CSCC' where project_name = 'MI PACC';

update cc_d_program set program_name = 'Customer Support' where program_name = 'MI PACC';

update cc_c_project_config set project_name = 'MI CSCC', program_name = 'Customer Support' where project_name = 'MI PACC';

update cc_c_project_config set program_name = 'Customer Support' where project_name = 'MI CSCC';

update cc_c_contact_queue 
set queue_name = replace(queue_name,'PACC','CSCC'), unit_of_work_name = replace(unit_of_work_name,'PACC','CSCC'), project_name = 'MI CSCC'
, program_name = 'Customer Support'
where project_name = 'MI PACC';

update cc_c_contact_queue 
set program_name = 'Customer Support'
where project_name = 'MI CSCC';

update cc_c_unit_of_work set unit_of_work_name = replace(unit_of_work_name,'PACC','CSCC') where unit_of_work_name like '%PACC%';

update cc_d_unit_of_work set unit_of_work_name = replace(unit_of_work_name,'PACC','CSCC') where unit_of_work_name like '%PACC%';

update cc_c_lookup set lookup_value = 'East Lansing' where lookup_type = 'ACD_DESKSETTING_SITE' and lookup_key in (5023,5024);

update cc_c_lookup set lookup_value = 'Customer Support' where lookup_type = 'ACD_DESKSETTING_PROGRAM' and lookup_key in (5023,5024);

update cc_c_lookup set lookup_value = 'MI CSCC' where lookup_type = 'ACD_DESKSETTING_PROJECT' and lookup_key in (5023,5024);

update cc_c_lookup set lookup_value = 'MI CSCC' where lookup_type = 'ACD_PQ_PROJECT' and lookup_key in (5073,5074,5075,5076,5077);

update cc_c_lookup set lookup_value = 'Customer Support' where lookup_type = 'ACD_PQ_PROGRAM' and lookup_key in (5073,5074,5075,5076,5077);

update cc_a_list_lkup set value = 'MI CSCC', name = replace(name,'MIPACC','MICSCC') where value = 'MI PACC';

commit;




