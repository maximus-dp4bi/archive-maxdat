
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
,'INCIDENT_ACTION_TAKEN_LOOKBACK'
,'INC_STATUS'
,'Number of days to look back for completed instances'
,'45'
,null
,null
,sysdate
,null
,'Number of days to look back for completed instances'
,sysdate
,sysdate)  ;

commit;