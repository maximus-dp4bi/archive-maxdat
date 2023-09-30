truncate table NYHIX_ETL_MAIL_FAX_DOC_APP_V2;

update CORP_ETL_CONTROL
set value = '3971'
where name = 'MAX_APP_DOC_INDV_ID' ;

update CORP_ETL_CONTROL
set value = '2013/10/1 00:00:00'
where name = 'MAX_CREATE_DATE_APP' ;

commit;