
CREATE TABLE corp_etl_clnt_inqry_wip
(ceci_id                NUMBER(18) NOT NULL
,contact_record_id      NUMBER(18) NOT NULL
,SUPP_CONTACT_TYPE_CD   VARCHAR2(64)  NOT NULL  -- CALL_RECORD.CALL_TYPE_CD
,contact_type           VARCHAR2(256) NOT NULL  -- ENUM_CALL_TYPE
,parent_record_id       NUMBER(18)     -- CALL_RECORD.PARENT_CALL_RECORD_ID
,tracking_number        VARCHAR2(32)
,SUPP_WORKER_ID         VARCHAR2(32)
,SUPP_WORKER_NAME       VARCHAR2(100)
,SUPP_CREATED_BY        VARCHAR2(32)  NOT NULL
,created_by             VARCHAR2(100) NOT NULL
,created_by_unit        VARCHAR2(256)  -- EB.ENUM_GROUP_TYPE.DESCRIPTION
,created_by_role        VARCHAR2(50)   -- EB.SEC_ROLE.ROLE_NAME
,create_dt              DATE          NOT NULL
,complete_dt            DATE
,contact_start_dt       DATE
,contact_end_dt         DATE
--,handle_time            NUMBER
,SUPP_CONTACT_GROUP_CD  VARCHAR2(64)   -- CALL_RECORD.CALLER_TYPE_CD
,contact_group          VARCHAR2(256)  -- ENUM_CALLER_TYPE
,SUPP_LANGUAGE_CD       VARCHAR2(32)   -- CALL_RECORD.LANGUAGE_CD
,language               VARCHAR2(256)  -- ENUM_LANGUAGE.DESCRIPTION
,translation_req        VARCHAR2(1)
--,contact_phone          VARCHAR2(16)   -- CALL_RECORD.CONTACT_PHONE
,ext_telephony_ref      VARCHAR2(32)   -- CALL_RECORD.EXT_TELEPHONY_REF
--,participant_status     VARCHAR2(20)   -- Calc attribute (Semantic)
--,relationship_to_participant VARCHAR2(256)    -- ENUM_RELATIONSHIP.DESCRIPTION What about auth reps?
--,referral_source       VARCHAR2(256)   -- CALL_RECORD.CALL_RECORD_FIELD1
,SUPP_LATEST_NOTE_ID   NUMBER(18)      -- NOTE.NOTE_ID
,note_category         VARCHAR2(32)    -- NOTE.CATEGORY_CD
,note_type             VARCHAR2(32)    -- NOTE.NOTE_TYPE_CD
,note_source           VARCHAR2(80)    -- NOTE.SOURCE
,note_present          VARCHAR2(1) DEFAULT 'N'
,contact_record_field1 VARCHAR2(80)
,contact_record_field2 VARCHAR2(80)
,contact_record_field3 VARCHAR2(80)
,contact_record_field4 VARCHAR2(80)
,contact_record_field5 VARCHAR2(80)
,assd_handle_contact   DATE
,ased_handle_contact   DATE
,aspb_handle_contact   VARCHAR2(100)
,assd_create_route_work DATE
,ased_create_route_work DATE
,gwf_work_identified    VARCHAR2(1)
,asf_handle_contact     VARCHAR2(1) DEFAULT 'N' NOT NULL
,asf_create_route_work  VARCHAR2(1) DEFAULT 'N' NOT NULL
,asf_cancel_contact     VARCHAR2(1) DEFAULT 'N' NOT NULL
,instance_status        VARCHAR2(10) DEFAULT 'Active' NOT NULL
,cancel_dt              DATE
,SUPP_UPDATE_BY         VARCHAR2(32) NOT NULL
,last_update_by_name    VARCHAR2(100) NOT NULL
,last_update_dt         DATE       NOT NULL
,STG_EXTRACT_DATE       DATE       DEFAULT SYSDATE NOT NULL                                                                                                      
,STG_LAST_UPDATE_DATE   DATE       DEFAULT SYSDATE NOT NULL
,STAGE_DONE_DATE        DATE
,bpm_ind                VARCHAR2(1)
,participant_status     VARCHAR2(15)
,cancel_method          VARCHAR2(50)
,cancel_reason          VARCHAR2(256)
,cancel_by              VARCHAR2(50)
);
ALTER TABLE corp_etl_clnt_inqry_wip
  ADD CONSTRAINT etl_clnt_inqry_wip_pk
  PRIMARY KEY ( ceci_id )
  USING INDEX TABLESPACE MAXDAT_INDX;
CREATE UNIQUE INDEX etl_clnt_inqry_wip_uk ON corp_etl_clnt_inqry_wip
 ( contact_record_id )
  LOGGING TABLESPACE MAXDAT_INDX;
ALTER TABLE corp_etl_clnt_inqry_wip ADD 
CONSTRAINT etl_clnt_inqry_wip_uk
  UNIQUE ( contact_record_id )
  ENABLE VALIDATE;
ALTER TABLE corp_etl_clnt_inqry_wip ADD 
CONSTRAINT etl_clnt_inqry_wip_c01
  CHECK ( supp_contact_type_cd IN ('INBOUND', 'OUTBOUND') )
  ENABLE VALIDATE;
ALTER TABLE corp_etl_clnt_inqry_wip ADD 
CONSTRAINT etl_clnt_inqry_wip_c02
  CHECK ( contact_type IN ('Inbound', 'Outbound') )
  ENABLE VALIDATE;
ALTER TABLE corp_etl_clnt_inqry_wip ADD 
CONSTRAINT etl_clnt_inqry_wip_c03
  CHECK ( translation_req IN ('N', 'Y', NULL) )
  ENABLE VALIDATE;
ALTER TABLE corp_etl_clnt_inqry_wip ADD 
CONSTRAINT etl_clnt_inqry_wip_c04
  CHECK ( instance_status IN ('Active', 'Complete') )
  ENABLE VALIDATE;
ALTER TABLE corp_etl_clnt_inqry_wip ADD 
CONSTRAINT etl_clnt_inqry_wip_c05
  CHECK ( bpm_ind IN ('N', 'Y', NULL) )
  ENABLE VALIDATE;
ALTER TABLE corp_etl_clnt_inqry_wip ADD 
CONSTRAINT etl_clnt_inqry_wip_c06
  CHECK ( note_present IN ('N', 'Y', NULL) )
  ENABLE VALIDATE;

