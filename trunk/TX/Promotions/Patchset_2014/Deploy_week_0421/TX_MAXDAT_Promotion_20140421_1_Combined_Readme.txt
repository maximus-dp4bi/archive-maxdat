***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 04/21/2014
----------------
Date       Developer           PHONE         Jira      Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/04/18 Brian Thai          210-722-3895  TXEB-2523 Manage Work- Remove SLA calc on ETL
2014/04/18 A. Antonio	       916-832-8644  TXEB-2521 Modified Client Outreach to use the CSI stage table.
2014/04/21 Raj A.              361-228-5588  TXEB-2519 MEA: Moved Fetch New instances ktr to an ETL package.
2014/04/21 A. Antonio	       916-832-8644  TXEB-2520 EMRS - Run one time script to synch CHIP enrollments with EB.
EMERGENCY 4/22 -2014/04/21 Sara		       571-294-6487  TXEB-2507 EB Contact Center: Forecasts failed to load
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_contcent.sh
Disable cron - cron_tx_run_emrs.sh
Disable cron - cron_tx_run_emrs_medenrl.sh

-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;	

       *******************************************************************************************	
        B. Thai (Manage Work)
        ------------------------------------------------------------------------------------
	** Unzip DB_ManageWork_20140418_Brian_1.zip
        ** Run in the order specified below.

        CORP_ETL_STAGE_pkg.sql
        create_ETL_initialize_triggers.sql
        CORP_ETL_MANAGE_WORK_pkg.sql
        20140417_1636_recompile_MW_STEP_INSTANCE_VW.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	        
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        B. Thai (Manage Work)
	--------------------------------------------------------------------
	Download AS_ManageWork_20140418_Brian_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ManageWork 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ManageWork
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ManageWork 

	ManageWork_RUNALL.kjb
	ManageWork_Save_Variables.ktr
	--------------------------------------------------------------------
       *******************************************************************************************	

       *******************************************************************************************	
         Arlene Antonio (Client Outreach)
	--------------------------------------------------------------------
	Download AS_ClientOutreach_20140418_Arlene_14.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

	ClientOutreach_OLTP_details.kjb
	Client_Outreach_get_OLTP_Program.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

      *******************************************************************************************	
         Raj A. (Manage Enrollment Activity)
	--------------------------------------------------------------------
	Download AS_ManageEnroll_20140421_Raj_8
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity

	ManageEnroll_Insert_Instances.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
----------------------
        DONE*******************************************************************************************	
	DONESara (Contact Center) 
	DONE--------------------------------------------------------------------
        DONEDOwnload AS_ContactCenter_20140421_Sara_1.zip 
	DONEDeploy the follow files to the appropriate path
	DONE  PROD     DEPLOY TO PATH ptxe4t/etl_scripts/cron_files
	DONE  PROD     DEPLOY TO PATH ptxe4t/etl_scripts/scripts/ContactCenter/main/bin
	DONE  cron_tx_run_contcent_forecast.sh
	DONEchmod 755 cron_tx_run_contcent_forecast.sh
	DONE--------------------------------------------------------------------
        DONE*******************************************************************************************
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
	*******************************************************************************************	
	A. Antonio (EMRS)
	--------------------------------------------------------------------
	--Execute tx_emrs_load_enrl_adhoc_chip.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_enrl_adhoc_chip.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_enrl_adhoc_chip.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_enrl_adhoc_chip.sh &	
	--------------------------------------------------------------------
       *******************************************************************************************	

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.


----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
Enable cron - cron_tx_run_emrs_medenrl.sh
