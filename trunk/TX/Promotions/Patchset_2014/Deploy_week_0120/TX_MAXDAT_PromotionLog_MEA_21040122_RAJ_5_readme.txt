******************************************** MODIFICATION HISTORY ***********************************************************************************
Instructions to install TXEB 
-----------------------------
2014/01/22 Raj A. 
1. Deploy performance improved ktrs and some bug fixes.
   Loading Enrollment data received on or after 01-DEC-2013.

******************************************** MODIFICATION HISTORY ***********************************************************************************


----------------------------------
1.DB SCRIPTS SECTION 
----------------------------------
server: ldohstxeb001.oracleoutsourcing.com
Database SID: PTXE4T

Disable BPM queue jobs for Manage Enrollment Activity process only.

execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(14,1,'ENABLED','N');
execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(14,2,'ENABLED','N');

        Raj A. (Manage Enrollment Activity)
        ------------------------------------------------------------------------------------
	** Unzip DB_MEA_20140122_RAJ_5.zip
        ** Run in the order specified below.

        1.20140122_0006_Cleanup_Tables_Upd_Global_Controls.sql
        ------------------------------------------------------------------------------------

-----------------------
2. KETTLE FILES SECTION
-----------------------

Download AS_PL_CODE_TUNING_20140122_RAJ_5.zip
OR
Fetch files from svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ManageEnrollmentActivity

and Deploy the following files to the appropriate path
ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity
PRD      DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity

ProcessManageEnroll_RUNALL_ONCE_A_DAY.kjb
ProcessManageEnroll_RUNALL_INTIAL_RUN.kjb
ProcessManageEnroll_RUNALL.kjb
ManageEnroll_WIP_to_BPM_StageTable.ktr
ManageEnroll_Update_Enrollment_Status.ktr
ManageEnroll_UPD_Rules_to_WIP.kjb
ManageEnroll_UPD9.ktr
ManageEnroll_UPD8.ktr
ManageEnroll_UPD7.ktr
ManageEnroll_UPD6.ktr
ManageEnroll_UPD5.ktr
ManageEnroll_UPD4.ktr
ManageEnroll_UPD3.ktr
ManageEnroll_UPD2.ktr
ManageEnroll_UPD19.ktr
ManageEnroll_UPD18.ktr
ManageEnroll_UPD17.ktr
ManageEnroll_UPD16.ktr
ManageEnroll_UPD15.ktr
ManageEnroll_UPD14.ktr
ManageEnroll_UPD13.ktr
ManageEnroll_UPD12.ktr
ManageEnroll_UPD11.ktr
ManageEnroll_UPD10.ktr
ManageEnroll_UPD1.ktr
ManageEnroll_Subprogram.ktr
ManageEnroll_SLCT_AUTO_PROC.ktr
ManageEnroll_set_RUN_RUNALL_TODAY.ktr
ManageEnroll_set_MAX_Update_TS_HPC_EMI.ktr
ManageEnroll_set_MAX_Update_TS.ktr
ManageEnroll_set_MAX_Clnt_enl_stat_ID.ktr
ManageEnroll_Plan_Selection.ktr
ManageEnroll_Newborn_Flag.ktr
ManageEnroll_MainJob_completed.ktr
ManageEnroll_Insert_Instances.ktr
ManageEnroll_Fetch_Second_FU_TX.ktr
ManageEnroll_Fetch_HPC_Letters.ktr
ManageEnroll_Fetch_First_FU_TX.ktr
ManageEnroll_Fetch_Fee_AA_due_date.ktr
ManageEnroll_Fetch_Enrl_packets.ktr
ManageEnroll_Fetch_EMI_Letters.ktr
ManageEnroll_Fetch_Client_Address.ktr
ManageEnroll_CHECK_Run_RUNALL_Today.ktr
ManageEnroll_Cancel_Dt_NO_LONGER_ELIG.ktr
ManageEnroll_Cancel_Dt_NEW_ENRL_PKT.ktr

---------------------
3. UNIX SCRIPT SECTION
---------------------
 ******************************************************************************************* 
        
       --------------------------------------------------------------------
       Download AS_PL_CODE_TUNING_20140122_RAJ_5.zip
       Deploy the follow files to the appropriate path
       ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
       PRD      DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

  
       tx_run_bpm_MEA_INITIAL_RUN.sh
      
       dos2unix tx_run_bpm_MEA_INITIAL_RUN.sh
 
       chmod 755 tx_run_bpm_MEA_INITIAL_RUN.sh
       --------------------------------------------------------------------

 *******************************************************************************************  

This script is not needed after the Initial run.


----------------------------------
4.DB SCRIPTS SECTION 
----------------------------------
server: ldohstxeb001.oracleoutsourcing.com
Database SID: PTXE4T

********** CHECK WITH DEVELOPER BEFORE PERFORMING THE BELOW STEP.  ************

Enable BPM queue jobs for Manage Enrollment Activity process only.

execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(14,1,'ENABLED','Y');
execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(14,2,'ENABLED','Y');

---------------------
5. Schedule CRON Job for the Manage Enrollment Activity process only.
---------------------
********** CHECK WITH DEVELOPER BEFORE PERFORMING THE BELOW STEP.  ************

Schedule tx_run_bpm_MEA.sh to run once a day at 11PM.