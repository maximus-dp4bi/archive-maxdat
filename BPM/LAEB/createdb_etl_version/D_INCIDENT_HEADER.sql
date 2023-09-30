CREATE SEQUENCE  "D_SEQ_INCIDENT_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "D_SEQ_INCIDENT_ID" TO &role_name;

-- Create table
CREATE TABLE D_INCIDENT_HEADER
 (  dp_incident_id NUMBER not null,      
    incident_header_id NUMBER(18,0),
    client_id NUMBER(18,0),
    case_id NUMBER(18,0),
    tracking_number VARCHAR2(32),
    origin_cd VARCHAR2(30),
    origin_id NUMBER(18,0),
    status_cd VARCHAR2(30),
    status_ts DATE,
    received_ts DATE,
    reporter_first_name VARCHAR2(80),
    reporter_last_name VARCHAR2(80),
    reporter_id NUMBER(18,0),
    reporter_phone VARCHAR2(32),
    reporter_type_cd VARCHAR2(30),
    reporter_relationship VARCHAR2(32),
    update_ts DATE,
    updated_by VARCHAR2(80),
    version_num NUMBER(16,0),
    create_ts DATE,
    created_by VARCHAR2(80),
    incident_header_type_cd VARCHAR2(30),
    state_received_ts DATE,
    responsible_staff_id NUMBER(18,0),
    eb_follow_up_needed_ind NUMBER(1,0),        
    description VARCHAR2(4000),    
    other_party_name VARCHAR2(80),
    actions_taken VARCHAR2(4000),
    priority_cd VARCHAR2(30),
    resolution VARCHAR2(4000),
    hearing_date DATE,
    plan_id_ext VARCHAR2(128),
    network_id_ext VARCHAR2(128),
    affected_party_type_cd VARCHAR2(30),
    selection_id NUMBER(18,0),
    affected_party_subtype_cd VARCHAR2(30),
    fair_hearing_tracking_nbr VARCHAR2(32),
    aid_to_continue_ind NUMBER(1,0),
    responsible_staff_group_id NUMBER(18,0),
    outreach_contact_info VARCHAR2(256),
    state_id VARCHAR2(128),
    application_id VARCHAR2(128),
    other_party_type_cd VARCHAR2(50),
    action_taken_cd VARCHAR2(50),
    resolution_type_cd VARCHAR2(50),
    non_incident_ind NUMBER(1,0),
    generic_field1 VARCHAR2(50),
    generic_field2 VARCHAR2(50),
    generic_field3 VARCHAR2(50),
    generic_field4 VARCHAR2(50),
    generic_field5 VARCHAR2(50),
    survey_id NUMBER(18,0),
    dp_updated_by VARCHAR2(80),
    dp_date_updated DATE,
    dp_created_by VARCHAR2(80),
    dp_date_created DATE)
tablespace &tablespace_name
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate indexes 
create index IDX2_INCIDENTNUM on D_INCIDENT_HEADER (incident_header_id)
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
create index IDX3_IHCLIENTNUM on D_INCIDENT_HEADER (CLIENT_ID)
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  
  
create index IDX4_IHCASENUM on D_INCIDENT_HEADER (CASE_ID)
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );    
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table D_INCIDENT_HEADER
  add constraint INCIDENT_PK primary key (DP_INCIDENT_ID)
  using index 
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
 
-- Grant/Revoke object privileges 
grant select on D_INCIDENT_HEADER to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_INCIDENT"
 BEFORE INSERT OR UPDATE
 ON d_incident_header
 FOR EACH ROW
DECLARE
    v_seq_id     D_INCIDENT_HEADER.dp_incident_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_incident_id IS NULL THEN
        SElECT D_SEQ_INCIDENT_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_incident_id       := v_seq_id;
      END IF;

    :NEW.dp_created_by := user;
    :NEW.dp_date_created := sysdate;

  END IF;

  :NEW.dp_updated_by := user;
  :NEW.dp_date_updated := sysdate;
  
END BUIR_INCIDENT;
/

ALTER TRIGGER "BUIR_INCIDENT" ENABLE;
/


begin
DBMS_ERRLOG.CREATE_ERROR_LOG ('D_INCIDENT_HEADER','ERRLOG_INCIDENT');
  end;
/


