***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 05/26/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/05/26 Sara                571-294-6487  TXEB-2420 Answer wait time total fix (DEPLOYED AND TESTED IN UAT)
                                             TXEB-2697 TX Contact Center - Configuration Changes Required for AMP integration        
                                             TXEB-2653 Need Data for STAR PLUS Call Types in MAXDAT
                                             MAXDAT-1149 Agent turnover is not being captured
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------

Disable cron - cron_tx_run_contcent.sh (Make sure that the cron job is not running)



-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT



     *******************************************************************************************
          Sara (Contact Center)
     ---------------------------------------------------------------------------------------
        ****Download DB_ContactCenter_20140526_Sara_1.zip
       	Deploy the following files to the appropriate path****
       	
       	100_INSERT_INTO_CC_A_ADHOC_JOB.sql
       	
       	100_AMP_UPDATE_CC_C_CONTACT_QUEUE.sql
       	101_AMP_UPDATE_CC_D_CONTACT_QUEUE.sql
       	102_AMP_UPDATE_CC_C_ACTIVITY_TYPE.sql
       	103_AMP_UPDATE_CC_D_ACTIVITY_TYPE.sql
       	
       	100_ADD_STARPLUS_CALLTYPES_SKILLGRPS_TO_CC_C_FILTER.sql
       	102_ADD_STARPLUS_UNIT_OF_WORK_TO_CC_C_UNIT_OF_WORK.sql
       	103_ADD_STARPLUS_DATA_TO_DIMENSIONAL_TABLES.sql
       	104_STARPLUS_ACD_SKILLSET_PROGRAM_TO_CC_C_LOOKUP.sql
       	105_STARPLUS_ACD_SKILLSET_PROJECT_TO_CC_C_LOOKUP.sql
       	106_STARPLUS_WFM_ORG_TO_CC_C_LOOKUP.sql
       	107_STARPLUS_WFM_ORG_TO_CC_C_FILTER.sql
       	108_UPDATE_STARPLUS_QUEUES_CC_C_CONTACT_QUEUE.sql
       	
       	100_ALTER_CC_S&CC_D_AGENT.sql
     --------------------------------------------------------------------------------------------  	
  
       	
    *******************************************************************************************
        
-----------------------
2. KETTLE FILES SECTION
-----------------------


       
       *******************************************************************************************	
        Sara (Contact Center)
	--------------------------------------------------------------------
	
	---- Create Contact Center one time jobs directory	
	
	UAT         mkdir  dtxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/jobs/One_time
	PRD SUPP    mkdir  ttxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/jobs/One_time
	PRD         mkdir  ptxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/jobs/One_time
	
	
	Download AS_ContactCenter_20140526_Sara_1.zip
	Deploy the follow files to the appropriate path
	
	  UAT      dtxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/jobs/One_time
     PRD SUPP      ttxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/jobs/One_time
	  PRD      ptxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/jobs/One_time

	one_time_load_update_agents.kjb
	one_time_load_update_cc_s_agent.ktr
	one_time_load_update_cc_d_agent.ktr
	
	--------------------------------------------------------------------
	        Sara (Contact Center)
        --------------------------------------------------------------------
		 AS_ContactCenter_20140526_Sara_1.zip
		Deploy the follow files to the appropriate path
		
		  UAT      dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/BluePumpkin
	     PRD SUPP      ttxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/BluePumpkin
		  PRD      ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/BluePumpkin
	
	 load_CC_S_AGENT.ktr
	 
		  UAT      dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional
	     PRD SUPP      ttxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional
		  PRD      ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional
	 
        manage_CC_D_AGENT.ktr
		
	--------------------------------------------------------------------
	
  *******************************************************************************************  
       

-----------------------
3. UNIX SCRIPT SECTION
-----------------------

       
        *******************************************************************************************	
        Sara (Contact Center)
        --------------------------------------------------------------------
	AS_ContactCenter_20140526_Sara_1.zip
	Deploy the follow files to the appropriate path
	
	UAT      dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin 
	PRD SUPP ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin
       	PROD     ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin
       	
       	run_cc_one_time_agent_fix.sh
       	
       	**Run dos2unix for the following List
       	
       	  run_cc_one_time_agent_fix.sh
       	  
       	 ** chmod 755
       	   run_cc_one_time_agent_fix.sh
       	 

	--------------------------------------------------------------------
       *******************************************************************************************  
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

       
       
       *******************************************************************************************	
       Sara (Contact Center)
        --------------------------------------------------------------------------------------------
	--Execute manage_adhoc_contact_center_jobs.sh

	
	PRD SUPP     nohup ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
	PRD          nohup ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
	
	--Execute agent one time fix
	
	UAT	     nohup dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_cc_one_time_agent_fix.sh &
	PRD SUPP     nohup ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_cc_one_time_agent_fix.sh &
	PRD          nohup ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_cc_one_time_agent_fix.sh &
       -------------------------------------------------------------------------------------------------	
	
       *******************************************************************************************  

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.
     
   -- Create backup folder and move folders to that folder:
   
   	UAT         mkdir  dtxe4t/ETL_Scripts/scripts/ContactCenter/backup
   	PRD SUPP    mkdir  ttxe4t/ETL_Scripts/scripts/ContactCenter/backup
	PRD         mkdir  ptxe4t/ETL_Scripts/scripts/ContactCenter/backup
	
 Move the following folders to backup folder:
 
 PRD           ptxe4t/ETL_Scripts/scripts/ContactCenter/
 
 implementation_23may2014/ 
 main_23may2014/
 test_23may2014/
 
 Move to:
 
 PRD          ptxe4t/ETL_Scripts/scripts/ContactCenter/backup
	
     

----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_contcent.sh

