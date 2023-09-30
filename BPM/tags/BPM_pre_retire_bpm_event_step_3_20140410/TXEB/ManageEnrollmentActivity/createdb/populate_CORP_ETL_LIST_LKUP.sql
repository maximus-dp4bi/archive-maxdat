/*
Created on 15-Aug-2013 by Raj A.
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
  
 --Used in ManageEnroll_Fetch_Second_FU_TX.ktr 
  select out_var 
  from corp_etl_list_lkup
  WHERE  name = 'SECOND_REMINDER_NOTICE';

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
'ENROLLMENT_PACKET', --name
'LETTER_TYPE',             --list_type
'Medical Mandatory Enrollment Packet', --value
'IAM',   --out_var
'LMDEF_ID', --ref_type
435,        --ref_id
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
'ENROLLMENT_PACKET', --name
'LETTER_TYPE',             --list_type
'Medical Voluntary Enrollment Letter', --value
'VLM',   --out_var
'LMDEF_ID', --ref_type
438,        --ref_id
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
'ENROLLMENT_PACKET', --name
'LETTER_TYPE',             --list_type
'Dental Mandatory Enrollment Packet', --value
'IAD',   --out_var
'LMDEF_ID', --ref_type
436,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the Enrollment packet. This is used by the Manage Enrollment Activity.',
sysdate,
sysdate
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
'ENROLLMENT_PACKET', --name
'LETTER_TYPE',             --list_type
'Dental Voluntary Enrollment', --value
'VLD',   --out_var
'LMDEF_ID', --ref_type
449,        --ref_id
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
'ENROLLMENT_PACKET', --name
'LETTER_TYPE',             --list_type
'NorthSTAR Mandatory Enrollment Packet', --value
'IAN',   --out_var
'LMDEF_ID', --ref_type
437,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the Enrollment packet. This is used by the Manage Enrollment Activity.',
sysdate,
sysdate
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
'ENROLLMENT_PACKET', --name
'LETTER_TYPE',             --list_type
'NorthSTAR only w/Medicare Mandatory Enrollment Packet', --value
'IND',   --out_var
'LMDEF_ID', --ref_type
456,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the Enrollment packet. This is used by the Manage Enrollment Activity.',
sysdate,
sysdate
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
'ENROLLMENT_PACKET', --name
'LETTER_TYPE',             --list_type
'Enrollment Letter', --value
'EPM',   --out_var
'LMDEF_ID', --ref_type
417,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the Enrollment packet. This is used by the Manage Enrollment Activity.',
sysdate,
sysdate
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
'FIRST_REMINDER_NOTICE',
'LETTER_TYPE',
'Enrollment Reminder',
'EIR',
'LMDEF_ID',
420,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the Second Enrollment packet. This is used by the Manage Enrollment Activity.',
sysdate,
sysdate
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
'SECOND_REMINDER_NOTICE',
'LETTER_TYPE',
'2nd Enrollment Reminder',
'LPD',
'LMDEF_ID',
20,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This global control value gives the lmdef_id of the Second Enrollment packet. This is used by the Manage Enrollment Activity.',
sysdate,
sysdate
);

/*
This global control is used to fetch the Enrollment Data Entry Task for the Manage Enrollment Activity process.
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
'ENRL_DATA_ENTRY',
'LIST',
'Enrollment Data Entry Task',
'Enrollment Data Entry Task',
'STEP_DEFINITION_ID',
1059,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This is a place holder for Manage Enrollment Activity process related Enrollment Data Entry Task.',
sysdate,
sysdate
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
'ENRL_DATA_ENTRY',
'LIST',
'Medicaid Enrollment Data Entry',
'Medicaid Enrollment Data Entry Task',
'STEP_DEFINITION_ID',
32300,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This is a place holder for Manage Enrollment Activity process related Enrollment Data Entry Task.',
sysdate,
sysdate
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
'ENRL_DATA_ENTRY',
'LIST',
'CHIP Enrollment Data Entry',
'CHIP Enrollment Data Entry Task',
'STEP_DEFINITION_ID',
32301,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This is a place holder for Manage Enrollment Activity process related Enrollment Data Entry Task.',
sysdate,
sysdate
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
'ENRL_DATA_ENTRY',
'LIST',
'STAR Enrollment Data Entry',
'Enrollment Data Entry task for the following forms: STAR Enrollment, Medicaid Dental Enrollment',
'STEP_DEFINITION_ID',
32320,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This is a place holder for Manage Enrollment Activity process related Enrollment Data Entry Task.',
sysdate,
sysdate
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
'ENRL_DATA_ENTRY',
'LIST',
'NorthSTAR Enrollment Data Entry',
'Enrollment Data Entry task:STAR and NSTAR,STARP DUAL and NorthSTAR, Mandatory STARP and NSTAR',
'STEP_DEFINITION_ID',
32321,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This is a place holder for Manage Enrollment Activity process related Enrollment Data Entry Task.',
sysdate,
sysdate
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
'ENRL_DATA_ENTRY',
'LIST',
'STAR+PLUS Enrollment Data Entry',
'Enrollment Data Entry task for forms: STAR+PLUS DUAL, Mandatory STARP',
'STEP_DEFINITION_ID',
32322,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This is a place holder for Manage Enrollment Activity process related Enrollment Data Entry Task.',
sysdate,
sysdate
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
'ENRL_DATA_ENTRY',
'LIST',
'TP40 STAR Enrollment',
'Enrollment Data Entry task for the following forms: TP40 STAR, TP40 STAR and NSTAR',
'STEP_DEFINITION_ID',
32323,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This is a place holder for Manage Enrollment Activity process related Enrollment Data Entry Task.',
sysdate,
sysdate
);

-----------------------------------------------------------
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
-----------------------------------------------------------
commit;