***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 03/31/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/03/25 A. Antonio          916.832-8644  Client Outreach - fixed get variable ktr to get the last outreach id from 
					     control table only so that it will be possible to run for a range of outreach ids.
2014/03/25 A. Antonio          916.832-8644  EMRS - error logging changes 
2014/03/31 Sumi		       916.425-6258  Support Client Inquiry insert to corp_etl_list_lkup
2014/03/31 M.Bhalekar          201.328.5695  Process Letters - Created db script to copy wip_bpm to wip_t table, Convert insert statement to use forall.
                                                             - Modified upd11- changed error log, corrected update field. 

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_emrs.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;	

     *******************************************************************************************	
       ( Sumi - Support Client Inquiry)
        ------------------------------------------------------------------------------------
	** Unzip DB_SupportClientInquiry_20140331_Sumi_1.zip
        ** Run in the order specified below.

        20140331_1030_TX_SCI_insert_prgm_info_corp_etl_list_lkup.sql
        
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************
 
        *******************************************************************************************	
         M.Bhalekar(Process Letters)
        ------------------------------------------------------------------------------------
	** Unzip DB_ProcessLetters_20140317_Mayuresh_2.zip
        ** Run in the order specified below.

        ETL_PROCESS_LETTERS_PKG.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************

execute MAXDAT_ADMIN.STARTUP_JOBS;

        
-----------------------
2. KETTLE FILES SECTION
-----------------------


      *******************************************************************************************	
         Arlene Antonio (Client Outreach)
	--------------------------------------------------------------------
	Download AS_ClientOutreach_20140325_Arlene_12.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

	Client_Outreach_Get_CntrlVariable.ktr
	ClientOUtreach_JobRun_var.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

	*******************************************************************************************	
        A. Antonio (EMRS)
	--------------------------------------------------------------------
	Download AS_EMRS_201403025_ARLENE_46.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS  

	
	DIM_Load_AA_CLIENT.ktr
	DIM_Load_AA_CONTRACT.ktr
	DIM_Load_AA_COUNTYCONTRACT.ktr
	DIM_Load_ADDRESS.ktr
	DIM_Load_ALERTS.ktr
	DIM_Load_CASES.ktr
	DIM_Load_CITIZENSHIP_STATUS.ktr
	DIM_Load_CLIENTS.ktr
	DIM_Load_CLIENT_ENRL_STATUS.ktr
	DIM_Load_DAILY_CASE_REF.ktr
	DIM_Load_DAILY_CLIENT_REF.ktr
	DIM_Load_DAILY_PROVIDER_REF.ktr
	DIM_Load_ENROLLMENT_ERROR_CODE.ktr
	DIM_Load_ENROLLMENT_STATUS.ktr
	DIM_Load_ENROLL_ACTION_STATUS.ktr
	DIM_Load_LANGUAGES.ktr
	DIM_Load_PLAN_PERCENTAGE.ktr
	DIM_Load_PROGRAMS.ktr
	DIM_Load_PROVIDERS.ktr
	DIM_Load_PROVIDER_SPECIALTY.ktr
	DIM_Load_SELECTION_MISSING_INFO.ktr
	DIM_Load_SELECTION_SOURCES.ktr
	DIM_Load_SELECTION_STATUS.ktr
	DIM_Load_SELECTION_TRANSACTION.ktr
	DIM_Load_SELECTION_TRANSACTION_HISTORY.ktr
	DIM_Upd_CASES.ktr
	DIM_Upd_CLIENTS.ktr
	DIM_Upd_PREV_CASES.ktr
	DIM_Upd_PREV_CLIENTS.ktr
	DIM_Upd_PREV_CLIENT_ELIGIBILITY.ktr
	DIM_Upd_PREV_CLIENT_ENRL_STATUS.ktr
	DIM_Upd_PREV_PROVIDERS.ktr
	DIM_Upd_PROVIDERS.ktr
	EMRS_set_global_variables.ktr
	ETL_Enrollment.kjb
	FACT_Compare_ENROLLMENTS.ktr
	FACT_Load_ENROLLMENTS.ktr
	STG_Compare_CASES.ktr
	STG_Compare_CLIENTS.ktr
	STG_Compare_PROVIDERS.ktr
	STG_Load_S_CLIENT_STATUS.ktr
	DIM_Load_CLIENT_ELIGIBILITY.ktr
	STG_Load_S_CLIENT_ELIGIBILITY.ktr
	DIM_Load_ENROLLMENT_REJECTIONS.ktr
	DIM_Load_NOTIFICATIONS_CHIP.ktr
	DIM_Load_NOTIFICATIONS_PERI.ktr
	DIM_Load_NOTIFICATIONS.ktr
	FACT_Upd_ENROLL_COST_SHARE.ktr
	STG_Load_S_COST_SHARE.ktr
	STG_Load_S_ENROLLMENTS.ktr
	STG_Load_S_CASES.ktr
	STG_Load_S_CLIENTS.ktr
	STG_Load_S_PROVIDERS.ktr
	DIM_Load_ZIPCODES.ktr
	DIM_Load_CARE_SERV_DELIV_AREAS.ktr
	DIM_Load_FEDERAL_POVERTY_LVLS.ktr
	DIM_Load_COUNTIES.ktr
	DIM_Load_PLANS.ktr
	DIM_Load_PROVIDER_TYPES.ktr
	DIM_Load_PROVIDER_SPECIALTY_CODE.ktr
	DIM_Load_PLAN_TYPES.ktr
	DIM_Load_RACES.ktr
	DIM_Load_SELECTION_REASONS.ktr
	DIM_Load_TERMINATION_REASONS.ktr
	DIM_Load_REJECTION_REASONS.ktr
	DIM_Load_CHANGE_REASONS.ktr
	DIM_Load_RISK_GROUPS.ktr
	DIM_Load_STATUS_IN_GROUPS.ktr
	DIM_Load_COVERAGE_CATEGORIES.ktr
	DIM_Load_AID_CATEGORIES.ktr
	DIM_Load_SUB_PROGRAMS.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

       *******************************************************************************************	
        M. Bhalekar (Process Letters)
	--------------------------------------------------------------------
	Download AS_ProcessLetters_20140324_Mayuresh_2.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessLetters
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessLetters 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessLetters

	Process_Letters_updates.kjb
	ProcessLetters_temp_wip_to_wip_t.ktr
        ProcessLetters_update11.ktr

	--------------------------------------------------------------------
       *******************************************************************************************


-----------------------
3. UNIX SCRIPT SECTION
-----------------------
 No  changes	
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

       *******************************************************************************************	
       A. Antonio (EMRS)
        --------------------------------------------------------------------------------------------
	--Execute tx_emrs_load_enrl_adhoc_medicaid.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_enrl_adhoc_medicaid.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_enrl_adhoc_medicaid.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_enrl_adhoc_medicaid.sh &
	--------------------------------------------------------------------------------------------
       *******************************************************************************************

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
  
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_emrs.sh
