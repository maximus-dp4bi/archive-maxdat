declare
 vStgUpdCount number := 0;
 vBPMUpdCount number := 0;
begin
for tmp_cur in (select * -- distinct stg.step_instance_history_id
                --distinct stg.step_instance_id
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
                --,DECODE(sis.ESCALATED_IND, 1, 'Y', 'N') ESCALATED_FLAG
                --,DECODE(sis.FORWARDED_IND, 1, 'Y', 'N') FORWARDED_FLAG
                ,sis.stage_create_ts
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
                --cemw.escalated_flag as mw_escalated_flag,
                --cemw.forwarded_flag as mw_forward_flag,
                cemw.cancel_work_flag, cemw.stage_done_date    
                from corp_etl_manage_work cemw
                where cemw.complete_date is null
                and nvl(cemw.cancel_work_flag,'N') = 'N') MW
                where stg.step_instance_id = mw.task_id
                and (stg.stg_status_number > mw.mw_status_number)
                )
loop
   update step_instance_stg sis
      set sis.mw_processed = 'N'
    where sis.step_instance_history_id = tmp_cur.step_instance_history_id;  
   vStgUpdCount := vStgUpdCount +1;
   IF tmp_cur.stage_done_date is not null then
     update corp_etl_manage_work
     set stage_done_date = null, 
         asf_complete_work = 'N'
     where task_id = tmp_cur.task_id;
     vBPMUpdCount := vBPMUpdCount +1;
   end if;   

end loop;
dbms_output.put_line('AdhocStepInstanceUPD_1 = '||vStgUpdCount);
dbms_output.put_line('AdhocManageWorkStgDone_DateUPD_1 = '||vBPMUpdCount);
vStgUpdCount := 0;
vBPMUpdCount := 0;
COMMIT;

for tmp_cur in (select *
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
                  ,sis.stage_create_ts
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
                  cemw.forwarded_flag as mw_forward_flag,  
                  cemw.cancel_work_flag, cemw.stage_done_date     
                  from corp_etl_manage_work cemw
                  where cemw.complete_date is null) MW
                  where stg.step_instance_id = mw.task_id
                  and ((stg.stg_status_number = mw.mw_status_number and 
                        (nvl(stg.ESCALATED_FLAG,'N') = 'Y' and nvl(mw.mw_escalated_flag,'N') = 'N' OR 
                         nvl(stg.FORWARDED_FLAG,'N') = 'Y' and  nvl(mw.mw_forward_flag,'N')= 'N')
                         ))
                )
loop
   update step_instance_stg sis
      set sis.mw_processed = 'N'
    where sis.step_instance_history_id = tmp_cur.step_instance_history_id;  
   
   IF tmp_cur.stage_done_date is not null then
     update corp_etl_manage_work
     set stage_done_date = null, 
         asf_complete_work = 'N'
     where task_id = tmp_cur.task_id;
   end if;   
end loop;
dbms_output.put_line('AdhocStepInstanceUPD_2 = '||vStgUpdCount);
dbms_output.put_line('AdhocManageWorkStgDone_DateUPD_2 = '||vBPMUpdCount);
vStgUpdCount := 0;
vBPMUpdCount := 0;
COMMIT;
end;
/
