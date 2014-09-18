-- Sequences
CREATE SEQUENCE seq_ceci_id START WITH 1;
CREATE SEQUENCE seq_cecid_id START WITH 1;
CREATE SEQUENCE seq_cecie_id START WITH 1;

CREATE PUBLIC SYNONYM seq_ceci_id FOR seq_ceci_id;
CREATE PUBLIC SYNONYM seq_cecid_id FOR seq_ceci_id;
CREATE PUBLIC SYNONYM seq_cecie_id FOR seq_ceci_id;

GRANT SELECT ON seq_ceci_id TO MAXDAT_OLTP_SIU;
GRANT SELECT ON seq_ceci_id TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON seq_ceci_id TO MAXDAT_READ_ONLY;

GRANT SELECT ON seq_cecid_id TO MAXDAT_OLTP_SIU;
GRANT SELECT ON seq_cecid_id TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON seq_cecid_id TO MAXDAT_READ_ONLY;

GRANT SELECT ON seq_cecie_id TO MAXDAT_OLTP_SIU;
GRANT SELECT ON seq_cecie_id TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON seq_cecie_id TO MAXDAT_READ_ONLY;


-- Tables
CREATE TABLE corp_etl_client_inquiry
(ceci_id                NUMBER(18) NOT NULL
,contact_record_id      NUMBER(18) NOT NULL
,SUPP_CONTACT_TYPE_CD   VARCHAR2(64) NOT NULL   -- CALL_RECORD.CALL_TYPE_CD
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
,contact_record_field1 VARCHAR2(80)    -- REFERRAL_SOURCE
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
,participant_status     VARCHAR2(15)
,cancel_method          VARCHAR2(50)
,cancel_reason          VARCHAR2(256)
,cancel_by              VARCHAR2(50)
);

ALTER TABLE corp_etl_client_inquiry
  ADD CONSTRAINT corp_etl_client_inquiry_pk
  PRIMARY KEY ( ceci_id )
  USING INDEX TABLESPACE MAXDAT_INDX;
CREATE INDEX corp_etl_client_inquiry_idx01 ON corp_etl_client_inquiry
 ( instance_status )
  LOGGING TABLESPACE MAXDAT_INDX;
CREATE UNIQUE INDEX corp_etl_client_inquiry_uk_idx ON corp_etl_client_inquiry
 ( contact_record_id )
  LOGGING TABLESPACE MAXDAT_INDX;
ALTER TABLE corp_etl_client_inquiry ADD 
CONSTRAINT corp_etl_client_inquiry_uk
  UNIQUE ( contact_record_id )
  ENABLE VALIDATE;
ALTER TABLE corp_etl_client_inquiry ADD 
CONSTRAINT corp_etl_client_inquiry_c01
  CHECK ( supp_contact_type_cd IN ('INBOUND', 'OUTBOUND') )
  ENABLE VALIDATE;
ALTER TABLE corp_etl_client_inquiry ADD 
CONSTRAINT corp_etl_client_inquiry_c02
  CHECK ( contact_type IN ('Inbound', 'Outbound') )
  ENABLE VALIDATE;
ALTER TABLE corp_etl_client_inquiry ADD 
CONSTRAINT corp_etl_client_inquiry_c03
  CHECK ( translation_req IN ('N', 'Y', NULL) )
  ENABLE VALIDATE;
ALTER TABLE corp_etl_client_inquiry ADD 
CONSTRAINT corp_etl_client_inquiry_c04
  CHECK ( instance_status IN ('Active', 'Complete') )
  ENABLE VALIDATE;
ALTER TABLE corp_etl_client_inquiry ADD 
CONSTRAINT corp_etl_client_inquiry_c05
  CHECK ( note_present IN ('N', 'Y', NULL) )
  ENABLE VALIDATE;


--
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


--
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



-- Synonym and Grants
CREATE PUBLIC SYNONYM corp_etl_client_inquiry FOR corp_etl_client_inquiry;
CREATE PUBLIC SYNONYM corp_etl_client_inquiry_dtl FOR corp_etl_client_inquiry_dtl;
CREATE PUBLIC SYNONYM corp_etl_client_inquiry_event FOR corp_etl_client_inquiry_event;

GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_client_inquiry TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_client_inquiry TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON corp_etl_client_inquiry TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_client_inquiry_dtl TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_client_inquiry_dtl TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON corp_etl_client_inquiry_dtl TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_client_inquiry_event TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON corp_etl_client_inquiry_event TO MAXDAT_OLTP_SIUD;
GRANT SELECT ON corp_etl_client_inquiry_event TO MAXDAT_READ_ONLY;



-- Triggers
CREATE OR REPLACE TRIGGER trg_biu_etl_client_inquiry
BEFORE INSERT OR UPDATE ON corp_etl_client_inquiry
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF :n.ceci_id IS NULL
    THEN :n.ceci_id := seq_ceci_id.NEXTVAL;
    END IF;
    --
    :n.stg_extract_date  := SYSDATE;
  END IF;
  :n.stg_last_update_date := SYSDATE;
  --
  IF (:n.supp_contact_type_cd IS NULL AND :n.contact_type IS NOT NULL) OR
     (:n.supp_contact_type_cd IS NOT NULL AND :n.contact_type IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20111, 'Value and supplementary do not match: SUPP_CONTACT_TYPE_CD/CONTACT_TYPE');
  END IF;
  IF (:n.supp_contact_group_cd IS NULL AND :n.contact_group IS NOT NULL) OR
     (:n.supp_contact_group_cd IS NOT NULL AND :n.contact_group IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20112, 'Value and supplementary do not match: SUPP_CONTACT_GROUP_CD/CONTACT_GROUP');
  END IF;
  IF (:n.supp_language_cd IS NULL AND :n.language IS NOT NULL) OR
     (:n.supp_language_cd IS NOT NULL AND :n.language IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20113, 'Value and supplementary do not match: SUPP_LANGUAGE_CD/LANGUAGE');
  END IF;
  IF (:n.supp_created_by IS NULL AND :n.created_by IS NOT NULL) OR
     (:n.supp_created_by IS NOT NULL AND :n.created_by IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20114, 'Value and supplementary do not match: SUPP_CREATED_BY/CREATED_BY');
  END IF;
  IF (:n.supp_update_by IS NULL AND :n.last_update_by_name IS NOT NULL) OR
     (:n.supp_update_by IS NOT NULL AND :n.last_update_by_name IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20115, 'Value and supplementary do not match: SUPP_UPDATE_BY/LAST_UPDATE_BY_NAME');
  END IF;
END trg_biu_etl_client_inquiry;
/

CREATE OR REPLACE TRIGGER trg_biu_etl_client_inquiry_dtl
BEFORE INSERT OR UPDATE ON corp_etl_client_inquiry_dtl
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF :n.cecid_id IS NULL
    THEN :n.cecid_id := seq_cecid_id.NEXTVAL;
    END IF;
    --
    :n.stg_extract_date := SYSDATE;
  END IF;
  :n.stg_last_update_date := SYSDATE;
END trg_biu_etl_client_inquiry_dtl;
/

CREATE OR REPLACE TRIGGER trg_biu_etl_client_inqry_event
BEFORE INSERT OR UPDATE ON corp_etl_client_inquiry_event
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF :n.cecie_id IS NULL
    THEN :n.cecie_id := seq_cecie_id.NEXTVAL;
    END IF;
    --
    :n.stg_extract_date := SYSDATE;
  END IF;
  :n.stg_last_update_date := SYSDATE;
  --
  IF (:n.supp_event_created_by IS NULL AND :n.event_created_by IS NOT NULL) OR
     (:n.supp_event_created_by IS NOT NULL AND :n.event_created_by IS NULL)
  THEN RAISE_APPLICATION_ERROR(-20116, 'Value and supplementary do not match: SUPP_EVENT_CREATED_BY/EVENT_CREATED_BY');
  END IF;
END trg_biu_etl_client_inqry_event;
/

