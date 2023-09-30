***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/09/05 Mayuresh Bhalekar - Creation.

******************************************************************************************************
-----------------
1. STOP BPM JOBS
-----------------

execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;


-----------------------
2. DB SCRIPTS SECTION
-----------------------
	
-- All files can be found at:
        -- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/CommunityOutreach/createdb
        -- or (TXEB) svn://rcmxapp1d.maximus.com/maxdat/BPM/(TXEB)/CommunityOutreach/createdb
        -- or DB_CommunityOutreach_20130916_MAYURESH_1_CORP.zip
        --  and DB_CommunityOutreach_20130916_MAYURESH_1_TXEB.zip   

        Run order 

        1.  create_ETL_CommunityOutreach_tables.sql
        2.  create_ETL_CommunityOutreach_sequences.sql 
        3.  create_ETL_CommunityOutreach_triggers.sql
        4.  INSERT_CORP_ETL_CONTROL.sql
        5.  (TXEB) insert_CORP_ETL_LIST_LKUP.sql	 	
        6.  (TXEB) insert_SURVEY_LKUP.sql
        7.  populate_lkup_tables.sql
        8.  (TXEB) populate_BPM_EVENT_MASTER.sql
        9.  populate_BPM_ATTRIBUTE_LKUP.sql
       10.  populate_BPM_ATTRIBUTE.sql
       11.  populate_BPM_ATTRIBUTE_STAGING_TABLE.sql
       12.  SemanticModel_CommunityOutreach.sql
       13.  CommunityOutreach_pkg.sql 
       14.  (TXEB) BPM_EVENT_PROJECT_pkg_body.sql
       15.  (TXEB) BPM_SEMANTIC_PROJECT_pkg_body.sql


-----------------
3. START BPM JOBS
-----------------

execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

-----------------------
4. KETTLE FILES SECTION
-----------------------
Download AS_INITIAL_KETTLE_CORP_COMMUNITYOUTREACH_1.zip
and deploy to <MAXDAT_ETL_PATH> /CommunityOutreach directory

OR
svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/CommunityOutreach

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



