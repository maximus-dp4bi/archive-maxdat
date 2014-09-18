/*
Created on 16-Aug-2012 by Raj A.

v1 Raj A. 16-Aug-2012 Creation.
v2 Raj A. 21-Aug-2012 Added 'LETTERS_LAST_UPDATE_DATE', 'PRO_MI_CDC_MI_TASKS' and 'LETTERS_CDC_APPS_DAYS_BACK'.
*/
----------------DML ----------------
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
'MI_TASK_TYPE',
'LIST',
'State Review Task - MI Reprocess Result',
'Missing Information',
'STEP_DEFINITION_ID',
32390,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This is a place holder for Process MI Task Type.',
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
start_date,
end_date,
comments
)
values
(
'MI_SLA_DAYS',
'LIST',
'NONE',
'6',
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This is a place holder for Process MI SLA Days.'
);

insert into corp_etl_list_lkup
(
name,
list_type,
value,
out_var,
start_date,
end_date,
comments
)
values
(
'MI_SLA_DAYS_TYPE',
'LIST',
'NONE',
'B',
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This is a place holder for Process MI SLA Days Type.'
);

insert into corp_etl_list_lkup
(
name,
list_type,
value,
out_var,
start_date,
end_date,
comments
)
values
(
'MI_SLA_JEOPARDY_DAYS',
'LIST',
'NONE',
'2',
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This is a place holder for Process MI SLA Jeopardy Days.'
);

insert into corp_etl_list_lkup
(
name,
list_type,
value,
out_var,
start_date,
end_date,
comments
)
values
(
'MI_SLA_TARGET_DAYS',
'LIST',
'NONE',
'4',
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This is a place holder for Process MI SLA Target Days.'
);
commit;

insert into corp_etl_control
(
name,
value_type,
value,
description,
created_ts,
updated_ts
)
values
(
'PRO_MI_CDC_START_TIME',
'D',
to_char(sysdate,'yyyy/mm/dd hh24:mi:ss'),
'This is the time when the Change Data Capture(CDC) started for Process MI. This is timestamp is used to lookup Task History records on or before this time for read-consistency between MIs and Tasks.',
sysdate,
sysdate
);
commit;

insert into corp_etl_control
(
name,
value_type,
value,
description,
created_ts,
updated_ts
)
values
(
'PRO_MI_CDC_MI_TASKS',
'N',
31,
'This global control value can be used to fetch completed MI tasks from OLTP going back few days from sysdate. This is used by Process MI Change Data Capture Get MI Tasks step.If for some reason the Process MI fails, set this variable to the date and time when it failed and restart.',
sysdate,
sysdate
);
commit;

insert into corp_etl_control
(
name,
value_type,
value,
description,
created_ts,
updated_ts
)
values
(
'LETTERS_LAST_UPDATE_DATE',
'D',
to_char(to_date('2012/7/31 01:00:00','yyyy/mm/dd hh24:mi:ss'),'yyyy/mm/dd hh24:mi:ss'),
'Change Data Capture of letters.This is the timestamp of the letter_request.update_ts from the previous run. update_ts of the most recent letter record from the previous run.',
sysdate,
sysdate
);

insert into corp_etl_control
(
name,
value_type,
value,
description,
created_ts,
updated_ts
)
values
(
'LETTERS_CDC_APPS_DAYS_BACK',
'N',
31,
'This global control value is used to fetch all letters on completed Applications going back these many days. This is used by CDC transformations.',
sysdate,
sysdate
);
commit;