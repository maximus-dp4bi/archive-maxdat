CREATE SEQUENCE  "EMRS_SEQ_ALERT_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_ALERT_ID" TO &role_name;

-- Create table
CREATE TABLE EMRS_D_ALERT
 (  dp_alert_id NUMBER not null,      
    alert_id NUMBER(18,0),
    case_id NUMBER(18,0),
    client_id NUMBER(18,0),
    message VARCHAR2(4000),
    start_date DATE,
    end_date DATE,
    void_ind NUMBER(1,0),
    system_alert_ind NUMBER(1,0),
    ref_type VARCHAR2(32),
    ref_id NUMBER(18,0),
    lock_id NUMBER(1,0),
    record_count NUMBER(8,0),
    alert_handler VARCHAR2(64),
    record_name VARCHAR2(80),
    record_date DATE,
    record_time VARCHAR2(10),
    modified_name VARCHAR2(80),
    modified_date DATE,
    modified_time VARCHAR2(10),
    updated_by VARCHAR2(80),
    date_updated DATE,
    created_by VARCHAR2(80),
    date_created DATE
)
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
create index IDX2_ALERTNUM on EMRS_D_ALERT (ALERT_ID)
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
  
create index IDX3_ALERTCLIENTNUM on EMRS_D_ALERT (CLIENT_ID)
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
  
create index IDX4_ALERTCASENUM on EMRS_D_ALERT (CASE_ID)
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
alter table EMRS_D_ALERT
  add constraint ALERT_PK primary key (DP_ALERT_ID)
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
grant select on EMRS_D_ALERT to &role_name;

CREATE OR REPLACE TRIGGER "BUIR_ALERT"
 BEFORE INSERT OR UPDATE
 ON emrs_d_alert
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_ALERT.dp_alert_id%TYPE;
BEGIN

  IF INSERTING THEN

      IF :NEW.dp_alert_id IS NULL THEN
        SElECT EMRS_SEQ_ALERT_ID.NEXTVAL
        INTO v_seq_id
        FROM dual;

        :NEW.dp_alert_id       := v_seq_id;
      END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;

  END IF;

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;
  
END BUIR_ALERT;
/

ALTER TRIGGER "BUIR_ALERT" ENABLE;
/

CREATE OR REPLACE VIEW EMRS_D_ALERT_SV
AS
  SELECT alert_id AS alert_id ,
    alert_id AS source_record_id ,
    case_id AS case_id ,
    client_id AS client_id ,
    MESSAGE AS MESSAGE ,
    start_date AS source_alert_start_date ,
    end_date AS source_alert_end_date ,
    void_ind AS void_ind ,
    system_alert_ind AS system_alert_ind ,
    ref_type AS ref_type ,
    ref_id AS ref_id ,
    lock_id AS lock_id ,
    record_count AS record_count ,
    alert_handler AS alert_handler ,
    record_date AS record_date ,
    record_time AS record_time ,
    record_name AS record_name ,
    modified_date AS modified_date ,    
    modified_name AS modified_name ,
    modified_time AS modified_time ,
    date_created AS date_created ,
    date_updated AS date_updated ,
    created_by AS created_by ,
    updated_by AS updated_by
FROM emrs_d_alert;    
  
GRANT SELECT ON EMRS_D_ALERT_SV TO &role_name;


begin
DBMS_ERRLOG.CREATE_ERROR_LOG ('EMRS_D_ALERT','ERRLOG_ALERT');
  end;
/


-- Create table
create table EMRS_S_ALERT_STG
(
   alert_id NUMBER(18,0),
    case_id NUMBER(18,0),
    client_id NUMBER(18,0),
    message VARCHAR2(4000),
    start_date DATE,
    end_date DATE,
    void_ind NUMBER(1,0),
    system_alert_ind NUMBER(1,0),
    ref_type VARCHAR2(32),
    ref_id NUMBER(18,0),
    lock_id NUMBER(1,0),
    record_count NUMBER(8,0),
    alert_handler VARCHAR2(64) )
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
grant select on EMRS_S_ALERT_STG to &role_name;

create index STG_IDX2_ALERTNUM on EMRS_S_ALERT_STG (ALERT_ID)
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


