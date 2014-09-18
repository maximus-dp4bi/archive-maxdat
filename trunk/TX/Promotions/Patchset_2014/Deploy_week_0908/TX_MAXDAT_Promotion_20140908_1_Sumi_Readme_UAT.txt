***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 09/08/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/09/03 Sumi          916 425 6258  TXEB-3180 MEA - Unnecessary updates happening in etl run
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------

*******************************************************************************************	
               Sumi (Manage Enrollment Activity)
        ------------------------------------------------------------------------------------
       	** Unzip DB_20140908_ManageEnroll_Sumi_1
               ** Run in the order specified below.
               
        
        ETL_MANAGE_ENROLLMENT_PKG.sql

       
       ------------------------------------------------------------------------------------
       *******************************************************************************************

-----------------------
2. KETTLE FILES SECTION
-----------------------

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

Enable cron - cron_tx_run_bpm.sh

