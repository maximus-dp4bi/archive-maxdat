alter table NYHIX_ETL_MAIL_FAX_DOC_OLTP_V2 modify (SLA_COMPLETE varchar(1) default 'N');
alter table NYHIX_ETL_MAIL_FAX_DOC_APP_V2 drop constraint ADD_ID_PK;
alter table NYHIX_ETL_MAIL_FAX_DOC_APP_V2 add constraint ADD_ID_PK primary key (APP_DOC_INDV_ID);