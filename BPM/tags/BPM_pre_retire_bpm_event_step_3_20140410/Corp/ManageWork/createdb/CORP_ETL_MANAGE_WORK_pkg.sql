alter session set plsql_code_type = native;

create or replace package corp_etl_manage_work_pkg is

-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL$'; 
  	SVN_REVISION varchar2(20) := '$Revision$'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';


   con_pkg Constant  VARCHAR2(30) := 'corp_etl_manage_work_pkg';  

  TYPE status_order_rec IS RECORD 
  (status       corp_etl_list_lkup.value%TYPE
  ,status_order corp_etl_list_lkup.out_var%TYPE);
    
  TYPE status_order_tab IS TABLE OF status_order_rec
  INDEX BY BINARY_INTEGER;
  gv_task_status_rec  status_order_tab;

  procedure process_updt_txnfrm(p_sucessful IN OUT VARCHAR2,
                                p_error IN OUT VARCHAR2);

  FUNCTION get_task_status_order
  (in_status IN VARCHAR2)
  RETURN INTEGER;

end corp_etl_manage_work_pkg;
/
create or replace package body corp_etl_manage_work_pkg is
  procedure process_updt_txnfrm(p_sucessful IN OUT VARCHAR2,
                                p_error IN OUT VARCHAR2) is 
    v_upd varchar2(1);
    v_stage_upd_rec   corp_etl_manage_work_tmp%ROWTYPE;
    con_proc Constant  VARCHAR2(30) := 'process_updt_txnfrm';
    v_step VARCHAR2(4000); 
   
  begin
    for new_cur in (
                     SELECT v.* 
                          , 'Y' YES
                          , 'N' NO
                          , sysdate system_date
                      FROM MW_STEP_INSTANCE_VW V
                     WHERE --task_id in (131054,131451,130995,131041,130676,130707,130789)
                           exists (select 1 from corp_etl_manage_work_tmp c 
                                    where v.task_id = c.task_id 
                                      and c.CANCEL_WORK_FLAG = 'N' 
                                      and  c.stage_done_date is null)
                     --order by task_id, step_instance_history_id
                     -- NYHIX-4273 add status order (new), history create date (status date)
                     ORDER BY task_id, status_order, status_date
    )
    loop
       v_step:= 'set variables';
       v_upd := 'N';
       SELECT * INTO v_stage_upd_rec from CORP_ETL_MANAGE_WORK_TMP where task_id = new_cur.task_id;
       
         --*******************************************************
        v_step := 'UPD1_20 Cancel';
         if new_cur.task_status = 'TERMINATED' then
            v_stage_upd_rec.cancel_work_flag := new_cur.yes;
            v_stage_upd_rec.cancel_work_date := new_cur.system_date;
            v_stage_upd_rec.last_update_by_name := new_cur.last_update_by_name;
            v_stage_upd_rec.last_update_date := new_cur.last_update_date;
            v_stage_upd_rec.date_today := new_cur.system_date;
            v_upd := 'Y';
         end if;  
         --*******************************************************                 
        v_step := 'UPD1_30 -  Last_Update (NVL not needed)';
         if new_cur.last_update_date <> v_stage_upd_rec.last_update_date then
            v_stage_upd_rec.last_update_by_name := new_cur.last_update_by_name;
            v_stage_upd_rec.last_update_date := new_cur.last_update_date;
            v_stage_upd_rec.date_today := new_cur.system_date;
            v_upd := 'Y';
         end if;           
         --*******************************************************                 
        v_step := 'UPD1_40 - Escalated (NVL not needed)';
         if new_cur.escalated_flag <> v_stage_upd_rec.escalated_flag then
            v_stage_upd_rec.escalated_flag := new_cur.escalated_flag;
            v_stage_upd_rec.escalated_to_name := new_cur.escalated_to_name;
            v_stage_upd_rec.unit_of_work := new_cur.unit_of_work;
            v_stage_upd_rec.sla_days := new_cur.sla_days;
            v_stage_upd_rec.sla_days_type := new_cur.sla_days_type;
            v_stage_upd_rec.sla_jeopardy_days := new_cur.sla_jeopardy_days;
            v_stage_upd_rec.jeopardy_flag := new_cur.jeopardy_flag;
            v_stage_upd_rec.timeliness_status := new_cur.timeliness_status;
            v_stage_upd_rec.date_today := new_cur.system_date;
            v_upd := 'Y';
         end if;                
             
         --*******************************************************                 
        v_step := 'UPD1_50 - Forwarded (NVL not needed)';
         if new_cur.forwarded_flag <> v_stage_upd_rec.forwarded_flag then
            v_stage_upd_rec.forwarded_flag := new_cur.forwarded_flag;
            v_stage_upd_rec.forwarded_by_name := new_cur.forwarded_by_name;
            v_stage_upd_rec.date_today  := new_cur.system_date;
            v_upd := 'Y';
         end if;           
         --*******************************************************                 
        v_step := 'UPD1_60 - Owner';
