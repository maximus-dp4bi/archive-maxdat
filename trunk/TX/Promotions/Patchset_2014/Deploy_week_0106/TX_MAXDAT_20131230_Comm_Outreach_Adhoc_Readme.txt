***** MODIFICATION HISTORY ****************************************************************************
Instructions for Community Outreach
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2013/12/30 Mayuresh Bhalekar   201-328-5695   Fixed MAXDAT-941


***** MODIFICATION HISTORY ****************************************************************************


-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh

-----------------------
1. DB SCRIPTS SECTION
-----------------------
No Scripts

        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
         Mayuresh Bhalekar (Community  Outreach)
	--------------------------------------------------------------------
	Download AS_COMMUNITYOUTREACH_20131230_MAYURESH_4.zip
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
       *******************************************************************************************

----------------------------
3. ADHOC SH SCRIPT SECTION
----------------------------

DOwnload AS_COMMUNITYOUTREACH_20131230_MAYURESH_SHELL.zip

	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
	  

		tx_run_bpm_ComO.sh

	Run dos2unix for the following List 
		tx_run_bpm_ComO.sh		

	chmod 755 tx_run_bpm_ComO.sh


       *******************************************************************************************	
       
        --Execute tx_run_bpm_ComO.sh which will populate the Community outreach ETL staging
	UAT            nohup /dtxe4t/ETL_Scripts/scripts/tx_run_bpm_ComO.sh &
        PROD SUPP      nohup /ttxe4t/ETL_Scripts/scripts/tx_run_bpm_ComO.sh &
	PROD           nohup /ptxe4t/ETL_Scripts/scripts/tx_run_bpm_ComO.sh &
	--------------------------------------------------------------------------------------------
       *******************************************************************************************	


----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
