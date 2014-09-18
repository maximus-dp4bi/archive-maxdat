
ALTER TABLE S_METRIC_TEMPLATE MODIFY (METRIC VARCHAR(100));

ALTER TABLE S_METRIC_DEFINITION MODIFY (METRIC VARCHAR(100), LABEL VARCHAR(100));

ALTER TABLE D_METRIC_DEFINITION MODIFY (NAME VARCHAR(100), LABEL VARCHAR(100));


ALTER TABLE D_METRIC_DEFINITION ADD (
  SORT_ORDER NUMBER(6,0)
  , SUB_CATEGORY VARCHAR(50)
  , DISPLAY_FORMAT VARCHAR(50)
  , HAS_ACTUAL VARCHAR(50)
  , IS_WEEKLY VARCHAR(50)
  , IS_MONTHLY VARCHAR(50)
);

ALTER TABLE S_METRIC_DEFINITION ADD (
  SORT_ORDER NUMBER(6,0)
  , SUB_CATEGORY VARCHAR(50)
  , DISPLAY_FORMAT VARCHAR(50)
  , HAS_ACTUAL VARCHAR(50)
  , IS_WEEKLY VARCHAR(50)
  , IS_MONTHLY VARCHAR(50)
);


ALTER TABLE S_METRIC_TEMPLATE ADD (
  FORECAST_COMMENTS VARCHAR(4000)
  , TARGET_COMMENTS VARCHAR(4000)
  , TARGET_VALUE NUMBER(19,2)
  , IS_FORECAST VARCHAR(1)
  , IS_ACTUAL VARCHAR(1)
);



ALTER TABLE F_METRIC ADD (
  FORECAST_COMMENTS VARCHAR(4000)
  , TARGET_COMMENTS VARCHAR(4000)
);


ALTER TABLE D_DIVISION 
    ADD CONSTRAINT D_DIVISION__UN UNIQUE ( DIVISION_NAME ) ;


ALTER TABLE D_METRIC_DEFINITION 
    ADD CONSTRAINT D_METRIC_DEFINITION_NAME__UN UNIQUE ( NAME ) ;


ALTER TABLE D_PROGRAM 
    ADD CONSTRAINT D_PROGRAM__UN UNIQUE ( PROGRAM_NAME ) ;


ALTER TABLE D_PROJECT 
    ADD CONSTRAINT D_PROJECT__UN UNIQUE ( PROJECT_NAME ) ;


ALTER TABLE D_REPORTING_PERIOD 
    DROP CONSTRAINT D_REPORTING_PERIOD__UN ;

ALTER TABLE D_REPORTING_PERIOD 
    ADD CONSTRAINT D_REPORTING_PERIOD__UN UNIQUE ( START_DATE , END_DATE ) ;


ALTER TABLE D_SEGMENT 
    ADD CONSTRAINT D_SEGMENT__UN UNIQUE ( SEGMENT_NAME ) ;



CREATE OR REPLACE VIEW D_METRIC_DEFINITION_SV AS
SELECT D_METRIC_DEFINITION.* FROM D_METRIC_DEFINITION ;


CREATE OR REPLACE VIEW F_METRIC_SV AS
SELECT F_METRIC.* FROM F_METRIC ;

SELECT SEQ_D_METRIC_DEFINITION.NEXTVAL FROM D_METRIC_DEFINITION;

SELECT seq_d_metric_project.nextval FROM D_METRIC_PROJECT;


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
VALUES ('2.3','001','001_ALTER_METRIC_TABLES');



COMMIT;
