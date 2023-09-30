DROP TABLE CC_F_IVR_PERFORMANCE_INTERVAL;
CREATE TABLE CC_F_IVR_PERFORMANCE_INTERVAL
(
F_IVR_PERFORMANCE_INTERVAL_ID NUMBER(38)
,D_DATE_ID    NUMBER(38)      NOT NULL
,D_INTERVAL_ID    NUMBER(38)  NOT NULL
,D_PROJECT_ID   NUMBER(38)    NOT NULL
,D_PROGRAM_ID   NUMBER(38)    NOT NULL
,IVR_SOURCE   VARCHAR2(20)    NOT NULL
,IVR_APPLICATION_NAME VARCHAR2(60)  NOT NULL
,D_IVR_LANG_ID          NUMBER(38)        NOT NULL
,INBOUND_DNIS_TYPE    VARCHAR2(20) NOT NULL
,UNIT_OF_WORK         VARCHAR2(20) NOT NULL
,IVR_EXIT_RESULT  varchar2(60)  NOT NULL
,IVR_EXIT_POINT   VARCHAR2(255) NOT NULL
,CALLS_RECEIVED_IN_IVR        NUMBER(7) DEFAULT 0 NOT NULL
,CALLS_ROUTED_TO_AGENT        NUMBER(7) DEFAULT 0 NOT NULL
,CALLS_CONTAINED_IN_IVR       NUMBER(7) DEFAULT 0 NOT NULL
,CALLS_RECEIVED_AFTER_HOURS    NUMBER(7) DEFAULT 0 NOT NULL
,TOTAL_DURATION_IN_IVR        NUMBER(11,2)
,AVG_DURATION_IN_IVR          NUMBER(11,2)
,MIN_DURATION_IN_IVR          NUMBER(11,2)
,MAX_DURATION_IN_IVR          NUMBER(11,2)
,CREATE_DT    DATE
,CREATED_BY   VARCHAR2(50)
,UPDATE_DT    DATE
,UPDATED_BY   VARCHAR2(50)
,UPDATE_COMMENTS              VARCHAR2(2000)
)
        TABLESPACE MAXDAT_DATA 
        LOGGING 
;

COMMENT ON TABLE CC_F_IVR_PERFORMANCE_INTERVAL IS 'Fact Table; Stores the IVR data from all sources; Uniqueness yet to determine';
COMMENT ON COLUMN CC_F_IVR_PERFORMANCE_INTERVAL.D_DATE_ID IS 'CC_D_DATES.D_DATE_ID FOR IVR_CALL_DATE';
COMMENT ON COLUMN CC_F_IVR_PERFORMANCE_INTERVAL.D_INTERVAL_ID IS 'CC_D_INTERVAL.D_INTERVAL_ID FOR IVR_CALL_START_TIME';
COMMENT ON COLUMN CC_F_IVR_PERFORMANCE_INTERVAL.D_PROJECT_ID IS 'CC_D_PROJECT.D_PROJECT_ID FOR IVR CALL';
COMMENT ON COLUMN CC_F_IVR_PERFORMANCE_INTERVAL.D_PROGRAM_ID IS 'CC_D_PROGRAM.D_PROGRAM_ID FOR IVR CALL';

ALTER TABLE CC_F_IVR_PERFORMANCE_INTERVAL 
    ADD CONSTRAINT CC_F_IVR_PERFORMANCE_INTERVAL_PK PRIMARY KEY ( F_IVR_PERFORMANCE_INTERVAL_ID ) ;


ALTER TABLE CC_F_IVR_PERFORMANCE_INTERVAL 
    ADD CONSTRAINT CC_F_IVR_PERFORMANCE_INTERVAL_UN UNIQUE ( D_DATE_ID, D_INTERVAL_ID, D_PROJECT_ID, D_PROGRAM_ID, IVR_SOURCE, IVR_APPLICATION_NAME, D_IVR_LANG_ID, INBOUND_DNIS_TYPE, UNIT_OF_WORK, IVR_EXIT_RESULT, IVR_EXIT_POINT) ;

ALTER TABLE CC_F_IVR_PERFORMANCE_INTERVAL ADD CONSTRAINT F_IVR_PERF_INTR_D_DATES_FK FOREIGN KEY (D_DATE_ID) REFERENCES CISCO_ENTERPRISE_CC.CC_D_DATES(D_DATE_ID);
ALTER TABLE CC_F_IVR_PERFORMANCE_INTERVAL ADD CONSTRAINT F_IVR_PERF_INTR_D_INTERVAL_FK FOREIGN KEY (D_INTERVAL_ID) REFERENCES CISCO_ENTERPRISE_CC.CC_D_INTERVAL(D_INTERVAL_ID);
ALTER TABLE CC_F_IVR_PERFORMANCE_INTERVAL ADD CONSTRAINT F_IVR_PERF_INTR_D_IVR_LANG_FK FOREIGN KEY (D_IVR_LANG_ID) REFERENCES CISCO_ENTERPRISE_CC.CC_C_IVR_LANGUAGE(IVR_LANG_ID);

CREATE SEQUENCE SEQ_IVR_PERFORMANCE_INTERVAL_ID;  

CREATE OR REPLACE TRIGGER BIU_CC_F_IVR_PERFORMANCE_INTERVAL
    BEFORE INSERT OR UPDATE ON CC_F_IVR_PERFORMANCE_INTERVAL 
    FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.F_IVR_PERFORMANCE_INTERVAL_ID IS NULL THEN 
          SELECT SEQ_IVR_PERFORMANCE_INTERVAL_ID.NEXTVAL INTO :NEW.F_IVR_PERFORMANCE_INTERVAL_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.CREATE_DT := SYSDATE;
          :NEW.CREATED_BY := USER;
END IF;
:NEW.UPDATE_DT := SYSDATE;
:NEW.UPDATED_BY := USER;
END; 
/

CREATE OR REPLACE VIEW CC_F_IVR_PERFORMANCE_INTERVAL_SV AS 
SELECT * FROM CC_F_IVR_PERFORMANCE_INTERVAL;

GRANT SELECT ON CC_F_IVR_PERFORMANCE_INTERVAL TO CISCO_READ_ONLY;
GRANT SELECT ON CC_F_IVR_PERFORMANCE_INTERVAL_SV TO CISCO_READ_ONLY;
GRANT SELECT, INSERT, UPDATE, DELETE ON CC_F_IVR_PERFORMANCE_INTERVAL TO SD25802, SR18956;
GRANT SELECT ON CC_F_IVR_PERFORMANCE_INTERVAL TO MAXDAT_READ_ONLY;
GRANT SELECT ON CC_F_IVR_PERFORMANCE_INTERVAL_SV TO MAXDAT_READ_ONLY;
