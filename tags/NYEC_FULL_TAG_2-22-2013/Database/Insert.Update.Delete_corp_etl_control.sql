-- insert the variable with a value used to fill events.
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'CC_EVENT_STG_CAPTURE_DATE', 'N', '90', 'The event table will look at this table to see when to start and also update', SYSDATE, SYSDATE from dual
WHERE  'CC_EVENT_STG_CAPTURE_DATE' NOT IN (SELECT name FROM corp_etl_control);

-- update the value used to fill events
update corp_etl_control SET value = '90' where name = 'CC_EVENT_STG_CAPTURE_DATE';


-- Used to select value used to fill events.
SELECT Value FROM corp_etl_control where name = 'CC_EVENT_STG_CAPTURE_DATE';

-- insert the variable with a value used to fill events by last event id.
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'CC_EVENT_STG_CAPTURE_EVENT_ID', 'D', '0', 'The event table will look at this table to see when to start and also update by event id', SYSDATE, SYSDATE from dual
WHERE  'CC_EVENT_STG_CAPTURE_EVENT_ID' NOT IN (SELECT name FROM corp_etl_control);

-- update the value used to fill events
update corp_etl_control SET value = '67553959' where name = 'CC_EVENT_STG_CAPTURE_EVENT_ID';


-- Used to select value used to fill events.
SELECT Value FROM corp_etl_control where name = 'CC_EVENT_STG_CAPTURE_EVENT_ID';

commit;

