
CREATE TABLE corp_etl_clnt_inqry_dtl_oltp
(cecid_id               NUMBER(18) NOT NULL
,ceci_id                NUMBER(18) NOT NULL
,contact_record_link_id NUMBER(18) NOT NULL
,client_id              NUMBER(18) NOT NULL
,case_id                NUMBER(18) NOT NULL
,program_type           VARCHAR2(32)
,program_subtype        VARCHAR2(32)
,contact_record_id      NUMBER(18) NOT NULL
);
ALTER TABLE corp_etl_clnt_inqry_dtl_oltp
  ADD CONSTRAINT etl_clnt_inqry_dtl_oltp_pk
  PRIMARY KEY ( cecid_id )
  USING INDEX TABLESPACE MAXDAT_INDX;
CREATE UNIQUE INDEX etl_clnt_inqry_dtl_oltp_uk_idx ON corp_etl_clnt_inqry_dtl_oltp
 ( contact_record_link_id )
  LOGGING TABLESPACE MAXDAT_INDX;
ALTER TABLE corp_etl_clnt_inqry_dtl_oltp ADD 
CONSTRAINT etl_clnt_inqry_dtl_oltp_uk
  UNIQUE ( contact_record_link_id )
  ENABLE VALIDATE;
