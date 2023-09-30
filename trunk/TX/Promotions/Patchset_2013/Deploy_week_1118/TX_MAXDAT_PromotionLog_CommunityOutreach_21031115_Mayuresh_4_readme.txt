***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/11/15 Mayuresh Bhalekar - Fix of Jira# MAXDAT-901.

******************************************************************************************************
-----------------
1. STOP BPM JOBS
-----------------

execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;


-----------------------
2. DB SCRIPTS SECTION
-----------------------
	
-- All files can be found at:
        -- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/CommunityOutreach/patch/20131115_truncate_etl_dm_comm_outreach.sql
        -- or DB_CommunityOutreach_20131115_MAYURESH_4_CORP.zip
       

        Run order 

        1.  20131115_truncate_etl_dm_comm_outreach.sql

-----------------
3. START BPM JOBS
-----------------

execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

-----------------------
4. KETTLE FILES SECTION
-----------------------
Download AS_COMMUNITYOUTREACH_20131115_MAYURESH_3.zip
OR
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/CommunityOutreach
Files from

and Deploy the follow files to the appropriate path
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



