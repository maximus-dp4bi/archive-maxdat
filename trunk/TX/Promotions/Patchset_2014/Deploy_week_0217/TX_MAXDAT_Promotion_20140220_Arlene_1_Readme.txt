***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 02/20/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/02/14 A. Antonio          916.832-8644  Process Letters :use pl/sql procedure to load temp tables.
					     Client outreach performance tuning
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh

-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;	

 
       *******************************************************************************************	
        A.Antonio(Process Letters)
        ------------------------------------------------------------------------------------
	** Unzip DB_ProcessLetters_20140214_Arlene_1.zip
        ** Run in the order specified below.

        1. ETL_PROCESS_LETTERS_PKG.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************


execute MAXDAT_ADMIN.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------


      *******************************************************************************************	
        A. Antonio Process Letters
	--------------------------------------------------------------------
	Download AS_ProcessLetters_20140214_Arlene_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessLetters
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessLetters 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessLetters 

	ProcessLetters_copy_to_temp.ktr
	--------------------------------------------------------------------

       *******************************************************************************************	
         Arlene Antonio (Client Outreach)
	--------------------------------------------------------------------
	Download AS_ClientOutreach_20140214_Arlene_7.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

	Client_Outreach_EVENTS_UPD.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

----------------------------
3. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
