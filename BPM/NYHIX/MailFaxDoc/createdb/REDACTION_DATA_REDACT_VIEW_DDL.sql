
  CREATE TABLE "MAXDAT"."APP_DOC_MAXE_REDACTION_DATA" 
   (	"APP_DOC_MAXE_REDACTION_DATA_ID" NUMBER(18,0), 
	"APP_DOC_DATA_ID" NUMBER(18,0), 
	"SEC_ROLE_ID" NUMBER(18,0), 
	"STEP_DEFINITION_ID" NUMBER(18,0), 
	"SOURCE" VARCHAR2(80 BYTE), 
	"CREATED_BY" VARCHAR2(50 BYTE), 
	"CREATE_TS" DATE, 
	"UPDATED_BY" VARCHAR2(50 BYTE), 
	"UPDATE_TS" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "MAXDAT_DATA" ;

  GRANT INSERT ON "MAXDAT"."APP_DOC_MAXE_REDACTION_DATA" TO "MAXDAT_OLTP_SIU";
  GRANT SELECT ON "MAXDAT"."APP_DOC_MAXE_REDACTION_DATA" TO "MAXDAT_OLTP_SIU";
  GRANT UPDATE ON "MAXDAT"."APP_DOC_MAXE_REDACTION_DATA" TO "MAXDAT_OLTP_SIU";
  GRANT SELECT ON "MAXDAT"."APP_DOC_MAXE_REDACTION_DATA" TO "MAXDAT_REPORTS";
  GRANT SELECT ON "MAXDAT"."APP_DOC_MAXE_REDACTION_DATA" TO "MAXDAT_READ_ONLY";
  GRANT DELETE ON "MAXDAT"."APP_DOC_MAXE_REDACTION_DATA" TO "MAXDAT_OLTP_SIUD";
  GRANT INSERT ON "MAXDAT"."APP_DOC_MAXE_REDACTION_DATA" TO "MAXDAT_OLTP_SIUD";
  GRANT SELECT ON "MAXDAT"."APP_DOC_MAXE_REDACTION_DATA" TO "MAXDAT_OLTP_SIUD";
  GRANT UPDATE ON "MAXDAT"."APP_DOC_MAXE_REDACTION_DATA" TO "MAXDAT_OLTP_SIUD";


  CREATE TABLE "MAXDAT"."APP_DOC_MAXE_REDACTION_REASON" 
   (	"APP_DOC_MAXE_REDACTION_REASON_ID" NUMBER(18,0), 
	"APP_DOC_MAXE_REDACTION_DATA_ID" NUMBER(18,0), 
	"REDACTION_REASON" VARCHAR2(80 BYTE), 
	"CREATED_BY" VARCHAR2(50 BYTE), 
	"CREATE_TS" DATE, 
	"UPDATED_BY" VARCHAR2(50 BYTE), 
	"UPDATE_TS" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "MAXDAT_DATA" ;

  GRANT INSERT ON "MAXDAT"."APP_DOC_MAXE_REDACTION_REASON" TO "MAXDAT_OLTP_SIU";
  GRANT SELECT ON "MAXDAT"."APP_DOC_MAXE_REDACTION_REASON" TO "MAXDAT_OLTP_SIU";
  GRANT UPDATE ON "MAXDAT"."APP_DOC_MAXE_REDACTION_REASON" TO "MAXDAT_OLTP_SIUD";
  GRANT UPDATE ON "MAXDAT"."APP_DOC_MAXE_REDACTION_REASON" TO "MAXDAT_OLTP_SIU";
  GRANT SELECT ON "MAXDAT"."APP_DOC_MAXE_REDACTION_REASON" TO "MAXDAT_REPORTS";
  GRANT SELECT ON "MAXDAT"."APP_DOC_MAXE_REDACTION_REASON" TO "MAXDAT_READ_ONLY";
  GRANT DELETE ON "MAXDAT"."APP_DOC_MAXE_REDACTION_REASON" TO "MAXDAT_OLTP_SIUD";
  GRANT INSERT ON "MAXDAT"."APP_DOC_MAXE_REDACTION_REASON" TO "MAXDAT_OLTP_SIUD";
  GRANT SELECT ON "MAXDAT"."APP_DOC_MAXE_REDACTION_REASON" TO "MAXDAT_OLTP_SIUD";


CREATE OR REPLACE  VIEW "MAXDAT"."D_NYHIX_MFD_DOC_REDACTION_DAILY_SV"  AS 
SELECT 'MAXE' AS SPLIT_REDACT_SOURCE,
SEC_ROLE_ID, 
STEP_DEFINITION_ID,
TRUNC (DOC.CREATE_TS) CREATE_DT,REDACTION_REASON,
REPORT_LABEL AS REASON,
COUNT (DISTINCT DOC.APP_DOC_MAXE_REDACTION_DATA_ID) AS CNT
FROM APP_DOC_MAXE_REDACTION_DATA DOC 
JOIN APP_DOC_MAXE_REDACTION_REASON REA ON DOC.APP_DOC_MAXE_REDACTION_DATA_ID = REA.APP_DOC_MAXE_REDACTION_DATA_ID
JOIN ENUM_APP_DOC_REDACTION_REASON ENUM ON REA.REDACTION_REASON = ENUM.VALUE
GROUP BY SEC_ROLE_ID, 
STEP_DEFINITION_ID,
TRUNC (DOC.CREATE_TS),REDACTION_REASON,
REPORT_LABEL
UNION ALL
SELECT 'KOFAX' AS SPLIT_REDACT_SOURCE,
NULL  AS ROLE_ID,
NULL AS STEP_DEFINITION_ID,
TRUNC (DOC.CREATE_TS) CREATE_DT,
REDACTION_REASON,
REPORT_LABEL AS REASON,
COUNT (DISTINCT APP_DOC_REDACTION_DATA_ID) AS CNT
FROM APP_DOC_REDACTION_REASON DOC
JOIN ENUM_APP_DOC_REDACTION_REASON ENUM ON DOC.REDACTION_REASON = ENUM.VALUE
GROUP BY 
TRUNC (DOC.CREATE_TS),
REDACTION_REASON,
REPORT_LABEL
WITH READ ONLY;

GRANT SELECT ON "MAXDAT"."D_NYHIX_MFD_DOC_REDACTION_DAILY_SV" TO "MAXDAT_READ_ONLY";
GRANT UPDATE ON "MAXDAT"."D_NYHIX_MFD_DOC_REDACTION_DAILY_SV" TO "MAXDAT_OLTP_SIU";
GRANT SELECT ON "MAXDAT"."D_NYHIX_MFD_DOC_REDACTION_DAILY_SV" TO "MAXDAT_OLTP_SIU";
GRANT INSERT ON "MAXDAT"."D_NYHIX_MFD_DOC_REDACTION_DAILY_SV" TO "MAXDAT_OLTP_SIU";
GRANT UPDATE ON "MAXDAT"."D_NYHIX_MFD_DOC_REDACTION_DAILY_SV" TO "MAXDAT_OLTP_SIUD";
GRANT SELECT ON "MAXDAT"."D_NYHIX_MFD_DOC_REDACTION_DAILY_SV" TO "MAXDAT_OLTP_SIUD";
GRANT INSERT ON "MAXDAT"."D_NYHIX_MFD_DOC_REDACTION_DAILY_SV" TO "MAXDAT_OLTP_SIUD";
GRANT DELETE ON "MAXDAT"."D_NYHIX_MFD_DOC_REDACTION_DAILY_SV" TO "MAXDAT_OLTP_SIUD";