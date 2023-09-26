delete from CORP_ETL_CONTROL Where name like 'PIN%';
commit;

insert into CORP_ETL_CONTROL
values ('PIN_PORTAL_SEARCHES_CREATE_DATE','D','2017/01/01 00:00:00','Max HCO F Portal Search by Date record creation date from source', sysdate, sysdate);


commit;
