-- 4/29/14 Dimensional Last Updated By staff name missing space. Update ETL to cascade to dimensional D_MW_CURRENT.

--update etl table
DECLARE  
CURSOR mwetl_cur IS
  select cemw_id, task_id,
   CASE WHEN instr(last_update_by_name,' ') = 0 THEN REPLACE(last_update_by_name,',',', ') 
        ELSE last_update_by_name END last_update_by_name
  from corp_etl_manage_work
  where (instr(last_update_by_name,' ') = 0 and instr(last_update_by_name,',') > 0);
   
   TYPE t_mwetl_tab IS TABLE OF mwetl_cur%ROWTYPE INDEX BY PLS_INTEGER;
    mwetl_tab t_mwetl_tab;
    v_bulk_limit NUMBER := 500;     

CURSOR dmw_cur IS
SELECT mw_bi_id
     , CASE WHEN instr("Current Last Update By Name",' ') = 0 THEN REPLACE("Current Last Update By Name",',',', ') 
       ELSE "Current Last Update By Name" 
       END last_update_by_name
  FROM d_mw_current c
 WHERE (instr("Current Last Update By Name",' ') = 0 and instr("Current Last Update By Name",',') > 0);

 TYPE t_dmw_tab IS TABLE OF dmw_cur%ROWTYPE INDEX BY PLS_INTEGER;
 dmw_tab t_dmw_tab;

BEGIN  
   OPEN mwetl_cur;
   LOOP
     FETCH mwetl_cur BULK COLLECT INTO mwetl_tab LIMIT v_bulk_limit;
     EXIT WHEN mwetl_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..mwetl_tab.COUNT
         UPDATE corp_etl_manage_work
         SET last_update_by_name = mwetl_tab(indx).last_update_by_name
         WHERE cemw_id = mwetl_tab(indx).cemw_id;

       FORALL indx IN 1..mwetl_tab.COUNT
         UPDATE d_mw_current
            SET "Current Last Update By Name" = mwetl_tab(indx).last_update_by_name
          WHERE "Task ID" = mwetl_tab(indx).task_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE mwetl_cur;

  OPEN dmw_cur;
  LOOP
     FETCH dmw_cur BULK COLLECT INTO dmw_tab LIMIT v_bulk_limit;
     EXIT WHEN dmw_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..dmw_tab.COUNT
         UPDATE d_mw_current
            SET "Current Last Update By Name" = dmw_tab(indx).last_update_by_name
          WHERE mw_bi_id = dmw_tab(indx).mw_bi_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE dmw_cur;
END;
/

