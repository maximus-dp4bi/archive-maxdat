alter session set current_schema = MAXDAT;

alter table F_NYHIX_MFD_BY_DATE            add MINOR_APPLICANT_FLAG varchar2(1);
alter table D_NYHIX_MFD_CURRENT_V2         add MINOR_APPLICANT_FLAG varchar2(1);
alter table app_doc_data_stg               add (MINOR_APPLICANT_FLAG varchar2(1),
                                                BIRTH_DATE date);
alter table NYHIX_ETL_MAIL_FAX_DOC_OLTP_V2 add (MINOR_APPLICANT_FLAG varchar2(1),
                                                BIRTH_DATE date); 
alter table NYHIX_ETL_MAIL_FAX_DOC_WIP_V2  add (MINOR_APPLICANT_FLAG varchar2(1),
                                                BIRTH_DATE date);
alter table NYHIX_ETL_MAIL_FAX_DOC_V2      add  MINOR_APPLICANT_FLAG varchar2(1);
