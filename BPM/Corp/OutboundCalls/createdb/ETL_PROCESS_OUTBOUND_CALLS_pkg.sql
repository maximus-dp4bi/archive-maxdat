alter session set plsql_code_type = native;

create or replace package maxdat.ETL_PROCESS_OUTBOUND_CALLS_PKG as

  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  procedure COPY_CALLS_TO_TEMP;
  procedure MOVE_WIP_TO_BPM;
  procedure UPD1_04;
  procedure UPD1_05;
  procedure UPDATES_FROM_OLTP_1;
  procedure UPD_DIAL_CYCLE_OUTCOME;
  
end ETL_PROCESS_OUTBOUND_CALLS_PKG;
/
create or replace package body maxdat.ETL_PROCESS_OUTBOUND_CALLS_PKG as

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

procedure MOVE_WIP_TO_BPM as

    CURSOR calls_cur IS
    SELECT cepoc_id, job_id, row_id, case_cin, campaign_id, campaign_indicator
         , create_dt, case_id, client_id, program, subprogram, language
         , error_count, error_text, job_end_dt, state_rep_home_phone, client_rep_home_phone
         , client_rep_cell_phone, phone_numbers_provided, letter_request_id, attempts_required
         , attempts_made, dial_cycle_outcome, assd_transmit_to_dialer, ased_transmit_to_dialer
         , asf_transmit_to_dialer, assd_process_outcome, ased_process_outcome, asf_process_outcome
         , complete_dt, cancel_dt, cancel_reason, cancel_method, instance_status
         , stg_extract_date, stg_last_update_date, stage_done_date
  from CORP_ETL_PROC_OUTBND_CALL_WIP tmp 
  where UPDATED = 'Y';

   TYPE t_call_tab IS TABLE OF calls_cur%ROWTYPE INDEX BY PLS_INTEGER;
    v_tab        t_call_tab;
    v_bulk_limit NUMBER := 5000;
    v_step       VARCHAR2(100);
    v_tab_name   VARCHAR2(30);

  begin
   
   OPEN calls_cur;
   LOOP
     FETCH calls_cur BULK COLLECT INTO v_tab LIMIT v_bulk_limit;
     EXIT WHEN v_tab.COUNT = 0; -- Exit when missing rows

     FOR i IN 1 .. v_tab.COUNT LOOP
       BEGIN
         v_tab_name := 'CORP_ETL_PROC_OUTBND_CALL_WIP';
         v_step := 'Moving WIP to BPM';
         update corp_etl_proc_outbnd_call
            set
                /* v_tab(i).job_id
                ,v_tab(i).row_id
                ,v_tab(i).case_cin 
                ,v_tab(i).campaign_id 
                ,v_tab(i).campaign_indicator
                ,v_tab(i).create_dt
                ,v_tab(i).case_id
                ,v_tab(i).client_id 
                ,v_tab(i).program 
                ,v_tab(i).subprogram
                ,v_tab(i).language
                ,v_tab(i).error_count 
                ,v_tab(i).error_text*/
                 job_end_dt = v_tab(i).job_end_dt 
               /* ,v_tab(i).state_rep_home_phone
                ,v_tab(i).client_rep_home_phone
                ,v_tab(i).client_rep_cell_phone 
                ,v_tab(i).phone_numbers_provided*/
                ,letter_request_id = v_tab(i).letter_request_id
                ,attempts_required = v_tab(i).attempts_required
                ,attempts_made = v_tab(i).attempts_made
                ,dial_cycle_outcome = v_tab(i).dial_cycle_outcome
                ,assd_transmit_to_dialer = v_tab(i).assd_transmit_to_dialer
                ,ased_transmit_to_dialer = v_tab(i).ased_transmit_to_dialer 
                ,asf_transmit_to_dialer = v_tab(i).asf_transmit_to_dialer
                ,assd_process_outcome = v_tab(i).assd_process_outcome
                ,ased_process_outcome = v_tab(i).ased_process_outcome 
                ,asf_process_outcome = v_tab(i).asf_process_outcome
                ,complete_dt = v_tab(i).complete_dt 
                ,cancel_dt = v_tab(i).cancel_dt
                ,cancel_reason = v_tab(i).cancel_reason
                ,cancel_method = v_tab(i).cancel_method
                ,instance_status = v_tab(i).instance_status 
                ,stg_extract_date = v_tab(i).stg_extract_date 
                ,stg_last_update_date = v_tab(i).stg_last_update_date
                ,stage_done_date = v_tab(i).stage_done_date
        where cepoc_id = v_tab(i).cepoc_id;


       EXCEPTION
         WHEN OTHERS THEN
           corp_etl_stage_pkg.log_etl_autonomous_critical
                              (IN_JOB_NAME          => $$PLSQL_UNIT
                              ,IN_PROCESS_NAME      => 'MOVE_WIP_TO_BPM'
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

  end MOVE_WIP_TO_BPM;

procedure UPD1_04 as

   CURSOR calls_cur IS
   SELECT 
         o2.CEPOC_ID, o2.CASE_CIN, o2.CAMPAIGN_INDICATOR, o2.SUBPROGRAM, o2.CREATE_DT, o2.job_id
        ,'Y'  IN_YES
        ,'N'	IN_NO
        ,'Complete' FINAL_STATUS,
        SYSDATE AS TODAY,
        'Active Instance Duplicated' AS CANCEL_REASON,
        'Normal' AS CANCEL_METHOD
   FROM corp_etl_proc_outbnd_call o1 --Not using OLTP stage table anymore; 05/06/2015 Raj A.
   JOIN corp_etl_proc_outbnd_call o2
    on  o2.job_id > o1.job_id
   and o1.complete_dt is null
   and o2.complete_dt is null
   and o1.case_cin = o2.case_cin
   and o1.CAMPAIGN_INDICATOR = o2.CAMPAIGN_INDICATOR
   and o1.SUBPROGRAM = o2.SUBPROGRAM
   and TRUNC(o2.CREATE_DT) between TRUNC(o1.CREATE_DT) and TRUNC(o1.CREATE_DT)+20
   ;

   TYPE t_call_tab IS TABLE OF calls_cur%ROWTYPE INDEX BY PLS_INTEGER;
    v_tab        t_call_tab;
    v_bulk_limit NUMBER := 5000;
    v_step       VARCHAR2(100);
    v_tab_name   VARCHAR2(30);

  begin
   
   OPEN calls_cur;
   LOOP
     FETCH calls_cur BULK COLLECT INTO v_tab LIMIT v_bulk_limit;
     EXIT WHEN v_tab.COUNT = 0; -- Exit when missing rows

     FOR i IN 1 .. v_tab.COUNT LOOP
       BEGIN
         v_tab_name := 'CORP_ETL_PROC_OUTBND_CALL';
         v_step := 'Processing UPD1_04 rule and updating BPM stage table.';
         update corp_etl_proc_outbnd_call
            set
                cancel_dt = v_tab(i).TODAY
                ,complete_dt = v_tab(i).TODAY                
                ,cancel_reason = v_tab(i).CANCEL_REASON
                ,cancel_method = v_tab(i).CANCEL_METHOD
                ,instance_status = v_tab(i).FINAL_STATUS
                ,stage_done_date = v_tab(i).TODAY
               -- ,updated = v_tab(i).IN_YES
        where cepoc_id = v_tab(i).cepoc_id;


       EXCEPTION
         WHEN OTHERS THEN
           corp_etl_stage_pkg.log_etl_autonomous_critical
                              (IN_JOB_NAME          => $$PLSQL_UNIT
                              ,IN_PROCESS_NAME      => 'UPD1_04'
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

  end UPD1_04;

procedure UPD1_05 as

   CURSOR calls_cur IS  
    SELECT	
           'Y'		IN_YES
           ,'N'	IN_NO
           ,'Complete' FINAL_STATUS,        
           SYSDATE AS TODAY,
           'Request Created-No Phone Numbers' AS CANCEL_REASON,
           'Normal' AS CANCEL_METHOD,
           CEPOC_ID		CEPOC_ID   
    FROM CORP_ETL_PROC_OUTBND_CALL
    WHERE 1=1
    and complete_dt is null
    and ERROR_COUNT = 1
    and ERROR_TEXT = '[no phone]'
    and STATE_REP_HOME_PHONE is null
    and CLIENT_REP_HOME_PHONE is null
    and CLIENT_REP_CELL_PHONE is null     
    ;

   TYPE t_call_tab IS TABLE OF calls_cur%ROWTYPE INDEX BY PLS_INTEGER;
    v_tab        t_call_tab;
    v_bulk_limit NUMBER := 5000;
    v_step       VARCHAR2(100);
    v_tab_name   VARCHAR2(30);

  begin
   
   OPEN calls_cur;
   LOOP
     FETCH calls_cur BULK COLLECT INTO v_tab LIMIT v_bulk_limit;
     EXIT WHEN v_tab.COUNT = 0; -- Exit when missing rows

     FOR i IN 1 .. v_tab.COUNT LOOP
       BEGIN
         v_tab_name := 'CORP_ETL_PROC_OUTBND_CALL';
         v_step := 'Processing UPD1_05 rule and updating BPM stage table.';
         update corp_etl_proc_outbnd_call
            set
                cancel_dt = v_tab(i).TODAY
                ,complete_dt = v_tab(i).TODAY                
                ,cancel_reason = v_tab(i).CANCEL_REASON
                ,cancel_method = v_tab(i).CANCEL_METHOD
                ,instance_status = v_tab(i).FINAL_STATUS
                ,stage_done_date = v_tab(i).TODAY
               -- ,updated = v_tab(i).IN_YES
        where cepoc_id = v_tab(i).cepoc_id;


       EXCEPTION
         WHEN OTHERS THEN
           corp_etl_stage_pkg.log_etl_autonomous_critical
                              (IN_JOB_NAME          => $$PLSQL_UNIT
                              ,IN_PROCESS_NAME      => 'UPD1_05'
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

  end UPD1_05;
  
  procedure UPDATES_FROM_OLTP_1 as

   CURSOR calls_cur IS     
    select distinct 
           A.*,
           s.END_TS as job_end_dt
      from
    (
    SELECT oltp.CEPOC_ID, 
           oltp.job_id,
           count(NUMBER_DIALED) AS ATTEMPTS_MADE,
           MIN(CALL_START_DT)   AS CALL_START,
           MAX(CALL_end_DT)     AS CALL_END
      from (select oltp.* 
              from CORP_ETL_PROC_OUTBND_CALL_OLTP oltp
              join CORP_ETL_PROC_OUTBND_CALL_WIP wip
                               on wip.cepoc_id = oltp.cepoc_id
             where oltp.INSTANCE_STATUS = 'Active'
               and wip.INSTANCE_STATUS = 'Active') oltp
      LEFT OUTER join corp_etl_proc_outbnd_call_dtl dtl
                 on oltp.cepoc_id = dtl.cepoc_id
      group by oltp.CEPOC_ID, oltp.job_id
      ) A
      join  etl_e_dialer_run_stg  s  
            on A.job_id = s.job_id  
    ;

   TYPE t_call_tab IS TABLE OF calls_cur%ROWTYPE INDEX BY PLS_INTEGER;
    v_tab        t_call_tab;
    v_bulk_limit NUMBER := 5000;
    v_step       VARCHAR2(100);
    v_tab_name   VARCHAR2(30);

  begin
   
   OPEN calls_cur;
   LOOP
     FETCH calls_cur BULK COLLECT INTO v_tab LIMIT v_bulk_limit;
     EXIT WHEN v_tab.COUNT = 0; -- Exit when missing rows

     FOR i IN 1 .. v_tab.COUNT LOOP
       BEGIN
         v_tab_name := 'CORP_ETL_PROC_OUTBND_CALL_OLTP';
         v_step := 'Getting updates from the source system and updating OLTP stage table.';
         update corp_etl_proc_outbnd_call_oltp
            set
                ATTEMPTS_MADE = v_tab(i).ATTEMPTS_MADE
                ,CALL_START = v_tab(i).CALL_START          
                ,CALL_END = v_tab(i).CALL_END
                ,JOB_END_DT = v_tab(i).JOB_END_DT       
        where cepoc_id = v_tab(i).cepoc_id;


       EXCEPTION
         WHEN OTHERS THEN
           corp_etl_stage_pkg.log_etl_autonomous_critical
                              (IN_JOB_NAME          => $$PLSQL_UNIT
                              ,IN_PROCESS_NAME      => 'UPDATES_FROM_OLTP_1'
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

  end UPDATES_FROM_OLTP_1;

procedure UPD_DIAL_CYCLE_OUTCOME as

   CURSOR calls_cur IS    
    select * from  
    (SELECT distinct oltp.CEPOC_ID,
            case when ref_type = 'SUCCESS'
                 then 'Successful'
            end as outcome
       from corp_etl_proc_outbnd_call_oltp oltp
       JOIN corp_etl_proc_outbnd_call_dtl dtl
            ON oltp.cepoc_id = dtl.cepoc_id
       JOIN CORP_ETL_LIST_LKUP RES
            ON DTL.CALL_RESULT = RES.out_var
            AND name ='OUTBOUND_CALL_RESULT'
       )
    where outcome is not null
    union all  --------
    select * from 
    (SELECT distinct oltp.CEPOC_ID,
            case when ref_type = 'FAILURE'
                 then 'Unsuccessful'
            end as outcome
            from corp_etl_proc_outbnd_call_oltp oltp
            join corp_etl_proc_outbnd_call_dtl dtl
                 ON oltp.cepoc_id = dtl.cepoc_id
            JOIN CORP_ETL_LIST_LKUP RES
                 ON DTL.CALL_RESULT = RES.out_var
                 AND name ='OUTBOUND_CALL_RESULT'
    )
    where outcome is not null 
    and cepoc_id not in (select distinct cepoc_id 
                           from (SELECT distinct oltp.CEPOC_ID,
                                        case when ref_type = 'SUCCESS'
                                             then 'Successful'
                                        end as outcome
                                  from corp_etl_proc_outbnd_call_oltp oltp
                                  join corp_etl_proc_outbnd_call_dtl dtl
                                       ON oltp.cepoc_id = dtl.cepoc_id
                                  JOIN CORP_ETL_LIST_LKUP RES
                                       ON DTL.CALL_RESULT = RES.out_var
                                       AND name ='OUTBOUND_CALL_RESULT'
                                    )
                            where outcome is not null
                           )
    union all --------
select distinct cepoc_id,
       case when sum(count_result) over (partition by cepoc_id)/(ATTEMPTS_REQUIRED * PHONE_NUMBERS_PROVIDED) >= 1 
            then 'Unsuccessful'
       else null
       end as outcome
from 
(SELECT distinct oltp.CEPOC_ID,
        PHONE_NUMBERS_PROVIDED,NUMBER_DIALED,ATTEMPTS_REQUIRED,
        count(DIALER_ATTEMPT_ID) over (partition by oltp.cepoc_id,NUMBER_DIALED) as count_result,
        ref_type
   from corp_etl_proc_outbnd_call_oltp oltp
   JOIN corp_etl_proc_outbnd_call_dtl dtl
        ON oltp.cepoc_id = dtl.cepoc_id
   JOIN CORP_ETL_LIST_LKUP RES
        ON DTL.CALL_RESULT = RES.out_var
    and name ='OUTBOUND_CALL_RESULT'
    and oltp.cepoc_id not in (select  cepoc_id 
                                from (select * from  
                                              (SELECT distinct oltp.CEPOC_ID,
                                                      case when ref_type = 'SUCCESS'
                                                           then 'Successful'
                                                      end as outcome
                                              from corp_etl_proc_outbnd_call_oltp oltp
                                              join corp_etl_proc_outbnd_call_dtl dtl
                                              on oltp.cepoc_id = dtl.cepoc_id
                                              JOIN CORP_ETL_LIST_LKUP RES
                                              ON DTL.CALL_RESULT = RES.out_var
                                              and name ='OUTBOUND_CALL_RESULT'
                                              )
                            where outcome is not null
                            union all
                            select * 
                            from (SELECT distinct oltp.CEPOC_ID,
                                                  case when ref_type = 'FAILURE'
                                                       then 'Unsuccessful'
                                                  end as outcome
                                                  from corp_etl_proc_outbnd_call_oltp oltp
                                                  join corp_etl_proc_outbnd_call_dtl dtl
                                                       on oltp.cepoc_id = dtl.cepoc_id
                                                  JOIN CORP_ETL_LIST_LKUP RES
                                                      ON DTL.CALL_RESULT = RES.out_var
                                                      and name ='OUTBOUND_CALL_RESULT'
                                     )
                            where outcome is not null 
                            and cepoc_id not in (select distinct cepoc_id 
                                                   from (SELECT distinct oltp.CEPOC_ID,
                                                  case when ref_type = 'SUCCESS'
                                                       then 'Successful'
                                                  end as outcome
                                                  from corp_etl_proc_outbnd_call_oltp oltp
                                                  join corp_etl_proc_outbnd_call_dtl dtl
                                                       on oltp.cepoc_id = dtl.cepoc_id
                                                  JOIN CORP_ETL_LIST_LKUP RES
                                                       ON DTL.CALL_RESULT = RES.out_var
                                                       and name ='OUTBOUND_CALL_RESULT'
                                                  )
                                                  where outcome is not null)
                                          )
                             )
)                            
    ;

   TYPE t_call_tab IS TABLE OF calls_cur%ROWTYPE INDEX BY PLS_INTEGER;
    v_tab        t_call_tab;
    v_bulk_limit NUMBER := 5000;
    v_step       VARCHAR2(100);
    v_tab_name   VARCHAR2(30);

  begin
   
   OPEN calls_cur;
   LOOP
     FETCH calls_cur BULK COLLECT INTO v_tab LIMIT v_bulk_limit;
     EXIT WHEN v_tab.COUNT = 0; -- Exit when missing rows

     FOR i IN 1 .. v_tab.COUNT LOOP
       BEGIN
         v_tab_name := 'CORP_ETL_PROC_OUTBND_CALL_OLTP';
         v_step := 'Updating DIAL_CYCLE_OUTCOME attribute in the OLTP stage table.';
         update corp_etl_proc_outbnd_call_oltp
            set
                DIAL_CYCLE_OUTCOME = v_tab(i).OUTCOME
        where cepoc_id = v_tab(i).cepoc_id;


       EXCEPTION
         WHEN OTHERS THEN
           corp_etl_stage_pkg.log_etl_autonomous_critical
                              (IN_JOB_NAME          => $$PLSQL_UNIT
                              ,IN_PROCESS_NAME      => 'UPD_DIAL_CYCLE_OUTCOME'
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

  end UPD_DIAL_CYCLE_OUTCOME;

end ETL_PROCESS_OUTBOUND_CALLS_PKG;
/

alter session set plsql_code_type = interpreted;