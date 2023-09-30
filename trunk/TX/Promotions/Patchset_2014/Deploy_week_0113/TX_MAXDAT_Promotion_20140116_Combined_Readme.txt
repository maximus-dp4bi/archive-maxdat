***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 01/13/2013
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/01/10 Raj A.                            Deploy performance improved ktr, ProcessLetters_temp_to_WIP_T.ktr
2014/01/13 A. Antonio   916-832-8644   	     Various modifications to process the status history for each record
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_bpm_let.sh

-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;	

        Mayuresh Bhalekar (Client Outreach)
        ------------------------------------------------------------------------------------
	** Unzip DB_ClientOutreach_20140113_Arlene_1.zip
        ** Run in the order specified below.

        1.truncate_Client_Outreach_etl_tables.sql
	2.20140107_1706_alter_clnt_outreach_tabs.sql
	
        
        ------------------------------------------------------------------------------------


execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

        Raj         (Letters)
        --------------------------------------------------------------------
	Download AS_PL_CODE_TUNING_20140110_RAJ_3
	Deploy the following files to the appropriate path
	UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessLetters
	ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessLetters
	PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessLetters

	ProcessLetters_temp_to_WIP_T.ktr	
	--------------------------------------------------------------------
	    
	    Mayuresh Bhalekar (Client Outreach)
	--------------------------------------------------------------------
		Download AS_ClientOutreach_20140113_Arlene_1.zip
		Deploy the follow files to the appropriate path
		  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach
		  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
		  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach
	
		Client_Outreach_UPD25.ktr
		Client_Outreach_UPD20.ktr
		Client_Outreach_UPD19.ktr
		Client_Outreach_UPD15.ktr
		Client_Outreach_UPD13.ktr
		Client_Outreach_UPD11.ktr
		Client_Outreach_UPD9.ktr
		Client_Outreach_UPD7.ktr
		Client_Outreach_UPD5.ktr
		Client_Outreach_UPD3.ktr
		Client_Outreach_UPD2.ktr
		Client_Outreach_UPD1.ktr
		Client_Outreach_get_OLTP_Surveys.ktr
		Client_Outreach_get_OLTP_Validation.ktr
		Client_Outreach_get_OLTP_Inc_Header.ktr
		Client_Outreach_get_OLTP_Program.ktr
		Client_Outreach_get_OLTP_Human_Task.ktr
		Client_Outreach_get_OLTP_Step_Inst.ktr
		Client_Outreach_UPD_BPM_Main.ktr
		Client_Outreach_UPD21.ktr
		Client_Outreach_UPD24.ktr
		ClientOutreach_Updates.kjb
		Client_Outreach_UPD14.ktr
		Client_Outreach_UPD12.ktr
		Client_Outreach_UPD10.ktr
		Client_Outreach_UPD8.ktr
		Client_Outreach_UPD6.ktr
		Client_Outreach_UPD4.ktr
		Client_Outreach_UPD16.ktr
		Client_Outreach_UPD18.ktr
		Client_Outreach_UPD17.ktr
		Client_Outreach_copy_TEMP.ktr
		Client_Outreach_fetch_OLTP.kjb
		ClientOutreach_OLTP_details.kjb
		Client_Outreach_GetOLTP_SUBPROG_TMP.ktr
		Client_Outreach_env_var.ktr
		Client_Outreach_INS2.ktr
		Client_Outreach_INS1.ktr
	
	---------------------------------------------------------------------

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
       *******************************************************************************************	
No changes
	
       *******************************************************************************************			
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
	--------------------------------------------------------------------------------------------        
        --Execute tx_run_bpm_ClnO.sh which will populate the Client outreach ETL staging
	PROD            nohup /dtxe4t/ETL_Scripts/scripts/tx_run_bpm_ClnO.sh &
	--------------------------------------------------------------------------------------------	
----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_let.sh
