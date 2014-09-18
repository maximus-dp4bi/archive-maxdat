insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPEALS_STAGE_DONE','N','6','Number of months to add to complete date to set the stage done date',sysdate,sysdate);

begin
BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(1603,3,'Received Date','Captured as an index field during document processing and is transmitted to DMS as XML for XSD Document Type= Incident AND XSD Form Type = Appeal. It is the create_ts from the doc_link table in the source');
BPM_EVENT.INSERT_BPM_ATTRIBUTE_LKUP(178,2,'Current Step','The Current Activity Step identifes where the instance is in the process.');
end;
/

INSERT INTO BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) VALUES(2590,178,23,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');
INSERT INTO BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) VALUES(2591,1603,23,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'N');

Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,	2590	,23,	'CURRENT_STEP');
Insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values (SEQ_BAST_ID.NEXTVAL,	2591	,23,	'RECEIVED_DT');


commit;