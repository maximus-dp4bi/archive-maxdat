***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 11/18/2013
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/03/03 A. Antonio          916-832-8644  Client Outreach - Use range of Outreach IDs to process the updates
2014/03/03 A. Antonio          916-832-8644  EMRS - Extract missing providers and selection transactions.
					     EMRS - Load the rest of CHIP notifications

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
        Arlene Antonio (Client Outreach)
        ------------------------------------------------------------------------------------
	** Unzip DB_ClientOutreach_20140303_Arlene_4.zip
        ** Run in the order specified below.

        1.20140304_1320_ins_corp_etl_control_min_max_coid.sqll
	        
        ------------------------------------------------------------------------------------
       *******************************************************************************************

	*******************************************************************************************	
        A. Antonio (EMRS)
        ------------------------------------------------------------------------------------
	** Unzip DB_EMRS_20140303_ARLENE_26.zip
        ** Run in the order specified below.

	20140303_1658_ins_emrs_run_date_control.sql
	        
        ------------------------------------------------------------------------------------
       *******************************************************************************************



execute MAXDAT_ADMIN.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------
      *******************************************************************************************	
         Arlene Antonio (Client Outreach)
	--------------------------------------------------------------------
	Download AS_ClientOutreach_20140303_Arlene_9.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

	Client_Outreach_copy_TEMP.ktr
	Client_Outreach_Get_CntrlVariable.ktr
	Client_Outreach_EVENTS_UPD.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

	*******************************************************************************************	
        A. Antonio (EMRS)
	--------------------------------------------------------------------
	Download AS_EMRS_20140303_ARLENE_42.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS  

	
	DIM_Load_SELECTION_MISSING_INFO_ADHOC.ktr
	DIM_Load_SELECTION_TRANSACTION_ADHOC.ktr
	DIM_Load_SELECTION_TRANSACTION_HIST_ADHOC.ktr	
	EMRS_set_adhoc_run_date.ktr
	ETL_Load_Selection_Transactions_Adhoc.kjb
	ETL_Load_Notifications_OneTime.kjb
	--------------------------------------------------------------------
       *******************************************************************************************



-----------------------
3. UNIX SCRIPT SECTION
-----------------------
None                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------


	*******************************************************************************************	
	A. Antonio (EMRS)
	--------------------------------------------------------------------
       DOwnload AS_EMRS_20140303_ARLENE_43.zip 

	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

		tx_emrs_load_selections_adhoc.sh


	Run dos2unix for the following List 
		tx_emrs_load_selections_adhoc.sh

	chmod 755 tx_emrs_load_selections_adhoc.sh


	--Execute tx_emrs_load_chip_provider_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_provider_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_provider_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_provider_adhoc.sh &

	--Execute tx_emrs_load_selections_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_selections_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_selections_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_selections_adhoc.sh &


	--Execute tx_emrs_load_notifications_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &

	--------------------------------------------------------------------
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
