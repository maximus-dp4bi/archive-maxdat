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
,'''Complaint Open'''
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
,'''OPEN'''
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
,'''Complaint Withdrawn'''
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
,'''WITHDRAWN'''
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
,'''Complaint Closed'''
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
,'''CLOSED'''
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
,'''Referred to HFS'''
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
,'''REFERRED_TO_STATE'''
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
,'PI_INC_STATS_ESCLT_TRMNL_OLTP'
,'INC_STATUS'
,'Various incident status when Escalated and ends the process'
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
,'''COMPLAINT'''
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
,null
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
,'''J'',''L'''
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
,'''J'',''L'',''O'''
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
,'''invalid'',''denied'',''void'',''rejected'',''disregarded'''
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
,'Incident Type'
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;



commit;