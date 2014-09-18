/*
Created on 28-Feb-2012 by Raj A.
Description:
This script adds the FOUR Reactivation task types that are being deployed to NYECPRD on 05-MAR-2013.
The idea is by 05-Mar, these four task types should be available in MAXDAT and the ETL processes i.e, MissingInfo, State Review, etc.
should pick them up and start tracking starting from 05-Mar-2013.
*/

--State Data Entry - MI Reactivation.
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
'TASK_MONITOR_TYPE',
'LIST',
'State Data Entry - Reactivation',
'State Data Entry',
'STEP_DEFINITION_ID',
1113017,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'Monitor Type for Tasks.',
sysdate,
sysdate
);

--State Data Entry - MI Reactivation.
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
'State Data Entry - MI Reactivation',
'Missing Information',
'STEP_DEFINITION_ID',
1113018,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'This is a place holder for Process MI Task Type.',
sysdate,
sysdate
);

--State Acceptance - Reactivation.
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
'TASK_MONITOR_TYPE',
'LIST',
'State Acceptance - Reactivation',
'State Review',
'STEP_DEFINITION_ID',
2003013,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'Monitor Type for Tasks.',
sysdate,
sysdate
);


--Application Problem Resolution - Reactivation.
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
'TASK_MONITOR_TYPE',
'LIST',
'Application Problem Resolution - Reactivation',
'Research',
'STEP_DEFINITION_ID',
2223030,
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
'Monitor Type for Tasks.',
sysdate,
sysdate
);
commit;