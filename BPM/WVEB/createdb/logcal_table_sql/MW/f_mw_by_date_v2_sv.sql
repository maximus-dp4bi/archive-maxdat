select 
  d.mw_bi_id
  ,bdd.d_date
  ,case when bdd.d_date = trunc(d.create_date) then 1 else 0 end creation_count
  ,case when bdd.d_date = trunc(d.complete_date) then 0 else 1 end inventory_count
  ,case when (bdd.d_date = trunc(d.complete_date) or bdd.d_date = trunc(d.cancel_work_date)) then 1 else 0 end completion_count
from 
  (select 
     si.STEP_INSTANCE_ID mw_bi_id 
     ,case when si.STATUS = 'TERMINATED' then si.COMPLETED_TS else null end cancel_work_date
     ,case when si.STATUS = 'COMPLETED' then si.COMPLETED_TS else null end complete_date
     ,si.CREATE_TS create_date
     ,si.CREATE_TS instance_start_date
     ,si.COMPLETED_TS instance_end_date
   from STEP_INSTANCE si 
   left outer join STEP_DEFINITION sd on si.STEP_DEFINITION_ID = sd.STEP_DEFINITION_ID
   where 
     sd.STEP_TYPE_CD in ('VIRTUAL_HUMAN_TASK','HUMAN_TASK')) d
join 
  (select (add_months(trunc(sysdate,'MM'),-12) + rownum) d_date 
   from dual 
   connect by rownum <= (sysdate - (add_months(trunc(sysdate,'MM'),-12)))) bdd  
  on (bdd.d_date >= trunc(d.instance_start_date) and (bdd.d_date <= d.instance_end_date or d.instance_end_date is null))
