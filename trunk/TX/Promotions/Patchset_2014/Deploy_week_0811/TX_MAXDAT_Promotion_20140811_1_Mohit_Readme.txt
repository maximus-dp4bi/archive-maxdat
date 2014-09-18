***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  ContactCenter week of 08/11/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- ---------  ---------------------------------------------
2014/08/11 Mohit Agarwal       248-918-7479 TXEB-2933    Duplicate Agent Dimension & Fact Records

           Clay Rowland        843-408-1358

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

  
 
-----------------------
2. KETTLE FILES SECTION
-----------------------

        
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
       
       	*******************************************************************************************	
               Mohit (Contact Center)
       	-------------------------------------------------------------------------------------------
       	
       	
       	-------------------------------------------------------------------------------------------
        *******************************************************************************************
       
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
       
       *******************************************************************************************	
              Mohit (Contact Center)
       -------------------------------------------------------------------------------------------
      
       	
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
