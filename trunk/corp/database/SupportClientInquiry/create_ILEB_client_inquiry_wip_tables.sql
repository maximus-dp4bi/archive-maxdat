
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
,created_by_unit        VARCHAR2(256)  -- EB.ENUM_GROUP_TYPE.DESCRIPTION
,created_by_role        VARCHAR2(50)   -- EB.SEC_ROLE.ROLE_NAME
,create_dt              DATE          NOT NULL
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
,create_dt              DATE          NOT NULL
,created_by_unit        VARCHAR2(256)  -- EB.ENUM_GROUP_TYPE.DESCRIPTION
,created_by_role        VARCHAR2(50)   -- EB.SEC_ROLE.ROLE_NAME
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


-- DTL Tables
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



-- EVENT Tables
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

CREATE TABLE corp_etl_clnt_inqry_event_wip
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
,bpm_ind                VARCHAR2(1)
,contact_record_id NUMBER(18) NOT NULL
);
ALTER TABLE corp_etl_clnt_inqry_event_wip
  ADD CONSTRAINT etl_clnt_inqry_event_wip_pk
  PRIMARY KEY ( cecie_id )
  USING INDEX TABLESPACE MAXDAT_INDX;
CREATE UNIQUE INDEX etl_clnt_inqry_event_wip_uk ON corp_etl_clnt_inqry_event_wip
 ( event_id )
  LOGGING TABLESPACE MAXDAT_INDX;
ALTER TABLE corp_etl_clnt_inqry_event_wip ADD 
CONSTRAINT etl_clnt_inqry_dtl_eve_wip_uk
  UNIQUE ( event_id )
  ENABLE VALIDATE;
ALTER TABLE corp_etl_clnt_inqry_event_wip ADD 
CONSTRAINT etl_clnt_inqry_event_wip_c04
  CHECK ( bpm_ind IN ('N', 'Y', NULL) )
  ENABLE VALIDATE;


-- Synonym and Grants
CREATE PUBLIC SYNONYM corp_etl_clnt_inqry_oltp FOR corp_etl_clnt_inqry_oltp;
CREATE PUBLIC SYNONYM corp_etl_clnt_inqry_wip FOR corp_etl_clnt_inqry_wip;
CREATE PUBLIC SYNONYM corp_etl_clnt_inqry_dtl_oltp FOR corp_etl_clnt_inqry_dtl_oltp;
CREATE PUBLIC SYNONYM corp_etl_clnt_inqry_dtl_wip FOR corp_etl_clnt_inqry_dtl_wip;
CREATE PUBLIC SYNONYM corp_etl_clnt_inqry_event_oltp FOR corp_etl_clnt_inqry_event_oltp;
CREATE PUBLIC SYNONYM corp_etl_clnt_inqry_event_wip FOR corp_etl_clnt_inqry_event_wip;

GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_clnt_inqry_oltp TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_clnt_inqry_oltp TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON corp_etl_clnt_inqry_oltp TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_clnt_inqry_wip TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_clnt_inqry_wip TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON corp_etl_clnt_inqry_wip TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_clnt_inqry_dtl_oltp TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_clnt_inqry_dtl_oltp TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON corp_etl_clnt_inqry_dtl_oltp TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_clnt_inqry_dtl_wip TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_clnt_inqry_dtl_wip TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON corp_etl_clnt_inqry_dtl_wip TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_clnt_inqry_event_oltp TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_clnt_inqry_event_oltp TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON corp_etl_clnt_inqry_event_oltp TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_clnt_inqry_event_wip TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_clnt_inqry_event_wip TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON corp_etl_clnt_inqry_event_wip TO MAXDAT_READ_ONLY;


-- Triggers
CREATE OR REPLACE TRIGGER trg_biu_etl_clnt_inqry_wip
BEFORE INSERT OR UPDATE ON corp_etl_clnt_inqry_wip
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
BEGIN
  IF (:n.supp_contact_type_cd IS NULL AND :n.contact_type IS NOT NULL) OR
     (:n.supp_contact_type_cd IS NOT NULL AND :n.contact_type IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20101, 'Value and supplementary do not match: SUPP_CONTACT_TYPE_CD/CONTACT_TYPE');
  END IF;
  IF (:n.supp_contact_group_cd IS NULL AND :n.contact_group IS NOT NULL) OR
     (:n.supp_contact_group_cd IS NOT NULL AND :n.contact_group IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20102, 'Value and supplementary do not match: SUPP_CONTACT_GROUP_CD/CONTACT_GROUP');
  END IF;
  IF (:n.supp_language_cd IS NULL AND :n.language IS NOT NULL) OR
     (:n.supp_language_cd IS NOT NULL AND :n.language IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20103, 'Value and supplementary do not match: SUPP_LANGUAGE_CD/LANGUAGE');
  END IF;
  IF (:n.supp_created_by IS NULL AND :n.created_by IS NOT NULL) OR
     (:n.supp_created_by IS NOT NULL AND :n.created_by IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20104, 'Value and supplementary do not match: SUPP_CREATED_BY/CREATED_BY');
  END IF;
  IF (:n.supp_update_by IS NULL AND :n.last_update_by_name IS NOT NULL) OR
     (:n.supp_update_by IS NOT NULL AND :n.last_update_by_name IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20105, 'Value and supplementary do not match: SUPP_UPDATE_BY/LAST_UPDATE_BY_NAME');
  END IF;
END trg_biu_etl_clnt_inqry_wip;
/

CREATE OR REPLACE TRIGGER trg_biu_etl_clnt_inqry_eve_wip
BEFORE INSERT OR UPDATE ON corp_etl_clnt_inqry_event_wip
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
BEGIN
  IF (:n.supp_event_created_by IS NULL AND :n.event_created_by IS NOT NULL) OR
     (:n.supp_event_created_by IS NOT NULL AND :n.event_created_by IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20106, 'Value and supplementary do not match: SUPP_EVENT_CREATED_BY/EVENT_CREATED_BY');
  END IF;
END trg_biu_etl_clnt_inqry_eve_wip;
/
