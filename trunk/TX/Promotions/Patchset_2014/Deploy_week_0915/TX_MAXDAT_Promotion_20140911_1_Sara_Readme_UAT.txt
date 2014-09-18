***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  ContactCenter week of 09/08/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- ---------  ---------------------------------------------
2014/09/11 Sara               248-918-7479 TXEB-3092    Scorecard - Add Time to Agent and Timeout Calls to MAXdat
           

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------

Disable cron - cron_tx_run_load_timeout_calls.sh



-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT


        
       *******************************************************************************************	
              ( Sara - Contact Center)
       -------------------------------------------------------------------------------------------
       	** Unzip DB_ContactCenter_20140911_Sara_1.zip
        ** Run in the order specified below.
       
 		 001_ALTER_CC_S_DETAIL.sql
		

               
               
       -------------------------------------------------------------------------------------------
       *******************************************************************************************

  
 
-----------------------
2. KETTLE FILES SECTION
-----------------------

        
     *******************************************************************************************	
              Sara(Contact Center)
     -------------------------------------------------------------------------------------------

     ****Download AS_ContactCenter_20140911_Sara_1.zip
       	Deploy the following files to the appropriate path****
       	
    UAT  dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/staging/load_timeout_calls.kjb
    UAT  dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/load_timeout_calls.ktr
    UAT  dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/Load_Time_To_Agent.ktr
       	
           	
       	
    -------------------------------------------------------------------------------------------
    *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
       

       
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
       
       *******************************************************************************************	
              Sara (Contact Center)
       -------------------------------------------------------------------------------------------
      
       	UAT          nohup dtxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin/run_load_timeout_calls.sh &
       -------------------------------------------------------------------------------------------
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

Enable cron - cron_tx_run_load_timeout_calls.sh

