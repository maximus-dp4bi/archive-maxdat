/*
Created on 11-Jun-2013 by Raj A.
Team: MAXDAT.
Project: ICEB.
Business Process: Manage Enrollment Activity.

Description:

1.Inserts global controls into the corp_etl_list_lkup table.
Use below sql to find out what it is.

--Used in ManageEnroll_Fetch_Enrl_packets.ktr
 select out_var 
  from corp_etl_list_lkup
  WHERE  name = 'FIRST_ENROLLMENT_PACKET';
  
--Used in ManageEnroll_Fetch_First_FU_packets.ktr
 select out_var 
  from corp_etl_list_lkup
  WHERE  name = 'SECOND_ENROLLMENT_PACKET';
  
 --ManageEnroll_Fetch_Second_FU_packets.ktr 
  select out_var 
  from corp_etl_list_lkup
  WHERE  name = 'INITIAL_REMINDER_NOTICE';

2.Inserts global controls into the Rule_lkup_mng_enrl_followup table.
Used by the ManageEnroll_Apply_UPD_Rules_to_WIP.ktr

3.Inserts two global controls into the corp_etl_control.

*/
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
'FIRST_ENROLLMENT_PACKET', --name
'LETTER_TYPE',             --list_type
'IA - Mandatory Welcome Letter (ICP)', --value
'IAI',   --out_var
'LMDEF_ID', --ref_type
339,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the First Enrollment packet. This is used by the Manage Enrollment Activity.',
sysdate,
sysdate
);
COMMIT;

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
'FIRST_ENROLLMENT_PACKET',
'LETTER_TYPE',
'IA - Mandatory Welcome Letter (PCCM)',
'IAP',
'LMDEF_ID',
340,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the First Enrollment packet. This is used by the Manage Enrollment Activity.',
sysdate,
sysdate
);
COMMIT;

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
'FIRST_ENROLLMENT_PACKET',
'LETTER_TYPE',
'IA - Mandatory Welcome Letter (PCCM/VMC)',
'IAV',
'LMDEF_ID',
345,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the First Enrollment packet. This is used by the Manage Enrollment Activity.',
sysdate,
sysdate
);
COMMIT;

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
'SECOND_ENROLLMENT_PACKET',
'LETTER_TYPE',
'SE - Mandatory Secondary Enrollment Packet (ICP)',
'SEI',
'LMDEF_ID',
343,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the Second Enrollment packet. This is used by the Manage Enrollment Activity.',
sysdate,
sysdate
);
COMMIT;

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
'SECOND_ENROLLMENT_PACKET',
'LETTER_TYPE',
'SE - Mandatory Secondary Enrollment Packet (PCCM)',
'SEP',
'LMDEF_ID',
344,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the Second Enrollment packet. This is used by the Manage Enrollment Activity.',
sysdate,
sysdate
);
COMMIT;

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
'SECOND_ENROLLMENT_PACKET',
'LETTER_TYPE',
'SE - Mandatory Secondary Enrollment Packet (PCCM/VMC)',
'SEV',
'LMDEF_ID',
347,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the Second Enrollment packet. This is used by the Manage Enrollment Activity.',
sysdate,
sysdate
);
COMMIT;

--Mandatory Initial Reminder.
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
'INITIAL_REMINDER_NOTICE',
'LETTER_TYPE',
'RM - Mandatory Initial Reminder Notice (ICP)',
'RMI',
'LMDEF_ID',
341,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the Initial Reminder Notice. This is used by the Manage Enrollment Activity.',
sysdate,
sysdate
);
COMMIT;

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
'INITIAL_REMINDER_NOTICE',
'LETTER_TYPE',
'RM - Mandatory Initial Reminder Notice (PCCM)',
'RMP',
'LMDEF_ID',
342,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the Initial Reminder Notice. This is used by the Manage Enrollment Activity.',
sysdate,
sysdate
);
COMMIT;

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
'INITIAL_REMINDER_NOTICE',
'LETTER_TYPE',
'RM - Mandatory Initial Reminder Notice (PCCM/VMC)',
'RMV',
'LMDEF_ID',
346,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the Initial Reminder Notice. This is used by the Manage Enrollment Activity.',
sysdate,
sysdate
);
COMMIT;
----------------------------------------------------------------------------------------------------

/*
client_enroll_status_id = 28966533 is the max id in the past 80 days in ILEBSTBY. So, this should work in MAXDAT production too.
This will improve the performance of the SQL by narrowing the search.
*/
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MANAGEENROLL_LAST_CLNT_ENRL_STAT_ID', 'N', '28966533', 'This is the Client Enroll Status ID which will be used for the search > than', SYSDATE, SYSDATE from dual
where  'MANAGEENROLL_LAST_CLNT_ENRL_STAT_ID' NOT IN (SELECT name FROM corp_etl_control);
COMMIT;
 
/*
After Initial run, set this variable to 4 days. This is to let the ETL self-heal in case it stopped for a maximum of 4 days
in MAXDAT production.
*/
insert into corp_etl_control(NAME, VALUE_TYPE, VALUE, DESCRIPTION, CREATED_TS, UPDATED_TS)
select 'MANAGEENROLL_CDC_DAYS_BACK', 'N', '60', 'This is the number of days to go back to fetch the Client Enroll Status records.', SYSDATE, SYSDATE from dual
where  'MANAGEENROLL_CDC_DAYS_BACK' NOT IN (SELECT name FROM corp_etl_control);
COMMIT;
--------------------------------------------------------------------------------------------------------------------------------------------