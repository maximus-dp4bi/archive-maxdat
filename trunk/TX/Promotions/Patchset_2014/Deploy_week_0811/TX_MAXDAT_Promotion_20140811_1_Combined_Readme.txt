***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 08/11/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/08/08 B.Thai              210.722.3895  TXEB - 3161:  Fix INS1_20 service area value.
2014/08/11 B.Thai              210.722.3895  TXEB - 3151:  Fix UPD2 performance issue.
2014/08/12 Austin Baker		   843.259.1955  TXEB - 3096:  increase size of 'Message' field in CC_L_ERROR table
2014/08/12 Austin Baker		   843.259.1955  TXEB - 2920:  deploy multiple programs update
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_bpm_daily.sh
Disable cron - cron_tx_run_contcent.sh
Disable cron - cron_tx_run_emrs.sh
Disable cron - cron_tx_run_emrs_medenrl.sh
Disable cron - manage_scheduled_contact_center_jobs.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

	*******************************************************************************************	
	Austin Baker (Contact Center)
	--------------------------------------------------------------------
 	** Unzip DB_ContactCenter_20140812_Austin_5.zip
	** Run in the order specified below.
		
		001_UPDATE_TX_PROGRAMS.sql
		002_ALTER_CC_L_ERROR.sql
		005_INSERT_ADHOC_RECORDS.sql
	--------------------------------------------------------------------
	*******************************************************************************************

       *******************************************************************************************	
              ( MOhit Agarwal - ContactCenter:Duplicate Agents fix)
       -------------------------------------------------------------------------------------------
       	** Unzip DB_PROD_ContactCenter_20140811_Mohit_1.zip
        ** Run in the order specified below.
       
 		 100_TXEB_DuplicateAgent_Cleanup_0.sql
                 101_TXEB_DuplicateAgent_Cleanup_1.sql
                 102_TXEB_DuplicateAgent_Cleanup_2.sql
		 103_TXEB_DuplicateAgent_Cleanup_3.sql
               
       -------------------------------------------------------------------------------------------
       *******************************************************************************************
       *******************************************************************************************	
              ( Mohit Agarwal- ContactCenter:lookup unique constraints)
       -------------------------------------------------------------------------------------------
       	** Unzip DB_ContactCenter_20140811_Mohit_2.zip
        ** Run in the order specified below.
       
                 104_TXEB_DuplicateFilter_Cleanup_4.sql
               
               
       -------------------------------------------------------------------------------------------
       *******************************************************************************************


-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        B. Thai (SCI fix INS1_20)
	--------------------------------------------------------------------
	Download AS_SCI_20140811_Brian_1.zip
	Deploy the follow files to the appropriate path
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/SupportClientInquiry
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/SupportClientInquiry 

	ClientInquiry_Child_Insert_INS1_20_TX.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

       *******************************************************************************************	
        B. Thai (MFD UPD2 performance issue)
	--------------------------------------------------------------------
	Download AS_MFD_20140811_Brian_1.zip
	Deploy the follow files to the appropriate path
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc 

	ProcessMailFaxUpdates_update2.ktr
	--------------------------------------------------------------------
       *******************************************************************************************
     
     *******************************************************************************************	
     Mohit Agarwal(ContactCenter:Duplicate Agents fix)
     -------------------------------------------------------------------------------------------
     Download AS_ContactCenter_20140811_Mohit_1.zip
     Deploy the following files to the appropriate path
     
     ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional
     PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional

     manage_agent_duplicates.kjb
     manage_CC_D_AGENT.kjb
     manage_CC_D_CONTACT_QUEUE.kjb  
     manage_queue_duplicates.kjb

     ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional
     PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional

     delete_agent_duplicates_update_valid_dim_records.ktr
     delete_queue_duplicates_update_valid_dim_records.ktr
     identify_log_agent_duplicates.ktr
     identify_log_queue_duplicates.ktr

    -------------------------------------------------------------------------------------------
    *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

       *******************************************************************************************	
       B. Thai (Client Inquiry adhoc)
        --------------------------------------------------------------------------------------------
        --Execute one-time SCI update
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/Run_onetime_ClientInquiry_Region_Update.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/Run_onetime_ClientInquiry_Region_Update.sh &
	
	--------------------------------------------------------------------------------------------
       *******************************************************************************************	

	   
	*******************************************************************************************	
	Austin Baker (Contact Center adhoc)
    --------------------------------------------------------------------------------------------
		-- Run an instance of loading the contact center
	PROD			nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/bin/manage_adhoc_contact_center_jobs.sh &
	
	--------------------------------------------------------------------------------------------
	*******************************************************************************************	
	   
----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.


     Please DELETE cron_run_bpm_Let.sh from the crontab in ProdFix and Prod. 

----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_bpm_daily.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
Enable cron - cron_tx_run_emrs_medenrl.sh
Enable cron - manage_scheduled_contact_center_jobs.sh