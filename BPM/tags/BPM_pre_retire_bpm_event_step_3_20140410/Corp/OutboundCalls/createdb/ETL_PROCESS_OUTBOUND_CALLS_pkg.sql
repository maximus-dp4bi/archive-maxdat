alter session set plsql_code_type = native;

create or replace 
package ETL_PROCESS_OUTBOUND_CALLS_PKG as

  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  procedure COPY_CALLS_TO_TEMP;

end ETL_PROCESS_OUTBOUND_CALLS_PKG;
/

create or replace 
package body ETL_PROCESS_OUTBOUND_CALLS_PKG as

  procedure COPY_CALLS_TO_TEMP as
  
    CURSOR calls_cur IS
    SELECT cepoc_id, job_id, row_id, case_cin, campaign_id, campaign_indicator
         , create_dt, case_id, client_id, program, subprogram, language
         , error_count, error_text, job_end_dt, state_rep_home_phone, client_rep_home_phone
         , client_rep_cell_phone, phone_numbers_provided, letter_request_id, attempts_required
         , attempts_made, dial_cycle_outcome, assd_transmit_to_dialer, ased_transmit_to_dialer
         , asf_transmit_to_dialer, assd_process_outcome, ased_process_outcome, asf_process_outcome
         , complete_dt, cancel_dt, cancel_reason, cancel_method, instance_status
         , stg_extract_date, stg_last_update_date, stage_done_date
     FROM corp_etl_proc_outbnd_call
    WHERE complete_dt IS NULL;

   TYPE t_call_tab IS TABLE OF calls_cur%ROWTYPE INDEX BY PLS_INTEGER;
    v_tab        t_call_tab;
    v_bulk_limit NUMBER := 5000;
    v_step       VARCHAR2(100);
    v_tab_name   VARCHAR2(30);

  begin
   v_step := 'Truncate temp tables';
   EXECUTE IMMEDIATE 'truncate table CORP_ETL_PROC_OUTBND_CALL_WIP';
   EXECUTE IMMEDIATE 'truncate table CORP_ETL_PROC_OUTBND_CALL_OLTP';

   OPEN calls_cur;
   LOOP
     FETCH calls_cur BULK COLLECT INTO v_tab LIMIT v_bulk_limit;
     EXIT WHEN v_tab.COUNT = 0; -- Exit when missing rows

     FOR i IN 1 .. v_tab.COUNT LOOP
       BEGIN
         v_tab_name := 'CORP_ETL_PROC_OUTBND_CALL_WIP';
         v_step := 'Inserting WIP';
         INSERT INTO corp_etl_proc_outbnd_call_wip 
         ( cepoc_id, job_id, row_id, case_cin, campaign_id, campaign_indicator
         , create_dt, case_id, client_id, program, subprogram, language
         , error_count, error_text, job_end_dt, state_rep_home_phone
         , client_rep_home_phone, client_rep_cell_phone, phone_numbers_provided
         , letter_request_id, attempts_required, attempts_made, dial_cycle_outcome
         , assd_transmit_to_dialer, ased_transmit_to_dialer, asf_transmit_to_dialer
         , assd_process_outcome, ased_process_outcome, asf_process_outcome
         , complete_dt, cancel_dt, cancel_reason, cancel_method
         , instance_status, stg_extract_date, stg_last_update_date, stage_done_date)
         VALUES
         ( v_tab(i).cepoc_id, v_tab(i).job_id, v_tab(i).row_id, v_tab(i).case_cin, v_tab(i).campaign_id, v_tab(i).campaign_indicator
         , v_tab(i).create_dt, v_tab(i).case_id, v_tab(i).client_id, v_tab(i).program, v_tab(i).subprogram, v_tab(i).language
         , v_tab(i).error_count, v_tab(i).error_text, v_tab(i).job_end_dt, v_tab(i).state_rep_home_phone
         , v_tab(i).client_rep_home_phone, v_tab(i).client_rep_cell_phone, v_tab(i).phone_numbers_provided
         , v_tab(i).letter_request_id, v_tab(i).attempts_required, v_tab(i).attempts_made, v_tab(i).dial_cycle_outcome
         , v_tab(i).assd_transmit_to_dialer, v_tab(i).ased_transmit_to_dialer, v_tab(i).asf_transmit_to_dialer
         , v_tab(i).assd_process_outcome, v_tab(i).ased_process_outcome, v_tab(i).asf_process_outcome
         , v_tab(i).complete_dt, v_tab(i).cancel_dt, v_tab(i).cancel_reason, v_tab(i).cancel_method
         , v_tab(i).instance_status, v_tab(i).stg_extract_date, v_tab(i).stg_last_update_date, v_tab(i).stage_done_date);


         v_tab_name := 'CORP_ETL_PROC_OUTBND_CALL_OLTP';
         v_step := 'Inserting OLTP';
         INSERT INTO corp_etl_proc_outbnd_call_oltp 
         ( cepoc_id, job_id, row_id, case_cin, campaign_id
         , campaign_indicator, create_dt, case_id, client_id
         , program, subprogram, language, error_count, error_text
         , job_end_dt, state_rep_home_phone, client_rep_home_phone
         , client_rep_cell_phone, phone_numbers_provided, letter_request_id
         , attempts_required, attempts_made, dial_cycle_outcome
         , assd_transmit_to_dialer, ased_transmit_to_dialer, asf_transmit_to_dialer
         , assd_process_outcome, ased_process_outcome, asf_process_outcome
         , complete_dt, cancel_dt, cancel_reason, cancel_method
         , instance_status, stg_extract_date, stg_last_update_date
         , stage_done_date)
         VALUES
         ( v_tab(i).cepoc_id, v_tab(i).job_id, v_tab(i).row_id, v_tab(i).case_cin, v_tab(i).campaign_id
         , v_tab(i).campaign_indicator, v_tab(i).create_dt, v_tab(i).case_id, v_tab(i).client_id
         , v_tab(i).program, v_tab(i).subprogram, v_tab(i).language, v_tab(i).error_count, v_tab(i).error_text
         , v_tab(i).job_end_dt, v_tab(i).state_rep_home_phone, v_tab(i).client_rep_home_phone
         , v_tab(i).client_rep_cell_phone, v_tab(i).phone_numbers_provided, v_tab(i).letter_request_id
         , v_tab(i).attempts_required, v_tab(i).attempts_made, v_tab(i).dial_cycle_outcome
         , v_tab(i).assd_transmit_to_dialer, v_tab(i).ased_transmit_to_dialer, v_tab(i).asf_transmit_to_dialer
         , v_tab(i).assd_process_outcome, v_tab(i).ased_process_outcome, v_tab(i).asf_process_outcome
         , v_tab(i).complete_dt, v_tab(i).cancel_dt, v_tab(i).cancel_reason, v_tab(i).cancel_method
         , v_tab(i).instance_status, v_tab(i).stg_extract_date, v_tab(i).stg_last_update_date
         , v_tab(i).stage_done_date);


       EXCEPTION
         WHEN OTHERS THEN
           corp_etl_stage_pkg.log_etl_autonomous_critical
                              (IN_JOB_NAME          => $$PLSQL_UNIT      
                              ,IN_PROCESS_NAME      => 'COPY_CALLS_TO_TEMP'   
                              ,IN_NR_OF_ERROR       => 1
                              ,IN_ERROR_DESC        => SUBSTR(SQLERRM, 1, 200) 
                              ,IN_ERROR_CODES       => SQLCODE 
                              ,IN_ERROR_FIELD       => NULL 
                              ,IN_DRIVER_TABLE_NAME => v_tab_name     
                              ,IN_DRIVER_KEY_NUMBER => v_tab(i).cepoc_id);
       END;
     END LOOP;
     COMMIT;
   END LOOP;
   CLOSE calls_cur;

  end COPY_CALLS_TO_TEMP;

end ETL_PROCESS_OUTBOUND_CALLS_PKG;
/

alter session set plsql_code_type = interpreted;
