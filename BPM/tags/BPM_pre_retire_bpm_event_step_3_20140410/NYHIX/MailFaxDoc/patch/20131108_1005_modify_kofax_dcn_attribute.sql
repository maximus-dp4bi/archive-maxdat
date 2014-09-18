Alter table NYHIX_ETL_MAIL_FAX_DOC modify (KOFAX_DCN varchar2(256) NOT NULL);
Alter table NYHIX_ETL_MAIL_FAX_DOC_OLTP modify (KOFAX_DCN varchar2(256) NOT NULL);
Alter table NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM modify (KOFAX_DCN varchar2(256) NOT NULL);
commit;