alter session set plsql_code_type = native;

CREATE OR REPLACE PACKAGE fedqic_etl_manage_work_pkg IS
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
|| FMullah  08/07/2014  Modified Ins_1 proc to include outer join when connecting fedqic_claim_type_stg table.
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
|| EBurke   08/08/2018  Modified for FEDqIC 
*/

-- Do not edit these four SVN_* variable values.  They are populated when you commit code
--    to SVN and used later to identify deployed code.
   SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/FEDQIC/ManageWork/createdb/fedqic_etl_manage_work_pkg.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 23262 $';
   SVN_REVISION_DATE varchar2(60) := '$Date: 2018-05-10 17:55:01 -0400 (Thu, 10 May 2018) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: fm18957 $';

/*
||  Procedures
*/
   PROCEDURE InitProcess;   --<< Resets from last run

   PROCEDURE Insert_Update;         --<< Inserts new records into corp_etl_mw and updates records in corp_etl_mw_wip

   PROCEDURE MW_UPDATE_MAIN_TABLE;   --<< updates corp_etl_mw from corp_etl_mw_wip records	

/*
|| Functions
*/

   FUNCTION Get_Person_ID
            (p_user_id in number)
     RETURN number parallel_enable;

   FUNCTION Get_Task_Team_ID
         (p_owner_id in number)
   RETURN Number parallel_enable;

   FUNCTION Get_Role_Name
         (p_role_id in number)
     RETURN varchar2 parallel_enable;

FUNCTION Get_MW_Parent_Task_ID
         (p_mw_task_id in number)
	RETURN Number parallel_enable;

FUNCTION Get_MW_Parent_Task_Type_ID
         (p_mw_task_id in number)
	RETURN Number parallel_enable;

FUNCTION Get_MW_NON_STANDARD_WORK_FLAG
         (p_mw_appeal_part_id in number,
	  p_mw_task_type_id in number,
	  p_mw_previous_task_type_id in number)
RETURN varchar2 parallel_enable;


FUNCTION Get_MW_Task_ID
         (p_parent_id in number, p_appeal_id number, p_status number, p_owner number)
     RETURN number parallel_enable;

FUNCTION Get_MW_Task_Owner
         (p_mw_task_id in number)
     RETURN number parallel_enable;

FUNCTION Get_MW_CLAIM_DATE
         (p_mw_task_id in number)
     RETURN date parallel_enable;

FUNCTION Get_MW_Task_TYPE_ID
         (p_mw_task_id in number)
     RETURN number parallel_enable;

FUNCTION Get_MW_Complete_Date
		(p_mw_task_id in number)
RETURN Date parallel_enable;

FUNCTION Get_MW_Cancel_Work_Date
		(p_mw_task_id in number)
RETURN date parallel_enable;

FUNCTION Get_MW_Appeal_Stage
		(p_mw_task_id in number)
RETURN Number parallel_enable;

FUNCTION Get_MW_Last_Action_End_Date
		(p_mw_task_id in number)
RETURN date parallel_enable;

END fedqic_etl_manage_work_pkg;
/

CREATE OR REPLACE PACKAGE BODY fedqic_etl_manage_work_pkg IS
   g_Error   VARCHAR2(4000);
   g_Limit   NUMBER;
   gPKG VARCHAR2(30) := 'fedqic_ETL_MANAGE_WORK_PKG';


FUNCTION Get_Person_ID
         (p_user_id in number)
RETURN Number parallel_enable
AS
     v_parameter_value number := null;
BEGIN

    IF p_user_id IS NULL OR p_user_id = 0 THEN
       v_parameter_value := 0;
    ELSE

         Select P.Person_ID
           Into v_parameter_value
           From fedqic_user_stg U
           Left Outer Join fedqic_person_stg P ON U.person_id = P.person_id
          Where U.user_id = p_user_id ;

    END IF;

    if v_parameter_value is null then
	v_parameter_value := -1;
    END IF;
    

    RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN -1;
END;

FUNCTION Get_Task_Team_ID
         (p_owner_id in number)
RETURN Number parallel_enable
AS
     v_parameter_value number := null;
BEGIN

    IF p_owner_id IS NULL OR p_owner_id = 0 THEN
       v_parameter_value := 0;
    ELSE
       select team_id 
       into v_parameter_value
       from d_teams te, d_supervisor su
       where te.team_id = su.supervisor_person_id
       and su.person_id = p_owner_id;

    END IF;

    if v_parameter_value is null then
	v_parameter_value := 0;
    END IF;
    

    RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN 0;
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

FUNCTION Get_MW_Parent_Task_ID
         (p_mw_task_id in number)
RETURN Number parallel_enable
AS
     v_parameter_value number := null;
BEGIN
IF p_mw_task_id is not null
THEN
--find the ms.mw_task id of the ms.parent of the first (lowest) ms.id that  belongs to same ms.mw_task_id
SELECT MS.MW_TASK_ID
INTO v_parameter_value
FROM FEDQIC_MAXDAT_STG MS
WHERE MS.ID = (select min(ms2.c_parent_previous_action_id) from fedqic_maxdat_stg ms2 where ms2.mw_task_id = p_mw_task_id);    
END IF;
RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN null;
END;

FUNCTION Get_MW_Parent_Task_Type_ID
         (p_mw_task_id in number)
RETURN Number parallel_enable
AS
     v_parameter_value number := null;
