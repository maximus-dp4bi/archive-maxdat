DECLARE  
  CURSOR temp_cur IS
  SELECT letter_request_id, instance_status,status,complete_dt,status_dt,cancel_by_id, cancel_by,cancel_reason,cancel_method,cancel_dt,stage_done_date
         ,mailed_dt,print_dt,letter_resp_file_dt,letter_resp_file_name,last_update_dt,asf_receive_confirmation,ased_receive_confirmation,gwf_outcome
         ,last_updated_by_id,epm_mail_dt_for_case
  from corp_etl_proc_letters pl  
  where instance_status = 'Complete'
  and exists(select 1 from d_pl_current d where pl.letter_request_id = d.letter_request_id and pl.status != d.letter_status and d.instance_status = 'Active');
   

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         update d_pl_current
         set instance_status = temp_tab(indx).instance_status
             ,letter_status = temp_tab(indx).status
             ,letter_status_date = temp_tab(indx).status_dt
             ,complete_date = temp_tab(indx).complete_dt
             ,cancel_by_id = temp_tab(indx).cancel_by_id
             ,cancel_by = temp_tab(indx).cancel_by
             ,cancel_date = temp_tab(indx).cancel_dt
             ,cancel_reason = temp_tab(indx).cancel_reason
             ,cancel_method = temp_tab(indx).cancel_method             
             ,mailed_date = temp_tab(indx).mailed_dt
             ,print_date = temp_tab(indx).print_dt
             ,letter_response_file_name = temp_tab(indx).letter_resp_file_name
             ,letter_response_file_date = temp_tab(indx).letter_resp_file_dt
             ,last_update_date = temp_tab(indx).last_update_dt
             ,last_updated_by_id = temp_tab(indx).last_updated_by_id
             ,receive_confirm_end_date = temp_tab(indx).ased_receive_confirmation
             ,confirmation_flag = temp_tab(indx).asf_receive_confirmation
             ,epm_mail_date_for_case = temp_tab(indx).epm_mail_dt_for_case
             ,outcome_flag = temp_tab(indx).gwf_outcome
         where letter_request_id = temp_tab(indx).letter_request_id ;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/