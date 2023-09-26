alter session set current_schema = MAXDAT;

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)
values('APPLICATION_SLA_DAYS_TYPE', 'APPLICATION_SLA', 'SLA_DAYS_TYPE','B',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)
values('APPLICATION_SLA_DAYS8', 'APPLICATION_SLA', 'SLA_DAYS8','8',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)
values('APPLICATION_SLA_DAYS5', 'APPLICATION_SLA', 'SLA_DAYS5','5',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)
values('APPLICATION_JEOPARDY_DAYS8', 'APPLICATION_SLA', 'JEOPARDY_DAYS8','7',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)
values('APPLICATION_JEOPARDY_DAYS5', 'APPLICATION_SLA', 'JEOPARDY_DAYS5','4',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

commit;