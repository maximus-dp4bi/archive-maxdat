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
,'PA_INCIDENT_STATUS_OPEN_BPM'
,'APPEAL_STATUS'
,'Various incident status when Opened'
,'''Incident Open'''
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
,'PA_INCIDENT_STATUS_OPEN_OLTP'
,'APPEAL_STATUS'
,'Various incident status when Opened'
,'''APPEAL_REOPEN'',''INCIDENT_OPEN'''
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
,'PA_INCIDNT_STATUS_WITHDRAN_BPM'
,'APPEAL_STATUS'
,'Various incident status when Withdrawn'
,'''APPEAL WITHDRAWN'''
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
,'PA_INCIDNT_STATS_WITHDRAN_OLTP'
,'APPEAL_STATUS'
,'Various incident status when Withdrawn'
,'''APPEAL_WITHDRAWN'''
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
,'PA_INCIDENT_STATUS_CLOSED_BPM'
,'APPEAL_STATUS'
,'Various incident status when Closed'
,'''Incident Closed'',''Incident Closed - Decision Overturned'',''Incident Closed - Decision Upheld'',''Incident Closed - Duplicate'',''Incident Closed - IDR Not Successful'',''Incident Closed - IDR Successful'''
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
,'PA_INCIDENT_STATUS_CLSD_OLTP'
,'APPEAL_STATUS'
,'Various incident status when Closed'
,'''INCIDENT_CLOSED'',''INC_CLOSED_OVERTURN'',''INC_CLOSED_UPHELD'',''INC_CLOSED_DUP'',''CLOSED_IDR_FAIL'',''CLOSED_IDR_SUCCESS'''
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
,'PA_INCIDENT_HEADER_TYPE'
,'APPEAL_STATUS'
,'Holds the incident header type'
,'''APPEAL'''
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
,'PA_REPORTER_RELATIONSHIP_DEFLT'
,'APPEAL_STATUS'
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
,'PA_ENROLL_STATUS_ENROLLEE'
,'APPEAL_STATUS'
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
,'PA_ENROL_STATS_POTNTIAL_ENRLE'
,'APPEAL_STATUS'
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
,'PA_SELECTN_TXN_STATUS_CD'
,'APPEAL_STATUS'
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
,'PA_UPD2_10'
,'APPEAL_STATUS'
,'Various incident status for UPD2_10'
,'''Appeal Validity Check'',''Awaiting Documentation'',''Schedule Hearing'',''Awaiting Written Withdrawal'',''SHOP Desk Review'''
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
,'PA_UPD3_10'
,'APPEAL_STATUS'
,'Various incident status for UPD3_10'
,'''Appeal Validity Check'''
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
,'PA_UPD3_20'
,'APPEAL_STATUS'
,'Various incident status for UPD3_20'
,'''Awaiting Documentation'''
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
,'PA_UPD3_30'
,'APPEAL_STATUS'
,'Various incident status for UPD3_30'
,'''Schedule Hearing'''
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
,'PA_UPD3_CHANNEL'
,'APPEAL_STATUS'
,'Various incident status for PA_UPD3_CHANNEL1'
,'''MAIL/FAX'',''FAX'',''WEB'''
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
,'PA_UPD3_CHANNEL2'
,'APPEAL_STATUS'
,'Various incident status for PA_UPD3_CHANNEL2'
,'''PHONE'''
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
,'PA_UPD3_50'
,'APPEAL_STATUS'
,'Various incident status for UPD3_50'
,'''Awaiting Written Withdrawal'''
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
,'PA_UPD3_60'
,'APPEAL_STATUS'
,'Various incident status for UPD3_60'
,'''SHOP Desk Review'''
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
,'PA_UPD4_10'
,'APPEAL_STATUS'
,'Various incident status for UPD4_10'
,'''Awaiting Validity Amendment'',''Awaiting Documentation'',''Schedule Hearing'',''Awaiting Written Withdrawal'',''Awaiting Validity Amendment - Individual'',''Awaiting Validity Amendment - SHOP'',''SHOP Desk Review''' 
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
,'PA_UPD5_10'
,'APPEAL_STATUS'
,'Various incident status for UPD5_10'
,'''Awaiting Validity Amendment'',''Awaiting Validity Amendment - Individual'',''Awaiting Validity Amendment - SHOP''' 
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
,'PA_UPD5_20'
,'APPEAL_STATUS'
,'Various incident status for UPD5_20'
,'''Awaiting Documentation''' 
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
,'PA_UPD5_30'
,'APPEAL_STATUS'
,'Various incident status for UPD5_30'
,'''Schedule Hearing''' 
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
,'PA_UPD5_40'
,'APPEAL_STATUS'
,'Various incident status for UPD5_40'
,'''Awaiting Written Withdrawal''' 
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
,'PA_UPD5_50'
,'APPEAL_STATUS'
,'Various incident status for UPD5_50'
,'''SHOP Desk Review''' 
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
,'PA_UPD6_10'
,'APPEAL_STATUS'
,'Various incident status for UPD6_10'
,'''Appeal Validity Check'',''Dismissal - Failed to Amend Invalid Appeal Request''' 
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
,'PA_UPD6_20'
,'APPEAL_STATUS'
,'Various incident status for UPD6_20'
,'''Dismissal - Failed to Amend Invalid Appeal Request''' 
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
,'PA_UPD6_30'
,'APPEAL_STATUS'
,'Various incident status for UPD6_30'
,'''Appeal Validity Check''' 
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
,'PA_UPD7_10'
,'APPEAL_STATUS'
,'Various incident status for UPD7_10'
,'''Schedule Hearing'',''Awaiting Written Withdrawal'',''SHOP Desk Review''' 
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
,'PA_UPD8_10'
,'APPEAL_STATUS'
,'Various incident status for UPD8_10'
,'''Schedule Hearing''' 
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
,'PA_UPD8_20'
,'APPEAL_STATUS'
,'Various incident status for UPD8_20'
,'''Awaiting Written Withdrawal''' 
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
,'PA_UPD8_30'
,'APPEAL_STATUS'
,'Various incident status for UPD8_30'
,'''SHOP Desk Review''' 
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
,'PA_UPD9_10'
,'APPEAL_STATUS'
,'Various incident status for UPD9_10'
,'''Incident Closed - Decision Upheld'',''Incident Closed - Decision Overturned''' 
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
,'PA_UPD10_10'
,'APPEAL_STATUS'
,'Various incident status for UPD10_10'
,'''Request Withdrawn - IDR Completed'',''Request Withdrawn - IDR Not Completed'',''Schedule Hearing'',''SHOP Desk Review''' 
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
,'PA_UPD11_10'
,'APPEAL_STATUS'
,'Various incident status for UPD11_10'
,'''Request Withdrawn - IDR Completed'',''Request Withdrawn - IDR Not Completed''' 
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
,'PA_UPD11_20'
,'APPEAL_STATUS'
,'Various incident status for UPD11_20'
,'''Schedule Hearing''' 
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
,'PA_UPD11_30'
,'APPEAL_STATUS'
,'Various incident status for UPD11_30'
,'''SHOP Desk Review''' 
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
,'PA_UPD12_10'
,'APPEAL_STATUS'
,'Various incident status for UPD12_10'
,'''Hearing Set - Disposition Review Needed'',''Hearing Set - No Disposition Review''' 
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
,'PA_UPD13_10'
,'APPEAL_STATUS'
,'Various incident status for UPD13_10'
,'''Hearing Set - Disposition Review Needed''' 
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
,'PA_UPD13_20'
,'APPEAL_STATUS'
,'Various incident status for UPD13_20'
,'''Hearing Set - No Disposition Review''' 
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
,'PA_UPD14_10'
,'APPEAL_STATUS'
,'Various incident status for UPD14_10'
,'''Hearing Set - No Disposition Review'',''Cancel Hearing''' 
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
,'PA_UPD15_10'
,'APPEAL_STATUS'
,'Various incident status for UPD15_10'
,'''Hearing Set - No Disposition Review''' 
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
,'PA_UPD15_20'
,'APPEAL_STATUS'
,'Various incident status for UPD15_20'
,'''Cancel Hearing''' 
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
,'PA_UPD16_10'
,'APPEAL_STATUS'
,'Various incident status for UPD16_10'
,'''Request Withdrawn - IDR Completed'',''Request Withdrawn - IDR Not Completed''' 
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
,'PA_UPD17_10'
,'APPEAL_STATUS'
,'Various incident status for UPD17_10'
,'''Incident Closed - Decision Upheld'',''Incident Closed - Decision Overturned''' 
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
,'PA_UPD18_10'
,'APPEAL_STATUS'
,'Various incident status for UPD18_10'
,'''Dismissal - Death''' 
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
,'PA_UPD18_20'
,'APPEAL_STATUS'
,'Various incident status for UPD18_20'
,'''Request Withdrawn - IDR Completed''' 
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
,'PA_UPD18_30'
,'APPEAL_STATUS'
,'Various incident status for UPD18_30'
,'''Request Withdrawn - IDR Not Completed''' 
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
,'PA_UPD18_40'
,'APPEAL_STATUS'
,'Various incident status for UPD18_40'
,'''Incident Closed - Duplicate'',''Incident Closed''' 
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
,'PA_EXCLUDE_STATUS'
,'APPEAL_STATUS'
,'Various incident status to exclude'
,'''Refer to ES-C'',''Refer to ES-C Supervisor'',''Refer to NY Appeals Unit'',''Refer to NY Appeals Unit Supervisor'',''Remand'',''Request to Vacate Dismissal'',''Reschedule Hearing- Appellant Request'',''Reschedule Hearing- DOH Request'',''Decision Overturned'',''Dismissal - Failed to Attend Hearing''' 
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
,'PA_OLD_UPD2_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD2'
,'''Incident Open'',''APPEAL INITIATED''' 
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
,'PA_OLD_UPD3_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD3'
,'''Incident Open'',''APPEAL INITIATED''' 
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
,'PA_OLD_UPD4_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD4'
,'''Appeal Validity Check''' 
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
,'PA_OLD_UPD5_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD5'
,'''Appeal Validity Check''' 
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
,'PA_OLD_UPD6_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD6'
,'''Awaiting Validity Amendment'',''Awaiting Validity Amendment - Individual'',''Awaiting Validity Amendment - SHOP''' 
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
,'PA_OLD_UPD7_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD7'
,'''Awaiting Documentation''' 
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
,'PA_OLD_UPD8_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD8'
,'''Awaiting Documentation''' 
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
,'PA_OLD_UPD9_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD9'
,'''SHOP Desk Review''' 
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
,'PA_OLD_UPD10_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD10'
,'''Awaiting Written Withdrawal'''
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
,'PA_OLD_UPD11_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD11'
, '''Awaiting Written Withdrawal''' 
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
,'PA_OLD_UPD12_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD12'
,'''Schedule Hearing'''
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
,'PA_OLD_UPD13_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD13'
,'''Schedule Hearing'''  
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
,'PA_OLD_UPD14_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD14'
,'''Hearing Set - Disposition Review Needed''' 
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
,'PA_OLD_UPD15_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD15'
,'''Hearing Set - Disposition Review Needed''' 
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
,'PA_OLD_UPD16_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD16'
,'''Cancel Hearing''' 
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
,'PA_OLD_UPD17_STATUS'
,'APPEAL_STATUS'
,'Previous status for UPD17'
,'''Hearing Set - No Disposition Review''' 
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
,'APPEALS_JEOPARDY_DAYS'
,'APPEALS'
,'APPEAL'
,25 
,null
,null
,sysdate
,null
,'Appeals Jeopardy Days'
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
,'APPEALS_TIMELINESS_DAYS'
,'APPEALS'
,'APPEAL'
,30 
,null
,null
,sysdate
,null
,'Appeals Timeliness Days'
,sysdate
,sysdate)  ;

