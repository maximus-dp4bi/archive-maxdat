insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_TIMELINESS_DAYS', 'MFD_TIMELINESS', 'APPLICATION','35',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_TIMELINESS_DAYS_TYPE', 'MFD_TIMELINESS_TYPE', 'APPLICATION','B',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_JEOPARDY_DAYS', 'MFD_JEOPARDY', 'APPLICATION','20',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_JEOPARDY_DAYS_TYPE', 'MFD_JEOPARDY', 'APPLICATION','B',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);


insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_TIMELINESS_DAYS', 'MFD_TIMELINESS', 'APPLICATION_PACKET','35',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_TIMELINESS_DAYS_TYPE', 'MFD_TIMELINESS_TYPE', 'APPLICATION_PACKET','B',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_JEOPARDY_DAYS', 'MFD_JEOPARDY', 'APPLICATION_PACKET','20',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_JEOPARDY_DAYS_TYPE', 'MFD_JEOPARDY', 'APPLICATION_PACKET','B',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);



insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_TIMELINESS_DAYS', 'MFD_TIMELINESS', 'RETURN_MAIL',null,trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_TIMELINESS_DAYS_TYPE', 'MFD_TIMELINESS_TYPE', 'RETURN_MAIL',null,trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_JEOPARDY_DAYS', 'MFD_JEOPARDY', 'RETURN_MAIL',null,trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_JEOPARDY_DAYS_TYPE', 'MFD_JEOPARDY', 'RETURN_MAIL',null,trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);


insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_TIMELINESS_DAYS', 'MFD_TIMELINESS', 'OTHER',null,trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_TIMELINESS_DAYS_TYPE', 'MFD_TIMELINESS_TYPE', 'OTHER',null,trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_JEOPARDY_DAYS', 'MFD_JEOPARDY', 'OTHER',null,trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_JEOPARDY_DAYS_TYPE', 'MFD_JEOPARDY', 'OTHER',null,trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);


--need to know all valid verification docs and their jeopardy/timeliness info

--For linking SLAs
insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_LINKING_SLA_DAYS', 'MFD_LINKING_SLA', 'LINK','3',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_LINKING_SLA_DAYS_TYPE', 'MFD_LINKING_SLA_TYPE', 'LINK','B',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_LINKING_JEOPARDY_DAYS', 'MFD_LINKING_JEOPARDY', 'LINK','2',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);

insert into corp_etl_list_lkup (name,list_type,value,out_var,start_date,end_date,created_ts,updated_ts)values('MFD_LINKING_JEOPARDY_DAYS_TYPE', 'MFD_LINKING_JEOPARDY', 'LINK','B',trunc(sysdate),to_date('07-jul-7777','dd-mon-yyyy'),sysdate,sysdate);


commit;