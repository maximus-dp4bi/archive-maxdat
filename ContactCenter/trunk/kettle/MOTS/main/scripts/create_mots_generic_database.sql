-- Generated by Oracle SQL Developer Data Modeler 3.3.0.747
--   at:        2014-07-15 13:18:00 EDT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g




CREATE SEQUENCE SEQ_D_CONTROL_CHART START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE SEQUENCE SEQ_D_DATA_TYPE START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE SEQUENCE SEQ_D_DIVISION START WITH 1 INCREMENT BY 1 MAXVALUE 99999999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE SEQUENCE SEQ_D_GEO_MASTER START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE SEQUENCE SEQ_D_METRIC_DEFINITION START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE SEQUENCE SEQ_D_METRIC_PROJECT START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE SEQUENCE SEQ_D_PROGRAM START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE SEQUENCE SEQ_D_PROJECT START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE SEQUENCE SEQ_D_REPORTING_PERIOD START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE SEQUENCE SEQ_D_SEGMENT START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE SEQUENCE SEQ_D_SLA_DEFINITION START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE SEQUENCE SEQ_D_SLA_PROJECT START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE SEQUENCE SEQ_F_METRIC START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE SEQUENCE SEQ_F_SLA START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE SEQUENCE SEQ_METRIC_VALUE_INTEGER START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE SEQUENCE SEQ_METRIC_VALUE_VARCHAR START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

CREATE TABLE D_CONTROL_CHART_PARAMETERS
  (
    D_CONTROL_CHART_ID        NUMBER NOT NULL ,
    D_METRIC_PROJECT_ID       NUMBER (19) NOT NULL ,
    REPORT_TYPE               VARCHAR2 (10) ,
    MU                        NUMBER (19,6) ,
    SIGMA                     NUMBER (19,6) ,
    UCL_OF_SIGMA              NUMBER (19,6) ,
    LCL_OF_SIGMA              NUMBER (19,6) ,
    UPPER_CONTROL_LIMIT       NUMBER (19,6) ,
    LOWER_CONTROL_LIMIT       NUMBER (19,6) ,
    CENTER_LINE               NUMBER (19,6) ,
    UPPER_SPECIFICATION_LIMIT NUMBER (19,6) ,
    LOWER_SPECIFICATION_LIMIT NUMBER (19,6) ,
    UPPER_WARNING_LIMIT       NUMBER (19,6) ,
    LOWER_WARNING_LIMIT       NUMBER (19,6) ,
    CP                        NUMBER (19,6) ,
    CPK                       NUMBER (19,6) ,
    NUMBER_OF_OBSERVATIONS    NUMBER ,
    PARAMETER_EFF_DT          DATE ,
    PARAMETER_END_DT          DATE ,
    CREATE_DATE               DATE ,
    LAST_MODIFIED_DATE        DATE ,
    CREATED_BY                VARCHAR2 (50) ,
    UPDATED_BY                VARCHAR2 (50)
  )
  TABLESPACE MOTS_DATA LOGGING ;
CREATE UNIQUE INDEX D_CONTROL_CHART_PARAMETERS_UK ON D_CONTROL_CHART_PARAMETERS
  (
    D_CONTROL_CHART_ID ASC
  )
  LOGGING ;
  ALTER TABLE D_CONTROL_CHART_PARAMETERS ADD CONSTRAINT D_CONTROL_CHART_PARAMETERS_PK PRIMARY KEY
  (
    D_CONTROL_CHART_ID
  )
  ;

CREATE TABLE D_DATA_TYPE
  (
    D_DATA_TYPE_ID     NUMBER (19) NOT NULL ,
    NAME               VARCHAR2 (50) ,
    VALUE_TABLE        VARCHAR2 (50) ,
    CREATE_DATE        DATE NOT NULL ,
    CREATED_BY         VARCHAR2 (50) ,
    LAST_MODIFIED_DATE DATE ,
    UPDATED_BY         VARCHAR2 (50)
  )
  TABLESPACE MOTS_DATA LOGGING ENABLE ROW MOVEMENT ;
ALTER TABLE D_DATA_TYPE ADD CONSTRAINT D_DATA_TYPE_PK PRIMARY KEY
(
  D_DATA_TYPE_ID
)
;

CREATE TABLE D_DIVISION
  (
    D_DIVISION_ID      NUMBER NOT NULL ,
    DIVISION_NAME      VARCHAR2 (100) ,
    D_SEGMENT_ID       NUMBER NOT NULL ,
    CREATE_DATE        DATE ,
    LAST_MODIFIED_DATE DATE
  )
  TABLESPACE MOTS_DATA LOGGING ;
