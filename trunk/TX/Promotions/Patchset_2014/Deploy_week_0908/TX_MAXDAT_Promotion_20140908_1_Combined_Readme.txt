***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 09/08/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/09/08 Mohit Agarwal       248-918-7479  TXEB-2934    Agent dimension records did not have their Site updated
2014/09/08 Mohit Agarwal       248-918-7479  MAXDAT-1681  MAXDAT Contact Center - Add Report Filter to Exclude Supervisor Activity 
2014/09/03 Brian Thai          210-722-3895  TXEB-2649    Client Outreach UPD25
2014/09/08 Sumi                916 425 6258  TXEB-3180 MEA - Unnecessary updates happening in etl run

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------

Disable cron - cron_tx_run_contcent.sh
Disable cron - manage_scheduled_contact_center_jobs.sh
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_bpm_daily.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;	

       *******************************************************************************************	
             Mohit (Contact Center)
       -------------------------------------------------------------------------------------------
       	** Unzip DB_ContactCenter_20140908_Mohit_1.zip
        ** Run in the order specified below.
       
		    100_UPDATE_CC_S_AGENT_SITE_NAME.sql

	** Unzip DB_ContactCenter_20140908_Mohit_2.zip
        ** Run in the order specified below.
       
		    101_ALTER_CC_D_PROGRAM_FLAG.sql
               
       -------------------------------------------------------------------------------------------
       *******************************************************************************************  

       *******************************************************************************************	
               Sumi (Manage Enrollment Activity)
        ------------------------------------------------------------------------------------
       	** Unzip DB_20140908_ManageEnroll_Sumi_1
               ** Run in the order specified below.
               
        
        ETL_MANAGE_ENROLLMENT_PKG.sql

       
       ------------------------------------------------------------------------------------
       *******************************************************************************************


execute MAXDAT_ADMIN.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        B.Thai (Client Outreach Update Rule 25)
        --------------------------------------------------------------------
	Download AS_20140908_CO_Brian_1.zip
	Deploy the follow files to the appropriate path
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

        Client_Outreach_UPD25.ktr

	--------------------------------------------------------------------
       *******************************************************************************************	

       *******************************************************************************************	
        Sumi - Manage Enrollment Activity
        --------------------------------------------------------------------
	Download AS_20140908_ManageEnroll_Sumi_1

	Deploy the follow files to the appropriate path

	 UAT dtxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity
	 ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity
	 PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity

        ManageEnroll_UPD14.ktr
	ManageEnroll_UPD17.ktr
  
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
     
     

----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_contcent.sh
Enable cron - manage_scheduled_contact_center_jobs.sh
Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_bpm_daily.sh


