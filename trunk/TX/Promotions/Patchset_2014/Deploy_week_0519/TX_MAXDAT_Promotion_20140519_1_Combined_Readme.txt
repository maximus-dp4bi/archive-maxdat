***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 05/19/2014
----------------
Date       Developer           PHONE         Jira      Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/05/19 Sara          571-294-6487       TXEB-2378  TXEB-2166 TX EB CC - add new data element to Contact Center for Timeout Calls needed for EB 602 Scorecard (DEPLOYED AND TESTED IN UAT)
           C.Rowland     843.408.1358       Promote TX ES Implementation - UAT PROMOTION COMPLETE TXEB-2636

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------

Disable cron - cron_tx_run_contcent.sh
Disable cron - cron_tx_run_contcent_forecast.sh
-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT


       *******************************************************************************************	
        Sara (Contact Center)
        ------------------------------------------------------------------------------------
	** Unzip DB_ContactCenter_20140519_Sara_1.zip
        ** Run in the order specified below.
        .
        100_ADD_ES_CALLTYPES_SKILLGRPS_TO_CC_C_FILTER.sql
        101_ADD_ES_QUEUES_TO_CC_C_CONTACT_QUEUE.sql
        102_ADD_ES_PROJECT_TO_CC_C_PROJECT_CONFIG.sql
        103_ADD_ES_UNIT_OF_WORK_TO_CC_C_UNIT_OF_WORK.sql
        104_ADD_ES_DATA_TO_DIMENSIONAL_TABLES.sql
        105_ACD_SKILLSET_PROGRAM_TO_CC_C_LOOKUP.sql
        106_ADD_PROJECT_TO_CC_C_LOOKUP.sql
        107_ACD_SKILLSET_PROJECT_TO_CC_C_LOOKUP.sql
        108_ADD_PROGRAMS_TO_CC_C_LOOKUP.sql
        109_UPDATE_CC_C_PROJ_CONFIG.sql
        110_INSERT_CC_S_AGENT_unknown.sql
        111_UPDATE_CC_D_PROJECT.sql
        112_UPDATE_CC_C_CONTACT_QUEUE.sql
        113_UPDATE_CC_S_PRODUCTION_PLAN.sql
        114_INSERT_UNKNOWN_INTERVAL.sql
        116_INSERT_CC_S_AGENT_unknown.sql
        121_UPDATE_ACTIVITY_TYPES_FOR_ES.sql
        
   	** Unzip DB_ContactCenter_20140519_Sara_2.zip
        ** Run in the order specified below.
        
        011_ALTER_CC_F_AGENT_ACTIVITY_BY_DATE.sql
        101_ALTER_TABLE_ADD_INTERVAL_MINUTES.sql
        109_ALTER_QUEUE_TABLES_ADD_COUNT_FIELDS.sql
        110_ALTER_AGENT_TABLES_ADD_TIME_FIELDS.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	        



        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        Sara (Contact Center)
	--------------------------------------------------------------------
     ****Download AS_ContactCenter_20140519_Sara_1.zip
       	Deploy the following files to the appropriate path****
       	
   -- Timeout calls job    	
       	

    PRD SUPP ttxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/staging/load_timeout_calls.kjb
    PRD SUPP ttxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/load_timeout_calls.ktr
 
    
    PRD  ptxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/staging/load_timeout_calls.kjb
    PRD  ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/load_timeout_calls.ktr
	--------------------------------------------------------------------
	
       	--------------------------------------------------------------------
       	Download AS_ContactCenter_20140519_Sara_2.zip
       	Deploy the follow files to the appropriate path

         ProdSupp 
       		unzip -o AS_ContactCenter_20140519_Sara_1.zip -d ttxe4t/ETL_Scripts/scripts/ContactCenter 
       	  PROD     
       		unzip -o AS_ContactCenter_20140519_Sara_1.zip -d ptxe4t/ETL_Scripts/scripts/ContactCenter  
       
       	--------------------------------------------------------------------	
       *******************************************************************************************	

