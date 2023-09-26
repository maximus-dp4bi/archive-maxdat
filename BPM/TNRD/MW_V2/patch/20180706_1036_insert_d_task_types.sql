---- TNERPS-4647

update MAXDAT.D_TASK_TYPES set OPERATIONS_GROUP = 'Call Center', 
                               SLA_DAYS = '3',
							   SLA_DAYS_TYPE ='B',
							   SLA_TARGET_DAYS = '2',
							   SLA_JEOPARDY_DAYS = '2'
where TASK_TYPE_ID = '32385';

update MAXDAT.D_TASK_TYPES set OPERATIONS_GROUP = 'Data Entry Unit', 
                               SLA_DAYS = '3',
							   SLA_DAYS_TYPE ='B',
							   SLA_TARGET_DAYS = '2',
							   SLA_JEOPARDY_DAYS = '2'
where TASK_TYPE_ID = '32386';
commit;
                               

