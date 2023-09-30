CREATE TABLE ETL_E_APP_STATUS_STAGING_STG 
(ETL_E_APP_STATUS_STAGING_ID NUMBER(18),
APPLICATION_ID	NUMBER(18),
CREATE_TS	DATE,
PROCESS_TS	DATE,
PROCESS_IND	NUMBER(1),
ERRORS	VARCHAR2(1000),
MMIS_APP_STATUS	VARCHAR2(32),
LETTER_REQ_ID	NUMBER(18),
MAILED_DATE	DATE,
LMDEF_ID	NUMBER(18),
LETTER_NAME	VARCHAR2(40),
RFI_PACKET_MAILED_DATE	DATE,
RFI_PACKET_RESPONSE_DUE_DATE	DATE ) TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX IDX01_APP_STATUS_STG ON ETL_E_APP_STATUS_STAGING_STG(ETL_E_APP_STATUS_STAGING_ID) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX02_APP_STATUS_STG ON ETL_E_APP_STATUS_STAGING_STG(APPLICATION_ID) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX03_APP_STATUS_STG ON ETL_E_APP_STATUS_STAGING_STG(LETTER_NAME) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX04_APP_STATUS_STG ON ETL_E_APP_STATUS_STAGING_STG(PROCESS_TS) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX05_APP_STATUS_STG ON ETL_E_APP_STATUS_STAGING_STG(LETTER_REQ_ID) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON ETL_E_APP_STATUS_STAGING_STG to MAXDAT_READ_ONLY;

CREATE TABLE ETL_L_APP_RENEWAL_STG(
JOB_ID	NUMBER(18),
ROW_NUM	NUMBER(8),
ERROR_COUNT	NUMBER(8),
WARNING_COUNT	NUMBER(8),
TRANSACTION_CD	VARCHAR2(2),
TRANSACTION_DATE	DATE,
APP_ID_EXT	VARCHAR2(32),
LTR_ID_EXT	VARCHAR2(32),
CASE_ID_EXT	VARCHAR2(32),
ELIGIBILITY_END_DATE	DATE,
CLNT_CIN	VARCHAR2(32),
MATCHED_CLIENT_ID	NUMBER(18),
PROGRAM_CD	VARCHAR2(32),
MATCHED_CASE_ID	NUMBER(18)) TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX IDX01_APP_RENEWAL_STG ON ETL_L_APP_RENEWAL_STG(JOB_ID,ROW_NUM) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX02_APP_RENEWAL_STG ON ETL_L_APP_RENEWAL_STG(MATCHED_CLIENT_ID) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON ETL_L_APP_RENEWAL_STG to MAXDAT_READ_ONLY;

CREATE TABLE ETL_E_DAILY_ACCENT_STAGING_STG
(ETL_E_DAILY_ACCENT_STAGING_ID	NUMBER(18,0),
APPLICATION_ID	NUMBER(18,0),
CREATE_TS	DATE,
PROCESS_TS	DATE,
PROCESS_IND	NUMBER(1,0),
TRANSACTION_CD	VARCHAR2(1 BYTE)
CLIENT_CIN	VARCHAR2(32 BYTE),
CASE_CIN	VARCHAR2(32 BYTE),
APPLICATION_DT	DATE,
VENDOR_CASE_NO	VARCHAR2(32 BYTE),
STATUS_CD	VARCHAR2(32 BYTE),
LMREQ_ID	NUMBER(18,0)) TABLESPACE MAXDAT_DATA;

GRANT SELECT ON ETL_E_DAILY_ACCENT_STAGING_STG to MAXDAT_READ_ONLY;

CREATE INDEX ETL_E_ACCENT_APP_ID	ON ETL_E_DAILY_ACCENT_STAGING_STG(APPLICATION_ID) TABLESPACE MAXDAT_INDX;
CREATE INDEX ACCENT_STAGING_LMREQ_IDX	ON ETL_E_DAILY_ACCENT_STAGING_STG(LMREQ_ID) TABLESPACE MAXDAT_INDX;
CREATE UNIQUE INDEX ETL_E_DAILY_ACCENT_STAGING_PK	ON ETL_E_DAILY_ACCENT_STAGING_STG(ETL_E_DAILY_ACCENT_STAGING_ID) TABLESPACE MAXDAT_INDX;


CREATE OR REPLACE VIEW d_mmis_app_status_sv
AS 
SELECT ai.application_id,ai.client_id, ai.client_cin,TRUNC(process_ts) process_ts,letter_type
       ,CASE WHEN mmis_app_status = 'TRMDN' AND letter_name NOT IN ('TN 408ftp','TN 409ftp') THEN 1 ELSE 0 END trmdn_substantive
       ,CASE WHEN (mmis_app_status = 'TRMDN' AND letter_name IN ('TN 408ftp','TN 409ftp')) OR (mmis_app_status = 'NR' AND letter_name = 'TN 411') THEN 1 ELSE 0 END trmdn_procedural
       ,CASE WHEN mmis_app_status = 'APPR' THEN 1 ELSE 0 END appr
       ,CASE WHEN mmis_app_status = 'PEND' THEN 1 ELSE 0 END pending
FROM app_individual_stg ai
  JOIN (SELECT *
        FROM (SELECT application_id,letter_req_id,mmis_app_status,letter_name,process_ts,ld.description letter_type,
                     ROW_NUMBER() OVER(PARTITION BY application_id, letter_req_id ORDER BY etl_e_app_status_Staging_id DESC) rn
              FROM etl_e_app_status_staging_stg es 
                LEFT JOIN d_letter_definition ld ON es.letter_name = ld.name
              WHERE es.mmis_app_status IN ('PEND','TRMDN','NR','APPR')
              AND es.process_ts IS NOT NULL)
        WHERE rn =1)     es
      ON es.application_id = ai.application_id
;

GRANT SELECT ON D_MMIS_APP_STATUS_SV to MAXDAT_READ_ONLY;


