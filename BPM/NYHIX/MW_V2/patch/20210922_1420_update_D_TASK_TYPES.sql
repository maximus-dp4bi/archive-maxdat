alter session set current_schema = MAXDAT;
UPDATE MAXDAT.D_TASK_TYPES  SET OPERATIONS_GROUP = 'Call Center', SLA_DAYS= '2',SLA_DAYS_TYPE='B', SLA_JEOPARDY_DAYS='1' where TASK_TYPE_ID = 20211001 

commit;