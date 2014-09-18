Drop Table CC_EVENT_STG;

CREATE TABLE CC_EVENT_STG (
MCES_ID   NUMBER PRIMARY KEY,
CREATE_TS DATE,
UPDATE_TS DATE,
EVENT_ID  NUMBER NOT NULL,
EVENT_CREATE_TS DATE NOT NULL,
REF_ID    NUMBER NOT NULL,
CASE_ID   NUMBER,
CALL_CAMPAIGN_TYPE VARCHAR2(32)
);

Drop Sequence Seq_mces;

CREATE SEQUENCE seq_mces START WITH 1 CACHE 20;

-- Create/Recreate indexes 
create index CC_EVNT_REF_INDX on CC_EVENT_STG (REF_ID)
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

create unique index EVENT_IDX on CC_EVENT_STG (EVENT_ID)
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

-- Grant/Revoke object privileges 

grant select, insert, update on CC_EVENT_STG to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on CC_EVENT_STG to MAXDAT_OLTP_SIUD;
grant select on CC_EVENT_STG to MAXDAT_READ_ONLY;


CREATE OR REPLACE TRIGGER MAXDAT."TRG_CC_EVENT_stg" BEFORE
       INSERT OR
       UPDATE ON CC_EVENT_STG FOR EACH ROW
BEGIN
  IF Inserting THEN
      SELECT seq_mces.Nextval INTO :NEW.MCES_ID FROM Dual;
      :NEW.CREATE_TS := to_date(SYSDATE);
  END IF;
  
  :NEW.UPDATE_TS := SYSDATE;
END;

/
