alter session set current_schema = MAXDAT;
ALTER TABLE MAXDAT.NYHIX_ETL_MAIL_FAX_DOC_CSC_V2BCK DROP COLUMN DCN;
INSERT INTO MAXDAT.NYHIX_ETL_MAIL_FAX_DOC_CSC_V2BCK 
SELECT    csc_detail_id,    kofax_dcn,    csc_proc_status_cd,    csc_proc_error_cd,    csc_proc_dt,    NULL FROM     maxdat.nyhix_etl_mail_fax_doc_csc_v2;
Commit;