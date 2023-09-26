update cc_c_contact_queue
set program_name = 'EEV'
	, project_name = 'IL EEV'
where queue_number in (10012
  ,10013
  ,10021
  ,10020
  ,10014
  ,10015);
commit;

insert into cc_l_patch_log (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
values ('0.3.1',111,'111_UPDATE_EEV_CONTACT_QUEUES');
commit;