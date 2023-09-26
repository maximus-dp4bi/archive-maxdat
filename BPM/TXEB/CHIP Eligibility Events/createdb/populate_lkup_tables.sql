insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) values (26,'CHIP Eligibility Events','Process is to monitor eligibility requests received from TIERS initiate appropriate work in the Enrollment Broker MAXeb.');

insert into BPM_SOURCE_LKUP (BSL_ID,NAME,BSTL_ID) values (26,'TXEB_ETL_CHIP_ELIG_EVENTS',9);

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,26,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'CHIP_ELIG_EVENTS','CALC_DCEECUR','Y');

insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (26,'Event ID');

commit;