alter table NYHIX_ETL_MAIL_FAX_DOC_OLTP add (DOCUMENT_NOTIFICATION_ID number(18,0));
commit;

update corp_etl_list_lkup
set out_var = '2013029'
where name = 'MFD_APPEAL_DE_TASK_ID';

update corp_etl_list_lkup
set out_var = '2013011,2013012,2013013,2013014,2013023,2013024,2013026,2013027,2013028'
where name = 'MFD_ESC_TASK_ID1';
commit;

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_DOC_TYPE_WEB', 'MFD_DOC_TYPE_WEB', 'Document Type for web docs','VERIFICATION_DOCUMENT',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);
commit;

update CORP_ETL_CONTROL
set value=30
where name='MFD_DOC_LOOK_BACK_DAYS';

commit;