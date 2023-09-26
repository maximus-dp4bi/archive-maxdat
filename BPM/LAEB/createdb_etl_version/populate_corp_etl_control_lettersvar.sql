delete from CORP_ETL_CONTROL Where name like '%LETTER%';
commit;

insert into CORP_ETL_CONTROL
values ('MAX_LETTER_CREATE_DATE','D','2017/01/01 00:00:00','Max letter request creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_LETTER_UPDATE_DATE','D','2017/01/01 00:00:00','Max letter request update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_LETTER_LINK_CREATE_DATE','D','2017/01/01 00:00:00','Max letter request link creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('MAX_LETTER_LINK_UPDATE_DATE','D','2017/01/01 00:00:00','Max letter request link update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('LETTER_REQUEST_LOOKBACK_DAYS','N','2','This is the number of lookback days used to get the Letter Requests in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('LETTER_REQLINK_LOOKBACK_DAYS','N','2','This is the number of lookback days used to get the Letter Request Link records in each run', sysdate, sysdate);

commit;
