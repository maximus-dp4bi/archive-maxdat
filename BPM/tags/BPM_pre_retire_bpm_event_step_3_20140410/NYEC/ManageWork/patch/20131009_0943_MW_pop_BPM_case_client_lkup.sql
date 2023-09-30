-- 10/9/13 B.Thai remaining BPM lookups for Manage Work on NYEC. For NYEC-5395 deployment.

declare
begin
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(593,1,'Client_ID','Unique identifier associated to the client level task in MAXe');
  BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(479,1,'Case_ID','Unique identifier associated to the case level task in MAXe');

  insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1686,593,1,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 
  insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (1687,479,1,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 

  insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1686,1,'CLIENT_ID');
  insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,1687,1,'CASE_ID');

  commit;

end;
/

