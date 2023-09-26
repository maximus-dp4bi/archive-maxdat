
CREATE SEQUENCE SEQ_D_PROJECT_ROLE START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

ALTER TABLE D_METRIC_DEFINITION MODIFY (HELPFUL_INFO VARCHAR2 (4000 CHAR));

ALTER TABLE D_METRIC_DEFINITION_AUD MODIFY (HELPFUL_INFO VARCHAR2 (4000 CHAR));

ALTER TABLE D_METRIC_DEFINITION MODIFY (FORMULA VARCHAR2 (250 CHAR));

ALTER TABLE D_METRIC_DEFINITION_AUD MODIFY (FORMULA VARCHAR2 (250 CHAR));

ALTER TABLE D_METRIC_DEFINITION MODIFY (DATA_SOURCE VARCHAR2 (250 CHAR));

ALTER TABLE D_METRIC_DEFINITION_AUD MODIFY (DATA_SOURCE VARCHAR2 (250 CHAR));

UPDATE D_METRIC_DEFINITION SET DESCRIPTION = LABEL WHERE DESCRIPTION IS NULL;

COMMIT;