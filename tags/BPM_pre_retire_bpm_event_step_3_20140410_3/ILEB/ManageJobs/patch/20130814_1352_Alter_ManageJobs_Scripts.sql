ALTER TABLE CORP_ETL_MANAGE_JOBS
  ADD (CANCEL_BY VARCHAR2(80 BYTE), 
CANCEL_REASON VARCHAR2(40 BYTE),
CANCEL_METHOD VARCHAR2(40 BYTE));
       
       
ALTER TABLE CORP_ETL_MANAGE_JOBS_OLTP
  ADD (CANCEL_BY VARCHAR2(80 BYTE), 
CANCEL_REASON VARCHAR2(40 BYTE),
CANCEL_METHOD VARCHAR2(40 BYTE));

ALTER TABLE CORP_ETL_MANAGE_JOBS_WIP_BPM
  ADD (CANCEL_BY VARCHAR2(80 BYTE), 
CANCEL_REASON VARCHAR2(40 BYTE),
CANCEL_METHOD VARCHAR2(40 BYTE));




--insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1693,576,11,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
--insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1694,722,11,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2179,576,11,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2180,722,11,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');

commit;


--insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1523,11,'CANCEL_REASON'); 
--insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1693,11,'CANCEL_BY'); 
--insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1694,11,'CANCEL_METHOD'); 
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1523,11,'CANCEL_REASON'); 
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,2179,11,'CANCEL_BY'); 
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,2180,11,'CANCEL_METHOD'); 
commit;


ALTER TABLE D_MJ_CURRENT
ADD (CANCEL_BY VARCHAR2(80 BYTE),
CANCEL_METHOD VARCHAR2(40 BYTE)
);

create or replace view D_MJ_CURRENT_SV as
select * from D_MJ_CURRENT 
with read only;
