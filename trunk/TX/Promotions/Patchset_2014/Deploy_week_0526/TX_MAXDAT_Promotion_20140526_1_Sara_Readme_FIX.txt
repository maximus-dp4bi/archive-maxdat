***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 05/26/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/05/26 Sara                571-294-6487  TXEB-2420 Answer wait time total fix (DEPLOYED AND TESTED IN UAT)

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------

Disable cron - cron_tx_run_contcent.sh (Make sure that the cron job is not running)

-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

     *******************************************************************************************
          Sara (Contact Center)
     ---------------------------------------------------------------------------------------
        ****Download DB_ContactCenter_20140526_Sara_2.zip
       	Deploy the following files to the appropriate path****
       	
           100_FIX_DUPLICATE_FACTS_PRD.sql
     --------------------------------------------------------------------------------------------  	
  
       	
    *******************************************************************************************
    
----------------------------
2. ADHOC SH SCRIPT SECTION
----------------------------

       
       
       *******************************************************************************************	
       Sara (Contact Center)
        --------------------------------------------------------------------------------------------
	--Execute manage_adhoc_contact_center_jobs.sh

	
	PRD          nohup ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
	

       -------------------------------------------------------------------------------------------------	
	
     *******************************************************************************************      
     
----------------------------
3. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_contcent.sh     