alter session set plsql_code_type = native;

/*
Created on 11-Apr-2013 by Raj A.
Description:
This trigger populates stage_create_ts(in case :NEW.stage_create_ts is null) and stage_update_ts although the Stage_create_ts gets 
populated by the KTR, ManageWork_Capture_OLTP.ktr
*/
-- Trigger previously named step_instance_stg_TRG
CREATE OR REPLACE TRIGGER TRG_BIU_STEP_INSTANCE_STG
BEFORE INSERT OR UPDATE ON STEP_INSTANCE_STG
FOR EACH ROW
BEGIN
  IF INSERTING and :NEW.stage_create_ts IS NULL THEN
	     :NEW.stage_create_ts := SYSDATE;    
  END IF;

  :NEW.stage_update_ts := SYSDATE;

  -- NYHIX-4273 MW status orders
  IF INSERTING THEN
    :new.status_order := corp_etl_stage_pkg.get_task_status_order(:new.hist_status);
    -- Now throw exception if ORDER not established
    IF NVL(:new.status_order,-1) < 0
    THEN corp_etl_stage_pkg.log_etl_critical
            (in_job_name          => $$PLSQL_UNIT
            ,in_process_name      => $$PLSQL_UNIT
            ,in_nr_of_error       => 1
            ,in_error_desc        => 'Task status order not defined, STATUS_ORDER => '||:new.status_order
            ,in_error_field       => 'HIST_STATUS'
            ,in_error_codes       => :new.hist_status
            ,in_driver_table_name => 'STEP_STAGE_INSTANCE'
            ,in_driver_key_number => :new.step_instance_history_id);
    END IF;
  END IF;
END;
/

alter session set plsql_code_type = interpreted;
