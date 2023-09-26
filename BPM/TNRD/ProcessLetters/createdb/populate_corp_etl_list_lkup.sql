insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)
values('RTN_MAIL_SLA_DAYS_TYPE', 'RTN_MAIL_SLA', 'SLA_DAYS_TYPE','B',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)
values('RTN_MAIL_SLA_DAYS', 'RTN_MAIL_SLA', 'SLA_DAYS','7',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)
values('RTN_MAIL_JEOPARDY_DAYS', 'RTN_MAIL_SLA', 'JEOPARDY_DAYS','6',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

commit;