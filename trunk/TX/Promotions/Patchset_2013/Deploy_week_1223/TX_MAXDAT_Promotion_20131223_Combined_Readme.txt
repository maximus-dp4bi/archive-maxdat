***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 12/23/2013
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2013/12/23 Mayuresh Bhalekar   201-328-5695   Maxdat-779, Maxdat-917, cleanup for reload, reset global Variables, etc


***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_contcent.sh
Disable cron - cron_tx_run_emrs.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;	

       *******************************************************************************************	
        Mayuresh Bhalekar (Client Outreach)
        ------------------------------------------------------------------------------------
	** Unzip DB_ClientOutreach_20131221_Mayuresh_2_CORP.zip
        ** Run in the order specified below.

        1.20131219_truncate_etl_dm_client_outreach.sql
 	2.Alter_ETL_ClientOutreach_tables.sql
	3.populate_CORP_ETL_CLNT_SURVEY_LKUP.sql
	4.create_ETL_ClientOutreach_triggers.sql
	5.populate_BPM_ATTRIBUTE_LKUP.sql
	6.populate_BPM_LKUP.sql
	7.Alter_SemanticModel_Client_Outreach.sql
	8.CLIENT_OUTREACH_pkg.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	        



execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
         Mayuresh Bhalekar (Client Outreach)
	--------------------------------------------------------------------
	Download AS_ClientOutreach_20131221_Mayuresh_2.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

	Client_Outreach_ActivityLKUP.ktr
	Client_Outreach_copy_TEMP.ktr
	Client_Outreach_env_var.ktr
	Client_Outreach_fetch_OLTP.kjb
	Client_Outreach_Get_CntrlVariable.ktr
	Client_Outreach_get_OLTP.ktr
	Client_Outreach_get_OLTP_County.ktr
	Client_Outreach_get_OLTP_Human_Task.ktr
	Client_Outreach_get_OLTP_Human_Task_Instance.ktr
	Client_Outreach_get_OLTP_Inc_Header.ktr
	Client_Outreach_get_OLTP_Inst_Head_Stat_Hist.ktr
	Client_Outreach_get_OLTP_Inst_Header_Stat_Hist.ktr
	Client_Outreach_get_OLTP_Proc_Notf_lkup.ktr
	Client_Outreach_get_OLTP_Program.ktr
	Client_Outreach_get_OLTP_Step_Inst.ktr
	Client_Outreach_get_OLTP_Surveys.ktr
	Client_Outreach_get_OLTP_Validation.ktr
	Client_Outreach_GetOLTP_SUBPROG.kjb
	Client_Outreach_GetOLTP_SUBPROG.ktr
	Client_Outreach_GetOLTP_SUBPROG_TMP.ktr
	Client_Outreach_INS1.ktr
	Client_Outreach_INS2.ktr
	Client_Outreach_MainJob_completed.ktr
	Client_Outreach_UPD_BPM_Main.ktr
	Client_Outreach_UPD1.ktr
	Client_Outreach_UPD2.ktr
	Client_Outreach_UPD3.ktr
	Client_Outreach_UPD4.ktr
	Client_Outreach_UPD5.ktr
	Client_Outreach_UPD6.ktr
	Client_Outreach_UPD7.ktr
	Client_Outreach_UPD8.ktr
	Client_Outreach_UPD9.ktr
	Client_Outreach_UPD10.ktr
	Client_Outreach_UPD11.ktr
	Client_Outreach_UPD12.ktr
	Client_Outreach_UPD13.ktr
	Client_Outreach_UPD14.ktr
	Client_Outreach_UPD15.ktr
	Client_Outreach_UPD16.ktr
	Client_Outreach_UPD17.ktr
	Client_Outreach_UPD18.ktr
	Client_Outreach_UPD19.ktr
	Client_Outreach_UPD20.ktr
	Client_Outreach_UPD21.ktr
	Client_Outreach_UPD24.ktr
	Client_Outreach_UPD25.ktr
	Client_Outreach_updMAX_ctrlVariable.ktr
	Client_Outreach_updMAX_Event_id_ctrlVariable.ktr
	ClientOutreach_OLTP_details.kjb
	ClientOutreach_runall.kjb
	ClientOutreach_Updates.kjb
-	--------------------------------------------------------------------
       *******************************************************************************************	

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
       *******************************************************************************************	
        (Developer create this block for each AS zip)
        --------------------------------------------------------------------
	Download AS_{SYSTEM}_{YYMMDD}20131118_{DEVELOPER_NAME}_{NUM}.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

	

	--------------------------------------------------------------------
       *******************************************************************************************			
                
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
