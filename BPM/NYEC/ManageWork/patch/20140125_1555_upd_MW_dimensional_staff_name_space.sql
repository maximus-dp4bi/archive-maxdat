-- Fix report data to prevent different staff name displayed
-- Tables: D_MW_OWNER, D_MW_LAST_UPDATE_BY_NAME, D_MW_TASK_TYPE, D_MW_ESCALATED, D_MW_FORWARDED
-- Special logic for Johanna and Johana Lopez


CREATE TABLE tmp_mw_owner
(bad_dmwo_id NUMBER NOT NULL, good_dmwo_id NUMBER)
/
CREATE TABLE tmp_mw_updated_by
(bad_dmwlubn_id NUMBER NOT NULL, good_dmwlubn_id NUMBER)
/
CREATE TABLE tmp_mw_escalated
(bad_dmwe_id NUMBER NOT NULL, good_dmwe_id NUMBER)
/
CREATE TABLE tmp_mw_forwarded
(bad_dmwf_id NUMBER NOT NULL, good_dmwf_id NUMBER)
/
DECLARE
  v_cnt INTEGER := 0;
BEGIN
  -- Owner
  INSERT INTO tmp_mw_owner
  SELECT bad_dmwo_id, good_dmwo_id
  FROM (SELECT dmwo_id AS bad_dmwo_id
              , "Owner Name" AS bad_name
              , replace("Owner Name", ', ', ',') AS bad_name_chk
          FROM d_mw_owner bad
         WHERE "Owner Name" LIKE '%, %'
                --and dmwo_id = i.dmwo_id 
       ) bad
      , (SELECT dmwo_id AS good_dmwo_id
               , "Owner Name" AS good_name
           FROM d_mw_owner
          WHERE "Owner Name" NOT LIKE '%, %') good
  WHERE bad.bad_name_chk = good.good_name;
  INSERT INTO tmp_mw_owner
  SELECT bad_dmwo_id, NULL
    FROM (SELECT dmwo_id AS bad_dmwo_id
                , "Owner Name" AS bad_name
                , replace("Owner Name", ', ', ',') AS bad_name_chk
            FROM d_mw_owner bad
           WHERE "Owner Name" LIKE '%, %'
             AND NOT EXISTS
                (SELECT 1 FROM d_mw_owner good
                    WHERE "Owner Name" NOT LIKE '%, %' 
                      AND good."Owner Name" = replace(bad."Owner Name", ', ', ','))
          );
  COMMIT;
  --
  FOR t IN (SELECT fmwbd_id, good_dmwo_id FROM f_mw_by_date, tmp_mw_owner
             WHERE dmwo_id = bad_dmwo_id AND good_dmwo_id IS NOT NULL)
  LOOP
    v_cnt := v_cnt + 1;
    UPDATE f_mw_by_date
       SET dmwo_id = t.good_dmwo_id
     WHERE fmwbd_id = t.fmwbd_id;
    IF v_cnt = 1000
    THEN COMMIT; v_cnt := 0;
    END IF;
  END LOOP;
  
  -- Last Updated By
  INSERT INTO tmp_mw_updated_by
  SELECT bad_dmwlubn_id, good_dmwlubn_id
    FROM (SELECT dmwlubn_id AS bad_dmwlubn_id
                , "Last Update By Name" AS bad_name
                , replace("Last Update By Name", ', ', ',') AS bad_name_chk
            FROM d_mw_last_update_by_name
           WHERE "Last Update By Name" LIKE '%, %'
                  --and dmwo_id = i.dmwo_id 
         ) bad
        , (SELECT dmwlubn_id AS good_dmwlubn_id
                 , "Last Update By Name" AS good_name
             FROM d_mw_last_update_by_name
            WHERE "Last Update By Name" NOT LIKE '%, %') good
    WHERE bad.bad_name_chk = good.good_name;
  /*
  INSERT INTO tmp_mw_updated_by
  SELECT bad_dmwlubn_id, NULL
    FROM (SELECT dmwlubn_id AS bad_dmwlubn_id
                , "Last Update By Name" AS bad_name
                , replace("Last Update By Name", ', ', ',') AS bad_name_chk
            FROM d_mw_last_update_by_name bad
           WHERE "Last Update By Name" LIKE '%, %'
             AND NOT EXISTS
                (SELECT 1 FROM d_mw_last_update_by_name good
                  WHERE "Last Update By Name" NOT LIKE '%, %'
                    AND good."Last Update By Name" = replace(bad."Last Update By Name", ', ', ','))
          );
  COMMIT;
  -- Manually handle Johana
  3935	      Lopez, Johana
  468	        Lopez,Johanna
  */
  UPDATE d_mw_last_update_by_name
     SET "Last Update By Name" = REPLACE("Last Update By Name", ', ', ',')
   WHERE dmwlubn_id = 3935;
  --
  FOR t IN (SELECT fmwbd_id, good_dmwlubn_id FROM f_mw_by_date, tmp_mw_updated_by
             WHERE dmwlubn_id = bad_dmwlubn_id AND good_dmwlubn_id IS NOT NULL)
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
  INSERT INTO tmp_mw_escalated
  SELECT bad_dmwe_id, good_dmwe_id
    FROM (SELECT dmwe_id AS bad_dmwe_id
                , "Escalated To Name" AS bad_name
                , replace("Escalated To Name", ', ', ',') AS bad_name_chk
            FROM d_mw_escalated
           WHERE "Escalated To Name" LIKE '%, %'
         ) bad
        ,(SELECT dmwe_id AS good_dmwe_id
                 , "Escalated To Name" AS good_name
            FROM d_mw_escalated
           WHERE "Escalated To Name" NOT LIKE '%, %') good
    WHERE bad.bad_name_chk = good.good_name;
  INSERT INTO tmp_mw_escalated
  SELECT bad_dmwe_id, NULL
    FROM (SELECT dmwe_id AS bad_dmwe_id
                , "Escalated To Name" AS bad_name
                , replace("Escalated To Name", ', ', ',') AS bad_name_chk
            FROM d_mw_escalated bad
           WHERE "Escalated To Name" LIKE '%, %'
             AND NOT EXISTS
                (SELECT 1 FROM d_mw_escalated good
                  WHERE "Escalated To Name" NOT LIKE '%, %'
                    AND good."Escalated To Name" = replace(bad."Escalated To Name", ', ', ','))
          );
  COMMIT;
  -- 
  FOR t IN (SELECT fmwbd_id, good_dmwe_id FROM f_mw_by_date, tmp_mw_escalated
             WHERE dmwe_id = bad_dmwe_id AND good_dmwe_id IS NOT NULL)
  LOOP
    v_cnt := v_cnt + 1;
    UPDATE f_mw_by_date f
       SET dmwe_id = t.good_dmwe_id
     WHERE fmwbd_id = t.fmwbd_id;
    IF v_cnt = 1000
    THEN COMMIT; v_cnt := 0;
    END IF;
  END LOOP;
  --

  -- Forwarded
  INSERT INTO tmp_mw_forwarded
  SELECT bad_dmwf_id, good_dmwf_id
    FROM (SELECT dmwf_id AS bad_dmwf_id
                , "Forwarded By Name" AS bad_name
                , replace("Forwarded By Name", ', ', ',') AS bad_name_chk
            FROM d_mw_forwarded
           WHERE "Forwarded By Name" LIKE '%, %'
         ) bad
        ,(SELECT dmwf_id AS good_dmwf_id
                , "Forwarded By Name" AS good_name
             FROM d_mw_forwarded
            WHERE "Forwarded By Name" NOT LIKE '%, %') good
   WHERE bad.bad_name_chk = good.good_name;
  INSERT INTO tmp_mw_forwarded
  SELECT bad_dmwf_id, NULL
    FROM (SELECT dmwf_id AS bad_dmwf_id
                , "Forwarded By Name" AS bad_name
                , replace("Forwarded By Name", ', ', ',') AS bad_name_chk
            FROM d_mw_forwarded bad
           WHERE "Forwarded By Name" LIKE '%, %'
             AND NOT EXISTS
                (SELECT 1 FROM d_mw_forwarded good
                  WHERE "Forwarded By Name" NOT LIKE '%, %'
                    AND good."Forwarded By Name" = replace(bad."Forwarded By Name", ', ', ','))
          );
  COMMIT;
  --
  FOR t IN (SELECT fmwbd_id, good_dmwf_id FROM f_mw_by_date, tmp_mw_forwarded
             WHERE dmwf_id = bad_dmwf_id AND good_dmwf_id IS NOT NULL)
  LOOP
    v_cnt := v_cnt + 1;
    UPDATE f_mw_by_date f
       SET dmwf_id = t.good_dmwf_id
     WHERE fmwbd_id = t.fmwbd_id;
    IF v_cnt = 1000
    THEN COMMIT; v_cnt := 0;
    END IF;
  END LOOP;
  --
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


