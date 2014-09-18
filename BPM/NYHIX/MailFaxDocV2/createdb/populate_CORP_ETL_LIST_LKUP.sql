insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_V2_TIMELINESS_DAYS', 'MFD_V2_TIMELINESS', 'processmailv2_timeli_threshold','10',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_V2_TIMELINESS_DAYS_TYPE', 'MFD_V2_TIMELINESS_TYPE', 'Processmailv2_timeli_type','B',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_V2_JEOPARDY_DAYS', 'MFD_V2_JEOPARDY', 'processmailv2_jeopardy','6',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_V2_JEOPARDY_DAYS_TYPE', 'MFD_V2_JEOPARDY', 'processmailv2_jeopardy','B',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_V2_TARGET_DAYS', 'MFD_V2_TARGET', 'processmailv2_target','5',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

commit;