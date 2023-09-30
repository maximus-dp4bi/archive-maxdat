***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 04/28/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- ---------  ---------------------------------------------
2014/04/24 M.Bhalekar         201.328.5695 TXEB-2514    Open Complaints Incidents in MAXDAT should be closed.
				           TXEB-2516    TXEB Process incidents hourly aborts. 
2014/04/28 Sara               571-294-6487 TXEB-2420 Fix AnswerWaitTime column mapping in cc_f_actuals_queue_interval
                                           TXEB-2546 Forecasts load error :PROJECT_ID is null
           C.Rowland          843.408.1358				           

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_contcent.sh
Disable cron - cron_tx_run_emrs.sh
Disable cron - manage_scheduled_contact_center_jobs.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;	

	*******************************************************************************************	
        M.Bhalekar(Process Incidents)
        ------------------------------------------------------------------------------------
	** Unzip DB_ProcessIncidents_20140424_Mayuresh_1.zip
        ** Run in the order specified below.

        20140423_1823_update_corp_etl_list_lkup.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************		        


       *******************************************************************************************	
       ( Sara - Contact Center)
        ------------------------------------------------------------------------------------
	** Unzip DB_ContactCenter_20140428_Sara_1.zip
        ** Run in the order specified below.

        [Skip this step in UAT - already promoted] 
        100_INSERT_INTO_CC_A_ADHOC_JOB.sql
        
      	** Unzip DB_ContactCenter_20140428_Sara_2.zip
        ** Run in the order specified below.  
        
        100_DELETE_FORECASTS_STAGING_DATA_04-14-2014.sql
        101_DELETE_FORECASTS_STAGING_DATA_04-28-2014.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************

 execute MAXDAT_ADMIN.STARTUP_JOBS;

       
-----------------------
2. KETTLE FILES SECTION
-----------------------

        *******************************************************************************************	
        M.Bhalekar(Process Incidents)
	--------------------------------------------------------------------
	Download AS_ProcessIncidents_20140425_Mayuresh_1.zip
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
	ProcessInc_CaptureNewInc_OLTP_TX.ktr
	ProcessInc_Check_Schedule.ktr
	ProcessInc_Get_LastIncID_CntrlVariable.ktr
	ProcessInc_Set_Inc_look_back_days.ktr
	ProcessInc_Set_LastIncID_CntrlVariable.ktr
	ProcessInc_STG_Insert.ktr
	Set_global_variables.ktr
	Set_Prj_Control_Variable.ktr
	Set_Status_Variables.ktr
	
	--------------------------------------------------------------------
       *******************************************************************************************
       
        *******************************************************************************************	
              Sara(Contact Center)
         --------------------------------------------------------------------

     ****Download AS_ContactCenter_20140428_Sara_1.zip
       	Deploy the following files to the appropriate path****

    [SKIP this step for UAT - code has already been promoted]
       	
    PRD SUPP ttxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/jobs/staging/load_production_planning_staging_tables.kjb
    PRD SUPP ttxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/staging/Cisco/load_production_planning_cisco_staging.kjb
    PRD SUPP ttxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/Cisco/load_CC_S_ACD_INTERVAL.ktr
    
    PRD  ptxe4t/ETL_Scripts/scripts/ContactCenter/implementation/TXEB/jobs/staging/load_production_planning_staging_tables.kjb
    PRD  ptxe4t/ETL_Scripts/scripts/ContactCenter/main/jobs/staging/Cisco/load_production_planning_cisco_staging.kjb
    PRD  ptxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/Cisco/load_CC_S_ACD_INTERVAL.ktr    
   --------------------------------------------------------------------
     *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
 
  [No Sctipts to be promoted this week]

                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
       *******************************************************************************************	
       (Developer create this block AS NEEDED)
        --------------------------------------------------------------------------------------------
        --Execute tx_emrs_load_aaclient_onetime.sh which will populate the new EMRS AA_CLIENt table
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_aaclient_onetime.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_aaclient_onetime.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_aaclient_onetime.sh &
	--------------------------------------------------------------------------------------------
       *******************************************************************************************	
       
       *******************************************************************************************	
              Sara (Contact Center)
               --------------------------------------------------------------------------------------------
       	--Execute manage_adhoc_contact_center_jobs.sh
        [Skip this step for UAT]
       	PRD SUPP     nohup ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
       	PRD          nohup ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_contact_center_jobs.sh &
       	
       	--------------------------------------------------------------------------------------------
        *******************************************************************************************


----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.
  
     *******************************************************************************************	
                Sara (Contact Center)
     --------------------------------------------------------------------------------------------
     
       ****Download DB_ContactCenter_20140428_Sara_2.zip
       	Deploy the following files to the following path****
     
     /ptxe4t/3rdparty/maxdat/files/forecasts/Inbound
     
     20140428_MAXDat_Agent_Need_Report.csv
     20140428_MAXDat_Agent_Usage_Report.csv
     20140428_MAXDat_Production_Plan_Parameters.csv
     20140428_MAXDat_Volume_Data.csv
     20140428_Utilization_Report.csv
     MAXDat_service_metrics.csv
     
     
    --------------------------------------------------------------------------------------------
    *******************************************************************************************
     

----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
Enable cron - manage_scheduled_contact_center_jobs.sh