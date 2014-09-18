insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (393,2,'All MI Satisfied','Indicates if all MI (missing data and missing documents) that 
was created prior to or during processing of this instance was satisfied for this application as of the date processing was completed (MI Task Complete, QC 
Task Complete if required, Research Task Complete if required).');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (394,3,'New MI Creation Date','The first date/time that new MI was added to the 
application during processing of this instance.  New MI is defined as MI added to the application after the State Data Entry - MI task was created and before 
the completion of all tasks for this instance (Research, QC, and State Data Entry - MI) and not satisfied prior to completion of all tasks for this 
instance.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (395,3,'New MI Satisfied Date','The latest date/time that all new MI added to the 
application during processing of this instance was satisfied.  New MI is defined as MI added to the application after the State Data Entry - MI task was 
created and before the completion of all tasks for this instance (Research, QC, and State Data Entry - MI) and not satisfied prior to completion of all tasks 
for this instance.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (396,3,'MI Letter Sent Date','This is the date that the MI Letter Status was updated to 
"Sent".');

commit;

insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (477,393,5,'BOTH',sysdate,to_date('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (478,394,5,'BOTH',sysdate,to_date('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (479,395,5,'BOTH',sysdate,to_date('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (480,396,5,'BOTH',sysdate,to_date('20770707','YYYYMMDD'));

commit;

update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=477;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=478;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=479;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=480;

commit;

insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,477,5,'ALL_MI_SATISFIED');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,478,5,'NEW_MI_CREATION_DATE');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,479,5,'NEW_MI_SATISFIED_DATE');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,480,5,'MI_LETTER_SENT_ON');

commit;

alter table D_NYEC_PMI_CURRENT add 
  ("All MI Satisfied"              varchar2(1),
   "New MI Creation Date"          date,
   "New MI Satisfied Date"         date,
   "MI Letter Sent On"           date);
   
create or replace view D_NYEC_PMI_CURRENT_SV as
select * from D_NYEC_PMI_CURRENT 
with read only;
