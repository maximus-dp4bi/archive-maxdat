INSERT INTO CC_A_SCHEDULE (JOB_TYPE, EXECUTION_TIME) VALUES('load_production_planning','09:00:00');
INSERT INTO CC_A_SCHEDULE (JOB_TYPE, EXECUTION_TIME) VALUES('load_production_planning','13:00:00');
INSERT INTO CC_A_SCHEDULE (JOB_TYPE, EXECUTION_TIME) VALUES('load_production_planning','16:00:00');
INSERT INTO CC_A_SCHEDULE (JOB_TYPE, EXECUTION_TIME) VALUES('load_production_planning','21:00:00');
INSERT INTO CC_A_SCHEDULE (JOB_TYPE, EXECUTION_TIME) VALUES('load_contact_center','03:00:00');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.1.6','103','103_INSERT_CC_A_SCHEDULE');

COMMIT;