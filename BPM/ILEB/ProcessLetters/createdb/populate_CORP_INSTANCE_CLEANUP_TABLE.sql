/*
Created on 22-July-2014 by Raj A.
Description:
While working on NYHIX Process Letters ETL code which is supposed to be a drop-in code from ILEB PL, I found this script to be missing from ILEB PL folder. 
So, back filling now.
*/
insert into CORP_INSTANCE_CLEANUP_TABLE
(system_name, cleanup_name, run, start_date, start_time, end_date, end_time, statement)
values
(
'PROCESS_LETTERS',
'CLEANUP1',
'Y',
sysdate,
'00:01:00',
to_date('7/7/7777','mm/dd/yyyy'),
'08:59:00',
q'[UPDATE corp_etl_proc_letters
  set CANCEL_DT = SYSDATE,
  COMPLETE_DT = SYSDATE,
  STAGE_DONE_DATE = SYSDATE,
  cancel_by = 'CLEANUP1 - Missing Status History Data',
  instance_status = 'Complete'
where instance_status = 'Active'
AND   cancel_dt is null
AND   status in ('Combined similar Requests','Canceled','Voided','Overcome by Events')]'
);

insert into CORP_INSTANCE_CLEANUP_TABLE
(system_name, cleanup_name, run, start_date, start_time, end_date, end_time, statement)
values
(
'PROCESS_LETTERS',
'CLEANUP2',
'Y',
sysdate,
'00:01:00',
to_date('7/7/7777','mm/dd/yyyy'),
'08:59:00',
q'[UPDATE corp_etl_proc_letters
  set CANCEL_DT = SYSDATE,
  COMPLETE_DT = SYSDATE,
  STAGE_DONE_DATE = SYSDATE,
  cancel_by = 'CLEANUP2 - - Sent with Error Status',
  instance_status = 'Complete'
where instance_status = 'Active'
AND   cancel_dt is null
AND   sent_dt is not null
AND   status in ('Errored')]'
);

insert into CORP_INSTANCE_CLEANUP_TABLE
(system_name, cleanup_name, run, start_date, start_time, end_date, end_time, statement)
values
(
'PROCESS_LETTERS',
'CLEANUP3',
'Y',
sysdate,
'00:01:00',
to_date('7/7/7777','mm/dd/yyyy'),
'08:59:00',
q'[UPDATE corp_etl_proc_letters
  set CANCEL_DT = SYSDATE,
  COMPLETE_DT = SYSDATE,
  STAGE_DONE_DATE = SYSDATE,
  cancel_by = 'CLEANUP3 - Letter Creation Error',
  instance_status = 'Complete'
where instance_status = 'Active'
AND   cancel_dt is null
AND   status in ('Errored')
and   sent_dt is null
and  task_id is null
and status_dt < sysdate - 7]'
);

insert into CORP_INSTANCE_CLEANUP_TABLE
(system_name, cleanup_name, run, start_date, start_time, end_date, end_time, statement)
values
(
'PROCESS_LETTERS',
'CLEANUP4',
'Y',
sysdate,
'00:01:00',
to_date('7/7/7777','mm/dd/yyyy'),
'08:59:00',
q'[UPDATE corp_etl_proc_letters
  set CANCEL_DT = SYSDATE,
  COMPLETE_DT = SYSDATE,
  STAGE_DONE_DATE = SYSDATE,
  cancel_by = 'CLEANUP4 - Letter Rejection',
  instance_status = 'Complete'
where instance_status = 'Active'
AND   cancel_dt is null
AND   status in ('Rejected')
and  task_id is null
and status_dt < sysdate - 7]'
);

commit;