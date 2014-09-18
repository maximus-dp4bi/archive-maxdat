Declare
v_mw_bi_id number;
v_task_id number;

PROCEDURE l_UpdateMW
IS
   CURSOR c_Parent (cp_Start_Id NUMBER) IS
      SELECT assignment_id
      FROM cadir_maxdat_stg
      WHERE subject_type = 2
      START WITH assignment_id = cp_Start_Id
      CONNECT BY PRIOR c_assignment_to = c_assignment_from;

   CURSOR cOrigCreate is
       SELECT source_reference_id refid,
              (Select MIN(Assignment_date) from cadir_maxdat_stg where tracking_id = Source_reference_id) cdate
         FROM corp_etl_manage_work
        WHERE original_creation_date IS NULL
          AND stage_done_date is null
        GROUP BY source_reference_id;

   TYPE t_OrigCreate_tab IS TABLE OF cOrigCreate%ROWTYPE INDEX BY PLS_INTEGER;
    OrigCreate_tab t_OrigCreate_tab;
   r_Parent c_Parent%ROWTYPE;
   v_bulk_limit NUMBER := 1000;
   v_step VARCHAR2(100);
   v_err_code VARCHAR2(30);
   v_err_msg VARCHAR2(240);
   v_err_index NUMBER;
   v_Name   VARCHAR2(50);
   v_Check  NUMBER;
   v_ParID  NUMBER;
   v_ChdID  NUMBER;

BEGIN

/*
|| This procedure is only a partial update rule in the workbook - It's only updating the original creation date
*/
--perform test ----
v_step := 'OCDATE';
INSERT INTO cadir_managework_logging VALUES (SYSDATE, SYSDATE, 'Starting '||v_step);
commit;
-------------------
   OPEN cOrigCreate;
   LOOP
     FETCH cOrigCreate BULK COLLECT INTO OrigCreate_tab LIMIT v_bulk_limit;
     EXIT WHEN OrigCreate_tab.COUNT = 0; -- Exit when missing rows

     BEGIN
       FORALL indx IN 1..OrigCreate_tab.COUNT SAVE EXCEPTIONS
           UPDATE corp_etl_manage_work_tmp
              SET original_creation_date = OrigCreate_tab(indx).Cdate
                , updated = 'Y'
            WHERE source_reference_id = OrigCreate_tab(indx).Refid
              AND original_creation_date IS NULL;

     EXCEPTION
           WHEN OTHERS THEN
             IF SQLCODE = -24381 THEN
               FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
                v_err_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE; --SQLCODE;
                v_err_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
                v_err_msg := SUBSTR(SQLERRM, 1, 90);
                INSERT INTO corp_etl_error_log
                VALUES(SEQ_CEEL_ID.nextval,--CEEL_ID
                        sysdate,--ERR_DATE
                        'CRITICAL',--ERR_LEVEL
                        'MANAGE WORK',--PROCESS_NAME
                        'UpdateMW',--JOB_NAME
                        '1',--NR_OF_ERROR
                        v_step||' - '||v_err_msg,--ERROR_DESC
                        null, --ERROR_FIELD
                        v_err_code,--ERROR_CODES
                        sysdate,--CREATE_TS
                        sysdate,--UPDATE_TS
                        'CORP_ETL_MANAGE_WORK',--DRIVER_TABLE_NAME
                        v_err_index);--DRIVER_KEY_NUMBER
               END LOOP;
             END IF;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE cOrigCreate;


/*
|| This procedure is only a partial rule in the workbook - It's finding the parent task ID of record
*/
--perform test ----
INSERT INTO cadir_managework_logging VALUES (SYSDATE, SYSDATE, 'ParentID');
commit;
-------------------
   FOR r_Row IN (SELECT task_id
                 FROM corp_etl_manage_work
                 WHERE task_id NOT IN (SELECT parent_task_id
                                       FROM corp_etl_manage_work
                                       WHERE parent_task_id IS NOT NULL)
                   AND source_reference_id in ( select distinct source_reference_id from corp_etl_manage_work_tmp)
                 )
   LOOP
      OPEN c_Parent(r_Row.task_id);
      FETCH c_Parent INTO r_Parent;
      v_ParID := r_Parent.Assignment_Id;
      LOOP
         FETCH c_Parent INTO r_Parent;
         EXIT WHEN c_Parent%NOTFOUND;

         v_ChdID := r_Parent.Assignment_Id;
         IF v_ParID <> v_ChdID THEN
            UPDATE  corp_etl_manage_work_tmp
              SET   parent_task_id = v_ParID
              WHERE task_id = v_ChdID;
         END IF;

         v_ParID := v_ChdID;
      END LOOP;
      CLOSE c_Parent;

   COMMIT;
   END LOOP;

