***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 09/15/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/09/15 Mayuresh B          201.328.5695  TXEB-2579  Commnuity Outreach-Add new attr to Comm Activity table

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


execute MAXDAT_ADMIN.SHUTDOWN_JOBS;	
    
       *******************************************************************************************	
        Mayuresh B.(Community Outreach)
        ------------------------------------------------------------------------------------
	** Unzip DB_CommunityOutreach_20140915_Mayuresh_1.zip
        ** Run in the order specified below.

        20140911_add_contact_f_lname_attr.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************

execute MAXDAT_ADMIN.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       	*******************************************************************************************	
        Mayuresh B.(Community Outreach)
	--------------------------------------------------------------------
	Download AS_CommunityOutreach_20140915_Mayuresh_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/CommunityOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/CommunityOutreach
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/CommunityOutreach 

	CommunityOutreach_Act_OltpDetails.ktr
	CommunityOutreach_Act_Update1.ktr
	CommunityOutreach_Activity_temp_to_BPMupdate.ktr
	CommunityOutreach_Actv_Chld_Copy_to_temp.ktr
	CommunityOutreach_CaptureCommunityActivitiesDetailsChild.ktr
	CommunityOutreach_CaptureCommunityActivity_INS3.ktr
	CommunityOutreach_CommActivity_RunAll.kjb
	--------------------------------------------------------------------
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

