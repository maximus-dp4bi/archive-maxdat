delete from F_NYHIX_MFD_BY_DATE;
delete from D_NYHIX_MFD_CURRENT;

delete from D_NYHIX_MFD_INS_STATUS;
delete from D_NYHIX_MFD_DOC_TYPE;
delete from D_NYHIX_MFD_DOC_STATUS;
delete from D_NYHIX_MFD_ENV_STATUS;
delete from D_NYHIX_MFD_DOC_SUB_TYPE;
delete from D_NYHIX_MFD_FORM_TYPE;
delete from D_NYHIX_MFD_TIME_STATUS;


delete from BPM_UPDATE_EVENT_QUEUE
where bsl_id=18;

delete from BPM_UPDATE_EVENT_QUEUE_ARCHIVE
where bsl_id=18;

commit;

update CORP_ETL_CONTROL
set value=398
where name='MFD_DOC_LOOK_BACK_DAYS';

commit;


Truncate table NYHIX_ETL_MAIL_FAX_DOC;
Truncate table NYHIX_ETL_MAIL_FAX_DOC_OLTP;
Truncate table NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM;
