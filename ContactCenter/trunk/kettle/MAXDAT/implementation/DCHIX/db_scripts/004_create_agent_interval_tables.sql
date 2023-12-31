CREATE TABLE CC_S_ACD_AGENT_INTERVAL 
    ( 
     ACD_AGENT_INTERVAL_ID NUMBER (19)  NOT NULL , 
     INTERVAL_DATE DATE DEFAULT SYSDATE  NOT NULL , 
     CONTACT_QUEUE_ID NUMBER (19)  NOT NULL , 
     AGENT_ID NUMBER (19)  NOT NULL , 
     INTERVAL_ID NUMBER (19)  NOT NULL , 
     CONTACTS_OFFERED NUMBER (7) DEFAULT 0  NOT NULL , 
     CONTACTS_HANDLED NUMBER (7) DEFAULT 0  NOT NULL , 
     CONTACTS_ABANDONED NUMBER (7) DEFAULT 0  NOT NULL , 
     CONTACTS_TRANSFERRED NUMBER (7) DEFAULT 0  NOT NULL , 
     MIN_HANDLE_TIME NUMBER (11,2) DEFAULT 0  NOT NULL , 
     MAX_HANDLE_TIME NUMBER (11,2) DEFAULT 0  NOT NULL , 
     MEAN_HANDLE_TIME NUMBER (11,2) DEFAULT 0  NOT NULL , 
     MEDIAN_HANDLE_TIME NUMBER (11,2) DEFAULT 0  NOT NULL , 
     STDDEV_HANDLE_TIME NUMBER (11,2) DEFAULT 0  NOT NULL , 
     WAIT_TIME_TOTAL NUMBER (12,2) DEFAULT 0  NOT NULL , 
     TALK_TIME_TOTAL NUMBER (12,2) DEFAULT 0  NOT NULL , 
     AFTER_CALL_WORK_TIME_TOTAL NUMBER (12,2) DEFAULT 0  NOT NULL , 
     HOLD_TIME_TOTAL NUMBER (12,2) DEFAULT 0  NOT NULL , 
     EXTRACT_DT DATE DEFAULT SYSDATE  NOT NULL , 
     LAST_UPDATE_DT DATE DEFAULT SYSDATE  NOT NULL , 
     LAST_UPDATE_BY VARCHAR2 (30)  NOT NULL 
    ) 
        TABLESPACE MAXDAT_DATA 
        LOGGING 
;


CREATE INDEX CC_S_ACD_A_INT_CC_S_CNTCT_Q_FK ON CC_S_ACD_AGENT_INTERVAL 
    ( 
     CONTACT_QUEUE_ID ASC 
    ) 
    TABLESPACE MAXDAT_INDX 
    LOGGING 
;

CREATE INDEX CC_S_ACD_A_INT_CC_S_AGENT_FK ON CC_S_ACD_AGENT_INTERVAL 
    ( 
     AGENT_ID ASC 
    ) 
    TABLESPACE MAXDAT_INDX 
    LOGGING 
;

CREATE INDEX CC_S_ACD_A_INT_CC_S_INT_FK ON CC_S_ACD_AGENT_INTERVAL 
    ( 
     ACD_AGENT_INTERVAL_ID ASC 
    ) 
    TABLESPACE MAXDAT_INDX 
    LOGGING 
;

-- Fact table

CREATE TABLE CC_F_ACD_AGENT_INTERVAL
  (
    F_CC_ACD_AGENT_INTRVL_ID  NUMBER (19) NOT NULL ,
    D_DATE_ID                      NUMBER (19) NOT NULL ,
    D_PROJECT_ID                   NUMBER (19) NOT NULL ,
    D_PROGRAM_ID                   NUMBER (19) NOT NULL ,
    D_GEOGRAPHY_MASTER_ID          NUMBER (19) NOT NULL ,
    D_UNIT_OF_WORK_ID              NUMBER (19) NOT NULL ,
    D_CONTACT_QUEUE_ID             NUMBER (19) NOT NULL ,
    D_INTERVAL_ID                  NUMBER (19) NOT NULL ,
    D_AGENT_ID                     NUMBER (19) NOT NULL ,
    CONTACTS_OFFERED               NUMBER (7) DEFAULT 0 NOT NULL ,
    CONTACTS_HANDLED               NUMBER (7) DEFAULT 0 NOT NULL ,
    CONTACTS_ABANDONED             NUMBER (7) DEFAULT 0 NOT NULL ,
    CONTACTS_TRANSFERRED           NUMBER (7) DEFAULT NULL ,
    MIN_HANDLE_TIME                NUMBER (7,2) DEFAULT NULL ,
    MAX_HANDLE_TIME                NUMBER (7,2) DEFAULT NULL ,
    MEAN_HANDLE_TIME               NUMBER (7,2) DEFAULT NULL ,
    MEDIAN_HANDLE_TIME             NUMBER (7,2) DEFAULT NULL ,
    STDDEV_HANDLE_TIME             NUMBER (7,2) DEFAULT NULL ,
    WAIT_TIME_TOTAL                NUMBER (12,2) DEFAULT 0 NOT NULL ,
    TALK_TIME_TOTAL                NUMBER (12,2) DEFAULT 0 NOT NULL ,
    AFTER_CALL_WORK_TIME_TOTAL     NUMBER (12,2) DEFAULT 0 NOT NULL ,
    HOLD_TIME_TOTAL                NUMBER (12,2) DEFAULT 0 NOT NULL ,
    CREATE_DATE                    DATE DEFAULT SYSDATE NOT NULL ,
    LAST_UPDATE_DATE               DATE DEFAULT SYSDATE NOT NULL,
    QUEUE_NUMBER                   NUMBER (19),
    AGENT_LOGIN_ID                 NVARCHAR2 (100)
  )
  TABLESPACE MAXDAT_DATA LOGGING ENABLE ROW MOVEMENT ;
