ALTER SESSION SET CURRENT_SCHEMA = MAXDAT;
update D_TASK_TYPES set OPERATIONS_GROUP = 'Research', SLA_DAYS = 3, SLA_DAYS_TYPE = 'B', SLA_TARGET_DAYS =  '3', SLA_JEOPARDY_DAYS =  '2', UNIT_OF_WORK =  '' where TASK_TYPE_ID =  50411;
update D_TASK_TYPES set OPERATIONS_GROUP = 'State Eligibility', SLA_DAYS = 3, SLA_DAYS_TYPE = 'B', SLA_TARGET_DAYS =  '3', SLA_JEOPARDY_DAYS =  '2', UNIT_OF_WORK =  '' where TASK_TYPE_ID =  50413;
update D_TASK_TYPES set OPERATIONS_GROUP = 'State Eligibility', SLA_DAYS = 3, SLA_DAYS_TYPE = 'B', SLA_TARGET_DAYS =  '3', SLA_JEOPARDY_DAYS =  '2', UNIT_OF_WORK =  '' where TASK_TYPE_ID =  50416;
update D_TASK_TYPES set OPERATIONS_GROUP = 'State Eligibility', SLA_DAYS = 3, SLA_DAYS_TYPE = 'B', SLA_TARGET_DAYS =  '3', SLA_JEOPARDY_DAYS =  '2', UNIT_OF_WORK =  '' where TASK_TYPE_ID =  50415;
update D_TASK_TYPES set OPERATIONS_GROUP = 'Research', SLA_DAYS = 3, SLA_DAYS_TYPE = 'B', SLA_TARGET_DAYS =  '3', SLA_JEOPARDY_DAYS =  '2', UNIT_OF_WORK =  '' where TASK_TYPE_ID =  50410;
update D_TASK_TYPES set OPERATIONS_GROUP = 'State Eligibility', SLA_DAYS = 3, SLA_DAYS_TYPE = 'B', SLA_TARGET_DAYS =  '3', SLA_JEOPARDY_DAYS =  '2', UNIT_OF_WORK =  '' where TASK_TYPE_ID =  50414;
update D_TASK_TYPES set OPERATIONS_GROUP = 'State Eligibility', SLA_DAYS = 3, SLA_DAYS_TYPE = 'B', SLA_TARGET_DAYS =  '3', SLA_JEOPARDY_DAYS =  '2', UNIT_OF_WORK =  '' where TASK_TYPE_ID =  50412;
commit;
