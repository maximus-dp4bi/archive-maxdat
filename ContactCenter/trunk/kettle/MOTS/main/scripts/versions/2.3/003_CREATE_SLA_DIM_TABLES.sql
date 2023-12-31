
CREATE TABLE D_SLA_DEFINITION 
    ( 
     D_SLA_DEFINITION_ID NUMBER (19)  NOT NULL , 
     SLA_NAME VARCHAR2 (50) , 
     SLA_LABEL VARCHAR2 (100) , 
     CATEGORY VARCHAR2 (50) , 
     FUNCTIONAL_AREA VARCHAR2 (50) , 
     REFERENCE_VALUE_DISPLAY_FORMAT VARCHAR2 (50) , 
     VERSION NUMBER (4) , 
     RECORD_EFF_DT DATE , 
     RECORD_END_DT DATE , 
     CREATE_DATE DATE , 
     CREATED_BY VARCHAR2 (50) , 
     LAST_MODIFIED_DATE DATE , 
     UPDATED_BY VARCHAR2 (50) 
    ) 
    LOGGING 
;



ALTER TABLE D_SLA_DEFINITION 
    ADD CONSTRAINT D_SLA_DEFINITION_PK PRIMARY KEY ( D_SLA_DEFINITION_ID ) ;


ALTER TABLE D_SLA_DEFINITION 
    ADD CONSTRAINT D_SLA_DEFINITION_SLA_NAME__UN UNIQUE ( SLA_NAME ) ;



CREATE TABLE D_SLA_PROJECT 
    ( 
     D_SLA_PROJECT_ID NUMBER (19)  NOT NULL , 
     D_PROJECT_ID NUMBER (19)  NOT NULL , 
     D_PROGRAM_ID NUMBER (19)  NOT NULL , 
     D_GEOGRAPHY_MASTER_ID NUMBER (19)  NOT NULL , 
     D_SLA_DEFINITION_ID NUMBER (19)  NOT NULL , 
     FREQUENCY VARCHAR2 (50) , 
     PROJECT_SLA_LABEL VARCHAR2 (255) , 
     REFERENCE_VALUE_CALC_DESC VARCHAR2 (255) , 
     REFERENCE_VALUE_DESC VARCHAR2 (255) , 
     PRIMARY_METRIC_DEFN_ID NUMBER , 
     PRIMARY_METRIC_THRESHOLD_LOW NUMBER (19,6) , 
     PRIMARY_METRIC_THRESHOLD_HIGH NUMBER (19,6) , 
     SECONDARY_METRIC_DEFN_ID NUMBER , 
     SECONDRY_METRIC_THRESHOLD_LOW NUMBER (19,6) , 
     SECONDRY_METRIC_THRESHOLD_HIGH NUMBER (19,6) , 
     SORT_ORDER NUMBER (6) , 
     SORT_ID VARCHAR2 (50) , 
     START_DATE DATE , 
     END_DATE DATE , 
     CREATE_DATE DATE , 
     CREATED_BY VARCHAR2 (50) , 
     LAST_MODIFIED_DATE DATE , 
     UPDATED_BY VARCHAR2 (50) 
    ) 
    LOGGING 
;



ALTER TABLE D_SLA_PROJECT 
    ADD CONSTRAINT D_SLA_PROJECT_PK PRIMARY KEY ( D_SLA_PROJECT_ID ) ;


ALTER TABLE D_SLA_PROJECT 
    ADD CONSTRAINT D_SLA_PROJECT__UN UNIQUE ( D_PROJECT_ID , D_PROGRAM_ID , D_GEOGRAPHY_MASTER_ID , SORT_ID ) ;



CREATE TABLE F_SERVICE_LEVEL_AGREEMENT 
    ( 
     F_SLA_ID NUMBER (19)  NOT NULL , 
     D_SLA_PROJECT_ID NUMBER (19)  NOT NULL , 
     D_REPORTING_PERIOD_ID NUMBER (19)  NOT NULL , 
     COMPLIANCE_RESULT NUMBER (1) , 
     REFERENCE_VALUE NUMBER (19,6) , 
     COMPLIANCE_COMMENTS VARCHAR2 (240) , 
     CREATE_DATE DATE , 
     CREATED_BY VARCHAR2 (50) , 
     LAST_MODIFIED_DATE DATE , 
     UPDATED_BY VARCHAR2 (50) 
    ) 
    LOGGING 
;



ALTER TABLE F_SERVICE_LEVEL_AGREEMENT 
    ADD CONSTRAINT F_SERVICE_LEVEL_AGREEMENT_PK PRIMARY KEY ( F_SLA_ID ) ;


ALTER TABLE F_SERVICE_LEVEL_AGREEMENT 
    ADD CONSTRAINT F_SERVICE_LEVEL_AGREEMENT__UN UNIQUE ( D_SLA_PROJECT_ID , D_REPORTING_PERIOD_ID ) ;


