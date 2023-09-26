--------------------------------------------------------
--  File created - Thursday-November-19-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body CORP_ETL_MW_V2_PKG
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "CORP_ETL_MW_V2_PKG" is
  procedure process_updt_txnfrm(p_sucessful IN OUT VARCHAR2,
                                p_error IN OUT VARCHAR2) is
    v_upd varchar2(1);
    v_stage_upd_rec   corp_etl_mw_v2_wip%ROWTYPE;
    con_proc Constant  VARCHAR2(30) := 'process_updt_txnfrm';
    v_step VARCHAR2(4000);

  begin
    for new_cur in (
                     SELECT v.*
                          , 'Y' YES
                          , 'N' NO
                          , sysdate system_date
                     FROM MW_V2_TASK_VW v
                     WHERE 1=1
                       and exists (select 1 from corp_etl_mw_v2_wip c
                                    where v.task_id = c.task_id
                                      and c.change_flag <> 'I'
                                      and c.CANCEL_WORK_DATE is null
                                      and  c.stage_done_date is null)
                     ORDER BY task_id, DECODE(task_status,'RESOLVED',2,'TERMINATED',3,1),status_date
    )
    loop
       v_step:= 'set variables';
       v_upd := 'N';
       SELECT * INTO v_stage_upd_rec from corp_etl_mw_v2_wip where task_id = new_cur.task_id;

         --*******************************************************
        v_step := 'UPD1_20 Cancel';
         if v_stage_upd_rec.task_status = 'TERMINATED' then
            v_stage_upd_rec.cancel_work_date := new_cur.system_date;
            v_stage_upd_rec.last_update_by_staff_id := coalesce(new_cur.last_update_by_staff_id,0);
            --v_stage_upd_rec.last_update_date := new_cur.last_update_date;
            v_upd := 'Y';
         end if;
         --*******************************************************
        v_step := 'UPD1_30 -  Last_Update (NVL not needed)';
         if new_cur.last_update_date <> v_stage_upd_rec.last_update_date then
            v_stage_upd_rec.last_update_by_staff_id := coalesce(new_cur.last_update_by_staff_id,0);
            v_stage_upd_rec.last_update_date := new_cur.last_update_date;
            v_stage_upd_rec.last_event_date := new_cur.last_update_date;
            v_upd := 'Y';
         end if;
         --*******************************************************
        v_step := 'UPD1_40 - Escalated (NVL not needed)';
         if new_cur.escalated_flag <> v_stage_upd_rec.escalated_flag then
            v_stage_upd_rec.escalated_flag := new_cur.escalated_flag;
             v_stage_upd_rec.escalated_to_staff_id := coalesce(new_cur.escalated_to_staff_id,0);
            --v_stage_upd_rec.unit_of_work := new_cur.unit_of_work;
            v_upd := 'Y';
         end if;

         --*******************************************************
        v_step := 'UPD1_50 - Forwarded (NVL not needed)';
         if new_cur.forwarded_flag <> v_stage_upd_rec.forwarded_flag then
            v_stage_upd_rec.forwarded_flag := new_cur.forwarded_flag;
          ---  v_stage_upd_rec.forwarded_by_staff_id := coalesce(new_cur.forwarded_by_staff_id,0);
            v_upd := 'Y';
         end if;
         --*******************************************************
        v_step := 'UPD1_60 - Owner';
--dbms_output.put_line ('UPD1_60 - task_histID :'||new_cur.step_instance_history_id||' NEW Owner: '||new_cur.owner_name||' Old : '||v_stage_upd_rec.owner_name);
         if nvl(new_cur.owner_staff_id,1) <> nvl(v_stage_upd_rec.owner_staff_id,1) then
            v_stage_upd_rec.owner_staff_id := coalesce(new_cur.owner_staff_id,0);
            v_upd := 'Y';
