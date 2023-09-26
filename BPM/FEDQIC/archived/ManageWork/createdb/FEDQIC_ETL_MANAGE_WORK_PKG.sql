--------------------------------------------------------
--  DDL for Package FEDQIC_ETL_MANAGE_WORK_PKG
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "FEDQIC_ETL_MANAGE_WORK_PKG" IS
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
|| CHill    06/27/2017  Adapted / Modified for FEDQIC project
*/

-- Do not edit these four SVN_* variable values.  They are populated when you commit code
--    to SVN and used later to identify deployed code.
   SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/FEDQIC/archived/ManageWork/createdb/FEDQIC_ETL_MANAGE_WORK_PKG.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 21593 $';
   SVN_REVISION_DATE varchar2(60) := '$Date: 2017-10-26 13:10:01 -0400 (Thu, 26 Oct 2017) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: ch136904 $';

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

   PROCEDURE FIX_RUN_AWAY_TASKS;


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

END fedqic_etl_manage_work_pkg;
/

create or replace PACKAGE BODY                      fedqic_etl_manage_work_pkg IS
   g_Error   VARCHAR2(4000);
   g_Limit   NUMBER;
   gPKG VARCHAR2(30) := 'FEDQIC_ETL_MANAGE_WORK_PKG';

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
           From fedqic_user_stg U
           Left Outer Join fedqic_person_stg P ON U.person_id = P.person_id
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
           From fedqic_user_stg U
           Left Outer Join fedqic_person_stg P ON U.person_id = P.person_id
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
           From fedqic_role_stg R
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
           From fedqic_user_stg U
           Inner Join d_supervisor S on U.person_id = S.person_id
           Inner Join fedqic_person_stg p on S.supervisor_person_id = P.person_ID
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

   -- Update fedqic maxdat stg

   SELECT role_id
     INTO v_role_id
     FROM fedqic_role_stg
    WHERE name = 'Closed Cases Queue';

   UPDATE fedqic_maxdat_stg
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
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('INIT', 'FEDQIC MW', g_Error);
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
         , fedqic_etl_manage_work_pkg.Get_Person_Name(MS.c_created_by)
         , RS.name
         , fedqic_etl_manage_work_pkg.Get_Person_Name(MS.c_created_by)
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
      FROM  fedqic_maxdat_stg          MS
      INNER JOIN fedqic_role_stg       RS  ON RS.role_id = MS.role_id
      LEFT OUTER JOIN fedqic_claim_type_stg TS  ON TS.id = MS.c_claim_type0
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
        FROM corp_etl_manage_work T , fedqic_maxdat_stg ms
       WHERE task_id = ms.assignment_id
         AND mw_processed = 'N';

   COMMIT;

   -- Gather stats on temp table
   Maxdat_Statistics.TABLE_STATS('CORP_ETL_MANAGE_WORK_TMP');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Ins_1', 'fedqic MW', g_Error);
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
                     ,  fedqic_maxdat_stg     MS
                  WHERE MW.task_id = MS.c_assignment_from
                    AND MW.task_status = 'UNCLAIMED'
                    AND MS.subject_type = 1
                    AND MS.data_object_key = 'T_IMR'
                    AND NOT EXISTS (SELECT 1 FROM fedqic_maxdat_stg XS WHERE XS.c_assignment_from = MS.c_assignment_to)
                  ORDER BY MW.Source_reference_id, mw.task_id
                 )
   LOOP
      BEGIN

         -- Cycrow = Parent 2   v_Stage = Child 1
         v_Name := fedqic_etl_manage_work_pkg.Get_Person_Name(CycRow.subject_id);
         v_RoleName := fedqic_etl_manage_work_pkg.Get_Role_Name(CycRow.Role_id);

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
                   VALUES ('Upd2_10','FEDQIC MW', 'TOO MANY ROWS RETURNED', CycRow.task_id);
      END;

   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Upd2_10', 'FEDQIC MW', g_Error);
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
                     ,  fedqic_maxdat_stg      MS
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
         v_Name := fedqic_etl_manage_work_pkg.Get_Person_Name(CycRow.c_created_by);

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
                   VALUES ('Upd3_10B','FEDQIC MW', 'TOO MANY ROWS RETURNED', CycRow.task_id);
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
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Upd3_10A', 'FEDQIC MW', g_Error);
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
                     ,  fedqic_maxdat_stg      OS
                     ,  fedqic_maxdat_stg      MS
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
         v_Name := fedqic_etl_manage_work_pkg.Get_Person_Name(CycRow.c_created_by);
         v_RoleName := fedqic_etl_manage_work_pkg.Get_Role_Name(CycRow.c_role_id);

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
                   VALUES ('Upd3_10B','FEDQIC MW', 'TOO MANY ROWS RETURNED', CycRow.task_id);
      END;  -- Loop Proc Block

   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Upd3_10B', 'FEDQIC MW', g_Error);
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
      FROM fedqic_maxdat_stg MS
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
                     ,  fedqic_maxdat_stg      OS
                     ,  fedqic_maxdat_stg      MS
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

         v_RoleName := fedqic_etl_manage_work_pkg.Get_Role_Name(CycRow.c_role_id);

         r_branch.assignment_id := Null;
         OPEN c_Branch(CycRow.c_task_id);
         FETCH  c_Branch INTO r_Branch;
         CLOSE c_Branch;

         -- CycRow = Parent 2, r_Branch = Child 2
         IF r_Branch.assignment_id IS NOT NULL THEN

            v_Name := fedqic_etl_manage_work_pkg.Get_Person_Name(r_Branch.c_created_by);
            v_forwarded_by_name := fedqic_etl_manage_work_pkg.Get_Person_Name(CycRow.c_subject_id);

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

            v_Name := fedqic_etl_manage_work_pkg.Get_Person_Name(CycRow.c_subject_id);

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
                   VALUES ('Upd3_10C','FEDQIC MW', 'TOO MANY ROWS RETURNED', CycRow.task_id);
      END;

   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Upd3_10C', 'FEDQIC MW', g_Error);
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
      INSERT INTO corp_etl_error_log (process_name,job_name,error_desc) VALUES ('Upd6_10','FEDQIC MW', g_Error);
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
      FROM fedqic_maxdat_stg
      WHERE subject_type = 2
      START WITH assignment_id = cp_Start_Id
      CONNECT BY PRIOR c_assignment_to = c_assignment_from;

   CURSOR cOrigCreate is
       SELECT source_reference_id refid,
              (Select MIN(Assignment_date) from fedqic_maxdat_stg where tracking_id = Source_reference_id) cdate
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
INSERT INTO fedqic_managework_logging VALUES (SYSDATE, SYSDATE, 'Starting '||v_step);
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
INSERT INTO fedqic_managework_logging VALUES (SYSDATE, SYSDATE, 'ParentID');
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
INSERT INTO fedqic_managework_logging VALUES (SYSDATE, SYSDATE, 'Owner');
commit;
-------------------
   FOR r_Row IN (SELECT W.* , M.Subject_Type, M.Subject_ID, M.c_Created_By
                   FROM corp_etl_manage_work W
                  INNER JOIN fedqic_maxdat_stg M ON M.c_assignment_from = W.task_id
                  WHERE W.owner_name IS NULL
                    AND W.Stage_done_date IS NULL
                )
   LOOP

     -- If child =  1 then use subject id
     IF r_Row.Subject_Type = 1 THEN
        v_PersonID := fedqic_etl_manage_work_pkg.Get_Person_ID(r_Row.Subject_ID);
        v_Name := fedqic_etl_manage_work_pkg.Get_Person_Name(r_Row.Subject_ID);
        v_Sup_Name := fedqic_etl_manage_work_pkg.Get_Supervisor_Name(r_Row.Subject_ID);
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