ALTER TABLE D_SLA_PROJECT 
    ADD CONSTRAINT D_SLA_PROJECT_D_GEO_MASTER_FK FOREIGN KEY 
    ( 
     D_GEOGRAPHY_MASTER_ID
    ) 
    REFERENCES D_GEOGRAPHY_MASTER 
    ( 
     D_GEOGRAPHY_MASTER_ID
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE D_SLA_PROJECT 
    ADD CONSTRAINT D_SLA_PROJECT_D_PROGRAM_FK FOREIGN KEY 
    ( 
     D_PROGRAM_ID
    ) 
    REFERENCES D_PROGRAM 
    ( 
     D_PROGRAM_ID
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE D_SLA_PROJECT 
    ADD CONSTRAINT D_SLA_PROJECT_D_PROJECT_FK FOREIGN KEY 
    ( 
     D_PROJECT_ID
    ) 
    REFERENCES D_PROJECT 
    ( 
     D_PROJECT_ID
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE D_SLA_PROJECT 
    ADD CONSTRAINT D_SLA_PROJECT_D_SLA_DEFN_FK FOREIGN KEY 
    ( 
     D_SLA_DEFINITION_ID
    ) 
    REFERENCES D_SLA_DEFINITION 
    ( 
     D_SLA_DEFINITION_ID
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE F_SERVICE_LEVEL_AGREEMENT 
    ADD CONSTRAINT F_SLA_D_REPORTING_PERIOD_FK FOREIGN KEY 
    ( 
     D_REPORTING_PERIOD_ID
    ) 
    REFERENCES D_REPORTING_PERIOD 
    ( 
     D_REPORTING_PERIOD_ID
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE F_SERVICE_LEVEL_AGREEMENT 
    ADD CONSTRAINT F_SLA_D_SLA_PROJECT_FK FOREIGN KEY 
    ( 
     D_SLA_PROJECT_ID
    ) 
    REFERENCES D_SLA_PROJECT 
    ( 
     D_SLA_PROJECT_ID
    ) 
    NOT DEFERRABLE 
;

CREATE SEQUENCE SEQ_D_SLA_DEFINITION 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 9999999999999999999 
    MINVALUE 1 
    CACHE 20 
;

CREATE SEQUENCE SEQ_D_SLA_PROJECT 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 9999999999999999999 
    MINVALUE 1 
    CACHE 20 
;

CREATE SEQUENCE SEQ_F_SLA 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 9999999999999999999 
    MINVALUE 1 
    CACHE 20 
;


CREATE OR REPLACE TRIGGER BIU_D_SLA_DEFINITION 
    BEFORE INSERT OR UPDATE ON D_SLA_DEFINITION 
    FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.D_SLA_DEFINITION_ID IS NULL THEN 
          SELECT SEQ_D_SLA_DEFINITION.NEXTVAL INTO :NEW.D_SLA_DEFINITION_ID FROM DUAL;
	:NEW.CREATE_DATE := SYSDATE;
	:NEW.CREATED_BY := USER;
END IF;
:NEW.UPDATED_BY := USER;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END;

 
/

ALTER TRIGGER BIU_D_SLA_DEFINITION ENABLE; 


CREATE OR REPLACE TRIGGER BIU_D_SLA_PROJECT 
    BEFORE INSERT OR UPDATE ON D_SLA_PROJECT 
    FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.D_SLA_PROJECT_ID IS NULL THEN 
          SELECT SEQ_D_SLA_PROJECT.NEXTVAL INTO :NEW.D_SLA_PROJECT_ID FROM DUAL;
	:NEW.CREATE_DATE := SYSDATE;
	:NEW.CREATED_BY := USER;
END IF;
:NEW.UPDATED_BY := USER;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END;

 
/

ALTER TRIGGER BIU_D_SLA_PROJECT ENABLE; 


CREATE OR REPLACE TRIGGER BIU_F_SLA 
    BEFORE INSERT OR UPDATE ON F_SERVICE_LEVEL_AGREEMENT 
    FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.F_SLA_ID IS NULL THEN 
          SELECT SEQ_F_SLA.NEXTVAL INTO :NEW.F_SLA_ID FROM DUAL;
	:NEW.CREATE_DATE := SYSDATE;
	:NEW.CREATED_BY := USER;
END IF;
:NEW.UPDATED_BY := USER;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END;

 
/

ALTER TRIGGER BIU_F_SLA ENABLE;



CREATE OR REPLACE VIEW D_SLA_DEFINITION_SV AS
SELECT D_SLA_DEFINITION.* FROM D_SLA_DEFINITION ;

CREATE PUBLIC SYNONYM D_SLA_DEFINITION_SV FOR D_SLA_DEFINITION_SV;


CREATE OR REPLACE VIEW D_SLA_PROJECT_SV AS
SELECT D_SLA_PROJECT.* FROM D_SLA_PROJECT ;

CREATE PUBLIC SYNONYM D_SLA_PROJECT_SV FOR D_SLA_PROJECT_SV;


CREATE OR REPLACE VIEW F_SERVICE_LEVEL_AGREEMENT_SV AS
SELECT F_SERVICE_LEVEL_AGREEMENT.* FROM F_SERVICE_LEVEL_AGREEMENT ;

CREATE PUBLIC SYNONYM F_SERVICE_LEVEL_AGREEMENT_SV FOR F_SERVICE_LEVEL_AGREEMENT_SV;


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('2.3','003','003_CREATE_SLA_DIM_TABLES');


COMMIT;
