insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPHEADER_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_header.create_ts from the previous run. create_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPHEADER_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_header.update_ts from the previous run. update_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPINDV_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_individual.create_ts from the previous run. create_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPINDV_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_individual.update_ts from the previous run. update_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPOUTCOME_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_elig_outcome.create_ts from the previous run. create_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPOUTCOME_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_elig_outcome.update_ts from the previous run. update_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPEVENT_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_event_log.create_ts from the previous run. create_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPCASELINK_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_case_link.create_ts from the previous run. create_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPCASELINK_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_case_link.update_ts from the previous run. update_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('REDET_PROCESSING_SLA_DAYS','N','35','Redetermination Processing Cycle Time SLA Days',sysdate,sysdate);


insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LTRLINK_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the letter_request_link.create_ts from the previous run. create_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LTRLINK_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the letter_request_link.update_ts from the previous run. update_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPMI_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_missing_info.create_ts from the previous run. create_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPMI_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_missing_info.update_ts from the previous run. update_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPINDVCLIENT_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the client.last_update_date from the previous run. update_ts of the most recent client record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CASEADDR_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the address.creation_date from the previous run. creation_date of the most recent address record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CASEADDR_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the address.last_update_date from the previous run. last_update_date of the most recent address record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPTRACKER_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_tracker.create_ts from the previous run. create_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPTRACKER_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_tracker.update_ts from the previous run. update_ts of the most recent app header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CASE_EVENT_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the event.create_ts from the previous run. create_ts of the most recent app header record from the previous run.',sysdate,sysdate);


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
,'APPEVENT_EVENT_CODES'
,'APPEVENT_EVENT_CODES'
,'Various application events'
,'''APP_DOD_MMIS'',''APP_CANCL_MMIS'',''APP_TRM_MMIS'',''APP_APEAL_MMIS'',''APP_ACT_MMIS'',''APP_DEN75_MMIS'',''APP_LINK_MMIS'',''APP_TRMDN_MMIS'',''APP_APPR_MMIS'',''APP_APR_MMIS'',''APP_REJ_MMIS'',''APP_MI_ADDED'',''APP_MI_SATISFIED'',''LETTER_REQ'',''RENEWAL_INITIATED'',''STATUS_CHANGE'',''LETTER_SENT'',''LETTER_MAIL'',''RFE_STATUS_CHANGE'',''ELIG_OUTCOME_CHANGED'',''APP_REACTIVATED'',''RFI_CK'',''PEND_CK'',''NR_CK'',''TRMDN_CK'',''APPR_CK'',''CK_APPR_MA'',''TRMDN'',''NR'',''APPLICANT_RELINKED'',''COB_ESTABLISHED'',''DOCUMENT_REMOVED'''
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
,'CASE_EVENT_CODES'
,'CASE_EVENT_CODES'
,'Various case events'
,'''CASE_MANUAL_ACTION'''
,null
,null
,sysdate
,null
,null
,sysdate
,sysdate)  ;

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APP_STATSTG_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the etl_l_app_status_staging_stg.create_ts from the previous run. create_ts of the most recent app_status_staging record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APP_STATSTG_LAST_PROCESS_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the etl_l_app_status_staging_stg.process_ts from the previous run. process_ts of the most recent app_status_staging record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APP_RNLSTG_JOB_ID','N',1,'This is the max job_id loaded in ETL_E_APP_RENEWAL_STG',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APP_RNLSTG_ROWNUM','N',1,'This is the max job_id loaded in ETL_E_APP_RENEWAL_STG',sysdate,sysdate);


insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('DAILYACCENT_STG_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the etl_e_daily_accent_staging.create_ts from the previous run. create_ts of the most recent accent record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('DAILYACCENT_STG_PROCESS_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the etl_e_daily_accent_staging.process_ts from the previous run. process_ts of the most recent accent record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CLIENT_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the client.creation_date from the previous run. create_ts of the most recent client record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CLIENT_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the client.last_update_date from the previous run. update_ts of the most recent client record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AUTHCONTACT_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the authorized_contact.ac_create_ts from the previous run. update_ts of the most recent auth rep record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('AUTHCONTACT_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the authorized_contact.ac_update_ts from the previous run. update_ts of the most recent auth rep record from the previous run.',sysdate,sysdate);


insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CASE_CLIENT_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the case_client.creation_date from the previous run. create_ts of the most recent case client record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CASE_CLIENT_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the case_client.last_update_date from the previous run. update_ts of the most recent case client record from the previous run.',sysdate,sysdate);


insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LTRHDR_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the letter_request_link.create_ts from the previous run. create_ts of the most recent ltr header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LTRHDR_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the letter_request_link.update_ts from the previous run. update_ts of the most recent ltr header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('DATAENTRY_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the data entry screens create_ts from the previous run. create_ts of the most recent de header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('DATAENTRY_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the  data entry screens create_ts from the previous run. create_ts of the most recent de header record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPCLIENTSUPINFO_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_tracker.create_ts from the previous run. update_ts of the most recent client supp info record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('CLIENTSUPINFO_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_tracker.update_ts from the previous run. update_ts of the most recent client supp info from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('ALERT_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the alert.create_ts from the previous run. create_ts of the most recent alert record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('ALERT_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the alert.update_ts from the previous run. most recent update_ts from the previous run.',sysdate,sysdate);


commit;