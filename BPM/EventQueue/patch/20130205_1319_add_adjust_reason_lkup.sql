delete from PBQJ_ADJUST_REASON_LKUP where PBQJ_ADJUST_REASON_ID = 221;

insert into PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID,ADJUST_TYPE,REASON_NAME,DESCRIPTION) 
values (240,'STOP','BAD_METADATA','Job had bad metadata.');

insert into PBQJ_ADJUST_REASON_LKUP (PBQJ_ADJUST_REASON_ID,ADJUST_TYPE,REASON_NAME,DESCRIPTION) 
values (241,'STOP','STARTED','Job was started but not running.');

commit;
