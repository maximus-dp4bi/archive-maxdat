DECLARE
 CURSOR enrl_cur IS
    SELECT f.enrollment_id
      ,f.enrollment_group_id
      ,f.source_record_id selection_segment_id
       ,client_number client_id
       ,case_number case_id
       ,provider_number network_id
       ,managed_care_start_date start_date
       ,managed_care_end_Date end_date
       ,enrollment_status_change_date     
    FROM emrs_f_enrollment f
    WHERE trunc(date_created) < to_date('02/15/2014','mm/dd/yyyy')
    AND NOT EXISTS(SELECT 1 FROM emrs_s_enrollment_stg_adhoc s WHERE f.source_record_id = s.source_selection_record_id);
   
   TYPE t_enrl_tab IS TABLE OF enrl_cur%ROWTYPE INDEX BY PLS_INTEGER;
    enrl_tab t_enrl_tab;
    v_bulk_limit NUMBER := 5000;     
BEGIN
   OPEN enrl_cur;
   LOOP
     FETCH enrl_cur BULK COLLECT INTO enrl_tab LIMIT v_bulk_limit;
     EXIT WHEN enrl_tab.COUNT = 0; -- Exit when missing rows

     FOR indx IN 1 .. enrl_tab.COUNT LOOP     

       DELETE FROM emrs_d_enrollment_notification
       WHERE enrollment_group_id = enrl_tab(indx).enrollment_group_id;    
         
       DELETE FROM emrs_f_enrollment
       WHERE enrollment_id = enrl_tab(indx).enrollment_id;
     
    END LOOP;
    COMMIT;
  END LOOP;
  COMMIT;
END;
/
COMMIT;