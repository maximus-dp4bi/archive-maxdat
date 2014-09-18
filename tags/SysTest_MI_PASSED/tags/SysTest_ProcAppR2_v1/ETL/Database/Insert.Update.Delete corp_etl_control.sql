-- insert the variable with a value used to fill events.
insert into corp_etl_control 
VALUES ('CC_EVENT_STG_CAPTURE_DATE', 'D', '08/13/2012', 'The event table will look at this table to see when to start and also update', SYSDATE, SYSDATE)

-- update the value used to fill events
update corp_etl_control SET value = '2012/07/12 01:01:01' where name = 'CC_EVENT_STG_CAPTURE_DATE'


-- Used to select value used to fill events.
SELECT Value FROM corp_etl_control where name = 'CC_EVENT_STG_CAPTURE_DATE'