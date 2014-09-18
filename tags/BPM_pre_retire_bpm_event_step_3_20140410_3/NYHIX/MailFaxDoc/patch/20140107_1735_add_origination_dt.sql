alter table NYHIX_ETL_MAIL_FAX_DOC drop column receipt_dt;
alter table NYHIX_ETL_MAIL_FAX_DOC drop column doc_complete_dt;
alter table NYHIX_ETL_MAIL_FAX_DOC add ORIGINATION_DT date not null;

alter table NYHIX_ETL_MAIL_FAX_DOC_OLTP drop column receipt_dt;
alter table NYHIX_ETL_MAIL_FAX_DOC_OLTP drop column doc_complete_dt;
alter table NYHIX_ETL_MAIL_FAX_DOC_OLTP add ORIGINATION_DT date not null;


alter table NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM drop column receipt_dt;
alter table NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM drop column doc_complete_dt;
alter table NYHIX_ETL_MAIL_FAX_DOC_WIP_BPM add ORIGINATION_DT date not null;