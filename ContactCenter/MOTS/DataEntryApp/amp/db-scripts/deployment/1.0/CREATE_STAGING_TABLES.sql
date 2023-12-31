
CREATE SEQUENCE SEQ_S_METRIC ;
CREATE SEQUENCE SEQ_S_PROJECT_REPORT START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 20 ;


CREATE TABLE S_PROJECT_REPORT
  (
    S_PROJECT_REPORT_ID        NUMBER (19) NOT NULL ,
    D_PROJECT_ID               NUMBER (19) NOT NULL ,
    D_PROGRAM_ID               NUMBER (19) NOT NULL ,
    D_GEOGRAPHY_MASTER_ID      NUMBER (19) NOT NULL ,
    D_REPORTING_PERIOD_ID      NUMBER (19) NOT NULL ,
    APPROVED                   VARCHAR2 (50) ,
    APPROVED_DATE              DATE ,
    REPORT_TYPE                VARCHAR2 (250) ,
    STATUS                     VARCHAR2 (50) ,
    IS_ACTUALS_TREND_PROCESSED VARCHAR2 (1) DEFAULT 'N' NOT NULL ,
    IS_FUTURE_TRENDS_PROCESSED VARCHAR2 (1) DEFAULT 'N' NOT NULL ,
    IS_ERROR                   VARCHAR2 (1) DEFAULT 'N' NOT NULL ,
    CREATE_DATE                DATE ,
    CREATED_BY                 VARCHAR2 (50) ,
    LAST_MODIFIED_DATE         DATE ,
    UPDATED_BY                 VARCHAR2 (50) ,
    FUNCTIONAL_AREA            VARCHAR2 (50)
  )
  LOGGING ;
CREATE INDEX S_PROJECT_REPORT__IDX ON S_PROJECT_REPORT
  (
    D_PROJECT_ID ASC
  )
  LOGGING ;
CREATE INDEX S_PROJECT_REPORT__IDXv1 ON S_PROJECT_REPORT
  (
    D_PROGRAM_ID ASC
  )
  LOGGING ;
CREATE INDEX S_PROJECT_REPORT__IDXv2 ON S_PROJECT_REPORT
  (
    D_GEOGRAPHY_MASTER_ID ASC
  )
  LOGGING ;
CREATE INDEX S_PROJECT_REPORT__IDXv3 ON S_PROJECT_REPORT
  (
    D_REPORTING_PERIOD_ID ASC
  )
  LOGGING ;
ALTER TABLE S_PROJECT_REPORT ADD CONSTRAINT S_PROJECT_REPORT_PK PRIMARY KEY ( S_PROJECT_REPORT_ID ) ;
ALTER TABLE S_PROJECT_REPORT ADD CONSTRAINT S_PROJECT_REPORT__UN UNIQUE ( D_PROJECT_ID , D_PROGRAM_ID , D_GEOGRAPHY_MASTER_ID , D_REPORTING_PERIOD_ID , REPORT_TYPE , FUNCTIONAL_AREA ) ;


CREATE TABLE S_METRIC
  (
    S_METRIC_ID                   NUMBER (19) NOT NULL ,
    D_METRIC_DEFINITION_ID        NUMBER (19) NOT NULL ,
    S_ACTUALS_PROJECT_REPORT_ID   NUMBER (19) ,
    S_FORECASTS_PROJECT_REPORT_ID NUMBER (19) ,
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
    UPDATED_BY                    VARCHAR2 (50) ,
    ACTUAL_VALUE_NOT_SUPPLIED     VARCHAR2 (1) ,
    FORECAST_VALUE_NOT_SUPPLIED   VARCHAR2 (1)
  )
  LOGGING ;
CREATE INDEX S_METRIC__IDX ON S_METRIC
  (
    D_METRIC_DEFINITION_ID ASC
  )
  LOGGING ;
CREATE INDEX S_METRIC__IDXv1 ON S_METRIC
  (
    S_ACTUALS_PROJECT_REPORT_ID ASC
  )
  LOGGING ;
CREATE INDEX S_METRIC__IDXv2 ON S_METRIC
  (
    S_FORECASTS_PROJECT_REPORT_ID ASC
  )
  LOGGING ;
ALTER TABLE S_METRIC ADD CONSTRAINT S_METRIC_PK PRIMARY KEY ( S_METRIC_ID ) ;
ALTER TABLE S_METRIC ADD CONSTRAINT S_METRIC_UN1 UNIQUE ( D_METRIC_DEFINITION_ID , S_ACTUALS_PROJECT_REPORT_ID , S_FORECASTS_PROJECT_REPORT_ID ) ;

ALTER TABLE S_METRIC ADD CONSTRAINT S_METRIC_D_ACTUALS_REPORT_FK FOREIGN KEY ( S_ACTUALS_PROJECT_REPORT_ID ) REFERENCES S_PROJECT_REPORT ( S_PROJECT_REPORT_ID ) NOT DEFERRABLE ;

ALTER TABLE S_METRIC ADD CONSTRAINT S_METRIC_D_FORECASTS_REPORT_FK FOREIGN KEY ( S_FORECASTS_PROJECT_REPORT_ID ) REFERENCES S_PROJECT_REPORT ( S_PROJECT_REPORT_ID ) NOT DEFERRABLE ;

ALTER TABLE S_METRIC ADD CONSTRAINT S_METRIC_D_METRIC_DEF_FK FOREIGN KEY ( D_METRIC_DEFINITION_ID ) REFERENCES D_METRIC_DEFINITION ( D_METRIC_DEFINITION_ID ) NOT DEFERRABLE ;

ALTER TABLE S_PROJECT_REPORT ADD CONSTRAINT D_PROJECT_REPORT_D_GEO_MSTR_FK FOREIGN KEY ( D_GEOGRAPHY_MASTER_ID ) REFERENCES D_GEOGRAPHY_MASTER ( D_GEOGRAPHY_MASTER_ID ) NOT DEFERRABLE ;

ALTER TABLE S_PROJECT_REPORT ADD CONSTRAINT D_PROJECT_REPORT_D_PROGRAM_FK FOREIGN KEY ( D_PROGRAM_ID ) REFERENCES D_PROGRAM ( D_PROGRAM_ID ) NOT DEFERRABLE ;

ALTER TABLE S_PROJECT_REPORT ADD CONSTRAINT D_PROJECT_REPORT_D_PROJECT_FK FOREIGN KEY ( D_PROJECT_ID ) REFERENCES D_PROJECT ( D_PROJECT_ID ) NOT DEFERRABLE ;

ALTER TABLE S_PROJECT_REPORT ADD CONSTRAINT D_PROJECT_REPORT_RPRTNG_PRD_FK FOREIGN KEY ( D_REPORTING_PERIOD_ID ) REFERENCES D_REPORTING_PERIOD ( D_REPORTING_PERIOD_ID ) NOT DEFERRABLE ;