BEGIN
IF p_mw_task_id is not null
THEN
--find the task type of the ms.mw_task id of the ms.parent of the first (lowest) ms.id that  belongs to same ms.mw_task_id
SELECT MS.C_STATUS
INTO v_parameter_value
FROM FEDQIC_MAXDAT_STG MS
WHERE MS.ID = (select min(ms2.c_parent_previous_action_id) from fedqic_maxdat_stg ms2 where ms2.mw_task_id = p_mw_task_id);    
END IF;
RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN null;
END;

FUNCTION Get_MW_NON_STANDARD_WORK_FLAG
         (p_mw_appeal_part_id in number,
	  p_mw_task_type_id in number,
	  p_mw_previous_task_type_id in number)
RETURN varchar2 parallel_enable
AS
     v_parameter_value number := null;
BEGIN
IF p_mw_task_type_id is not null
THEN
--find this combination in the C_MW_STANDARD_WORK table
SELECT count (*)
INTO v_parameter_value
FROM C_MW_STANDARD_WORK sw
WHERE sw.APPEAL_PART_ID = p_mw_appeal_part_id 
AND sw.CURRENT_TASK_TYPE_ID = p_mw_task_type_id
AND sw.PREVIOUS_TASK_TYPE_ID = p_mw_previous_task_type_id;    
END IF;
RETURN case when v_parameter_value > 0 then 'N' else 'Y' end;

EXCEPTION
  WHEN OTHERS THEN
     RETURN null;
END;




--function to find corp_etl_mw record to update
FUNCTION Get_MW_Task_ID
         (p_parent_id in number, p_appeal_id number, p_status number, p_owner number)
RETURN Number parallel_enable
AS
     v_parameter_value number := null;
BEGIN

--find parent in fedqic_maxdat_stg
--if parent has same appeal id and c_status and not (this record's c_owner is null and parent's c_owner is not null)return parent's mw_task_id
SELECT MS.MW_TASK_ID
INTO v_parameter_value
FROM FEDQIC_MAXDAT_STG MS
WHERE MS.ID = p_parent_id
AND MS.C_APPEAL_ID = p_appeal_id
AND MS.C_STATUS = p_status
AND NOT (MS.C_OWNER is not null and p_owner is null); 

RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Get_MW_Task_ID', 'fedqic MW', g_Error);
     RETURN null;
END;

FUNCTION Get_MW_Task_Owner
         (p_mw_task_id in number)
RETURN Number parallel_enable
AS
     v_parameter_value number := null;
BEGIN

SELECT MW.OWNER_STAFF_ID
INTO v_parameter_value
FROM CORP_ETL_MW_WIP MW
WHERE MW.TASK_ID = p_mw_task_id; 

RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN null;
END;

FUNCTION Get_MW_CLAIM_DATE
         (p_mw_task_id in number)
RETURN date parallel_enable
AS
     v_parameter_value date := null;
BEGIN

SELECT MW.CLAIM_DATE
INTO v_parameter_value
FROM CORP_ETL_MW_WIP MW
WHERE MW.TASK_ID = p_mw_task_id; 

RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN null;
END;


FUNCTION Get_MW_Task_Type_Id
         (p_mw_task_id in number)
RETURN Number parallel_enable
AS
     v_parameter_value number := null;
BEGIN

SELECT MW.TASK_TYPE_ID
INTO v_parameter_value
FROM CORP_ETL_MW_WIP MW
WHERE MW.TASK_ID = p_mw_task_id; 

RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN null;
END;


FUNCTION Get_MW_Complete_Date
		(p_mw_task_id in number)
RETURN Date parallel_enable
AS
     v_parameter_value date := null;
BEGIN

SELECT MW.COMPLETE_DATE
INTO v_parameter_value
FROM CORP_ETL_MW_WIP MW
WHERE MW.TASK_ID = p_mw_task_id; 

RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN null;
END;

FUNCTION Get_MW_Cancel_Work_Date
		(p_mw_task_id in number)
RETURN Date parallel_enable
AS
     v_parameter_value date := null;
BEGIN

SELECT MW.CANCEL_WORK_DATE
INTO v_parameter_value
FROM CORP_ETL_MW_WIP MW
WHERE MW.TASK_ID = p_mw_task_id; 

RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN null;
END;


FUNCTION Get_MW_Appeal_Stage
		(p_mw_task_id in number)
RETURN Number parallel_enable
AS
     v_parameter_value number := null;
BEGIN

SELECT MW.APPEAL_STAGE
INTO v_parameter_value
FROM CORP_ETL_MW_WIP MW
WHERE MW.TASK_ID = p_mw_task_id; 

RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN null;
END;

FUNCTION Get_MW_Last_Action_End_Date
		(p_mw_task_id in number)
RETURN Date parallel_enable
AS
     v_parameter_value date := null;
BEGIN

SELECT MW.LAST_ACTION_END_DATE
INTO v_parameter_value
FROM CORP_ETL_MW_WIP MW
WHERE MW.TASK_ID = p_mw_task_id; 

RETURN v_parameter_value;

EXCEPTION
  WHEN OTHERS THEN
     RETURN null;
END;


