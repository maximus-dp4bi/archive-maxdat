CREATE TABLE CC_S_ACD_QUEUE_INTERVAL 
    ( 
     ACD_QUEUE_INTERVAL_ID NUMBER (19)  NOT NULL , 
     INTERVAL_DATE DATE DEFAULT SYSDATE  NOT NULL , 
     CONTACT_QUEUE_ID NUMBER (19)  NOT NULL , 
     INTERVAL_ID NUMBER (19)  NOT NULL , 
     CONTACTS_RECEIVED_FROM_IVR NUMBER (7) DEFAULT 0  NOT NULL , 
     CONTACTS_OFFERED NUMBER (7) DEFAULT 0  NOT NULL ,
     RAW_CONTACTS_OFFERED NUMBER (7) DEFAULT 0 NOT NULL,
     CONTACTS_HANDLED NUMBER (7) DEFAULT 0  NOT NULL , 
     CONTACTS_ABANDONED NUMBER (7) DEFAULT 0  NOT NULL , 
     MIN_HANDLE_TIME NUMBER (11,2) DEFAULT NULL , 
     MAX_HANDLE_TIME NUMBER (11,2) DEFAULT NULL , 
     MEAN_HANDLE_TIME NUMBER (11,2) DEFAULT NULL , 
     MEDIAN_HANDLE_TIME NUMBER (11,2) DEFAULT NULL , 
     STDDEV_HANDLE_TIME NUMBER (11,2) DEFAULT NULL , 
     MIN_SPEED_TO_HANDLE NUMBER (11,2) DEFAULT 0 NULL , 
     MAX_SPEED_TO_HANDLE NUMBER (11,2) DEFAULT NULL , 
     MEAN_SPEED_TO_HANDLE NUMBER (11,2) DEFAULT NULL , 
     MEDIAN_SPEED_TO_HANDLE NUMBER (11,2) DEFAULT NULL , 
     STDDEV_SPEED_TO_HANDLE NUMBER (11,2) DEFAULT NULL , 
     MIN_SPEED_OF_ANSWER NUMBER (11,2) DEFAULT NULL , 
     MAX_SPEED_OF_ANSWER NUMBER (11,2) DEFAULT NULL , 
     MEAN_SPEED_OF_ANSWER NUMBER (11,2) DEFAULT NULL , 
     MEDIAN_SPEED_OF_ANSWER NUMBER (11,2) DEFAULT  NULL , 
     STDDEV_SPEED_OF_ANSWER NUMBER (11,2) DEFAULT  NULL , 
     SPEED_OF_ANSWER_PERIOD_1 NUMBER (7) DEFAULT 0  NOT NULL , 
     SPEED_OF_ANSWER_PERIOD_2 NUMBER (7) DEFAULT 0  NOT NULL , 
     SPEED_OF_ANSWER_PERIOD_3 NUMBER (7) DEFAULT 0  NOT NULL , 
     SPEED_OF_ANSWER_PERIOD_4 NUMBER (7) DEFAULT 0  NOT NULL , 
     SPEED_OF_ANSWER_PERIOD_5 NUMBER (7) DEFAULT 0  NOT NULL , 
     SPEED_OF_ANSWER_PERIOD_6 NUMBER (7) DEFAULT 0  NOT NULL , 
     SPEED_OF_ANSWER_PERIOD_7 NUMBER (7) DEFAULT 0  NOT NULL , 
     SPEED_OF_ANSWER_PERIOD_8 NUMBER (7) DEFAULT 0  NOT NULL , 
     SPEED_OF_ANSWER_PERIOD_9 NUMBER (7) DEFAULT 0  NOT NULL , 
     SPEED_OF_ANSWER_PERIOD_10 NUMBER (7) DEFAULT 0  NOT NULL , 
     CALLS_ABANDONED_PERIOD_1 NUMBER (7) DEFAULT 0  NOT NULL , 
     CALLS_ABANDONED_PERIOD_2 NUMBER (7) DEFAULT 0  NOT NULL , 
     CALLS_ABANDONED_PERIOD_3 NUMBER (7) DEFAULT 0  NOT NULL , 
     CALLS_ABANDONED_PERIOD_4 NUMBER (7) DEFAULT 0  NOT NULL , 
     CALLS_ABANDONED_PERIOD_5 NUMBER (7) DEFAULT 0  NOT NULL , 
     CALLS_ABANDONED_PERIOD_6 NUMBER (7) DEFAULT 0  NOT NULL , 
     CALLS_ABANDONED_PERIOD_7 NUMBER (7) DEFAULT 0  NOT NULL , 
     CALLS_ABANDONED_PERIOD_8 NUMBER (7) DEFAULT 0  NOT NULL , 
     CALLS_ABANDONED_PERIOD_9 NUMBER (7) DEFAULT 0  NOT NULL , 
     CALLS_ABANDONED_PERIOD_10 NUMBER (7) DEFAULT 0  NOT NULL , 
     CONTACTS_TRANSFERRED NUMBER (7) DEFAULT NULL , 
     OUTFLOW_CONTACTS NUMBER (7) DEFAULT 0  NOT NULL , 
     ANSWER_WAIT_TIME_TOTAL NUMBER (12,2) DEFAULT 0  NOT NULL , 
     ABANDON_TIME_TOTAL NUMBER (12,2) DEFAULT 0  NOT NULL , 
     TALK_TIME_TOTAL NUMBER (12,2) DEFAULT 0  NOT NULL , 
     AFTER_CALL_WORK_TIME_TOTAL NUMBER (12,2) DEFAULT 0  NOT NULL , 
     SERVICE_LEVEL_ANSWERED_PERCENT NUMBER (5,2) DEFAULT 0  NOT NULL , 
     SERVICE_LEVEL_ANSWERED_COUNT NUMBER (7) DEFAULT 0  NOT NULL , 
     SERVICE_LEVEL_ABANDONED NUMBER (5,2) DEFAULT 0 , 
     CALLS_ON_HOLD NUMBER (7) DEFAULT NULL , 
     HOLD_TIME_TOTAL NUMBER (12,2) DEFAULT 0  NOT NULL , 
     SHORT_ABANDONS NUMBER (7) DEFAULT NULL, 
     CALL_TYPE VARCHAR2 (200) , 
     EXTRACT_DT DATE DEFAULT SYSDATE  NOT NULL , 
     LAST_UPDATE_DT DATE DEFAULT SYSDATE  NOT NULL , 
     LAST_UPDATE_BY VARCHAR2 (30)  NOT NULL ,
     MAX_ABANDON_TIME NUMBER DEFAULT NULL,
     ABANDON_THRESHOLD NUMBER(7) DEFAULT NULL, 
     SHORT_CALLS NUMBER(7) DEFAULT NULL,
     CALLS_RONA NUMBER(7,0),
     MAX_CALLS_QUEUED NUMBER (7) DEFAULT NULL,
     CALLS_ANSWERED NUMBER(7,0),
     HANDLE_TIME NUMBER,
     INCOMPLETE_CALLS NUMBER(7) DEFAULT NULL
     ) 
        TABLESPACE MAXDAT_DATA 
        LOGGING 
