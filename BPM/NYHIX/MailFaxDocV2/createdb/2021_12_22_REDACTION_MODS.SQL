--------------------------------------------------------------------------
-- Run this script in MAXDAT@NHX1DORPHXDP.C5GIOXYSVG4C.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMP to make it look like MAXDAT@NHX1DORUHXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMU.
--
-- Please review the script before using it to make sure it won't cause any unacceptable data loss.
--
-- MAXDAT@NHX1DORPHXDP.C5GIOXYSVG4C.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMP schema extracted by user WL134672
-- MAXDAT@NHX1DORUHXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMU schema extracted by user WL134672

CREATE TABLE MAXDAT.APP_DOC_MAXE_REDACTION_DATA
(
  APP_DOC_MAXE_REDACTION_DATA_ID  NUMBER(18),
  APP_DOC_DATA_ID                 NUMBER(18),
  SEC_ROLE_ID                     NUMBER(18),
  STEP_DEFINITION_ID              NUMBER(18),
  SOURCE                          VARCHAR2(80 BYTE),
  CREATED_BY                      VARCHAR2(50 BYTE),
  CREATE_TS                       DATE,
  UPDATED_BY                      VARCHAR2(50 BYTE),
  UPDATE_TS                       DATE
);

GRANT SELECT ON MAXDAT.APP_DOC_MAXE_REDACTION_DATA TO MAXDAT_READ_ONLY;

CREATE TABLE MAXDAT.APP_DOC_MAXE_REDACTION_REASON
(
  APP_DOC_MAXE_REDACTION_REASON_ID  NUMBER(18),
  APP_DOC_MAXE_REDACTION_DATA_ID    NUMBER(18),
  REDACTION_REASON                  VARCHAR2(80 BYTE),
  CREATED_BY                        VARCHAR2(50 BYTE),
  CREATE_TS                         DATE,
  UPDATED_BY                        VARCHAR2(50 BYTE),
  UPDATE_TS                         DATE
);

GRANT SELECT ON MAXDAT.APP_DOC_MAXE_REDACTION_REASON TO MAXDAT_READ_ONLY;

CREATE OR REPLACE FORCE VIEW APP_DOC_MAXE_REDACTION_REASON
(APP_DOC_DATA_ID, APP_DOC_REDACTION_DATA_ID, KOFAX_SPLIT_REDACT_SOURCE, REDACTION_DATA_IND_KOFAX, REASON_ID_KOFAX, 
 REASON_KOFAX, CREATED_BY_KOFAX_REDACT, CREATED_TS_KOFAX_REDACT, UPDATED_BY_KOFAX_REDACT, UPDATED_TS_KOFAX_REDACT, 
 APP_DOC_MAXE_REDACTION_DATA_ID, MAXE_SPLIT_REDACT_SOURCE, REDACTION_DATA_IND_MAXE, SEC_ROLE_ID, STEP_DEFINITION_ID, 
 REASON_ID_MAXE, REASON_MAXE, CREATED_BY_MAXE_REDACT, CREATED_TS_MAXE_REDACT, UPDATED_BY_MAXE_REDACT, 
 UPDATED_TS_MAXE_REDACT)
