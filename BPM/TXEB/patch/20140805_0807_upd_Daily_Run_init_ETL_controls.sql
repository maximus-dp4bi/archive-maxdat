-- TXEB-2984

UPDATE corp_etl_control
SET name = 'RUN_DAILY_MASTER_START'
where name = 'RUNINIT_DAILY_SCHEDULE_START';

UPDATE corp_etl_control
SET name = 'RUN_DAILY_MASTER_END'
where name = 'RUNINIT_DAILY_SCHEDULE_END';

UPDATE corp_etl_control
SET name = 'RUN_DAILY_LETTERS_START', value = REPLACE(value,':','')
where name = 'RUN_LETTER_STARTTIME';

UPDATE corp_etl_control
SET name = 'RUN_DAILY_LETTERS_END',value = REPLACE(value,':','')
where name = 'RUN_LETTER_ENDTIME';

UPDATE corp_etl_control
SET name = 'RUN_DAILY_CLIENT_OUTREACH_START',value = REPLACE(value,':','')
where name = 'CO_RUN_START_TIME';

UPDATE corp_etl_control
SET name = 'RUN_DAILY_CLIENT_OUTREACH_END',value = REPLACE(value,':','')
where name = 'CO_RUN_END_TIME';

COMMIT;