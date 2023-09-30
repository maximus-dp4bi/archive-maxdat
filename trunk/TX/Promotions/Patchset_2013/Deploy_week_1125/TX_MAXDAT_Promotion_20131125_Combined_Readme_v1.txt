***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 11/25/2013
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------

2013/11/22 Randall Kolb        512.627.5175  Fix Client Outreach PK.
2013/11/24 Mayuresh Bhalekar   201.328.5695  Fix of Jira# MAXDAT-901	
2013/11/25 A. Antonio	       916.832.8644  Rename EMRS view 
2013/11/25 Clay 	       843.408.1358  Deploy Contact Center v1.6 
2013/11/25 Brian Tahi	       210.722.3895  MFD Performance Tuning

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
	
       
        Randall Kolb - Fix Client Outreach fact primary key and reset queue.
        --------------------------------------------------------------------
        For TXEB UAT, Prod and Prod Fix dbs.
	    ** Unzip DB_ClientOutreach_20131122_RANDALL_1.zip
        ** Run in the order specified below.

          20131122_0904_fix_COR_fact_pk.sql
        
        ------------------------------------------------------------------------------------


         Mayuresh Bhalekar - Fix of Jira# MAXDAT-901.
        --------------------------------------------------------------------
        For TXEB UAT, Prod and Prod Fix dbs.
	   Unzip DB_CommunityOutreach_20131115_MAYURESH_4_CORP.zip
           Run in the order specified below.

          20131115_truncate_etl_dm_comm_outreach.sql
        
        ------------------------------------------------------------------------------------

		
         Cecil Beeland - Create intraday job schedule;  Add skill group filter records;  Add contact queues filter and config records;  Add 2 SYSOUT fields;
        --------------------------------------------------------------------
        For TXEB UAT, Prod and Prod Fix dbs.
	   Unzip DB_PATCH_CONTACT_CENTER_20131121_Cecil_v0.1.6.zip
           Run in the order specified below.

		001_ALTER_CC_S_TMP_CISCO_C_T_INTERVAL.sql
		002_ALTER_CC_S_ACD_INTERVAL.sql
		003_ALTER_CC_F_ACTUALS_QUEUE_INTERVAL.sql
		004_UPDATE_CC_A_SCHEDULED_JOB__CC_A_ADHOC_JOB.sql
		005_CREATE_CC_A_SCHEDULE.sql
		101_CC_C_FILTER_INSERT_MISSING_SKILLS.sql
		102_UPDATE_EBA_AGENT_RECORD.sql
		103_INSERT_CC_A_SCHEDULE.sql
		104_CC_C_FILTER__INSERT_MISSING_QUEUES.sql
		105_CC_C_CONTACT_QUEUE__INSERT_UPDATE_MISSING_QUEUES.sql

        ------------------------------------------------------------------------------------

         A. Antonio - Rename EMRS view.
        --------------------------------------------------------------------
        For TXEB UAT, Prod and Prod Fix dbs.
	   Unzip DB_EMRS_20131125_ARLENE_24.zip
           Run in the order specified below.

          20131122_1334_rename_view.sql
        
        ------------------------------------------------------------------------------------


execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------


        B.Thai (MailFaxDoc) Performance tuning
	--------------------------------------------------------------------
	Download AS_MFDOC_2013122_BRIAN_6.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc

	  ProcessMailFax_CaptureNewDoc_create.ktr
	  ProcessMailFax_Cleanup.ktr
	  ProcessMailFax_copy_to_tmp.ktr
	  ProcessMailFax_Get_ LastDocID_CntrlVariable.ktr
	  ProcessMailFax_Get_gwf_work_identified.ktr
	  ProcessMailFax_Get_MAXe_autolink_Dtl.ktr
	  ProcessMailFax_Get_MAXe_classify_tsk_Dtl.ktr
	  ProcessMailFax_Get_MAXe_IA_tsk_Dtl.ktr
	  ProcessMailFax_Get_MAXe_manual_tsk_Dtl.ktr
	  ProcessMailFax_Get_MAXe_work_tsk_Dtl.ktr
	  ProcessMailFax_set_MAX_DCN.ktr
	  ProcessMailFax_Tmp_to_BPM_Update.ktr
	  ProcessMailFaxUpdates_update1.ktr
	  ProcessMailFaxUpdates_update2.ktr
	  ProcessMailFaxUpdates_update3.ktr
	  ProcessMailFaxUpdates_update4.ktr
	  ProcessMailFaxUpdates_update5.ktr
	  ProcessMailFaxUpdates_update6.ktr
	  ProcessMailFaxUpdates_update7.ktr
	  ProcessMailFaxUpdates_update8.ktr
	--------------------------------------------------------------------

 
          Mayuresh Bhalekar - Fix of Jira# MAXDAT-901.
	  --------------------------------------------------------------------
          Download AS_COMMUNITYOUTREACH_20131115_MAYURESH_3.zip
          Deploy the follow files to the appropriate path
	    UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/CommunityOutreach  
            ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/CommunityOutreach  
            PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/CommunityOutreach 


          	Community_Outreach_Get_LastSessionID_cntrlvar.ktr
		CommunityOutreach__Child_temp_to_update.ktr
		CommunityOutreach__temp_to_BPMupdate.ktr
		CommunityOutreach_CaptureChildTable.ktr
		CommunityOutreach_CaptureChildTable_INS2.ktr
		CommunityOutreach_CaptureCommunityActivity_INS3.ktr
		CommunityOutreach_CaptureCommunityActivityDetailsChild.ktr
		CommunityOutreach_CaptureNewJob.ktr
		CommunityOutreach_CaptureNewJob_test.ktr
		CommunityOutreach_Child_Copy_to_temp.ktr
		CommunityOutreach_Child_RunAll.kjb
		CommunityOutreach_Child_temp_to_update.ktr
		CommunityOutreach_Child_Update1.ktr
		CommunityOutreach_CommActivity_RunAll.kjb
		CommunityOutreach_Copy_to_temp.ktr
		CommunityOutreach_Env.ktr
		CommunityOutreach_MainJob_completed.ktr
		CommunityOutreach_OltpDetails.ktr
		CommunityOutreach_RunAll.kjb
		CommunityOutreach_temp_to_BPMupdate.ktr
		CommunityOutreach_Update1.ktr
		CommunityOutreach_Update2.ktr
		CommunityOutreach_Update3.ktr
		CommunityOutreach_Update6.ktr
		CommunityOutreach_Update7.ktr
		CommunityOutreach_Update8.ktr
		CommunityOutreach_Update9.ktr
		CommunityOutreach_updMAX_ctrlVariable.ktr  
      
	
	--------------------------------------------------------------------
	Unzip AS_PATCH_CONTACT_CENTER_20131121_Cecil_v0.1.6.zip

	--	
	UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter 
		# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
		unzip -o AS_PATCH_CONTACT_CENTER_20131121_Cecil_v0.1.6.zip -d dtxe4t/ETL_Scripts/scripts/ContactCenter 
		# MAKE SCRIPTS EXECUTABLE
		chmod 755 dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/*.sh
	--
	ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ContactCenter 
		# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
		unzip -o AS_PATCH_CONTACT_CENTER_20131121_Cecil_v0.1.6.zip -d ttxe4t/ETL_Scripts/scripts/ContactCenter 
		# MAKE SCRIPTS EXECUTABLE
		chmod 755 ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/*.sh
	--
	PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ContactCenter 
		# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
		unzip -o AS_PATCH_CONTACT_CENTER_20131121_Cecil_v0.1.6.zip -d ptxe4t/ETL_Scripts/scripts/ContactCenter 
		# MAKE SCRIPTS EXECUTABLE
		chmod 755 ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/*.sh
	--------------------------------------------------------------------

-----------------------
3. UNIX SCRIPT SECTION
-----------------------

Nothing to do for this deployment		
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

       (Developer create this block AS NEEDED)
        --------------------------------------------------------------------------------------------
        --Execute tx_emrs_load_aaclient_onetime.sh which will populate the new EMRS AA_CLIENt table
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_aaclient_onetime.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_aaclient_onetime.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_aaclient_onetime.sh &
	--------------------------------------------------------------------------------------------


----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.
        
	Cecil Beeland
	--------------------------------------------------------------------------------------------
	-- Update cron_tx_run_contcent.sh job for scheduled execution of Contact Center ETL 15 minutes past each hour
	--	
	UAT
	15 * * * * /dtxe4t/ETL_scripts/scripts/ContactCenter/main/bin/manage_scheduled_contact_center_jobs.sh
	--
	ProdSupp
	15 * * * * /ttxe4t/ETL_scripts/scripts/ContactCenter/main/bin/manage_scheduled_contact_center_jobs.sh
	--
	PROD
	15 * * * * /ptxe4t/ETL_scripts/scripts/ContactCenter/main/bin/manage_scheduled_contact_center_jobs.sh
	 
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_contcent.sh (manage_scheduled_contact_center_jobs.sh)
Enable cron - cron_tx_run_emrs.sh



