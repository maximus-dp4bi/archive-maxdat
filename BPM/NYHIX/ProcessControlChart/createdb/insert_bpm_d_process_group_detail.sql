insert into bpm_d_process_group_detail(d_process_definition_id,d_process_group_id,name,label,record_eff_dt,record_end_dt)
select (select d_process_definition_id from bpm_d_process_definition where process_name = 'MANAGE_WORK')
       ,(select d_process_group_id from bpm_d_process_group where group_name = 'TASK_TYPE')
       ,task_type
       ,task_type
       ,trunc(sysdate)
       ,to_date('12/31/2099','mm/dd/yyyy')
from BPM_D_OPS_GROUP_TASK ;
commit;