;


CREATE INDEX CC_S_ACD_Q_INT_CC_S_CNTCT_Q_FK ON CC_S_ACD_QUEUE_INTERVAL 
    ( 
     CONTACT_QUEUE_ID ASC 
    ) 
    TABLESPACE MAXDAT_INDX 
    LOGGING 
;
CREATE INDEX CC_S_ACD_Q_INT_CC_S_INT_FK ON CC_S_ACD_QUEUE_INTERVAL 
    ( 
     ACD_QUEUE_INTERVAL_ID ASC 
    ) 
    TABLESPACE MAXDAT_INDX 
    LOGGING 
;



-- Fact table

CREATE TABLE CC_F_ACD_QUEUE_INTERVAL
  (
    F_CC_ACD_QUEUE_INTRVL_ID  NUMBER (19) NOT NULL ,
    D_DATE_ID                      NUMBER (19) NOT NULL ,
    D_CONTACT_QUEUE_ID             NUMBER (19) NOT NULL ,
    D_INTERVAL_ID                  NUMBER (19) NOT NULL ,
    CONTACTS_RECEIVED_FROM_IVR     NUMBER (7) DEFAULT 0 NOT NULL ,
    CONTACTS_OFFERED               NUMBER (7) DEFAULT 0 NOT NULL ,
    CONTACTS_HANDLED               NUMBER (7) DEFAULT 0 NOT NULL ,
    CONTACTS_ABANDONED             NUMBER (7) DEFAULT 0 NOT NULL ,
    MIN_HANDLE_TIME                NUMBER (11,2) DEFAULT NULL ,
    MAX_HANDLE_TIME                NUMBER (11,2) DEFAULT NULL ,
    MEAN_HANDLE_TIME               NUMBER (11,2) DEFAULT NULL ,
    MEDIAN_HANDLE_TIME             NUMBER (11,2) DEFAULT NULL ,
    STDDEV_HANDLE_TIME             NUMBER (11,2) DEFAULT NULL ,
    MIN_SPEED_TO_HANDLE            NUMBER (11,2) DEFAULT NULL ,
    MAX_SPEED_TO_HANDLE            NUMBER (11,2) DEFAULT NULL ,
    MEAN_SPEED_TO_HANDLE           NUMBER (11,2) DEFAULT NULL ,
    MEDIAN_SPEED_TO_HANDLE         NUMBER (11,2) DEFAULT NULL ,
    STDDEV_SPEED_TO_HANDLE         NUMBER (11,2) DEFAULT NULL ,
    MIN_SPEED_OF_ANSWER            NUMBER (11,2) DEFAULT NULL ,
    MAX_SPEED_OF_ANSWER            NUMBER (11,2) DEFAULT NULL ,
    MEAN_SPEED_OF_ANSWER           NUMBER (11,2) DEFAULT NULL ,
    MEDIAN_SPEED_OF_ANSWER         NUMBER (11,2) DEFAULT NULL ,
    STDDEV_SPEED_OF_ANSWER         NUMBER (11,2) DEFAULT NULL ,
    SPEED_OF_ANSWER_PERIOD_1       NUMBER (7) DEFAULT 0 NOT NULL ,
    SPEED_OF_ANSWER_PERIOD_2       NUMBER (7) DEFAULT 0 NOT NULL ,
    SPEED_OF_ANSWER_PERIOD_3       NUMBER (7) DEFAULT 0 NOT NULL ,
    SPEED_OF_ANSWER_PERIOD_4       NUMBER (7) DEFAULT 0 NOT NULL ,
    SPEED_OF_ANSWER_PERIOD_5       NUMBER (7) DEFAULT 0 NOT NULL ,
    SPEED_OF_ANSWER_PERIOD_6       NUMBER (7) DEFAULT 0 NOT NULL ,
    SPEED_OF_ANSWER_PERIOD_7       NUMBER (7) DEFAULT 0 NOT NULL ,
    SPEED_OF_ANSWER_PERIOD_8       NUMBER (7) DEFAULT 0 NOT NULL ,
    SPEED_OF_ANSWER_PERIOD_9       NUMBER (7) DEFAULT 0 NOT NULL ,
    SPEED_OF_ANSWER_PERIOD_10      NUMBER (7) DEFAULT 0 NOT NULL ,
    CALLS_ABANDONED_PERIOD_1       NUMBER (7) DEFAULT 0 NOT NULL ,
    CALLS_ABANDONED_PERIOD_2       NUMBER (7) DEFAULT 0 NOT NULL ,
    CALLS_ABANDONED_PERIOD_3       NUMBER (7) DEFAULT 0 NOT NULL ,
    CALLS_ABANDONED_PERIOD_4       NUMBER (7) DEFAULT 0 NOT NULL ,
    CALLS_ABANDONED_PERIOD_5       NUMBER (7) DEFAULT 0 NOT NULL ,
    CALLS_ABANDONED_PERIOD_6       NUMBER (7) DEFAULT 0 NOT NULL ,
    CALLS_ABANDONED_PERIOD_7       NUMBER (7) DEFAULT 0 NOT NULL ,
    CALLS_ABANDONED_PERIOD_8       NUMBER (7) DEFAULT 0 NOT NULL ,
    CALLS_ABANDONED_PERIOD_9       NUMBER (7) DEFAULT 0 NOT NULL ,
    CALLS_ABANDONED_PERIOD_10      NUMBER (7) DEFAULT 0 NOT NULL ,
    LABOR_MINUTES_TOTAL            NUMBER (10,2) DEFAULT 0 NOT NULL ,
    LABOR_MINUTES_AVAILABLE        NUMBER (9,2) DEFAULT 0 NOT NULL ,
    LABOR_MINUTES_WAITING          NUMBER (10,2) DEFAULT 0 NOT NULL ,
    HEADCOUNT_TOTAL                NUMBER (7,2) DEFAULT 0 NOT NULL ,
    HEADCOUNT_AVAILABLE            NUMBER (7,2) DEFAULT 0 NOT NULL ,
    HEADCOUNT_UNAVAILABLE          NUMBER (7,2) DEFAULT 0 NOT NULL ,
    CONTACT_INVENTORY              NUMBER (7) DEFAULT 0 NOT NULL ,
    CONTACT_INVENTORY_JEOPARDY     NUMBER (7) DEFAULT 0 NOT NULL ,
    MIN_CONTACT_INVENTORY_AGE      NUMBER (5,2) DEFAULT 0 NOT NULL ,
    MAX_CONTACT_INVENTORY_AGE      NUMBER (5,2) DEFAULT 0 NOT NULL ,
    MEAN_CONTACT_INVENTORY_AGE     NUMBER (5,2) DEFAULT 0 NOT NULL ,
    MEDIAN_CONTACT_INVENTORY_AGE   NUMBER (5,2) DEFAULT 0 NOT NULL ,
    STDDEV_CONTACT_INVENTORY_AGE   NUMBER (5,2) DEFAULT 0 NOT NULL ,
    CONTACTS_TRANSFERRED           NUMBER (7) DEFAULT NULL ,
    OUTFLOW_CONTACTS               NUMBER (7) DEFAULT 0 NOT NULL ,
    ANSWER_WAIT_TIME_TOTAL         NUMBER (12,2) DEFAULT 0 NOT NULL ,
    ABANDON_TIME_TOTAL             NUMBER (12,2) DEFAULT 0 NOT NULL ,
    TALK_TIME_TOTAL                NUMBER (12,2) DEFAULT 0 NOT NULL ,
    AFTER_CALL_WORK_TIME_TOTAL     NUMBER (12,2) DEFAULT 0 NOT NULL ,
    SERVICE_LEVEL_ANSWERED_PERCENT NUMBER (5,2) DEFAULT 0 NOT NULL ,
    SERVICE_LEVEL_ANSWERED_COUNT   NUMBER (7) DEFAULT 0 NOT NULL ,
    SERVICE_LEVEL_ABANDONED        NUMBER (5,2) DEFAULT 0 ,
    CALLS_ON_HOLD                  NUMBER (7) DEFAULT NULL ,
    HOLD_TIME_TOTAL                NUMBER (12,2) DEFAULT 0 NOT NULL ,
    SHORT_ABANDONS                 NUMBER (7) DEFAULT NULL ,
    SHORT_CALLS                    NUMBER (7) DEFAULT NULL,
    CONTACTS_BLOCKED               NUMBER (7) DEFAULT NULL ,
    RETURN_RING                    NUMBER (7) DEFAULT 0 NOT NULL ,
    INCOMPLETE_CALLS               NUMBER (7) DEFAULT NULL ,
    CREATE_DATE                    DATE DEFAULT SYSDATE NOT NULL ,
    LAST_UPDATE_DATE               DATE DEFAULT SYSDATE NOT NULL,
    MAX_ABANDON_TIME               NUMBER  DEFAULT  NULL ,
    CALLS_RONA 			   NUMBER(7,0),
    QUEUE_NUMBER                   NUMBER (19),
    ABANDON_THRESHOLD 		   NUMBER(7) DEFAULT NULL,
    MAX_CALLS_QUEUED NUMBER (7) DEFAULT NULL,
    CALLS_ANSWERED NUMBER(7,0),
    HANDLE_TIME NUMBER, 
    ROUTER_QUEUE_WAIT_TIME NUMBER, 
    RAW_CONTACTS_OFFERED NUMBER
  )
  TABLESPACE MAXDAT_DATA LOGGING ENABLE ROW MOVEMENT ;
