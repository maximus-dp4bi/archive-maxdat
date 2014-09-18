-- Populate BPM_ATTRIBUTE_LKUP 

insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (346,3,'HEART MI Due Date','This is the date that is 15 calendar days from the date the MI record was created');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (347,3,'MAXe MI Due Date','This is the date that is 15 calendar days from the date the MI record was created and is synced with the HEART MI Due Date');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (348,2,'MI Type','The MI Type is the name of each MI on the application.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (349,2,'MI Letter Name','The MI Letter Name is the unique name of the MI letter sent to the client.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (350,2,'MI Satisfied Reason','The MI Satisfied Reason is selected by the RA from the ''Satisfied Reason'' drop down on the MI sub tab to satisfy missing information in Maxe');


-- Populate BPM_ATTRIBUTE 

insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (420,346,4,'BOTH',sysdate,to_date('20770707','YYYYMMDD'),'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (421,347,4,'BOTH',sysdate,to_date('20770707','YYYYMMDD'),'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (422,348,4,'BOTH',sysdate,to_date('20770707','YYYYMMDD'),'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (423,349,4,'BOTH',sysdate,to_date('20770707','YYYYMMDD'),'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (424,350,4,'BOTH',sysdate,to_date('20770707','YYYYMMDD'),'N');


--Populate BPM_ATTRIBUTE_STAGING_TABLE 

insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.NEXTVAL,420,4,'HEART_MI_DUE_DT');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.NEXTVAL,421,4,'MAXE_MI_DUE_DT');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.NEXTVAL,422,4,'MI_TYPE_NAME');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.NEXTVAL,423,4,'MI_LETTER_NAME');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.NEXTVAL,424,4,'MI_ITEM_SATISFIED_REASON');

commit;

-- Delete MI Item Satisfied Channel entry from lkup tables

delete from bpm_instance_attribute where ba_id=234;

commit;

delete from bpm_attribute where ba_id=234;

delete from bpm_attribute_lkup where bal_id=213;

delete from bpm_attribute_staging_table where ba_id=234;

commit;

-- Delete UNDELIVERABLE_* columns from BPM_ATTRIBUTE_STAGING_TABLE as per Elizabeth T Wright's suggestion 11/13/12
-- REFER_TO_DISTRCI_* have never been inserted into BPM_ATTRIBUTE_STAGING_TABLE

delete from bpm_attribute_staging_table
where 
  bsl_id=4
  and ba_id in (240,241);

commit;