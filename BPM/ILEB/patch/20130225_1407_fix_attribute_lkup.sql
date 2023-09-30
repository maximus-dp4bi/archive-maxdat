--select * from bpm_region_lkup
INSERT INTO bpm_region_lkup(brl_id, NAME) VALUES(1,'EAST');
INSERT INTO bpm_region_lkup(brl_id, NAME) VALUES(2,'CENTRAL');
INSERT INTO bpm_region_lkup(brl_id, NAME) VALUES(3,'WEST');


--select * from bpm_program_lkup
INSERT INTO bpm_program_lkup(bprg_id, NAME) VALUES(1,'EB');
INSERT INTO bpm_program_lkup(bprg_id, NAME) VALUES(2,'ES');

--select * from bpm_source_type_lkup
INSERT INTO bpm_source_type_lkup(bstl_id, NAME) VALUES(1,'ATS ETL');

--select * from bpm_identifier_type_lkup
INSERT INTO bpm_identifier_type_lkup(bil_id, name) VALUES(1, 'Document ID');
INSERT INTO bpm_identifier_type_lkup(bil_id, name) VALUES(2, 'Application ID');
INSERT INTO bpm_identifier_type_lkup(bil_id, name) VALUES(3, 'Task ID');
INSERT INTO bpm_identifier_type_lkup(bil_id, name) VALUES(4, 'Batch ID');

--select * from bpm_update_type_lkup
INSERT INTO bpm_update_type_lkup(butl_id, name) VALUES(1, 'ETL');

--select * from bpm_activity_type_lkup
INSERT INTO bpm_activity_type_lkup(bactl_id, activity_type_cd, activity_type_desc) VALUES(1,'A','Activity Step');
INSERT INTO bpm_activity_type_lkup(bactl_id, activity_type_cd, activity_type_desc) VALUES(2,'G','Gateway');
INSERT INTO bpm_activity_type_lkup(bactl_id, activity_type_cd, activity_type_desc) VALUES(3,'E','End Point');

--select * from bpm_activity_event_type_lkup
INSERT INTO bpm_activity_event_type_lkup(bacetl_id,event_type_name,event_type_order) VALUES(1,'Start',1);
INSERT INTO bpm_activity_event_type_lkup(bacetl_id,event_type_name,event_type_order) VALUES(2,'Cancel',2);
INSERT INTO bpm_activity_event_type_lkup(bacetl_id,event_type_name,event_type_order) VALUES(3,'Complete',3);

--select * from bpm_datatype_lkup
INSERT INTO bpm_datatype_lkup(bdl_id, datatype) VALUES(1,'NUMBER');
INSERT INTO bpm_datatype_lkup(bdl_id, datatype) VALUES(2,'VARCHAR');
INSERT INTO bpm_datatype_lkup(bdl_id, datatype) VALUES(3,'DATE');


insert into bpm_source_lkup(BSL_ID,NAME,BSTL_ID) values (1,'CORP_ETL_MANAGE_WORK',1);

INSERT INTO bpm_event_master(bem_id,brl_id,bprj_id,bprg_id,bprol_id,name,description,effective_date,end_date) VALUES(1,	1,	7,	1,	1,	'ILEB OPS Manage Work',	'ILEB Operations Manage Work',SYSDATE,to_date('77770707','YYYYMMDD'));

commit;

commit;