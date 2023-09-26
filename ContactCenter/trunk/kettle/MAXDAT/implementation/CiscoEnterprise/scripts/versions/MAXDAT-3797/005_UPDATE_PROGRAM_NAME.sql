update cc_c_project_config
set program_name = 'GA Healthy Babies'
where program_name = 'GA Healty Babies';

update cc_d_program
set program_name = 'GA Healthy Babies'
where program_name = 'GA Healty Babies';

update cc_c_contact_queue
set program_name = 'GA Healthy Babies'
where program_name = 'GA Healty Babies';

update cc_c_lookup
set lookup_value = 'GA Healthy Babies'
where lookup_value = 'GA Healty Babies';

commit;