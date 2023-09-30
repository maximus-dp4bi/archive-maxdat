
SET DEFINE OFF;


update maxdat.d_task_types
set operations_group='Account Review',
SLA_DAYS=5,
SLA_DAYS_TYPE='B'
WHERE TASK_TYPE_ID=2015027;

commit;
 