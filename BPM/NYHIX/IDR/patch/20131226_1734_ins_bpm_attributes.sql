insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('IDRS_STAGE_DONE','N','6','Number of months to add to complete date to set the stage done date',sysdate,sysdate);

begin
BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(178,2,'Current Step','The Current Activity Step identifes where the instance is in the process.');
end;
/

insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) values (2597,178,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N'); 

Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.NEXTVAL,2597,21,	'CURRENT_STEP');

commit;