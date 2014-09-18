***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 09/01/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/09/01  M.Bhalekar         201.328.5695 TXEB-2384   Add Client ID to process incidents 
					    ILEB-3365   MAXDAT PI: ILEB, TXEB & SVN Kettle Code synced up.

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;	

       *******************************************************************************************	
        (Developer create this block for each DB zip)
        ------------------------------------------------------------------------------------
	** Unzip DB_ProcessIncidents_20140901_Mayuresh_1.zip
        ** Run in the order specified below.

        20140612_1455_CORP_ETL_CONTROL.sql
        20140812_1657_add_Client_ID.sql
        create_ETL_ProcessIncidents_triggers.sql
        DPY_PROCESS_INCIDENTS_pkg.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************        

execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        (Developer create this block for each AS zip)
	--------------------------------------------------------------------
	Download AS_ProcessIncidents_20140901_Mayuresh_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessIncidents
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessIncidents
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessIncidents

	Apply_UPD10_rules_and_load_to_PROCESS_INCIDENTS_WIP_BPM.ktr
	Get_Updates_From_OLTP_TX.ktr
	Process_Incidents_Final_Updates_From_WIP_STG_to_BPM.ktr
	Process_Incidents_Job_Completed.ktr
	Process_Incidents_RUN_ALL.kjb
	Process_Incidents_Updates1_AND_2_From_OLTP_STG_to_WIP_STG.ktr
	Process_Incidents_Updates3_AND_4_From_OLTP_STG_to_WIP_STG.ktr
	Process_Incidents_Updates5_AND_6_AND_7_From_OLTP_STG_to_WIP_STG.ktr
	Process_Incidents_Updates8_AND_9_From_OLTP_STG_to_WIP_STG.ktr
	ProcessInc_Get_LastIncID_CntrlVariable.ktr
	ProcessInc_Set_env_var.ktr
	ProcessInc_Set_Inc_look_back_days.ktr
	ProcessInc_Set_LastIncID_CntrlVariable.ktr
	ProcessInc_STG_Insert.ktr
	Set_global_variables.ktr
	Set_Status_Variables.ktr
	Process_Incidents_Gather Stat_OLTP_WIP.ktr

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

Enable cron - cron_tx_run_bpm.sh