PROCEDURE InitProcess
IS
v_role_id number;
BEGIN
   -- Remove any old records from tmp table
   DELETE FROM corp_etl_mw_wip;
   COMMIT;

   --populate tmp table with records from corp_etl_mw
   --insert into corp_etl_mw_wip 
   --   (select mw.*,null from corp_etl_mw mw
   --   where mw.source_reference_id in 
   --        (select mx.c_appeal_id from fedqic_maxdat_stg mx where mx.mw_processed != 'Y'));	
   --commit;

      INSERT INTO corp_etl_mw_wip 
      SELECT  
      CEMW_ID,
      CANCELLED_BY_STAFF_ID,
      CANCEL_METHOD,
      CANCEL_REASON,
      CANCEL_WORK_DATE,
      CASE_ID,
      CLIENT_ID,
      COMPLETE_DATE,
      CREATE_DATE,
      CREATED_BY_STAFF_ID,
      ESCALATED_FLAG,
      ESCALATED_TO_STAFF_ID,
      FORWARDED_FLAG,
      FORWARDED_BY_STAFF_ID,
      BUSINESS_UNIT_ID,
      INSTANCE_START_DATE,
      INSTANCE_END_DATE,
      LAST_UPDATE_BY_STAFF_ID,
      LAST_UPDATE_DATE,
      LAST_EVENT_DATE,
      OWNER_STAFF_ID,
      PARENT_TASK_ID,
      SOURCE_REFERENCE_ID,
      SOURCE_REFERENCE_TYPE,
      STATUS_DATE,
      STG_EXTRACT_DATE,
      STG_LAST_UPDATE_DATE,
      STAGE_DONE_DATE,
      TASK_ID,
      TASK_PRIORITY,
      TASK_STATUS,
      TASK_TYPE_ID,
      TEAM_ID,
      UNIT_OF_WORK,
      WORK_RECEIPT_DATE,
      SOURCE_PROCESS_ID,
      SOURCE_PROCESS_INSTANCE_ID,
      'N',
      CLAIM_DATE,
      ROLE,
      PART,
      RECEIVED_DATE,
      null,
      APPEAL_STAGE,
      PREVIOUS_TASK_TYPE_ID,
      NON_STANDARD_WORK_FLAG,
      HANDLE_TIME
      FROM (
      SELECT  
      CEMW_ID,
      CANCELLED_BY_STAFF_ID,
      CANCEL_METHOD,
      CANCEL_REASON,
      CANCEL_WORK_DATE,
      CASE_ID,
      CLIENT_ID,
      COMPLETE_DATE,
      CREATE_DATE,
      CREATED_BY_STAFF_ID,
      ESCALATED_FLAG,
      ESCALATED_TO_STAFF_ID,
      FORWARDED_FLAG,
      FORWARDED_BY_STAFF_ID,
      BUSINESS_UNIT_ID,
      INSTANCE_START_DATE,
      INSTANCE_END_DATE,
      LAST_UPDATE_BY_STAFF_ID,
      LAST_UPDATE_DATE,
      LAST_EVENT_DATE,
      OWNER_STAFF_ID,
      PARENT_TASK_ID,
      SOURCE_REFERENCE_ID,
      SOURCE_REFERENCE_TYPE,
      STATUS_DATE,
      STG_EXTRACT_DATE,
      STG_LAST_UPDATE_DATE,
      STAGE_DONE_DATE,
      TASK_ID,
      TASK_PRIORITY,
      TASK_STATUS,
      TASK_TYPE_ID,
      TEAM_ID,
      UNIT_OF_WORK,
      WORK_RECEIPT_DATE,
      SOURCE_PROCESS_ID,
      SOURCE_PROCESS_INSTANCE_ID,
      CLAIM_DATE,
      ROLE,
      PART,
      RECEIVED_DATE,
      APPEAL_STAGE,
      PREVIOUS_TASK_TYPE_ID,
      NON_STANDARD_WORK_FLAG,
      HANDLE_TIME,			
      rank() over (partition by source_reference_id order by task_id desc) as rnk 
      FROM corp_etl_mw mw
      WHERE mw.source_reference_id in
           (select mx.c_appeal_id from fedqic_maxdat_stg mx where mx.mw_processed != 'Y')
      ) 
      where rnk = 1;

      commit;

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('INIT', 'fedqic MW', g_Error);
      COMMIT;
      RAISE;
END InitProcess;

/*
|| Procedure to insert into corp_etl_manage_work where the MS record represents a new task
||   
*/

PROCEDURE Insert_Update
IS

v_Check    NUMBER;
v_MW_Task_ID number;
v_MW_PARENT_TASK_ID number;
v_UHandle_Time number;
v_MW_Task_Owner number;
v_MW_Task_Type_Id number;
v_MW_Complete_Date Date;	
v_MW_Cancel_Work_Date Date;
v_MW_Appeal_Stage Number;
v_MW_Last_Action_End_Date Date;
v_Forwarded varchar2(1);
v_Owner_Person_ID number;
v_End_Date Date;

v_Update_Flag varchar2(1);
v_Ucancel_Method varchar2(50);
v_Ucancel_Reason varchar2(50);
v_Ucancel_Work_Date Date;	
v_Ucomplete_Date Date;
v_Uinstance_End_Date Date;
v_Uforwarded_Flag varchar2(1);
v_Uforwarded_By_Staff_ID number;
v_Ulast_Update_Date Date;
v_Ulast_Update_By_Staff_ID number;
v_Uowner_Staff_ID number;
v_Uteam_ID number;
v_Ustatus_Date Date;
v_Utask_Status varchar2(50);
v_Uclaim_Date Date;
v_UAppeal_Stage Number;
v_Ulast_Action_End_Date Date;
v_Ustg_Last_Update_Date Date;    

