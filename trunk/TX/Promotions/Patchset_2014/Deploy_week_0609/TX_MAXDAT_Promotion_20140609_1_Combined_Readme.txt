***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 06/09/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/06/09 M.Bhalekar         201.328.5695  TXEB-2282   Community Outreach - Corrected transformation
2014/06/10 Sara               571.294.6487  TXEB-2699   Confirm Outbound Call Queues

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


       *******************************************************************************************	
        M.Bhalekar(Community Outreach)
        ------------------------------------------------------------------------------------
	** Unzip DB_CommunityOutreach_20140609_Mayuresh_1.zip
        ** Run in the order specified below.

        20140609_1320_Add_grants_script.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	        


execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

       *******************************************************************************************	
        Sara (Contact Center)
        ------------------------------------------------------------------------------------
	** Unzip DB_ContactCenter_20140610_Sara_1.zip
        ** Run in the order specified below.

          100_OUTBOUND_WFM_ORG_TO_CC_C_LOOKUP.sql
          101_OUTBOUND_WFM_ORG_TO_CC_C_FILTER.sql
          102_ADD_OUTBOUND_CALLTYPES_SKILLGRPS_TO_CC_C_FILTER.sql
          103_OUTBOUND_ACD_SKILLSET_PROJECT_TO_CC_C_LOOKUP.sql
          104_OUTBOUND_ACD_SKILLSET_PROGRAM_TO_CC_C_LOOKUP.sql
          105_UPDATE_OUTBOUND_QUEUES_CC_C_CONTACT_QUEUE.sql
          105_FIX_UPDATE_CC_C&CC_D_ACTIVITY_TYPE.sql
          106_ADD_OUTBOUND_UNIT_OF_WORK_TO_CC_C_UNIT_OF_WORK.sql
          107_ADD_OUTBOUND_DATA_TO_DIMENSIONAL_TABLES.sql
          108_INSERT_INTO_CC_A_ADHOC_JOB.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************

        
-----------------------
2. KETTLE FILES SECTION
-----------------------



       *******************************************************************************************	
         M.Bhalekar(Community Outreach)
	--------------------------------------------------------------------
	Download AS_CommunityOutreach_20140609_Mayuresh_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/CommunityOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/CommunityOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/CommunityOutreach

	CommunityOutreach_Activity_DetailsCHLD_temp_to_BPMupdate.ktr

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
       	--Execute manage_adhoc_contact_center_jobs.sh
       	UAT          nohup /dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
       	PRD SUPP     nohup /ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
       	PRD          nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
       	
       	--------------------------------------------------------------------------------------------
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