UPDATE CORP_ETL_LIST_LKUP
SET OUT_VAR = '''Dismissed - Death'''
WHERE NAME = 'PA_UPD18_10';

UPDATE CORP_ETL_LIST_LKUP
SET OUT_VAR = '''Appeal Closed - Duplicate/Error'''
WHERE NAME = 'PA_UPD18_20';

INSERT INTO MAXDAT.CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS) VALUES ('PA_UPD20_10','APPEAL_STATUS','Various incident status for UPD20_10','''Dismissed''',null,null,sysdate,null,null);
INSERT INTO MAXDAT.CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS) VALUES ('PA_UPD20_20','APPEAL_STATUS','Various incident status for UPD20_20','''Appeal Closed - ARU Action Completed''',null,null,sysdate,null,null);
INSERT INTO MAXDAT.CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS) VALUES ('PA_UPD20_30','APPEAL_STATUS','Various incident status for UPD20_30','''Appeal Closed - DOH Action Completed''',null,null,sysdate,null,null);
INSERT INTO MAXDAT.CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS) VALUES ('PA_UPD20_40','APPEAL_STATUS','Various incident status for UPD20_40','''Appeal Closed - Failed to Attend Hearing''' ,null,null,sysdate,null,null);
INSERT INTO MAXDAT.CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS) VALUES ('PA_UPD20_50','APPEAL_STATUS','Various incident status for UPD20_50','''Appeal Closed - Non-Sworn Cancellation''',null,null,sysdate,null,null);
INSERT INTO MAXDAT.CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS) VALUES ('PA_UPD20_60','APPEAL_STATUS','Various incident status for UPD20_60','''Appeal Closed - Written Withdrawal''',null,null,sysdate,null,null);
INSERT INTO MAXDAT.CORP_ETL_LIST_LKUP (NAME,LIST_TYPE,VALUE,OUT_VAR,REF_TYPE,REF_ID,START_DATE,END_DATE,COMMENTS) VALUES ('PA_UPD20_70','APPEAL_STATUS','Various incident status for UPD20_70','''Appeal Closed''',null,null,sysdate,null,null);


commit;	      