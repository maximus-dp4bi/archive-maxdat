--------------------------------------------------------
--  File created - Thursday-May-21-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure FIX_COMPLETED_DATE_MW2
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FLCPD0_MAXDAT"."FIX_COMPLETED_DATE_MW2" as
cursor c_opened_tasks is
    select task_id, complete_date, stage_done_date 
      from flhk_etl_manage_work mw
      where task_id in (select task_id from 
      D_MW_V2_CURRENT mw2 where  MW2.COMPLETE_DATE is null
      and MW2.JEOPARDY_FLAG = 'Y'
      and mw2.curr_task_status = 'RESOLVED');
    
  begin
  
    for r_w2_update in c_opened_tasks
    loop
      update  D_MW_V2_CURRENT
      set complete_date = r_w2_update.complete_date,
          stage_done_date = r_w2_update.stage_done_date
        where task_id = r_w2_update.task_id;
    end loop;
    commit;
  end;

/
