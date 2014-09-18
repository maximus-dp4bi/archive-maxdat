/*
Created on 11-Sep-2013 by Raj A.
Process: NYHIX IDR Incidents Process.
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
'''IDR_INCIDENT_HEADER_TYPE''', --name
'IDR_LIST',             --list_type
'Holds the incident header type', --value
'''IDR''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_ENROLL_STATUS_ENROLLEE', --name
'IDR_LIST',             --list_type
'Various enrollment statuses for an enrollee', --value
'''J'',''L''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_ENROL_STATS_POTNTIAL_ENRLE', --name
'IDR_LIST',             --list_type
'Various enrollment statuses for a potential enrollee', --value
'''J'',''L'',''O''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_INCI_STATUS_AWAITING_DOC', --name
'IDR_LIST',             --list_type
'Various incident statuses when awaiting documentation', --value
'''AWAIT_DOC''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_CLOSED_NOT_SUCCESSFUL', --name
'IDR_LIST',             --list_type
'Various incident statuses when IDR incident is closed NOT successful', --value
'''CLOSED_IDR_FAIL''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_CLOSED_SUCCESSFUL', --name
'IDR_LIST',             --list_type
'Various incident statuses when IDR incident is closed and successful', --value
'''CLOSED_IDR_SUCCESS''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_INSTANCE_STATUS_ACTIVE', --name
'IDR_LIST',             --list_type
'Instance status when it is created', --value
'''Active''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_INSTANCE_STATUS_COMPLETE', --name
'IDR_LIST',             --list_type
'Instance status when it is completed', --value
'''Complete''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_YES', --name
'IDR_LIST',             --list_type
'Generic value ''Y'' to be used for any filter or for setting a ASF or a GWF flag.', --value
'''Y''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_NO', --name
'IDR_LIST',             --list_type
'Generic value ''N'' to be used for any filter or for setting a ASF or a GWF flag.', --value
'''N''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_INCIDENT_NORMAL', --name
'IDR_LIST',             --list_type
'Incident status when it closes normally', --value
'''Normal''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_INCIDENT_EXCEPTION', --name
'IDR_LIST',             --list_type
'Incident status when it closes abnormally', --value
'''Exception''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_INCI_STATUS_AWAITING_DOC_2', --name
'IDR_LIST',             --list_type
'Incident status when awaiting documentation', --value
'''Awaiting Documentation''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_CLOSED_NOT_SUCCESSFUL_2', --name
'IDR_LIST',             --list_type
'Incident status when IDR incident is closed NOT successful', --value
'''Incident Closed - IDR Not Successful ''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_CLOSED_SUCCESSFUL_2', --name
'IDR_LIST',             --list_type
'Incident status when IDR incident is closed and successful', --value
'''Incident Closed - IDR Successful ''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_INCIDENT_CLOSED', --name
'IDR_LIST',             --list_type
'Various incident statuses when IDR incident is closed', --value
'''INCIDENT_CLOSED''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_INCIDENT_CLOSED_2', --name
'IDR_LIST',             --list_type
'Incident status when the incident is Closed', --value
'''Incident Closed''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_INC_CLOSED_DUP', --name
'IDR_LIST',             --list_type
'Various incident statuses when IDR incident is closed Duplicate', --value
'''INC_CLOSED_DUP''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_INC_CLOSED_DUP_2', --name
'IDR_LIST',             --list_type
'Various incident statuses when IDR incident is closed Duplicate', --value
'''Incident Closed - Duplicate''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_INCI_CANCEL_REASON_CLOSED', --name
'IDR_LIST',             --list_type
'Cancel reason when the Incident closes normally', --value
'''Closed''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_INCI_CANCEL_REASON_UNKNOWN', --name
'IDR_LIST',             --list_type
'Cancel reason when the Incident closes abnormally', --value
'''Unknown''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_INCIDENT_OPEN', --name
'IDR_LIST',             --list_type
'Incident status when the IDR incident is open', --value
'''INCIDENT_OPEN''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
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
'IDR_INCIDENT_OPEN_2', --name
'IDR_LIST',             --list_type
'Incident status when the incident is open', --value
'''Incident Open''',   --out_var
null, --ref_type
null,        --ref_id
trunc(sysdate),
to_date('07-jul-7777','dd-mon-yyyy'),
null,
sysdate,
SYSDATE
);

INSERT INTO corp_etl_list_lkup
    (cell_id
    ,NAME
    ,list_type
    ,VALUE
    ,out_var
    ,ref_type
    ,ref_id
    ,start_date
    ,end_date
    ,comments
    ,created_ts
    ,updated_ts) 
VALUES
    (seq_cell_id.nextval
    ,'LAST_ETL_COMP_PIVOT'
    ,'PIVOT'
    ,'IDR_Incidents_RUN_ALL'
    ,'21'
    ,'BPM_EVENT_MASTER'
    ,21
    ,trunc(SYSDATE - 1)
    ,to_date('07077777', 'mmddyyyy')
    ,'Pivot to connect the job stats table to BPM tables, out is BSL_ID, ref type is BPM event master and ref id is BEM_ID'
    ,SYSDATE
    ,SYSDATE);

commit;