
INSERT INTO CC_A_ADHOC_JOB (START_DATETIME, END_DATETIME) VALUES ('2013-10-18 00:00:00','2013-10-19 00:00:00');
INSERT INTO CC_A_ADHOC_JOB (START_DATETIME, END_DATETIME) VALUES ('2013-10-22 00:00:00','2013-10-23 00:00:00');

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.1.3.2','002','002_INSERT_CC_A_ADHOC_JOB');

COMMIT;