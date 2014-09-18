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
,'INCIDENT_STATUS_ESCLT_OLTP'
,'INC_STATUS'
,'Various Incident Status'
,'''REFERRED_TO_STATE'',''REFERRED_TO_PLAN'',''REFERRED_TO_MTP'',''REFERRED_TO_DSHS'',''REFERRED_TO_OIG'',''REFERRED_TO_OCR'''
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
,'INCIDENT_STATUS_ESCLT_BPM'
,'INC_STATUS'
,'Various Incident Status'
,'''Referred to HHSC'',''Referred to Plan'',''Referred to MTP'',''Referred to DSHS'',''Referred to OIGG'',''Referred to the Office of Civil Rights'''
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
,'INCIDENT_STATUS_CLOSED_OLTP'
,'INC_STATUS'
,'Various Incident Status when closed'
,'''CLOSED'',''CLOSED_2'',''CLOSED_3'''
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
,'INCIDENT_STATUS_OPEN_OLTP'
,'INC_STATUS'
,'Various Incident Status when open'
,'''OPEN'',''OPEN_2'',''OPEN_3'''
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
,'INCIDENT_STATUS_OPEN_BPM'
,'INC_STATUS'
,'Various Incident Status when open'
,'''Open for Complaints and HHSC Complaints'',''Open for PSI and Civil Rights'',''Open for Escalations'''
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
,'INCIDENT_STATUS_WITHDRAWN_OLTP'
,'INC_STATUS'
,'Various Incident Status when withdrawn'
,'''WITHDRAWN'',''WITHDRAWN_2'',''WITHDRAWN_3'''
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
,'INCIDENT_STATUS_WITHDRAWN_BPM'
,'INC_STATUS'
,'Various Incident Status when withdrawn'
,'''Withdrawn'''
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
,'INCIDENT_STATUS_CLOSED_BPM'
,'INC_STATUS'
,'Various Incident Status when closed'
,'''Closed'''
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
,'INCIDENT_SLA_BASIS'
,'INC_THRESHOLD'
,'Incident Jeopardy status and timeliness threshold'
,'Priority'
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;


commit;