-- Add cancel attributes to look up tables

insert into bpm_attribute (ba_id,bal_id,bem_id,when_populated,effective_date,end_date,retain_history_flag) values (1781,722,10,'BOTH',sysdate,bpm_common.get_max_date,'N'); 
insert into bpm_attribute (ba_id,bal_id,bem_id,when_populated,effective_date,end_date,retain_history_flag) values (1782,547,10,'BOTH',sysdate,bpm_common.get_max_date,'N'); 
Insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1783,576,10,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 

Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,1781,10,'CANCEL_METHOD');
Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,1782,10,'CANCEL_REASON');
Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,1783,10,'CANCEL_BY');

commit;


-- Add cancel attributes to semantic tables

alter table D_PI_CURRENT add (CANCEL_BY varchar2(50),
                              CANCEL_REASON varchar2(256),
                              CANCEL_METHOD varchar2(50));

create or replace view D_PI_CURRENT_SV as
select * from D_PI_CURRENT
with read only;

commit;