
--insert bpm_attribute_lkup

Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (722,2,'Cancel Method','This is the method as per which the instance was cancelled');
update bpm_attribute_lkup set purpose = 'The reason that the instance is cancelled' where bal_id = 547 ;
update bpm_attribute_lkup set purpose = 'The name of the system or performer who cancelled the instance' where bal_id = 576;


-- insert bpm_attribute

Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1683,722,9,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1684,547,9,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1685,576,9,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');


--insert bpm_attribute_staging_table

Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,1683,9,'CANCEL_METHOD');
Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,1684,9,'CANCEL_REASON');
Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,1685,9,'CANCEL_BY');

commit;