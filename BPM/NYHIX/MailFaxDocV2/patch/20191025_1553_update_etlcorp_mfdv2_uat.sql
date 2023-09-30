Alter session set current_schema=MAXDAT;



update maxdat.corp_etl_control set value = '2019/10/25 00:00:00' where name='MAX_CREATE_DATE_DMS';

commit;


