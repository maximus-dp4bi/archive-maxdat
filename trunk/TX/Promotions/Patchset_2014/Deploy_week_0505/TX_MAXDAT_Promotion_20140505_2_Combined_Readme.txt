***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 05/05/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- ---------  ---------------------------------------------
2014/05/05 Sara               571-294-6487 TXEB-2378-TXEB-2166 TX EB CC - add new data element to Contact Center for Timeout Calls needed for EB 602 Scorecard
           				   TXEB-2420 Fix AnswerWaitTime column mapping in cc_f_actuals_queue_interval    

2014/05/06 M.Bhalekar         201-328-5695           Fix for ERROR executing query in part[OQ exec query] for Process Incidents        

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - manage_scheduled_contact_center_jobs.sh
Disable cron -cron_tx_run_contcent_forecast.sh



-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;	

        
       *******************************************************************************************	
              ( Sara - Contact Center)
               ------------------------------------------------------------------------------------
       	** Unzip DB_ContactCenter_20140505_Sara_1.zip
               ** Run in the order specified below.
       
               101_INSERT_INTO_CC_A_ADHOC_JOB.sql
               
               
               ------------------------------------------------------------------------------------
       *******************************************************************************************

  

execute MAXDAT_ADMIN.STARTUP_JOBS;


 
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        M.Bhalekar(Process Incidents)
	--------------------------------------------------------------------
	Download AS_ProcessIncidents_20140506_Mayuresh_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessIncidents 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessIncidents 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessIncidents

	
	Get_Updates_From_OLTP_TX.ktr
	
	
	--------------------------------------------------------------------
       *******************************************************************************************

        
       
     *******************************************************************************************	
              Sara(Contact Center)
         --------------------------------------------------------------------

     ****Download AS_ContactCenter_20140505_Sara_2.zip
       	Deploy the following files to the appropriate path****
       	
   -- Timeout calls job    	
       	
    UAT dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/staging/load_timeout_calls.kjb
    UAT dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/load_timeout_calls.ktr
    
    PRD SUPP ttxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/staging/load_timeout_calls.kjb
    PRD SUPP ttxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/load_timeout_calls.ktr
 
    
    PRD  ptxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/staging/load_timeout_calls.kjb
    PRD  ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/load_timeout_calls.ktr
    
  -- Forecasts job
  
  UAT      dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/Forecasts/load_CC_S_FCST_INTERVAL.ktr
  PRD SUPP ttxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/Forecasts/load_CC_S_FCST_INTERVAL.ktr
  PRD      ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/Forecasts/load_CC_S_FCST_INTERVAL.ktr
  
   --------------------------------------------------------------------
     *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
       
       	*******************************************************************************************	
               Sara (Contact Center)
       	--------------------------------------------------------------------
       	Download AS_ContactCenter_20140505_Sara_2.zip
       	Deploy the follow files to the appropriate path
       
       	UAT      DEPLOY TO PATH /dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin
       	ProdSupp DEPLOY TO PATH /ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin
       	PROD     DEPLOY TO PATH /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin
       
       	run_load_timeout_calls.sh 
       
       	Run dos2unix for the following List 
       		run_load_timeout_calls.sh 
       		
       	chmod 755 run_load_timeout_calls.sh 
       	--------------------------------------------------------------------
       *******************************************************************************************
       
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
       
       *******************************************************************************************	
              Sara (Contact Center)
               --------------------------------------------------------------------------------------------
       	--Execute manage_adhoc_contact_center_jobs.sh
       	UAT          nohup /dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
       	PRD SUPP     nohup /ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
       	PRD          nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
       	
       	--------------------------------------------------------------------------------------------
        *******************************************************************************************


----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.
     
  	-- Schedule contact center timeout calls cron job
	-- Download AS_ContactCenter_20140505_Sara_2.zip
	
UAT #CONTACTCENTERTIMEOUTCALLS
00 22 * * * /dtxe4t/3rdparty/cron_files/cron_tx_run_load_timeout_calls.sh > /dtxe4t/ETL_Logs/logs/ContactCenter/run_timeout_calls_`date +\%Y\%m\%d`.log 2>&1

PRD SUPP #CONTACTCENTERTIMEOUTCALLS
00 22 * * * /ttxe4t/3rdparty/cron_files/cron_tx_run_load_timeout_calls.sh > /ttxe4t/ETL_Logs/logs/ContactCenter/run_timeout_calls_`date +\%Y\%m\%d`.log 2>&1

PRD #CONTACTCENTERTIMEOUTCALLS
00 22 * * * /ptxe4t/3rdparty/cron_files/cron_tx_run_load_timeout_calls.sh > /ptxe4t/ETL_Logs/logs/ContactCenter/run_timeout_calls_`date +\%Y\%m\%d`.log 2>&1
	
	
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - manage_scheduled_contact_center_jobs.sh
Enable cron - cron_tx_run_contcent_forecast.sh