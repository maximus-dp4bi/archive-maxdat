--------------------------------------------------------
--  File created - Tuesday-November-19-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package FLHK_ETL_MANAGE_WORK_PKG
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "FLHK_ETL_MANAGE_WORK_PKG" AS 
  con_pkg Constant  VARCHAR2(30) := 'flhk_etl_manage_work_pkg'; 
  procedure process_update_txnfrm(p_sucessful IN OUT VARCHAR2,
                                  p_error IN OUT VARCHAR2);
end flhk_etl_manage_work_pkg;

/
--------------------------------------------------------
--  File created - Tuesday-November-19-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body FLHK_ETL_MANAGE_WORK_PKG
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "FLHK_ETL_MANAGE_WORK_PKG" AS

  procedure process_update_txnfrm(p_sucessful IN OUT VARCHAR2,
                                  p_error IN OUT VARCHAR2) AS
  v_upd varchar2(1);
    v_stage_wip_rec    FLHK_ETL_MANAGE_WORK_WIP_BPM%ROWTYPE;
    CON_PROC  Constant  VARCHAR2(30) := 'flhk_etl_manage_work_pkg';
    v_step VARCHAR2(4000);    
    err_code NUMBER;
    err_msg varchar2(200);
	commit_cnt number;
  begin
    for OLTP_CUR in (
       SELECT  distinct MW_ID,
               TASK_ID,
               PARENT_TASK_ID,
               WRSTATUS_ID,
               TASK_TYPE,
               TASK_STATUS,
               STATUS_DATE,
               STATUS_REASON,
               CREATE_DATE, 
               CREATED_BY_NAME,
               PRIORITY,
               DUE_DATE,  
               ASSIGNED_TO,  
               QUEUE,
               CONTEXT,
               DRIVER_TYPE,
               DRIVER_KEY,
               ACTION_CATEGORY,
               RULE_EXECUTED, 
               ROLE_NAME,
               CANCEL_WORK_DATE,
               COMPLETE_DATE,
               INSTANCE_STATUS,
               LAST_UPDATE_DATE,
               LAST_UPDATE_BY_NAME,
               ASF_COMPLETE_WORK,        
                           'Y'               YES,
                           'N'               NO,
                           sysdate           SYSTEM_DATE
               FROM FLHK_ETL_MANAGE_WORK_OLTP_STG
    )
    loop
       v_step:= 'set variables';
       v_upd := 'N';
	   commit_cnt := 0;
       SELECT * INTO v_stage_wip_rec from FLHK_ETL_MANAGE_WORK_WIP_BPM 
                      where mw_id = OLTP_CUR.mw_id;
          --*******************************************************
        v_step := 'UPD1_10 Driver_Key';
        if OLTP_CUR.driver_key <> v_stage_wip_rec.driver_key then
            v_stage_wip_rec.driver_key  := OLTP_CUR.driver_key;
            v_stage_wip_rec.driver_type := OLTP_CUR.driver_type;
            v_stage_wip_rec.STG_LAST_UPDATE_DATE  := OLTP_CUR.system_date;
            v_stage_wip_rec.MW_PROCESSED := 'Y';
            v_upd := 'Y';
        end if;  
         --*******************************************************       
         --*******************************************************
        v_step := 'UPD1_20 Queue';
        if nvl(OLTP_CUR.queue, 'mm') <>  nvl(v_stage_wip_rec.queue, 'mm') then
            v_stage_wip_rec.queue      := OLTP_CUR.queue;
            v_stage_wip_rec.STG_LAST_UPDATE_DATE := OLTP_CUR.system_date;
            v_stage_wip_rec.MW_PROCESSED := 'Y';
            v_upd := 'Y';
        end if;  
         --*******************************************************                             
        v_step := 'UPD1_40 - Task Status';
        if OLTP_CUR.task_status <> v_stage_wip_rec.task_status then
            v_stage_wip_rec.task_status   := OLTP_CUR.task_status;
            v_stage_wip_rec.status_date   := OLTP_CUR.status_date;
            v_stage_wip_rec.task_type     := OLTP_CUR.task_type;
            v_stage_wip_rec.status_reason := OLTP_CUR.status_reason;
            v_stage_wip_rec.STG_LAST_UPDATE_DATE    := OLTP_CUR.system_date;
            v_stage_wip_rec.MW_PROCESSED := 'Y';
            v_upd := 'Y';
        end if;                
             
         --*******************************************************                 
        v_step := 'UPD1_50 - ASSIGN_TO';
        if nvl(OLTP_CUR.assigned_to, 'mm') <> nvl(v_stage_wip_rec.assigned_to, 'mm') then
            v_stage_wip_rec.assigned_to := OLTP_CUR.assigned_to;
            v_stage_wip_rec.STG_LAST_UPDATE_DATE  := OLTP_CUR.system_date;
            v_stage_wip_rec.MW_PROCESSED := 'Y';
            v_upd := 'Y';
         end if;           
         --*******************************************************                 
         v_step := 'UPD1_60 - Task_Type';
         if nvl(OLTP_CUR.task_type, 'mm') <> nvl(v_stage_wip_rec.task_type, 'mm') then
            v_stage_wip_rec.task_status   := OLTP_CUR.task_status;
            v_stage_wip_rec.status_date   := OLTP_CUR.status_date;
            v_stage_wip_rec.task_type     := OLTP_CUR.task_type;
            v_stage_wip_rec.status_reason := OLTP_CUR.status_reason;
            v_stage_wip_rec.STG_LAST_UPDATE_DATE    := OLTP_CUR.system_date;
            v_stage_wip_rec.MW_PROCESSED := 'Y';
            v_upd := 'Y';
         end if;           
         --*******************************************************                 
         v_step := 'UPD1_70 - Due_date';
         if nvl(OLTP_CUR.due_date, '01-JAN-1900') <> nvl(v_stage_wip_rec.due_date,'01-JAN-1900') then
            v_stage_wip_rec.due_date   := OLTP_CUR.due_date;
            v_stage_wip_rec.STG_LAST_UPDATE_DATE := OLTP_CUR.system_date;
            v_stage_wip_rec.MW_PROCESSED := 'Y';
            v_upd := 'Y';
         end if;           
         --*******************************************************                 
         v_step := 'UPD1_80 - Rule_executed or role_name';
         if (nvl(OLTP_CUR.rule_executed,'mm') <> nvl(v_stage_wip_rec.rule_executed,'mm')) OR
            (nvl(OLTP_CUR.role_name, 'mm') <> nvl(v_stage_wip_rec.rule_executed, 'mm')) then
            v_stage_wip_rec.rule_executed := OLTP_CUR.rule_executed;
            v_stage_wip_rec.role_name     := OLTP_CUR.role_name;                                                                                    
            v_stage_wip_rec.STG_LAST_UPDATE_DATE    := OLTP_CUR.system_date;
            v_stage_wip_rec.MW_PROCESSED := 'Y';
            v_upd := 'Y';
         end if;           
         --*******************************************************                 
         v_step := 'UPD1_90 - Priority';
         if OLTP_CUR.priority <> v_stage_wip_rec.priority then
            v_stage_wip_rec.priority := OLTP_CUR.priority;  
            v_stage_wip_rec.STG_LAST_UPDATE_DATE := OLTP_CUR.system_date;
            v_stage_wip_rec.MW_PROCESSED := 'Y';
            v_upd := 'Y';
         end if;           
         --*******************************************************                 
         v_step := 'UPD1_100 - Last_update_by_name';
         if nvl(OLTP_CUR.last_update_by_name,'mm') <> nvl(v_stage_wip_rec.last_update_by_name,'mm') then
            v_stage_wip_rec.last_update_by_name := OLTP_CUR.last_update_by_name;                                                            
            v_stage_wip_rec.STG_LAST_UPDATE_DATE := OLTP_CUR.system_date;
            v_stage_wip_rec.MW_PROCESSED := 'Y';
         v_upd := 'Y';
         end if; 
        --*******************************************************       
         v_step := 'UPD1_110 - Last_update_date';
         if nvl(OLTP_CUR.last_update_date,'01-JAN-1900') <> nvl(v_stage_wip_rec.last_update_date,'01-JAN-1900')  then
            v_stage_wip_rec.last_update_date := OLTP_CUR.last_update_date;                                                            
            v_stage_wip_rec.STG_LAST_UPDATE_DATE := OLTP_CUR.system_date;
            v_stage_wip_rec.MW_PROCESSED := 'Y';
         v_upd := 'Y';
         end if; 
         --*******************************************************
         v_step := 'UPD3_10 - Task completed';
         if (OLTP_CUR.task_status = 'RESOLVED')  then
            v_stage_wip_rec.complete_date := OLTP_CUR.status_date;
            v_stage_wip_rec.stage_done_date := OLTP_CUR.system_date;
            v_stage_wip_rec.asf_complete_work := 'Y';
            v_stage_wip_rec.STG_LAST_UPDATE_DATE := OLTP_CUR.system_date;
            v_stage_wip_rec.MW_PROCESSED := 'Y';
            v_stage_wip_rec.INSTANCE_STATUS := 'COMPLETE';
            v_upd := 'Y';
        end if;
        if v_upd = 'Y' then
            UPDATE FLHK_ETL_MANAGE_WORK_WIP_BPM a
                       SET ROW = v_stage_wip_rec
                     WHERE a.mw_id = v_stage_wip_rec.mw_id;
			if commit_cnt > 100 then 
               COMMIT;
			   commit_cnt := 0;
			end if;
        end if;
		commit_cnt := commit_cnt + 1;
    end loop;    
    p_sucessful := 'Y';
    p_error     := con_proc || ': Sucessful';
EXCEPTION
    WHEN OTHERS THEN
    Begin
        err_code := SQLCODE;
        err_msg := substr(SQLERRM, 1, 200);
        INSERT INTO CORP_ETL_ERROR_LOG 
         (err_date, err_level, process_name, job_name, nr_of_error, error_desc, 
          error_field, error_codes, driver_table_name, driver_key_number, create_ts, update_ts)	 
        VALUES (sysdate, 'ABORT', 'Manage Work', 'ManageWork Capture OLTP', 
         err_code, err_msg, null, err_code, null, v_stage_wip_rec.mw_id, sysdate, sysdate);
        p_sucessful := 'N';
        p_error     := con_proc || ': '|| v_step || ': ' || SQLERRM;
    END;
  END process_update_txnfrm;

END FLHK_ETL_MANAGE_WORK_PKG;

/