CREATE INDEX CC_F_ACD_AGENT_INTERVAL_IDX2 ON CC_F_ACD_AGENT_INTERVAL
  (
    D_DATE_ID ASC
  )
  TABLESPACE MAXDAT_INDX LOGGING ;
CREATE INDEX CC_F_ACD_AGENT_INTERVAL_IDX3 ON CC_F_ACD_AGENT_INTERVAL
  (
    D_PROJECT_ID ASC
  )
  TABLESPACE MAXDAT_INDX LOGGING ;
CREATE INDEX CC_F_ACD_AGENT_INTERVAL_IDX4 ON CC_F_ACD_AGENT_INTERVAL
  (
    D_PROGRAM_ID ASC
  )
  TABLESPACE MAXDAT_INDX LOGGING ;
CREATE INDEX CC_F_ACD_AGENT_INTERVAL_IDX5 ON CC_F_ACD_AGENT_INTERVAL
  (
    D_GEOGRAPHY_MASTER_ID ASC
  )
  TABLESPACE MAXDAT_INDX LOGGING ;
CREATE INDEX CC_F_ACD_AGENT_INTERVAL_IDX6 ON CC_F_ACD_AGENT_INTERVAL
  (
    D_UNIT_OF_WORK_ID ASC
  )
  TABLESPACE MAXDAT_INDX LOGGING ;
CREATE INDEX CC_F_ACD_AGENT_INTERVAL_IDX7 ON CC_F_ACD_AGENT_INTERVAL
  (
    D_CONTACT_QUEUE_ID ASC
  )
  TABLESPACE MAXDAT_INDX LOGGING ;
CREATE INDEX CC_F_ACD_AGENT_INTERVAL_IDX8 ON CC_F_ACD_AGENT_INTERVAL
  (
    D_INTERVAL_ID ASC
  )
  TABLESPACE MAXDAT_INDX LOGGING ;
  
CREATE INDEX CC_F_ACD_AGENT_INTERVAL_IDX9 ON CC_F_ACD_AGENT_INTERVAL
  (
    D_AGENT_ID ASC
  )
  TABLESPACE MAXDAT_INDX LOGGING ;  

ALTER TABLE CC_F_ACD_AGENT_INTERVAL ADD CONSTRAINT CC_F_ACD_AGENT_INTERVAL_PK PRIMARY KEY
(
  F_CC_ACD_AGENT_INTRVL_ID
)
;
ALTER TABLE CC_F_ACD_AGENT_INTERVAL ADD CONSTRAINT CC_F_ACD_AGENT_INTERVAL__UN UNIQUE
(
  D_DATE_ID , D_PROJECT_ID , D_PROGRAM_ID , D_GEOGRAPHY_MASTER_ID , D_UNIT_OF_WORK_ID , D_INTERVAL_ID , D_CONTACT_QUEUE_ID , D_AGENT_ID)
 
;



ALTER TABLE CC_S_ACD_AGENT_INTERVAL 
    ADD CONSTRAINT CC_S_ACD_AGENT_INTERVAL_PK PRIMARY KEY ( ACD_AGENT_INTERVAL_ID ) ;


ALTER TABLE CC_S_ACD_AGENT_INTERVAL 
    ADD CONSTRAINT CC_S_ACD_A_INTERVAL__UN UNIQUE ( INTERVAL_DATE , CONTACT_QUEUE_ID , INTERVAL_ID , AGENT_ID ) ;
    
    

