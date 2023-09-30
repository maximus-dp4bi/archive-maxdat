DECLARE

   g_Error   VARCHAR2(4000);
   g_Limit   NUMBER;
   gPKG VARCHAR2(30) := 'CADIR_ETL_MANAGE_WORK_PKG';

/*
|| Procedure to insert into corp_etl_manage_work where the etk role name is not "Closed Cases Queue" - AND they
||   do not already exist in corp_etl_manage_work.
*/
PROCEDURE lc_Ins_1
IS

BEGIN  -- INS1

   -- Inserting these new "Type 2" records into Manage Work.
   INSERT INTO corp_etl_manage_work (
           create_date
         , created_by_name
         , group_name
         , last_update_by_name
         , last_update_date
         , source_reference_id
         , source_reference_type
         , status_date
         , task_id
         , task_status
         , task_type
         , team_name
         , stg_extract_date
         , stg_last_update_date
         , case_number
         , channel
         , instance_status
         , instance_start_date
         , received_date
         , assigned_date
         , cancel_work_flag
         , complete_flag
         , task_priority
         , forwarded_by_name
         , forwarded_flag
         , sla_days_type
         , sla_days
         , sla_jeopardy_days
         , sla_target_days
         )
      SELECT
           MS.assignment_date
         , COALESCE(PR.full_name,'Unknown')
         , RS.name
         , COALESCE(PR.full_name,'Unknown')
         , MS.assignment_date
         , MS.tracking_id
         , 'TRACKING_ID'
         , MS.assignment_date
         , MS.assignment_id
         , 'UNCLAIMED'
         , RS.NAME
         , 'UNASSIGNED'
         , SYSDATE
         , SYSDATE
         , MS.c_case_number
         , 'Appeal Type'
         , 'Active'
         , MS.assignment_date
         , MS.c_received_date
         , NVL(MS.c_assigned_date, MS.assignment_date)
         , 'N'
         , 'N'
         , TS.c_name
         , PR.full_name
         , Decode(PR.last_name,NULL,'N','Y')
         , sla_type.sla_days_type
         , sla_days.sla_days
         , sla_jeopardy.sla_jeopardy_days
         , sla_target.sla_target_days
      FROM  cadir_maxdat_stg          MS
      INNER JOIN cadir_role_stg       RS  ON RS.role_id = MS.role_id
      LEFT OUTER JOIN cadir_claim_type_stg TS  ON TS.id = MS.c_claim_type0
      LEFT OUTER JOIN (SELECT person_id
                          ,  COALESCE(last_name,'Unknown') last_name
                          ,  NVL(last_name, 'Unknown')||NVL2(first_name,', '||first_name, NULL)||
                             NVL2(middle_name,' '||SubStr(middle_name,1,1), NULL) full_name
                       FROM  cadir_person_stg) PR ON MS.c_created_by = PR.person_id
      LEFT OUTER JOIN (select value, out_var as sla_days_type from corp_etl_list_lkup  where name = 'ManageWork_SLA_Days_Type') SLA_TYPE
                       on  SLA_TYPE.value =  RS.name
      LEFT OUTER JOIN (select value, out_var as sla_days from corp_etl_list_lkup  where name = 'ManageWork_SLA_Days') SLA_DAYS
                       on  SLA_DAYS.value =  RS.name
      LEFT OUTER JOIN (select value, out_var as sla_jeopardy_days from corp_etl_list_lkup  where name = 'ManageWork_SLA_Jeopardy_Days') SLA_JEOPARDY
                       on  SLA_JEOPARDY.value =  RS.name
      LEFT OUTER JOIN (select value, out_var as sla_target_days from corp_etl_list_lkup  where name = 'ManageWork_SLA_Target_Days') SLA_TARGET
                       on  SLA_TARGET.value =  RS.name

      WHERE MS.data_object_key = 'T_IMR'
        AND MS.subject_type = 2
        AND RS.name <> 'Closed Cases Queue'
        AND assignment_id -- > g_Limit
        IN (31004,31552,32870,54059,106246,113650,213071,219227,220296,222811,223794,225073,225294,231933,233624,
            233787,236321,402993,403643,406805,463345,465526,766603,766822,770550,50973709,50975076)
        AND NOT EXISTS (SELECT 1 FROM corp_etl_manage_work MW WHERE MW.task_id = MS.assignment_id)
      ORDER BY MS.id;

   COMMIT;

   INSERT INTO corp_etl_manage_work_tmp
      SELECT T.*,NULL FROM corp_etl_manage_work T WHERE task_id --> g_Limit
              IN (31004,31552,32870,54059,106246,113650,213071,219227,220296,222811,223794,225073,225294,231933,233624,
                  233787,236321,402993,403643,406805,463345,465526,766603,766822,770550,50973709,50975076);
   COMMIT;

   -- Gather stats on temp table
   Maxdat_Statistics.TABLE_STATS('CORP_ETL_MANAGE_WORK_TMP');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Ins_1', 'CADIR MW', g_Error);
      COMMIT;