BEGIN

   FOR CycRow IN (SELECT MS.*
                  FROM  fedqic_maxdat_stg     MS
                  WHERE MS.MW_Processed = 'N'
                  ORDER BY ms.c_appeal_id, ms.id
                  )
   LOOP
   
   
   --does this task already exist in MW(?)
   SELECT COUNT(1)
   INTO v_Check
   FROM corp_etl_mw_wip mw
   WHERE mw.task_id = CycRow.id -- my task id already in MW
   OR --my parent is represented by a MW task and my appeal id is same and my status is same as that mw task and not (my owner is null and MW owner is not null) 
      (EXISTS 
         (SELECT 1 FROM fedqic_maxdat_stg ms2 where ms2.id = CycRow.c_parent_previous_action_id
					      AND ms2.c_appeal_id = cycRow.c_appeal_id
				              AND ms2.mw_task_id = mw.task_id
					      --AND ms2.c_status = mw.task_type_id -??
					      AND mw.source_reference_id = cycRow.c_appeal_id 
                                              AND mw.task_type_id = cycRow.c_status
					      AND NOT (cycRow.c_owner = 0 and mw.OWNER_STAFF_ID != 0)
	)
    );

   IF v_Check = 0
   THEN
      --insert new record into mw_wip
      INSERT INTO corp_etl_mw_wip (
      --CEMW_ID,
      CANCELLED_BY_STAFF_ID,
      CANCEL_METHOD,
      CANCEL_REASON,
      CANCEL_WORK_DATE,
      CASE_ID,
      CLIENT_ID, 
      COMPLETE_DATE,
      CREATE_DATE,
      CREATED_BY_STAFF_ID,
      ESCALATED_FLAG,
      ESCALATED_TO_STAFF_ID,
      FORWARDED_FLAG,
      FORWARDED_BY_STAFF_ID,  
      BUSINESS_UNIT_ID,
      INSTANCE_START_DATE,
      INSTANCE_END_DATE,
      LAST_UPDATE_BY_STAFF_ID,
      LAST_UPDATE_DATE,
      LAST_EVENT_DATE,
      OWNER_STAFF_ID, 
      PARENT_TASK_ID, 
      SOURCE_REFERENCE_ID,
      SOURCE_REFERENCE_TYPE,
      STATUS_DATE,
      STG_EXTRACT_DATE,
      STG_LAST_UPDATE_DATE,
      STAGE_DONE_DATE,
      TASK_ID,
      TASK_PRIORITY,
      TASK_STATUS,
      TASK_TYPE_ID,
      TEAM_ID,
      UNIT_OF_WORK,
      WORK_RECEIPT_DATE,
      SOURCE_PROCESS_ID,
      SOURCE_PROCESS_INSTANCE_ID,
      CHANGE_FLAG,
      CLAIM_DATE,
      ROLE,
      PART,
      RECEIVED_DATE,
      APPEAL_STAGE,
      PREVIOUS_TASK_TYPE_ID,
      NON_STANDARD_WORK_FLAG,
      HANDLE_TIME,
      LAST_ACTION_END_DATE
     )
      SELECT 
      --0 --CEMW_ID added by trigger
        0 --CANCELLED_BY_STAFF_ID not used in fedqic
      , null --CANCEL_METHOD updated by etl script
      , null --CANCEL_REASON updated by etl script
      , null --CANCEL_WORK_DATE updated by etl script
      , CycRow.C_APPEAL_NUMBER --CASE_ID (note this is varchar2 in fedqic)
      , null --CLIENT_ID (not used in fedqic)
      , null --COMPLETE_DATE (null until updated retroactively when next task is created)
      , CycRow.C_START_DATE --CREATE_DATE
      , nvl(fedqic_etl_manage_work_pkg.Get_Person_ID(CycRow.C_OWNER),0) --CREATED_BY_STAFF_ID
      , 'N' --ESCALATED_FLAG not used in fedqic
      , 0 --ESCALATED_BY_STAFF_ID not used in fedqic
      , 'N' --FORWARDED_FLAG new record can't already be forwarded
      , 0 --FORWARDED_BY_STAFF_ID new record can't already be forwarded
      , 0  --BUSINESS_UNIT_ID
      , CycRow.C_START_DATE --INSTANCE_START_DATE
      , null --INSTANCE_END_DATE should be null until updated retroactivley when next task is created or from udpate_cancelled etl script
      , nvl(fedqic_etl_manage_work_pkg.Get_Person_ID(CycRow.C_OWNER),0) --LAST_UPDATED_BY_STAFF_ID
      , case when CycRow.c_end_date is null then CycRow.c_start_date else CycRow.c_end_date end --LAST_UPDATED_DATE (?)
      , sysdate --LAST_EVENT_DATE not used in fedqic (?)
      , nvl(fedqic_etl_manage_work_pkg.Get_Person_ID(CycRow.C_OWNER),0) --OWNER_STAFF_ID
      , null --PARENT_TASK_ID updated below
      , CycRow.C_APPEAL_ID  --SOURCE_REFERENCE_ID
      , 'APPEAL' --SOURCE_REFERENCE_TYPE
      , CycRow.c_start_date --STATUS_DATE (end_date only relevant to "COMPLETED" status, which is updated retroactively when next task created)  (?)
      , sysdate --STG_EXTRACT_DATE
      , sysdate --STG_LAST_UPDATE_DATE 
      , null --STG_DONE_DATE (new record stg is not done with it yet)
      , CycRow.ID --TASK_ID
      , TO_CHAR(NVL(CycRow.C_APPEAL_PRIORITY,0)) --TASK_PRIORITY
      , case when CycRow.c_owner = 0 then 'UNCLAIMED' else 'CLAIMED' end --TASK_STATUS ("COMPLETED" status updated retroactively when next task is created)
      , CycRow.C_STATUS --TASK_TYPE_ID
      , fedqic_etl_manage_work_pkg.Get_Task_Team_ID(nvl(fedqic_etl_manage_work_pkg.Get_Person_ID(CycRow.C_OWNER),0)) --TEAM_ID not used in fedqic, so using supervisor id as team id
      , null --UNIT_OF_WORK not used in fedqic
      , CycRow.C_START_DATE --WORK_RECEIPT_DATE
      , null --SOURCE_PROCES_ID not used in fedqic
      , null --SOURCE_PROCESS_INSTANCE_ID not used in fedqic
      ,'N' --CHANGE_FLAG
      , CASE WHEN CycRow.C_OWNER != 0 THEN CycRow.C_START_DATE ELSE NULL END --CLAIM_DATE
      , fedqic_etl_manage_work_pkg.Get_ROLE_NAME(CycRow.ROLE_ID) --ROLE
      , CycRow.APPEAL_PART --PART
      , CycRow.C_APPEAL_REQUEST_RECEIVED_DATE  --RECEIVED_DATE
      , CycRow.APPEAL_STAGE --APPEAL_STAGE
      , null --PREVIOUS_TASK_TYPE_ID
      , 'N' --NON_STANDARD_WORK_FLAG
      , null --HANDLE_TIME
      , CycRow.C_END_DATE
      from dual;      
  
      --update fedqic_maxdat_stg record
      UPDATE fedqic_maxdat_stg ms
      SET ms.MW_Processed      =  'Y',
      ms.MW_TASK_ID = CycRow.id	
      WHERE id = CycRow.id;

      --update parent_task_id in corp_etl_mw_wip 
      update corp_etl_mw_wip mw set mw.parent_task_id = fedqic_etl_manage_work_pkg.Get_MW_Parent_Task_ID(cycRow.ID),
      previous_task_type_id = fedqic_etl_manage_work_pkg.Get_MW_Parent_Task_Type_ID(cycRow.ID),
      non_standard_work_flag = 	fedqic_etl_manage_work_pkg.Get_MW_NON_STANDARD_WORK_FLAG(cycRow.part_id, cycRow.c_status, fedqic_etl_manage_work_pkg.Get_MW_Parent_Task_Type_ID(cycRow.ID)),
      change_flag = 'Y' 
      where mw.task_id = CycRow.ID; 
	       

      --insert record from wip into mw (excluding records with task type of Closed or Archive)
      IF (CycRow.c_status not in (47,49)) --PRD task type id for Closed and Archive
      THEN	
      INSERT INTO corp_etl_mw
         SELECT CEMW_ID,
            CANCELLED_BY_STAFF_ID,
            CANCEL_METHOD,
            CANCEL_REASON,
            CANCEL_WORK_DATE,
            CASE_ID,
            CLIENT_ID, 
            COMPLETE_DATE,
            CREATE_DATE,
            CREATED_BY_STAFF_ID,
            ESCALATED_FLAG,
            ESCALATED_TO_STAFF_ID,
            FORWARDED_FLAG,
            FORWARDED_BY_STAFF_ID,  
            BUSINESS_UNIT_ID,
            INSTANCE_START_DATE,
            INSTANCE_END_DATE,
            LAST_UPDATE_BY_STAFF_ID,
            LAST_UPDATE_DATE,
            LAST_EVENT_DATE,
            OWNER_STAFF_ID, 
            PARENT_TASK_ID, 
            SOURCE_REFERENCE_ID,
            SOURCE_REFERENCE_TYPE,
            STATUS_DATE,
            STG_EXTRACT_DATE,
            STG_LAST_UPDATE_DATE,
            STAGE_DONE_DATE,
            TASK_ID,
            TASK_PRIORITY,
            TASK_STATUS,
            TASK_TYPE_ID,
            TEAM_ID,
            UNIT_OF_WORK,
            WORK_RECEIPT_DATE,
            SOURCE_PROCESS_ID,
            SOURCE_PROCESS_INSTANCE_ID,
            CLAIM_DATE,
            ROLE,
            PART,
            RECEIVED_DATE,
            LAST_ACTION_END_DATE,
      	    APPEAL_STAGE,
            PREVIOUS_TASK_TYPE_ID,
            NON_STANDARD_WORK_FLAG,
            HANDLE_TIME
        FROM corp_etl_mw_wip T WHERE T.task_id = CycRow.id;
        END IF;

      --update completion related fields retroactively for parent task when new task is created by this record
      v_MW_Parent_task_ID := null;
      v_MW_Complete_Date := null;
      v_MW_Cancel_Work_Date := null;
      v_MW_Task_Owner := 0;
      v_MW_Task_Type_Id := null;
      v_MW_Last_Action_End_Date := null;
      v_Ucomplete_Date := null;
      v_Uinstance_End_Date := null;
      v_UHandle_Time := null;
      v_MW_Parent_Task_ID := fedqic_etl_manage_work_pkg.Get_MW_Parent_Task_ID(cycRow.ID);
      IF v_MW_Parent_Task_ID is not null
      THEN 
	 --v_MW_Complete_Date := fedqic_etl_manage_work_pkg.Get_MW_Complete_Date(v_MW_Parent_Task_ID);
	 v_MW_Cancel_Work_Date := fedqic_etl_manage_work_pkg.Get_MW_Cancel_Work_Date(v_MW_Parent_Task_ID);
	 v_MW_Task_Owner := fedqic_etl_manage_work_pkg.Get_MW_Task_Owner(v_MW_Parent_Task_ID); 	 
	 v_MW_Task_Type_Id := fedqic_etl_manage_work_pkg.Get_MW_Task_TYpe_Id(v_MW_Parent_Task_ID);
	 v_MW_Last_Action_End_Date := fedqic_etl_manage_work_pkg.Get_MW_Last_Action_End_Date(v_MW_Parent_Task_ID);
	 IF v_MW_Last_Action_End_Date is null
	 THEN 	
	    v_Ucomplete_Date := CycRow.c_start_date;
	 ELSE 
	    v_Ucomplete_Date := v_MW_Last_Action_End_Date;
	 END IF;
         v_Uinstance_End_Date := coalesce(v_Ucomplete_Date,v_MW_Cancel_Work_Date);	 
         v_UHandle_Time := 24* (v_UComplete_Date - fedqic_etl_manage_work_pkg.Get_MW_CLAIM_DATE(v_MW_Parent_Task_ID)); 	 	

	 UPDATE corp_etl_mw_wip set COMPLETE_DATE = v_Ucomplete_Date, 
			        INSTANCE_END_DATE = v_Uinstance_End_Date, 
			        LAST_UPDATE_DATE = v_Ucomplete_Date,
			        STATUS_DATE = v_Ucomplete_Date,
			        TASK_STATUS = 'COMPLETED', 
			        LAST_UPDATE_BY_STAFF_ID = v_MW_Task_Owner,
				STG_LAST_UPDATE_DATE = sysdate, 
				STAGE_DONE_DATE = sysdate,
				LAST_EVENT_DATE = sysdate,
				HANDLE_TIME = v_UHandle_Time,
				CHANGE_FLAG = 'Y'
	 WHERE corp_etl_mw_wip.task_id = v_MW_Parent_Task_ID;	
      END IF;

	--update created by staff id to person who forwarded if the task was created by forwarding back to queue;
	IF (v_MW_Task_Type_Id = CycRow.c_status) AND (v_MW_Task_Owner != 0 and CycRow.c_owner = 0) 
	THEN
	UPDATE corp_etl_mw_wip set created_by_staff_id = v_MW_Task_Owner 
	WHERE corp_etl_mw_wip.task_id = CycRow.ID;
	END IF;