ALTER TABLE CC_S_ACD_AGENT_INTERVAL 
    ADD CONSTRAINT CC_S_ACD_A_INT_CC_S_CNTCTQ_FK FOREIGN KEY 
    ( 
     CONTACT_QUEUE_ID
    ) 
    REFERENCES CC_S_CONTACT_QUEUE 
    ( 
     CONTACT_QUEUE_ID
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE CC_S_ACD_AGENT_INTERVAL 
    ADD CONSTRAINT CC_S_ACD_A_INT_CC_S_INT_FK FOREIGN KEY 
    ( 
     INTERVAL_ID
    ) 
    REFERENCES CC_S_INTERVAL 
    ( 
     INTERVAL_ID
    ) 
    NOT DEFERRABLE 
;

ALTER TABLE CC_S_ACD_AGENT_INTERVAL 
    ADD CONSTRAINT CC_S_ACD_A_INT_CC_S_AGENT_FK FOREIGN KEY 
    ( 
     AGENT_ID
    ) 
    REFERENCES CC_S_AGENT
    ( 
     AGENT_ID
    ) 
    NOT DEFERRABLE 
;



ALTER TABLE CC_F_ACD_AGENT_INTERVAL ADD CONSTRAINT F_ACD_A_INTRVL_D_CNTCT_Q_FK FOREIGN KEY ( D_CONTACT_QUEUE_ID ) REFERENCES CC_D_CONTACT_QUEUE ( D_CONTACT_QUEUE_ID ) NOT DEFERRABLE ;

ALTER TABLE CC_F_ACD_AGENT_INTERVAL ADD CONSTRAINT F_ACD_A_INTRVL_D_DATES_FK FOREIGN KEY ( D_DATE_ID ) REFERENCES CC_D_DATES ( D_DATE_ID ) NOT DEFERRABLE ;

ALTER TABLE CC_F_ACD_AGENT_INTERVAL ADD CONSTRAINT F_ACD_A_INTRVL_D_GEO_FK FOREIGN KEY ( D_GEOGRAPHY_MASTER_ID ) REFERENCES CC_D_GEOGRAPHY_MASTER ( GEOGRAPHY_MASTER_ID ) NOT DEFERRABLE ;

ALTER TABLE CC_F_ACD_AGENT_INTERVAL ADD CONSTRAINT F_ACD_A_INTRVL_D_INT_FK FOREIGN KEY ( D_INTERVAL_ID ) REFERENCES CC_D_INTERVAL ( D_INTERVAL_ID ) NOT DEFERRABLE ;

ALTER TABLE CC_F_ACD_AGENT_INTERVAL ADD CONSTRAINT F_ACD_A_INTRVL_D_PRG_FK FOREIGN KEY ( D_PROGRAM_ID ) REFERENCES CC_D_PROGRAM ( PROGRAM_ID ) NOT DEFERRABLE ;

ALTER TABLE CC_F_ACD_AGENT_INTERVAL ADD CONSTRAINT F_ACD_A_INTRVL_D_PRJ_FK FOREIGN KEY ( D_PROJECT_ID ) REFERENCES CC_D_PROJECT ( PROJECT_ID ) NOT DEFERRABLE ;

ALTER TABLE CC_F_ACD_AGENT_INTERVAL ADD CONSTRAINT F_ACD_A_INTRVL_D_UOW_FK FOREIGN KEY ( D_UNIT_OF_WORK_ID ) REFERENCES CC_D_UNIT_OF_WORK ( UOW_ID ) NOT DEFERRABLE ;

ALTER TABLE CC_F_ACD_AGENT_INTERVAL ADD CONSTRAINT F_ACD_A_INTRVL_D_AGENT_FK FOREIGN KEY ( D_AGENT_ID ) REFERENCES CC_D_AGENT ( D_AGENT_ID ) NOT DEFERRABLE ;


CREATE SEQUENCE SEQ_CC_S_ACD_A_INTERVAL 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 9999999999999999999 
    MINVALUE 1 
    CACHE 20 
;

CREATE SEQUENCE SEQ_CC_F_ACD_A_INTERVAL START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE OR REPLACE TRIGGER BIU_CC_S_ACD_A_INTERVAL 
    BEFORE INSERT OR UPDATE ON CC_S_ACD_AGENT_INTERVAL 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.ACD_AGENT_INTERVAL_ID IS NULL THEN 
          SELECT SEQ_CC_S_ACD_A_INTERVAL.NEXTVAL INTO :NEW.ACD_AGENT_INTERVAL_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
IF :NEW.LAST_UPDATE_BY IS NULL THEN 
          :NEW.LAST_UPDATE_BY := USER;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
END; 
/    

CREATE OR REPLACE VIEW CC_F_ACD_AGENT_INTERVAL_SV  AS
SELECT CC_F_ACD_AGENT_INTERVAL.* FROM CC_F_ACD_AGENT_INTERVAL ;

CREATE OR REPLACE TRIGGER BI_CC_F_ACD_A_INTERVAL 
    BEFORE INSERT ON CC_F_ACD_AGENT_INTERVAL 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.F_CC_ACD_AGENT_INTRVL_ID IS NULL THEN 
          SELECT SEQ_CC_F_ACD_A_INTERVAL.NEXTVAL INTO :NEW.F_CC_ACD_AGENT_INTRVL_ID FROM DUAL;      
END IF;
END;  
/






























