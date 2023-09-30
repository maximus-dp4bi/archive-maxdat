-- Generated by Oracle SQL Developer Data Modeler 3.1.4.710
--   at:        2014-01-02 12:28:31 EST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



CREATE TABLE S_METRIC_DEFINITION 
    ( 
     S_METRIC_DEFINITION_ID NUMBER (19)  NOT NULL , 
     METRIC VARCHAR2 (50) , 
     TYPE VARCHAR2 (50) , 
     DATA_TYPE_NAME VARCHAR2 (50) , 
     VALUE_TYPE VARCHAR2 (50) , 
     STATUS VARCHAR2 (50) , 
     HAS_TARGET VARCHAR2 (1) , 
     HAS_FORECAST VARCHAR2 (1) , 
     IS_CALCULATED VARCHAR2 (1) , 
     FUNCTIONAL_AREA VARCHAR2 (50) , 
     LABEL VARCHAR2 (50) , 
     CATEGORY VARCHAR2 (50) , 
     CREATE_DATE DATE , 
     LAST_MODIFIED_DATE DATE , 
     RECORD_EFF_DT DATE , 
     RECORD_END_DT DATE 
    ) 
    LOGGING 
;



ALTER TABLE S_METRIC_DEFINITION 
    ADD CONSTRAINT S_METRIC_TEMPLATEv1_PK PRIMARY KEY ( S_METRIC_DEFINITION_ID ) ;


ALTER TABLE S_METRIC_DEFINITION 
    ADD CONSTRAINT S_METRIC_DEFINITION_UN UNIQUE ( METRIC ) ;



CREATE TABLE S_METRIC_TEMPLATE 
    ( 
     S_METRIC_TEMPLATE_ID NUMBER (19)  NOT NULL , 
     FILE_NAME VARCHAR2 (255) , 
     CREATE_DATE DATE , 
     PROJECT_NAME VARCHAR2 (50) , 
     REPORTING_PERIOD DATE , 
     METRIC VARCHAR2 (50) , 
     FORECAST_VALUE NUMBER (19,2) , 
     ACTUAL_VALUE NUMBER (19,2) ,
     COMMENTS VARCHAR2(4000) ,
     IS_PROCESSED VARCHAR(1)
    ) 
    LOGGING 
;



ALTER TABLE S_METRIC_TEMPLATE 
    ADD CONSTRAINT S_METRIC_TEMPLATE_PK PRIMARY KEY ( S_METRIC_TEMPLATE_ID ) ;


ALTER TABLE S_METRIC_TEMPLATE 
    ADD CONSTRAINT S_METRIC_TEMPLATE_UN UNIQUE ( FILE_NAME , METRIC , REPORTING_PERIOD , PROJECT_NAME , CREATE_DATE ) ;



CREATE SEQUENCE SEQ_S_METRIC_DEFINITION 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 9999999999999999 
    MINVALUE 1 
    CACHE 20 
;

CREATE SEQUENCE SEQ_S_METRIC_TEMPLATE 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 9999999999999999 
    MINVALUE 1 
    CACHE 20 
;

CREATE OR REPLACE TRIGGER BIU_S_METRIC_DEFINITION 
    BEFORE INSERT OR UPDATE ON S_METRIC_DEFINITION 
    FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.S_METRIC_DEFINITION_ID IS NULL THEN 
	SELECT SEQ_S_METRIC_DEFINITION.NEXTVAL INTO :NEW.S_METRIC_DEFINITION_ID FROM DUAL;
	SELECT SYSDATE INTO :NEW.CREATE_DATE FROM DUAL;
END IF;

IF UPDATING THEN
	SELECT SYSDATE INTO :NEW.LAST_MODIFIED_DATE FROM DUAL;
END IF;
END; 
/

ALTER TRIGGER BIU_S_METRIC_DEFINITION ENABLE ;


CREATE OR REPLACE TRIGGER BI_S_METRIC_TEMPLATE 
    BEFORE INSERT OR UPDATE ON S_METRIC_TEMPLATE 
    FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.S_METRIC_TEMPLATE_ID IS NULL THEN 
          SELECT SEQ_S_METRIC_TEMPLATE.NEXTVAL INTO :NEW.S_METRIC_TEMPLATE_ID FROM DUAL;
END IF;
END; 
/

ALTER TRIGGER BI_S_METRIC_TEMPLATE ENABLE ;




-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             2
-- CREATE INDEX                             0
-- ALTER TABLE                              4
-- CREATE VIEW                              0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            2
-- CREATE STRUCTURED TYPE                   0
-- CREATE COLLECTION TYPE                   0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          2
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0