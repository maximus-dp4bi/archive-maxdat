***** MODIFICATION HISTORY ****************************************************************************
Instructions for Client Outreach initial deployment and adhoc run
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/01/22 A. Antonio   916-832-8644   	     Modified queries for the update rules to see if the process will go through


***** MODIFICATION HISTORY ****************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT


execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;	

       *******************************************************************************************	
        Mayuresh Bhalekar (Client Outreach)
        ------------------------------------------------------------------------------------
	** Unzip DB_ClientOutreach_20140122_Arlene_2.zip
        ** Run in the order specified below.

        1.20140121_1317_upd_timeliness_tab.sql
	2.20140122_1734_alter_outreach_events_tab.sql
	3.ETL_COMMON_pkg.sql
	4.CLIENT_OUTREACH_pkg.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************

execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
         Mayuresh Bhalekar (Client Outreach)
	--------------------------------------------------------------------
	Download AS_ClientOutreach_20140122_Arlene_2.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

	Client_Outreach_UPD3.ktr
	Client_Outreach_UPD4.ktr
	Client_Outreach_UPD6.ktr
	Client_Outreach_UPD8.ktr
	Client_Outreach_UPD10.ktr
	Client_Outreach_UPD12.ktr
	Client_Outreach_UPD14.ktr
	Client_Outreach_UPD16.ktr
	Client_Outreach_UPD17.ktr
	Client_Outreach_UPD18.ktr
	Client_Outreach_UPD21.ktr
	Client_Outreach_UPD24.ktr
	Client_Outreach_INS2.ktr
	Client_Outreach_get_OLTP_Validation.ktr

	--------------------------------------------------------------------
       *******************************************************************************************

----------------------------
3. ADHOC SH SCRIPT SECTION
----------------------------
       *******************************************************************************************	
       
        --Execute tx_run_bpm_ClnO.sh which will populate the Client outreach ETL staging
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_run_bpm_ClnO.sh &
	--------------------------------------------------------------------------------------------
       *******************************************************************************************	
