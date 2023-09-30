alter table nyhix_etl_mail_fax_doc_v2 modify env_status default 'Received';
alter table nyhix_etl_mail_fax_doc_oltp_v2 modify env_status default 'Received';
alter table nyhix_etl_mail_fax_doc_wip_v2 modify env_status default 'Received';

alter table D_NYHIX_MFD_FORM_TYPE_V2 modify form_type VARCHAR2(64 BYTE) null;

update BPM_UPDATE_EVENT_QUEUE set OLD_DATA = deletexml(OLD_DATA,'/ROWSET/ROW/ENV_STATUS'), NEW_DATA = deletexml(NEW_DATA,'/ROWSET/ROW/ENV_STATUS') Where BSL_ID = 24 and IDENTIFIER in (select dcn from nyhix_etl_mail_fax_doc_v2 where env_status is NULL) and existsnode(old_data,'ROWSET/ROW/ENV_STATUS') = 1;

update BPM_UPDATE_EVENT_QUEUE set OLD_DATA = APPENDCHILDXML(OLD_DATA,'/ROWSET/ROW',XMLTYPE('<ENV_STATUS>![CDATA[Received]]</ENV_STATUS>')), NEW_DATA = APPENDCHILDXML(NEW_DATA,'/ROWSET/ROW',XMLTYPE('<ENV_STATUS>![CDATA[Received]]</ENV_STATUS>')) Where BSL_ID = 24 and IDENTIFIER in (select dcn from nyhix_etl_mail_fax_doc_v2 where env_status is NULL);

commit;

alter trigger TRG_AI_NYHIX_ETL_MFD_Q_V2 disable;
alter trigger TRG_AU_NYHIX_ETL_MFD_Q_V2 disable;
alter trigger TRG_BIU_NYHIX_ETL_MFD_V2 disable;

Update nyhix_etl_mail_fax_doc_v2
set env_status = 'Received'
where env_status = null;
commit;

alter trigger TRG_AI_NYHIX_ETL_MFD_Q_V2 enable;
alter trigger TRG_AU_NYHIX_ETL_MFD_Q_V2 enable;
alter trigger TRG_BIU_NYHIX_ETL_MFD_V2 enable;