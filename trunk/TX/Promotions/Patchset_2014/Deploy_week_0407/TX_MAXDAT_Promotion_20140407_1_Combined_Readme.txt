***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 04/07/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/04/04 D. Dillon          512-757-4558  Packaged to re-promote.  Never made it to Prod
2014/04/07 A. Antonio	      916-832-8644   Modified to use STEP_INSTANCE_STG instead of going to the source.
					     Modified to update ASED_OUTREACH_STEP* fields only when 
					     the calculated end date is not null.
					     Added new stage table to Run Initialization - Client_Supplementary_Info_Stg.

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

execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;	

 
       *******************************************************************************************	
        D.Dillon Maxdat Statistics
        ------------------------------------------------------------------------------------
	** Unzip DB_MAXDAT_STATISTICS_20140401_Dave_1.zip
        ** Run in the order specified below.

        1. GATHER_STATS_TABLE_CONFIG.sql
	2. populate_GATHER_STATS_TABLE_CONFIG.sql
	3. MAXDAT_STATISTICS_pkg.sql

	** Execute the following in SQL:
	execute maxdat_statistics.create_stats_job;
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************

       *******************************************************************************************	
        A. Antonio (Run Initialization)
        ------------------------------------------------------------------------------------
	** Unzip DB_ClientSupplInfo_20140403_Arlene_1.zip
        ** Run in the order specified below.

        20140402_1720_create_Client_Suppl_Info_Stg.sql
	       
        ------------------------------------------------------------------------------------
       *******************************************************************************************

execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------
      *******************************************************************************************	
         Arlene Antonio (Client Outreach)
	--------------------------------------------------------------------
	Download AS_ClientOutreach_20140407_Arlene_13.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

	Client_Outreach_UPD6.ktr
	Client_Outreach_UPD8.ktr
	Client_Outreach_UPD10.ktr
	Client_Outreach_UPD12.ktr
	Client_Outreach_UPD14.ktr
	Client_Outreach_get_OLTP_Human_Task.ktr
	Client_Outreach_fetch_OLTP.kjb
	--------------------------------------------------------------------
       *******************************************************************************************


      *******************************************************************************************	
         A. Antonio (Run Initialization)
	--------------------------------------------------------------------
	Download AS_ClientSupplInfo_20140403_Arlene_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

	Client_Supplementary_Info_Stg.kjb
	Upd_ClientSupplementaryInfo_Var.ktr
	Load_Client_Supplementary_Info_Stg.ktr
	Load_Client_Supplementary_Info_Stg_Onetime.ktr	
	--------------------------------------------------------------------
       *******************************************************************************************


       *******************************************************************************************	
        (Developer create this block for each AS zip)
	--------------------------------------------------------------------
	Download AS_{SYSTEM}_{YYMMDD}20131118_{DEVELOPER_NAME}_{NUM}.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/{Your Direcortory} 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/{Your Direcortory} 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/{Your Direcortory} 

	file1.ktr
	file2.kjb
	file3.ktr
	etc
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
         A. Antonio (Run Initialization)
	--------------------------------------------------------------------
	Download AS_ClientSupplInfo_20140407_Arlene_2.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

	Run_onetime_ClientSupplInfo_Stg.sh
	
	**Run dos2unix for the following List
	Run_onetime_ClientSupplInfo_Stg.sh
	
	** chmod 755
	chmod 755 Run_onetime_ClientSupplInfo_Stg.sh

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

----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