BEQUEATH DEFINER
AS 
with 
kofax as (
SELECT 'KOFAX'               AS kofax_split_redact_source,
       trunc (rea.create_ts) create_dt,
       redaction_reason      reason_id_kofax,
       report_label          AS reason_kofax,
       rea.app_doc_redaction_data_id,
       k.redaction_data_ind redaction_data_ind_kofax,
       rea.created_by        created_by_kofax_redact,
       rea.create_ts         created_ts_kofax_redact,
       rea.updated_by        updated_by_kofax_redact,
       rea.update_ts         updated_ts_kofax_redact
  FROM app_doc_redaction_data k
  JOIN app_doc_redaction_reason      rea ON k.app_doc_redaction_data_id = rea.app_doc_redaction_data_id
  JOIN enum_app_doc_redaction_reason enum ON rea.redaction_reason = enum.value
 WHERE k.app_doc_redaction_data_id IS NOT NULL
),
maxe as (
SELECT 'MAXE'                AS maxe_split_redact_source,
       app_doc_data_id       AS max_app_doc_data_id,
       doc.app_doc_maxe_redaction_data_id,
       case when doc.APP_DOC_MAXE_REDACTION_DATA_ID is not null then 1 else 0 end as redaction_data_ind_maxe,
       sec_role_id,
       step_definition_id,
       trunc (doc.create_ts) create_dt,
       redaction_reason      reason_id_maxe,
       report_label          AS reason_maxe,
       rea.created_by        created_by_maxe_redact,
       rea.create_ts         created_ts_maxe_redact,
       rea.updated_by        updated_by_maxe_redact,
       rea.update_ts         updated_ts_maxe_redact
  FROM app_doc_maxe_redaction_data doc
  JOIN app_doc_maxe_redaction_reason rea ON doc.app_doc_maxe_redaction_data_id = rea.app_doc_maxe_redaction_data_id
  JOIN enum_app_doc_redaction_reason enum ON rea.redaction_reason = enum.value
where DOC.APP_DOC_MAXE_REDACTION_DATA_ID is not null
)
SELECT ad.app_doc_data_id,
       ext.app_doc_redaction_data_id,
       kofax_split_redact_source,
       kofax.redaction_data_ind_kofax,
       kofax.reason_id_kofax,
       kofax.reason_kofax,
       kofax.created_by_kofax_redact,
       kofax.created_ts_kofax_redact,
       kofax.updated_by_kofax_redact,
       kofax.updated_ts_kofax_redact,
       maxe.app_doc_maxe_redaction_data_id,
       maxe_split_redact_source,
       maxe.redaction_data_ind_maxe,
       maxe.sec_role_id,
       maxe.step_definition_id,
       maxe.reason_id_maxe,
       maxe.reason_maxe,
       maxe.created_by_maxe_redact,
       maxe.created_ts_maxe_redact,
       maxe.updated_by_maxe_redact,
       maxe.updated_ts_maxe_redact
  FROM app_doc_data_stg ad
  JOIN app_doc_data_ext_stg ext ON ad.app_doc_data_id = ext.app_doc_data_id
  LEFT JOIN kofax ON ext.app_doc_redaction_data_id = kofax.app_doc_redaction_data_id
  LEFT JOIN maxe ON ext.app_doc_redaction_data_id = maxe.app_doc_maxe_redaction_data_id
 WHERE 
 kofax.redaction_data_ind_kofax = 1 OR redaction_data_ind_maxe =1 
-- or ad.max_redacted_ind is not null --add later
;

GRANT SELECT ON APP_DOC_MAXE_REDACTION_REASON TO MAXDAT_READ_ONLY;

--------------------------------------------------------------------------
-- Run this script in MAXDAT@NHX1DORPHXDP.C5GIOXYSVG4C.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMP to make it look like MAXDAT@NHX1DORUHXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMU.
--
-- Please review the script before using it to make sure it won't cause any unacceptable data loss.
--
-- MAXDAT@NHX1DORPHXDP.C5GIOXYSVG4C.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMP schema extracted by user WL134672
-- MAXDAT@NHX1DORUHXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMU schema extracted by user WL134672

CREATE OR REPLACE FORCE VIEW MAXDAT.D_NYHIX_MFD_DOC_REDACTION_DAILY_SV
(SPLIT_REDACT_SOURCE, SEC_ROLE_ID, STEP_DEFINITION_ID, CREATE_DT, REDACTION_REASON, 
 REASON, CNT)
BEQUEATH DEFINER
AS 
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

GRANT SELECT ON MAXDAT.D_NYHIX_MFD_DOC_REDACTION_DAILY_SV TO MAXDAT_READ_ONLY;


