
CREATE TABLE corp_etl_clnt_inqry_event_oltp
(cecie_id               NUMBER(18) NOT NULL
,ceci_id                NUMBER(18) NOT NULL
,event_id               NUMBER(18) NOT NULL
,supp_event_created_by	VARCHAR2(32) NOT NULL
,EVENT_CREATE_DT	DATE          NOT NULL
,supp_event_type_cd	VARCHAR2(32)
--,EVENT_TYPE             VARCHAR2(256)
,supp_event_context	VARCHAR2(64)
,EVENT_ACTION           VARCHAR2(256)
,MANUAL_ACTION_CATEGORY VARCHAR2(64)
--,TASK_ID                NUMBER(18)
,EVENT_REF_ID           NUMBER(18)
,EVENT_REF_TYPE         VARCHAR2(32)
,contact_record_id      NUMBER(18) NOT NULL
);
ALTER TABLE corp_etl_clnt_inqry_event_oltp
  ADD CONSTRAINT etl_clnt_inqry_event_oltp_pk
  PRIMARY KEY ( cecie_id )
  USING INDEX TABLESPACE MAXDAT_INDX;
CREATE UNIQUE INDEX etl_clnt_inqry_event_oltp_uk ON corp_etl_clnt_inqry_event_oltp
 ( event_id )
  LOGGING TABLESPACE MAXDAT_INDX;
ALTER TABLE corp_etl_clnt_inqry_event_oltp ADD 
CONSTRAINT etl_clnt_inqry_dtl_eve_oltp_uk
  UNIQUE ( event_id )
  ENABLE VALIDATE;

