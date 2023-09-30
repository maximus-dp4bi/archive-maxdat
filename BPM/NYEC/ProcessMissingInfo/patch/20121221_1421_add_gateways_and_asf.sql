insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (312,2,'Manual Letter Flag','Manual letter gateway flag.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (365,2,'QC Required - Phone Flag','QC required phone gateway flag.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (366,2,'Update State System Flag','Update state system gateway flag.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (367,2,'Send Research Flag','Send research gateway flag.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (368,2,'MI Outcome Flag','MI outcome gateway flag.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (369,2,'Receive MI Flag','Receive MI accept activity step flag.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (370,2,'Create State Accept Flag','Create state accept activity step flag.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (371,2,'Determine MI Outcome Flag','Determine MI Outcome activity step flag.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (372,2,'Complete MI Task Flag','Determine MI Task activity step flag.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (373,2,'Perform QC on MI Flag','Perform QC on MI activity step flag.');
insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (374,2,'Send MI Letter Flag','Send MI Letter activity step flag.');

insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (444, 49,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (445,365,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (446,366,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (447,312,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (448,367,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (449, 98,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (450, 97,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (451,368,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (452,369,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (453,370,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (454,371,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (455,372,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (456,373,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (457, 89,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (458,374,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));

update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=444;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=445;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=446;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=447;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=448;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=449;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=450;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=451;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=452;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=453;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=454;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=455;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=456;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=457;
update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=458;

insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,444,5,'GWF_CHANNEL');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,445,5,'GWF_PHONE_QC_REQ');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,446,5,'GWF_UPDATE_STATE');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,447,5,'GWF_MANUAL_LETTER');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,448,5,'GWF_SEND_RESEARCH');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,449,5,'GWF_QC_REQUIRED');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,450,5,'GWF_QC_OUTCOME');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,451,5,'GWF_MI_OUTCOME');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,452,5,'ASF_RECEIVE_MI');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,453,5,'ASF_CREATE_STATE_ACCEPT');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,454,5,'ASF_DETERMINE_MI_OUTCOME');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,455,5,'ASF_COMPLETE_MI_TASK');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,456,5,'ASF_PERFORM_QC');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,457,5,'ASF_PERFORM_RESEARCH');
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,458,5,'ASF_SEND_MI_LETTER');

commit;

drop index DNPMICUR_UIX1;
create index DNPMICUR_UIX1 on D_NYEC_PMI_CURRENT ("Cur Application ID") online tablespace MAXDAT_INDX parallel compute statistics; 

alter table D_NYEC_PMI_CURRENT add
  ("Channel Flag"                  varchar2(1),
   "QC Required - Phone Flag"      varchar2(1),
   "Update State System Flag"      varchar2(1),
   "Manual Letter Flag"            varchar2(1),
   "Send Research Flag"            varchar2(1),
   "QC Required Flag"              varchar2(1),
   "QC Outcome Flag"               varchar2(1),
   "MI Outcome Flag"               varchar2(1),
   "Receive MI Flag"               varchar2(1),
   "Create State Accept Flag"      varchar2(1),
   "Determine MI Outcome Flag"     varchar2(1),
   "Complete MI Task Flag"         varchar2(1),
   "Perform QC on MI Flag"         varchar2(1),
   "Perform Research Flag"         varchar2(1),
   "Send MI Letter Flag"           varchar2(1));

create or replace view D_NYEC_PMI_CURRENT_SV as
select * from D_NYEC_PMI_CURRENT 
with read only;