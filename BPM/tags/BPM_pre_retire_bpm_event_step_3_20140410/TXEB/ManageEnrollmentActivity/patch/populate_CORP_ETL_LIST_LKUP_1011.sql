/*
Created on 10-Oct-2013 by Raj A.
Team: MAXDAT.
Business Process: Manage Enrollment Activity.
Description:
Inserts global controls into the corp_etl_list_lkup table.
Use below sql to find out what it is.

--Used in ManageEnroll_Fetch_Enrl_packets.ktr
 select out_var 
  from corp_etl_list_lkup
  WHERE  name = 'ENROLLMENT_PACKET';
  
--Used in ManageEnroll_Fetch_First_FU_TX.ktr
 select out_var 
  from corp_etl_list_lkup
  WHERE  name = 'INITIAL_REMINDER_NOTICE';
  
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
'PLAN_CHANGE', --name
'LETTER_TYPE',             --list_type
'Health Plan Change', --value
'HPC',   --out_var
'LMDEF_ID', --ref_type
421,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the Enrollment packet. This is used by the Manage Enrollment Activity.',
sysdate,
SYSDATE
);

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
'ENROLL_MI', --name
'LETTER_TYPE',             --list_type
'Enrollment Missing Info', --value
'EMI',   --out_var
'LMDEF_ID', --ref_type
418,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the Enrollment packet. This is used by the Manage Enrollment Activity.',
sysdate,
SYSDATE
);

commit;
