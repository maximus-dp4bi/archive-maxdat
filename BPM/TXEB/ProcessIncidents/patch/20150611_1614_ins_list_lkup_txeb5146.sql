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
,'PI_INCIDENT_TYPE_COMPLAINTS'
,'INC_STATUS'
,'Complaint Incident Types'
,'''Complaint'',''HHSC Complaint'''
,null
,null
,sysdate
,null
,'Incident Types where statuses listed in INCIDENT_STATUS_CMPLT_TERMINAL_BPM apply.'
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
,'INCIDENT_STATUS_CMPLT_TERM_BPM'
,'INC_STATUS'
,'Terminal Status for Complaint Incident Types'
,'''Referred to HHSC'',''Referred to MTP'''
,null
,null
,sysdate
,null
,'Terminal statuses for Incident Types Complaint and HHSC Complaint'
,sysdate
,sysdate)  ;

commit;