-- Create table
create table S_INCIDENT_HEADER_STG
(
    incident_header_id NUMBER(18,0),
    client_id NUMBER(18,0),
    case_id NUMBER(18,0),
    tracking_number VARCHAR2(32),
    origin_cd VARCHAR2(30),
    origin_id NUMBER(18,0),
    status_cd VARCHAR2(30),
    status_ts DATE,
    received_ts DATE,
    reporter_first_name VARCHAR2(80),
    reporter_last_name VARCHAR2(80),
    reporter_id NUMBER(18,0),
    reporter_phone VARCHAR2(32),
    reporter_type_cd VARCHAR2(30),
    reporter_relationship VARCHAR2(32),
    update_ts DATE,
    updated_by VARCHAR2(80),
    version_num NUMBER(16,0),
    create_ts DATE,
    created_by VARCHAR2(80),
    incident_header_type_cd VARCHAR2(30),
    state_received_ts DATE,
    responsible_staff_id NUMBER(18,0),
    eb_follow_up_needed_ind NUMBER(1,0),        
    description VARCHAR2(4000),    
    other_party_name VARCHAR2(80),
    actions_taken VARCHAR2(4000),
    priority_cd VARCHAR2(30),
    resolution VARCHAR2(4000),
    hearing_date DATE,
    plan_id_ext VARCHAR2(128),
    network_id_ext VARCHAR2(128),
    affected_party_type_cd VARCHAR2(30),
    selection_id NUMBER(18,0),
    affected_party_subtype_cd VARCHAR2(30),
    fair_hearing_tracking_nbr VARCHAR2(32),
    aid_to_continue_ind NUMBER(1,0),
    responsible_staff_group_id NUMBER(18,0),
    outreach_contact_info VARCHAR2(256),
    state_id VARCHAR2(128),
    application_id VARCHAR2(128),
    other_party_type_cd VARCHAR2(50),
    action_taken_cd VARCHAR2(50),
    resolution_type_cd VARCHAR2(50),
    non_incident_ind NUMBER(1,0),
    generic_field1 VARCHAR2(50),
    generic_field2 VARCHAR2(50),
    generic_field3 VARCHAR2(50),
    generic_field4 VARCHAR2(50),
    generic_field5 VARCHAR2(50),
    survey_id NUMBER(18,0) )
tablespace &tablespace_name
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
-- Grant/Revoke object privileges 
grant select on S_INCIDENT_HEADER_STG to &role_name;

create index STG_IDX2_INCDENTNUM on S_INCIDENT_HEADER_STG (INCIDENT_HEADER_ID)
  tablespace &tablespace_name
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

CREATE OR REPLACE VIEW D_PI_COMPLAINT_CALL_SV AS
SELECT /*+ parallel(10) */ distinct    
    i.incident_header_id AS INCIDENT_HEADER_ID
    , cr.call_record_id AS CONTACT_RECORD_ID
    , i.case_id AS CASE_ID --Link to EMRS_D_CASE_SV, EMRS_D_CASE_RES_ADDRESS_SV --But there is no requirement so far for CASE information, this is used for the case Address
    , COALESCE(crl.client_id,i.client_id) AS CLIENT_ID --connect to EMRS_D_CLIENT_SV in the Client Attribute
    , COALESCE(cr.call_start_ts, i.create_ts) AS COMPLAINT_DATE --Link to D_DATES to D_MONTH
    , i.origin_cd AS INCIDENT_ORIGIN_CD  --Link to D_PI_INCIDENT_ORIGIN_SV
    , i.status_cd AS INCIDENT_STATUS_CD -- Link to D_PI_INCIDENT_STATUS_SV
    , i.reporter_type_cd AS COMPLAINT_SOURCE  --cannot find a lookup
    , COALESCE(i.affected_party_type_cd, 'UD') AS AFFECTED_PARTY_TYPE_CD --Connect to EMRS_D_AFFECTED_PARTY_TYPE_SV lookup
    , COALESCE(i.affected_party_subtype_cd, 'UD') AS AFFECTED_PARTY_SUBTYPE_CD --Connect to EMRS_D_AFFECTED_PARTY_SUBTYPE_SV lookup
    , COALESCE(cl.clnt_fname, i.reporter_first_name) AS MEMBER_FIRST_NAME_FOR_RPT_115
    , COALESCE(cl.clnt_lname, i.reporter_last_name) AS MEMBER_LAST_NAME_FOR_RPT_115
    , CASE WHEN cl.client_id IS NOT NULL THEN 
            cl.clnt_fname||
                CASE
                  WHEN SUBSTR(cl.clnt_mi,1,1) IS NULL
                  THEN ' '
                  ELSE ' '||SUBSTR(cl.clnt_mi,1,1)||' '
                END ||cl.clnt_lname
       ELSE         
                CASE WHEN LENGTH(i.reporter_last_name) > 1
                    THEN i.reporter_first_name||' '||i.reporter_last_name
                    ELSE NULL
                    END
       END AS MEMBER_FULL_NAME_FOR_RPT_115
    , i.reporter_first_name AS REPORTER_FIRST_NAME
    , i.reporter_last_name AS REPORTER_LAST_NAME
    , CASE WHEN LENGTH(reporter_last_name) > 1
          THEN i.reporter_first_name||' '||i.reporter_last_name
          ELSE NULL
          END AS REPORTER_FULL_NAME
    , CASE WHEN i.reporter_phone IS NOT NULL 
            THEN '('||SUBSTR( i.reporter_phone,1,3)||')'||SUBSTR( i.reporter_phone,4,3)||'-'||SUBSTR( i.reporter_phone,7) END AS REPORTER_PHONE
    , dbms_lob.substr(i.description, 3999, 1) AS COMPLAINT_ABOUT
    , i.actions_taken complaint_action_taken 
FROM d_incident_header i
JOIN d_event e  ON (i.incident_header_id = e.ref_id AND e.ref_type = 'INCIDENT' AND e.event_type_cd = 'COMPLAINT_INITIATED')
LEFT JOIN d_call_record cr ON e.call_record_id = cr.call_record_id
LEFT JOIN d_call_record_link crl ON (cr.call_record_id = crl.call_record_id)
LEFT JOIN emrs_d_client cl ON (cl.client_id = COALESCE(crl.client_id,i.client_id))
WHERE i.incident_header_type_cd = 'COMPLAINT';
 
  
GRANT SELECT ON D_PI_COMPLAINT_CALL_SV TO &role_name;
