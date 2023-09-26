update step_instance_stg upd
set upd.mw_processed = 'N'
where upd.step_instance_history_id in (
select distinct stg.step_instance_history_id
from 
(select
step_instance_id,
sis.step_instance_history_id,
sis.hist_status,
case 
  when sis.hist_status = 'UNCLAIMED' then 1
  when sis.hist_status = 'CLAIMED' then 2
  when sis.hist_status = 'INPROCESS' then 3
  when sis.hist_status = 'TIMEOUT' then 4
  when sis.hist_status = 'COMPLETED' then 5
end as stg_Status_Number
,DECODE(sis.ESCALATED_IND, 1, 'Y', 'N') ESCALATED_FLAG
,DECODE(sis.FORWARDED_IND, 1, 'Y', 'N') FORWARDED_FLAG
from step_instance_stg sis
where sis.mw_processed = 'Y'
) stg,
(select
cemw.task_id,
cemw.task_status,
case 
  when cemw.task_status = 'UNCLAIMED' then 1
  when cemw.task_status = 'CLAIMED' then 2
  when cemw.task_status = 'INPROCESS' then 3
  when cemw.task_status = 'TIMEOUT' then 4
  when cemw.task_status = 'COMPLETED' then 5
end as mw_Status_Number,
cemw.escalated_flag as mw_escalated_flag,
cemw.forwarded_flag as mw_forward_flag    
from corp_etl_manage_work cemw
where cemw.complete_date is null) MW
where stg.step_instance_id = mw.task_id
and (stg.stg_status_number > mw.mw_status_number)
     ) ;
commit;
--********************************
update step_instance_stg upd
set upd.mw_processed = 'N'
where upd.step_instance_history_id in (
select distinct stg.step_instance_history_id
from 
(select
step_instance_id,
sis.step_instance_history_id,
sis.hist_status,
case 
  when sis.hist_status = 'UNCLAIMED' then 1
  when sis.hist_status = 'CLAIMED' then 2
  when sis.hist_status = 'INPROCESS' then 3
  when sis.hist_status = 'TIMEOUT' then 4
  when sis.hist_status = 'COMPLETED' then 5
end as stg_Status_Number
,DECODE(sis.ESCALATED_IND, 1, 'Y', 'N') ESCALATED_FLAG
,DECODE(sis.FORWARDED_IND, 1, 'Y', 'N') FORWARDED_FLAG
from step_instance_stg sis
where sis.mw_processed = 'Y'
and sis.step_instance_history_id  in (select max(sis2.step_instance_history_id) from  step_instance_stg sis2
                                      where sis2.step_instance_id = sis.step_instance_id
                                      and sis2.hist_status = sis.hist_status)
) stg,
(select
cemw.task_id,
cemw.task_status,
case 
  when cemw.task_status = 'UNCLAIMED' then 1
  when cemw.task_status = 'CLAIMED' then 2
  when cemw.task_status = 'INPROCESS' then 3
  when cemw.task_status = 'TIMEOUT' then 4
  when cemw.task_status = 'COMPLETED' then 5
end as mw_Status_Number,
cemw.escalated_flag as mw_escalated_flag,
cemw.forwarded_flag as mw_forward_flag    
from corp_etl_manage_work cemw
where cemw.complete_date is null) MW
where stg.step_instance_id = mw.task_id
and ((stg.stg_status_number = mw.mw_status_number and 
      (nvl(stg.ESCALATED_FLAG,'N') = 'Y' and nvl(mw.mw_escalated_flag,'N') = 'N' OR 
       nvl(stg.FORWARDED_FLAG,'N') = 'Y' and  nvl(mw.mw_forward_flag,'N')= 'N')
       ))
);      
commit;
