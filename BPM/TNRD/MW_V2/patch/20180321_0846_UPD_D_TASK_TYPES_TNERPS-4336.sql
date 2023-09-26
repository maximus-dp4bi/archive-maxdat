--- TNERPS-4336
update d_task_types
set operations_group = 'Call Center'
    ,sla_days = 7
    ,sla_days_type = 'B'
    ,sla_target_days = 7
    ,sla_jeopardy_days = 5
where task_name = 'Returned Mail';
commit;

update d_task_types
set operations_group = 'Data Entry Unit'
    ,sla_days = 3
    ,sla_days_type = 'B'
    ,sla_target_days = 10
    ,sla_jeopardy_days = 8
where task_name = 'MI Review';
commit;

update d_task_types
set operations_group = 'Mail Room'
    ,sla_days = 2
    ,sla_days_type = 'B'
    ,sla_target_days = 2
    ,sla_jeopardy_days = 3
where task_name = 'Link Document Set';
commit;

update d_task_types
set operations_group = 'Data Entry Unit'
    ,sla_days = 8
    ,sla_days_type = 'B'
    ,sla_target_days = 8
    ,sla_jeopardy_days = 5
where task_name = 'Data Evaluation';
commit;


update d_task_types
set operations_group = 'Research'
    ,sla_days = 3
    ,sla_days_type = 'B'
    ,sla_target_days = 3
    ,sla_jeopardy_days = 2
where task_name = 'Application Review';
commit;

update d_task_types
set operations_group = 'Research'
    ,sla_days = 3
    ,sla_days_type = 'B'
    ,sla_target_days = 3
    ,sla_jeopardy_days = 2
where task_name ='Document Review';
commit;

update d_task_types
set operations_group = 'Research'
    ,sla_days = 3
    ,sla_days_type = 'B'
    ,sla_target_days = 5
    ,sla_jeopardy_days = 4
where task_name ='Reactivation Status Review';
commit;


update d_task_types
set operations_group = 'Research'
    ,sla_days = 10
    ,sla_days_type = 'B'
    ,sla_target_days =10
    ,sla_jeopardy_days = 9
where task_name = 'Link from State with Open Applications';
commit;


update d_task_types
set operations_group = 'Research'
    ,sla_days = 5
    ,sla_days_type = 'B'
    ,sla_target_days =5
    ,sla_jeopardy_days = 4
where task_name = 'Multiple Applying Members';
commit;


update d_task_types
set operations_group = 'Data Entry Unit'
    ,task_name='MAXIMUS-QC With Coverage'
    ,sla_days = 8
    ,sla_days_type = 'B'
    ,sla_target_days =8
    ,sla_jeopardy_days = 7
where task_name = 'MAXIMUS-QC';
commit;

Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (50792,'MAXIMUS-QC Without Coverage','APS - Data Entry QC by MAXIMUS','Data Entry Unit',5,'B',5,4,null);
commit;

update d_task_types
set operations_group = 'Research'
    ,sla_days = 1
    ,sla_days_type = 'B'
    ,sla_target_days =1
    ,sla_jeopardy_days = 0
where task_name = 'Data Correction';
commit;


update d_task_types
set operations_group = 'Research'
    ,sla_days = 5
    ,sla_days_type = 'B'
    ,sla_target_days =5
    ,sla_jeopardy_days = 4
where task_name = 'Manual Human Task';
commit;

update d_task_types
set operations_group = 'Data Entry Unit'
    ,task_name='MAXIMUS-QC With Coverage'
    ,sla_days = 5
    ,sla_days_type = 'B'
    ,sla_target_days =5
    ,sla_jeopardy_days =4
where task_name = 'CK Data Evaluation';
commit;

Insert into D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (50793,'CK Data Evaluation With Coverage','CK Data Evaluation','Data Entry Unit',8,'B',8,7,null);
commit;


