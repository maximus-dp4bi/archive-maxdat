DECLARE
 CURSOR case_cur IS
   SELECT LEAD(date_created,1) OVER(ORDER BY case_number, version) new_date_of_validity_end,
          LEAST(COALESCE(date_of_validity_start,date_created),date_created) new_date_of_validity_start, c1.* 
   FROM emrs_d_case c1
   WHERE (date_of_validity_start is null
       OR date_of_validity_end is null)
   ORDER BY case_number,version;
   
   TYPE t_case_tab IS TABLE OF case_cur%ROWTYPE INDEX BY PLS_INTEGER;
    case_tab t_case_tab;
    v_bulk_limit NUMBER := 5000;
BEGIN
   OPEN case_cur;
   LOOP
     FETCH case_cur BULK COLLECT INTO case_tab LIMIT v_bulk_limit;
     EXIT WHEN case_tab.COUNT = 0; -- Exit when missing rows

     FOR indx IN 1 .. case_tab.COUNT LOOP
       UPDATE emrs_d_case dc
       SET date_of_validity_start = CASE WHEN dc.date_of_validity_start IS NULL THEN case_tab(indx).new_date_of_validity_start ELSE dc.date_of_validity_start END
        ,date_of_validity_end = CASE WHEN dc.date_of_validity_end IS NULL THEN case_tab(indx).new_date_of_validity_end ELSE dc.date_of_validity_end END
       WHERE case_id = case_tab(indx).case_id;
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
END;
