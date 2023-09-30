***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 08/04/2014
----------------
Date       Developer           PHONE         Jira           Reason/Description
---------- ------------------- ------------  -----------    ---------------------------------------------
2014/08/07 Austin Baker        843-259-1955  TXEB - [ticket #]    MAXDAT - [reason]

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------

Disable cron - cron_tx_run_contcent.sh
Disable cron - manage_scheduled_contact_center_jobs.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

        
       *******************************************************************************************	
              Austin (Contact Center)
       -------------------------------------------------------------------------------------------
       	** Unzip DB_ContactCenter_20140805_Austin_2.zip
        ** Run in the order specified below.
       
		   004_INSERT_ADHOC_RECORDS.sql
               
       -------------------------------------------------------------------------------------------
       *******************************************************************************************
 
-----------------------
2. KETTLE FILES SECTION
-----------------------

        
     *******************************************************************************************	
              Austin (Contact Center)
     -------------------------------------------------------------------------------------------
    

    -------------------------------------------------------------------------------------------
    *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
       
       	*******************************************************************************************	
               Austin (Contact Center)
       	-------------------------------------------------------------------------------------------
       	
       	
       	-------------------------------------------------------------------------------------------
        *******************************************************************************************
       
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
       
       *******************************************************************************************	
              Austin (Contact Center)
       -------------------------------------------------------------------------------------------
		- execute the following to run an instance of loading the Contact Center (07/29/2014 - 08/04/2014)
		UAT		nohup /dtxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin/manage_adhoc_contact_center_jobs.sh &
       	
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

Enable cron - cron_tx_run_contcent.sh
Enable cron - manage_scheduled_contact_center_jobs.sh
