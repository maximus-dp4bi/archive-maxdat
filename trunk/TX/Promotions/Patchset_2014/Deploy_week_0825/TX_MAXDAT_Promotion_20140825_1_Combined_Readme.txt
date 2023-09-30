***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 08/18/2014
----------------
Date       Developer           PHONE         Jira           Reason/Description
---------- ------------------- ------------  -----------    ---------------------------------------------
2014/08/18 Austin Baker        843-259-1955  MAXDAT - 1612  MAXDAT - exporting data to AMP to correct unknown program/project records
2014/08/18 Brian Thai          916.8844.5812 TXEB-2649 Client Outreach new CPW and call attributes

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_bpm_daily.sh
Disable cron - cron_tx_run_contcent.sh
Disable cron - cron_tx_run_emrs.sh
Disable cron - cron_tx_run_emrs_medenrl.sh
Disable cron - manage_scheduled_contact_center_jobs.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;

       *******************************************************************************************	
        B.Thai (Client Outreach new CPW/call attributes)
        ------------------------------------------------------------------------------------
	** Unzip DB_20140825_CO_Brian_1.zip
        ** Run in the order specified below.

        20140807_0839_alter_CO_tabs_views.sql
        20140807_1114_recompile_OC_triggers.sql
        20140812_0912_CO_insert_survey_lkup.sql
        ETL_CLIENT_OUTREACH_PKG.sql
        CLIENT_OUTREACH_pkg.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	        
 
execute MAXDAT_ADMIN.STARTUP_JOBS;

-----------------------
2. KETTLE FILES SECTION
-----------------------

     *******************************************************************************************
              Austin (Contact Center)
     -------------------------------------------------------------------------------------------
    	Download AS_CC_20140818_Austin_1.zip
	Deploy the following files to the appropriate path
	  PRD      DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/ 
	  PRODSUPP DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/

		flatten_CC_F_AGENT_BY_DATE.ktr
	  
	  PRD      DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/utility/
	  PRODSUPP DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/utility/

		get_missing_file_dates.ktr

    -------------------------------------------------------------------------------------------
    *******************************************************************************************

       *******************************************************************************************	
        B.Thai (Client Outreach new CPW/call attributes)
	--------------------------------------------------------------------
	Download AS_20140825_CO_Brian_1.zip
	Deploy the follow files to the appropriate path
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

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
       
       *******************************************************************************************	
        B.Thai (Client Outreach one-time shell)
        --------------------------------------------------------------------
	Download AS_20140825_CO_Brian_2.zip
	Deploy the follow files to the appropriate path
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/

        Onetime_ClientOutreach_CPW_Call_Update.ktr
        Onetime_ClientOutreach_CPW_Call_Update.sh
	
	**Run dos2unix for the following List
	dos2unix Onetime_ClientOutreach_CPW_Call_Update.sh
	
	** chmod 755
	chmod 755 Onetime_ClientOutreach_CPW_Call_Update.sh
	--------------------------------------------------------------------
       *******************************************************************************************			
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
       
       *******************************************************************************************	
              Austin (Contact Center)
       -------------------------------------------------------------------------------------------
		- execute the following to run an instance of exporting data to AMP
		PRD		nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_flatten_contact_center.sh 2014/03/31 2014/04/04 &
		PRD		nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_flatten_contact_center.sh 2014/06/19 2014/06/20 &
		PRD		nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_flatten_contact_center.sh 2014/06/23 2014/06/27 &
		PRD		nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_flatten_contact_center.sh 2014/07/07 2014/07/11 &
		PRD		nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_flatten_contact_center.sh 2014/07/14 2014/07/16 &
       	
       -------------------------------------------------------------------------------------------
       *******************************************************************************************

       *******************************************************************************************	
       B.Thai (Client Outreach one-time shell)
        --------------------------------------------------------------------------------------------
        --Execute Onetime_ClientOutreach_CPW_Call_Update.sh which updated CLient Outreach new attribute values
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/Onetime_ClientOutreach_CPW_Call_Update.sh &
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/Onetime_ClientOutreach_CPW_Call_Update.sh &
	--------------------------------------------------------------------------------------------
       *******************************************************************************************	


----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.
     
	
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_bpm_daily.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
Enable cron - cron_tx_run_emrs_medenrl.sh
Enable cron - manage_scheduled_contact_center_jobs.sh
