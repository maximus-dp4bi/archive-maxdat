insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (1605,3,'Origination Dt','The date the instance was originated.');
insert into BPM_ATTRIBUTE values (2598,1605,18,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.nextval,2598,18,'ORIGINATION_DT');

commit;

delete from BPM_ATTRIBUTE_STAGING_TABLE where BA_ID = 2204 and BSL_ID = 18 and STAGING_TABLE_COLUMN = 'RECEIPT_DT';
delete from BPM_ATTRIBUTE where BA_ID = 2204 and BAL_ID = 100;

delete from BPM_ATTRIBUTE_STAGING_TABLE where BA_ID = 2481 and BSL_ID = 18 and STAGING_TABLE_COLUMN = 'DOC_COMPLETE_DT';
delete from BPM_ATTRIBUTE where BA_ID = 2481 and BAL_ID = 1541;
delete from BPM_ATTRIBUTE_LKUP where BAL_ID = 1541 and NAME = 'Document Complete Dt';

commit;