alter session set plsql_code_type = native;

CREATE OR REPLACE PACKAGE MAXDAT_CADR.cadir_etl_manage_work_pkg IS
/*
|| CA DIR Project
||    This source code is the intellectual property of MAXIMUS.
||    Copyright(c) 2007 MAXIMUS, Inc. All rights reserved.
|| Scope   : This package contains procedures to populate an altered version of Managed Work
||             It will build a tmp table to do bulk updates/inserts to manage work.
|| Written : Dave Dillon
|| Date    : June 18, 2014
|| Revisions ---------------------------------------------------------------------
|| DDillon 	06/18/2014	Written
|| DDillon	07/07/2014	Released to SVN
|| DDillon  07/22/2014  Adding some things found in code review with Farook. Also making pieces to be
||                        called from kettle.
|| DDillon  07/24/2014  Made changes for new rules from Aram - a) Owner name only comes from a 1 record
||                        b) If a 1 starts the sequence - not going to use a parent_id for the following 2
|| DDillon  08/02/2014  Update Owner logic - was going directly to person insted of going through user
||                      Also added performance tracker in the last module that are temporary
|| FMullah  08/06/2014  Added SLA variables to INS_1 Proc
||                      Also modified updateMW Proc to update parent task id only for those tasks that
||                      are currently being processed in hourly run.
|| FMullah  08/07/2014  Modified Ins_1 proc to include outer join when connecting cadir_claim_type_stg table.
|| FMullah  08/12/2014  Modified Ins_1 proc to connect with USER table to extract created_by_name
||                      Modified Upd2_10, Upd3_10A, Upd3_10B and Upd3_10c to join with USER table
||                      to extract last_update_by_name and last_update_date
|| FMullah  08/21/2014  Added extract logic for 3 new attributes, Role Name, ClaimDate, LastTask
|| FMullah  09/10/2014  Added extract logic for new attributes, Prev Task Name, Prev Task Create Date
|| FMullah  09/30/2014  Added extract logic for tasks from SQID database
|| FMullah  10/14/2014  Added extract logic for Team Supervisor name
|| FMullah  02/25/2015  Modified PROCESS_SQID_TASKS and commented out code that sets in_process column.
|| FMullah  03/23/2015  Added Process_Deltek_load
|| Fmullah  03/27/2015  Added data format global control variable to process deltek load procedure.
|| Fmullah  05/08/2015  Modified process deltek load procedure, to end date record loaded in previous file, should entry be found
||                      for an employee for certain date in new file to be processed.
|| Fmullah  05/21/2015  Added new function Get_Person_ID
||                      Added extract logic for Person_ID
|| Fmullah  06/04/2015  Modified Process Deltek Load procedure, not to update record if sup_updated is set to 'Y'.
|| Fmullah  06/24/2015  Added Fix_Run_Away_Tasks procedure to correct entellitrak records.
|| Fmullah  08/31/2017  Added logic to calc pharma flag
|| Fmullah  11/10/2017  Modified Fix_Run_Away_Tasks, added logic to reset closed flag to update decision mailed date
|| Fmullah  03/30/2020  Modified Process_SQID TASKS procedure 
|| Fmullah  06/05/2020  Added SET_REDACTED_CASES procedure  
||
*/

-- Do not edit these four SVN_* variable values.  They are populated when you commit code
--    to SVN and used later to identify deployed code.
   SVN_FILE_URL varchar2(200) := '$URL$';
  	SVN_REVISION varchar2(20) := '$Revision$';
   SVN_REVISION_DATE varchar2(60) := '$Date$';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

/*
||  Procedures
*/
   PROCEDURE InitProcess;   --<< Resets from last run

   PROCEDURE Ins_1;         --<< Inserts all new 2 records

   PROCEDURE Upd2_10;       --<< Updates "Claimed"

   PROCEDURE Upd3_10A;      --<< Updates Closed for a 2 -> 2
   PROCEDURE Upd3_10B;      --<< Updates Closed for a 2 -> 1 -> 2
   PROCEDURE Upd3_10C;      --<< Update Close/Forward for 2 -> 1 -> 1 -> 2

   PROCEDURE Upd6_10;       --<< Update done dates

   PROCEDURE UpdateMW;       --<< Misc Update
   PROCEDURE MW_UPDATE_MAIN_TABLE; -- Master Update of Manage Work table

   PROCEDURE PROCESS_SQID_TASKS;

   PROCEDURE PROCESS_DELTEK_LOAD;

   PROCEDURE FIX_RUN_AWAY_TASKS;
   
   PROCEDURE SET_REDACTED_CASES;

/*
|| Functions
*/

   FUNCTION Get_Person_ID
            (p_user_id in number)
     RETURN number parallel_enable;

   FUNCTION Get_Person_Name
            (p_user_id in number)
     RETURN varchar2 parallel_enable;

   FUNCTION Get_Role_Name
         (p_role_id in number)
     RETURN varchar2 parallel_enable;

   FUNCTION Get_Supervisor_Name
            (p_user_id in number)
     RETURN varchar2 parallel_enable;

END cadir_etl_manage_work_pkg;
/

CREATE OR REPLACE PACKAGE BODY MAXDAT_CADR.cadir_etl_manage_work_pkg IS
   g_Error   VARCHAR2(4000);
   g_Limit   NUMBER;
   gPKG VARCHAR2(30) := 'CADIR_ETL_MANAGE_WORK_PKG';

FUNCTION Get_Person_ID
         (p_user_id in number)
RETURN Number parallel_enable
AS
     v_parameter_value number := null;
BEGIN

    IF p_user_id IS NULL THEN
       v_parameter_value := null;
    ELSE

         Select P.Person_ID
           Into v_parameter_value
           From cadir_user_stg U
           Left Outer Join cadir_person_stg P ON U.person_id = P.person_id
          Where U.user_id = p_user_id ;

    END IF;

    RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN null;
END;

FUNCTION Get_Person_Name
         (p_user_id in number)
RETURN varchar2 parallel_enable
AS
     v_parameter_value varchar2(100) := null;
BEGIN

    IF p_user_id IS NULL THEN
       v_parameter_value := 'Unknown';
    ELSE

         Select TRIM(P.Last_Name) || DECODE(Last_Name, NULL, NULL, ',') || TRIM(First_Name) || RTRIM(LPAD(SUBSTR(Middle_Name, 1, 1),2, ' '))
           Into v_parameter_value
           From cadir_user_stg U
           Left Outer Join cadir_person_stg P ON U.person_id = P.person_id
          Where U.user_id = p_user_id ;

    END IF;

    RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN 'Unknown';
END;


FUNCTION Get_Role_Name
         (p_role_id in number)
RETURN varchar2 parallel_enable
AS
     v_parameter_value varchar2(100) := null;
BEGIN

    IF p_role_id IS NULL THEN
       v_parameter_value := 'Unknown';
    ELSE

         Select Name
           Into v_parameter_value
           From cadir_role_stg R
          Where R.role_id = p_role_id ;

    END IF;

    RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN 'Unknown';
END;


FUNCTION Get_Supervisor_Name
         (p_user_id in number)
RETURN varchar2 parallel_enable
AS
     v_parameter_value varchar2(100) := null;
BEGIN

    IF p_user_id IS NULL THEN
       v_parameter_value := Null;
    ELSE

         Select TRIM(P.Last_Name) || DECODE(P.Last_Name, NULL, NULL, ',') || TRIM(P.First_Name) || RTRIM(LPAD(SUBSTR(P.Middle_Name, 1, 1),2, ' '))
           Into v_parameter_value
           From cadir_user_stg U
           Inner Join d_supervisor S on U.person_id = S.person_id
           Inner Join cadir_person_stg p on S.supervisor_person_id = P.person_ID
           Where U.user_id = p_user_id ;

    END IF;

    RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN Null;
END;


PROCEDURE InitProcess
IS
v_role_id number;
BEGIN
   -- Remove any old records from tmp table
   DELETE FROM corp_etl_manage_work_tmp;
   COMMIT;

   -- Get Lower Limt From Controls
   SELECT To_Number(value)
   INTO g_Limit
   FROM corp_etl_control
   WHERE name = 'MW_MAX_PROCESSED_ID';

   -- Update cadir maxdat stg

   SELECT role_id
     INTO v_role_id
     FROM cadir_role_stg
    WHERE name = 'Closed Cases Queue';

   UPDATE cadir_maxdat_stg
      SET MW_Processed = 'Y'
    WHERE MW_Processed = 'N'
      AND ( subject_type = 1
            OR
           (subject_type = 2 AND role_id = v_role_id)  ) ;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('INIT', 'CADIR MW', g_Error);
      COMMIT;
END InitProcess;

/*
|| Procedure to insert into corp_etl_manage_work where the etk role name is not "Closed Cases Queue" - AND they
||   do not already exist in corp_etl_manage_work.
*/
PROCEDURE Ins_1
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
         , cadir_etl_manage_work_pkg.Get_Person_Name(MS.c_created_by)
         , RS.name
         , cadir_etl_manage_work_pkg.Get_Person_Name(MS.c_created_by)
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
         , MS.c_assigned_date
         , 'N'
         , 'N'
         , TS.c_name
         , NULL
         , 'N'
         , sla_type.sla_days_type
         , sla_days.sla_days
         , sla_jeopardy.sla_jeopardy_days
         , sla_target.sla_target_days
      FROM  cadir_maxdat_stg          MS
      INNER JOIN cadir_role_stg       RS  ON RS.role_id = MS.role_id
      LEFT OUTER JOIN cadir_claim_type_stg TS  ON TS.id = MS.c_claim_type0
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
        AND MW_Processed = 'N'
        AND NOT EXISTS (SELECT 1 FROM corp_etl_manage_work MW WHERE MW.task_id = MS.assignment_id);

   COMMIT;

   INSERT INTO corp_etl_manage_work_tmp
      SELECT T.*,NULL
        FROM corp_etl_manage_work T , cadir_maxdat_stg ms
       WHERE task_id = ms.assignment_id
         AND mw_processed = 'N';

   COMMIT;

   -- Gather stats on temp table
   Maxdat_Statistics.TABLE_STATS('CORP_ETL_MANAGE_WORK_TMP');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Ins_1', 'CADIR MW', g_Error);
      COMMIT;
