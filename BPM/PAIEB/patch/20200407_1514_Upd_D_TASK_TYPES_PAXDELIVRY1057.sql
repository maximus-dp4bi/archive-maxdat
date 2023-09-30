
SET DEFINE OFF;

UPDATE d_task_types
SET task_name = 'CHC Delayed Plan Transfer'
,operations_group = 'CHC Call Center'
WHERE task_type_id = 40137574;

COMMIT;

