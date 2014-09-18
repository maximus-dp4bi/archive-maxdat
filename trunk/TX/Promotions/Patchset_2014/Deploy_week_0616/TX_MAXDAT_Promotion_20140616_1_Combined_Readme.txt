***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 06/16/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/06/16 Sara                571.294.6487  TXEB-2767 MAXDAT AMP export jobs/transforms are not up to date  
                                             TXEB-2756 Confirm Outbound Call Queues & UOW for ES Outbound Call Queues
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_contcent.sh
Disable cron - cron_tx_run_emrs.sh
Disable cron - cron_tx_run_emrs_medenrl.sh
Disable cron-  cron_tx_run_contcent_flatten.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

       *******************************************************************************************	
        Sara (Contact Center)
        ------------------------------------------------------------------------------------
	** Unzip DB_ContactCenter_20140616_Sara_1.zip
        ** Run in the order specified below.

  	    100_ES_OUTBOUND_WFM_ORG_TO_CC_C_LOOKUP.sql
  	    101_ES_OUTBOUND_WFM_ORG_TO_CC_C_FILTER.sql
  	    102_ES_OUTBOUND_CALLTYPES_SKILLGRPS_TO_CC_C_FILTER.sql
  	    103_ES_OUTBOUND_ACD_SKILLSET_PROJECT_TO_CC_C_LOOKUP.sql
  	    104_ES_OUTBOUND_ACD_SKILLSET_PROGRAM_TO_CC_C_LOOKUP.sql
  	    105_UPDATE_ES_OUTBOUND_QUEUES_CC_C_CONTACT_QUEUE.sql
  	    106_ADD_ES_OUTBOUND_UNIT_OF_WORK_TO_CC_C_UNIT_OF_WORK.sql
  	    107_ADD_ES_OUTBOUND_DATA_TO_DIMENSIONAL_TABLES.sql
  	    
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        Sara(Contact Center)
	--------------------------------------------------------------------
	Download AS_ContactCenter_20140616_Sara_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional

      flatten_project_facts.kjb
      get_dates_and_flatten_project_facts.kjb
      
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms
	  
	  flatten_CC_F_AGENT_BY_DATE.ktr
	  flatten_CC_F_AGENT_ACTIVITY_BY_DATE.ktr
	  flatten_CC_F_ACTUALS_QUEUE_INTERVAL.ktr
	  flatten_CC_F_ACTUALS_IVR_INTERVAL.ktr
	  flatten_CC_F_IVR_SELF_SERVICE_USAGE.ktr
	  flatten_CC_F_FORECAST_INTERVAL.ktr
      
      

	--------------------------------------------------------------------
       *******************************************************************************************	

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
None		
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

        *******************************************************************************************	
              Sara (Contact Center)
               --------------------------------------------------------------------------------------------

       -- Execute flatten contact center job
       
       	UAT          nohup /dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_tx_flatten_contact_center.sh &
       	PRD SUPP     nohup ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_tx_flatten_contact_center.sh &
       	PRD          nohup ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_tx_flatten_contact_center.sh &
       	

              -------------------------------------------------------------------------------------------------	
       	
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

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
Enable cron - cron_tx_run_emrs_medenrl.sh
Enable cron-  cron_tx_run_contcent_flatten.sh
