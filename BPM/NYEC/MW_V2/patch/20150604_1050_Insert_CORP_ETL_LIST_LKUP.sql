--Adding SLA_Days_Type of 'B' for SLA_Days 70

insert into corp_etl_list_lkup (name, list_type, value, out_var, ref_type, ref_id,start_date, end_date, comments)
select 'ManageWork_SLA_Days_Type', list_type, value, 'B', ref_type, ref_id, start_date, end_date, comments
from corp_etl_list_lkup where name = 'ManageWork_SLA_Days' and ref_id = 32390;

COMMIT;

--Updating D_TASK_TYPES

update D_TASK_TYPES
SET SLA_DAYS_TYPE = 'B'
WHERE SLA_DAYS = 70
AND TASK_TYPE_ID = 32390;

COMMIT;