CREATE INDEX CC_F_ACD_Q_INTERVAL_IDX2 ON CC_F_ACD_QUEUE_INTERVAL
  (
    D_DATE_ID ASC
  )
  TABLESPACE MAXDAT_INDX LOGGING ;

CREATE INDEX CC_F_ACD_Q_INTERVAL_IDX7 ON CC_F_ACD_QUEUE_INTERVAL
  (
    D_CONTACT_QUEUE_ID ASC
  )
  TABLESPACE MAXDAT_INDX LOGGING ;
CREATE INDEX CC_F_ACD_Q_INTERVAL_IDX8 ON CC_F_ACD_QUEUE_INTERVAL
  (
    D_INTERVAL_ID ASC
  )
  TABLESPACE MAXDAT_INDX LOGGING ;

ALTER TABLE CC_F_ACD_QUEUE_INTERVAL ADD CONSTRAINT CC_F_ACD_QUEUE_INTERVAL_PK PRIMARY KEY
(
  F_CC_ACD_QUEUE_INTRVL_ID
)
;

ALTER TABLE CC_S_ACD_QUEUE_INTERVAL 
    ADD CONSTRAINT CC_S_ACD_Q_INTERVAL_PK PRIMARY KEY ( ACD_QUEUE_INTERVAL_ID ) ;


