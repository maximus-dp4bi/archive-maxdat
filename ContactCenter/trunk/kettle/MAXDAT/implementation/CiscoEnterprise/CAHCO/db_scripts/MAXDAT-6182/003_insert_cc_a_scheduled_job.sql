INSERT INTO CC_A_SCHEDULED_JOB (SCHEDULED_JOB_TYPE, START_DATETIME_PARAM, END_DATETIME_PARAM, JOB_START_DATE, JOB_END_DATE, SUCCESS) 
VALUES ('load_call_back','2018-06-14 00:00:00','2018-06-15 00:00:00', to_date('2018-06-147 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2018-06-15 01:00:00', 'YYYY-MM-DD HH24:MI:SS'),1);

COMMIT;