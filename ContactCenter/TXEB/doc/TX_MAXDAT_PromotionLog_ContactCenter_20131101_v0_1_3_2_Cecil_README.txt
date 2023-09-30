----------------------------
1. DB SCRIPTS SECTION
----------------------------

	-- Run these SQL scripts below in the Oracle database as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])


	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TXEB/DB_PATCH_CONTACT_CENTER_20131031_Cecil_v0.1.3.2.zip
	
	Unzip and run the following SQL scripts on the MAXDAT database.
	
	0.1.3.2/000_ALTER_CC_S_ACD_INTERVAL_PRECISION.sql
	0.1.3.2/001_ALTER_CC_F_ACTUALS_QUEUE_INTERVAL_PRECISION.sql
	0.1.3.2/002_INSERT_CC_A_ADHOC_JOB.sql


----------------------------
2. DISABLE CRON JOB
----------------------------
	-- Disable cron job for Contact Center ETL so that the scheduled jobs do not run concurrently with the adhoc job.
	
----------------------------
3. ADHOC SH SCRIPT SECTION
----------------------------
	--Execute manage_adhoc_load_contact_center.sh which will populate data for TXEB for the missed days [10/19-10/30]
	
	nohup $MAXDAT_ETL_PATH/ContactCenter/main/bin/manage_adhoc_load_contact_center.sh &
	
	--Note:  this job will likely take up to 10 hours to complete as it is loading over a week's worth of data.

----------------------------
4. SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
----------------------------
	-- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.

	
----------------------------
5. ENABLE CRON JOB
----------------------------
	-- Enable cron job for Contact Center ETL
