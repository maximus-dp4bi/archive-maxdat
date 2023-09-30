-- Script to insert the control variables if they do not exist into corp_etl_control
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'STATE_REVIEW_CAPTURE_DATE', 'D', '2012/08/24 09:13:07', 'This is where State Review will start and is updated from state review', SYSDATE, SYSDATE from dual
WHERE  'STATE_REVIEW_CAPTURE_DATE' NOT IN (SELECT name FROM corp_etl_control)

insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'STATE_REVIEW_LOOK_BACK_DAYS', 'N', '30', 'The event table will look at this table to see when to start and also update', SYSDATE, SYSDATE from dual
WHERE  'STATE_REVIEW_LOOK_BACK_DAYS' NOT IN (SELECT name FROM corp_etl_control)

insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'STATE_REVIEW_LAST_STEP_HIST_ID', 'N', '0', 'This History ID which will be used for the search > than', SYSDATE, SYSDATE from dual
where  'STATE_REVIEW_LAST_STEP_HIST_ID' NOT IN (SELECT name FROM corp_etl_control)
