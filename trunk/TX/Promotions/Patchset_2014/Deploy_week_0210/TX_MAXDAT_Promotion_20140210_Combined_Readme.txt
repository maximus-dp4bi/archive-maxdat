***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 02/10/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/02/03 M. Bhalekar        201-328-5695   Added New 3 attributes #ILEB-1726 in TX and to make process corp 
2014/02/10 A. Antonio         916-832-8644   Load CHIP and PERI notifications

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_emrs.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;	


       *******************************************************************************************	
        M.Bhalekar(Manage Jobs)
        ------------------------------------------------------------------------------------
	** Unzip DB_MJ_20140203_MAYURESH_4.zip
        ** Run in the order specified below.

        1. 20140203_0130_Alter_ManageJobs_Scripts.sql
        2. MANAGE_JOBS_pkg.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	        


execute MAXDAT_ADMIN.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        M.Bhalekar(Community Outreach)
	--------------------------------------------------------------------
	Download AS_COMMUNITYOUTREACH_20140207_MAYURESH_4.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/CommunityOutreach  
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/CommunityOutreach  
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/CommunityOutreach 

	CommunityOutreach_CommActivity_RunAll.kjb
	CommunityOutreach_CaptureCommunityActivitiesDetailsChild.ktr
	
	--------------------------------------------------------------------
       *******************************************************************************************

      *******************************************************************************************	
        A. Antonio (EMRS)
	--------------------------------------------------------------------
	Download AS_EMRS_20140210_ARLENE_39.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS  

	DIM_Load_NOTIFICATIONS_CHIP_ONETIME.ktr
	DIM_Load_NOTIFICATIONS_PERI_ONETIME.ktr
	ETL_Load_Notifications_OneTime.kjb
	DIM_Load_NOTIFICATIONS_PERI.ktr
	--------------------------------------------------------------------

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
no scripts to deploy		
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
 
	*******************************************************************************************	
	A. Antonio (EMRS)
	--------------------------------------------------------------------       
	--Execute tx_emrs_load_notifications_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &

	--------------------------------------------------------------------
       *******************************************************************************************

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_emrs.sh