ELSE
   --update corp_etl_mw_wip record
   DBMS_OUTPUT.put_line('updating '||CycRow.ID);
   v_Update_Flag := 'N';		
   v_Ucomplete_Date :=null;
   v_Uforwarded_Flag :=null;
   v_Uforwarded_By_Staff_ID :=null;
   v_Ulast_Update_Date :=null;
   v_Ulast_Update_By_Staff_ID :=null;
   v_Uowner_Staff_ID :=null;
   v_Uteam_ID := null;
   v_Ustatus_Date :=null;
   v_Utask_Status :=null;
   v_Uclaim_Date :=null;
   v_UAppeal_Stage := null;
   v_Ulast_Action_End_Date :=null;
   v_Ustg_Last_Update_Date :=null;

   --get existing task info
   v_MW_Task_ID := fedqic_etl_manage_work_pkg.Get_MW_Task_ID(CycRow.c_parent_previous_action_id, CycRow.c_appeal_id, CycRow.c_status,CycRow.c_owner);
   v_MW_Task_Owner := fedqic_etl_manage_work_pkg.Get_MW_Task_Owner(v_MW_Task_ID); 
   v_MW_Complete_Date := fedqic_etl_manage_work_pkg.Get_MW_Complete_Date(v_MW_Task_ID);
   v_MW_Cancel_Work_Date := fedqic_etl_manage_work_pkg.Get_MW_Cancel_Work_Date(v_MW_Task_ID);
   v_MW_Appeal_Stage := fedqic_etl_manage_work_pkg.Get_MW_Appeal_Stage(v_MW_Task_ID);

   --this new record info and defaults
   v_Owner_Person_ID := nvl(fedqic_etl_manage_work_pkg.Get_Person_ID(CycRow.c_owner),0);
   v_Forwarded := 'N';

   --don't update CANCELLED_BY_STAFF_ID,CANCEL_METHOD,CANCEL_REASON,CANCEL_WORK_DATE updated by update cancelled etl script
   --don't update CASE_ID,CLIENT_ID	
   --don't update complete date (update this when next new task is created retroactively from insert section)
   --don't update create date,created_by_staff_id
   --don't update escalated_flag, escalated_to_staff_id (not used)
	
   --update forwarded_flag, forwarded_by_staff_id 	
   IF CycRow.c_owner != 0 and v_MW_Task_Owner != 0 and v_Owner_Person_ID != v_MW_Task_Owner
   THEN
	v_Forwarded := 'Y';   
	v_Uforwarded_Flag := v_Forwarded;
	v_Uforwarded_By_Staff_ID := v_MW_Task_Owner;
	v_Update_Flag := 'Y';	 
   END IF;
	
   --don't update BUSINESS_UNIT_ID (=part)
   --don't update INSTANCE_START_DATE
   --don't update INSTANCE_END_DATE (updated retroactively from insert section and from update cancelled etl script)	

   --update LAST_UPDATE_BY_STAFF_ID,LAST_UPDATE_DATE (also updated retroactively from insert section)
   --note: should last_update_date always match last_update_by_staff_id (ie. last_update_date = last time updated by staff); 
   --should last_update_by_staff_id be null if last updated was by system, or remain the last staff id to have updated the task in the past?

   IF CycRow.c_end_date is null
   THEN 
	v_Ulast_Update_Date := CycRow.c_start_date;
	v_Update_Flag := 'Y';
   ELSE
	v_Ulast_Update_Date := CycRow.c_end_date;
	v_Update_Flag := 'Y';	
   END IF;
	
   IF v_Forwarded = 'Y' --if forwarded then the staff who forwarded is the staff who last updated	
   THEN
	v_Ulast_Update_By_Staff_ID := v_MW_Task_Owner;
	v_Update_Flag := 'Y';
   ELSE
	v_Ulast_Update_By_Staff_ID := nvl(v_Owner_Person_ID,0);
	v_Update_Flag := 'Y';
   END IF; 

   --don't update PARENT_TASK_ID
   --don't update SOURCE_REFERENCE_ID,SOURCE_REFERENCE_TYPE

   --update STATUS_DATE, TASK_STATUS, and V_OWNER_STAFF_ID if "UNCLAIMED" or "CLAIMED", update CLAIMED_DATE if "CLAIMED"
   --don't update to "COMPLETED" here - updated retroactively in insert section
   IF CycRow.c_owner = 0 and v_MW_Task_Owner != 0 --(i.e. changing from owned to unowned)
   THEN
	v_Ustatus_Date := CycRow.c_start_date;
	v_Utask_Status := 'UNCLAIMED';
	v_Uowner_Staff_ID := v_Owner_Person_ID;	
        v_Uteam_ID := fedqic_etl_manage_work_pkg.Get_Task_Team_ID(v_Owner_Person_ID);	
	v_Update_Flag := 'Y';
   END IF;
   IF (CycRow.c_owner != 0 and v_MW_Task_OWner = 0) or (CycRow.c_owner != 0 and v_MW_Task_Owner != 0 and v_Owner_Person_ID != v_MW_Task_Owner)
   --(ie. changeing from unowned to owned or from one owner to a different owner)
   THEN
	v_Ustatus_Date := CycRow.c_start_date;
	v_Utask_Status := 'CLAIMED';
	v_Uclaim_Date := CycRow.c_start_date;
	v_Uowner_Staff_ID := v_Owner_Person_ID;
        v_Uteam_ID := fedqic_etl_manage_work_pkg.Get_Task_Team_ID(v_Owner_Person_ID);
	v_Update_Flag := 'Y';
   END IF;
 
   --don't update STG_EXTRACT_DATE,
   --don't update STAGE_DONE_DATE (if COMPLETED or cancelled - needs to be updated retroactively from insert section or from update_cancelled etl script)
   --don't update TASK_ID,TASK_PRIORITY
   --don't update TASK_TYPE_ID (since this results in new task)
   --don't update TEAM_ID (team id is updated to equal new supervisor id when owner is updated), UNIT_OF_WORK (not used)
   --don't update WORK_RECEIPT_DATE (same as create date)
   --don't update SOURCE_PROCESS_ID,SOURCE_PROCESS_INSTANCE_ID,
   --don't update ROLE,PART,RECEIVED_DATE

