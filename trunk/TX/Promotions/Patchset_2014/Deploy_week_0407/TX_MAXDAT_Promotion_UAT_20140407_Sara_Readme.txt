***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 04/07/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/04/07 Sara                571-294-6487  TXEB-2420 Fix AnswerWaitTime column mapping in cc_f_actuals_queue_interval
           C.Rowland           843.408.1358

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - manage_scheduled_contact_center_jobs.sh



-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT



     *******************************************************************************************	
       ( Sara - Contact Center)
        ------------------------------------------------------------------------------------
	** Unzip DB_ContactCenter_20140407_Sara_1.zip
        ** Run in the order specified below.

        100_INSERT_INTO_CC_A_ADHOC_JOB.sql
        
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************
 
        
-----------------------
2. KETTLE FILES SECTION
-----------------------


      *******************************************************************************************	
         Sara (Contact Center)
	--------------------------------------------------------------------
	Download AS_ContactCenter_20140407_Sara_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/Cisco
	  
	load_CC_S_ACD_INTERVAL.ktr
	
	
	--------------------------------------------------------------------
       *******************************************************************************************

	

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
	UAT             nohup dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
	
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

