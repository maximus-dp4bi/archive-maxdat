--------------------------------------------------------
--  File created - Tuesday-March-28-2018   
--------------------------------------------------------
REM INSERTING into FLCPD0_MAXDAT.D_TASK_TYPES
SET DEFINE OFF;
Insert into FLCPD0_MAXDAT.D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (68,'F45_MEDICAL','F45_MEDICAL','Customer Service Representative',1,'B',1,1,'D');
Insert into FLCPD0_MAXDAT.D_TASK_TYPES (TASK_TYPE_ID,TASK_NAME,TASK_DESCRIPTION,OPERATIONS_GROUP,SLA_DAYS,SLA_DAYS_TYPE,SLA_TARGET_DAYS,SLA_JEOPARDY_DAYS,UNIT_OF_WORK) values (69,'F45_DENTAL','F45_DENTAL','Customer Service Representative',1,'B',1,1,'D');
commit;