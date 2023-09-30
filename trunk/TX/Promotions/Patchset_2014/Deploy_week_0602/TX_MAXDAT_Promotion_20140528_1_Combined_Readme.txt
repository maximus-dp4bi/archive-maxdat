***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 06/02/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/05/27 M.Bhalekar         201.328.5695  TXEB-2282   Community Outreach - Update Activity Records
2014/06/03 Sara               571-294-6487  TXEB-2716   MAXDAT - TXES CC - activity configurations need updating (Tested in UAT)

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_contcent.sh
Disable cron - cron_tx_run_emrs.sh
Disable cron - cron_tx_run_emrs_medenrl.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT


execute MAXDAT_ADMIN.SHUTDOWN_JOBS;	
	

       *******************************************************************************************	
        M.Bhalekar(Community Outreach)
        ------------------------------------------------------------------------------------
	** Unzip DB_CommunityOutreach_20140527_Mayuresh_1.zip
        ** Run in the order specified below.

        20140527_0913_Add_Activities_upd_ddl.sql
        20140527_0917_populate_CORP_ETL_CONTROL.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	        

 execute MAXDAT_ADMIN.STARTUP_JOBS;
 
 
        *******************************************************************************************	
         Sara(Contact Center)
         ------------------------------------------------------------------------------------
 	** Unzip DB_ContactCenter_20140603_Sara_1.zip
         ** Run in the order specified below.
 
         104_UPDATE_CC_C&CC_D_ACTIVITY_TYPE.sql
         
         ------------------------------------------------------------------------------------
       *******************************************************************************************	

        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
         M.Bhalekar(Community Outreach)
	--------------------------------------------------------------------
	Download AS_CommunityOutreach_20140528_Mayuresh_2.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/CommunityOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/CommunityOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/CommunityOutreach

	Community_Outreach_Get_LastSessionID_cntrlvar.ktr
	CommunityOutreach_Act_Details_Update1.ktr
	CommunityOutreach_Act_OltpDetails.ktr
	CommunityOutreach_Act_OltpDetailsChildDEL.ktr
  	CommunityOutreach_Act_OltpDetailsEX.ktr
	CommunityOutreach_Act_Update1.ktr
	CommunityOutreach_Activity_DetailsCHLD_temp_to_BPMupdate.ktr
	CommunityOutreach_Activity_temp_to_BPMupdate.ktr
	CommunityOutreach_Actv_Chld_Copy_to_temp.ktr
	CommunityOutreach_Actv_Details_Chld_Copy_to_temp.ktr
	CommunityOutreach_CaptureCommunityActivities_Main.kjb
	CommunityOutreach_CaptureCommunityActivity.kjb
	CommunityOutreach_CaptureCommunityActivity_Updates.kjb
	CommunityOutreach_CaptureCommunityActivityDetails.kjb
	CommunityOutreach_CommunityActivitiesDetailsChild_OLTP.ktr
	CommunityOutreach_JobRun_var.ktr
	CommunityOutreach_RunAll.kjb
	--------------------------------------------------------------------
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

	file1.sh
	file2.sh
	file3.sh
	etc
	
	**Run dos2unix for the following List
	dos2unix file1.sh
	dos2unix file2.sh
	dos2unix file3.sh
	etc
	
	** chmod 755
	chmod 755 file1.sh
	chmod 755 file2.sh
	chmod 755 file3.sh
	etc
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
Enable cron - cron_tx_run_emrs_medenrl.sh
