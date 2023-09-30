***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 09/22/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/09/21 Sara                571.294.6487 TXEB-3262  Short Abandons <> Short Calls 

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron_tx_run_adhoc_contcent.sh 
Disable cron_tx_run_contcent.sh 
Disable cron_tx_run_contcent_flatten.sh 
Disable cron_tx_run_contcent_forecast.sh 
Disable cron_tx_run_get_dates_and_flatten_cc.sh 
Disable cron - manage_scheduled_contact_center_jobs.sh



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
       
 		 001_ADD_SHORT_CALLS_TO_CC_F_ACTUALS.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       
       
           *******************************************************************************************	
                         Sara(Contact Center)
                -------------------------------------------------------------------------------------------
           
                ****Download AS_ContactCenter_20140919_Sara_1.zip
                  	Deploy the following files to the appropriate path****
               UAT   	 dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional/
               ProdSupp  ttxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional/
               PROD      ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional/
       		
                load_CC_F_ACTUALS_QUEUE_INTERVAL.ktr
                
                
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
