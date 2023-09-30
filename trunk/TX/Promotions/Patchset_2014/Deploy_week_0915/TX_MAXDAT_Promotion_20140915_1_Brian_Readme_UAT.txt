***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 09/15/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/09/11 Brian Thai          210-722-3895  TXEB-2649 Client Outreach one-time event extract from OLTP
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
        B.Thai (Client Outreach one-time event extract)
        --------------------------------------------------------------------
	** Unzip DB_20140915_CO_Brian_1.zip
        ** Run in the order specified below.

        20140910_0753_CO_create_temp_tab.sql

	--------------------------------------------------------------------
       *******************************************************************************************	

execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        B.Thai (Client Outreach one-time event extract)
        --------------------------------------------------------------------
	Download AS_20140915_CO_Brian_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts

        Onetime_ClientOutreach_CPW_Pop_Temp.ktr

	--------------------------------------------------------------------
       *******************************************************************************************	


-----------------------
3. UNIX SCRIPT SECTION
-----------------------

       *******************************************************************************************	
        B.Thai (Client Outreach one-time event extract)
        --------------------------------------------------------------------
	Download AS_20140915_CO_Brian_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts

        Onetime_ClientOutreach_CPW_Call_Update.sh
	
	**Run dos2unix for the following List
	dos2unix Onetime_ClientOutreach_CPW_Call_Update.sh Onetime_ClientOutreach_CPW_Call_Update.sh

	--------------------------------------------------------------------
       *******************************************************************************************	
	
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
       *******************************************************************************************	
       B.Thai (Client Outreach one-time shell)
        --------------------------------------------------------------------------------------------
        --Execute Onetime_ClientOutreach_CPW_Call_Update.sh which updated CLient Outreach new attribute values
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/Onetime_ClientOutreach_CPW_Call_Update.sh &
	--------------------------------------------------------------------------------------------
       *******************************************************************************************	

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------

----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
Enable cron - cron_tx_run_emrs_medenrl.sh