END lc_Ins_1;

/*
|| This procedure updates UPD2 Rule
||   2 => 1  => Null  (Claimed)
*/
PROCEDURE lc_Upd2_10
IS
   v_Stage  cadir_maxdat_stg%ROWTYPE;
   v_Name   VARCHAR2(50);
   v_Check  NUMBER;

BEGIN

   FOR CycRow IN (SELECT MW.*
                  FROM  corp_etl_manage_work MW
                     ,  cadir_maxdat_stg     MS
                  WHERE MW.source_reference_id = MS.tracking_id
                    AND MW.task_id = MS.c_assignment_from
                    AND MW.task_status = 'UNCLAIMED'
                    AND MS.subject_type = 1
                    AND MS.data_object_key = 'T_IMR'
                    AND MS.assignment_id --> g_Limit
                            IN (31004,31552,32870,54059,106246,113650,213071,219227,220296,222811,223794,225073,225294,231933,233624,
                                233787,236321,402993,403643,406805,463345,465526,766603,766822,770550,50973709,50975076)
                    AND NOT EXISTS (SELECT 1 FROM cadir_maxdat_stg XS WHERE XS.c_assignment_from = MS.c_assignment_to)
                 )
   LOOP
      BEGIN
         -- Cycrow = Parent 2   v_Stage = Child 1
         SELECT *
         INTO  v_Stage
         FROM  cadir_maxdat_stg
         WHERE c_assignment_from = CycRow.task_id;

         -- Getting the last_update from the following record - per Aram
         SELECT P.last_name||', '||first_name||' '||SubStr(middle_name,1,1)
         INTO v_Name
         FROM cadir_maxdat_stg S
         LEFT OUTER JOIN cadir_person_stg P ON S.subject_id = P.person_id
         WHERE assignment_id = v_Stage.c_assignment_from;

         IF v_Name IS NULL THEN v_Name := 'Unknown'; END IF;
         IF v_Name = ',  ' THEN v_Name := 'Unknown'; END IF;

         SELECT COUNT(1)
         INTO v_Check
         FROM corp_etl_manage_work_tmp
         WHERE cemw_id = CycRow.cemw_id;

         IF v_Check = 0 THEN
            INSERT INTO corp_etl_manage_work_tmp (
                    cemw_id
                  , last_update_date
                  , last_update_by_name
                  , task_status
                  , complete_date
                  , instance_status
                  , instance_end_date
                  , status_date
                  , asf_complete_work
                  , complete_flag
                  , parent_task_id
                  , original_creation_date
                  , owner_name
                  , updated)
               VALUES (
                    CycRow.cemw_id
                  , v_Stage.assignment_date
                  , Rtrim(v_Name,' ')
                  , 'CLAIMED'
                  , CycRow.complete_date
                  , CycRow.instance_status
                  , CycRow.instance_end_date
                  , v_Stage.assignment_date
                  , CycRow.asf_complete_work
                  , CycRow.complete_flag
                  , CycRow.parent_task_id
                  , CycRow.original_creation_date
                  , CycRow.owner_name
                  , 'Y');
         ELSE
            UPDATE corp_etl_manage_work_tmp
               SET last_update_date     = v_Stage.assignment_date
                  , last_update_by_name = Rtrim(v_Name,' ')
                  , task_status         = 'CLAIMED'
                  , status_date         = v_Stage.assignment_date
                  , updated             = 'Y'
               WHERE cemw_id = CycRow.cemw_id;
         END IF;
      EXCEPTION
         WHEN too_many_rows THEN
            INSERT INTO corp_etl_error_log (process_name,job_name,error_desc,error_codes)
                   VALUES ('Upd2_10','CADIR MW', 'TOO MANY ROWS RETURNED', CycRow.task_id);
      END;

   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Upd2_10', 'CADIR MW', g_Error);
      COMMIT;
