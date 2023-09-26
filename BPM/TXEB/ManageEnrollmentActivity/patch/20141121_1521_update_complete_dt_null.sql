DECLARE  
  CURSOR temp_cur IS
  select CLIENT_ENROLL_STATUS_ID, ASED_SELECTION_RECD,COMPLETE_DT,ased_auto_assign
  from CORP_ETL_MANAGE_ENROLL
  where INSTANCE_STATUS = 'Complete'
  and complete_dt is null
  and ASED_SELECTION_RECD is null
  and ased_auto_assign is not null
  and (enroll_fee_amnt_due = 0 or fee_paid_flg = 'Y');

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;
  --v_ased_selection_recd date;
BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FOR indx IN 1..temp_tab.COUNT LOOP
           -- v_ased_selection_recd := temp_tab(indx).ASED_SELECTION_RECD; 
          UPDATE CORP_ETL_MANAGE_ENROLL
            SET COMPLETE_DT = temp_tab(indx).ased_auto_assign
               WHERE CLIENT_ENROLL_STATUS_ID = temp_tab(indx).CLIENT_ENROLL_STATUS_ID;
        END LOOP; 
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/
