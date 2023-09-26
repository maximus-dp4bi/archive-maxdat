-- Create table
create table MAXDAT_CADR.S_CRS_IMR_PARTICIPANT
(
  SCIP_ID                     NUMBER(19) NOT NULL, 
  PARTICIPANT_ID              NUMBER(19) NOT NULL,
  IMR_ID                      NUMBER(19),
  PARTICIPANT_TYPE_CODE       NUMBER(10),
  DBA_NAME                    VARCHAR2(255),
  PARTICIPANT_CONTACT_FNAME   VARCHAR2(255),
  PARTICIPANT_CONTACT_LNAME   VARCHAR2(255),
  PARTICIPANT_CONTACT_MNAME   VARCHAR2(255),
  PARTICIPANT_CONTACT_SUFFIX  VARCHAR2(255),
  PARTICIPANT_CONTACT_PREFIX  VARCHAR2(255),  
  PARTICIPANT_1ST_ST_ADDR     VARCHAR2(255),
  PARTICIPANT_2ND_ST_ADDR     VARCHAR2(255),
  PARTICIPANT_CITY            VARCHAR2(255),
  PARTICIPANT_POSTAL_CODE     VARCHAR2(255),
  PARTICIPANT_ORGAN_NAME      VARCHAR2(255),
  PARTICIPANT_STATE_CODE      NUMBER(10),
  CREATE_DT                   DATE,
  CREATED_BY                  VARCHAR2(100),
  LAST_UPDATE_DT              DATE,
  LAST_UPDATED_BY             VARCHAR2(100)
)
tablespace MAXDAT_DATA
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
create index MAXDAT_CADR.PART_IMR_ID_INDX on MAXDAT_CADR.S_CRS_IMR_PARTICIPANT (IMR_ID)
  tablespace MAXDAT_INDX
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
create index MAXDAT_CADR.PARTICIPANT_ID_INDX on MAXDAT_CADR.S_CRS_IMR_PARTICIPANT (PARTICIPANT_ID)
  tablespace MAXDAT_INDX
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
alter table MAXDAT_CADR.S_CRS_IMR_PARTICIPANT
  add constraint S_CRS_SCIP_PK primary key (SCIP_ID)
  using index 
  tablespace MAXDAT_DATA
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
grant select, insert, update, delete on MAXDAT_CADR.S_CRS_IMR_PARTICIPANT to MAXDAT_OLTP_SIUD;
grant select on MAXDAT_CADR.S_CRS_IMR_PARTICIPANT to MAXDAT_READ_ONLY;

-- Create sequence 
create sequence SEQ_SCIP_ID minvalue 1
maxvalue 9999999999999999999
start with 1
increment by 1
cache 5;

CREATE OR REPLACE TRIGGER BIU_S_CRS_IMR_PARTICIPANT
    BEFORE INSERT OR UPDATE ON S_CRS_IMR_PARTICIPANT
    FOR EACH ROW 
    BEGIN
IF INSERTING AND :NEW.SCIP_ID IS NULL THEN 
          SELECT SEQ_SCIP_ID.NEXTVAL INTO :NEW.SCIP_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.CREATE_DT := SYSDATE;
          :NEW.CREATED_BY:= USER;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATED_BY := USER;
END;   
/    
