
INSERT INTO CC_A_ADHOC_JOB (START_DATETIME_PARAM, END_DATETIME_PARAM, ADHOC_JOB_TYPE) 
VALUES ( '2014-03-01 00:00:00', '2014-03-09 00:00:00', 'load_contact_center'); 
INSERT INTO CC_A_ADHOC_JOB (START_DATETIME_PARAM, END_DATETIME_PARAM, ADHOC_JOB_TYPE) 
VALUES ( '2014-03-09 00:00:00', '2014-03-10 00:00:00', 'load_contact_center'); 
INSERT INTO CC_A_ADHOC_JOB (START_DATETIME_PARAM, END_DATETIME_PARAM, ADHOC_JOB_TYPE) 
VALUES ( '2014-03-10 00:00:00', '2014-03-16 00:00:00', 'load_contact_center'); 
INSERT INTO CC_A_ADHOC_JOB (START_DATETIME_PARAM, END_DATETIME_PARAM, ADHOC_JOB_TYPE) 
VALUES ( '2014-03-16 00:00:00', '2014-03-23 00:00:00', 'load_contact_center'); 
INSERT INTO CC_A_ADHOC_JOB (START_DATETIME_PARAM, END_DATETIME_PARAM, ADHOC_JOB_TYPE) 
VALUES ( '2014-03-23 00:00:00', '2014-03-30 00:00:00', 'load_contact_center'); 
INSERT INTO CC_A_ADHOC_JOB (START_DATETIME_PARAM, END_DATETIME_PARAM, ADHOC_JOB_TYPE) 
VALUES ( '2014-03-30 00:00:00', '2014-04-06 00:00:00', 'load_contact_center'); 
INSERT INTO CC_A_ADHOC_JOB (START_DATETIME_PARAM, END_DATETIME_PARAM, ADHOC_JOB_TYPE) 
VALUES ( '2014-04-06 00:00:00', '2014-04-13 00:00:00', 'load_contact_center'); 
INSERT INTO CC_A_ADHOC_JOB (START_DATETIME_PARAM, END_DATETIME_PARAM, ADHOC_JOB_TYPE) 
VALUES ( '2014-04-13 00:00:00', '2014-04-20 00:00:00', 'load_contact_center'); 
INSERT INTO CC_A_ADHOC_JOB (START_DATETIME_PARAM, END_DATETIME_PARAM, ADHOC_JOB_TYPE) 
VALUES ( '2014-04-20 00:00:00', '2014-04-27 00:00:00', 'load_contact_center'); 
INSERT INTO CC_A_ADHOC_JOB (START_DATETIME_PARAM, END_DATETIME_PARAM, ADHOC_JOB_TYPE) 
VALUES ( '2014-04-27 00:00:00', '2014-05-04 00:00:00', 'load_contact_center'); 
INSERT INTO CC_A_ADHOC_JOB (START_DATETIME_PARAM, END_DATETIME_PARAM, ADHOC_JOB_TYPE) 
VALUES ( '2014-05-04 00:00:00', '2014-05-11 00:00:00', 'load_contact_center'); 
INSERT INTO CC_A_ADHOC_JOB (START_DATETIME_PARAM, END_DATETIME_PARAM, ADHOC_JOB_TYPE) 
VALUES ( '2014-05-11 00:00:00', '2014-05-18 00:00:00', 'load_contact_center'); 
INSERT INTO CC_A_ADHOC_JOB (START_DATETIME_PARAM, END_DATETIME_PARAM, ADHOC_JOB_TYPE) 
VALUES ( '2014-05-18 00:00:00', '2014-05-22 00:00:00', 'load_contact_center'); 

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.4.1','001','001_INSERT_ADHOC_JOBS');

COMMIT; 