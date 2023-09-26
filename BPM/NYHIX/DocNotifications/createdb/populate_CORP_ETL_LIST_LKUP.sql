insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('DN_TIMELINESS_DAYS', 'DN_TIMELINESS', 'processdocnotif_timeli_threshold','10',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('DN_TIMELINESS_DAYS_TYPE', 'DN_TIMELINESS_TYPE', 'Processdocnotif_timeli_type','B',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('DN_JEOPARDY_DAYS', 'DN_JEOPARDY', 'processdocnotif_jeopardy','6',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('DN_JEOPARDY_DAYS_TYPE', 'DN_JEOPARDY', 'processdocnotif_jeopardy','B',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('DN_TARGET_DAYS', 'DN_TARGET', 'processdocnotif_target','5',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

commit;