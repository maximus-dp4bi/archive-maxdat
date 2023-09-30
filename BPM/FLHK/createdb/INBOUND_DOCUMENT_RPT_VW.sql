--INBOUND_DOCUMENT_RPT_VW
CREATE OR REPLACE FORCE VIEW "FLCPD0_STAGE"."INBOUND_DOCUMENT_RPT_VW" ("OPERATION$", "CSCN$", "COMMIT_TIMESTAMP$", "XIDUSN$", "XIDSLT$", "XIDSEQ$", "DDLDESC$", "DDLOPER$", "DDLPDOBJN$", "RSID$", "TARGET_COLMAP$", "TIMESTAMP$", "USERNAME$", "ACCOUNT_ID", "ACCOUNT_LINK_STATUS", "ACCOUNT_NUMBER", "ALREADY_WORKED_FLAG", "APPLICATION_ID", "APP_SENT_STATUS", "APP_SENT_STATUS_DATE", "CHECK_NUMBER", "DOCUMENT_CONTROL_NUMBER", "DOCUMENT_ID", "DOCUMENT_SOURCE_SYSTEM", "ENVELOPE_CONTROL_NUMBER", "ENV_HAS_APP_DOC_FLAG", "ENV_HAS_RENEW_DOC_FLAG", "FORWARD_ADDRESS_PRESENT_FLAG", "IMAGE_FORMAT", "IMAGE_LOCATION", "INBOUND_DOCUMENT_SOURCE", "INBOUND_DOCUMENT_TYPE", "INSERT_DATE", "INSERT_JOB_NAME", "INSERT_USER", "INSERT_USER_ROLE", "JPA_VERSION", "LAST_UPDATE_JOB_NAME", "LAST_UPDATE_USER", "LETTER_ID", "MISSING_PAGES_FLAG", "PAYMENT_AMOUNT", "RECEIVED_DATE", "SCAN_DATE", "SOURCE_BATCH_REFERENCE", "UNREADABLE_FLAG", "UPDATE_DATE", "UPDATE_USER_ROLE", "WEB_CONFIRMATION_ID", "WEB_ENVELOPE_NUMBER", "WEB_UPLOAD_DATE") AS 
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
       IDC.*
FROM FLCPD0_CDC.INBOUND_DOCUMENT_CT IDC
where IDC.shareplex_source_scn >= 523031955 and IDC.shareplex_source_scn <=539086134 ;