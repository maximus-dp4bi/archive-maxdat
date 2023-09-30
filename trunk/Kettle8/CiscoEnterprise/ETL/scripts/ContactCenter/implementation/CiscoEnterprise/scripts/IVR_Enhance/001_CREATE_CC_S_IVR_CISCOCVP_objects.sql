drop table CC_S_IVR_CISCOCVP;
drop sequence SEQ_IVR_CISCOCVP_ID;

CREATE TABLE CC_S_IVR_CISCOCVP (
IVR_CISCOCVP_ID NUMBER(32)
,CALLGUID VARCHAR2(40 BYTE)
,CALLSTARTDATE  DATE
,APPNAME    VARCHAR2(60)
,STARTDATETIME   DATE
,ENDDATETIME     DATE
,EVENTYPEID NUMBER
,EVENTTYPE       VARCHAR2(60)
,CAUSEID    NUMBER
,CAUSE    VARCHAR2(60)
,DURATION NUMBER(38)
,ANI    VARCHAR2(25)
,DNIS   VARCHAR2(30)
,ROUTERCALLKEYDAY NUMBER
,ROUTERCALLKEY    NUMBER
,EXIT_POINT VARCHAR2(60)
,DET_GUID VARCHAR2(36 BYTE)
,PRECISIONQUEUEID NUMBER
,PQNAME     VARCHAR2(60)
,CALLTYPEID NUMBER
,CTNAME   VARCHAR2(60)
,TALKTIME NUMBER(10)
,WORKTIME NUMBER(10)
,RINGTIME NUMBER(10)
,TIMETOABAND  NUMBER(10)
,CALLSTARTDATE_UTC DATE
,STARTDATETIME_DB_UTC DATE
,ENDDATETIME_DB_UTC DATE
,LOCALTIMEZONEOFFSET  NUMBER
,EXTRACT_DT DATE  NOT NULL 
,LAST_UPDATE_DT DATE  NOT NULL 
,LAST_UPDATE_BY VARCHAR2 (30)  NOT NULL 
)
        TABLESPACE MAXDAT_DATA 
        LOGGING 
;        

COMMENT ON TABLE CC_S_IVR_CISCOCVP IS 'Staging Table; Stores the IVR data from Cisco CVP; Uniqueness is Composite CALLGUID, CALLSTARTDATE';
COMMENT ON COLUMN CC_S_IVR_CISCOCVP.CALLSTARTDATE IS 'VXMLSESSION.CALLSTARTDATE; At the time of table creation timezone of data is US/Eastern (local)';
COMMENT ON COLUMN CC_S_IVR_CISCOCVP.STARTDATETIME IS 'VXMLSESSION.startdatetime for timezone mentioned in cc.timezone; At time of implementation it is US/Eastern';
COMMENT ON COLUMN CC_S_IVR_CISCOCVP.ENDDATETIME IS 'VXMLSESSION.enddatetime for timezone mentioned in cc.timezone; At time of implementation it is US/Eastern';
COMMENT ON COLUMN CC_S_IVR_CISCOCVP.STARTDATETIME_DB_UTC IS 'VXMLSESSION.startdatetime; As is from DB; Timezone is UTC';
COMMENT ON COLUMN CC_S_IVR_CISCOCVP.ENDDATETIME_DB_UTC IS 'VXMLSESSION.enddatetime; As is from DB; Timezone is UTC';
COMMENT ON COLUMN CC_S_IVR_CISCOCVP.APPNAME IS 'VXMLSESSION.APPNAME; Each project/program can have multiple Appnames';
COMMENT ON COLUMN CC_S_IVR_CISCOCVP.DNIS IS 'CALL.DNIS; Each Appname will have multiple DNIs';
COMMENT ON COLUMN CC_S_IVR_CISCOCVP.CALLSTARTDATE_UTC IS 'VXMLSESSION.CALLSTARTDATE in UTC; Converted using LOCALTIMEZONEOFFSET';

ALTER TABLE CC_S_IVR_CISCOCVP 
    ADD CONSTRAINT CC_S_IVR_CISCOCVP_PK PRIMARY KEY ( IVR_CISCOCVP_ID ) ;


ALTER TABLE CC_S_IVR_CISCOCVP 
    ADD CONSTRAINT CC_S_IVR_CISCOCVP_UN UNIQUE ( CALLGUID , CALLSTARTDATE) ;
    
CREATE SEQUENCE SEQ_IVR_CISCOCVP_ID;  

CREATE OR REPLACE TRIGGER BIU_CC_S_IVR_CISCOCVP
    BEFORE INSERT OR UPDATE ON CC_S_IVR_CISCOCVP 
    FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.IVR_CISCOCVP_ID IS NULL THEN 
          SELECT SEQ_IVR_CISCOCVP_ID.NEXTVAL INTO :NEW.IVR_CISCOCVP_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.EXTRACT_DT := SYSDATE;
END IF;
:NEW.LAST_UPDATE_DT := SYSDATE;
:NEW.LAST_UPDATE_BY := USER;
END; 
/

CREATE OR REPLACE VIEW CC_S_IVR_CISCOCVP_SV AS 
SELECT * FROM CC_S_IVR_CISCOCVP;

GRANT SELECT ON CC_S_IVR_CISCOCVP TO CISCO_READ_ONLY;
GRANT SELECT ON CC_S_IVR_CISCOCVP_SV TO CISCO_READ_ONLY;
GRANT SELECT, INSERT, UPDATE, DELETE ON CC_S_IVR_CISCOCVP TO SD25802, SR18956;
GRANT SELECT, INSERT, UPDATE, DELETE ON CC_S_IVR_CISCOCVP TO SD25802, SR18956;
GRANT SELECT ON CC_S_IVR_CISCOCVP TO MAXDAT_READ_ONLY;
GRANT SELECT ON CC_S_IVR_CISCOCVP_SV TO MAXDAT_READ_ONLY;