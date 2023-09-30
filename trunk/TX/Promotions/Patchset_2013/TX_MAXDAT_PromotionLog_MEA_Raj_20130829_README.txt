--------------------------------------------------------------------	
CONTACT_NAME:	Raj A.
CONTACT_NUMBER:	(O)512-533-5143; (M)361-228-5588

If there are error in any one of the following scripts please stop and notify the contact name above, otherwise it creates more clean up for all of us.

1. Turn off the cron job, tx_run_bpm.sh

2.Copy the below kettle script (*.kjb, *.ktr) from 
  svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/ManageEnrollmentActivity 
  OR 
  svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_MEA_KETTLE_CORP_20130829_RAJ_1.zip
  to:/u25/ETL_Scripts/UAT/scripts/ManageEnrollmentActivity

2.1.1 ManageEnroll_Set_Env_Var.ktr
2.1.2 ManageEnroll_Insert_Instances.ktr
2.1.3 ManageEnroll_Newborn_Flag.ktr
2.1.4 ManageEnroll_Subprogram.ktr
2.1.5 ManageEnroll_Fetch_Fee_AA_due_date	
2.1.6 ManageEnroll_copy_to_interm_stage_tables.ktr
2.1.7 ManageEnroll_Fetch_Enrl_packets.ktr
2.1.8 ManageEnroll_Cancel_Dt_NO_LONGER_ELIG.ktr
2.1.9 ManageEnroll_Cancel_Dt_NEW_ENRL_PKT.ktr
2.1.10 ManageEnroll_Plan_Selection.ktr
2.1.11 ManageEnroll_SLCT_AUTO_PROC.ktr
2.1.12 ManageEnroll_Update_Enrollment_Status.ktr
2.1.13 ManageEnroll_Calc_Age.ktr
2.1.14 ManageEnroll_Apply_UPD_Rules_to_WIP.ktr
2.1.15 ManageEnroll_NULL_Columns_ONE_TIME.ktr
2.1.16 ManageEnroll_WIP_to_BPM_StageTable.ktr
2.1.17 ManageEnroll_set_MAX_Clnt_enl_stat_ID.ktr
2.1.18 ManageEnroll_set_MAX_Update_TS
2.1.19 ProcessManageEnroll_RUNALL.kjb
2.1.20 ManageEnroll_STATS_tables.ktr
2.1.21 ManageEnroll_STATS_All_STG_tables.ktr
2.1.22 ProcessManageEnroll_RUNALL_INTIAL_RUN.kjb
2.1.23 ManageEnroll_CHECK_Run_RUNALL_Today.ktr
2.1.24 ProcessManageEnroll_RUNALL_ONCE_A_DAY.kjb
2.1.25 ManageEnroll_set_RUN_RUNALL_TODAY.ktr



2.1.26 Follow instructions in TX_MAXDAT_PromotionLog_MEA_20131002_RAJ_2_README.txt 



  Copy the below kettle script (*.kjb, *.ktr) from 
  svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/ManageEnrollmentActivity 
  OR 
  svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_MEA_KETTLE_TXEB_20130829_RAJ_1.zip
  to:/u25/ETL_Scripts/UAT/scripts/ManageEnrollmentActivity

2.2.1 ManageEnroll_Fetch_First_FU_TX.ktr
2.2.2 ManageEnroll_Fetch_Second_FU_TX.ktr


    Copy the below kettle script (*.kjb, *.ktr) from 
    svn://rcmxapp1d.maximus.com/maxdat/trunk/IL/ETL/scripts 
    OR 
    svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_MEA_CORP_20130829_RAJ_1.zip
    to:/u25/ETL_Scripts/UAT/scripts

2.3.1 UPD_ENUM_ENROLL_TRANS_SOURCE.ktr
2.3.2 Load_OLTP_Lookups.kjb
2.3.3 CDC_CLIENT_ENROLL_STATUS_1.ktr
2.3.4 CDC_CLIENT_ENROLL_STATUS_2.ktr
2.3.5 Client_Enroll_Status_STG.kjb
2.3.6 CDC_SELECTION_TXN_1.ktr
2.3.7 CDC_SELECTION_TXN_2.ktr
2.3.8 Selection_txn_STG.kjb
2.3.9 CDC_CLIENT_ELIG_STATUS_1.ktr
2.3.10 CDC_CLIENT_ELIG_STATUS_2.ktr
2.3.11 Client_Elig_Status_STG.kjb
2.3.12 CDC_COST_SHARE_DTLS_1.ktr
2.3.13 CDC_COST_SHARE_DTLS_2.ktr
2.3.14 Cost_Share_Details_STG.kjb
2.3.15 Run_Initialization.kjb
2.3.16 ManageEnrl_Run_Initialization.kjb
2.3.17 Run_onetime_RUN_INIT_KJB.sh
2.3.18 tx_run_bpm.sh
2.3.19 Run_onetime_ManageEnrl.sh
2.3.20 CUTOFF_CALENDAR_STG.ktr


3. Run the below in Maxdat Database (TXEBMXDU/TXEBMXDP).

   3.1 execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;

   3.2 Download the following files 
       from svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DB_MEA_20130829_RAJ_1
	   or 
	   from svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/ManageEnrollmentActivity/createdb 
	   
       and run them in Maxdat Database in the same order as below.

       If any script fails then stop and let the Developer, (Raj A.) know.  

	 1. create_ETL_ManageEnroll_tables.sql
 	 2. create_ETL_ManageEnroll_sequences.sql
	 3. create_ETL_ManageEnroll_indexes.sql
	 4. populate_CORP_ETL_CONTROL
	 5. populate_CORP_ETL_LIST_LKUP
	 6. populate_RULE_LKUP_MNG_ENRL_FOLLOWUP
	 7. populate_RULE_LKUP_MNG_ENRL_SLA
	 8. populate_RULE_LKUP_MNG_ENRL_PACKET
	 9. SemanticModel_ManageEnrollment.sql
	 10. create_ETL_ManageEnroll_triggers.sql
	 11. populate_lkup_tables.sql
	 12. populate_BPM_EVENT_MASTER.sql
	 13. populate_BPM_ATTRIBUTE_LKUP.sql
	 14. populate_BPM_ATTRIBUTE.sql
	 15. populate_BPM_ATTRIBUTE_STAGING_TABLE.sql
	 16. MANAGE_ENROLL_pkg.sql
     17. BPM_EVENT_PROJECT_pkg_body.sql
     18. BPM_SEMANTIC_PROJECT_pkg_body.sql
     19. create_ETL_ManageEnroll_grants_public_syn.sql 

    3.3 execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
             
4. Run dos2unix for the following /u25/ETL_Scripts/UAT/scripts/Run_onetime_RUN_INIT_KJB.sh
   dos2unix -o Run_onetime_RUN_INIT_KJB.sh  
   chmod 755 Run_onetime_RUN_INIT_KJB.sh
     
   Run it now.

5. Run dos2unix for the following /u25/ETL_Scripts/UAT/scripts/Run_onetime_ManageEnrl.sh
   dos2unix -o Run_onetime_ManageEnrl.sh  
   chmod 755 Run_onetime_ManageEnrl.sh   
      
   Run it now.    

6. Download from svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ManageEnrollmentActivity/createdb/ManageEnrl_AFTER_ONE_TIME_RUN.sql
   and run it in Maxdat Database (TXEBMXDU/TXEBMXDP).

7. Turn on tx_run_bpm.sh cron job
 	
--------------------------------------------------------------------