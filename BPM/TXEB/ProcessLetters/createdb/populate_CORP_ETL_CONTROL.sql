insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LETTERS_LAST_UPDATE_DATE','D','2013/08/01 00:0:00','This is the timestamp of the letter_request.update_ts from the previous run. update_ts of the most recent letter record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LETTERS_START_DATE','D','2013/08/01 00:00:00','This is the timestamp for the letters create_ts.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('PL_LAST_LMREQ_ID','N',0,'Used to fetch Letters from OLTP for Process Letters  process',sysdate,sysdate);


Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('RUN_DAILY_LETTERS_START','V','200000','RUN_LETTER_STARTTIME ',to_date('19-SEP-13','DD-MON-RR'),to_date('19-SEP-13','DD-MON-RR'));
Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) values ('RUN_DAILY_LETTERS_END','V','230000','RUN_LETTER_ENDTIME ',to_date('19-SEP-13','DD-MON-RR'),to_date('19-SEP-13','DD-MON-RR'));

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('PL_BAD_ADDRESS_LAST_JOB_ID','N','0','Used to fetch Letters Bad address data from OLTP',sysdate,sysdate);



commit;