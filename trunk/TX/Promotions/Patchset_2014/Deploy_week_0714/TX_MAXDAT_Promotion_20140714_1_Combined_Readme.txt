***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 07/14/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/07/09 M. Bhalekar         201.328.5695  TXEB-2282  Commnuity Outreach-updated job run schedule and corrected update cond
					     TXEB-2551  MAXDAT - Support Client Inquiry record deadlocks. 
2014/07/14 Sara(TESTED IN UAT) 571.294.6487  TXEB-2781	MAXDAT CC - Agent by Date fact data not classfied by Project or Program
                                             TXEB-2791	MAXDAT CC - Agent by Date Calls Handled do not match ACD Queue interval Call Handled by Date	
                                             TXEB-2839	MAXDAT CC - Agent Activity by Date fact table missing data from June
                                             MAXDAT-1491 MAXDAT UAT - Flatten job deployment - Master ticket
                                             MAXDAT-1416 MAXDAT CC - Site Dimension is not being properly populated in any of the contact center deployments
2014/07/14 Brian               210.722.3895  MAXDAT-1083 Indexes no on MAXDAT_INDX tablespace.

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_contcent.sh
Disable cron - cron_tx_run_emrs.sh
Disable cron - cron_tx_run_emrs_medenrl.sh
Disable cron-  cron_tx_run_adhoc_contcent.sh
Disable cron-  cron_tx_run_contcent_flatten.sh
Disable cron-  cron_tx_run_get_dates_and_flatten_cc.sh
	




-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;	

       *******************************************************************************************	
        (Developer create this block for each DB zip)
        ------------------------------------------------------------------------------------
	** Unzip DB_{SYSTEM}_{YYMMDD}20131118_{DEVELOPER_NAME}_{NUM}.zip
        ** Run in the order specified below.

        File1.sql
        File2.sql
        File3.sql
        etc
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	        

       *******************************************************************************************	
        M. Bhalekar (Community Outreach)
        ------------------------------------------------------------------------------------
	** Unzip DB_CommunityOutreach_20140709_Mayuresh_1.zip
        ** Run in the order specified below.

        20140709_0837_update_CORP_ETL_CONTROL.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************

       *******************************************************************************************	
        B. Thai (Maxdat Indexes)
        ------------------------------------------------------------------------------------
	** Unzip DB_Maxdat_20140714_Brian_1.zip
        ** Run in the order specified below.

        ** First script for APT only
        20140711_1305_TXEB_apt_rebuild_indexes.sql

        ** Second script for all environments
        20140711_0853_TXEB_prd_rebuild_indexes.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	        


execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

       *******************************************************************************************	
        Sara (Contact Center)
        ------------------------------------------------------------------------------------
	** Unzip DB_ContactCenter_20140714_Sara_1.zip
        ** Run in the order specified below.

        004_DEDUPE_CONTACT_QUEUES.sql
        005_DELETE_SSU_AGENTS.sql
        006_DELETE_TEXAS_ORG.sql
        008_DELETE_AGENT_BY_FACTS.sql
        009_INSERT_ADHOC_JOBS.sql
        
        101_ADD_SITE_LOOKUPS.sql
        102_UPDATE_SITE_NAMES.sql
        103_UPDATE_OBSOLETE_SITE_ID_IN_FACTS.sql
        
        001_SEED_FLATTEN_SCHEDULED_JOB.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        (Developer create this block for each AS zip)
	--------------------------------------------------------------------
	Download AS_{SYSTEM}_{YYMMDD}20131118_{DEVELOPER_NAME}_{NUM}.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/{Your Direcortory} 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/{Your Direcortory} 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/{Your Direcortory} 

	file1.ktr
	file2.kjb
	file3.ktr
	etc
	--------------------------------------------------------------------
       *******************************************************************************************

	*******************************************************************************************	
        M. Bhalekar (Community Outreach)
	--------------------------------------------------------------------
	Download AS_CommunityOutreach_20140709_Mayuresh_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/CommunityOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/CommunityOutreach
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/CommunityOutreach 

	CommunityOutreach_Actv_Chld_Copy_to_temp.ktr
	CommunityOutreach_Actv_Details_Chld_Copy_to_temp.ktr
	CommunityOutreach_CaptureCommunityActivityDetails.kjb
	CommunityOutreach_JobRun_var.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

        *******************************************************************************************	
        M. Bhalekar (SupportClientInquiry)
	--------------------------------------------------------------------
	Download AS_SCI_20140714_Mayuresh_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/SupportClientInquiry
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/SupportClientInquiry
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/SupportClientInquiry
	  

	ClientInquiry_Child_Update_UPD1_20_TX.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

	
       
       *******************************************************************************************	
                     Sara (Contact Center)
              	--------------------------------------------------------------------
              	Download AS_ContactCenter_20140714_Sara_1.zip
              	Deploy the follow files to the appropriate path
              	
              	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/BluePumpkin
              	  ProdSupp DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/BluePumpkin
              	  PROD     DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/BluePumpkin 
              	  
                 load_CC_S_AGENT.ktr
         
                 UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional
                 ProdSupp DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional
              	  PROD     DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional
              	  
                 manage_CC_D_SITE.ktr
                 manage_CC_D_GROUP.ktr
                 
                 UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/utility
                 ProdSupp DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/utility
              	 PROD     DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/utility
              	 
              	       get_missing_file_dates.ktr
		       log_to_CC_A_SCHEDULED_JOB_end.ktr
		       log_to_CC_A_SCHEDULED_JOB_error.ktr
                       log_to_CC_A_SCHEDULED_JOB_start.ktr
                       
                 UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs   
                 ProdSupp DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs 
              	 PROD     DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs 
              	 
              	 execute_flatten_project_facts.kjb
              	 
              	 UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional
              	 ProdSupp DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional
              	 PROD     DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/dimensional
              	 
              	       flatten_MAXDAT_tables.kjb
	               flatten_project_facts.kjb
               	  
              
       
              	--------------------------------------------------------------------
       *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
***************************************************************************************************************
                   Sara (Contact Center)
---------------------------------------------------------------------------------------------------------------

          Download AS_ContactCenter_20140714_Sara_1.zip
	  Deploy the follow files to the appropriate path
	  
         UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin
          
          run_exec_flatten_contact_center.sh
          run_flatten_contact_center.sh	  
          
          **Run dos2unix for the following List	      
	 
	  run_exec_flatten_contact_center.sh
          run_flatten_contact_center.sh	
	  			      
	  		** chmod 755	      
	  chmod 755 run_exec_flatten_contact_center.sh
          chmod 755 run_flatten_contact_center.sh	
          
          
         UAT	 /dtxe4t/3rdparty/cron_files

                  cron_tx_run_contcent_flatten.sh

	**Run dos2unix for the following List	
	     cron_tx_run_contcent_flatten.sh
	 
	 **chmod 755
	 chmod 755 cron_tx_run_contcent_flatten.sh


----------------------------------------------------------------------------------------------------------
*************************************************************************************************************		
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
       *******************************************************************************************	
       Sara (Contact Center)
        --------------------------------------------------------------------------------------------
        
	UAT        nohup /dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
	PRD SUPP   nohup /ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
	PRD        nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &

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
Enable cron-  cron_tx_run_adhoc_contcent.sh
Enable cron-  cron_tx_run_contcent_flatten.sh 
Enable cron-  cron_tx_run_get_dates_and_flatten_cc.sh