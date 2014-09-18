-- TXEB-2984 new daily Run Init

insert into corp_etl_control (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
values ('RUNINIT_DAILY_SCHEDULE_START', 'V', '200000', 'Daily Run Init scheduling START date. Initially for TXEB. Represents the hour and minute value on 24-hour format.', SYSDATE, SYSDATE);

insert into corp_etl_control (NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
values ('RUNINIT_DAILY_SCHEDULE_END', 'V', '060000', 'Daily Run Init scheduling END date. Initially for TXEB. Represents the hour and minute value on 24-hour format.', SYSDATE, SYSDATE);

commit;
