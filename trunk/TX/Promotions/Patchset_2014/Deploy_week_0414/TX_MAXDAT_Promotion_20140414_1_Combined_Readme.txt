***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 04/14/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/04/10 A. Antonio          916.832.8644  EMRS - To load medicaid selection segments in batches.
			        	     Performance tuning for one time CSI stage load
2014/04/11 B. Thai             210-722-3895  Step Instance Stage load daily auto-correction with OLTP
                                             attributes of PROCESS_ID and PROCESS_INSTANCE_ID for MFD.
2014/04/11 Raj A.              361-228-5588  Deploy ktr that uses CSI staged table in MAXDAT instead of oltp table. 
					     This ktr fetches client related info. 

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_contcent.sh
Disable cron - cron_tx_run_emrs.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;	

       *******************************************************************************************	
        B.Thai (Run Init)
        ------------------------------------------------------------------------------------
	** Unzip DB_RunInit_20140404_Brian_1.zip
        ** Run in the order specified below.

        20140402_1625_alter_STEP_INSTANCE_STG.sql
        20140403_0854_Run_Init_Ins_Upd_Controls.sql
        20140326_1321_MW_del_non_human_tasks.sql


	** Last record deletion script will take an hour or so to complete.
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************
      
execute MAXDAT_ADMIN.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------
	*******************************************************************************************	
        A. Antonio (EMRS)
	--------------------------------------------------------------------
	Download AS_EMRS_20140410_ARLENE_47.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS  
	
	ETL_Load_MEDICAID_Enroll_By_Range.kjb
	STG_Read_MEDICAID_Enroll_Counts.ktr
	STG_Update_MEDICAID_Enroll_Counts.ktr
	STG_Load_MEDICAID_Enroll_Variables.ktr
	ETL_Load_Enrollment_Fact_MEDICAID_Adhoc.kjb
	STG_Load_S_MED_ENROLL_adhoc_insupd.ktr
	EMRS_Adhoc_JobRun_var.ktr
	STG_Load_S_ENROLLMENTS_MEDICAID_adhoc.ktr

	--------------------------------------------------------------------
       *******************************************************************************************	

       *******************************************************************************************	
         A. Antonio (Run Initialization)
	--------------------------------------------------------------------
	Download AS_ClientSupplInfo_20140411_Arlene_3.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

	Upd_ClientSupplementaryInfo_Var.ktr
	Load_Client_Supplementary_Info_Stg.ktr
	Load_Client_Supplementary_Info_Stg_Onetime.ktr	
	--------------------------------------------------------------------
       *******************************************************************************************

       *******************************************************************************************	
        B. Thai (Run Init)
	--------------------------------------------------------------------
	Download AS_RunInit_20140404_Brian_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

	Load_Step_Instance_Stg.kjb
	ManageWork_Capture_OLTP.ktr
	ManageWork_Get_Variables.ktr
	step_instance_stg_dbl_chk.ktr
	StepInstanceStg_Correct_Chk_Run.ktr
	StepInstanceStg_Correct_Set_Range.ktr
	StepInstanceStg_Daily_Correction.kjb
	--------------------------------------------------------------------
       *******************************************************************************************	

       *******************************************************************************************	
        Raj A. (Manage Enrollment Activity)
	--------------------------------------------------------------------
	Download AS_MEA_20140414_RAJ_7.zip
        Deploy the following files to the appropriate path
	UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity
	ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity
	PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity


        ManageEnroll_Insert_Instances.ktr
	--------------------------------------------------------------------
       *******************************************************************************************
-----------------------
3. UNIX SCRIPT SECTION
-----------------------
	*******************************************************************************************	
	A. Antonio (EMRS)
	--------------------------------------------------------------------
       DOwnload AS_EMRS_20140410_ARLENE_48.zip 

	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

		tx_emrs_load_enrl_adhoc_medicaid.sh
		cron_tx_run_emrs_medenrl.sh

	Run dos2unix for the following List 
		tx_emrs_load_enrl_adhoc_medicaid.sh
		cron_tx_run_emrs_medenrl.sh

	chmod 755 tx_emrs_load_enrl_adhoc_medicaid.sh
	chmod 755 cron_tx_run_emrs_medenrl.sh

	--------------------------------------------------------------------
       *******************************************************************************************
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
       *******************************************************************************************	
         A. Antonio (Run Initialization)
	--------------------------------------------------------------------	
	--Execute Run_onetime_ClientSupplInfo_Stg.sh which will populate the new Client_Supplementary_Info_Stg table
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/Run_onetime_ClientSupplInfo_Stg.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/Run_onetime_ClientSupplInfo_Stg.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/Run_onetime_ClientSupplInfo_Stg.sh &
	--------------------------------------------------------------------
       *******************************************************************************************


----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.

	*******************************************************************************************	
	A. Antonio (EMRS)
	--------------------------------------------------------------------
	Files can be found in  AS_EMRS_20140410_ARLENE_48.zip which was previously downloaded

	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/3rdparty/cron_files 
	  ProdSupp DEPLOY TO PATH ttxe4t/3rdparty/cron_files 
	  PROD     DEPLOY TO PATH ptxe4t/3rdparty/cron_files 

		cron_tx_run_emrs_medenrl.sh


	Run dos2unix for the following List 
		cron_tx_run_emrs_medenrl.sh

	chmod 755 cron_tx_run_emrs_medenrl.sh

       -- Update crontab per cronsetup.txt

----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
Enable cron - cron_tx_run_emrs_medenrl.sh
