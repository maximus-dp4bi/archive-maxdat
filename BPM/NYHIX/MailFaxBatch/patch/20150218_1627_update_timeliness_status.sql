DECLARE  
  CURSOR temp_cur IS
   SELECT mfb_bi_id
   FROM d_mfb_current
   WHERE instance_status = 'Complete' and AGE_IN_BUSINESS_DAYS = 2;

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
         UPDATE d_mfb_current
            SET TIMELINESS_STATUS = 'Timely'
         WHERE mfb_bi_id = temp_tab(indx).mfb_bi_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/