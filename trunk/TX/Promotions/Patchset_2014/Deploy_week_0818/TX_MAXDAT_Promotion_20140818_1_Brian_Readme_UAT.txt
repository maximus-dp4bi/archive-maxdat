***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 08/18/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/08/18 Brian Thai          916.8844.5812 TXEB-2649 Client Outreach new CPW and call attributes
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
	** Unzip DB_20140818_CO_Brian_1.zip
        ** Run in the order specified below.

        20140807_0839_alter_CO_tabs_views
        20140807_1114_recompile_OC_triggers
        20140812_0912_CO_insert_survey_lkup
        ETL_CLIENT_OUTREACH_PKG
        CLIENT_OUTREACH_pkg
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	        



execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        (Developer create this block for each AS zip)
	--------------------------------------------------------------------
	Download AS_20140818_CO_Brian_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach

	Client_Outreach_copy_TEMP.ktr
	Client_Outreach_EVENTS_UPD.ktr
	Client_Outreach_get_OLTP_Surveys.ktr
	Client_Outreach_INS2.ktr
	ClientOutreach_Updates.kjb

	--------------------------------------------------------------------
       *******************************************************************************************	


-----------------------
3. UNIX SCRIPT SECTION
-----------------------
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.


     Schedule EMRS Load Medicaid Selection segments cron job
        -- cron_tx_run_emrs_medenrl.sh is in AS_EMRS_20140410_ARLENE_48.zip
	
	-- Schedule cron_tx_run_emrs_medenrl.sh per cronsetup.txt

----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
Enable cron - cron_tx_run_emrs_medenrl.sh
