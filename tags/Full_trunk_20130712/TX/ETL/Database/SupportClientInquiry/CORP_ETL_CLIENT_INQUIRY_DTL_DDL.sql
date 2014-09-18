-- TXEB, initial deployment: added staff unit, team, and role; client under-21


-- Tables
CREATE TABLE corp_etl_client_inquiry_dtl
(cecid_id               NUMBER(18) NOT NULL
,ceci_id                NUMBER(18) NOT NULL
,contact_record_link_id NUMBER(18) NOT NULL
,client_id              NUMBER(18) NOT NULL
,case_id                NUMBER(18) NOT NULL
,program_type           VARCHAR2(32)
,program_subtype        VARCHAR2(32)
,STG_EXTRACT_DATE       DATE       DEFAULT SYSDATE NOT NULL                                                                                                      
,STG_LAST_UPDATE_DATE   DATE       DEFAULT SYSDATE NOT NULL
,contact_record_id      NUMBER(18) NOT NULL
,translation_req        VARCHAR2(1)
,participant_status     VARCHAR2(15)
,client_under_twentyone VARCHAR2(1)
);

ALTER TABLE corp_etl_client_inquiry_dtl
  ADD CONSTRAINT corp_etl_client_inquiry_dtl_pk
  PRIMARY KEY ( cecid_id )
  USING INDEX TABLESPACE MAXDAT_INDX;
CREATE UNIQUE INDEX corp_etl_clnt_inqry_dtl_uk_idx ON corp_etl_client_inquiry_dtl
 ( contact_record_link_id )
  LOGGING TABLESPACE MAXDAT_INDX;
ALTER TABLE corp_etl_client_inquiry_dtl ADD 
CONSTRAINT corp_etl_clnt_inqry_dtl_uk
  UNIQUE ( contact_record_link_id )
  ENABLE VALIDATE;
CREATE INDEX corp_etl_clnt_inqry_dtl_idx01 ON corp_etl_client_inquiry_dtl
 ( ceci_id )
  LOGGING TABLESPACE MAXDAT_INDX;
CREATE INDEX corp_etl_clnt_inqry_dtl_idx02 ON corp_etl_client_inquiry_dtl
 ( contact_record_id )
  LOGGING TABLESPACE MAXDAT_INDX;


-- Sequences
CREATE SEQUENCE seq_cecid_id START WITH 1;