END lc_Upd2_10;


/*
|| This procedure updates UPD3 Rule where a 2 folows a 2
||   2 => 2  => Null
*/
PROCEDURE lc_Upd3_10A
IS
   v_Stage  cadir_maxdat_stg%ROWTYPE;
   v_Name   VARCHAR2(50);
   v_Check  NUMBER;
   v_Commit NUMBER;

BEGIN
   v_Commit := 0;
   FOR CycRow IN (SELECT MW.*, MS.assignment_id child_id --(grand child task_id)
                  FROM  corp_etl_manage_work  MW
                     ,  cadir_maxdat_stg      MS
                  WHERE MW.task_id = MS.c_assignment_from
                    AND MW.task_status <> 'COMPLETE'
                    AND MW.stage_done_date IS NULL
                    AND MS.subject_type = 2
                    AND MS.data_object_key = 'T_IMR'
                    AND MS.assignment_id --> g_Limit
                    IN (31004,31552,32870,54059,106246,113650,213071,219227,220296,222811,223794,225073,225294,231933,233624,
                        233787,236321,402993,403643,406805,463345,465526,766603,766822,770550,50973709,50975076)
                  )
   LOOP
      BEGIN  -- Loop Proc Block
         -- Cycrow = Parent 2   v_Stage = Child 2
         SELECT *
         INTO v_Stage
         FROM cadir_maxdat_stg
         WHERE c_assignment_to = CycRow.child_id;

         -- Getting the last_update from the following record - per Aram
         SELECT P.last_name||', '||first_name||' '||SubStr(middle_name,1,1)
         INTO v_Name
         FROM cadir_maxdat_stg S
         LEFT OUTER JOIN cadir_person_stg P ON S.c_created_by = P.person_id
         WHERE assignment_id = v_Stage.c_assignment_from;

         IF v_Name IS NULL THEN v_Name := 'Unknown'; END IF;
         IF v_Name = ',  ' THEN v_Name := 'Unknown'; END IF;

         SELECT COUNT(1)
         INTO v_Check
         FROM corp_etl_manage_work_tmp
         WHERE cemw_id = CycRow.cemw_id;

         IF v_Check = 0 THEN
            INSERT INTO corp_etl_manage_work_tmp (
                    cemw_id
                  , last_update_date
                  , last_update_by_name
                  , task_status
                  , complete_date
                  , instance_status
                  , instance_end_date
                  , status_date
                  , asf_complete_work
                  , complete_flag
                  , parent_task_id
                  , original_creation_date
                  , owner_name
                  , updated)
               VALUES (
                   CycRow.cemw_id
                  , v_Stage.assignment_date
                  , Rtrim(v_Name,' ')
                  , 'COMPLETED'
                  , v_Stage.assignment_date
                  , 'Complete'
                  , v_Stage.assignment_date
                  , v_Stage.assignment_date
                  , 'Y'
                  , 'Y'
                  , CycRow.parent_task_id
                  , CycRow.original_creation_date
                  , CycRow.owner_name
                  , 'Y');
            ELSE
               UPDATE corp_etl_manage_work_tmp
                  SET last_update_date  = v_Stage.assignment_date
                  , last_update_by_name = Rtrim(v_Name,' ')
                  , task_status         = 'COMPLETED'
                  , complete_date       = v_Stage.assignment_date
                  , instance_status     = 'Complete'
                  , instance_end_date   = v_Stage.assignment_date
                  , status_date         = v_Stage.assignment_date
                  , asf_complete_work   = 'Y'
                  , complete_flag       = 'Y'
                  , updated             = 'Y'
               WHERE cemw_id = CycRow.cemw_id;
         END IF;

      EXCEPTION
         WHEN too_many_rows THEN
            INSERT INTO corp_etl_error_log (process_name,job_name,error_desc,error_codes)
                   VALUES ('Upd3_10B','CADIR MW', 'TOO MANY ROWS RETURNED', CycRow.task_id);
      END;  -- Loop Proc Block

      v_Commit := v_Commit+1;
      IF v_Commit > 2000 THEN
         COMMIT;
         v_Commit := 1;
      END IF;

   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Upd3_10A', 'CADIR MW', g_Error);
      COMMIT;
END lc_Upd3_10A;