END Ins_1;

/*
|| This procedure updates UPD2 Rule
||   2 => 1  => Null  (Claimed)
*/
PROCEDURE Upd2_10
IS

   v_Name     VARCHAR2(50);
   v_RoleName VARCHAR2(50);
   v_Check    NUMBER;

BEGIN

   FOR CycRow IN (SELECT MW.*, MS.Subject_id ,MS.Role_id, MS.Assignment_date gc_Assignment_date
                  FROM  corp_etl_manage_work MW
                     ,  cadir_maxdat_stg     MS
                  WHERE MW.task_id = MS.c_assignment_from
                    AND MW.task_status = 'UNCLAIMED'
                    AND MS.subject_type = 1
                    AND MS.data_object_key = 'T_IMR'
                    AND NOT EXISTS (SELECT 1 FROM cadir_maxdat_stg XS WHERE XS.c_assignment_from = MS.c_assignment_to)
                  ORDER BY MW.Source_reference_id, mw.task_id
                 )
   LOOP
      BEGIN

         -- Cycrow = Parent 2   v_Stage = Child 1
         v_Name := cadir_etl_manage_work_pkg.Get_Person_Name(CycRow.subject_id);
         v_RoleName := cadir_etl_manage_work_pkg.Get_Role_Name(CycRow.Role_id);

         SELECT COUNT(1)
         INTO v_Check
         FROM corp_etl_manage_work_tmp
         WHERE cemw_id = CycRow.cemw_id;

         IF v_Check = 0 THEN
            INSERT INTO corp_etl_manage_work_tmp
            SELECT T.*,NULL FROM corp_etl_manage_work T WHERE cemw_id = CycRow.cemw_id;
         END IF;

        UPDATE corp_etl_manage_work_tmp
           SET last_update_date     = CycRow.gc_assignment_date
              , last_update_by_name = Rtrim(v_Name,' ')
              , task_status         = 'CLAIMED'
              , status_date         = CycRow.gc_assignment_date
              , role_Name           = Rtrim(v_RoleName,' ')
              , claim_date          = CycRow.gc_assignment_date
              , updated             = 'Y'
           WHERE cemw_id = CycRow.cemw_id;

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
END Upd2_10;


/*
|| This procedure updates UPD3 Rule where a 2 folows a 2
||   2 => 2  => Null
*/
PROCEDURE Upd3_10A
IS

   v_Name   VARCHAR2(50);
   v_Check  NUMBER;
   v_Commit NUMBER;

BEGIN
   v_Commit := 0;
   FOR CycRow IN (SELECT MW.*, MS.c_Created_by , MS.Assignment_date gc_assignment_date , MS.assignment_id gc_task_id --(grand child task_id)
                  FROM  corp_etl_manage_work  MW
                     ,  cadir_maxdat_stg      MS
                  WHERE MW.task_id = MS.c_assignment_from
                    AND MW.task_status <> 'COMPLETE'
                    AND MW.stage_done_date IS NULL
                    AND MS.subject_type = 2
                    AND MS.data_object_key = 'T_IMR'
                  ORDER BY MW.Source_reference_id, mw.task_id
                  )
   LOOP
      BEGIN  -- Loop Proc Block

         -- Cycrow = Parent 2   v_Stage = Child 2
         v_Name := cadir_etl_manage_work_pkg.Get_Person_Name(CycRow.c_created_by);

         SELECT COUNT(1)
         INTO v_Check
         FROM corp_etl_manage_work_tmp
         WHERE cemw_id = CycRow.cemw_id;

         IF v_Check = 0 THEN
            INSERT INTO corp_etl_manage_work_tmp
            SELECT T.*,NULL FROM corp_etl_manage_work T WHERE cemw_id = CycRow.cemw_id;
         END IF;

         UPDATE corp_etl_manage_work_tmp
            SET last_update_date  = CycRow.gc_assignment_date
            , last_update_by_name = Rtrim(v_Name,' ')
            , task_status         = 'COMPLETED'
            , complete_date       = CycRow.gc_assignment_date
            , instance_status     = 'Complete'
            , instance_end_date   = CycRow.gc_assignment_date
            , status_date         = CycRow.gc_assignment_date
            , asf_complete_work   = 'Y'
            , complete_flag       = 'Y'
            , updated             = 'Y'
         WHERE cemw_id = CycRow.cemw_id;

      EXCEPTION
         WHEN too_many_rows THEN
            INSERT INTO corp_etl_error_log (process_name,job_name,error_desc,error_codes)
                   VALUES ('Upd3_10B','CADIR MW', 'TOO MANY ROWS RETURNED', CycRow.task_id);
      END;  -- Loop Proc Block

      v_Commit := v_Commit+1;
      IF v_Commit > 100 THEN
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
END Upd3_10A;


/*
|| This procedure updates UPD3 Rule where a 2 folows a 2 but has an intermediate 1
||   2 => 1 => 2
*/
PROCEDURE Upd3_10B
IS

   v_Name       VARCHAR2(50);
   v_RoleName   VARCHAR2(50);
   v_Check  NUMBER;

BEGIN

   FOR CycRow IN (SELECT MW.*,
                         OS.Role_id c_role_id, OS.Assignment_date c_assignment_date,
                         MS.c_Created_by , MS.Assignment_date gc_assignment_date, MS.assignment_id gc_task_id
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
                  ORDER BY MW.Source_reference_id, mw.task_id
                  )
   LOOP
      BEGIN  -- Loop Proc Block

         -- Cycrow = Parent 2   v_Stage = Grandchild 2
         v_Name := cadir_etl_manage_work_pkg.Get_Person_Name(CycRow.c_created_by);
         v_RoleName := cadir_etl_manage_work_pkg.Get_Role_Name(CycRow.c_role_id);

         SELECT COUNT(1)
         INTO v_Check
         FROM corp_etl_manage_work_tmp
         WHERE cemw_id = CycRow.cemw_id;

         IF v_Check = 0 THEN
            -- Complete Close Update
            INSERT INTO corp_etl_manage_work_tmp
            SELECT T.*,NULL FROM corp_etl_manage_work T WHERE cemw_id = CycRow.cemw_id;
         END IF;

         UPDATE corp_etl_manage_work_tmp
            SET last_update_date  = CycRow.gc_assignment_date
            , last_update_by_name = Rtrim(v_Name,' ')
            , task_status         = 'COMPLETED'
            , complete_date       = CycRow.gc_assignment_date
            , instance_status     = 'Complete'
            , instance_end_date   = CycRow.gc_assignment_date
            , status_date         = CycRow.gc_assignment_date
            , asf_complete_work   = 'Y'
            , complete_flag       = 'Y'
            , role_name           = Rtrim(v_RoleName,' ')
            , claim_date          = CycRow.c_assignment_date
            , updated             = 'Y'
         WHERE cemw_id = CycRow.cemw_id;

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
END Upd3_10B;


/*
|| This procedure updates UPD3 Rule where a 2 folows a 2 but has more that on intermediate 1.  It's basically
||  like Upd3Rule_B - except it also updates the forward by fileds in the child as well as the parent task id.
||   2 => 1 => 1 => 1 => 2
*/
PROCEDURE Upd3_10C
IS
   CURSOR c_Branch (cp_Start_Id NUMBER) IS
      SELECT MS.*
      FROM cadir_maxdat_stg MS
      WHERE subject_type = 2
      START WITH c_assignment_from = cp_Start_Id
      CONNECT BY PRIOR c_assignment_to = c_assignment_from;

   r_Branch c_Branch%ROWTYPE;
   v_Check  NUMBER;
   v_Name       VARCHAR2(50);
   v_RoleName   VARCHAR2(50);
   v_forwarded_by_name VARCHAR2(50);

