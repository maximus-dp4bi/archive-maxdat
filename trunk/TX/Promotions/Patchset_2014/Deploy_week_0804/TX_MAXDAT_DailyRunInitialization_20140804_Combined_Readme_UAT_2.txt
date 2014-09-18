ee***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 08/04/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/08/05 M.Bhalekar          201.328.5695 TXEB-3065 MAXDAT - Decoupling Client Outreach process from hourly run, adding into Daily run and Grouping daily process together. 

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------

Disable cron - cron_run_bpm_daily.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

      *******************************************************************************************	
        B. Thai (Run Initialization and Daily)
        ------------------------------------------------------------------------------------
	** Unzip DB_Run_Init_20140805_Brian_3.zip
        ** Run in the order specified below.

        20140805_0807_upd_Daily_Run_init_ETL_controls.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

    
	*******************************************************************************************	
        M.Bhalekar (Client Outreach)
	--------------------------------------------------------------------
	Download AS_ClientOR_20140804_Mayuresh_2.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach 
	   
	ClientOutreach_runall.kjb
	ClientOUtreach_JobRun_var.ktr	
	--------------------------------------------------------------------
	
	*******************************************************************************************	
        M.Bhalekar (Process Letters)
	--------------------------------------------------------------------
	Download AS_PL_20140804_Mayuresh_2.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessLetters 
	
	Process_Letters_runall.kjb
	ProcessLetters_JobRun_var.ktr
	--------------------------------------------------------------------
	
	
       *******************************************************************************************	
        B. Thai (Run Initialization and Daily)
	--------------------------------------------------------------------
	Download AS_Run_Init_20140804_Brian_3.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/

	Run_Initialization.kjb
	Run_Initialization_Daily.kjb
	Check_Daily_Master_Schedule.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
			
N/A
		
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

N/A

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.
      
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_run_bpm_daily.sh
