alter session set current_schema = MAXDAT;


alter table NYHIX_ETL_MAIL_FAX_DOC_APP_V2 add (MINOR_APPLICANT_FLAG varchar2(1),
                                                BIRTH_DATE date); 



