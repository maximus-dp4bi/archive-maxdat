CREATE TABLE CASE_CLIENT_STG
(CSCL_ID	NUMBER(18,0)
,CSCL_STATUS_BEGIN_DATE	DATE
,CSCL_CASE_ID	NUMBER(18,0)
,CLIENT_ID	NUMBER(18,0)
,CSCL_STATUS_END_DATE	DATE
,CREATED_BY	VARCHAR2(80)
,CREATION_DATE	DATE
,LAST_UPDATED_BY	VARCHAR2(80)
,LAST_UPDATE_DATE	DATE
,CSCL_STATUS_CD	VARCHAR2(2)
,CSCL_ADLK_ID	VARCHAR2(32)
,CSCL_RES_ADDR_ID	NUMBER(18,0)
,PROGRAM_CD	VARCHAR2(32)
,STATUS_BEGIN_NDT	NUMBER(18,0)
,STATUS_END_NDT	NUMBER(18,0)
,ADLK_SUBPROGRAM	VARCHAR2(20)) TABLESPACE MAXDAT_DATA;

CREATE UNIQUE INDEX XUKCASE_CLIENT ON CASE_CLIENT_STG(cscl_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX01_CASE_CLIENT ON CASE_CLIENT_STG(client_id) TABLESPACE MAXDAT_INDX;
CREATE INDEX IDX02_CASE_CLIENT ON CASE_CLIENT_STG(cscl_adlk_id) TABLESPACE MAXDAT_INDX;

GRANT SELECT ON CASE_CLIENT_STG to MAXDAT_READ_ONLY;