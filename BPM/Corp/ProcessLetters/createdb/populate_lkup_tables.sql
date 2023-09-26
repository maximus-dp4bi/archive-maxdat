/*
v1 Raj A. 07/28/2014 Creation.
v2 Raj A. 10/14/2015 Moved BPM_SOURCE_LKUP insert to project specific folder because it changes with each project (ex: NYHIX has BSTL_ID=8 and TNRD  BSTL_ID=1)
*/
insert into BPM_PROCESS_LKUP (BPROL_ID,NAME,DESCRIPTION) values (12,'Process Letters','Processing letter requests and receive outcome confirmation of letter processing');

insert into PROCESS_BPM_QUEUE_JOB_CONFIG (PBQJC_ID,BSL_ID,BDM_ID,ENABLED) values (SEQ_PBQJC_ID.nextval,12,2,'Y');

insert into PROCESS_BPM_CALC_JOB_CONFIG (PBCJC_ID,PACKAGE_NAME,PROCEDURE_NAME,PROCESS_ENABLED) 
values (SEQ_PBCJC_ID.nextval,'PROCESS_LETTERS','CALC_DPLCUR','Y');

insert into BPM_IDENTIFIER_TYPE_LKUP (BIL_ID,NAME) values (12,'Letter Request ID');

commit;

