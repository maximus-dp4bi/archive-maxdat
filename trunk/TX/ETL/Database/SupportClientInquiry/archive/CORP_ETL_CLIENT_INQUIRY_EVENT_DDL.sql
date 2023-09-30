-- TXEB, initial deployment: added staff unit, team, and role; client under-21


-- Tables
CREATE TABLE corp_etl_client_inquiry_event
(cecie_id               NUMBER(18) NOT NULL
,ceci_id                NUMBER(18) NOT NULL
,event_id               NUMBER(18) NOT NULL
,supp_event_created_by	VARCHAR2(32) NOT NULL
,event_created_by	VARCHAR2(100) NOT NULL
,EVENT_CREATE_DT	DATE          NOT NULL
,supp_event_type_cd	VARCHAR2(32)
--,EVENT_TYPE             VARCHAR2(256)
,supp_event_context	VARCHAR2(64)
,EVENT_ACTION           VARCHAR2(256)
,MANUAL_ACTION_CATEGORY VARCHAR2(64)
--,TASK_ID                NUMBER(18)
,EVENT_REF_ID           NUMBER(18)
,EVENT_REF_TYPE         VARCHAR2(32)
,STG_EXTRACT_DATE       DATE       DEFAULT SYSDATE NOT NULL                                                                                                   
,STG_LAST_UPDATE_DATE   DATE       DEFAULT SYSDATE NOT NULL
,contact_record_id      NUMBER(18) NOT NULL
);

ALTER TABLE corp_etl_client_inquiry_event
  ADD CONSTRAINT corp_etl_client_inqry_event_pk
  PRIMARY KEY ( cecie_id )
  USING INDEX TABLESPACE MAXDAT_INDX;
CREATE UNIQUE INDEX corp_etl_clnt_inqry_event_uk ON corp_etl_client_inquiry_event
 ( event_id )
  LOGGING TABLESPACE MAXDAT_INDX;
ALTER TABLE corp_etl_client_inquiry_event ADD 
CONSTRAINT corp_etl_clnt_inqry_event_uk
  UNIQUE ( event_id )
  ENABLE VALIDATE;
CREATE INDEX corp_etl_clnt_inqry_eve_idx01 ON corp_etl_client_inquiry_event
 ( ceci_id )
  LOGGING TABLESPACE MAXDAT_INDX;
CREATE INDEX corp_etl_clnt_inqry_eve_idx02 ON corp_etl_client_inquiry_event
 ( contact_record_id )
  LOGGING TABLESPACE MAXDAT_INDX;

-- Sequences
CREATE SEQUENCE seq_cecie_id START WITH 1;


