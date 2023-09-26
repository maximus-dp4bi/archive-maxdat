-- MAXDAT-8125 - Manage Work SLA Days and Jeopardy Days Configuration does not match PA IEB Prod 

alter session set current_schema = PA_IEB;

-- select * from D_BPM_TASK_TYPE_ENTITY where TASK_TYPE_ID in (40137294,40137334,40137335,40137336);

update D_TASK_TYPES set 
  OPERATIONS_GROUP = 'Assessors Unit',
  SLA_TARGET_DAYS = 2,
  SLA_JEOPARDY_DAYS = 1,
  SLA_DAYS_TYPE = 'B',
  SLA_DAYS = 2
where TASK_TYPE_ID = 40137294;

update D_TASK_TYPES set 
  OPERATIONS_GROUP = 'CHC Enrollment',
  SLA_TARGET_DAYS = 2,
  SLA_JEOPARDY_DAYS = 1,
  SLA_DAYS_TYPE = 'B',
  SLA_DAYS = 2
where TASK_TYPE_ID in (40137334,40137335,40137336);

commit;