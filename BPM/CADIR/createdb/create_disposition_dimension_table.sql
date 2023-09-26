--Disposition dimension table

CREATE TABLE D_CRS_DISPOSITION
  (
    DCD_ID    	   		        NUMBER (19) NOT NULL ,
    DISPOSITION_ID             		NUMBER (19) NOT NULL ,
    DISPOSITION_CODE             	VARCHAR2(255) ,
    DISPOSITION_NAME             	VARCHAR2(255),
    DISPOSITION_ORDER           	NUMBER(10),
    DISPOSITION_ACTIVE_FLAG      	NUMBER (1),
    DISPOSITION_START_DATE		DATE,
    DISPOSITION_END_DATE		DATE,
    CREATE_DT                           DATE NOT NULL ,
    UPDATE_DT                           DATE NOT NULL
  );

ALTER TABLE D_CRS_DISPOSITION ADD CONSTRAINT DCD_ID_PK PRIMARY KEY
(
  DCD_ID
)
;

ALTER TABLE D_CRS_DISPOSITION ADD CONSTRAINT DCDD__UN UNIQUE
(
  DISPOSITION_ID
)
;

CREATE SEQUENCE SEQ_DCD_ID START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE OR REPLACE TRIGGER BIU_D_CRS_DISPOSITION
    BEFORE INSERT OR UPDATE ON D_CRS_DISPOSITION
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.DCD_ID IS NULL THEN 
          SELECT SEQ_DCD_ID.NEXTVAL INTO :NEW.DCD_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.CREATE_DT := SYSDATE;
END IF;
:NEW.UPDATE_DT := SYSDATE;
END; 
/


CREATE OR REPLACE VIEW D_CRS_DISPOSITION_SV
AS SELECT * FROM D_CRS_DISPOSITION;


