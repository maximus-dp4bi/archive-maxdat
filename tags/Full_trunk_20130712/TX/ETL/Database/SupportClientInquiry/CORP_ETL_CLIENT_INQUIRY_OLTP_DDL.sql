
-- INQUIRY Tables
CREATE TABLE corp_etl_clnt_inqry_oltp
(ceci_id                NUMBER(18) NOT NULL
,contact_record_id      NUMBER(18) NOT NULL
,SUPP_CONTACT_TYPE_CD   VARCHAR2(64) NOT NULL   -- CALL_RECORD.CALL_TYPE_CD
,contact_type           VARCHAR2(256) NOT NULL  -- ENUM_CALL_TYPE
,parent_record_id       NUMBER(18)     -- CALL_RECORD.PARENT_CALL_RECORD_ID
,tracking_number        VARCHAR2(32)
,SUPP_WORKER_ID         VARCHAR2(32)
,SUPP_WORKER_NAME       VARCHAR2(100)
,SUPP_CREATED_BY        VARCHAR2(32)  NOT NULL
,create_dt              DATE          NOT NULL
,created_by_unit        VARCHAR2(256)  -- EB.ENUM_GROUP_TYPE.DESCRIPTION
,created_by_role        VARCHAR2(50)   -- EB.SEC_ROLE.ROLE_NAME
,contact_start_dt       DATE
,contact_end_dt         DATE
,SUPP_CONTACT_GROUP_CD  VARCHAR2(64)   -- CALL_RECORD.CALLER_TYPE_CD
,contact_group          VARCHAR2(256)  -- ENUM_CALLER_TYPE
,SUPP_LANGUAGE_CD       VARCHAR2(32)   -- CALL_RECORD.LANGUAGE_CD
,language               VARCHAR2(256)  -- ENUM_LANGUAGE.DESCRIPTION
--,translation_req        VARCHAR2(1)  -- Derived from CASE.TRANSLATION_REQ_IND
--,contact_phone          VARCHAR2(16)   -- CALL_RECORD.CONTACT_PHONE
,ext_telephony_ref      VARCHAR2(32)   -- CALL_RECORD.EXT_TELEPHONY_REF
--,participant_status     VARCHAR2(20)   -- Participant/Non-Participant from DTL client ID
--,referral_source       VARCHAR2(256)   -- CALL_RECORD.CALL_RECORD_FIELD1
,SUPP_LATEST_NOTE_ID   NUMBER(18)      -- NOTE.NOTE_ID
,note_category         VARCHAR2(32)    -- NOTE.CATEGORY_CD
,note_type             VARCHAR2(32)    -- NOTE.NOTE_TYPE_CD
,note_source           VARCHAR2(80)    -- NOTE.SOURCE
,contact_record_field1 VARCHAR2(80)    -- Mapped for REFERRAL_SOURCE
,contact_record_field2 VARCHAR2(80)
,contact_record_field3 VARCHAR2(80)
,contact_record_field4 VARCHAR2(80)
,contact_record_field5 VARCHAR2(80)
,SUPP_UPDATE_BY         VARCHAR2(32) NOT NULL
,last_update_dt         DATE NOT NULL
);
ALTER TABLE corp_etl_clnt_inqry_oltp
  ADD CONSTRAINT etl_clnt_inqry_oltp_pk
  PRIMARY KEY ( ceci_id )
  USING INDEX TABLESPACE MAXDAT_INDX;
CREATE UNIQUE INDEX etl_clnt_inqry_oltp_uk ON corp_etl_clnt_inqry_oltp
 ( contact_record_id )
  LOGGING TABLESPACE MAXDAT_INDX;
ALTER TABLE corp_etl_clnt_inqry_oltp ADD 
CONSTRAINT etl_clnt_inqry_oltp_uk
  UNIQUE ( contact_record_id )
  ENABLE VALIDATE;
ALTER TABLE corp_etl_clnt_inqry_oltp ADD 
CONSTRAINT etl_clnt_inqry_oltp_c01
  CHECK ( supp_contact_type_cd IN ('INBOUND', 'OUTBOUND') )
  ENABLE VALIDATE;


