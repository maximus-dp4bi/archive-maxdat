--SUS_TRANS_RPT_VW
CREATE OR REPLACE FORCE VIEW "FLCPD0_STAGE"."SUS_TRANS_RPT_VW" ("OPERATION$", "CSCN$", "COMMIT_TIMESTAMP$", "XIDUSN$", "XIDSLT$", "XIDSEQ$", "DDLDESC$", "DDLOPER$", "DDLPDOBJN$", "RSID$", "TARGET_COLMAP$", "TIMESTAMP$", "USERNAME$", "AMOUNT", "APPLICATION_ID", "BATCH_ID", "COMMENTS", "CREDIT_DEBIT", "DATE_POSTED", "DATE_RECEIVED", "DOCUMENT_ID", "DTYPE", "FINANCIAL_TRANSACTION_ID", "INSERT_DATE", "INSERT_JOB_NAME", "INSERT_USER", "INSERT_USER_ROLE", "JPA_VERSION", "LAST_UPDATE_JOB_NAME", "LAST_UPDATE_USER", "MISSING_ACCOUNT_NUMBER_FLAG", "PARENT_TRANSACTION_ID", "PAYMENT_AGENT", "PAYMENT_CHANNEL", "PAYMENT_METHOD", "RCVD_ACCOUNT_NUMBER", "RCVD_BATCH_DATE", "RCVD_BATCH_NUMBER", "RCVD_FIRST_NAME", "RCVD_LAST_NAME", "RCVD_NAME", "RCVD_SEQUENCE_NUMBER", "RCVD_SSN", "RCVD_TRANSACTION_NUMBER", "STATUS", "SUSPENSE_TRANSACTION_ID", "SUSPENSE_TRANSACTION_TYPE", "TRANSACTION_SUBTYPE", "TRANSACTION_TYPE", "UPDATE_DATE", "UPDATE_USER_ROLE", "VIEWING_USERID") AS 
SELECT decode(Shareplex_source_operation,'UPDATE BEFORE','UO','UPDATE AFTER','UN','INSERT','I','DELETE','D') "OPERATION$",
       Shareplex_source_SCN "CSCN$",
       Shareplex_source_TIME "COMMIT_TIMESTAMP$", 
       NULL "XIDUSN$",
       NULL "XIDSLT$", 
       NULL "XIDSEQ$",   
       NULL "DDLDESC$", 
       NULL "DDLOPER$", 
       NULL "DDLPDOBJN$", 
       NULL "RSID$", 
       NULL "TARGET_COLMAP$", 
       Shareplex_source_TIME "TIMESTAMP$", 
       NULL "USERNAME$", 
       STC.*
FROM FLCPD0_CDC.SUSPENSE_TRANSACTION_CT STC
where STC.shareplex_source_scn >= 523031955 and STC.shareplex_source_scn <=539086134 ;