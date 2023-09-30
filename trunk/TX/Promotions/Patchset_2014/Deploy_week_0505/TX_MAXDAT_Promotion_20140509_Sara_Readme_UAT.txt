***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 05/09/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/05/09 Sara                571-294-6487  TXEB-2420 Answer wait time total fix
           C.Rowland           843.408.1358

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_contcent_forecast.sh



-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT



     *******************************************************************************************	
        ****Download DB_ContactCenter_20140509_Sara_1.zip
       	Deploy the following files to the appropriate path****
       	
       	100_INSERT_UNKNOWN_INTERVAL.sql
       	
       	
       *******************************************************************************************
 
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

No Changes  
        

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
 No  changes	
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

       *******************************************************************************************	
       Sara (Contact Center)
        --------------------------------------------------------------------------------------------
	--Execute manage_adhoc_contact_center_jobs.sh

	UAT          nohup dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
	
	--------------------------------------------------------------------------------------------
       *******************************************************************************************

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
  
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - manage_scheduled_contact_center_jobs.sh

