***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 07/07/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/07/07 Sara                571.294.6487             Fix for unique constraint error in PRD

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_contcent.sh
Disable cron - cron_tx_run_emrs.sh
Disable cron - cron_tx_run_emrs_medenrl.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;	

        
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

       *******************************************************************************************	
        Sara (Contact Center)
        ------------------------------------------------------------------------------------
	** Unzip DB_ContactCenter_20140707_Sara_1.zip
        ** Run in the order specified below.

         001_ALTER_CC_S_WFM_AGENT_ACTIVITY.sql
         002_ALTER_CC_S_AGENT_CC_C_LOOKUP.sql
         001_ADD_BUSYONDNTIME_FIELD.sql
         
         100_EB_THS_IVR_ORG_TO_CC_C_LOOKUP.sql
         101_EB_THS_IVR_ORG_TO_CC_C_FILTER.sql
         102_UPDATE_CC_C_CONTACT_QUEUE.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

        *******************************************************************************************	
              Sara (Contact Center)
       	--------------------------------------------------------------------
       	Download AS_ContactCenter_20140707_Sara_1.zip
       	Deploy the follow files to the appropriate path
       	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/BluePumpkin
       	  ProdSupp DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/BluePumpkin
       	  PROD     DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/BluePumpkin 
       	  
       	  load_CC_S_WFM_AGENT_ACTIVITY.ktr
       	  load_CC_S_AGENT.ktr
	  load_tmp_actualeventtimeline.ktr
  
          UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional
          ProdSupp DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional
       	  PROD     DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional
       	  
       	  load_CC_F_ACTUALS_IVR_INTERVAL.ktr
       	  load_CC_F_ACTUALS_QUEUE_INTERVAL.ktr
       	  load_CC_F_AGENT_ACTIVITY_BY_DATE.ktr
       	  load_CC_F_AGENT_BY_DATE.ktr
       	  load_CC_F_FORECAST_INTERVAL.ktr
       	  load_CC_F_IVR_SELF_SERVICE_USAGE.ktr
        	  
       

       	--------------------------------------------------------------------
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
     
1.Gather stats on CC_S_TMP_ACTUALEVENTTIMELINE and CC_S_WFM_AGENT_ACTIVITY tables
2.Increase RAM allocation to 8GB in kitchen.sh     

----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
Enable cron - cron_tx_run_emrs_medenrl.sh
