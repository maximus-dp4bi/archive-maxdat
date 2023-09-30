DECLARE  
  CURSOR temp_cur IS
  select * 
  from (
  select letter_request_id,process_letters.GET_TIMELINE_STATUS(program,
     create_date,
     complete_date,
     mailed_date,
     letter_type,case_id) correct_timeliness_status
     , process_letters.GET_JEOPARDY_DAYS (program,letter_type) correct_jeopardy_days
     , process_letters.GET_JEOPARDY_DATE (program,create_date,letter_type) correct_jeopardy_date
     ,process_letters.GET_JEOPARDY_STATUS (program,create_date,complete_date,letter_type) correct_jeopardy_status
     ,process_letters.GET_SLA_DAYS(program,letter_type) correct_sla_days
     ,process_letters.GET_SLA_DAYS_TYPE(program,letter_type) correct_sla_days_type
     ,process_letters.GET_SLA_TARGET_DAYS(program,letter_type) correct_target_days
     ,timeliness_status
     ,sla_jeopardy_days
     ,sla_jeopardy_date
     ,jeopardy_status
     ,sla_days
     ,sla_days_type
     ,sla_target_days
  from d_pl_current
  where letter_type in('Checkup Reminder Dental Letter','Checkup Reminder Medical Letter','Checkup Due Dental Letter','Checkup Due Medical Letter')
  and instance_status = 'Complete')
  where timeliness_status <> correct_timeliness_status
    or sla_jeopardy_days <> correct_jeopardy_days
    or sla_jeopardy_date <>  correct_jeopardy_date
    or jeopardy_status <> correct_jeopardy_status
    or sla_days <> correct_sla_days
    or sla_days_type <> correct_sla_days_type
    or sla_target_days <> correct_target_days;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;
BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FOR indx IN 1..temp_tab.COUNT LOOP
           -- v_ased_selection_recd := temp_tab(indx).ASED_SELECTION_RECD; 
          UPDATE d_pl_current
            SET timeliness_status = temp_tab(indx).correct_timeliness_status
                ,sla_jeopardy_days = temp_tab(indx).correct_jeopardy_days
                ,sla_jeopardy_date = temp_tab(indx).correct_jeopardy_date
                ,jeopardy_status = temp_tab(indx).correct_jeopardy_status
                ,sla_days = temp_tab(indx).correct_sla_days
                ,sla_days_type = temp_tab(indx).correct_sla_days_type
                ,sla_target_days = temp_tab(indx).correct_target_days
            WHERE letter_request_id = temp_tab(indx).letter_request_id;
        END LOOP; 
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

