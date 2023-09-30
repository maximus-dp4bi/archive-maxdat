alter session set plsql_code_type = native;

set define off;

create or replace package corp_etl_mw_pkg is

-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$';
  	SVN_REVISION varchar2(20) := '$Revision$';
 	SVN_REVISION_DATE varchar2(60) := '$Date$';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


   con_pkg Constant  VARCHAR2(30) := 'corp_etl_mw_pkg';

  procedure process_updt_txnfrm(p_sucessful IN OUT VARCHAR2,
                                p_error IN OUT VARCHAR2);

end corp_etl_mw_pkg;
/
create or replace package body corp_etl_mw_pkg is
  procedure process_updt_txnfrm(p_sucessful IN OUT VARCHAR2,
                                p_error IN OUT VARCHAR2) is
    v_upd varchar2(1);
    v_stage_upd_rec   corp_etl_mw_wip%ROWTYPE;
    con_proc Constant  VARCHAR2(30) := 'process_updt_txnfrm';
    v_step VARCHAR2(4000);
    err_code NUMBER;
    err_msg varchar2(200);

  begin
    for new_cur in (
                     SELECT v.*
                          , 'Y' YES
                          , 'N' NO
                          , sysdate system_date
                      FROM MW_STEP_INSTANCE_VW V
                     WHERE 1=1
                       and exists (select 1 from corp_etl_mw_wip c
                                    where v.task_id = c.task_id
                                      and c.CANCEL_WORK_DATE is null
                                      and  c.stage_done_date is null)
                     --and task_id = 186006
                     --order by task_id, step_instance_history_id
                     -- NYHIX-4273 add status order (new), history create date (status date)
                     -- NYEC-6318 remove status order
                     --ORDER BY task_id, status_date, step_instance_history_id
                     --MAXDAT-1450 Fix the order by clause so the updates will be processed correctly
                     ORDER BY task_id, DECODE(task_status,'COMPLETED',2,'TERMINATED',3,1),status_date,step_instance_history_id
    )
    loop
       v_step:= 'set variables';
       v_upd := 'N';
       SELECT * INTO v_stage_upd_rec from corp_etl_mw_wip where task_id = new_cur.task_id;

         --*******************************************************
        v_step := 'UPD1_20 Cancel';
         if new_cur.task_status = 'TERMINATED' then
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
            v_stage_upd_rec.forwarded_by_staff_id := coalesce(new_cur.forwarded_by_staff_id,0);
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
         if nvl(new_cur.task_status,'mm') <> nvl(v_stage_upd_rec.task_status,'mm') OR
            nvl(new_cur.status_date,trunc(sysdate+200)) <> nvl(v_stage_upd_rec.status_date,trunc(sysdate+200))then
            v_stage_upd_rec.task_status := new_cur.task_status;
            v_stage_upd_rec.status_date := nvl(new_cur.status_date,sysdate);
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
        v_step := 'UPD1 - Source Process ID & Source Process Instance ID';
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
         if v_upd = 'Y' then
            UPDATE corp_etl_mw_wip a
               SET ROW = v_stage_upd_rec
             WHERE a.cemw_id = v_stage_upd_rec.cemw_id;
            COMMIT;
         end if;
    end loop;
    p_sucessful := 'Y';
    p_error     := con_proc || ': Sucessful';
  EXCEPTION
      WHEN OTHERS THEN
          Begin
        err_code := SQLCODE;
        err_msg := substr(SQLERRM, 1, 200);
        p_sucessful := 'N';
        p_error     := con_proc || ': '|| v_step || ': ' || SQLERRM;
        INSERT INTO CORP_ETL_ERROR_LOG 
         (err_date, err_level, process_name, job_name, nr_of_error, error_desc, 
          error_field, error_codes, driver_table_name, driver_key_number, create_ts, update_ts)  
        VALUES 
         (sysdate, 'ABORT', 'MW', 'CORP_ETL_MW_PKG',err_code, err_msg, 
         err_code, err_msg, 'corp_etl_mw_wip', v_stage_upd_rec.cemw_id, sysdate, sysdate);
        COMMIT;
      END;
  END process_updt_txnfrm;


end corp_etl_mw_pkg;
/

alter session set plsql_code_type = interpreted;