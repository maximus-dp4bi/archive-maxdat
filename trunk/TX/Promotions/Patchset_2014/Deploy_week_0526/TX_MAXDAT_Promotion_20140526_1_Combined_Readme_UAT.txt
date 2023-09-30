***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 05/26/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/05/26 Sara                571-294-6487  MAXDAT-1149 Agent turnover is not being captured
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------

Disable cron - cron_tx_run_contcent.sh ( Make sure that the cron job is not running )


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

       *******************************************************************************************	
        Sara (Contact Center)
        ------------------------------------------------------------------------------------
	** Download and run the following
            100_ALTER_CC_S&CC_D_AGENT.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	


-----------------------
1. KETTLE FILES SECTION
-----------------------
       *******************************************************************************************	
        Sara (Contact Center)
	--------------------------------------------------------------------
	
	---- Create Contact Center one time jobs directory	
	
	UAT         mkdir  dtxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/jobs/One_time

	
	
	Download AS_ContactCenter_20140526_Sara_1.zip
	Deploy the follow files to the appropriate path
	
	  UAT      dtxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/jobs/One_time


	one_time_load_update_agents.kjb
	one_time_load_update_cc_s_agent.ktr
	one_time_load_update_cc_d_agent.ktr
	
	--------------------------------------------------------------------
	        Sara (Contact Center)
        --------------------------------------------------------------------
		AS_ContactCenter_20140526_Sara_1.zip
		Deploy the follow files to the appropriate path
		
		  UAT      dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/BluePumpkin

	
	 load_CC_S_AGENT.ktr
	 
		  UAT      dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/dimensional

	 
        manage_CC_D_AGENT.ktr
		
	--------------------------------------------------------------------
	
  *******************************************************************************************  
       

-----------------------
2. UNIX SCRIPT SECTION
-----------------------
	
       
        *******************************************************************************************	
        Sara (Contact Center)
        --------------------------------------------------------------------
	AS_ContactCenter_20140526_Sara_1.zip
	Deploy the follow files to the appropriate path
	
	UAT      dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin 

       	
       	run_cc_one_time_agent_fix.sh
       	
       	**Run dos2unix for the following List
       	
       	  run_cc_one_time_agent_fix.sh
       	  
       	 ** chmod 755
       	   run_cc_one_time_agent_fix.sh
       	 

	--------------------------------------------------------------------
       *******************************************************************************************  
       
----------------------------
3. ADHOC SH SCRIPT SECTION
----------------------------

       
       
       *******************************************************************************************	
       Sara (Contact Center)
        --------------------------------------------------------------------------------------------

	UAT	     nohup dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_cc_one_time_agent_fix.sh &

       -------------------------------------------------------------------------------------------------	
	
       *******************************************************************************************         
       
----------------------------
4. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_contcent.sh
      