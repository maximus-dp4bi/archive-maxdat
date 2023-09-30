DECLARE  
  CURSOR temp_cur IS
     select letter_request_id from corp_etl_proc_letters
     where letter_type = 'Enrollment Reminder'
     and epm_mail_dt_for_case > create_dt;      

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
         update corp_etl_proc_letters nf
           set epm_mail_dt_for_case =  (SELECT max(letter_mailed_date) 
                                        FROM letters_stg ls WHERE ls.letter_case_id = nf.case_id and ls.letter_type = 'Enrollment Letter' and letter_status_cd = 'MAIL'
                                        AND ls.letter_mailed_date <= nf.create_dt)              
		     where letter_request_id = temp_tab(indx).letter_request_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/
commit;