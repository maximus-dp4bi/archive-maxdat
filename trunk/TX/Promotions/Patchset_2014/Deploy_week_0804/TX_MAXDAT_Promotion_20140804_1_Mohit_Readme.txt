***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 07/12/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- ---------  ---------------------------------------------
2014/07/12 Mohit Agarwal       248-918-7479 MAXDAT-1488  MAXDAT - Add check for creation of duplicate dimension records
           				    MAXDAT-1544  MAXDAT - Unique constraints should be added to CC_C_LOOKUP, CC_C_FILTER tables    

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
              ( MOhit - Contact Center)
       -------------------------------------------------------------------------------------------
       	** Unzip DB_ContactCenter_20140804_Mohit_1.zip
        ** Run in the order specified below.
       
               100_TXEB_ADD_CONSTRAINTS.sql
	       101_TXEB_DuplicateAgent_Cleanup20140804.sql
               
               
       -------------------------------------------------------------------------------------------
       *******************************************************************************************

  
 
-----------------------
2. KETTLE FILES SECTION
-----------------------

        
     *******************************************************************************************	
              Mohit(Contact Center)
     -------------------------------------------------------------------------------------------

     ****Download AS_ContactCenter_20140804_Mohit_1.zip
       	Deploy the following files to the appropriate path****
       	
   -- Timeout calls job    	
       	
    UAT dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional/manage_agent_duplicates.kjb
    UAT dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional/manage_CC_D_AGENT.kjb
    UAT dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional/manage_CC_D_CONTACT_QUEUE.kjb  
    UAT dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional/manage_queue_duplicates.kjb

    UAT dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional/delete_agent_duplicates_update_valid_dim_records.ktr
    UAT dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional/delete_queue_duplicates_update_valid_dim_records.ktr
    UAT dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional/identify_log_agent_duplicates.ktr
    UAT dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional/identify_log_queue_duplicates.ktr
    

    

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