--update appeal_stage
IF ((CycRow.Appeal_Stage != v_MW_Appeal_Stage) or not (CycRow.Appeal_Stage is null and v_MW_Appeal_Stage is null))
THEN
	v_UAppeal_Stage := CycRow.Appeal_Stage;
	v_Update_Flag := 'Y';
END IF;


   --update LAST_ACTION_END_DATE
	v_Ulast_Action_End_Date := CycRow.c_end_date;

   --update STG_LAST_UPDATE_DATE,
   IF v_Update_Flag = 'Y'
   THEN
	v_Ustg_Last_Update_Date := sysdate;
	
	--execute updates
	UPDATE CORP_ETL_MW_WIP MW SET   
	MW.FORWARDED_FLAG = CASE WHEN v_Uforwarded_Flag IS NOT NULL THEN v_Uforwarded_Flag ELSE MW.FORWARDED_FLAG END, 
	MW.FORWARDED_BY_STAFF_ID = CASE WHEN v_Uforwarded_By_Staff_ID IS NOT NULL THEN v_Uforwarded_By_Staff_ID ELSE MW.FORWARDED_BY_STAFF_ID END, 
	MW.LAST_UPDATE_DATE = CASE WHEN v_Ulast_Update_Date IS NOT NULL THEN v_Ulast_Update_Date ELSE MW.LAST_UPDATE_DATE END,  
	MW.LAST_UPDATE_BY_STAFF_ID = CASE WHEN v_Ulast_Update_By_Staff_ID IS NOT NULL THEN v_Ulast_Update_By_Staff_ID ELSE MW.LAST_UPDATE_BY_STAFF_ID END,  
	MW.OWNER_STAFF_ID = CASE WHEN v_Uowner_Staff_ID IS NOT NULL THEN v_Uowner_Staff_ID ELSE MW.OWNER_STAFF_ID END, 
        MW.TEAM_ID = CASE WHEN v_Uteam_ID IS NOT NULL THEN v_Uteam_ID ELSE MW.TEAM_ID END, 
	MW.STATUS_DATE = CASE WHEN v_Ustatus_Date IS NOT NULL THEN v_Ustatus_Date ELSE MW.STATUS_DATE END,  
	MW.TASK_STATUS = CASE WHEN v_Utask_Status IS NOT NULL THEN v_Utask_Status ELSE MW.TASK_STATUS END,  
	MW.CLAIM_DATE = CASE WHEN v_Uclaim_Date IS NOT NULL THEN v_Uclaim_Date ELSE MW.CLAIM_DATE END,
	MW.APPEAL_STAGE = CASE WHEN v_UAppeal_Stage IS NOT NULL THEN v_UAppeal_Stage ELSE MW.APPEAL_STAGE END,
	MW.STG_LAST_UPDATE_DATE = CASE WHEN v_Ustg_Last_Update_Date IS NOT NULL THEN v_Ustg_Last_Update_Date ELSE MW.STG_LAST_UPDATE_DATE END,
	MW.LAST_EVENT_DATE = CASE WHEN v_Ustg_Last_Update_Date IS NOT NULL THEN v_Ustg_Last_Update_Date ELSE MW.LAST_EVENT_DATE END,
	CHANGE_FLAG = 'Y'
	WHERE MW.TASK_ID = v_MW_TASK_ID; 

   --update last action end date for use in setting complete date retroactively
   UPDATE CORP_ETL_MW_WIP MW SET
   MW.LAST_ACTION_END_DATE = v_Ulast_Action_End_Date
   WHERE MW.TASK_ID = v_MW_TASK_ID; 

   END IF;

   --update fedqic_maxdat_stg record
   UPDATE fedqic_maxdat_stg ms
   SET ms.MW_Processed =  'Y',
   ms.MW_TASK_ID = v_MW_Task_ID	
   WHERE id = CycRow.id;