--dbms_output.put_line ('UPD1_60 - task_histID :'||new_cur.step_instance_history_id||' NEW Owner: '||new_cur.owner_name||' Old : '||v_stage_upd_rec.owner_name);
         if nvl(new_cur.owner_name,'mm') <> nvl(v_stage_upd_rec.owner_name,'mm') then
            v_stage_upd_rec.owner_name := new_cur.owner_name;
            v_stage_upd_rec.date_today := new_cur.system_date;
            v_upd := 'Y';
--dbms_output.put_line ('IN - UPD1_60 - task_histID :'||new_cur.step_instance_history_id||' NEW Owner: '||new_cur.owner_name||' Old : '||v_stage_upd_rec.owner_name) ;           
         end if;           
         --*******************************************************                 
        v_step := 'UPD1_70 - Group';
         if nvl(new_cur.group_name,'mm') <> nvl(v_stage_upd_rec.group_name,'mm') then
            v_stage_upd_rec.group_name := new_cur.group_name;
            v_stage_upd_rec.group_parent_name := new_cur.group_parent_name;
            v_stage_upd_rec.group_supervisor_name := new_cur.group_supervisor_name;
            v_stage_upd_rec.unit_of_work := new_cur.unit_of_work;
            v_stage_upd_rec.sla_days := new_cur.sla_days;
            v_stage_upd_rec.sla_days_type := new_cur.sla_days_type;
            v_stage_upd_rec.sla_jeopardy_days := new_cur.sla_jeopardy_days;
            v_stage_upd_rec.jeopardy_flag := new_cur.jeopardy_flag;
            v_stage_upd_rec.timeliness_status := new_cur.timeliness_status;                                                                                    
            v_stage_upd_rec.date_today := new_cur.system_date;
            v_upd := 'Y';
         end if;           
         --*******************************************************                 
        v_step := 'UPD1_80 - Team';
         if nvl(new_cur.team_name,'mm') <> nvl(v_stage_upd_rec.team_name,'mm') then
            v_stage_upd_rec.team_name := new_cur.team_name;
            v_stage_upd_rec.team_parent_name := new_cur.team_parent_name;
            v_stage_upd_rec.team_supervisor_name := new_cur.team_supervisor_name;                       
            v_stage_upd_rec.unit_of_work := new_cur.unit_of_work;
            v_stage_upd_rec.sla_days := new_cur.sla_days;
            v_stage_upd_rec.sla_days_type := new_cur.sla_days_type;
            v_stage_upd_rec.sla_jeopardy_days := new_cur.sla_jeopardy_days;
            v_stage_upd_rec.jeopardy_flag := new_cur.jeopardy_flag;
            v_stage_upd_rec.timeliness_status := new_cur.timeliness_status;                                                                                    
            v_stage_upd_rec.date_today := new_cur.system_date;
            v_upd := 'Y';
         end if;           
         --*******************************************************                 
        v_step := 'UPD1_90 - Reference';
         if nvl(new_cur.source_reference_id,99999999999999) <> nvl(v_stage_upd_rec.source_reference_id,99999999999999) then
            v_stage_upd_rec.source_reference_id := new_cur.source_reference_id;
            v_stage_upd_rec.source_reference_type := new_cur.source_reference_type;            
            v_stage_upd_rec.date_today := new_cur.system_date;
            v_upd := 'Y';
         end if;           
         --*******************************************************                 
        v_step := 'UPD1_100 - Status_Date';
         if nvl(new_cur.task_status,'mm') <> nvl(v_stage_upd_rec.task_status,'mm') OR
            nvl(new_cur.status_date,trunc(sysdate+200)) <> nvl(v_stage_upd_rec.status_date,trunc(sysdate+200))then
            v_stage_upd_rec.task_status := new_cur.task_status;
            v_stage_upd_rec.status_date := new_cur.status_date;
            v_stage_upd_rec.complete_flag := new_cur.complete_flag;
            v_stage_upd_rec.complete_date := new_cur.complete_date;
            v_stage_upd_rec.status_age_in_bus_days := new_cur.status_age_in_bus_days;
            v_stage_upd_rec.status_age_in_cal_days := new_cur.status_age_in_cal_days;                                                            
            v_stage_upd_rec.timeliness_status := new_cur.timeliness_status;
            v_stage_upd_rec.date_today := new_cur.system_date;
         v_upd := 'Y';
         end if; 
         --*******************************************************                 
        v_step := 'UPD1_110 - Client_ID';
         if nvl(new_cur.client_id,99999999999999) <> nvl(v_stage_upd_rec.client_id,99999999999999) then
            v_stage_upd_rec.client_id := new_cur.client_id;
            v_stage_upd_rec.date_today := new_cur.system_date;
            v_upd := 'Y';
         end if;     
         --*******************************************************                 
        v_step := 'UPD1_120 - Case_ID';
         if nvl(new_cur.case_id,99999999999999) <> nvl(v_stage_upd_rec.case_id,99999999999999) then
            v_stage_upd_rec.case_id := new_cur.case_id;
            v_stage_upd_rec.date_today := new_cur.system_date;
            v_upd := 'Y';
         end if;     
         --*******************************************************           
        v_step := 'UPD2_10 - Updated Calculated fields';
         if v_stage_upd_rec.cancel_work_flag = 'N' AND
            (v_stage_upd_rec.age_in_calendar_days IS NULL OR
             v_stage_upd_rec.age_in_calendar_days <> 
                    trunc(nvl(v_stage_upd_rec.complete_date, sysdate)) - trunc(v_stage_upd_rec.create_date)
             ) then
            v_stage_upd_rec.age_in_business_days := new_cur.age_in_business_days;
            v_stage_upd_rec.age_in_calendar_days := new_cur.age_in_calendar_days;            
            v_stage_upd_rec.jeopardy_flag := new_cur.jeopardy_flag;
            v_stage_upd_rec.status_age_in_bus_days := new_cur.status_age_in_bus_days;
            v_stage_upd_rec.status_age_in_cal_days := new_cur.status_age_in_cal_days;                                                            
            v_stage_upd_rec.timeliness_status := new_cur.timeliness_status;
            v_stage_upd_rec.date_today := new_cur.system_date;
            v_upd := 'Y';
         end if;          
        --*******************************************************                 
        v_step := 'TXF1 and TXF3l ASF Cancel Work ';
         if  v_stage_upd_rec.asf_complete_work = 'N' AND
             v_stage_upd_rec.asf_cancel_work = 'N' AND
             v_stage_upd_rec.cancel_work_flag = 'Y' THEN
            v_stage_upd_rec.asf_cancel_work := new_cur.yes;
            v_stage_upd_rec.stage_done_date := new_cur.system_date;           
            v_stage_upd_rec.date_today := new_cur.system_date;
            v_stage_upd_rec.cancel_method := 'Normal';
            v_stage_upd_rec.cancel_reason := 'Task was Terminated';
            v_stage_upd_rec.cancel_by := new_cur.last_update_by_name;
            v_upd := 'Y';
         end if;
        --*******************************************************                 
        v_step := 'TXF2 and TXF3 - ASF_COMPLETE_WORK ';
         if  v_stage_upd_rec.asf_complete_work = 'N' AND
             v_stage_upd_rec.asf_cancel_work = 'N' AND
             v_stage_upd_rec.complete_date is not null THEN
            v_stage_upd_rec.asf_complete_work := new_cur.yes;
            v_stage_upd_rec.stage_done_date := new_cur.system_date;           
            v_stage_upd_rec.date_today := new_cur.system_date;
            v_upd := 'Y';
         end if;                  
         --*******************************************************                 
         if v_upd = 'Y' then
            UPDATE corp_etl_manage_work_tmp a
                       SET ROW = v_stage_upd_rec
                     WHERE a.cemw_id = v_stage_upd_rec.cemw_id;
            update step_instance_stg set mw_processed = 'Y' 
            where step_instance_history_id = new_cur.step_instance_history_id;
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

  FUNCTION get_task_status_order
  (in_status IN VARCHAR2)
  RETURN INTEGER
  AS
    a INTEGER := 0;
    CURSOR crs_lkup
    IS
    SELECT VALUE, out_var
      FROM CORP_ETL_LIST_LKUP
     WHERE name      = 'MW_TASK_STATUS_ORDER'
       AND list_type = 'ORDER';
  BEGIN
    -- For performance, retieve once
    IF gv_task_status_rec.count = 0
    THEN
      FOR c IN crs_lkup
      LOOP gv_task_status_rec(a) := c;
           a := a + 1;
      END LOOP;
    END IF;
    -- Now identify the status order
    IF gv_task_status_rec.count > 0
    THEN
      FOR i IN gv_task_status_rec.first..gv_task_status_rec.last
      loop
        IF gv_task_status_rec(i).status = in_status
        THEN RETURN gv_task_status_rec(i).status_order;
        END IF;
      END LOOP;
    END IF;
    --
    RETURN NULL;
  END get_task_status_order;

end corp_etl_manage_work_pkg;
/
alter session set plsql_code_type = interpreted;