/*
|| This procedure is only a partial rule in the workbook - It's only updating the owner
*/
--perform test ----
INSERT INTO cadir_managework_logging VALUES (SYSDATE, SYSDATE, 'Owner');
commit;
-------------------
   FOR r_Row IN (SELECT W.* , M.Subject_Type, M.Subject_ID, M.c_Created_By
                   FROM  corp_etl_manage_work W
                  INNER JOIN cadir_maxdat_stg M ON M.c_assignment_from = W.task_id
                  WHERE W.owner_name IS NULL
                  AND source_reference_id in ( select distinct source_reference_id from corp_etl_manage_work_tmp)
                )
   LOOP

     -- If child =  1 then use subject id
     IF r_Row.Subject_Type = 1 THEN
        v_Name := cadir_etl_manage_work_pkg.Get_Person_Name(r_Row.Subject_ID);
     ELSE
        -- Aram confirmed that if followed by type 2 then Owner Name is not set
         v_Name := Null ;
      -- v_Name := cadir_etl_manage_work_pkg.Get_Person_Name(r_Row.c_Created_By);
     END IF;

     SELECT COUNT(1)
       INTO v_Check
       FROM corp_etl_manage_work_tmp
      WHERE cemw_id = r_Row.cemw_id;

      IF v_Check = 0 THEN
          INSERT INTO corp_etl_manage_work_tmp
            SELECT T.*,NULL FROM corp_etl_manage_work T WHERE cemw_id = r_Row.cemw_id;
      END IF;

      UPDATE corp_etl_manage_work_tmp
         SET owner_name = v_Name
       WHERE cemw_id = r_Row.cemw_id;

   END LOOP;
   COMMIT;

--perform test ----
INSERT INTO cadir_managework_logging VALUES (SYSDATE, SYSDATE, 'MW_UPDATE_MAIN_TABLE');
commit;

cadir_etl_manage_work_pkg.MW_UPDATE_MAIN_TABLE;

--perform test ----
INSERT INTO cadir_managework_logging VALUES (SYSDATE, SYSDATE, 'upd_CNTRL_TAB');
commit;

  UPDATE corp_etl_control
     SET VALUE = (SELECT to_char(NVL(MAX(task_id),0)) FROM corp_etl_manage_work)
     WHERE NAME = 'MW_MAX_PROCESSED_ID';
 COMMIT;

END l_UpdateMW;



Begin

delete from corp_etl_manage_work_tmp ; commit;

   INSERT INTO corp_etl_manage_work_tmp
      SELECT T.*,NULL FROM corp_etl_manage_work T WHERE task_id IN 
      (21662,217522,224396,224900,226069,226799,227374,229166,229212,229379,
229513,229595,229644,230065,230834,231154,231498,231766,231930,231996,232016,232148,232802,232834,233626,234148,234569,235054,235198,235296,
235431,236111,236315,236761,236783,242182,249051,250411,251079,252346,252677,252722,261010,261304,263700,264596,266032,266435,266642,266860,
273079,281649,286718,310592,313815,320377,320904,328314,330074,346460,347730,349705,51451025,51501016,944126)
       AND stage_done_Date is null;
   COMMIT;

  cadir_etl_manage_work_pkg.Upd2_10;
  cadir_etl_manage_work_pkg.Upd3_10A;
  cadir_etl_manage_work_pkg.Upd3_10B;
  cadir_etl_manage_work_pkg.Upd3_10C;
  cadir_etl_manage_work_pkg.Upd6_10;
  l_updateMW;

END;
/