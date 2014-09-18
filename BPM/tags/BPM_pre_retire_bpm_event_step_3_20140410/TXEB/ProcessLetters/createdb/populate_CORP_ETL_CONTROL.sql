insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LETTERS_LAST_UPDATE_DATE','D','2013/08/01 00:0:00','This is the timestamp of the letter_request.update_ts from the previous run. update_ts of the most recent letter record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LETTERS_START_DATE','D','2013/08/01 00:00:00','This is the timestamp for the letters create_ts.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('PL_LAST_LMREQ_ID','N',0,'Used to fetch Letters from OLTP for Process Letters  process',sysdate,sysdate);

commit;