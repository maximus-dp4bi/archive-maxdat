insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('DOC_TIMELINESS_DAYS', 'DOC_TIMELINESS', 'flhk_doc_timeli_threshold','5',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('DOC_TIMELINESS_DAYS_TYPE', 'DOC_TIMELINESS_TYPE', 'flhk_doc_timeli_type','B',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('DOC_JEOPARDY_DAYS', 'DOC_JEOPARDY', 'flhk_doc_jeopardy_threshold','3',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('DOC_JEOPARDY_DAYS_TYPE', 'DOC_JEOPARDY', 'flhk_doc_jeopardy_type','B',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('DOC_TARGET_DAYS', 'DOC_TARGET', 'flhk_doc_target_days','2',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

commit;