BEGIN
   FOR CycRow IN (SELECT MW.*
                         ,OS.Assignment_id c_task_id, OS.Role_id c_role_id
                         ,OS.Subject_ID c_subject_id, OS.Assignment_date c_assignment_date
                         ,MS.assignment_id gc_task_id
                  FROM  corp_etl_manage_work  MW
                     ,  cadir_maxdat_stg      OS
                     ,  cadir_maxdat_stg      MS
                  WHERE MW.task_id = OS.c_assignment_from
                    AND OS.c_assignment_to = MS.c_assignment_from
                    AND MW.task_status <> 'COMPLETE'
                    AND MW.stage_done_date IS NULL
                    AND MS.subject_type = 1
                    AND OS.subject_type = 1
                    AND MS.data_object_key = 'T_IMR'
                    AND OS.data_object_key = 'T_IMR'
                  ORDER BY MW.Source_reference_id, mw.task_id
                 )
   LOOP
      BEGIN

         v_RoleName := cadir_etl_manage_work_pkg.Get_Role_Name(CycRow.c_role_id);

         r_branch.assignment_id := Null;
         OPEN c_Branch(CycRow.c_task_id);
         FETCH  c_Branch INTO r_Branch;
         CLOSE c_Branch;

         -- CycRow = Parent 2, r_Branch = Child 2
         IF r_Branch.assignment_id IS NOT NULL THEN

            v_Name := cadir_etl_manage_work_pkg.Get_Person_Name(r_Branch.c_created_by);
            v_forwarded_by_name := cadir_etl_manage_work_pkg.Get_Person_Name(CycRow.c_subject_id);

            SELECT COUNT(1)
            INTO v_Check
            FROM corp_etl_manage_work_tmp
            WHERE cemw_id = CycRow.cemw_id;

            IF v_Check = 0 THEN
               INSERT INTO corp_etl_manage_work_tmp
               SELECT T.*,NULL FROM corp_etl_manage_work T WHERE cemw_id = CycRow.cemw_id;
            END IF;

             UPDATE corp_etl_manage_work_tmp
                SET last_update_date    = r_Branch.assignment_date
                  , last_update_by_name = Rtrim(v_Name,' ')
                  , task_status         = 'COMPLETED'
                  , complete_date       = r_Branch.assignment_date
                  , instance_status     = 'Complete'
                  , instance_end_date   = r_Branch.assignment_date
                  , status_date         = r_Branch.assignment_date
                  , asf_complete_work   = 'Y'
                  , forwarded_by_name   = Rtrim(v_forwarded_by_name,' ')
                  , forwarded_flag      = 'Y'
                  , complete_flag       = 'Y'
                  , role_name           = Rtrim(v_RoleName,' ')
                  , claim_date          = CycRow.c_assignment_Date
                  , updated             = 'Y'
             WHERE cemw_id = CycRow.cemw_id;

        ELSE -- CycRow = Parent 2 and child 1

            v_Name := cadir_etl_manage_work_pkg.Get_Person_Name(CycRow.c_subject_id);

             SELECT COUNT(1)
             INTO v_Check
             FROM corp_etl_manage_work_tmp
             WHERE cemw_id = CycRow.cemw_id;

             IF v_Check = 0 THEN
                INSERT INTO corp_etl_manage_work_tmp
                SELECT T.*,NULL FROM corp_etl_manage_work T WHERE cemw_id = CycRow.cemw_id;
             END IF;

            UPDATE corp_etl_manage_work_tmp
               SET last_update_date     = CycRow.c_assignment_date
                  , last_update_by_name = Rtrim(v_Name,' ')
                  , task_status         = 'CLAIMED'
                  , status_date         = CycRow.c_assignment_date
                  , forwarded_by_name   = Rtrim(v_Name,' ')
                  , forwarded_flag      = 'Y'
                  , role_name           = Rtrim(v_RoleName,' ')
                  , claim_date          = CycRow.c_assignment_date
                  , updated             = 'Y'
               WHERE cemw_id = CycRow.cemw_id;

        END IF;
      EXCEPTION
         WHEN too_many_rows THEN
            INSERT INTO corp_etl_error_log (process_name,job_name,error_desc,error_codes)
                   VALUES ('Upd3_10C','CADIR MW', 'TOO MANY ROWS RETURNED', CycRow.task_id);
      END;

   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Upd3_10C', 'CADIR MW', g_Error);
      COMMIT;
END Upd3_10C;

/*
|| This procedure just updates the the stage done date - it may do other things in the future
*/
PROCEDURE Upd6_10
IS

BEGIN
   --===================  UPD6  =========================
   -- Set Stage Done Flag
   UPDATE   corp_etl_manage_work_tmp
      SET   stage_done_date = SYSDATE
      WHERE stage_done_date IS NULL
        AND instance_status = 'Complete'
        AND task_status = 'COMPLETED';

   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name,job_name,error_desc) VALUES ('Upd6_10','CADIR MW', g_Error);
      COMMIT;

END Upd6_10;

/*
|| This procedure updates some info that needs to be in the tables first. Then it
||   updates all of Manage Work with a single update to each record no matter how many
||   changes were made to each one
*/
PROCEDURE UpdateMW
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
   v_Sup_Name  VARCHAR2(50);
   v_Name   VARCHAR2(50);
   v_Check  NUMBER;
   v_ParID  NUMBER;
   v_ChdID  NUMBER;
   v_PersonID NUMBER;

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
INSERT INTO cadir_managework_logging VALUES (SYSDATE, SYSDATE, 'ParentID');
commit;
-------------------
   FOR r_Row IN (SELECT task_id
                   FROM corp_etl_manage_work
                  WHERE task_id NOT IN (SELECT parent_task_id
                                          FROM corp_etl_manage_work
                                         WHERE parent_task_id IS NOT NULL)
                    AND source_reference_id in ( select distinct source_reference_id from corp_etl_manage_work_tmp)
                    order by source_reference_id, task_id
                 )
   LOOP
      OPEN c_Parent(r_Row.task_id);
      FETCH c_Parent INTO r_Parent;
      v_ParID := r_Parent.Assignment_Id;
      LOOP
         FETCH c_Parent INTO r_Parent;
         EXIT WHEN c_Parent%NOTFOUND;

         v_ChdID := r_Parent.Assignment_Id;
         IF nvl(v_ParID,0) <> nvl(v_ChdID,0) THEN
            UPDATE  corp_etl_manage_work_tmp
              SET   parent_task_id = v_ParID
                  , updated = 'Y'
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
INSERT INTO cadir_managework_logging VALUES (SYSDATE, SYSDATE, 'Owner');
commit;
-------------------
   FOR r_Row IN (SELECT W.* , M.Subject_Type, M.Subject_ID, M.c_Created_By
                   FROM corp_etl_manage_work W
                  INNER JOIN cadir_maxdat_stg M ON M.c_assignment_from = W.task_id
                  WHERE W.owner_name IS NULL
                    AND W.Stage_done_date IS NULL
                )
   LOOP

     -- If child =  1 then use subject id
     IF r_Row.Subject_Type = 1 THEN
        v_PersonID := cadir_etl_manage_work_pkg.Get_Person_ID(r_Row.Subject_ID);
        v_Name := cadir_etl_manage_work_pkg.Get_Person_Name(r_Row.Subject_ID);
        v_Sup_Name := cadir_etl_manage_work_pkg.Get_Supervisor_Name(r_Row.Subject_ID);
     ELSE
        -- Aram confirmed that if followed by type 2 then Owner Name is not set
         v_PersonID := Null;
         v_Name := Null ;
         v_Sup_Name := Null;
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
           , Team_Supervisor_Name = v_Sup_Name
           , Person_ID = v_PersonID
           , updated = 'Y'
       WHERE cemw_id = r_Row.cemw_id;

   END LOOP;
   COMMIT;


INSERT INTO cadir_managework_logging VALUES (SYSDATE, SYSDATE, 'LastTask');
commit;
-------------------
   FOR r_Row IN (SELECT cemw_id, task_id
                   FROM corp_etl_manage_work W
                  WHERE W.Last_Task = 'N'
                    AND W.Stage_done_date IS NULL
                    AND EXISTS ( select 1 from cadir_maxdat_stg M , cadir_role_stg R
                                 where m.role_id = r.role_id
                                   and r.name = 'Closed Cases Queue'
                                   and m.assignment_id = ( SELECT Min(assignment_id)
                                                             FROM cadir_maxdat_stg MS
                                                            WHERE subject_type = 2
                                                            START WITH c_assignment_from = w.task_id
                                                          CONNECT BY PRIOR c_assignment_to = c_assignment_from) )
                )
   LOOP

     SELECT COUNT(1)
       INTO v_Check
       FROM corp_etl_manage_work_tmp
      WHERE cemw_id = r_Row.cemw_id;

      IF v_Check = 0 THEN
          INSERT INTO corp_etl_manage_work_tmp
            SELECT T.*,NULL FROM corp_etl_manage_work T WHERE cemw_id = r_Row.cemw_id;
      END IF;

      UPDATE corp_etl_manage_work_tmp
         SET Last_Task = 'Y'
           , updated = 'Y'
       WHERE cemw_id = r_Row.cemw_id;

   END LOOP;
   COMMIT;
-------------------
INSERT INTO cadir_managework_logging VALUES (SYSDATE, SYSDATE, 'Prev Task Name');
commit;
-------------------
   FOR r_Row IN (SELECT a.task_id, a.parent_task_id, a.cemw_id
                      , r.name Queue_From, b.assignment_date Prev_task_Create_Dt
                   FROM corp_etl_manage_work a
                   JOIN cadir_maxdat_stg b on a.parent_task_id  = b.assignment_id
                   JOIN cadir_role_stg r on b.role_id = r.role_id
                  WHERE a.Prev_Task_Name IS NULL
                    AND a.Stage_done_date IS NULL
                  UNION
		 SELECT a.task_id, a.parent_task_id, a.cemw_id
                      , r.name Queue_From, b.assignment_date Prev_task_Create_Dt
                   FROM corp_etl_manage_work_tmp a
                   JOIN cadir_maxdat_stg b on a.parent_task_id  = b.assignment_id
                   JOIN cadir_role_stg r on b.role_id = r.role_id
                  WHERE a.Prev_Task_Name IS NULL
                 )
   LOOP

     SELECT COUNT(1)
       INTO v_Check
       FROM corp_etl_manage_work_tmp
      WHERE cemw_id = r_Row.cemw_id;

      IF v_Check = 0 THEN
          INSERT INTO corp_etl_manage_work_tmp
            SELECT T.*,NULL FROM corp_etl_manage_work T WHERE cemw_id = r_Row.cemw_id;
      END IF;

      UPDATE corp_etl_manage_work_tmp
         SET Prev_Task_Name = r_Row.Queue_From
           , Prev_Task_Create_Date = r_Row.Prev_Task_Create_Dt
           , updated = 'Y'
       WHERE cemw_id = r_Row.cemw_id;

   COMMIT;
   END LOOP;

