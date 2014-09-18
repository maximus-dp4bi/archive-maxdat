/*
v1 Scott Allison 25-Sep-2012 Initial creation
v2 Raj A.        07-DEC-2012 Added 'STRW_AUTO_CLOSED_BY' and 'STRW_AUTO_REJECTED_BY'. 

Description:
This script creates the Global control values for the State Review process only.
*/
-- Script to insert the control variables if they do not exist into corp_etl_control
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'STATE_REVIEW_CAPTURE_DATE', 'D', '2012/11/24 09:13:07', 'This is where State Review will start and is updated from state review', SYSDATE, SYSDATE from dual
WHERE  'STATE_REVIEW_CAPTURE_DATE' NOT IN (SELECT name FROM corp_etl_control)

insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'STATE_REVIEW_LOOK_BACK_DAYS', 'N', '31', 'The event table will look at this table to see when to start and also update', SYSDATE, SYSDATE from dual
WHERE  'STATE_REVIEW_LOOK_BACK_DAYS' NOT IN (SELECT name FROM corp_etl_control)

insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'STATE_REVIEW_LAST_STEP_HIST_ID', 'N', '0', 'This History ID which will be used for the search > than', SYSDATE, SYSDATE from dual
where  'STATE_REVIEW_LAST_STEP_HIST_ID' NOT IN (SELECT name FROM corp_etl_control)


insert into corp_etl_list_lkup
(
name,
list_type,
value,
out_var,
ref_type,
ref_id,
start_date,
end_date,
comments,
created_ts,
updated_ts
)
values
(
'STRW_AUTO_CLOSED_BY',
'LIST',
'-455',
'STAFF',
'STAFF_ID',
'-455',
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the staff_id who can Auto-Close the State Review Task. This is used by the Process State Review.',
sysdate,
sysdate
);
commit;

insert into corp_etl_list_lkup
(
name,
list_type,
value,
out_var,
ref_type,
ref_id,
start_date,
end_date,
comments,
created_ts,
updated_ts
)
values
(
'STRW_AUTO_REJECTED_BY',
'LIST',
'-800',
'STAFF',
'STAFF_ID',
'-800',
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the staff_id who can Auto-Reject the State Review Task. This is used by the Process State Review.',
sysdate,
sysdate
);
commit;