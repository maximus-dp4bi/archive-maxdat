CREATE TABLE CC_S_ACD_AGENT_SUPERVISOR
(
S_AGENT_SUPERVISOR_ID NUMBER(19) NOT NULL,
AGENT_ID NUMBER(19),
AGENT_LOGIN_ID NVARCHAR2(255),
SUPERVISOR_ID NUMBER(19),
SUPERVISOR_LOGIN_ID NVARCHAR2(255),
EXTRACT_DT DATE,
LAST_UPDATE_DT DATE,
LAST_UPDATE_BY VARCHAR2(30 BYTE)
);


CREATE INDEX CC_S_ACD_AGENT_SUPERVISOR_IDX1 ON CC_S_ACD_AGENT_SUPERVISOR
  (
    S_AGENT_SUPERVISOR_ID
  );

CREATE INDEX CC_S_ACD_AGENT_SUPERVISOR_IDX2 ON CC_S_ACD_AGENT_SUPERVISOR
  (
   AGENT_ID
  );

CREATE INDEX CC_S_ACD_AGENT_SUPERVISOR_IDX3 ON CC_S_ACD_AGENT_SUPERVISOR
  (
   AGENT_LOGIN_ID
  );
  
CREATE INDEX CC_S_ACD_AGENT_SUPERVISOR_IDX4 ON CC_S_ACD_AGENT_SUPERVISOR
  (
   SUPERVISOR_ID
  );

CREATE INDEX CC_S_ACD_AGENT_SUPERVISOR_IDX5 ON CC_S_ACD_AGENT_SUPERVISOR
  (
   SUPERVISOR_LOGIN_ID
  );  

  
ALTER TABLE CC_S_ACD_AGENT_SUPERVISOR ADD CONSTRAINTS CC_S_ACD_AGENT_SUPERVISOR_PK PRIMARY KEY
  (
    S_AGENT_SUPERVISOR_ID
  );
  
ALTER TABLE CC_S_ACD_AGENT_SUPERVISOR ADD CONSTRAINTS CC_S_ACD_AGENT_SUPERVISOR_UN UNIQUE
  (
     AGENT_ID
    ,SUPERVISOR_ID
  );
 
ALTER TABLE CC_S_ACD_AGENT_SUPERVISOR ADD CONSTRAINTS CC_S_ACD_AGENT_SUPERVISOR_AGT_FK FOREIGN KEY
  (
    AGENT_ID
  )REFERENCES CC_S_AGENT (AGENT_ID) NOT DEFERRABLE;
  
ALTER TABLE CC_S_ACD_AGENT_SUPERVISOR ADD CONSTRAINTS CC_S_ACD_AGENT_SUPERVISOR_SUP_FK FOREIGN KEY
  (
    SUPERVISOR_ID
  )REFERENCES CC_S_AGENT (AGENT_ID) NOT DEFERRABLE;
  
  
CREATE SEQUENCE SEQ_CC_S_ACD_AGENT_SUPERVISOR START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20;

CREATE OR REPLACE TRIGGER "BIU_CC_S_ACD_AGENT_SUPERVISOR" 
  BEFORE INSERT OR UPDATE ON CC_S_ACD_AGENT_SUPERVISOR 
  FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.S_AGENT_SUPERVISOR_ID IS NULL THEN 
  SELECT SEQ_CC_S_ACD_AGENT_SUPERVISOR.NEXTVAL INTO :NEW.S_AGENT_SUPERVISOR_ID FROM DUAL;
END IF;
IF INSERTING THEN
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATE_BY := USER;
END;
/ 


CREATE TABLE CC_D_ACD_AGENT_SUPERVISOR
(
D_AGENT_SUPERVISOR_ID NUMBER(19) NOT NULL,
D_AGENT_ID	NUMBER(19),
AGENT_LOGIN_ID	NVARCHAR2(255),
D_SUPERVISOR_ID	NUMBER(19),
SUPERVISOR_LOGIN_ID NVARCHAR2(255),
VERSION NUMBER(10) NOT NULL,
EXTRACT_DT DATE,
LAST_UPDATE_DT DATE,
LAST_UPDATE_BY VARCHAR2(30 BYTE),
RECORD_EFF_DT  DATE,
RECORD_END_DT  DATE
);


CREATE INDEX CC_D_ACD_AGENT_SUPERVISOR_IDX1 ON CC_D_ACD_AGENT_SUPERVISOR
  (
    D_AGENT_SUPERVISOR_ID
  );
 
  
CREATE INDEX CC_D_ACD_AGENT_SUPERVISOR_IDX2 ON CC_D_ACD_AGENT_SUPERVISOR
  (
    D_AGENT_ID
  );

  
CREATE INDEX CC_D_ACD_AGENT_SUPERVISOR_IDX3 ON CC_D_ACD_AGENT_SUPERVISOR
  (
    D_SUPERVISOR_ID
  );
 
  
CREATE INDEX CC_D_ACD_AGENT_SUPERVISOR_IDX4 ON CC_D_ACD_AGENT_SUPERVISOR
  (
    AGENT_LOGIN_ID
  );

  
CREATE INDEX CC_D_ACD_AGENT_SUPERVISOR_IDX5 ON CC_D_ACD_AGENT_SUPERVISOR
  (
    SUPERVISOR_LOGIN_ID
  );
  
ALTER TABLE CC_D_ACD_AGENT_SUPERVISOR ADD CONSTRAINTS CC_D_ACD_AGENT_SUPERVISOR_PK PRIMARY KEY
  (
    D_AGENT_SUPERVISOR_ID
  );


ALTER TABLE CC_D_ACD_AGENT_SUPERVISOR ADD CONSTRAINTS CC_D_ACD_AGENT_SUPERVISOR_UN UNIQUE
  (
    D_AGENT_ID,
    D_SUPERVISOR_ID,
    RECORD_EFF_DT,
    RECORD_END_DT 
  );
  

ALTER TABLE CC_D_ACD_AGENT_SUPERVISOR ADD CONSTRAINTS CC_D_ACD_AGENT_SUPERVISOR_REC_CK CHECK
  (
    RECORD_EFF_DT <= RECORD_END_DT
  );
  
  
ALTER TABLE CC_D_ACD_AGENT_SUPERVISOR ADD CONSTRAINTS CC_D_ACD_AGENT_SUPERVISOR_AGT_FK FOREIGN KEY
  (
    D_AGENT_ID
  )REFERENCES CC_D_AGENT (D_AGENT_ID) NOT DEFERRABLE;
  
  
ALTER TABLE CC_D_ACD_AGENT_SUPERVISOR ADD CONSTRAINTS CC_D_ACD_AGENT_SUPERVISOR_SUP_FK FOREIGN KEY
  (
    D_SUPERVISOR_ID
  )REFERENCES CC_D_AGENT (D_AGENT_ID) NOT DEFERRABLE; 

CREATE SEQUENCE SEQ_CC_D_ACD_AGENT_SUPERVISOR START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20;

CREATE OR REPLACE TRIGGER "BIU_CC_D_ACD_AGENT_SUPERVISOR" 
  BEFORE INSERT OR UPDATE ON CC_D_ACD_AGENT_SUPERVISOR 
  FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.D_AGENT_SUPERVISOR_ID IS NULL THEN 
  SELECT SEQ_CC_D_ACD_AGENT_SUPERVISOR.NEXTVAL INTO :NEW.D_AGENT_SUPERVISOR_ID FROM DUAL;
END IF;
IF INSERTING THEN
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATE_BY := USER;
END;
/ 