/*
|| This procedure updates UPD3 Rule where a 2 folows a 2 but has an intermediate 1
||   2 => 1 => 2
*/
PROCEDURE lc_Upd3_10B
IS
   v_Stage  cadir_maxdat_stg%ROWTYPE;
   v_Name   VARCHAR2(50);
   v_Check  NUMBER;

BEGIN

   FOR CycRow IN (SELECT MW.*, MS.assignment_id gc_task_id --(grand child task_id)
                  FROM  corp_etl_manage_work  MW
                     ,  cadir_maxdat_stg      OS
                     ,  cadir_maxdat_stg      MS
                  WHERE MW.task_id = OS.c_assignment_from
                    AND OS.c_assignment_to = MS.c_assignment_from
                    AND MW.task_status <> 'COMPLETE'
                    AND MW.stage_done_date IS NULL
                    AND MS.subject_type = 2
                    AND OS.subject_type = 1
                    AND MS.data_object_key = 'T_IMR'
                    AND OS.data_object_key = 'T_IMR'
                    AND MS.assignment_id --> g_Limit
                    IN (31004,31552,32870,54059,106246,113650,213071,219227,220296,222811,223794,225073,225294,231933,233624,
                        233787,236321,402993,403643,406805,463345,465526,766603,766822,770550,50973709,50975076)
                  )
   LOOP
      BEGIN  -- Loop Proc Block
         -- Cycrow = Parent 2   v_Stage = Grandchild 2
         SELECT *
         INTO v_Stage
         FROM cadir_maxdat_stg
         WHERE c_assignment_to = CycRow.gc_task_id;

         -- Getting the last_update from the following record - per Aram
         SELECT P.last_name||', '||first_name||' '||SubStr(middle_name,1,1)
         INTO v_Name
         FROM cadir_maxdat_stg S
         LEFT OUTER JOIN cadir_person_stg P ON S.c_created_by = P.person_id
         WHERE assignment_id = v_Stage.c_assignment_from;

         IF v_Name IS NULL THEN v_Name := 'Unknown'; END IF;
         IF v_Name = ',  ' THEN v_Name := 'Unknown'; END IF;

         SELECT COUNT(1)
         INTO v_Check
         FROM corp_etl_manage_work_tmp
         WHERE cemw_id = CycRow.cemw_id;

         IF v_Check = 0 THEN
            -- Complete Close Update
            INSERT INTO corp_etl_manage_work_tmp (
                    cemw_id
                  , last_update_date
                  , last_update_by_name
                  , task_status
                  , complete_date
                  , instance_status
                  , instance_end_date
                  , status_date
                  , asf_complete_work
                  , complete_flag
                  , parent_task_id
                  , original_creation_date
                  , owner_name
                  , updated)
               VALUES (
                    CycRow.cemw_id
                  , v_Stage.assignment_date
                  , Rtrim(v_Name,' ')
                  , 'COMPLETED'
                  , v_Stage.assignment_date
                  , 'Complete'
                  , v_Stage.assignment_date
                  , v_Stage.assignment_date
                  , 'Y'
                  , 'Y'
                  , CycRow.parent_task_id
                  , CycRow.original_creation_date
                  , CycRow.owner_name
                  , 'Y');
            ELSE
               UPDATE corp_etl_manage_work_tmp
                  SET last_update_date  = v_Stage.assignment_date
                  , last_update_by_name = Rtrim(v_Name,' ')
                  , task_status         = 'COMPLETED'
                  , complete_date       = v_Stage.assignment_date
                  , instance_status     = 'Complete'
                  , instance_end_date   = v_Stage.assignment_date
                  , status_date         = v_Stage.assignment_date
                  , asf_complete_work   = 'Y'
                  , complete_flag       = 'Y'
                  , updated             = 'Y'
               WHERE cemw_id = CycRow.cemw_id;
         END IF;

      EXCEPTION
         WHEN too_many_rows THEN
            INSERT INTO corp_etl_error_log (process_name,job_name,error_desc,error_codes)
                   VALUES ('Upd3_10B','CADIR MW', 'TOO MANY ROWS RETURNED', CycRow.task_id);
      END;  -- Loop Proc Block

   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Upd3_10B', 'CADIR MW', g_Error);
      COMMIT;
END lc_Upd3_10B;

