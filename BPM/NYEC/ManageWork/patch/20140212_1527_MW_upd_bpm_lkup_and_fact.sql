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

DECLARE
  v_cnt INTEGER := 0;
BEGIN
  -- Owner
  FOR t IN (SELECT fmwbd_id, good_dmwo_id FROM f_mw_by_date, tmp_mw_owner
             WHERE dmwo_id = bad_dmwo_id)
  LOOP
    v_cnt := v_cnt + 1;
    UPDATE f_mw_by_date
       SET dmwo_id = t.good_dmwo_id
     WHERE fmwbd_id = t.fmwbd_id;
    IF v_cnt = 1000
    THEN COMMIT; v_cnt := 0;
    END IF;
  END LOOP;

  -- Last Updated
  FOR t IN (SELECT fmwbd_id, good_dmwlubn_id FROM f_mw_by_date, tmp_mw_updated_by
             WHERE dmwlubn_id = bad_dmwlubn_id)
  LOOP
    v_cnt := v_cnt + 1;
    UPDATE f_mw_by_date
       SET dmwlubn_id = t.good_dmwlubn_id
     WHERE fmwbd_id = t.fmwbd_id;
    IF v_cnt = 1000
    THEN COMMIT; v_cnt := 0;
    END IF;
  END LOOP;

  -- Escalated
  FOR t IN (SELECT fmwbd_id, good_dmwe_id FROM f_mw_by_date, tmp_mw_escalated
             WHERE dmwe_id = bad_dmwe_id)
  LOOP
    v_cnt := v_cnt + 1;
    UPDATE f_mw_by_date
       SET dmwe_id = t.good_dmwe_id
     WHERE fmwbd_id = t.fmwbd_id;
    IF v_cnt = 1000
    THEN COMMIT; v_cnt := 0;
    END IF;
  END LOOP;

  -- Forwarded
  FOR t IN (SELECT fmwbd_id, good_dmwf_id FROM f_mw_by_date, tmp_mw_forwarded
             WHERE dmwf_id = bad_dmwf_id)
  LOOP
    v_cnt := v_cnt + 1;
    UPDATE f_mw_by_date
       SET dmwf_id = t.good_dmwf_id
     WHERE fmwbd_id = t.fmwbd_id;
    IF v_cnt = 1000
    THEN COMMIT; v_cnt := 0;
    END IF;
  END LOOP;

  COMMIT;

END;
/

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