-----------------------
3. UNIX SCRIPT SECTION
----------------------

       	*******************************************************************************************	
               Sara (Contact Center)
       	--------------------------------------------------------------------
       	Download AS_ContactCenter_20140519_Sara_1.zip
       	Deploy the follow files to the appropriate path
       
        ProdSupp DEPLOY TO PATH /ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin
       	PROD     DEPLOY TO PATH /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin
       
       	run_load_timeout_calls.sh 
       	
       	PRD SUPP /ttxe4t/3rdparty/cron_files
	PRD      /ptxe4t/3rdparty/cron_files
	       	
       	cron_tx_run_load_timeout_calls.sh 
       	
       	
       
       	Run dos2unix for the following List 
       	run_load_timeout_calls.sh
       	cron_tx_run_load_timeout_calls.sh 
       		
       		
       	chmod 755 run_load_timeout_calls.sh
       	chmod 755 cron_tx_run_load_timeout_calls.sh 
       	

       	--------------------------------------------------------------------
       	
        --------------------------------------------------------------------
	  	Download AS_ContactCenter_20140519_Sara_2.zip            
	  	Deploy the follow files to the appropriate path            
	  	            
	           
	  	PRODSUPP  /ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin            
	      PROD    /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin            
	  		             
	  	run_tx_flatten_contact_center.sh            
	  	            
	    **Run dos2unix for the following List            
		run_tx_flatten_contact_center.sh	      
			      
		** chmod 755	      
	  	chmod 755 run_tx_flatten_contact_center.sh	            
	  	            
	   PRD SUPP /ttxe4t/3rdparty/cron_files            
	   PRD      /ptxe4t/3rdparty/cron_files	      
	 	      
	 cron_tx_run_contcent_flatten.sh	      
			      
		**Run dos2unix for the following List	      
		cron_tx_run_contcent_flatten.sh	      
			      
		** chmod 755	      
	  chmod 755 cron_tx_run_contcent_flatten.sh	      
       	--------------------------------------------------------------------
       *******************************************************************************************	

                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
  None

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.

  	-- Schedule contact center timeout calls cron job


PRD SUPP #CONTACTCENTERTIMEOUTCALLS
00 22 * * * /ttxe4t/3rdparty/cron_files/cron_tx_run_load_timeout_calls.sh > /ttxe4t/ETL_Logs/logs/ContactCenter/run_timeout_calls_`date +\%Y\%m\%d`.log 2>&1

PRD #CONTACTCENTERTIMEOUTCALLS
00 22 * * * /ptxe4t/3rdparty/cron_files/cron_tx_run_load_timeout_calls.sh > /ptxe4t/ETL_Logs/logs/ContactCenter/run_timeout_calls_`date +\%Y\%m\%d`.log 2>&1

     
-------------------------------------------------------------------------------------------------------------------------     
  -- Contact Center kettle.properties
  
  Please add the following to kettle.properties file.

  
  PRD SUPP:
  cc.mots.file.directory=/ttxe4t/3rdparty/mots/files
  cc.mots.transport=moveit
  
  PRD:
  cc.mots.file.directory=/ptxe4t8/3rdparty/mots/files
  cc.mots.transport=moveit
  
  Remove or comment out the following in kettle.properties file
  
  cc.project.name=Enrollment Broker
  cc.program.name=EB
  
----------------------------------------------------------------------------------------------------------------------------  

-- Create cron job to run flatten project facts once a day


PRD SUPP
    #CONTCENTCENTERFLATTEN
00 17 * * * /ttxe4t/3rdparty/cron_files/cron_tx_run_contcent_flatten.sh > /ttxe4t/ETL_Logs/logs/ContactCenter/`uname -n`_contcentflatten.log 2>&1

PRD
   #CONTCENTCENTERFLATTEN
00 17 * * * /ptxe4t/3rdparty/cron_files/cron_tx_run_contcent_flatten.sh > /ptxe4t/ETL_Logs/logs/ContactCenter/`uname -n`_contcentflatten.log 2>&1

----------------------------
6. Enable Cron Jobs 
----------------------------
Enable cron - cron_tx_run_contcent.sh
Enable Cron - cron_tx_run_contcent_forecast.sh
