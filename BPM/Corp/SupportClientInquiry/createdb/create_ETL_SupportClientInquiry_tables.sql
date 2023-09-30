
-- SCI Tables
CREATE TABLE corp_etl_client_inquiry
(ceci_id                NUMBER(18) NOT NULL
,contact_record_id      NUMBER(18) NOT NULL
,SUPP_CONTACT_TYPE_CD   VARCHAR2(64) NOT NULL   -- CALL_RECORD.CALL_TYPE_CD
,contact_type           VARCHAR2(256) NOT NULL  -- ENUM_CALL_TYPE
,parent_record_id       NUMBER(18)     -- CALL_RECORD.PARENT_CALL_RECORD_ID
,tracking_number        VARCHAR2(32)
,SUPP_WORKER_ID         VARCHAR2(32)
,SUPP_WORKER_NAME       VARCHAR2(100)
,SUPP_CREATED_BY        VARCHAR2(32)
,created_by             VARCHAR2(100)
,created_by_unit        VARCHAR2(256)  -- EB.ENUM_GROUP_TYPE.DESCRIPTION
,created_by_role        VARCHAR2(50)   -- EB.SEC_ROLE.ROLE_NAME
,create_dt              DATE
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
,SUPP_UPDATE_BY         VARCHAR2(32)
,last_update_by_name    VARCHAR2(100)
,last_update_dt         DATE
,STG_EXTRACT_DATE       DATE       DEFAULT SYSDATE NOT NULL                                                                                                      
,STG_LAST_UPDATE_DATE   DATE       DEFAULT SYSDATE NOT NULL
,STAGE_DONE_DATE        DATE
,participant_status     VARCHAR2(15)
,cancel_method          VARCHAR2(50)
,cancel_reason          VARCHAR2(256)
,cancel_by              VARCHAR2(50)) 
tablespace MAXDAT_DATA;

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


grant select on corp_etl_client_inquiry to MAXDAT_READ_ONLY;


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
,supp_addr_id           NUMBER(18)
,residence_county       VARCHAR2(32)
,service_area           VARCHAR2(64)
,region                 VARCHAR2(64)) 
tablespace MAXDAT_DATA ;

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

grant select on corp_etl_client_inquiry_dtl to MAXDAT_READ_ONLY;


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
,contact_record_id      NUMBER(18) NOT NULL) 
tablespace MAXDAT_DATA;

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

grant select on corp_etl_client_inquiry_event to MAXDAT_READ_ONLY;


-- OLTP/WIP Tables
CREATE TABLE corp_etl_clnt_inqry_oltp
(ceci_id                NUMBER(18) NOT NULL
,contact_record_id      NUMBER(18) NOT NULL
,SUPP_CONTACT_TYPE_CD   VARCHAR2(64) NOT NULL   -- CALL_RECORD.CALL_TYPE_CD
,contact_type           VARCHAR2(256) NOT NULL  -- ENUM_CALL_TYPE
,parent_record_id       NUMBER(18)     -- CALL_RECORD.PARENT_CALL_RECORD_ID
,tracking_number        VARCHAR2(32)
,SUPP_WORKER_ID         VARCHAR2(32)
,SUPP_WORKER_NAME       VARCHAR2(100)
,SUPP_CREATED_BY        VARCHAR2(32)
,created_by_unit        VARCHAR2(256)  -- EB.ENUM_GROUP_TYPE.DESCRIPTION
,created_by_role        VARCHAR2(50)   -- EB.SEC_ROLE.ROLE_NAME
,create_dt              DATE
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
,SUPP_UPDATE_BY         VARCHAR2(32)
,last_update_dt         DATE NOT NULL) 
tablespace MAXDAT_DATA;

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

grant select on corp_etl_clnt_inqry_oltp to MAXDAT_READ_ONLY;


CREATE TABLE corp_etl_clnt_inqry_wip
(ceci_id                NUMBER(18) NOT NULL
,contact_record_id      NUMBER(18) NOT NULL
,SUPP_CONTACT_TYPE_CD   VARCHAR2(64)  NOT NULL  -- CALL_RECORD.CALL_TYPE_CD
,contact_type           VARCHAR2(256) NOT NULL  -- ENUM_CALL_TYPE
,parent_record_id       NUMBER(18)     -- CALL_RECORD.PARENT_CALL_RECORD_ID
,tracking_number        VARCHAR2(32)
,SUPP_WORKER_ID         VARCHAR2(32)
,SUPP_WORKER_NAME       VARCHAR2(100)
,SUPP_CREATED_BY        VARCHAR2(32)
,created_by             VARCHAR2(100)
,create_dt              DATE
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
,SUPP_UPDATE_BY         VARCHAR2(32)
,last_update_by_name    VARCHAR2(100)
,last_update_dt         DATE
,STG_EXTRACT_DATE       DATE       DEFAULT SYSDATE NOT NULL                                                                                                      
,STG_LAST_UPDATE_DATE   DATE       DEFAULT SYSDATE NOT NULL
,STAGE_DONE_DATE        DATE
,bpm_ind                VARCHAR2(1)
,participant_status     VARCHAR2(15)
,cancel_method          VARCHAR2(50)
,cancel_reason          VARCHAR2(256)
,cancel_by              VARCHAR2(50)) 
tablespace MAXDAT_DATA;

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

grant select on corp_etl_clnt_inqry_wip to MAXDAT_READ_ONLY;


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
,supp_addr_id           NUMBER(18)
,residence_county       VARCHAR2(32)
,service_area           VARCHAR2(64)
,region                 VARCHAR2(64)) 
tablespace MAXDAT_DATA;

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

grant select on corp_etl_clnt_inqry_dtl_oltp to MAXDAT_READ_ONLY;


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
,supp_addr_id           NUMBER(18)
,residence_county       VARCHAR2(32)
,service_area           VARCHAR2(64)
,region                 VARCHAR2(64)) 
tablespace MAXDAT_DATA;

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

grant select on corp_etl_clnt_inqry_dtl_wip to MAXDAT_READ_ONLY;


-- EVENT Tables
CREATE TABLE corp_etl_clnt_inqry_event_oltp
(cecie_id               NUMBER(18) NOT NULL
,ceci_id                NUMBER(18) NOT NULL
,event_id               NUMBER(18) NOT NULL
,supp_event_created_by	VARCHAR2(32)
,EVENT_CREATE_DT	DATE
,supp_event_type_cd	VARCHAR2(32)
--,EVENT_TYPE             VARCHAR2(256)
,supp_event_context	VARCHAR2(64)
,EVENT_ACTION           VARCHAR2(256)
,MANUAL_ACTION_CATEGORY VARCHAR2(64)
--,TASK_ID                NUMBER(18)
,EVENT_REF_ID           NUMBER(18)
,EVENT_REF_TYPE         VARCHAR2(32)
,contact_record_id      NUMBER(18) NOT NULL) 
tablespace MAXDAT_DATA;

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

grant select on corp_etl_clnt_inqry_event_oltp to MAXDAT_READ_ONLY;


CREATE TABLE corp_etl_clnt_inqry_event_wip
(cecie_id               NUMBER(18) NOT NULL
,ceci_id                NUMBER(18) NOT NULL
,event_id               NUMBER(18) NOT NULL
,supp_event_created_by	VARCHAR2(32)
,event_created_by	VARCHAR2(100)
,EVENT_CREATE_DT	DATE
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
,contact_record_id NUMBER(18) NOT NULL) 
tablespace MAXDAT_DATA;

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

grant select on corp_etl_clnt_inqry_event_wip to MAXDAT_READ_ONLY;




