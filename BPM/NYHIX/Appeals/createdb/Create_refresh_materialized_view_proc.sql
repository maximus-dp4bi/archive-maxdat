--------------------------------------------------------
--  File created - Friday-October-12-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure REFRESH_MATERIALIZED_VIEW
--------------------------------------------------------
set define off;

CREATE OR REPLACE EDITIONABLE PROCEDURE "MAXDAT"."REFRESH_MATERIALIZED_VIEW" AS 
BEGIN
dbms_snapshot.refresh('TEMP_INCIDENT_STATUS_HISTORY_SV','complete');
END REFRESH_MATERIALIZED_VIEW;

/
