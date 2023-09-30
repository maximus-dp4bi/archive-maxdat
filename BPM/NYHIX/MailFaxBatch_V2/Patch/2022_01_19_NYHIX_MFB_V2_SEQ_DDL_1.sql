--------------------------------------------------------
--  DDL for sequence SEQ_NYHIX_MFB_BATCH_SUMMARY_ID
--  FROM SEQ_BI_ID. 
--  ******* The starting number must match the current_value + 1 
--  ******* in SEQ_BI_ID.
--------------------------------------------------------


DROP SEQUENCE MAXDAT.SEQ_NYHIX_MFB_BATCH_SUMMARY_ID;

CREATE SEQUENCE  MAXDAT.SEQ_NYHIX_MFB_BATCH_SUMMARY_ID  
MINVALUE 1 
MAXVALUE 9999999999999999999999999999 
INCREMENT BY 1 
START WITH 68776570
CACHE 100 NOORDER  NOCYCLE  NOKEEP  NOSCALE  
GLOBAL ;



GRANT SELECT ON MAXDAT.SEQ_NYHIX_MFB_BATCH_SUMMARY_ID TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.SEQ_NYHIX_MFB_BATCH_SUMMARY_ID TO MAXDAT_REPORTS;

--------------------------------------------------------
--  DDL for sequence SEQ_NYHIX_MFB_BATCH_BY_HOUR_ID 
--  FROM SEQ_BI_ID. 
--  ******* The starting number must match the current_value + 1 
--  ******* in SEQ_FMFBBH_ID.nextval;.
--------------------------------------------------------

DROP SEQUENCE  MAXDAT.SEQ_NYHIX_MFB_BATCH_BY_HOUR_ID ;

CREATE SEQUENCE  MAXDAT.SEQ_NYHIX_MFB_BATCH_BY_HOUR_ID 
MINVALUE 1 MAXVALUE 999999999999999999999999999 
INCREMENT BY 1 
START WITH 16720400
GRANT SELECT ON MAXDAT.SEQ_NYHIX_MFB_BATCH_BY_HOUR_ID TO MAXDAT_READ_ONLY;
GRANT SELECT ON MAXDAT.SEQ_NYHIX_MFB_BATCH_BY_HOUR_ID TO MAXDAT_REPORTS;

--delete from maxdat.corp_etl_error_log
--where process_name = 'Update_Maxdat_reporting';

commit;

