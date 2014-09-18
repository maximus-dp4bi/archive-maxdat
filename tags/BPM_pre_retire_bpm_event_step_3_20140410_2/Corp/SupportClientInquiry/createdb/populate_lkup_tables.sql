insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) values (13,'Client Inquiry','Client Inbound contacts including web chats (not implemented yet).');

insert into bpm_source_type_lkup(bstl_id,name) values (9,'MAXEB ETL');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (13,'CORP_ETL_CLIENT_INQUIRY',9);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,13,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'CLIENT_INQUIRY','CALC_DSCICUR','Y');

-- For triggers
insert into bpm_identifier_type_lkup (bil_id,name) values (13, 'Call Record ID');

commit;