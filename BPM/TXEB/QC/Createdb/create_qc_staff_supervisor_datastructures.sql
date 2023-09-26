CREATE TABLE QC_STAFF_SUPERVISOR
(
STAFF_SUPERVISOR_ID NUMBER(19) NOT NULL,
STAFF_ID NUMBER(19),
SUPERVISOR_EMPID VARCHAR2(80 BYTE),
VERSION NUMBER(10),
CREATE_TS DATE,
CREATE_BY VARCHAR2(30 BYTE),
UPDATE_TS DATE,
UPDATE_BY VARCHAR2(30 BYTE),
SUPERVISOR_START_DATE  DATE,
SUPERVISOR_END_DATE  DATE
);

/*alter table qc_staff_supervisor
  modify staff_id null */
  
/*alter table qc_staff_supervisor
  drop CONSTRAINT QC_STAFF_SUPERVISOR_FK*/
  
CREATE INDEX QC_STAFF_SUPERVISOR_IDX1 ON QC_STAFF_SUPERVISOR
  (
    STAFF_SUPERVISOR_ID
  );
  
CREATE INDEX QC_STAFF_SUPERVISOR_IDX2 ON QC_STAFF_SUPERVISOR
  (
    STAFF_ID
  );

CREATE INDEX QC_STAFF_SUPERVISOR_IDX3 ON QC_STAFF_SUPERVISOR
  (
    SUPERVISOR_EMPID
  );
  
ALTER TABLE QC_STAFF_SUPERVISOR ADD CONSTRAINTS QC_STAFF_SUPERVISOR_PK PRIMARY KEY
  (
    STAFF_SUPERVISOR_ID
  );
  
ALTER TABLE QC_STAFF_SUPERVISOR ADD CONSTRAINTS QC_STAFF_SUPERVISOR_UN UNIQUE
  (
    STAFF_ID
    ,SUPERVISOR_EMPID
    ,SUPERVISOR_START_DATE
  );
  
ALTER TABLE QC_STAFF_SUPERVISOR ADD CONSTRAINTS QC_STAFF_SUPERVISOR_CK1 CHECK
  (
    SUPERVISOR_START_DATE <= SUPERVISOR_END_DATE
  );
  
ALTER TABLE QC_STAFF_SUPERVISOR ADD CONSTRAINTS QC_STAFF_SUPERVISOR_FK FOREIGN KEY
  (
    STAFF_ID
  )REFERENCES QC_STAFF (STAFF_ID) NOT DEFERRABLE; 
  
CREATE SEQUENCE SEQ_QC_STAFF_SUPERVISOR START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20;
  
CREATE OR REPLACE TRIGGER "BIU_QC_STAFF_SUPERVISOR" 
  BEFORE INSERT OR UPDATE ON QC_STAFF_SUPERVISOR 
  FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.STAFF_SUPERVISOR_ID IS NULL THEN 
  SELECT SEQ_QC_STAFF_SUPERVISOR.NEXTVAL INTO :NEW.STAFF_SUPERVISOR_ID FROM DUAL;
END IF;
IF INSERTING THEN
          :NEW.CREATE_TS := SYSDATE;
          :NEW.CREATE_BY := USER;
END IF;
:NEW.UPDATE_TS := SYSDATE;
:NEW.UPDATE_BY := USER;
END;
/ 


-- create view

CREATE OR REPLACE VIEW QC_STAFF_SUPERVISOR_SV AS 
select 
  SS.STAFF_ID,
  CASE WHEN SS.VERSION=SS_CURR.MAX_VER THEN 1 ELSE 0 END CURR_IND,
  STF.EXT_STAFF_NUMBER EXT_STAFF_ID,
  STF.FIRST_NAME STAFF_FIRST_NAME,
  STF.LAST_NAME STAFF_LAST_NAME,
  CONCAT(STF.FIRST_NAME,CONCAT(' ',STF.LAST_NAME)) AGENT_DISPLAY_NAME,
  STF.START_DATE,
  STF.END_DATE,
  STF.TITLE STAFF_TITLE,
  SS.SUPERVISOR_EMPID,
  SUP.FIRST_NAME SUPE_FIRST_NAME,
  SUP.LAST_NAME SUPE_LAST_NAME,
  CONCAT(SUP.FIRST_NAME,CONCAT(' ',SUP.LAST_NAME)) AG_SUPE_DISPLAY_NAME,
  SS.SUPERVISOR_START_DATE SUPE_START_DATE,
  SS.SUPERVISOR_END_DATE SUPE_END_DATE,
  SS.CREATE_TS,
  SS.CREATE_BY,
  SS.UPDATE_TS,
  SS.UPDATE_BY
from QC_STAFF_SUPERVISOR SS
INNER JOIN (SELECT STAFF_ID,SUPERVISOR_EMPID,MAX(VERSION)MAX_VER FROM QC_STAFF_SUPERVISOR GROUP BY STAFF_ID,SUPERVISOR_EMPID) SS_CURR ON (SS.STAFF_ID=SS_CURR.STAFF_ID AND SS.SUPERVISOR_EMPID=SS_CURR.SUPERVISOR_EMPID)
INNER JOIN QC_STAFF STF ON (SS.STAFF_ID=STF.STAFF_ID)
INNER JOIN QC_STAFF SUP ON (SS.SUPERVISOR_EMPID=SUP.EXT_STAFF_NUMBER);

grant select on qc_staff_supervisor_sv to maxdat_read_only;
grant select on qc_staff_supervisor_sv to maxdat_reports;
