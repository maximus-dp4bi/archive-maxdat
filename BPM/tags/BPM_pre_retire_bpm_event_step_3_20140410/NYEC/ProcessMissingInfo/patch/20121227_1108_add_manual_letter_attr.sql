insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (312,2,'Manual Letter Flag','Manual letter gateway flag.');

insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE) values (447,312,5,'BOTH',SYSDATE,TO_DATE('20770707','YYYYMMDD'));

update BPM_ATTRIBUTE set RETAIN_HISTORY_FLAG ='N' where BA_ID=447;

commit;