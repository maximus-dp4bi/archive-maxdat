insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'MFB_TIMELINESS_DAYS'
,'TIMELINESS_DAYS_THRESHOLD'
,'Threshold for Timeliness Days'
,'2'
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'MFB_TIMELINESS_DAYS_TYPE'
,'TIMELINESS_DAYS_TYPE_THRESHOLD'
,'Threshold for Timeliness Days Type'
,'B'
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'MFB_JEOPARDY_DAYS'
,'JEOPARDY_DAYS_THRESHOLD'
,'Threshold for Jeopardy Days'
,'1'
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'MFB_JEOPARDY_DAYS_TYPE'
,'JEOPARDY_DAYS_TYPE_THRESHOLD'
,'Threshold for Jeopardy Days Type'
,'B'
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;

insert into corp_etl_list_lkup ( cell_id
     ,name
     ,list_type
     ,value
     ,out_var
     ,ref_type
     ,ref_id
     ,start_date
     ,end_date
     ,comments
     ,created_ts
     ,updated_ts)
values (seq_cell_id.NEXTVAL
,'MFB_TARGET_DAYS'
,'TARGET_DAYS_THRESHOLD'
,'Threshold for Target Days'
,'0'
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;

commit;