/* NYEC has mixture of staff names. Updating those without spaces.
   1. Update bad-only dimensional staffs (without associated good staff)
   2. Update bad dimensional staff that has good staff
   3. Remove all lingering bad staff (those moved to good staff)
*/
-- Step 1
UPDATE d_mw_owner o SET "Owner Name" = replace("Owner Name", ',', ', ')
 WHERE instr("Owner Name",', ') = 0 AND instr("Owner Name",',') > 0
   AND NOT EXISTS
       (SELECT 1 FROM d_mw_owner o2
         WHERE o2."Owner Name" = replace(o."Owner Name", ',', ', '));
COMMIT;

UPDATE d_mw_last_update_by_name l SET "Last Update By Name" = replace("Last Update By Name", ',', ', ')
 WHERE instr("Last Update By Name",', ') = 0 AND instr("Last Update By Name",',') > 0
   AND NOT EXISTS
       (SELECT 1 FROM d_mw_last_update_by_name l2
         WHERE l2."Last Update By Name" = replace(l."Last Update By Name", ',', ', '));
COMMIT;

UPDATE d_mw_escalated e SET "Escalated To Name" = replace("Escalated To Name", ',', ', ')
 WHERE instr("Escalated To Name",', ') = 0 AND instr("Escalated To Name",',') > 0
   AND NOT EXISTS
       (SELECT 1 FROM d_mw_escalated e2
         WHERE e2."Escalated To Name" = replace(e."Escalated To Name", ',', ', '));
COMMIT;

UPDATE d_mw_forwarded f SET "Forwarded By Name" = replace("Forwarded By Name", ',', ', ')
 WHERE instr("Forwarded By Name",', ') = 0 AND instr("Forwarded By Name",',') > 0
   AND NOT EXISTS
       (SELECT 1 FROM d_mw_forwarded f2
         WHERE f2."Forwarded By Name" = replace(f."Forwarded By Name", ',', ', '));
COMMIT;


-- Step 2
CREATE TABLE tmp_mw_owner AS
  SELECT bad_dmwo_id, good_dmwo_id FROM
     (SELECT dmwo_id AS bad_dmwo_id
            , "Owner Name" AS bad_name
            , replace("Owner Name", ',', ', ') AS bad_name_chk
        FROM d_mw_owner bad
       WHERE "Owner Name" NOT LIKE '%, %'
     ) bad
    , (SELECT dmwo_id AS good_dmwo_id
             , "Owner Name" AS good_name
         FROM d_mw_owner
        WHERE "Owner Name" LIKE '%, %') good
  WHERE bad.bad_name_chk = good.good_name;

CREATE TABLE tmp_mw_updated_by AS
  SELECT bad_dmwlubn_id, good_dmwlubn_id
  FROM (SELECT dmwlubn_id AS bad_dmwlubn_id
             , "Last Update By Name" AS bad_name
             , replace("Last Update By Name", ',', ', ') AS bad_name_chk
         FROM d_mw_last_update_by_name
        WHERE "Last Update By Name" NOT LIKE '%, %'
       ) bad
     , (SELECT dmwlubn_id AS good_dmwlubn_id
             , "Last Update By Name" AS good_name
         FROM d_mw_last_update_by_name
        WHERE "Last Update By Name" LIKE '%, %') good
  WHERE bad.bad_name_chk = good.good_name;

CREATE TABLE tmp_mw_escalated AS
  SELECT bad_dmwe_id, good_dmwe_id
    FROM (SELECT dmwe_id AS bad_dmwe_id
               , "Escalated To Name" AS bad_name
               , replace("Escalated To Name", ',', ', ') AS bad_name_chk
            FROM d_mw_escalated
           WHERE "Escalated To Name" NOT LIKE '%, %'
         ) bad
        ,(SELECT dmwe_id AS good_dmwe_id
                 , "Escalated To Name" AS good_name
            FROM d_mw_escalated
           WHERE "Escalated To Name" LIKE '%, %') good
    WHERE bad.bad_name_chk = good.good_name;

CREATE TABLE tmp_mw_forwarded AS
  SELECT bad_dmwf_id, good_dmwf_id
  FROM (SELECT dmwf_id AS bad_dmwf_id
              , "Forwarded By Name" AS bad_name
              , replace("Forwarded By Name", ',', ', ') AS bad_name_chk
          FROM d_mw_forwarded
         WHERE "Forwarded By Name" NOT LIKE '%, %') bad
        ,(SELECT dmwf_id AS good_dmwf_id
              , "Forwarded By Name" AS good_name
          FROM d_mw_forwarded 
         WHERE "Forwarded By Name" LIKE '%, %') good
  WHERE bad_name_chk = good_name;

