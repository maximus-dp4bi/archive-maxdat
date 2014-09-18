***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 09/01/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/09/01 Cecil Beeland       843-259-6092  MAXDAT - 1602    MAXDAT - Unit of Work Contact Type needed in Contact Center data to Support AMP
2014/09/01 M.Bhalekar          201.328.5695  TXEB-2384   Add Client ID to process incidents 
					     ILEB-3365   MAXDAT PI: ILEB, TXEB & SVN Kettle Code synced up.

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_bpm_daily.sh
Disable cron - cron_tx_run_emrs.sh
Disable cron - cron_tx_run_emrs_medenrl.sh
Disable cron - cron_tx_run_contcent.sh
Disable cron - manage_scheduled_contact_center_jobs.sh
Disable cron - run_exec_flatten_contact_center.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;	

       *******************************************************************************************	
             Cecil (Contact Center)
       -------------------------------------------------------------------------------------------
       	** Unzip DB_CC_20140826_Cecil_1.zip
        ** Run in the order specified below.
       
		   001_ALTER_UNIT_OF_WORK_TABLES.sql
		   100_UPDATE_TX_UNIT_OF_WORK_CATEGORY.sql
               
       -------------------------------------------------------------------------------------------
       *******************************************************************************************  
 
	*******************************************************************************************	
         M.Bhalekar(ProcessIncidents)
        ------------------------------------------------------------------------------------
	** Unzip DB_ProcessIncidents_20140901_Mayuresh_1.zip
        ** Run in the order specified below.

        20140612_1455_CORP_ETL_CONTROL.sql
        20140812_1657_add_Client_ID.sql
        create_ETL_ProcessIncidents_triggers.sql
        DPY_PROCESS_INCIDENTS_pkg.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************       

execute MAXDAT_ADMIN.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

     *******************************************************************************************
              Cecil (Contact Center)
     -------------------------------------------------------------------------------------------
    	Download AS_CC_20140826_Cecil_1.zip
	Deploy the following files to the appropriate path
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/ 
	  Prod     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/ 

	flatten_CC_F_ACTUALS_QUEUE_INTERVAL.ktr
        flatten_CC_F_ACTUALS_IVR_INTERVAL.ktr
        flatten_CC_F_IVR_SELF_SERVICE_USAGE.ktr
	flatten_CC_F_FORECAST_INTERVAL.ktr
    -------------------------------------------------------------------------------------------
    *******************************************************************************************	


	*******************************************************************************************	
        M.Bhalekar(ProcessIncidents)
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
			
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------


----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     

----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_bpm_daily.sh
Enable cron - cron_tx_run_emrs.sh
Enable cron - cron_tx_run_emrs_medenrl.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - manage_scheduled_contact_center_jobs.sh
Enable cron - run_exec_flatten_contact_center.sh

