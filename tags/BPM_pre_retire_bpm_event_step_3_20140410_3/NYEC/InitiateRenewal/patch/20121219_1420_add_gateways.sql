insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (363,2,'File Process Successful Flag','File process successful gateway flag.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (364,2,'Process Exception Result Flag','Process exception result gateway flag.');

insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (442,363,6,'BOTH',sysdate,to_date('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (443,364,6,'BOTH',sysdate,to_date('20770707','YYYYMMDD'));

update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=442;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=443;

insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,442,6,'GWF_FILE_PROC_RES');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,443,6,'GWF_EXCEPT_RES');

alter table D_NYEC_IR_CURRENT add (
  "File Process Successful Flag" varchar2(1),
  "Process Exception Result Flag" varchar2(1));

create or replace view D_NYEC_IR_CURRENT_SV as
select * from D_NYEC_IR_CURRENT
with read only;

commit;