-------------------

INSERT INTO cadir_managework_logging VALUES (SYSDATE, SYSDATE, 'MW_UPDATE_MAIN_TABLE');
commit;

MW_UPDATE_MAIN_TABLE;

INSERT INTO cadir_managework_logging VALUES (SYSDATE, SYSDATE, 'FIX_RUN_AWAY_TASKS');
commit;

FIX_RUN_AWAY_TASKS;

INSERT INTO cadir_managework_logging VALUES (SYSDATE, SYSDATE, 'upd_CNTRL_TAB');
commit;

  UPDATE corp_etl_control
     SET VALUE = (SELECT to_char(NVL(MAX(task_id),0)) FROM corp_etl_manage_work)
     WHERE NAME = 'MW_MAX_PROCESSED_ID';

  UPDATE cadir_maxdat_stg
     SET MW_Processed = 'Y'
   WHERE MW_processed = 'N'
     AND assignment_id in (select task_id from corp_etl_manage_work_tmp where updated = 'Y');

 COMMIT;

------------------

INSERT INTO cadir_managework_logging VALUES (SYSDATE, SYSDATE, 'MW_PROCESS_SQID');
commit;

PROCESS_SQID_TASKS;

INSERT INTO cadir_managework_logging VALUES (SYSDATE, SYSDATE, 'MW_PROCESS_SQID');
commit;


END UpdateMW;

--=================
PROCEDURE MW_UPDATE_MAIN_TABLE AS

 CURSOR wip_cur IS
   SELECT * FROM corp_etl_manage_work_tmp
   WHERE UPDATED = 'Y';

   TYPE t_wip_tab IS TABLE OF wip_cur%ROWTYPE INDEX BY PLS_INTEGER;
    wip_tab t_wip_tab;
    v_bulk_limit NUMBER := 1000;
    v_step VARCHAR2(100);
    v_err_code VARCHAR2(30);
    --v_err_msg VARCHAR2(240);
    v_err_index NUMBER;
    vPROC VARCHAR2(30) := 'MW_UPDATE_MAIN_TABLE';
