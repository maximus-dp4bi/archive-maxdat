***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 11/18/2013
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2013/11/23 Devin Heimbuch      916.8844.5812 Sample 

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
        (Developer create this block for each DB zip)
        ------------------------------------------------------------------------------------
	** Unzip DB_{SYSTEM}_{YYMMDD}20131118_{DEVELOPER_NAME}_{NUM}.zip
        ** Run in the order specified below.

        File1.sql
        File2.sql
        File3.sql
        etc
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	        



execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

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
       *******************************************************************************************	
        (Developer create this block for each AS zip)
        --------------------------------------------------------------------
	Download AS_{SYSTEM}_{YYMMDD}20131118_{DEVELOPER_NAME}_{NUM}.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

	file1.sh
	file2.sh
	file3.sh
	etc
	
	**Run dos2unix for the following List
	dos2unix file1.sh
	dos2unix file2.sh
	dos2unix file3.sh
	etc
	
	** chmod 755
	chmod 755 file1.sh
	chmod 755 file2.sh
	chmod 755 file3.sh
	etc
	--------------------------------------------------------------------
       *******************************************************************************************			
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
       *******************************************************************************************	
       (Developer create this block AS NEEDED)
        --------------------------------------------------------------------------------------------
        --Execute tx_emrs_load_aaclient_onetime.sh which will populate the new EMRS AA_CLIENt table
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_aaclient_onetime.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_aaclient_onetime.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_aaclient_onetime.sh &
	--------------------------------------------------------------------------------------------
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
