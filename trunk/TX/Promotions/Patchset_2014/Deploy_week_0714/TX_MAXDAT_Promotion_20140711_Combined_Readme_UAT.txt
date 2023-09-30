***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 07/14/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/07/14 Sara                571.294.6487  MAXDAT-1491 MAXDAT UAT - Flatten job deployment - Master ticket

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron_tx_run_contcent_flatten.sh cron job 


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

       *******************************************************************************************	
        Sara (Contact Center)
        ------------------------------------------------------------------------------------
	** Unzip DB_ContactCenter_20140711_Sara_1.zip
        ** Run in the order specified below.

          001_SEED_FLATTEN_SCHEDULED_JOB.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

        *******************************************************************************************	
              Sara (Contact Center)
       	--------------------------------------------------------------------
       	Download AS_ContactCenter_20140711_Sara_1.zip
       	Deploy the follow files to the appropriate path
       	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/utility

       	   get_missing_file_dates.ktr
           log_to_CC_A_SCHEDULED_JOB_end.ktr
           log_to_CC_A_SCHEDULED_JOB_error.ktr
           log_to_CC_A_SCHEDULED_JOB_start.ktr
          
          
  
          UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs
          
          execute_flatten_project_facts.kjb
          
           UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional
           
           flatten_MAXDAT_tables.kjb
	   flatten_project_facts.kjb
          

       	--------------------------------------------------------------------
       *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------

***************************************************************************************************************
                   Sara (Contact Center)
---------------------------------------------------------------------------------------------------------------

         UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin
          
          run_exec_flatten_contact_center.sh
          run_flatten_contact_center.sh	  
          
          **Run dos2unix for the following List	      
	 
	  run_exec_flatten_contact_center.sh
          run_flatten_contact_center.sh	
	  			      
	  		** chmod 755	      
	  chmod 755 run_exec_flatten_contact_center.sh
          chmod 755 run_flatten_contact_center.sh	



----------------------------------------------------------------------------------------------------------
*************************************************************************************************************


			
                
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

Enable cron_tx_run_contcent_flatten.sh cron job 