BEGIN
   v_step :=  gPKG||'.'||vPROC||' - Updateing Main table';
   OPEN wip_cur;
   LOOP
     FETCH wip_cur BULK COLLECT INTO wip_tab LIMIT v_bulk_limit;
     EXIT WHEN wip_tab.COUNT = 0; -- Exit when missing rows

     BEGIN
       FORALL indx IN 1 .. wip_tab.COUNT SAVE EXCEPTIONS
         UPDATE corp_etl_manage_work
            SET ASF_CANCEL_WORK  =  wip_tab(indx).ASF_CANCEL_WORK,
                ASF_COMPLETE_WORK  =  wip_tab(indx).ASF_COMPLETE_WORK,
                AGE_IN_BUSINESS_DAYS  =  wip_tab(indx).AGE_IN_BUSINESS_DAYS,
                AGE_IN_CALENDAR_DAYS  =  wip_tab(indx).AGE_IN_CALENDAR_DAYS,
                CANCEL_WORK_DATE  =  wip_tab(indx).CANCEL_WORK_DATE,
                CANCEL_WORK_FLAG  =  wip_tab(indx).CANCEL_WORK_FLAG,
                COMPLETE_DATE  =  wip_tab(indx).COMPLETE_DATE,
                COMPLETE_FLAG  =  wip_tab(indx).COMPLETE_FLAG,
                CREATE_DATE  =  wip_tab(indx).CREATE_DATE,
                CREATED_BY_NAME  =  wip_tab(indx).CREATED_BY_NAME,
                ESCALATED_FLAG  =  wip_tab(indx).ESCALATED_FLAG,
                ESCALATED_TO_NAME  =  wip_tab(indx).ESCALATED_TO_NAME,
                FORWARDED_BY_NAME  =  wip_tab(indx).FORWARDED_BY_NAME,
                FORWARDED_FLAG  =  wip_tab(indx).FORWARDED_FLAG,
                GROUP_NAME  =  wip_tab(indx).GROUP_NAME,
                GROUP_PARENT_NAME  =  wip_tab(indx).GROUP_PARENT_NAME,
                GROUP_SUPERVISOR_NAME  =  wip_tab(indx).GROUP_SUPERVISOR_NAME,
                JEOPARDY_FLAG  =  wip_tab(indx).JEOPARDY_FLAG,
                LAST_UPDATE_BY_NAME  =  wip_tab(indx).LAST_UPDATE_BY_NAME,
                LAST_UPDATE_DATE  =  wip_tab(indx).LAST_UPDATE_DATE,
                OWNER_NAME  =  wip_tab(indx).OWNER_NAME,
                SLA_DAYS  =  wip_tab(indx).SLA_DAYS,
                SLA_DAYS_TYPE  =  wip_tab(indx).SLA_DAYS_TYPE,
                SLA_JEOPARDY_DAYS  =  wip_tab(indx).SLA_JEOPARDY_DAYS,
                SLA_TARGET_DAYS  =  wip_tab(indx).SLA_TARGET_DAYS,
                SOURCE_REFERENCE_ID  =  wip_tab(indx).SOURCE_REFERENCE_ID,
                SOURCE_REFERENCE_TYPE  =  wip_tab(indx).SOURCE_REFERENCE_TYPE,
                STATUS_AGE_IN_BUS_DAYS  =  wip_tab(indx).STATUS_AGE_IN_BUS_DAYS,
                STATUS_AGE_IN_CAL_DAYS  =  wip_tab(indx).STATUS_AGE_IN_CAL_DAYS,
                STATUS_DATE  =  wip_tab(indx).STATUS_DATE,
                TASK_ID  =  wip_tab(indx).TASK_ID,
                TASK_STATUS  =  wip_tab(indx).TASK_STATUS,
                TASK_TYPE  =  wip_tab(indx).TASK_TYPE,
                TEAM_NAME  =  wip_tab(indx).TEAM_NAME,
                TEAM_PARENT_NAME  =  wip_tab(indx).TEAM_PARENT_NAME,
                TEAM_SUPERVISOR_NAME  =  wip_tab(indx).TEAM_SUPERVISOR_NAME,
                TIMELINESS_STATUS  =  wip_tab(indx).TIMELINESS_STATUS,
                UNIT_OF_WORK  =  wip_tab(indx).UNIT_OF_WORK,
                STG_EXTRACT_DATE  =  wip_tab(indx).STG_EXTRACT_DATE,
                STG_LAST_UPDATE_DATE  =  wip_tab(indx).STG_LAST_UPDATE_DATE,
                STAGE_DONE_DATE  =  wip_tab(indx).STAGE_DONE_DATE,
                DATE_TODAY  =  wip_tab(indx).DATE_TODAY,
                CASE_ID  =  wip_tab(indx).CASE_ID,
                CLIENT_ID  =  wip_tab(indx).CLIENT_ID,
                CANCEL_METHOD  =  wip_tab(indx).CANCEL_METHOD,
                CANCEL_REASON  =  wip_tab(indx).CANCEL_REASON,
                CANCEL_BY  =  wip_tab(indx).CANCEL_BY,
                TASK_PRIORITY  =  wip_tab(indx).TASK_PRIORITY,
                PARENT_TASK_ID  =  wip_tab(indx).PARENT_TASK_ID,
                CHANNEL  =  wip_tab(indx).CHANNEL,
                INSTANCE_STATUS  =  wip_tab(indx).INSTANCE_STATUS,
                INSTANCE_START_DATE  =  wip_tab(indx).INSTANCE_START_DATE,
                INSTANCE_END_DATE  =  wip_tab(indx).INSTANCE_END_DATE,
                RECEIVED_DATE  =  wip_tab(indx).RECEIVED_DATE,
                ASSIGNED_DATE  =  wip_tab(indx).ASSIGNED_DATE,
                ORIGINAL_CREATION_DATE  =  wip_tab(indx).ORIGINAL_CREATION_DATE,
                CASE_NUMBER  =  wip_tab(indx).CASE_NUMBER,
                ROLE_NAME  =  wip_tab(indx).ROLE_NAME,
                CLAIM_DATE =  wip_tab(indx).CLAIM_DATE,
                LAST_TASK =  wip_tab(indx).LAST_TASK,
                PREV_TASK_NAME =  wip_tab(indx).PREV_TASK_NAME,
                PREV_TASK_CREATE_DATE =  wip_tab(indx).PREV_TASK_CREATE_DATE,
                PERSON_ID = wip_tab(indx).PERSON_ID
          WHERE CEMW_ID  =  wip_tab(indx).CEMW_ID;

     EXCEPTION
        WHEN OTHERS THEN
          IF SQLCODE = -24381 THEN
            FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
              v_err_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE; --SQLCODE;
              v_err_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
              --v_err_msg := SUBSTR(SQLERRM, 1, 200);
              INSERT INTO corp_etl_error_log
              VALUES(SEQ_CEEL_ID.nextval,--CEEL_ID
                     sysdate,--ERR_DATE
                     'CRITICAL',--ERR_LEVEL
                     'MANAGE_WORK',--PROCESS_NAME
                     'MW_UPDATE_MAIN_TABLE',--JOB_NAME
                     '1',--NR_OF_ERROR
                     v_step, --||' '||v_err_msg,--ERROR_DESC
                     null,--ERROR_FIELD
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
  CLOSE wip_cur;
END MW_UPDATE_MAIN_TABLE;

PROCEDURE PROCESS_SQID_TASKS
AS

BEGIN

-- Insert new tasks

Insert into Corp_Etl_Manage_Work
           ( Create_Date
           , Created_By_Name
           , Last_Update_date
           , Owner_Name
           , Last_Update_By_Name
           , Source_Reference_ID
           , Source_Reference_Type
           , Status_Date
           , Task_ID
           , Task_Status
           , Task_Type
           , Case_Number
           , Channel
           , Instance_Status
           , Instance_Start_Date
           , Instance_End_Date
           , Received_Date
           , Complete_flag
           , Complete_Date
           , Task_Priority
           , Role_Name
           , Team_Name
           , Group_Name
           , asf_complete_work
           , original_creation_date
           , sla_days_type
           , sla_days
           , sla_jeopardy_days
           , sla_target_days
           , Claim_Date
           , Last_Task
           , Prev_Task_Name
           , Prev_Task_Create_Date
           , Person_Id
           , cancel_work_flag
           , cancel_work_date
           , cancel_reason
           , Cancel_By
           , asf_cancel_work
           , Forwarded_By_Name
           , Forwarded_Flag
           , Team_Supervisor_Name
           , Stage_Done_date)

  SELECT S.Create_date Create_date
           , Case When Crt.Username IS Null Then 'DATSI User'
                  When Upper(S.Created_By) in ('SYSTEM','BATCH','EXTERNAL SYSTEM') Then Upper(S.Created_By)
                  Else cadir_etl_manage_work_pkg.Get_Person_Name(Crt.User_Id) End Created_By_Name
           , S.Update_Date Last_Update_date
           , Case When S.owner_name IS Not Null Then cadir_etl_manage_work_pkg.Get_Person_Name(S.owner_name)
                  When S.End_Date Is Not Null And S.Task_Priority = 'case_creation_service' Then 'sqidcasecreator'
                  Else Null End as Owner_Name
           , Case When S.owner_name IS Not Null Then cadir_etl_manage_work_pkg.Get_Person_Name(S.owner_name)
                  When S.End_Date Is Not Null And S.Task_Priority = 'case_creation_service' Then 'sqidcasecreator'
                  When Crt.Username IS Null Then 'DATSI User'
                  When Upper(S.Created_By) in ('SYSTEM','BATCH','EXTERNAL SYSTEM') Then Upper(S.Created_By)
                  Else cadir_etl_manage_work_pkg.Get_Person_Name(Crt.User_Id) End Last_Update_By_Name
           , S.DCN Source_Reference_ID
           , 'DCN' Source_Reference_Type
           , Case --When S.End_Date IS Not Null Then S.End_Date
                  When S.Start_Date IS Not Null Then S.Start_Date
                  When S.Error_Date IS Not Null Then S.Error_Date
                  Else S.Create_Date
                   End Status_Date
           , S.Task_ID Task_ID
           , Case --When S.End_Date IS Not Null Then 'COMPLETED'
                  When S.Start_Date IS Not Null AND S.End_Date IS null Then 'CLAIMED'
                  When S.Error_Date IS Not Null AND S.Start_Date IS Null AND S.End_Date IS null Then 'UNCLAIMED'
                  Else 'UNASSIGNED'
                  End Task_Status
           , S.Task_Type Task_Type
           , S.Case_ID Case_Number
           , S.Channel Channel
           , 'Active' Instance_Status --Case When S.End_Date IS Null Then 'Active' Else 'Complete' End  Instance_Status
           , NVL(S.Start_Date, S.Create_Date) Instance_Start_Date
           , S.End_Date Instance_End_Date
           , S.Received_Date Received_Date
           , 'N' Complete_flag--Case When S.End_Date IS Not Null Then 'Y' ELSE 'N' END Complete_flag
           , NULL Complete_Date --, S.End_Date Complete_Date
           , 'Standard' as Task_Priority
           , S.EXECUTION_ID as Role_Name
           , Null Team_Name
           , NVL(S.Doc_Queue,'Doc_Sorting') Group_Name
           , 'N' Complete_flag --Case When S.End_Date IS Not Null Then 'Y' ELSE 'N' END asf_complete_work
           , S.Create_date original_creation_date
           , NVL(sla_days_type,'B') as sla_days_type
           , NVL(sla_days,'1') as sla_days
           , NVL(sla_jeopardy_days,'0') as sla_jeopardy_days
           , NVL(sla_target_days,'1') as sla_target_days
           , S.Start_Date as Claim_Date
           , 'N' Last_Task
           , PrevTask.Task_Type as Prev_Task_Name
           , PrevTask.Create_Date as Prev_Task_Create_Date
           , Case When S.Owner_Name is Not Null Then cadir_etl_manage_work_pkg.Get_Person_ID(S.Owner_Name)
                  When S.End_Date Is Not Null And S.Task_Priority = 'case_creation_service' Then 62290139
                  Else Null End Person_Id
           , 'N'  cancel_work_flag
           , Null cancel_work_date
           , Null cancel_reason
           , Null Cancel_By
           , 'N' asf_cancel_work
           , Case When S.Parent_Task_ID Is Not Null Then cadir_etl_manage_work_pkg.Get_Person_Name(PrevTask.owner_name)
                  Else Null End Forwarded_By_Name
           , Case When S.Parent_Task_ID Is Not Null Then 'Y' Else 'N' End Forwarded_Flag
           , Case When S.owner_name IS Not Null Then cadir_etl_manage_work_pkg.Get_Supervisor_Name(S.owner_name)
                  Else Null End as Team_Supervisor_Name
           , NULL Stage_Done_date --Case When S.End_Date IS Not Null Then Sysdate ELSE Null END Stage_Done_date
        FROM SQID_TASK_HIST_STG S
        LEFT OUTER JOIN CADIR_USER_STG Crt ON UPPER(UserName) = UPPER(S.Created_By)
        LEFT OUTER JOIN SQID_TASK_HIST_STG PrevTask ON S.Parent_Task_Id = PrevTask.Task_Id
        LEFT OUTER JOIN (select value, out_var as sla_days_type from corp_etl_list_lkup  where name = 'ManageWork_SLA_Days_Type') SLA_TYPE
                         on  SLA_TYPE.value =  S.Task_Type
        LEFT OUTER JOIN (select value, out_var as sla_days from corp_etl_list_lkup  where name = 'ManageWork_SLA_Days') SLA_DAYS
                         on  SLA_DAYS.value =  S.Task_Type
        LEFT OUTER JOIN (select value, out_var as sla_jeopardy_days from corp_etl_list_lkup  where name = 'ManageWork_SLA_Jeopardy_Days') SLA_JEOPARDY
                         on  SLA_JEOPARDY.value =  S.Task_Type
        LEFT OUTER JOIN (select value, out_var as sla_target_days from corp_etl_list_lkup  where name = 'ManageWork_SLA_Target_Days') SLA_TARGET
                         on  SLA_TARGET.value =  S.Task_Type

        WHERE S.In_Process = 'Y'
          AND NOT EXISTS ( Select 1 From Corp_Etl_Manage_Work C Where C.Task_id = S.Task_ID);

      -- Identify Changed records and apply updates to active instance

      FOR upd_rec in ( Select C.CEMW_ID, A.*
                         FROM (
                                SELECT S.Create_date Create_date
                                         , Case When Crt.Username IS Null Then 'DATSI User'
                                                When Upper(S.Created_By) in ('SYSTEM','BATCH','EXTERNAL SYSTEM') Then Upper(S.Created_By)
                                                Else cadir_etl_manage_work_pkg.Get_Person_Name(Crt.User_Id) End Created_By_Name
                                         , S.Update_Date Last_Update_date
                                         , Case When S.owner_name IS Not Null Then cadir_etl_manage_work_pkg.Get_Person_Name(S.owner_name)
                                                When S.End_Date Is Not Null And S.Task_Priority = 'case_creation_service' Then 'sqidcasecreator'
                                                Else Null End as Owner_Name
                                         , Case When S.owner_name IS Not Null Then cadir_etl_manage_work_pkg.Get_Person_Name(S.owner_name)
                                                When S.End_Date Is Not Null And S.Task_Priority = 'case_creation_service' Then 'sqidcasecreator'
                                                When Crt.Username IS Null Then 'DATSI User'
                                                When Upper(S.Created_By) in ('SYSTEM','BATCH','EXTERNAL SYSTEM') Then Upper(S.Created_By)
                                                Else cadir_etl_manage_work_pkg.Get_Person_Name(Crt.User_Id) End Last_Update_By_Name
                                         , S.DCN Source_Reference_ID
                                         , 'DCN' Source_Reference_Type
                                         , Case When S.End_Date IS Not Null Then S.End_Date
                                                When S.Start_Date IS Not Null Then S.Start_Date
                                                When S.Error_Date IS Not Null Then S.Error_Date
                                                Else S.Create_Date
                                                 End Status_Date
                                         , S.Task_ID Task_ID
                                         , Case When S.End_Date IS Not Null Then 'COMPLETED'
                                                When S.Start_Date IS Not Null AND S.End_Date IS null Then 'CLAIMED'
                                                When S.Error_Date IS Not Null AND S.Start_Date IS Null AND S.End_Date IS null Then 'UNCLAIMED'
                                                Else 'UNASSIGNED'
                                                End Task_Status
                                         , S.Task_Type Task_Type
                                         , S.Case_ID Case_Number
                                         , S.Channel Channel
                                         , Case When S.End_Date IS Null Then 'Active'
                                                Else 'Complete'
                                                End  Instance_Status
                                         , NVL(S.Start_Date, S.Create_Date) Instance_Start_Date
                                         , S.End_Date Instance_End_Date
                                         , S.Received_Date Received_Date
                                         , Case When S.End_Date IS Not Null Then 'Y' ELSE 'N' END Complete_flag
                                         , S.End_Date Complete_Date
                                         , 'Standard' as Task_Priority
                                         , S.EXECUTION_ID as Role_Name
                                         , Null Team_Name
                                         , NVL(S.Doc_Queue,'Doc_Sorting') Group_Name
                                         , Case When S.End_Date IS Not Null Then 'Y' ELSE 'N' END asf_complete_work
                                         , S.Create_date original_creation_date
                                         , NVL(sla_days_type,'B') as sla_days_type
                                         , NVL(sla_days,'1') as sla_days
                                         , NVL(sla_jeopardy_days,'0') as sla_jeopardy_days
                                         , NVL(sla_target_days,'1') as sla_target_days
                                         , S.Start_Date as Claim_Date
                                         , 'N' Last_Task
                                         , PrevTask.Task_Type as Prev_Task_Name
                                         , PrevTask.Create_Date as Prev_Task_Create_Date
                                         , Case When S.Owner_Name is Not Null Then cadir_etl_manage_work_pkg.Get_Person_ID(S.Owner_Name)
                                                When S.End_Date Is Not Null And S.Task_Priority = 'case_creation_service' Then 62290139
                                                Else Null End Person_Id
                                         , 'N'  cancel_work_flag
                                         , Null cancel_work_date
                                         , Null cancel_reason
                                         , Null Cancel_By
                                         , 'N' asf_cancel_work
                                         , Case When S.Parent_Task_ID Is Not Null Then cadir_etl_manage_work_pkg.Get_Person_Name(PrevTask.owner_name)
                                                Else Null End Forwarded_By_Name
                                         , Case When S.Parent_Task_ID Is Not Null Then 'Y' Else 'N' End Forwarded_Flag
                                         , Case When S.owner_name IS Not Null Then cadir_etl_manage_work_pkg.Get_Supervisor_Name(S.owner_name)
                                                Else Null End as Team_Supervisor_Name
                                         , Case When S.End_Date IS Not Null Then Sysdate ELSE Null END Stage_Done_date
                                      FROM SQID_TASK_HIST_STG S
                                      LEFT OUTER JOIN CADIR_USER_STG Crt ON UPPER(UserName) = UPPER(S.Created_By)
                                      LEFT OUTER JOIN SQID_TASK_HIST_STG PrevTask ON S.Parent_Task_Id = PrevTask.Task_Id
                                      LEFT OUTER JOIN (select value, out_var as sla_days_type from corp_etl_list_lkup  where name = 'ManageWork_SLA_Days_Type') SLA_TYPE
                                                       on  SLA_TYPE.value =  S.Task_Type
                                      LEFT OUTER JOIN (select value, out_var as sla_days from corp_etl_list_lkup  where name = 'ManageWork_SLA_Days') SLA_DAYS
                                                       on  SLA_DAYS.value =  S.Task_Type
                                      LEFT OUTER JOIN (select value, out_var as sla_jeopardy_days from corp_etl_list_lkup  where name = 'ManageWork_SLA_Jeopardy_Days') SLA_JEOPARDY
                                                       on  SLA_JEOPARDY.value =  S.Task_Type
                                      LEFT OUTER JOIN (select value, out_var as sla_target_days from corp_etl_list_lkup  where name = 'ManageWork_SLA_Target_Days') SLA_TARGET
                                                       on  SLA_TARGET.value =  S.Task_Type

                                      WHERE S.In_Process = 'Y'
                            ) A    , corp_etl_manage_work C
                     Where A.TASK_ID = C.TASK_ID
                       and ((C.cancel_work_flag !=  A.cancel_work_flag) OR
                            (C.complete_flag != A.complete_flag) OR
                            (C.asf_cancel_work != A.asf_cancel_work) OR
                            (C.asf_complete_work != A.asf_complete_work) OR
                            (NVL(C.cancel_reason,'QqQqQq') !=  NVL(A.cancel_reason,'QqQqQq')) OR
                            (NVL(C.cancel_by,'QqQqQq') !=   NVL(A.cancel_by,'QqQqQq')) OR
                            (NVL(C.task_priority,'QqQqQq') !=  NVL(A.task_priority,'QqQqQq')) OR
                            (NVL(C.role_name,'QqQqQq' ) !=      NVL(A.role_name, 'QqQqQq')) OR
                            (NVL(C.team_name,'QqQqQq' ) !=     NVL(A.team_name, 'QqQqQq')) OR
                            (NVL(C.group_name,'QqQqQq') !=     NVL(A.group_name,'QqQqQq')) OR
                            (NVL(C.created_by_name, 'QqQqQq' ) !=      NVL(A.created_by_name, 'QqQqQq' )) OR
                            (NVL(C.last_update_by_name, 'QqQqQq') !=   NVL(A.last_update_by_name, 'QqQqQq')) OR
                            (NVL(C.owner_name, 'QqQqQq') !=   NVL(A.owner_name, 'QqQqQq')) OR
                            (NVL(C.source_reference_type,'QqQqQq')  !=   NVL(A.source_reference_type, 'QqQqQq')) OR
                            (NVL(C.task_status,'QqQqQq') !=   NVL(A.task_status,'QqQqQq')) OR
                            (NVL(C.task_type, 'QqQqQq')  !=   NVL(A.task_type,'QqQqQq')) OR
                            (NVL(C.case_number,'QqQqQq')  !=   NVL(A.case_number,'QqQqQq')) OR
                            (NVL(C.channel, 'QqQqQq')   !=   NVL(A.channel,'QqQqQq')) OR
                            (NVL(C.instance_status, 'QqQqQq') !=  NVL(A.instance_status, 'QqQqQq')) OR
                            (NVL(C.instance_start_date,to_date('07/07/7777','mm/dd/yyyy'))  !=  NVL(A.instance_start_date,to_date('07/07/7777','mm/dd/yyyy'))) OR
                            (NVL(C.instance_end_date,to_date('07/07/7777','mm/dd/yyyy')) !=    NVL(A.instance_end_date,to_date('07/07/7777','mm/dd/yyyy'))) OR
                            (NVL(C.received_date,to_date('07/07/7777','mm/dd/yyyy')) !=        NVL(A.received_date,to_date('07/07/7777','mm/dd/yyyy'))) OR
                            (NVL(C.create_date, to_date('07/07/7777','mm/dd/yyyy') ) != NVL(A.create_date, to_date('07/07/7777','mm/dd/yyyy')))  OR
                            (NVL(C.last_update_date, to_date('07/07/7777','mm/dd/yyyy'))  !=    NVL(A.last_update_date, to_date('07/07/7777','mm/dd/yyyy'))) OR
                            (NVL(C.complete_date, to_date('07/07/7777','mm/dd/yyyy')) !=   NVL(A.complete_date,to_date('07/07/7777','mm/dd/yyyy'))) OR
                            (NVL(C.original_creation_date, to_date('07/07/7777','mm/dd/yyyy')) != NVL(A.original_creation_date, to_date('07/07/7777','mm/dd/yyyy'))) OR
                            (NVL(C.status_date, to_date('07/07/7777','mm/dd/yyyy')) !=   NVL(A.status_date,to_date('07/07/7777','mm/dd/yyyy'))) OR
                            (NVL(C.cancel_work_date,to_date('07/07/7777','mm/dd/yyyy')) != NVL(A.cancel_work_date,to_date('07/07/7777','mm/dd/yyyy'))) OR
                            (NVL(C.sla_days_type, 'QqQqQq') !=  NVL(A.sla_days_type, 'QqQqQq')) OR
                            (NVL(C.sla_days, -99.9191 ) !=  NVL(A.sla_days, -99.9191)) OR
                            (NVL(C.sla_jeopardy_days, -99.9191) !=  NVL(A.sla_jeopardy_days, -99.9191)) OR
                            (NVL(C.sla_target_days, -99.9191  ) !=  NVL(A.sla_target_days,  -99.9191)) OR
                            (NVL(C.source_reference_id, -99.9191) !=    NVL(A.source_reference_id, -99.9191)) OR
                            (NVL(C.Claim_Date, to_date('07/07/7777','mm/dd/yyyy')) !=   NVL(A.Claim_Date,to_date('07/07/7777','mm/dd/yyyy'))) OR
                            (NVL(C.Last_Task, 'QqQqQq')  !=   NVL(A.Last_Task,'QqQqQq')) OR
                            (NVL(C.Prev_Task_Name, 'QqQqQq')  !=   NVL(A.Prev_Task_Name,'QqQqQq')) OR
                            (NVL(C.Prev_Task_Create_Date, to_date('07/07/7777','mm/dd/yyyy')) != NVL(A.Prev_Task_Create_Date,to_date('07/07/7777','mm/dd/yyyy'))) OR
                            (NVL(C.Person_Id, -99.9191)  !=   NVL(A.Person_Id,-99.9191)) OR
                            (NVL(C.Forwarded_By_Name, 'QqQqQq')  !=   NVL(A.Forwarded_By_Name,'QqQqQq')) OR
                            (NVL(C.Team_Supervisor_Name, 'QqQqQq')  != NVL(A.Team_Supervisor_Name,'QqQqQq')) OR
                            (NVL(C.Forwarded_Flag, 'QqQqQq')  !=   NVL(A.Forwarded_Flag,'QqQqQq')) )
                     )
    LOOP

       Update Corp_etl_manage_work mw
          Set mw.create_date = upd_rec.create_date,
              mw.created_by_name = upd_rec.created_by_name,
              mw.last_update_by_name = upd_rec.last_update_by_name,
              mw.last_update_date = upd_rec.last_update_date,
              mw.owner_name = upd_rec.owner_name,
              mw.source_reference_id = upd_rec.source_reference_id,
              mw.source_reference_type = upd_rec.source_reference_type,
              mw.status_date = upd_rec.status_date,
              mw.task_id = upd_rec.task_id,
              mw.task_status = upd_rec.task_status,
              mw.task_type = NVL(mw.task_type,upd_rec.task_type),
              mw.case_number = upd_rec.case_number,
              mw.channel = upd_rec.channel,
              mw.instance_status = upd_rec.instance_status,
              mw.instance_start_date = upd_rec.instance_start_date,
              mw.instance_end_date = upd_rec.instance_end_date,
              mw.received_date = upd_rec.received_date,
              mw.cancel_work_flag = upd_rec.cancel_work_flag,
              mw.cancel_work_date = upd_rec.cancel_work_date,
              mw.cancel_reason = upd_rec.cancel_reason,
              mw.cancel_by = upd_rec.cancel_by,
              mw.complete_flag = upd_rec.complete_flag,
              mw.complete_date = upd_rec.complete_date,
              mw.task_priority = upd_rec.task_priority,
              mw.role_name = upd_rec.role_name,
              mw.team_name = upd_rec.team_name,
              mw.group_name = upd_rec.group_name,
              mw.asf_cancel_work = upd_rec.asf_cancel_work,
              mw.asf_complete_work = upd_rec.asf_complete_work,
              mw.original_creation_date          = upd_rec.original_creation_date,
              mw.sla_days_type = upd_rec.sla_days_type,
              mw.sla_days = upd_rec.sla_days,
              mw.sla_jeopardy_days = upd_rec.sla_jeopardy_days,
              mw.sla_target_days = upd_rec.sla_target_days,
              mw.Claim_Date = upd_rec.Claim_Date,
              mw.Last_Task = upd_rec.Last_Task,
              mw.Prev_Task_Name = upd_rec.Prev_Task_Name,
              mw.Prev_Task_Create_Date = upd_rec.Prev_Task_Create_Date,
              mw.Person_Id = upd_rec.Person_Id,
              mw.Forwarded_By_Name = upd_rec.Forwarded_By_Name,
              mw.Forwarded_Flag = upd_rec.Forwarded_Flag,
              mw.Team_Supervisor_Name = upd_rec.Team_Supervisor_Name,              
              mw.Stage_Done_date = upd_rec.Stage_Done_date
        where mw.cemw_id = upd_rec.cemw_id;

    END LOOP;

      Update SQID_TASK_HIST_STG S
         Set In_Process = 'N'
       Where In_Process = 'Y'
         and exists ( Select 1 From Corp_Etl_Manage_Work C
                       Where C.Task_id = S.Task_ID
                         and S.End_Date IS Not Null
                         and C.Complete_Date IS Not Null );

      COMMIT;


END PROCESS_SQID_TASKS;

PROCEDURE PROCESS_DELTEK_LOAD
AS
  v_hours_date date;
  v_errmsg varchar2(100);
  v_errcd varchar2(10);
  v_id_exists number;
  v_sup_updated varchar2(1);
  v_date_format varchar2(20);

BEGIN

  -- Get default date format
  select value into v_date_format from corp_etl_control where name = 'DELTEK_DATE_FORMAT';

  -- Update all stage records, if employee id is less than 4 characters then prefix '0'

  Update d_deltek_hours_tmp t
     set employee_id = '0'||employee_id
   where processed = 'N'
     and length(employee_id) = 4;

  -- Update records from previously loaded files for that date

  Update d_deltek_hours
     set entered_hours = 0, productive_hours = 0
        ,Notes = nvl(notes,'')||'Record updated by load process, hours changed from '||entered_hours||' to 0.'
   where sup_updated = 'N'
     and ddh_id in (Select distinct d.ddh_id
                      from d_deltek_hours_tmp t , d_deltek_hours d
                     where d.employee_id = t.employee_id
                       and d.hours_date =  to_date(t.hours_date, v_date_format)
                       and t.processed = 'N'
                       and trunc(d.maxdat_audit_create_dt) <> trunc(t.create_dt));

   Commit;


  -- Process staged records

  For stg in ( select *
                 from d_deltek_hours_tmp t
                where processed = 'N'
                order by tmp_ddh_id )
  Loop

     -- Begin check Header record
     If RTRIM(stg.employee_id,'0123456789') is not null Then -- Alphanumeric

         update d_deltek_hours_tmp
            set comments = nvl(comments,'')||'Header records'
              , processed = 'E'
          where tmp_ddh_id = stg.tmp_ddh_id;

     Else -- Load Data

         v_hours_date := null;
         v_id_exists := 0;
         v_sup_updated := 'N';

         Begin
           -- Agreed date format
           select to_date(stg.hours_date, v_date_format)
             into v_hours_date
             from dual;

         Exception when others then
              --
              Begin
               -- Just to handle one particular error situation due to date format mismatch.
               select to_date(stg.hours_date, 'Mon dd, yyyy')
                 into v_hours_date
                 from dual;

            Exception when others then

                  v_errmsg := substr(sqlerrm, 1, 100);
                  v_errcd := sqlcode;

                  update d_deltek_hours_tmp
                     set comments = v_errcd || '-' ||v_errmsg
                       , processed = 'E'
                   where tmp_ddh_id = stg.tmp_ddh_id;
              End;
              --
         End;

         -- Check if Pay type exists
         If stg.pay_type is null then

             update d_deltek_hours_tmp
                set comments = nvl(comments,'')||'Pay Type is missing in the record'
                  , processed = 'E'
              where tmp_ddh_id = stg.tmp_ddh_id;

         Elsif v_hours_date is not null then

           Begin

             -- Check if record already exists

             Select ddh_id , sup_updated into v_id_exists, v_sup_updated
               from d_deltek_hours d
              where d.employee_id = stg.employee_id
                and d.hours_date = v_hours_date
                and nvl(d.project_id,'*') = nvl(stg.project_id,'*')
                and d.pay_type = stg.pay_type;

              -- If not updated by supervisor then update record in d_deltek_hours
              If v_sup_updated = 'N' Then

                 Update d_deltek_hours
                    set employee_id            = stg.employee_id,
                        labor_grp_type         = stg.labor_grp_type,
                        last_name              = stg.last_name,
                        first_name             = stg.first_name,
                        title                  = stg.title,
                        empl_org_id            = stg.empl_org_id,
                        empl_org_name          = stg.empl_org_name,
                        approval_name          = stg.approval_name,
                        project_id             = stg.project_id,
                        project_name           = stg.project_name,
                        org_id                 = stg.org_id,
                        org_name               = stg.org_name,
                        pay_type               = stg.pay_type,
                        plc_id                 = stg.plc_id,
                        hours_date             = v_hours_date,
                        entered_hours          = stg.entered_hours,
                        productive_hours       = stg.productive_hours,
                        notes                  = nvl(notes,'')||'Record updated by load process - '||stg.tmp_ddh_id
                  where ddh_id = v_id_exists;

              Else

                 update d_deltek_hours_tmp
                    set comments = nvl(comments,'')||'Record had been updated by supervisor'
                      , processed = 'E'
                  where tmp_ddh_id = stg.tmp_ddh_id;

              End if;

           Exception when no_data_found then

             -- If new record then insert

              Insert into d_deltek_hours ( employee_id,  labor_grp_type,  last_name, first_name, title, empl_org_id, empl_org_name,
                                         approval_name, project_id,  project_name, org_id, org_name, pay_type, plc_id, hours_date,
                                         entered_hours, productive_hours, comments, notes)
              values  ( stg.employee_id, stg.labor_grp_type,  stg.last_name, stg.first_name, stg.title, stg.empl_org_id, stg.empl_org_name,
                        stg.approval_name,stg.project_id,  stg.project_name, stg.org_id, stg.org_name, stg.pay_type, stg.plc_id,v_hours_date,
                        stg.entered_hours,stg.productive_hours, stg.comments, stg.notes);

           End;

           Update d_deltek_hours_tmp set processed = 'Y'
            where tmp_ddh_id = stg.tmp_ddh_id
              and processed <> 'E';

         End if; -- Check Pay Type

     End if; -- Check Header Record

     Commit;

  End Loop;

END PROCESS_DELTEK_LOAD;


PROCEDURE FIX_RUN_AWAY_TASKS
AS
   v_log_message varchar2(250);
   v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'FIX_RUN_AWAY_TASKS';
BEGIN

   -- Run fix tasks script only if it wasnt run for that date

   For run_loop in ( Select 'x' Run_Fix_Tasks from Corp_Etl_Control
                      Where Name = 'FIX_RUN_AWAY_TASKS_CORRECTION_DATE'
                        And to_date(value,'mm/dd/yyyy') != trunc(sysdate) )
   Loop

       -- Identify records where Assignment_From is duplicate

        For I In ( Select c_assignment_from , Tracking_id
                    From cadir_maxdat_stg
                   Where tracking_id not in (Select tracking_id
                                               From cadir_maxdat_stg
                                              Group by tracking_id, c_assignment_to
                                             Having count(1) > 1  )
                   Group by tracking_id, c_assignment_from
                  Having count(1) > 1 )
        Loop

             For Fix_Rec in ( Select  Tracking_id, Assignment_Id, c_assignment_from, c_assignment_to,Prev_Assignment_ID, c_created_on, id
                                From
                                    (Select Tracking_id, Assignment_Id, c_assignment_from, c_assignment_to
                                           , LAG(C_assignment_to, 1, 0) OVER (PARTITION BY tracking_id ORDER BY id NULLS LAST) Prev_Assignment_ID
                                           , c_created_on, id
                                      From cadir_maxdat_stg
                                     Where c_assignment_from = I.C_ASSIGNMENT_FROM  ) a
                               Where a.prev_assignment_id <> 0
                               Order by a.c_created_on, a.id
                              )

             Loop

                 Update cadir_maxdat_stg
                    Set c_assignment_from = Fix_rec.Prev_Assignment_ID
                      , mw_processed = 'N'
                  Where id = Fix_Rec.id ;

                 v_log_message := 'TrackingID:'||Fix_Rec.Tracking_id||','||'Assignment_From:'||Fix_Rec.c_assignment_from||','||'Changed to:'||Fix_Rec.Prev_Assignment_ID;

                 BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,1,null,Fix_Rec.id,null,v_log_message,null);

             End loop;

        End loop;

        Commit;

        -- Identify records where Assignment_From link is broken, leaving multiple tasks open for given tracking id

        For I In ( Select Source_reference_id Tracking_id, task_id
                     From corp_etl_manage_work a
                    Where Source_Reference_Type='TRACKING_ID'
                      And Complete_Date is null
                      And Exists ( Select 1 from corp_etl_manage_Work a2
                                    Where a.Source_Reference_ID = a2.Source_Reference_ID
                                      And a.Task_ID < a2.Task_ID
                                      And Source_Reference_Type='TRACKING_ID')
                       )
        Loop

             -- Most of the cases are fixed with this logic

             For Fix_Rec in ( Select  Tracking_id, Assignment_Id, c_assignment_from, c_assignment_to, Next_ID, c_created_on, id
                                      ,old_Assignment_from
                                From
                                      (Select Tracking_id, Assignment_Id, c_assignment_from, c_assignment_to
                                            , LAG(ID, 1, 0) OVER  (PARTITION BY tracking_id ORDER BY id NULLS LAST) Prev_ID
                                            , LEAD(ID, 1, 0) OVER (PARTITION BY tracking_id ORDER BY id NULLS LAST) Next_ID
                                            , LEAD(C_assignment_from, 1, 0) OVER (PARTITION BY tracking_id ORDER BY id NULLS LAST) old_Assignment_from
                                            , c_created_on, id
                                        From cadir_maxdat_stg
                                       Where tracking_id  = I.Tracking_Id  ) a
                               Where a.assignment_id <> old_assignment_from
                                 And old_assignment_from <> 0
                               Order by a.c_created_on, a.id
                              )

             Loop

                 Update cadir_maxdat_stg
                    Set c_assignment_from = Fix_Rec.Assignment_Id
                      , mw_processed = 'N'
                  Where id = Fix_Rec.Next_Id ;

                  v_log_message := 'TrackingID:'||Fix_Rec.Tracking_id||','||'Assignment_From:'||Fix_Rec.old_assignment_from||','||'Changed to:'||Fix_Rec.Assignment_Id ||','||' For ID :'||Fix_Rec.Next_Id;

                  BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,1,null,Fix_Rec.Next_Id,null,v_log_message,null);

              End loop;

         End loop;

         Update corp_etl_control set value = to_char(sysdate,'mm/dd/yyyy')
          Where name = 'FIX_RUN_AWAY_TASKS_CORRECTION_DATE';

     Commit;

   End Loop;

   -- Calc pharma Flag

    For I in (select count(1) cnt, sysdate StartTime from CORP_ETL_JOB_STATISTICS c 
               where job_Start_date > trunc(sysdate)
                 and Job_name = 'ManageWork_RUNALL' )
    Loop  

        If I.cnt IN (1,2)  Then --  1 AM and 4 AM run only 

            -- Reset Closed flag to reprocess decision mailed date updates
            
            Update s_crs_imr  set imr_closed_dt_flg = 'Y'
             where IMR_Closed_dt_flg = 'N' and
                   IMR_ID in ( select distinct imr_id 
                                 from s_crs_imr_decisions 
                                where decision_date >= sysdate - 10
                                  and Decision_letter_mailed_dt is null);            
          
            -- Reset the flag before evaluation 

            Update s_crs_imr_decisions Set Pharma = 'N'
            where Pharma = 'Y' 
              and IMR_ID in ( select distinct id_base id_base from s_crs_imr_audit_stage
                               union
                              select distinct imr_id id_base from s_crs_imr where imr_closed_dt_flg = 'Y' ) ;

            Commit;
                              
            -- Re-Calc Pharma flag for all newly processed issue disputes 
                              
            Update s_crs_imr_decisions d Set Pharma = 'Y'                   
            where IMR_ID in ( select distinct id_base id_base from s_crs_imr_audit_stage
                               union
                              select distinct imr_id id_base from s_crs_imr where imr_closed_dt_flg = 'Y' )
             and exists (select 1 
                               from s_crs_imr_issues_in_dispute IID, 
                                    d_crs_Issue_types IT
                             where IT.Issue_Type_ID=IID.Issue_Type_ID 
                               and IID.IMR_ID= d.imr_id 
                               and IT.Issue_Type_Name='Pharmaceuticals' 
                               and IID.issue_eligible_flag=1) 
             and not exists (select 1 
                               from s_crs_imr_issues_in_dispute IID, 
                                    d_crs_Issue_types IT
                             where IT.Issue_Type_ID=IID.Issue_Type_ID 
                               and IID.IMR_ID=d.imr_id 
                               and IT.Issue_Type_Name<>'Pharmaceuticals' 
                               and IID.issue_eligible_flag=1) ;                  
                               
             INSERT INTO cadir_managework_logging VALUES (I.StartTime, SYSDATE, 'CALC_PHARMA_FLAG');                           
                              
            Commit;
            
            IF I.cnt = 2  Then -- 4 AM run 
                -- Clean up columns of linefeed and carriage return
                begin

                    update s_crs_imr 
                       set imr_treatment_req = TRIM( replace( replace(imr_treatment_req,chr(13)||chr(10),' ') , chr(10),' ') )
                     Where regexp_count(imr_treatment_req,chr(10)) >= 1 ;

                    update s_crs_imr_issues_in_dispute_clb 
                       set issue_desc = TRIM( replace( replace(issue_desc,chr(13)||chr(10),' ') , chr(10),' ') )
                     where regexp_count(issue_desc,chr(10)) >= 1;

                    update s_crs_imr_issues_in_dispute_clb 
                       set odg_citation = TRIM( replace( replace(odg_citation,chr(13)||chr(10),' ') , chr(10),' ') )
                     where regexp_count(odg_citation,chr(10)) >= 1;

                    update s_crs_imr_issues_in_dispute_clb 
                       set mfs_citation = TRIM( replace( replace(mfs_citation,chr(13)||chr(10),' ') , chr(10),' ') )
                     where regexp_count(mfs_citation,chr(10)) >= 1 ;

                    update s_crs_imr_issues_in_dispute_clb 
                       set ca_non_mtus_citation = TRIM( replace( replace(ca_non_mtus_citation,chr(13)||chr(10),' ') , chr(10),' ') )
                     where regexp_count(ca_non_mtus_citation,chr(10)) >= 1;
                   
                   commit;
				  
				   -- Once a day identify Redacted cases to be sent to DWC_RED_MAX_RECS
				   SET_REDACTED_CASES;

                  end;            
            
            End if;
            
         End if;   
    End Loop;


  END FIX_RUN_AWAY_TASKS;
  
  PROCEDURE SET_REDACTED_CASES
	AS
	   v_cntr number := 0;
	   v_limit number;
	BEGIN

		  Insert into S_CRS_IMR_REDACTED (IMR_ID, RED_DWC_SENT)
		  select DISTINCT SOURCE_REFERENCE_ID IMR_ID , 'N' RED_DWC_SENT
			From corp_Etl_manage_Work C
		   where TASK_TYPE = 'Redacted FDL Generation Queue'
			 and COMPLETE_FLAG = 'Y'
			 and NOT exists ( Select 1 from S_CRS_IMR_REDACTED R where R.IMR_ID = C.Source_reference_id )
			 and exists ( Select 1 from S_CRS_IMR_DECISIONS D where D.IMR_ID = C.Source_reference_id  and decision_closed_reason_id = 53269595);

		  Select Value - ( Select count(1) from S_CRS_IMR_REDACTED Where RED_DWC_SENT = 'N')
		    Into v_limit
			from Corp_Etl_Control
		   where Name = 'DWC_RED_MAX_RECS';

			For I in (  select IMR_ID from S_CRS_IMR_REDACTED where red_dwc_sent = 'P' order by IMR_ID DESC)
			Loop
				
			  v_cntr := v_cntr + 1;
					
			  Update S_CRS_IMR_REDACTED  Set red_dwc_sent = 'N' , red_dwc_sent_date = NULL
			   Where red_dwc_sent = 'P'
				 and imr_id = I.imr_id;

				  If v_cntr >= v_limit then
					  exit;
				 End if;
         
			End Loop;

			Commit;

	END SET_REDACTED_CASES;


END cadir_etl_manage_work_pkg;

/

alter session set plsql_code_type = interpreted;

