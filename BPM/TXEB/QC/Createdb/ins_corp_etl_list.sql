
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
,'QC_LOOKUP_ALL'
,'QC'
,'Flag to load all lookup entries'
,'1'
,null
,null
,sysdate
,null
,'Flag to load all lookup entries'
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
,'QC_TRAN_ALL'
,'QC'
,'Flag to load all tran entries'
,'1'
,null
,null
,sysdate
,null
,'Flag to load all tran entries'
,sysdate
,sysdate)  ;

commit;
