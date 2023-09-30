
CREATE TABLE corp_etl_clnt_inqry_dtl_wip
(cecid_id               NUMBER(18) NOT NULL
,ceci_id                NUMBER(18) NOT NULL
,contact_record_link_id NUMBER(18) NOT NULL
,client_id              NUMBER(18) NOT NULL
,case_id                NUMBER(18) NOT NULL
,program_type           VARCHAR2(32)
,program_subtype        VARCHAR2(32)
,bpm_ind                VARCHAR2(1)
,contact_record_id      NUMBER(18) NOT NULL
,translation_req        VARCHAR2(1)
,participant_status     VARCHAR2(15)
,client_under_twentyone VARCHAR2(1)
);
ALTER TABLE corp_etl_clnt_inqry_dtl_wip
  ADD CONSTRAINT etl_clnt_inqry_dtl_wip_pk
  PRIMARY KEY ( cecid_id )
  USING INDEX TABLESPACE MAXDAT_INDX;
CREATE UNIQUE INDEX etl_clnt_inqry_dtl_wip_uk_idx ON corp_etl_clnt_inqry_dtl_wip
 ( contact_record_link_id )
  LOGGING TABLESPACE MAXDAT_INDX;
ALTER TABLE corp_etl_clnt_inqry_dtl_wip ADD 
CONSTRAINT etl_clnt_inqry_dtl_wip_uk
  UNIQUE ( contact_record_link_id )
  ENABLE VALIDATE;
ALTER TABLE corp_etl_clnt_inqry_dtl_wip ADD 
CONSTRAINT etl_clnt_inqry_dtl_wip_c04
  CHECK ( bpm_ind IN ('N', 'Y', NULL) )
  ENABLE VALIDATE;


