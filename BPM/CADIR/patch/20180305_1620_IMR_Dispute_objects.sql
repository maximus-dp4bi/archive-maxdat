ALTER TABLE S_CRS_IMR ADD FRST_MED_DOC_RCVD_DT DATE;
ALTER TABLE S_CRS_IMR ADD IMR_JCN_NUMBER  VARCHAR2(100);
ALTER TABLE S_CRS_IMR ADD IMR_EAMS_NUMBER VARCHAR2(100);
ALTER TABLE S_CRS_IMR ADD IMR_PRIMARY_DIAGNOSIS VARCHAR2(255);
ALTER TABLE S_CRS_IMR ADD IMR_TREATMENT_REQ VARCHAR2(255);

ALTER TABLE S_CRS_IMR_DECISIONS ADD DWC_SENT VARCHAR2(1) DEFAULT 'N';
ALTER TABLE S_CRS_IMR_DECISIONS ADD DWC_SENT_DATE DATE;

ALTER TABLE S_CRS_IMR_ISSUES_IN_DISPUTE ADD CHP_SELECTED          VARCHAR2(15);
ALTER TABLE S_CRS_IMR_ISSUES_IN_DISPUTE ADD CHP_2017_SELECTED     VARCHAR2(15);
ALTER TABLE S_CRS_IMR_ISSUES_IN_DISPUTE ADD CA_CHP_SELECTED       VARCHAR2(15);
ALTER TABLE S_CRS_IMR_ISSUES_IN_DISPUTE ADD CA_CHP_2017_SELECTED  VARCHAR2(15);
ALTER TABLE S_CRS_IMR_ISSUES_IN_DISPUTE ADD HAS_ODG_FLAG          NUMBER(1); 
ALTER TABLE S_CRS_IMR_ISSUES_IN_DISPUTE ADD HAS_2017_MTUS_FLAG    NUMBER(1);  
ALTER TABLE S_CRS_IMR_ISSUES_IN_DISPUTE ADD HAS_CA_2017_MTUS_FLAG NUMBER(1);

-- Create table
create table S_CRS_IMR_ISSUES_IN_DISPUTE_CLB
(
  SCIIDC_ID                   NUMBER(19) NOT NULL, 
  issue_in_dispute_id         NUMBER(19) NOT NULL,
  IMR_ID                      NUMBER(19),
  ISSUE_DESC                  VARCHAR2(2000),
  ODG_CITATION                VARCHAR2(2000),
  MFS_CITATION                VARCHAR2(2000),
  CA_NON_MTUS_CITATION        VARCHAR2(2000),
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
create index DISP_CLB_IMR_ID_INDX on S_CRS_IMR_ISSUES_IN_DISPUTE_CLB (IMR_ID)
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
create index DISP_CLB_ISSUE_ID_INDX on S_CRS_IMR_ISSUES_IN_DISPUTE_CLB (issue_in_dispute_id)
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
alter table S_CRS_IMR_ISSUES_IN_DISPUTE_CLB
  add constraint S_CRS_SCIIDC_PK primary key (SCIIDC_ID)
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
grant select, insert, update, delete on S_CRS_IMR_ISSUES_IN_DISPUTE_CLB to MAXDAT_OLTP_SIUD;
grant select on S_CRS_IMR_ISSUES_IN_DISPUTE_CLB to MAXDAT_READ_ONLY;

-- Create sequence 
create sequence SEQ_SCIIDC_ID minvalue 1
maxvalue 9999999999999999999
start with 1
increment by 1
cache 5;

CREATE OR REPLACE TRIGGER BIU_S_CRS_IMR_ISSUES_IN_DISPUTE_CLB
    BEFORE INSERT OR UPDATE ON S_CRS_IMR_ISSUES_IN_DISPUTE_CLB
    FOR EACH ROW 
    BEGIN
IF INSERTING AND :NEW.SCIIDC_ID IS NULL THEN 
          SELECT SEQ_SCIIDC_ID.NEXTVAL INTO :NEW.SCIIDC_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.CREATE_DT := SYSDATE;
          :NEW.CREATED_BY:= USER;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATED_BY := USER;
END;   
/    
