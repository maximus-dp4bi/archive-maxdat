******************************************** MODIFICATION HISTORY ***********************************************************************************
Instructions to install TXEB 
-----------------------------
2014/03/24 Raj A. 
1. Deploy ktrs that call the plsql ETL code. Added Start_time and End_time to call the ETL during a specific time.
   The deployment for last week happened only to UAT database. Kettle code errored out in UAT and hence it wasn't deployed to PRD.
   This week release i.e, 03242014 is scheduled for prod deployment.

******************************************** MODIFICATION HISTORY ***********************************************************************************


----------------------------------
1.DB SCRIPTS SECTION 
----------------------------------
execute MAXDAT_ADMIN.SHUTDOWN_JOBS;

        *******************************************************************************************	
               Raj A. (Manage Enrollment Activity)
        ------------------------------------------------------------------------------------
       	** Unzip DB_MEA_20140324_RAJ_6.zip
               ** Run in the order specified below.
       
               
        20140317_1205_DML_Global_Controls.sql
        20140317_1205_Update_TXEB_MEA_Events_Semantic.sql
        ETL_MANAGE_ENROLLMENT_PKG.sql
        20140317_1749_MEA_Index_WIP_tab.sql
       
       ------------------------------------------------------------------------------------
       *******************************************************************************************

execute MAXDAT_ADMIN.STARTUP_JOBS;


-----------------------
2. KETTLE FILES SECTION
-----------------------

Server: MAXDAT UAT App Server, i.e., 148.87.247.142

Download AS_MEA_20140324_RAJ_6.zip
OR
Fetch files from svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ManageEnrollmentActivity

and Deploy the following files to the appropriate path in the TXEB MAXDAT UAT Server, i.e., 
UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity
ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity
PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity


ProcessManageEnroll_RUNALL_ONCE_A_DAY.kjb
ProcessManageEnroll_Check_Schedule.ktr
ProcessManageEnroll_RUNALL.kjb
ManageEnroll_WIP_to_BPM_StageTable.ktr
ManageEnroll_Update_Enrollment_Status.ktr
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
ManageEnroll_UPD16.ktr
ManageEnroll_UPD15.ktr
ManageEnroll_UPD13.ktr
ManageEnroll_UPD12.ktr
ManageEnroll_UPD11.ktr
ManageEnroll_UPD10.ktr
ManageEnroll_UPD1.ktr
ManageEnroll_STATS_WIP_Stage.ktr
ManageEnroll_STATS_tables.ktr
ManageEnroll_STATS_OLTP_Stage.ktr
ManageEnroll_STATS_All_STG_tables.ktr
ManageEnroll_SLCT_AUTO_PROC.ktr
ManageEnroll_Set_Env_Var.ktr
ManageEnroll_Plan_Selection.ktr
ManageEnroll_Insert_Instances.ktr
ManageEnroll_Fetch_Second_FU_TX.ktr
ManageEnroll_Fetch_HPC_Letters.ktr
ManageEnroll_Fetch_First_FU_TX.ktr
ManageEnroll_Fetch_Fee.ktr
ManageEnroll_Fetch_Enrl_packets.ktr
ManageEnroll_Fetch_EMI_Letters.ktr
ManageEnroll_copy_to_interm_stage_tables.ktr
ManageEnroll_Cancel_Dt_NO_LONGER_ELIG.ktr
ManageEnroll_Cancel_Dt_NEW_ENRL_PKT.ktr
ManageEnroll_Calc_Age.ktr
ManageEnroll_AA_Due_Dt.ktr

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
 *******************************************************************************************	
         Raj A. (Manage Enrollment Activity)
	--------------------------------------------------------------------
	Download AS_MEA_20140324_RAJ_6.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

	tx_run_bpm.sh
	
	**Run dos2unix for the following List
	tx_run_bpm.sh
	
	** chmod 755
	chmod 755 tx_run_bpm.sh
	--------------------------------------------------------------------
       *******************************************************************************************