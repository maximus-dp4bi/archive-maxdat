
ALTER TABLE D_METRIC_DEFINITION MODIFY (D_DATA_TYPE_ID NUMERIC(19,0) DEFAULT 2);

ALTER TABLE D_METRIC_DEFINITION ADD	DATA_SOURCE VARCHAR(50);
ALTER TABLE D_METRIC_DEFINITION ADD	DESCRIPTION VARCHAR(4000);
ALTER TABLE D_METRIC_DEFINITION ADD	FORMULA VARCHAR(250);
ALTER TABLE D_METRIC_DEFINITION ADD	HELPFUL_INFO VARCHAR(4000);
ALTER TABLE D_METRIC_DEFINITION ADD	EXAMPLE VARCHAR(4000);
ALTER TABLE D_METRIC_DEFINITION ADD	LOWER_BOUND NUMBER(18,2);
ALTER TABLE D_METRIC_DEFINITION ADD	UPPER_BOUND NUMBER(18,2);


ALTER TABLE D_METRIC_PROJECT ADD IS_AUTO_LOAD VARCHAR(1);