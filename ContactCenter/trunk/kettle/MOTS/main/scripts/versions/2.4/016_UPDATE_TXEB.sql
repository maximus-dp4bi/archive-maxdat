
update d_project
set project_name = 'TX Enrollment Broker'
where project_name = 'TX EB'
;

insert into cc_l_patch_log (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
values ('2.4',016,'016_UPDATE_TXEB');

commit;