--dbms_output.put_line ('IN - UPD1_60 - task_histID :'||new_cur.step_instance_history_id||' NEW Owner: '||new_cur.owner_name||' Old : '||v_stage_upd_rec.owner_name) ;
         end if;
         --*******************************************************
        v_step := 'UPD1_70 - Group';
         if nvl(new_cur.business_unit_id,1) <> nvl(v_stage_upd_rec.business_unit_id,1) then
            v_stage_upd_rec.business_unit_id := coalesce(new_cur.business_unit_id,0);
            v_upd := 'Y';
         end if;
         --*******************************************************
        v_step := 'UPD1_80 - Team';
         if nvl(new_cur.team_id,1) <> nvl(v_stage_upd_rec.team_id,1) then
            v_stage_upd_rec.team_id := coalesce(new_cur.team_id,0);
            v_upd := 'Y';
         end if;
         --*******************************************************
        v_step := 'UPD1_90 - Reference';
         if nvl(new_cur.source_reference_id,99999999999999) <> nvl(v_stage_upd_rec.source_reference_id,99999999999999) then
            v_stage_upd_rec.source_reference_id := new_cur.source_reference_id;
            v_stage_upd_rec.source_reference_type := new_cur.source_reference_type;
            v_upd := 'Y';
         end if;
         --*******************************************************
        v_step := 'UPD1_100 - Status_Date';
         if nvl(new_cur.status_date,trunc(sysdate+200)) <> nvl(v_stage_upd_rec.status_date,trunc(sysdate+200)) then
            v_stage_upd_rec.task_status := new_cur.task_status;
            v_stage_upd_rec.status_date := new_cur.status_date;
            v_stage_upd_rec.complete_date := new_cur.complete_date;
         v_upd := 'Y';
         end if;
         --*******************************************************
         v_step := 'UPD1_105 - Task status';
         if nvl(new_cur.task_status,'XXXX') <> nvl(v_stage_upd_rec.task_status,'XXXX') then
            v_stage_upd_rec.task_status := new_cur.task_status;
            v_stage_upd_rec.status_date := new_cur.status_date;
            v_stage_upd_rec.complete_date := new_cur.complete_date;
         v_upd := 'Y';
         end if;
         --*******************************************************
        v_step := 'UPD1_110 - Client_ID';
         if nvl(new_cur.client_id,99999999999999) <> nvl(v_stage_upd_rec.client_id,99999999999999) then
            v_stage_upd_rec.client_id := new_cur.client_id;
            v_upd := 'Y';
         end if;
         --*******************************************************
        v_step := 'UPD1_120 - Case_ID';
         if nvl(new_cur.case_id,99999999999999) <> nvl(v_stage_upd_rec.case_id,99999999999999) then
            v_stage_upd_rec.case_id := new_cur.case_id;
            v_upd := 'Y';
         end if;
         --*******************************************************
        v_step := 'UPD1 - Source Process ID  Process Instance ID';
         if nvl(new_cur.source_process_id,99999999999999) <> nvl(v_stage_upd_rec.source_process_id,99999999999999) OR
            nvl(new_cur.source_process_instance_id,99999999999999) <> nvl(v_stage_upd_rec.source_process_instance_id,99999999999999)
          then
            v_stage_upd_rec.source_process_id := new_cur.source_process_id;
            v_stage_upd_rec.source_process_instance_id := new_cur.source_process_instance_id;
            v_upd := 'Y';
         end if;
        --*******************************************************
        v_step := 'Update Cancel Work ';
         if v_stage_upd_rec.cancel_work_date is not null THEN
            v_stage_upd_rec.stage_done_date := new_cur.system_date;
            v_stage_upd_rec.cancel_method := 'Normal';
            v_stage_upd_rec.cancel_reason := 'Task was Terminated';
            v_stage_upd_rec.cancelled_by_staff_id := coalesce(new_cur.last_update_by_staff_id,0);
            v_upd := 'Y';
         end if;
        --*******************************************************
         v_step := 'Update COMPLETE_DATE ';
         if  v_stage_upd_rec.complete_date is not null THEN
            v_stage_upd_rec.stage_done_date := new_cur.system_date;
            v_upd := 'Y';
         end if;
         --*******************************************************
         v_step := 'Update RULE_EXECUTED  ';
         if nvl(new_cur.RULE_EXECUTED,'XXXXX') <> nvl(v_stage_upd_rec.RULE_EXECUTED,'XXXX') then
		    v_stage_upd_rec.RULE_EXECUTED := new_cur.RULE_EXECUTED;
            v_upd := 'Y';
         end if;

         --*******************************************************
         if v_upd = 'Y' then
            v_stage_upd_rec.change_flag := 'U';
            UPDATE corp_etl_mw_v2_wip a
               SET ROW = v_stage_upd_rec
             WHERE a.cemw_id = v_stage_upd_rec.cemw_id;
            COMMIT;
         end if;
    end loop;
    p_sucessful := 'Y';
    p_error     := con_proc || ': Sucessful';
  EXCEPTION
      WHEN OTHERS THEN
          rollback;
          p_sucessful := 'N';
          p_error     := con_proc || ': '||v_step || ': ' || SQLERRM;
  END process_updt_txnfrm;


end corp_etl_mw_v2_pkg;

/
