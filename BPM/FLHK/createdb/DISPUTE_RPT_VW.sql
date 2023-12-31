--DISPUTE_RPT_VW
--  CREATE OR REPLACE FORCE VIEW "FLCPD0_STAGE"."DISPUTE_RPT_VW" ("OPERATION$", "CSCN$", "COMMIT_TIMESTAMP$", "XIDUSN$", "XIDSLT$", "XIDSEQ$", "DDLDESC$", "DDLOPER$", "DDLPDOBJN$", "RSID$", "TARGET_COLMAP$", "TIMESTAMP$", "USERNAME$", "ACCOUNT_ID", "APPROVED_FLAG", "CONTINUE_COVERAGE_FLAG", "CREATION_DATE", "DISPOSITION_CODE", "DISPUTE_ID", "DISPUTE_STATUS", "INSERT_DATE", "INSERT_JOB_NAME", "INSERT_USER", "INSERT_USER_ROLE", "JPA_VERSION", "LAST_UPDATE_JOB_NAME", "LAST_UPDATE_USER", "LIABLE_PARTY_NAME", "MAXIMUS_RETURN_IND", "NOTE", "REQUESTOR_NAME", "RESOLUTION_COMMENTS", "UPDATE_DATE", "UPDATE_USER_ROLE") AS 
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
       DC.*
 FROM "FLCPD0_CDC"."DISPUTE_CT" DC
 WHERE DC.shareplex_source_scn >= 523031955 AND DC.shareplex_source_scn <= 539086134 ;