ALTER TABLE CC_S_ACD_QUEUE_INTERVAL 
    ADD CONSTRAINT CC_S_ACD_Q_INTERVAL__UN UNIQUE ( INTERVAL_DATE , CONTACT_QUEUE_ID , INTERVAL_ID  ) ;
    
    
ALTER TABLE CC_S_ACD_QUEUE_INTERVAL 
    ADD CONSTRAINT CC_S_ACD_Q_INT_CC_S_CNTCTQ_FK FOREIGN KEY 
    ( 
     CONTACT_QUEUE_ID
    ) 
    REFERENCES CC_S_CONTACT_QUEUE 
    ( 
     CONTACT_QUEUE_ID
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE CC_S_ACD_QUEUE_INTERVAL 
    ADD CONSTRAINT CC_S_ACD_Q_INT_CC_S_INT_FK FOREIGN KEY 
    ( 
     INTERVAL_ID
    ) 
    REFERENCES CC_S_INTERVAL 
    ( 
     INTERVAL_ID
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE CC_F_ACD_QUEUE_INTERVAL ADD CONSTRAINT F_ACD_Q_INTRVL_D_CNTCT_Q_FK FOREIGN KEY ( D_CONTACT_QUEUE_ID ) REFERENCES CC_D_CONTACT_QUEUE ( D_CONTACT_QUEUE_ID ) NOT DEFERRABLE ;

ALTER TABLE CC_F_ACD_QUEUE_INTERVAL ADD CONSTRAINT F_ACD_Q_INTRVL_D_DATES_FK FOREIGN KEY ( D_DATE_ID ) REFERENCES CC_D_DATES ( D_DATE_ID ) NOT DEFERRABLE ;

ALTER TABLE CC_F_ACD_QUEUE_INTERVAL ADD CONSTRAINT F_ACD_Q_INTRVL_D_INT_FK FOREIGN KEY ( D_INTERVAL_ID ) REFERENCES CC_D_INTERVAL ( D_INTERVAL_ID ) NOT DEFERRABLE ;

CREATE SEQUENCE SEQ_CC_S_ACD_Q_INTERVAL 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 9999999999999999999 
    MINVALUE 1 
    CACHE 20 
;

CREATE SEQUENCE SEQ_CC_F_ACD_Q_INTERVAL START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE OR REPLACE TRIGGER BIU_CC_S_ACD_Q_INTERVAL 
    BEFORE INSERT OR UPDATE ON CC_S_ACD_QUEUE_INTERVAL 
    FOR EACH ROW 
BEGIN 
IF INSERTING AND :NEW.ACD_QUEUE_INTERVAL_ID IS NULL THEN 
          SELECT SEQ_CC_S_ACD_Q_INTERVAL.NEXTVAL INTO :NEW.ACD_QUEUE_INTERVAL_ID FROM DUAL;
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

CREATE OR REPLACE TRIGGER BI_CC_F_ACD_Q_INTERVAL 
    BEFORE INSERT ON CC_F_ACD_QUEUE_INTERVAL 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.F_CC_ACD_QUEUE_INTRVL_ID IS NULL THEN 
          SELECT SEQ_CC_F_ACD_Q_INTERVAL.NEXTVAL INTO :NEW.F_CC_ACD_QUEUE_INTRVL_ID FROM DUAL;      
END IF;
END;  
/

CREATE OR REPLACE VIEW CC_F_ACD_QUEUE_INTERVAL_SV  AS 
  SELECT CC_F_ACD_QUEUE_INTERVAL.F_CC_ACD_QUEUE_INTRVL_ID,
    CC_F_ACD_QUEUE_INTERVAL.D_DATE_ID,
    CC_D_CONTACT_QUEUE.D_PROJECT_ID,
    CC_D_CONTACT_QUEUE.D_PROGRAM_ID,
    CC_D_CONTACT_QUEUE.D_GEOGRAPHY_MASTER_ID,
    CC_D_CONTACT_QUEUE.D_UNIT_OF_WORK_ID,
    CC_F_ACD_QUEUE_INTERVAL.D_CONTACT_QUEUE_ID,
    CC_F_ACD_QUEUE_INTERVAL.D_INTERVAL_ID,
    CC_F_ACD_QUEUE_INTERVAL.CONTACTS_RECEIVED_FROM_IVR,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ANSWERED,
    CC_F_ACD_QUEUE_INTERVAL.CONTACTS_OFFERED,
    CC_F_ACD_QUEUE_INTERVAL.CONTACTS_HANDLED,
    CC_F_ACD_QUEUE_INTERVAL.CONTACTS_ABANDONED,
    CC_F_ACD_QUEUE_INTERVAL.MIN_HANDLE_TIME,
    CC_F_ACD_QUEUE_INTERVAL.MAX_HANDLE_TIME,
    CC_F_ACD_QUEUE_INTERVAL.MEAN_HANDLE_TIME,
    CC_F_ACD_QUEUE_INTERVAL.MEDIAN_HANDLE_TIME,
    CC_F_ACD_QUEUE_INTERVAL.STDDEV_HANDLE_TIME,
    CC_F_ACD_QUEUE_INTERVAL.MIN_SPEED_TO_HANDLE,
    CC_F_ACD_QUEUE_INTERVAL.MAX_SPEED_TO_HANDLE,
    CC_F_ACD_QUEUE_INTERVAL.MEAN_SPEED_TO_HANDLE,
    CC_F_ACD_QUEUE_INTERVAL.MEDIAN_SPEED_TO_HANDLE,
    CC_F_ACD_QUEUE_INTERVAL.STDDEV_SPEED_TO_HANDLE,
    CC_F_ACD_QUEUE_INTERVAL.MIN_SPEED_OF_ANSWER,
    CC_F_ACD_QUEUE_INTERVAL.MAX_SPEED_OF_ANSWER,
    CC_F_ACD_QUEUE_INTERVAL.MEAN_SPEED_OF_ANSWER,
    CC_F_ACD_QUEUE_INTERVAL.MEDIAN_SPEED_OF_ANSWER,
    CC_F_ACD_QUEUE_INTERVAL.STDDEV_SPEED_OF_ANSWER,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_1,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_2,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_3,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_4,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_5,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_6,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_7,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_8,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_9,
    CC_F_ACD_QUEUE_INTERVAL.SPEED_OF_ANSWER_PERIOD_10,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_1,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_2,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_3,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_4,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_5,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_6,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_7,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_8,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_9,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ABANDONED_PERIOD_10,
    CC_F_ACD_QUEUE_INTERVAL.LABOR_MINUTES_TOTAL,
    CC_F_ACD_QUEUE_INTERVAL.LABOR_MINUTES_AVAILABLE,
    CC_F_ACD_QUEUE_INTERVAL.LABOR_MINUTES_WAITING,
    CC_F_ACD_QUEUE_INTERVAL.HEADCOUNT_TOTAL,
    CC_F_ACD_QUEUE_INTERVAL.HEADCOUNT_AVAILABLE,
    CC_F_ACD_QUEUE_INTERVAL.HEADCOUNT_UNAVAILABLE,
    CC_F_ACD_QUEUE_INTERVAL.CONTACT_INVENTORY,
    CC_F_ACD_QUEUE_INTERVAL.CONTACT_INVENTORY_JEOPARDY,
    CC_F_ACD_QUEUE_INTERVAL.MIN_CONTACT_INVENTORY_AGE,
    CC_F_ACD_QUEUE_INTERVAL.MAX_CONTACT_INVENTORY_AGE,
    CC_F_ACD_QUEUE_INTERVAL.MEAN_CONTACT_INVENTORY_AGE,
    CC_F_ACD_QUEUE_INTERVAL.MEDIAN_CONTACT_INVENTORY_AGE,
    CC_F_ACD_QUEUE_INTERVAL.STDDEV_CONTACT_INVENTORY_AGE,
    CC_F_ACD_QUEUE_INTERVAL.CONTACTS_TRANSFERRED,
    CC_F_ACD_QUEUE_INTERVAL.OUTFLOW_CONTACTS,
    CC_F_ACD_QUEUE_INTERVAL.ANSWER_WAIT_TIME_TOTAL,
    CC_F_ACD_QUEUE_INTERVAL.ABANDON_TIME_TOTAL,
    CC_F_ACD_QUEUE_INTERVAL.TALK_TIME_TOTAL,
    CC_F_ACD_QUEUE_INTERVAL.AFTER_CALL_WORK_TIME_TOTAL,
    CC_F_ACD_QUEUE_INTERVAL.SERVICE_LEVEL_ANSWERED_PERCENT,
    CC_F_ACD_QUEUE_INTERVAL.SERVICE_LEVEL_ANSWERED_COUNT,
    CC_F_ACD_QUEUE_INTERVAL.SERVICE_LEVEL_ABANDONED,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_ON_HOLD,
    CC_F_ACD_QUEUE_INTERVAL.HOLD_TIME_TOTAL,
    CC_F_ACD_QUEUE_INTERVAL.SHORT_ABANDONS,
    CC_F_ACD_QUEUE_INTERVAL.SHORT_CALLS,
    CC_F_ACD_QUEUE_INTERVAL.CALLS_RONA,
    CC_F_ACD_QUEUE_INTERVAL.CREATE_DATE,
    CC_F_ACD_QUEUE_INTERVAL.LAST_UPDATE_DATE,
    CC_F_ACD_QUEUE_INTERVAL.MAX_ABANDON_TIME,
    CC_F_ACD_QUEUE_INTERVAL.QUEUE_NUMBER,
    CC_F_ACD_QUEUE_INTERVAL.ABANDON_THRESHOLD,
    CC_F_ACD_QUEUE_INTERVAL.MAX_CALLS_QUEUED,
    CC_F_ACD_QUEUE_INTERVAL.HANDLE_TIME,
    CC_F_ACD_QUEUE_INTERVAL.ROUTER_QUEUE_WAIT_TIME,
    CC_F_ACD_QUEUE_INTERVAL.RAW_CONTACTS_OFFERED,
    ROUND( ( CASE WHEN (CC_F_ACD_QUEUE_INTERVAL.CONTACTS_ABANDONED)!=0 THEN ((CC_F_ACD_QUEUE_INTERVAL.ABANDON_TIME_TOTAL)/(CC_F_ACD_QUEUE_INTERVAL.CONTACTS_ABANDONED))ELSE NULL END ),2) AVG_TIME_TO_ABANDON
  FROM CC_F_ACD_QUEUE_INTERVAL
  INNER JOIN CC_D_CONTACT_QUEUE
  ON CC_F_ACD_QUEUE_INTERVAL.D_CONTACT_QUEUE_ID = CC_D_CONTACT_QUEUE.D_CONTACT_QUEUE_ID;

