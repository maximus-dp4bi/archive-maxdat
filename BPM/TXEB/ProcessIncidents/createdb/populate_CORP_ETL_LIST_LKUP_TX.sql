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
,'PI_INCIDENT_STATUS_OPEN_BPM'
,'INC_STATUS'
,'Various incident status when Opened'
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
,'PI_INCIDENT_STATUS_OPEN_OLTP'
,'INC_STATUS'
,'Various incident status when Opened'
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
,'PI_INCIDNT_STATUS_WITHDRAN_BPM'
,'INC_STATUS'
,'Various incident status when Withdrawn'
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
,'PI_INCIDNT_STATS_WITHDRAN_OLTP'
,'INC_STATUS'
,'Various incident status when Withdrawn'
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
,'PI_INCIDENT_STATUS_CLOSED_BPM'
,'INC_STATUS'
,'Various incident status when Closed'
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
,'PI_INCIDENT_STATUS_CLSD_OLTP'
,'INC_STATUS'
,'Various incident status when Closed'
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
,'PI_INCIDENT_STATUS_ESCLT_BPM'
,'INC_STATUS'
,'Various incident status when Escalated and still active'
,'''NA'''
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
,'PI_INCIDENT_STATUS_ESCLT_OLTP'
,'INC_STATUS'
,'Various incident status when Escalated and still active'
,'''NA'''
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
,'PI_INC_STATS_ESCLT_TRMNL_BPM'
,'INC_STATUS'
,'Various incident status when Escalated and ends the process'
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
,'PI_INC_STATS_ESCLT_TRMNL_OLTP'
,'INC_STATUS'
,'Various incident status when Escalated and ends the process'
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
,'PI_INCDNT_STATUS_RETRN_MMS_BPM'
,'INC_STATUS'
,'Various incident status when returned to MMS'
,'''NA'''
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
,'PI_INC_STATUS_RETRN_MMS_OLTP'
,'INC_STATUS'
,'Various incident status when returned to MMS'
,'''NA'''
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
,'PI_INCIDENT_HEADER_TYPE'
,'INC_STATUS'
,'Holds the incident header type'
,'''OUTREACH REQUEST'''
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
,'PI_REPORTER_RELATIONSHIP_DEFLT'
,'INC_STATUS'
,'Holds default reporter relationship'
,'''Self'''
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
,'PI_ENROLL_STATUS_ENROLLEE'
,'INC_STATUS'
,'Various enrollment status for enrollee'
,'''G'',''O*'''
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
,'PI_ENROL_STATS_POTNTIAL_ENRLE'
,'INC_STATUS'
,'Various enrollment status for potential enrollee'
,'''K'',''O'',''Q'',''G'',''O*'''
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
,'PI_SELECTN_TXN_STATUS_CD'
,'INC_STATUS'
,'Various status in selection txn'
,'''invalid'',''denied'',''void'',''rejected'''
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
,'PI_INCIDENT_SLA_BASIS'
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
,'INCIDENT_ACTION_TAKEN_LIMIT'
,'INC_STATUS'
,'Limit for the number of actions taken to extract'
,'15'
,null
,null
,sysdate
,null
,'Limit for the number of actions taken to extract'
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