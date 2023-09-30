delete from CORP_ETL_CONTROL 
Where name IN('MAX_SEL_OVERRIDE_RESP_PROCESSED_DATE','SLCTSEGMENT_SYNCH_LOOKBACK_DAYS');

commit;

insert into CORP_ETL_CONTROL
values ('MAX_SEL_OVERRIDE_RESP_PROCESSED_DATE','D','2020/10/01 00:00:00','Max processed date for override response from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('SLCTSEGMENT_SYNCH_LOOKBACK_DAYS','N','2','This is the number of lookback days used for the synchronizing selection segments', sysdate, sysdate);


commit;