/*
|| This procedure updates some info that needs to be in the tables first. Then it
||   updates all of Manage Work with a single update to each record no matter how many
||   changes were made to each one
*/
PROCEDURE lc_UpdateMW
IS
   CURSOR c_Parent (cp_Start_Id NUMBER) IS
      SELECT assignment_id
      FROM cadir_maxdat_stg
      WHERE subject_type = 2
      START WITH assignment_id = cp_Start_Id
      CONNECT BY PRIOR c_assignment_to = c_assignment_from;

   CURSOR cOrigCreate is
       SELECT source_reference_id refid, MIN(create_date) cdate
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
   FOR r_Row IN (SELECT W.*
                    ,  P.last_name||', '||P.first_name||' '||SubStr(P.middle_name,1,1) full_name
                 FROM  corp_etl_manage_work W
                 INNER JOIN cadir_maxdat_stg M ON M.c_assignment_from = W.task_id
                 LEFT  OUTER JOIN cadir_user_stg   U ON M.subject_id = U.user_id
                 LEFT  OUTER JOIN cadir_person_stg P ON U.person_id = P.person_id
                 WHERE W.owner_name IS NULL
                   AND W.task_id --> g_Limit
                    IN (31004,31552,32870,54059,106246,113650,213071,219227,220296,222811,223794,225073,225294,231933,233624,
                        233787,236321,402993,403643,406805,463345,465526,766603,766822,770550,50973709,50975076)
                   AND M.subject_type = 1
                )
   LOOP
      v_Name := Rtrim(r_Row.full_name);
      IF v_Name IS NULL THEN v_Name := 'Unknown'; END IF;
      IF v_Name = ',' THEN v_Name := 'Unknown'; END IF;

      SELECT COUNT(1)
      INTO v_Check
      FROM corp_etl_manage_work_tmp
      WHERE cemw_id = r_Row.cemw_id;

      IF v_Check = 0 THEN
         -- Complete Cloase Update
         INSERT INTO corp_etl_manage_work_tmp (
                 cemw_id
               , last_update_date
               , last_update_by_name
               , task_status
               , complete_date
               , instance_status
               , instance_end_date
               , status_date
               , asf_complete_work
               , complete_flag
               , parent_task_id
               , original_creation_date
               , owner_name
               , updated)
            VALUES (
                 r_Row.cemw_id
               , r_Row.last_update_date
               , r_Row.last_update_by_name
               , r_Row.task_status
               , r_Row.complete_date
               , r_Row.instance_status
               , r_Row.instance_end_date
               , r_Row.status_date
               , r_Row.asf_complete_work
               , r_Row.complete_flag
               , r_Row.parent_task_id
               , r_Row.original_creation_date
               , v_Name
               , 'Y');
      ELSE
         UPDATE corp_etl_manage_work_tmp
            SET   owner_name = v_Name
            WHERE cemw_id = r_Row.cemw_id;
      END IF;
   END LOOP;
   COMMIT;


END lc_UpdateMW;
--=================

BEGIN

--- Init Proc
begin

   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'InitProc');   commit;

   MAXDAT_CADR.cadir_etl_manage_work_pkg.InitProcess;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;

end;
   
--------------- lc_Ins_1
   
begin
   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'INS_1');
   commit;

   lc_Ins_1;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;
end;   
   
--------------- lc_upd2_10
   
begin
   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'Upd2_10');
   commit;

   lc_Upd2_10;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;
end;

---------  lc_Upd3_10A

begin
   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'Upd3_10A');
   commit;

   lc_Upd3_10A;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;
end;

----- lc_Upd3_10B

begin
   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'Upd3_10B');
   commit;

   lc_Upd3_10B;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;
end;

----- upd3_10C

begin
   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'Upd3_10C');
   commit;

   MAXDAT_CADR.cadir_etl_manage_work_pkg.Upd3_10C;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;
end;

----- Upd6_10

begin
   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'Upd6_10');
   commit;

   MAXDAT_CADR.cadir_etl_manage_work_pkg.Upd6_10;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;
end;

---- lc_UpdateMW 

begin
   insert into MAXDAT_CADR.cadir_managework_logging values(sysdate,null,'UpdateMW');
   commit;

   lc_UpdateMW;

   update MAXDAT_CADR.cadir_managework_logging
      set end_date = sysdate
      where end_date is null;
   commit;
   
   INSERT INTO cadir_managework_logging VALUES (SYSDATE, SYSDATE, 'MW_UPDATE_MAIN_TABLE');
   commit;

   MAXDAT_CADR.cadir_etl_manage_work_pkg.MW_UPDATE_MAIN_TABLE;

end;

END;

