DECLARE
 CURSOR client_cur IS
  select * from emrs_s_enrollment_stg s
  where record_status = 'new'
  and exists(select 1 from emrs_f_enrollment f where s.source_selection_record_id = f.source_record_id and f.date_created < to_date('10/04/2013','mm/dd/yyyy'));

   
   TYPE t_clnt_tab IS TABLE OF client_cur%ROWTYPE INDEX BY PLS_INTEGER;
    clnt_tab t_clnt_tab;
    v_bulk_limit NUMBER := 5000;  
BEGIN
  OPEN client_cur;
  LOOP
     FETCH client_cur BULK COLLECT INTO clnt_tab LIMIT v_bulk_limit;
     EXIT WHEN clnt_tab.COUNT = 0; -- Exit when missing rows
    
     FOR indx IN 1 .. clnt_tab.COUNT LOOP  
       DELETE FROM emrs_f_enrollment
       WHERE source_record_id = clnt_tab(indx).source_selection_record_id
       AND date_created < to_date('10/04/2013','mm/dd/yyyy');
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
END;
/

COMMIT;