INSERT INTO fedqic_managework_logging VALUES (SYSDATE, SYSDATE, 'LastTask');
commit;
-------------------
   FOR r_Row IN (SELECT cemw_id, task_id
                   FROM corp_etl_manage_work W
                  WHERE W.Last_Task = 'N'
                    AND W.Stage_done_date IS NULL
                    AND EXISTS ( select 1 from fedqic_maxdat_stg M , fedqic_role_stg R
                                 where m.role_id = r.role_id
                                   and r.name = 'Closed Cases Queue'
                                   and m.assignment_id = ( SELECT Min(assignment_id)
                                                             FROM fedqic_maxdat_stg MS
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
INSERT INTO fedqic_managework_logging VALUES (SYSDATE, SYSDATE, 'Prev Task Name');
commit;
-------------------
   FOR r_Row IN (SELECT a.task_id, a.parent_task_id, a.cemw_id
                      , r.name Queue_From, b.assignment_date Prev_task_Create_Dt
                   FROM corp_etl_manage_work a
                   JOIN fedqic_maxdat_stg b on a.parent_task_id  = b.assignment_id
                   JOIN fedqic_role_stg r on b.role_id = r.role_id
                  WHERE a.Prev_Task_Name IS NULL
                    AND a.Stage_done_date IS NULL
                  UNION
		 SELECT a.task_id, a.parent_task_id, a.cemw_id
                      , r.name Queue_From, b.assignment_date Prev_task_Create_Dt
                   FROM corp_etl_manage_work_tmp a
                   JOIN fedqic_maxdat_stg b on a.parent_task_id  = b.assignment_id
                   JOIN fedqic_role_stg r on b.role_id = r.role_id
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

INSERT INTO fedqic_managework_logging VALUES (SYSDATE, SYSDATE, 'MW_UPDATE_MAIN_TABLE');
commit;

MW_UPDATE_MAIN_TABLE;

INSERT INTO fedqic_managework_logging VALUES (SYSDATE, SYSDATE, 'FIX_RUN_AWAY_TASKS');
commit;

FIX_RUN_AWAY_TASKS;

INSERT INTO fedqic_managework_logging VALUES (SYSDATE, SYSDATE, 'upd_CNTRL_TAB');
commit;

  UPDATE corp_etl_control
     SET VALUE = (SELECT to_char(NVL(MAX(task_id),0)) FROM corp_etl_manage_work)
     WHERE NAME = 'MW_MAX_PROCESSED_ID';

  UPDATE fedqic_maxdat_stg
     SET MW_Processed = 'Y'
   WHERE MW_processed = 'N'
     AND assignment_id in (select task_id from corp_etl_manage_work_tmp where updated = 'Y');

 COMMIT;


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

PROCEDURE FIX_RUN_AWAY_TASKS
AS
   v_log_message varchar2(250);
   v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'FIX_RUN_AWAY_TASKS';
BEGIN

   -- Identify records where Assignment_From is duplicate

    For I In ( Select c_assignment_from , Tracking_id
                From fedqic_maxdat_stg
               Where tracking_id not in (Select tracking_id
                                           From fedqic_maxdat_stg
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
                                  From fedqic_maxdat_stg
                                 Where c_assignment_from = I.C_ASSIGNMENT_FROM  ) a
                           Where a.prev_assignment_id <> 0
                           Order by a.c_created_on, a.id
                          )

         Loop

             Update fedqic_maxdat_stg
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
                                    From fedqic_maxdat_stg
                                   Where tracking_id  = I.Tracking_Id  ) a
                           Where a.assignment_id <> old_assignment_from
                             And old_assignment_from <> 0
                           Order by a.c_created_on, a.id
                          )

         Loop

             Update fedqic_maxdat_stg
                Set c_assignment_from = Fix_Rec.Assignment_Id
                  , mw_processed = 'N'
              Where id = Fix_Rec.Next_Id ;

              v_log_message := 'TrackingID:'||Fix_Rec.Tracking_id||','||'Assignment_From:'||Fix_Rec.old_assignment_from||','||'Changed to:'||Fix_Rec.Assignment_Id ||','||' For ID :'||Fix_Rec.Next_Id;

              BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_INFO,null,v_procedure_name,1,null,Fix_Rec.Next_Id,null,v_log_message,null);

          End loop;

     End loop;

     Commit;



  END FIX_RUN_AWAY_TASKS;


END fedqic_etl_manage_work_pkg;
/