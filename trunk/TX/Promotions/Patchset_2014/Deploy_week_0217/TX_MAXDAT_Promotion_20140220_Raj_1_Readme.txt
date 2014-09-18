******************************************** MODIFICATION HISTORY ***********************************************************************************
Instructions to install TXEB 
-----------------------------
2014/01/21 Raj A. 
1. Deploy performance improved ktrs and some bug fixes.

******************************************** MODIFICATION HISTORY ***********************************************************************************


----------------------------------
1.DB SCRIPTS SECTION 
----------------------------------
n/a

-----------------------
2. KETTLE FILES SECTION
-----------------------

Server: MAXDAT UAT App Server, i.e., 148.87.247.142

Download AS_PL_CODE_TUNING_20140121_RAJ_5.zip
OR
Fetch files from svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ManageEnrollmentActivity

and Deploy the following files to the appropriate path in the TXEB MAXDAT UAT Server, i.e., 
UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity

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
ManageEnroll_Set_Env_Var.ktr