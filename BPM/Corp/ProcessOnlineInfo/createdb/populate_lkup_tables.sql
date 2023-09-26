insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) values (19,'Process Online Info','The Self-Service Portal provides 24 hour access to information enabling individuals to compare Health Plans, review answers to Frequently Asked Questions(FAQs) and conduct provider searches.');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (19,'CORP_ETL_PROCESS_ONLINE_INFO',9);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,19,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'PROCESS_ONLINE_INFO','CALC_DONLCUR','Y');

insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (19,'TRANSACTION_ID');

commit;