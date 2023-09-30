Alter table nyhix_etl_mail_fax_doc_oltp add PROCESS_INSTANCE_ID number(18,0);

update corp_etl_list_lkup
set out_var = '3003,2013011,2013012,2013013,2013014,2013023,2013024,2013026,2013027,2013028,2013400'
where name = 'MFD_ESC_TASK_ID1'