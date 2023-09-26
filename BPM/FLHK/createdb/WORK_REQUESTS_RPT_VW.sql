--WORK_REQUESTS_RPT_VW
CREATE OR REPLACE FORCE VIEW "FLCPD0_STAGE"."WORK_REQUESTS_RPT_VW" ("OPERATION$", "CSCN$", "COMMIT_TIMESTAMP$", "XIDUSN$", "XIDSLT$", "XIDSEQ$", "DDLDESC$", "DDLOPER$", "DDLPDOBJN$", "RSID$", "TARGET_COLMAP$", "TIMESTAMP$", "USERNAME$", "ASSIGNED_TO", "CONTEXT", "CREATED_BY", "CREATED_DATE", "DRIVER_KEY", "DUE_DATE", "INSERT_DATE", "INSERT_JOB_NAME", "INSERT_USER", "INSERT_USER_ROLE", "LAST_UPDATE_JOB_NAME", "LAST_UPDATE_USER", "PARENT_TASK_ID", "PRIORITY", "STATUS", "STATUS_DATE", "STATUS_REASON", "TASK_ID", "UPDATED_BY", "UPDATED_DATE", "UPDATE_DATE", "UPDATE_USER_ROLE", "USER_ROLE", "VERSION", "WRQ_ID", "WRRULE_ID", "WRT_ID") AS 
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
       WRC.*
FROM FLCPD0_CDC.WORK_REQUESTS_CT WRC
where WRC.shareplex_source_scn >= 523031955 and WRC.shareplex_source_scn <=539086134 ;