CREATE INDEX D_DIVISION__IDXv2 ON D_DIVISION
  (
    D_SEGMENT_ID ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
ALTER TABLE D_DIVISION ADD CONSTRAINT D_DIVISION_PK PRIMARY KEY
(
  D_DIVISION_ID
)
;
ALTER TABLE D_DIVISION ADD CONSTRAINT D_DIVISION__UN UNIQUE
(
  DIVISION_NAME
)
;

CREATE TABLE D_GEOGRAPHY_MASTER
  (
    D_GEOGRAPHY_MASTER_ID NUMBER (19) NOT NULL ,
    GEOGRAPHY_NAME        VARCHAR2 (100) ,
    CREATE_DATE           DATE ,
    LAST_MODIFIED_DATE    DATE
  )
  TABLESPACE MOTS_DATA LOGGING ENABLE ROW MOVEMENT ;
ALTER TABLE D_GEOGRAPHY_MASTER ADD CONSTRAINT D_GEOGRAPHY_MASTER_PK PRIMARY KEY
(
  D_GEOGRAPHY_MASTER_ID
)
;
ALTER TABLE D_GEOGRAPHY_MASTER ADD CONSTRAINT D_GEOGRAPHY_MASTER__UN UNIQUE
(
  GEOGRAPHY_NAME
)
;

CREATE TABLE D_METRIC_DEFINITION
  (
    D_METRIC_DEFINITION_ID NUMBER NOT NULL ,
    D_DATA_TYPE_ID         NUMBER (19) NOT NULL ,
    NAME                   VARCHAR2 (50) ,
    LABEL                  VARCHAR2 (100) ,
    SORT_ORDER             NUMBER (6) ,
    TYPE                   VARCHAR2 (50) ,
    CATEGORY               VARCHAR2 (50) ,
    SUB_CATEGORY           VARCHAR2 (50) ,
    VALUE_TYPE             VARCHAR2 (50) ,
    DISPLAY_FORMAT         VARCHAR2 (50) ,
    STATUS                 VARCHAR2 (50) ,
    FUNCTIONAL_AREA        VARCHAR2 (50) ,
    HAS_ACTUAL             VARCHAR2 (50) ,
    HAS_TARGET             VARCHAR2 (50) ,
    HAS_FORECAST           VARCHAR2 (50) ,
    IS_CALCULATED          VARCHAR2 (50) ,
    IS_WEEKLY              VARCHAR2 (50) ,
    IS_MONTHLY             VARCHAR2 (50) ,
    RECORD_EFF_DT          DATE ,
    RECORD_END_DT          DATE ,
    CREATE_DATE            DATE ,
    CREATED_BY             VARCHAR2 (50) ,
    LAST_MODIFIED_DATE     DATE ,
    UPDATED_BY             VARCHAR2 (50)
  )
  TABLESPACE MOTS_DATA LOGGING ENABLE ROW MOVEMENT ;
ALTER TABLE D_METRIC_DEFINITION ADD CONSTRAINT M_DEF_HAS_TARGET_CK CHECK
(
  HAS_TARGET IN ('Y', 'N')
)
;
ALTER TABLE D_METRIC_DEFINITION ADD CONSTRAINT M_DEF_HAS_FORECAST_CK CHECK
(
  HAS_FORECAST IN ('Y', 'N')
)
;
ALTER TABLE D_METRIC_DEFINITION ADD CONSTRAINT M_DEF_IS_CALCULATED_CK CHECK
(
  IS_CALCULATED IN ('Y', 'N')
)
;
CREATE INDEX D_METRIC_DEFINITION__IDXv2 ON D_METRIC_DEFINITION
  (
    FUNCTIONAL_AREA ASC ,
    CATEGORY ASC ,
    SUB_CATEGORY ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
CREATE INDEX D_METRIC_DEFINITION__IDXv3 ON D_METRIC_DEFINITION
  (
    D_DATA_TYPE_ID ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
ALTER TABLE D_METRIC_DEFINITION ADD CONSTRAINT D_METRIC_DEFINITION_PK PRIMARY KEY
(
  D_METRIC_DEFINITION_ID
)
;
ALTER TABLE D_METRIC_DEFINITION ADD CONSTRAINT D_METRIC_DEFINITION_NAME__UN UNIQUE
(
  NAME
)
;

CREATE TABLE D_METRIC_PROJECT
  (
    D_METRIC_PROJECT_ID         NUMBER (19) NOT NULL ,
    D_PROJECT_ID                NUMBER (19) NOT NULL ,
    D_PROGRAM_ID                NUMBER (19) NOT NULL ,
    D_GEOGRAPHY_MASTER_ID       NUMBER (19) NOT NULL ,
    D_METRIC_DEFINITION_ID      NUMBER NOT NULL ,
    SUPPLY_FORECAST             VARCHAR2 (50) ,
    SUPPLY_TARGET               VARCHAR2 (50) ,
    IS_SLA                      VARCHAR2 (50) ,
    SLA_TYPE                    VARCHAR2 (50) ,
    SLA_THRESHOLD               VARCHAR2 (50) ,
    UPPER_SPECIFICATION_LIMIT   NUMBER (19,6) ,
    LOWER_SPECIFICATION_LIMIT   NUMBER (19,6) ,
    CALCULATE_CONTROL_CHART_IND VARCHAR2 (1) ,
    TREND_INDICATOR_CALCULATION VARCHAR2 (20) ,
    ACTUAL_VALUE_PROVIDED_BY    VARCHAR2 (50) ,
    FORECAST_VALUE_PROVIDED_BY  VARCHAR2 (50) ,
    ACTUAL_EFF_DT               DATE ,
    FORECAST_EFF_DT             DATE ,
    TARGET_EFF_DT               DATE ,
    RECORD_EFF_DT               DATE ,
    RECORD_END_DT               DATE ,
    CREATE_DATE                 DATE ,
    CREATED_BY                  VARCHAR2 (50) ,
    LAST_MODIFIED_DATE          DATE ,
    UPDATED_BY                  VARCHAR2 (50)
  )
  TABLESPACE MOTS_DATA LOGGING ENABLE ROW MOVEMENT ;
ALTER TABLE D_METRIC_PROJECT ADD CONSTRAINT M_PROJ_IS_SLA_CK CHECK
(
  IS_SLA IN ('Y', 'N')
)
;
ALTER TABLE D_METRIC_PROJECT ADD CONSTRAINT M_PROJ_SUPPLY_FORECAST_CK CHECK
(
  SUPPLY_FORECAST IN ('Y', 'N')
)
;
ALTER TABLE D_METRIC_PROJECT ADD CONSTRAINT M_PROJ_SUPPLY_TARGET_CK CHECK
(
  SUPPLY_TARGET IN ('Y', 'N')
)
;
CREATE INDEX D_METRIC_PROJECT__IDXv2 ON D_METRIC_PROJECT
  (
    D_METRIC_DEFINITION_ID ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
CREATE INDEX D_METRIC_PROJECT__IDXv3 ON D_METRIC_PROJECT
  (
    D_PROGRAM_ID ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
CREATE INDEX D_METRIC_PROJECT__IDXv4 ON D_METRIC_PROJECT
  (
    D_PROJECT_ID ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
CREATE INDEX D_METRIC_PROJECT__IDXv5 ON D_METRIC_PROJECT
  (
    ACTUAL_EFF_DT DESC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
CREATE INDEX D_METRIC_PROJECT__IDXv6 ON D_METRIC_PROJECT
  (
    FORECAST_EFF_DT DESC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
ALTER TABLE D_METRIC_PROJECT ADD CONSTRAINT D_METRIC_PROJECT_PK PRIMARY KEY
(
  D_METRIC_PROJECT_ID
)
;
ALTER TABLE D_METRIC_PROJECT ADD CONSTRAINT D_METRIC_PROJECT__UN UNIQUE
(
  D_PROJECT_ID , D_PROGRAM_ID , D_GEOGRAPHY_MASTER_ID , D_METRIC_DEFINITION_ID , RECORD_EFF_DT
)
;

CREATE TABLE D_PROGRAM
  (
    D_PROGRAM_ID       NUMBER (19) NOT NULL ,
    PROGRAM_NAME       VARCHAR2 (100) ,
    CREATE_DATE        DATE ,
    LAST_MODIFIED_DATE DATE
  )
  TABLESPACE MOTS_DATA LOGGING ENABLE ROW MOVEMENT ;
ALTER TABLE D_PROGRAM ADD CONSTRAINT D_PROGRAM_PK PRIMARY KEY
(
  D_PROGRAM_ID
)
;
ALTER TABLE D_PROGRAM ADD CONSTRAINT D_PROGRAM__UN UNIQUE
(
  PROGRAM_NAME
)
;

CREATE TABLE D_PROJECT
  (
    D_PROJECT_ID       NUMBER (19) NOT NULL ,
    PROJECT_NAME       VARCHAR2 (100) ,
    D_DIVISION_ID      NUMBER NOT NULL ,
    CREATE_DATE        DATE ,
    LAST_MODIFIED_DATE DATE
  )
  TABLESPACE MOTS_DATA LOGGING ENABLE ROW MOVEMENT ;
CREATE INDEX D_PROJECT__IDXv2 ON D_PROJECT
  (
    D_DIVISION_ID ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
ALTER TABLE D_PROJECT ADD CONSTRAINT D_PROJECT_PK PRIMARY KEY
(
  D_PROJECT_ID
)
;
ALTER TABLE D_PROJECT ADD CONSTRAINT D_PROJECT__UN UNIQUE
(
  PROJECT_NAME
)
;

CREATE TABLE D_REPORTING_PERIOD
  (
    D_REPORTING_PERIOD_ID NUMBER (19) NOT NULL ,
    TYPE                  VARCHAR2 (50) ,
    START_DATE            DATE ,
    END_DATE              DATE ,
    MONTH                 VARCHAR2 (50) ,
    YEAR                  NUMBER (19) ,
    CREATE_DATE           DATE ,
    CREATED_BY            VARCHAR2 (50) ,
    LAST_MODIFIED_DATE    DATE ,
    UPDATED_BY            VARCHAR2 (50)
  )
  TABLESPACE MOTS_DATA LOGGING ENABLE ROW MOVEMENT ;
CREATE UNIQUE INDEX D_REPORTING_PERIOD__IDXv2 ON D_REPORTING_PERIOD
  (
  TYPE ASC , END_DATE DESC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
  ALTER TABLE D_REPORTING_PERIOD ADD CONSTRAINT D_REPORTING_PERIOD_PK PRIMARY KEY
  (
    D_REPORTING_PERIOD_ID
  )
  ;
  ALTER TABLE D_REPORTING_PERIOD ADD CONSTRAINT D_REPORTING_PERIOD__UN UNIQUE
  (
    START_DATE , END_DATE
  )
  ;

CREATE TABLE D_SEGMENT
  (
    D_SEGMENT_ID       NUMBER NOT NULL ,
    SEGMENT_NAME       VARCHAR2 (100) ,
    CREATE_DATE        DATE ,
    LAST_MODIFIED_DATE DATE
  )
  TABLESPACE MOTS_DATA LOGGING ;
ALTER TABLE D_SEGMENT ADD CONSTRAINT D_SEGMENT_PK PRIMARY KEY
(
  D_SEGMENT_ID
)
;
ALTER TABLE D_SEGMENT ADD CONSTRAINT D_SEGMENT__UN UNIQUE
(
  SEGMENT_NAME
)
;

CREATE TABLE D_SLA_DEFINITION
  (
    D_SLA_DEFINITION_ID            NUMBER (19) NOT NULL ,
    SLA_NAME                       VARCHAR2 (50) ,
    SLA_LABEL                      VARCHAR2 (100) ,
    CATEGORY                       VARCHAR2 (50) ,
    FUNCTIONAL_AREA                VARCHAR2 (50) ,
    REFERENCE_VALUE_DISPLAY_FORMAT VARCHAR2 (50) ,
    VERSION                        NUMBER (4) ,
    RECORD_EFF_DT                  DATE ,
    RECORD_END_DT                  DATE ,
    CREATE_DATE                    DATE ,
    CREATED_BY                     VARCHAR2 (50) ,
    LAST_MODIFIED_DATE             DATE ,
    UPDATED_BY                     VARCHAR2 (50)
  )
  TABLESPACE MOTS_DATA LOGGING ENABLE ROW MOVEMENT ;
CREATE INDEX D_SLA_DEFINITION__IDXv2 ON D_SLA_DEFINITION
  (
    CATEGORY ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
CREATE INDEX D_SLA_DEFINITION__IDXv3 ON D_SLA_DEFINITION
  (
    FUNCTIONAL_AREA ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
ALTER TABLE D_SLA_DEFINITION ADD CONSTRAINT D_SLA_DEFINITION_PK PRIMARY KEY
(
  D_SLA_DEFINITION_ID
)
;
ALTER TABLE D_SLA_DEFINITION ADD CONSTRAINT D_SLA_DEFINITION_SLA_NAME__UN UNIQUE
(
  SLA_NAME
)
;

CREATE TABLE D_SLA_PROJECT
  (
    D_SLA_PROJECT_ID               NUMBER (19) NOT NULL ,
    D_PROJECT_ID                   NUMBER (19) NOT NULL ,
    D_PROGRAM_ID                   NUMBER (19) NOT NULL ,
    D_GEOGRAPHY_MASTER_ID          NUMBER (19) NOT NULL ,
    D_SLA_DEFINITION_ID            NUMBER (19) NOT NULL ,
    FREQUENCY                      VARCHAR2 (50) ,
    PROJECT_SLA_LABEL              VARCHAR2 (255) ,
    REFERENCE_VALUE_CALC_DESC      VARCHAR2 (255) ,
    REFERENCE_VALUE_DESC           VARCHAR2 (255) ,
    PRIMARY_METRIC_DEFN_ID         NUMBER ,
    PRIMARY_METRIC_THRESHOLD_LOW   NUMBER (19,6) ,
    PRIMARY_METRIC_THRESHOLD_HIGH  NUMBER (19,6) ,
    SECONDARY_METRIC_DEFN_ID       NUMBER ,
    SECONDRY_METRIC_THRESHOLD_LOW  NUMBER (19,6) ,
    SECONDRY_METRIC_THRESHOLD_HIGH NUMBER (19,6) ,
    SORT_ORDER                     NUMBER (6) ,
    SORT_ID                        VARCHAR2 (50) ,
    START_DATE                     DATE ,
    END_DATE                       DATE ,
    CREATE_DATE                    DATE ,
    CREATED_BY                     VARCHAR2 (50) ,
    LAST_MODIFIED_DATE             DATE ,
    UPDATED_BY                     VARCHAR2 (50)
  )
  TABLESPACE MOTS_DATA LOGGING ENABLE ROW MOVEMENT ;
CREATE INDEX D_SLA_PROJECT__IDXv2 ON D_SLA_PROJECT
  (
    D_SLA_DEFINITION_ID ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
CREATE INDEX D_SLA_PROJECT__IDXv3 ON D_SLA_PROJECT
  (
    D_PROJECT_ID ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
CREATE INDEX D_SLA_PROJECT__IDXv4 ON D_SLA_PROJECT
  (
    D_PROGRAM_ID ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
CREATE INDEX D_SLA_PROJECT__IDXv5 ON D_SLA_PROJECT
  (
    START_DATE DESC ,
    END_DATE DESC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
ALTER TABLE D_SLA_PROJECT ADD CONSTRAINT D_SLA_PROJECT_PK PRIMARY KEY
(
  D_SLA_PROJECT_ID
)
;
ALTER TABLE D_SLA_PROJECT ADD CONSTRAINT D_SLA_PROJECT__UN UNIQUE
(
  D_PROJECT_ID , D_PROGRAM_ID , D_GEOGRAPHY_MASTER_ID , D_SLA_DEFINITION_ID , START_DATE , SORT_ID
)
;

CREATE TABLE F_METRIC
  (
    F_METRIC_ID                   NUMBER (19) NOT NULL ,
    D_METRIC_PROJECT_ID           NUMBER (19) NOT NULL ,
    D_REPORTING_PERIOD_ID         NUMBER (19) NOT NULL ,
    APPROVED                      VARCHAR2 (50) ,
    APPROVED_DATE                 DATE ,
    ACTUAL_VALUE                  NUMBER (19,6) ,
    ACTUAL_RECEIVED_DATE          DATE ,
    ACTUAL_TREND_INDICATOR        NUMBER (1) ,
    ACTUAL_FORECAST_VARIANCE_FRMT NUMBER (1) ,
    FORECAST_VALUE                NUMBER (19,6) ,
    FORECAST_RECEIVED_DATE        DATE ,
    TARGET_VALUE                  NUMBER (19,6) ,
    TARGET_RECEIVED_DATE          DATE ,
    COMMENTS                      VARCHAR2 (4000) ,
    FORECAST_COMMENTS             VARCHAR2 (4000) ,
    TARGET_COMMENTS               VARCHAR2 (4000) ,
    CREATE_DATE                   DATE ,
    CREATED_BY                    VARCHAR2 (50) ,
    LAST_MODIFIED_DATE            DATE ,
    UPDATED_BY                    VARCHAR2 (50)
  )
  TABLESPACE MOTS_DATA LOGGING ENABLE ROW MOVEMENT ;
CREATE INDEX F_METRIC__IDXv2 ON F_METRIC
  (
    D_METRIC_PROJECT_ID ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
CREATE INDEX F_METRIC__IDXv3 ON F_METRIC
  (
    D_REPORTING_PERIOD_ID ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
ALTER TABLE F_METRIC ADD CONSTRAINT F_METRIC_PK PRIMARY KEY
(
  F_METRIC_ID
)
;
ALTER TABLE F_METRIC ADD CONSTRAINT F_METRIC__UN UNIQUE
(
  D_METRIC_PROJECT_ID , D_REPORTING_PERIOD_ID
)
;

CREATE TABLE F_SERVICE_LEVEL_AGREEMENT
  (
    F_SLA_ID              NUMBER (19) NOT NULL ,
    D_SLA_PROJECT_ID      NUMBER (19) NOT NULL ,
    D_REPORTING_PERIOD_ID NUMBER (19) NOT NULL ,
    COMPLIANCE_RESULT     NUMBER (1) ,
    REFERENCE_VALUE       NUMBER (19,6) ,
    COMPLIANCE_COMMENTS   VARCHAR2 (240) ,
    CREATE_DATE           DATE ,
    CREATED_BY            VARCHAR2 (50) ,
    LAST_MODIFIED_DATE    DATE ,
    UPDATED_BY            VARCHAR2 (50)
  )
  TABLESPACE MOTS_DATA LOGGING ENABLE ROW MOVEMENT ;
CREATE INDEX F_SERVICE_LEVEL_AGREEMENT_IDX ON F_SERVICE_LEVEL_AGREEMENT
  (
    D_SLA_PROJECT_ID ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
CREATE INDEX F_SERVICE_LEVEL_AGREEMENT_IX ON F_SERVICE_LEVEL_AGREEMENT
  (
    D_REPORTING_PERIOD_ID ASC
  )
  TABLESPACE MOTS_INDEX LOGGING ;
ALTER TABLE F_SERVICE_LEVEL_AGREEMENT ADD CONSTRAINT F_SERVICE_LEVEL_AGREEMENT_PK PRIMARY KEY
(
  F_SLA_ID
)
;
ALTER TABLE F_SERVICE_LEVEL_AGREEMENT ADD CONSTRAINT F_SERVICE_LEVEL_AGREEMENT__UN UNIQUE
(
  D_SLA_PROJECT_ID , D_REPORTING_PERIOD_ID
)
;

ALTER TABLE D_CONTROL_CHART_PARAMETERS ADD CONSTRAINT D_CCP_METRIC_PROJ_FK FOREIGN KEY ( D_METRIC_PROJECT_ID ) REFERENCES D_METRIC_PROJECT ( D_METRIC_PROJECT_ID ) NOT DEFERRABLE ;

ALTER TABLE D_DIVISION ADD CONSTRAINT D_DIVISION_SEGMENT_FK FOREIGN KEY ( D_SEGMENT_ID ) REFERENCES D_SEGMENT ( D_SEGMENT_ID ) NOT DEFERRABLE ;

ALTER TABLE D_PROJECT ADD CONSTRAINT D_PROJECT_D_DIVISION_FK FOREIGN KEY ( D_DIVISION_ID ) REFERENCES D_DIVISION ( D_DIVISION_ID ) NOT DEFERRABLE ;

ALTER TABLE D_SLA_PROJECT ADD CONSTRAINT D_SLA_PROJECT_D_GEO_MASTER_FK FOREIGN KEY ( D_GEOGRAPHY_MASTER_ID ) REFERENCES D_GEOGRAPHY_MASTER ( D_GEOGRAPHY_MASTER_ID ) NOT DEFERRABLE ;

ALTER TABLE D_SLA_PROJECT ADD CONSTRAINT D_SLA_PROJECT_D_PROGRAM_FK FOREIGN KEY ( D_PROGRAM_ID ) REFERENCES D_PROGRAM ( D_PROGRAM_ID ) NOT DEFERRABLE ;

ALTER TABLE D_SLA_PROJECT ADD CONSTRAINT D_SLA_PROJECT_D_PROJECT_FK FOREIGN KEY ( D_PROJECT_ID ) REFERENCES D_PROJECT ( D_PROJECT_ID ) NOT DEFERRABLE ;

ALTER TABLE D_SLA_PROJECT ADD CONSTRAINT D_SLA_PROJECT_D_SLA_DEFN_FK FOREIGN KEY ( D_SLA_DEFINITION_ID ) REFERENCES D_SLA_DEFINITION ( D_SLA_DEFINITION_ID ) NOT DEFERRABLE ;

ALTER TABLE F_METRIC ADD CONSTRAINT F_METRIC__METRIC_PROJ_FK FOREIGN KEY ( D_METRIC_PROJECT_ID ) REFERENCES D_METRIC_PROJECT ( D_METRIC_PROJECT_ID ) NOT DEFERRABLE ;

ALTER TABLE F_METRIC ADD CONSTRAINT F_METRIC__RPT_PERIOD_FK FOREIGN KEY ( D_REPORTING_PERIOD_ID ) REFERENCES D_REPORTING_PERIOD ( D_REPORTING_PERIOD_ID ) NOT DEFERRABLE ;

ALTER TABLE F_SERVICE_LEVEL_AGREEMENT ADD CONSTRAINT F_SLA_D_REPORTING_PERIOD_FK FOREIGN KEY ( D_REPORTING_PERIOD_ID ) REFERENCES D_REPORTING_PERIOD ( D_REPORTING_PERIOD_ID ) NOT DEFERRABLE ;

ALTER TABLE F_SERVICE_LEVEL_AGREEMENT ADD CONSTRAINT F_SLA_D_SLA_PROJECT_FK FOREIGN KEY ( D_SLA_PROJECT_ID ) REFERENCES D_SLA_PROJECT ( D_SLA_PROJECT_ID ) NOT DEFERRABLE ;

ALTER TABLE D_METRIC_DEFINITION ADD CONSTRAINT METRIC_DEF__DATA_TYPE_FK FOREIGN KEY ( D_DATA_TYPE_ID ) REFERENCES D_DATA_TYPE ( D_DATA_TYPE_ID ) NOT DEFERRABLE ;

ALTER TABLE D_METRIC_PROJECT ADD CONSTRAINT METRIC_PROJ_GEO_MASTER_FK FOREIGN KEY ( D_GEOGRAPHY_MASTER_ID ) REFERENCES D_GEOGRAPHY_MASTER ( D_GEOGRAPHY_MASTER_ID ) NOT DEFERRABLE ;

ALTER TABLE D_METRIC_PROJECT ADD CONSTRAINT METRIC_PROJ_PROGRAM_FK FOREIGN KEY ( D_PROGRAM_ID ) REFERENCES D_PROGRAM ( D_PROGRAM_ID ) NOT DEFERRABLE ;

ALTER TABLE D_METRIC_PROJECT ADD CONSTRAINT METRIC_PROJ__METRIC_DEF_FK FOREIGN KEY ( D_METRIC_DEFINITION_ID ) REFERENCES D_METRIC_DEFINITION ( D_METRIC_DEFINITION_ID ) NOT DEFERRABLE ;

ALTER TABLE D_METRIC_PROJECT ADD CONSTRAINT METRIC_PROJ__PROJECT_FK FOREIGN KEY ( D_PROJECT_ID ) REFERENCES D_PROJECT ( D_PROJECT_ID ) NOT DEFERRABLE ;

CREATE OR REPLACE VIEW D_DATA_TYPE_SV  AS
SELECT D_DATA_TYPE.* FROM D_DATA_TYPE ;




CREATE OR REPLACE VIEW D_DIVISION_SV  AS
SELECT D_DIVISION.* FROM D_DIVISION ;




CREATE OR REPLACE VIEW D_GEOGRAPHY_MASTER_SV  AS
SELECT D_GEOGRAPHY_MASTER.* FROM D_GEOGRAPHY_MASTER ;




CREATE OR REPLACE VIEW D_METRIC_DEFINITION_SV  AS
SELECT D_METRIC_DEFINITION.* FROM D_METRIC_DEFINITION ;




CREATE OR REPLACE VIEW D_METRIC_PROJECT_SV  AS
SELECT D_METRIC_PROJECT.* FROM D_METRIC_PROJECT ;




CREATE OR REPLACE VIEW D_PROGRAM_SV  AS
SELECT D_PROGRAM.* FROM D_PROGRAM ;




CREATE OR REPLACE VIEW D_PROJECT_SV  AS
SELECT D_PROJECT.* FROM D_PROJECT ;




CREATE OR REPLACE VIEW D_REPORTING_PERIOD_SV  AS
SELECT D_REPORTING_PERIOD.* FROM D_REPORTING_PERIOD ;




CREATE OR REPLACE VIEW D_SEGMENT_SV  AS
SELECT D_SEGMENT.* FROM D_SEGMENT ;




CREATE OR REPLACE VIEW D_SLA_DEFINITION_SV  AS
SELECT D_SLA_DEFINITION.* FROM D_SLA_DEFINITION ;




CREATE OR REPLACE VIEW D_SLA_PROJECT_SV  AS
SELECT D_SLA_PROJECT.* FROM D_SLA_PROJECT ;




CREATE OR REPLACE VIEW F_METRIC_SV  AS
SELECT F_METRIC.* FROM F_METRIC ;




CREATE OR REPLACE VIEW F_SERVICE_LEVEL_AGREEMENT_SV  AS
SELECT F_SERVICE_LEVEL_AGREEMENT.* FROM F_SERVICE_LEVEL_AGREEMENT ;




CREATE OR REPLACE TRIGGER BIU_D_CONTROL_CHART_PARAMETERS 
    BEFORE INSERT OR UPDATE ON D_CONTROL_CHART_PARAMETERS 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.D_CONTROL_CHART_ID IS NULL THEN 
  SELECT SEQ_D_CONTROL_CHART.NEXTVAL INTO :NEW.D_CONTROL_CHART_ID FROM DUAL;    
	:NEW.CREATE_DATE := SYSDATE;  
	:NEW.CREATED_BY := USER;
END IF;
:NEW.UPDATED_BY := USER;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END; 
/



CREATE OR REPLACE TRIGGER BIU_D_DATA_TYPE 
    BEFORE INSERT OR UPDATE ON D_DATA_TYPE 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.D_DATA_TYPE_ID IS NULL THEN 
          SELECT SEQ_D_DATA_TYPE.NEXTVAL INTO :NEW.D_DATA_TYPE_ID FROM DUAL;
	:NEW.CREATE_DATE := SYSDATE;  
	:NEW.CREATED_BY := USER;
END IF;
:NEW.UPDATED_BY := USER;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END; 
/



CREATE OR REPLACE TRIGGER BIU_D_DIVISION 
    BEFORE INSERT OR UPDATE ON D_DIVISION 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.D_DIVISION_ID IS NULL THEN 
          SELECT SEQ_D_DIVISION.NEXTVAL INTO :NEW.D_DIVISION_ID FROM DUAL;
	:NEW.CREATE_DATE := SYSDATE;  
END IF;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END;  
/



CREATE OR REPLACE TRIGGER BIU_D_GEO_MASTER 
    BEFORE INSERT OR UPDATE ON D_GEOGRAPHY_MASTER 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.D_GEOGRAPHY_MASTER_ID IS NULL THEN 
          SELECT SEQ_D_GEO_MASTER.NEXTVAL INTO :NEW.D_GEOGRAPHY_MASTER_ID FROM DUAL;
	:NEW.CREATE_DATE := SYSDATE;  
END IF;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END;  
/



CREATE OR REPLACE TRIGGER BIU_D_METRIC_DEFINITION 
    BEFORE INSERT OR UPDATE ON D_METRIC_DEFINITION 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.D_METRIC_DEFINITION_ID IS NULL THEN 
	SELECT SEQ_D_METRIC_DEFINITION.NEXTVAL INTO :NEW.D_METRIC_DEFINITION_ID FROM DUAL;
	:NEW.CREATE_DATE := SYSDATE;  
	:NEW.CREATED_BY := USER;
END IF;
:NEW.UPDATED_BY := USER;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END; 
/



CREATE OR REPLACE TRIGGER BIU_D_METRIC_PROJECT 
    BEFORE INSERT OR UPDATE ON D_METRIC_PROJECT 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.D_METRIC_PROJECT_ID IS NULL THEN 
	SELECT SEQ_D_METRIC_PROJECT.NEXTVAL INTO :NEW.D_METRIC_PROJECT_ID FROM DUAL;
	:NEW.CREATE_DATE := SYSDATE;  
	:NEW.CREATED_BY := USER;
END IF;
:NEW.UPDATED_BY := USER;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END; 
/



CREATE OR REPLACE TRIGGER BIU_D_PROGRAM 
    BEFORE INSERT OR UPDATE ON D_PROGRAM 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.D_PROGRAM_ID IS NULL THEN 
          SELECT SEQ_D_PROGRAM.NEXTVAL INTO :NEW.D_PROGRAM_ID FROM DUAL;
	:NEW.CREATE_DATE := SYSDATE;  
END IF;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END;  
/



CREATE OR REPLACE TRIGGER BIU_D_PROJECT 
    BEFORE INSERT OR UPDATE ON D_PROJECT 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.D_PROJECT_ID IS NULL THEN 
          SELECT SEQ_D_PROJECT.NEXTVAL INTO :NEW.D_PROJECT_ID FROM DUAL;
	:NEW.CREATE_DATE := SYSDATE;  
END IF;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END;  
/



CREATE OR REPLACE TRIGGER BIU_D_REPORTING_PERIOD 
    BEFORE INSERT OR UPDATE ON D_REPORTING_PERIOD 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.D_REPORTING_PERIOD_ID IS NULL THEN 
          SELECT SEQ_D_REPORTING_PERIOD.NEXTVAL INTO :NEW.D_REPORTING_PERIOD_ID FROM DUAL;    
	:NEW.CREATE_DATE := SYSDATE;  
	:NEW.CREATED_BY := USER;
END IF;
:NEW.UPDATED_BY := USER;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END; 
/



CREATE OR REPLACE TRIGGER BIU_D_SEGMENT 
    BEFORE INSERT OR UPDATE ON D_SEGMENT 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.D_SEGMENT_ID IS NULL THEN 
          SELECT SEQ_D_SEGMENT.NEXTVAL INTO :NEW.D_SEGMENT_ID FROM DUAL;
	:NEW.CREATE_DATE := SYSDATE;  
END IF;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END;  
/



CREATE OR REPLACE TRIGGER BIU_D_SLA_DEFINITION 
    BEFORE INSERT OR UPDATE ON D_SLA_DEFINITION 
    FOR EACH ROW 
    ENABLE 
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



CREATE OR REPLACE TRIGGER BIU_D_SLA_PROJECT 
    BEFORE INSERT OR UPDATE ON D_SLA_PROJECT 
    FOR EACH ROW 
    ENABLE 
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



CREATE OR REPLACE TRIGGER BIU_F_METRIC 
    BEFORE INSERT OR UPDATE ON F_METRIC 
    FOR EACH ROW 
    ENABLE 
BEGIN
IF INSERTING AND :NEW.F_METRIC_ID IS NULL THEN 
          SELECT SEQ_F_METRIC.NEXTVAL INTO :NEW.F_METRIC_ID FROM DUAL;
	:NEW.CREATE_DATE := SYSDATE;
	:NEW.CREATED_BY := USER;
END IF;
:NEW.UPDATED_BY := USER;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END;

 
/



CREATE OR REPLACE TRIGGER BIU_F_SLA 
    BEFORE INSERT OR UPDATE ON F_SERVICE_LEVEL_AGREEMENT 
    FOR EACH ROW 
    ENABLE 
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




-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                            21
-- ALTER TABLE                             48
-- CREATE VIEW                             13
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                          14
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                         16
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