--update etl table
DECLARE  
CURSOR mwetl_cur IS
  select cemw_id,
   CASE WHEN instr(created_by_name,' ') = 0 THEN REPLACE(created_by_name,',',', ') ELSE created_by_name END created_by_name,
   CASE WHEN instr(last_update_by_name,' ') = 0 THEN REPLACE(last_update_by_name,',',', ') ELSE last_update_by_name END last_update_by_name,
   CASE WHEN instr(owner_name,' ') = 0 THEN REPLACE(owner_name,',',', ') ELSE owner_name END owner_name,
   CASE WHEN instr(team_supervisor_name,' ') = 0 THEN REPLACE(team_supervisor_name,',',', ') ELSE team_supervisor_name END team_supervisor_name
  from corp_etl_manage_work
  where stage_done_date is null
  and ((instr(created_by_name,' ') = 0 and instr(created_by_name,',') > 0)
   or (instr(last_update_by_name,' ') = 0 and instr(last_update_by_name,',') > 0) 
   or (instr(owner_name,' ') = 0 and instr(owner_name,',') > 0)    
   or (instr(team_supervisor_name,' ') = 0 and instr(team_supervisor_name,',') > 0) ) ;
   
   TYPE t_mwetl_tab IS TABLE OF mwetl_cur%ROWTYPE INDEX BY PLS_INTEGER;
    mwetl_tab t_mwetl_tab;
    v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN mwetl_cur;
   LOOP
     FETCH mwetl_cur BULK COLLECT INTO mwetl_tab LIMIT v_bulk_limit;
     EXIT WHEN mwetl_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..mwetl_tab.COUNT
         UPDATE corp_etl_manage_work
         SET created_by_name  = mwetl_tab(indx).created_by_name
            ,last_update_by_name = mwetl_tab(indx).last_update_by_name
            ,owner_name = mwetl_tab(indx).owner_name
            ,team_supervisor_name = mwetl_tab(indx).team_supervisor_name
         WHERE cemw_id = mwetl_tab(indx).cemw_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE mwetl_cur;
END;
/

--update current dimension
DECLARE  
CURSOR mwcur_cur IS
  select mw_bi_id,
    CASE WHEN instr("Created By Name",' ') = 0 THEN REPLACE("Created By Name",',',', ') ELSE "Created By Name" END created_by_name,
    CASE WHEN instr("Current Last Update By Name",' ') = 0 THEN REPLACE("Current Last Update By Name",',',', ') ELSE "Current Last Update By Name" END last_update_by_name,
    CASE WHEN instr("Current Owner Name",' ') = 0 THEN REPLACE("Current Owner Name",',',', ') ELSE "Current Owner Name" END owner_name,
    CASE WHEN instr("Current Team Supervisor Name",' ') = 0 THEN REPLACE("Current Team Supervisor Name",',',', ') ELSE "Current Team Supervisor Name" END team_supervisor_name
  from d_mw_current
  where ("Complete Date" is null and "Cancel Work Date" is null)
  and ((instr("Created By Name",' ') = 0 and instr("Created By Name",',') > 0)
    or (instr("Current Last Update By Name",' ') = 0 and instr("Current Last Update By Name",',') > 0) 
    or (instr("Current Owner Name",' ') = 0 and instr("Current Owner Name",',') > 0)    
    or (instr("Current Team Supervisor Name",' ') = 0 and instr("Current Team Supervisor Name",',') > 0)) ;
   
   TYPE t_mwcur_tab IS TABLE OF mwcur_cur%ROWTYPE INDEX BY PLS_INTEGER;
    mwcur_tab t_mwcur_tab;
    v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN mwcur_cur;
   LOOP
     FETCH mwcur_cur BULK COLLECT INTO mwcur_tab LIMIT v_bulk_limit;
     EXIT WHEN mwcur_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..mwcur_tab.COUNT
         UPDATE d_mw_current
         SET "Created By Name"  = mwcur_tab(indx).created_by_name
            ,"Current Last Update By Name" = mwcur_tab(indx).last_update_by_name
            ,"Current Owner Name" = mwcur_tab(indx).owner_name
            ,"Current Team Supervisor Name" = mwcur_tab(indx).team_supervisor_name
         WHERE mw_bi_id = mwcur_tab(indx).mw_bi_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE mwcur_cur;
END;
/

