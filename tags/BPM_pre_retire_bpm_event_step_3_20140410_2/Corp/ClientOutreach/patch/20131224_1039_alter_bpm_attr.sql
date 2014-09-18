/*insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1602, 2, 'Extra Effort - Other Indicator', 'Indicates if the extra effort referral is for a client who needs assistance with something Other than the other possible options.'
  ); */
  
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (	2589,	1602	,15	,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 

insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,	2589,	15,'EXEFF_OTHER_IND');

Commit;
