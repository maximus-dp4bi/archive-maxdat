DECLARE  
  CURSOR temp_cur IS
   SELECT eemfdb_id
   FROM NYHIX_ETL_MAIL_FAX_DOC_V2
   WHERE instance_status = 'Complete';

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
         UPDATE NYHIX_ETL_MAIL_FAX_DOC_V2
            SET INSTANCE_STATUS = 'Active',
                STG_DONE_DATE = NULL,
                COMPLETE_DT = NULL
         WHERE eemfdb_id = temp_tab(indx).eemfdb_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;