DECLARE  
CURSOR mwowner_cur IS
   SELECT fmwbd_id, good_dmwo_id FROM f_mw_by_date, tmp_mw_owner
   WHERE dmwo_id = bad_dmwo_id;
   
   TYPE t_mwowner_tab IS TABLE OF mwowner_cur%ROWTYPE INDEX BY PLS_INTEGER;
    mwowner_tab t_mwowner_tab;
    v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN mwowner_cur;
   LOOP
     FETCH mwowner_cur BULK COLLECT INTO mwowner_tab LIMIT v_bulk_limit;
     EXIT WHEN mwowner_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..mwowner_tab.COUNT
         UPDATE f_mw_by_date
         SET dmwo_id = mwowner_tab(indx).good_dmwo_id
         WHERE fmwbd_id = mwowner_tab(indx).fmwbd_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE mwowner_cur;
END;
/


DECLARE  
CURSOR mwupd_cur IS
  SELECT fmwbd_id, good_dmwlubn_id FROM f_mw_by_date, tmp_mw_updated_by
  WHERE dmwlubn_id = bad_dmwlubn_id;
   
   TYPE t_mwupd_tab IS TABLE OF mwupd_cur%ROWTYPE INDEX BY PLS_INTEGER;
    mwupd_tab t_mwupd_tab;
    v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN mwupd_cur;
   LOOP
     FETCH mwupd_cur BULK COLLECT INTO mwupd_tab LIMIT v_bulk_limit;
     EXIT WHEN mwupd_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..mwupd_tab.COUNT
         UPDATE f_mw_by_date
         SET dmwlubn_id = mwupd_tab(indx).good_dmwlubn_id
         WHERE fmwbd_id = mwupd_tab(indx).fmwbd_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE mwupd_cur;
END;
/

DECLARE  
CURSOR mwesc_cur IS
  SELECT fmwbd_id, good_dmwe_id FROM f_mw_by_date, tmp_mw_escalated
  WHERE dmwe_id = bad_dmwe_id;
   
   TYPE t_mwesc_tab IS TABLE OF mwesc_cur%ROWTYPE INDEX BY PLS_INTEGER;
    mwesc_tab t_mwesc_tab;
    v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN mwesc_cur;
   LOOP
     FETCH mwesc_cur BULK COLLECT INTO mwesc_tab LIMIT v_bulk_limit;
     EXIT WHEN mwesc_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..mwesc_tab.COUNT
         UPDATE f_mw_by_date
         SET dmwe_id = mwesc_tab(indx).good_dmwe_id
         WHERE fmwbd_id = mwesc_tab(indx).fmwbd_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE mwesc_cur;
END;
/

DECLARE  
CURSOR mwfwd_cur IS
  SELECT fmwbd_id, good_dmwf_id FROM f_mw_by_date, tmp_mw_forwarded
  WHERE dmwf_id = bad_dmwf_id;
   
   TYPE t_mwfwd_tab IS TABLE OF mwfwd_cur%ROWTYPE INDEX BY PLS_INTEGER;
    mwfwd_tab t_mwfwd_tab;
    v_bulk_limit NUMBER := 500;     
BEGIN  
   OPEN mwfwd_cur;
   LOOP
     FETCH mwfwd_cur BULK COLLECT INTO mwfwd_tab LIMIT v_bulk_limit;
     EXIT WHEN mwfwd_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..mwfwd_tab.COUNT
         UPDATE f_mw_by_date
         SET dmwf_id = mwfwd_tab(indx).good_dmwf_id
         WHERE fmwbd_id = mwfwd_tab(indx).fmwbd_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE mwfwd_cur;
END;
/

COMMIT;

DROP TABLE tmp_mw_owner
/
DROP TABLE tmp_mw_updated_by
/
DROP TABLE tmp_mw_escalated
/
DROP TABLE tmp_mw_forwarded
/

-- Step 3
DELETE FROM d_mw_owner WHERE INSTR("Owner Name",',') > 0 AND INSTR("Owner Name",', ') = 0;
DELETE FROM d_mw_last_update_by_name WHERE INSTR("Last Update By Name",',') > 0 AND INSTR("Last Update By Name",', ') = 0;
DELETE FROM d_mw_escalated WHERE INSTR("Escalated To Name",',') > 0 AND INSTR("Escalated To Name",', ') = 0;
DELETE FROM d_mw_forwarded WHERE INSTR("Forwarded By Name",',') > 0 AND INSTR("Forwarded By Name",', ') = 0;
COMMIT;

