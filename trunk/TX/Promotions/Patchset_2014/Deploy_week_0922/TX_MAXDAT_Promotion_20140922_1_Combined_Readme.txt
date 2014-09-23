***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 09/22/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/09/21 Sara                571.294.6487  
                                             TXEB-3092  Scorecard - Add Time to Agent and Timeout Calls to MAXdat
2014/09/19 Mayuresh B.         201.328.5695  TXEB-3582  Error occurred during init of VM on PROD.
2014/09/22 Brian Thai          210-722-3895  TXEB-3622 Client Outreach Not Completing Invalid Requests

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron_tx_run_adhoc_contcent.sh 
Disable cron_tx_run_contcent.sh 
Disable cron_tx_run_contcent_flatten.sh 
Disable cron_tx_run_contcent_forecast.sh 
Disable cron_tx_run_get_dates_and_flatten_cc.sh 
Disable cron_tx_run_load_timeout_calls.sh 
Disable cron - manage_scheduled_contact_center_jobs.sh
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_bpm_daily.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;	

execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;


       *******************************************************************************************	
        Sara(Contact Center)
        ------------------------------------------------------------------------------------
       	** Unzip DB_ContactCenter_20140919_Sara_1.zip
        ** Run in the order specified below.
       
 		 001_UPDATE_EXISTING_TIME_OUT_CALLS_FLAG.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	
        
-----------------------
2. KETTLE FILES SECTION
-----------------------




       *******************************************************************************************	
        B.Thai (Client Outreach UPD25)
        --------------------------------------------------------------------
	Download AS_20140922_CO_Brian_1.zip
	Deploy the follow files to the appropriate path
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

        Client_Outreach_UPD25.ktr

	--------------------------------------------------------------------
       *******************************************************************************************	

-----------------------
3. UNIX SCRIPT SECTION
-----------------------



	*******************************************************************************************	
        Mayuresh B.(Run Initialization)
        --------------------------------------------------------------------
	Download AS_20140919_Run_BPM_Mayuresh_1.zip
	Deploy the follow files to the appropriate path
	  
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

	tx_run_bpm.sh
	
	
	**Run dos2unix for the following List
	dos2unix tx_run_bpm.sh
	
	** chmod 755
	chmod 755 tx_run_bpm.sh
	
	--------------------------------------------------------------------
       *******************************************************************************************	
       
              
              
     *******************************************************************************************	
                                Sara(Contact Center)
                       -------------------------------------------------------------------------------------------
                  
                       ****Download AS_ContactCenter_20140919_Sara_1.zip
                         	Deploy the following files to the appropriate path****
       
                       
                              UAT           DEPLOY TO PATH dtxe4t/3rdparty/cron_files    
                              ProdSupp      DEPLOY TO PATH ttxe4t/3rdparty/cron_files
       		       PROD          DEPLOY TO PATH ptxe4t/3rdparty/cron_files
       		         
       		         
       		         cron_tx_run_contcent.sh 
       		         cron_tx_run_load_timeout_calls.sh  
       		         
       		          
       			 **Run dos2unix for the following List	      
       			 
       		   
       		         cron_tx_run_contcent.sh 
       		         cron_tx_run_load_timeout_calls.sh	
       			  			      
       			** chmod 755	      
       
       		          chmod 755  cron_tx_run_contcent.sh 
                        	  chmod 755  cron_tx_run_load_timeout_calls.sh	     
                             	
                         	
                      -------------------------------------------------------------------------------------------
    *******************************************************************************************
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------


----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.

----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron_tx_run_adhoc_contcent.sh 
Enable cron_tx_run_contcent.sh 
Enable cron_tx_run_contcent_flatten.sh 
Enable cron_tx_run_contcent_forecast.sh 
Enable cron_tx_run_get_dates_and_flatten_cc.sh 
Enable cron_tx_run_load_timeout_calls.sh c
Enable cron - manage_scheduled_contact_center_jobs.sh