END IF;


   END LOOP;
   COMMIT;


EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
      g_Error := SQLERRM ;
      INSERT INTO corp_etl_error_log (process_name, job_name, error_desc) VALUES ('Insert_Update_Task', 'fedqic MW', g_Error);
      COMMIT;
      RAISE;

END Insert_Update;

PROCEDURE MW_UPDATE_MAIN_TABLE AS

 CURSOR wip_cur IS
   SELECT * FROM corp_etl_mw_wip
   WHERE CHANGE_FLAG = 'Y';

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
         UPDATE corp_etl_mw
            SET 
		CANCELLED_BY_STAFF_ID = wip_tab(indx).CANCELLED_BY_STAFF_ID,
       		CANCEL_METHOD         = wip_tab(indx).CANCEL_METHOD,
  		CANCEL_REASON         = wip_tab(indx).CANCEL_REASON,
  		CANCEL_WORK_DATE      = wip_tab(indx).CANCEL_WORK_DATE,
  		CASE_ID               = wip_tab(indx).CASE_ID,
  		CLIENT_ID             = wip_tab(indx).CLIENT_ID,
  		COMPLETE_DATE         = wip_tab(indx).COMPLETE_DATE,
  		CREATE_DATE           = wip_tab(indx).CREATE_DATE,
  		CREATED_BY_STAFF_ID   = wip_tab(indx).CREATED_BY_STAFF_ID,
  		ESCALATED_FLAG        = wip_tab(indx).ESCALATED_FLAG,
  		ESCALATED_TO_STAFF_ID = wip_tab(indx).ESCALATED_TO_STAFF_ID,
  		FORWARDED_FLAG        = wip_tab(indx).FORWARDED_FLAG,
  		FORWARDED_BY_STAFF_ID = wip_tab(indx).FORWARDED_BY_STAFF_ID,
  		BUSINESS_UNIT_ID      = wip_tab(indx).BUSINESS_UNIT_ID,
  		INSTANCE_START_DATE   = wip_tab(indx).INSTANCE_START_DATE,
  		INSTANCE_END_DATE     = wip_tab(indx).INSTANCE_END_DATE,
  		LAST_UPDATE_BY_STAFF_ID	= wip_tab(indx).LAST_UPDATE_BY_STAFF_ID,
  		LAST_UPDATE_DATE        = wip_tab(indx).LAST_UPDATE_DATE,
  		LAST_EVENT_DATE         = wip_tab(indx).LAST_EVENT_DATE,
  		OWNER_STAFF_ID	        = wip_tab(indx).OWNER_STAFF_ID,
  		PARENT_TASK_ID          = wip_tab(indx).PARENT_TASK_ID,
  		SOURCE_REFERENCE_ID     = wip_tab(indx).SOURCE_REFERENCE_ID,
  		SOURCE_REFERENCE_TYPE   = wip_tab(indx).SOURCE_REFERENCE_TYPE,
  		STATUS_DATE             = wip_tab(indx).STATUS_DATE,
  		STG_EXTRACT_DATE        = wip_tab(indx).STG_EXTRACT_DATE,
  		STG_LAST_UPDATE_DATE    = wip_tab(indx).STG_LAST_UPDATE_DATE,
  		STAGE_DONE_DATE         = wip_tab(indx).STAGE_DONE_DATE,
  		TASK_ID                 = wip_tab(indx).TASK_ID,
  		TASK_PRIORITY           = wip_tab(indx).TASK_PRIORITY,
  		TASK_STATUS             = wip_tab(indx).TASK_STATUS,
  		TASK_TYPE_ID            = wip_tab(indx).TASK_TYPE_ID,
  		TEAM_ID                 = wip_tab(indx).TEAM_ID,
  		UNIT_OF_WORK            = wip_tab(indx).UNIT_OF_WORK,
  		WORK_RECEIPT_DATE       = wip_tab(indx).WORK_RECEIPT_DATE,
  		SOURCE_PROCESS_INSTANCE_ID = wip_tab(indx).SOURCE_PROCESS_INSTANCE_ID,
  		CLAIM_DATE	           = wip_tab(indx).CLAIM_DATE,
  		ROLE		           = wip_tab(indx).ROLE,
  		PART		           = wip_tab(indx).PART,
  		RECEIVED_DATE	           = wip_tab(indx).RECEIVED_DATE,
      		APPEAL_STAGE 		   = wip_tab(indx).APPEAL_STAGE,
      		PREVIOUS_TASK_TYPE_ID	   = wip_tab(indx).PREVIOUS_TASK_TYPE_ID,
      		NON_STANDARD_WORK_FLAG	   = wip_tab(indx).NON_STANDARD_WORK_FLAG,
      		HANDLE_TIME		   = wip_tab(indx).HANDLE_TIME,
		LAST_ACTION_END_DATE	   = wip_tab(indx).LAST_ACTION_END_DATE
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

END fedqic_etl_manage_work_pkg;

/

alter session set plsql_code_type = interpreted;