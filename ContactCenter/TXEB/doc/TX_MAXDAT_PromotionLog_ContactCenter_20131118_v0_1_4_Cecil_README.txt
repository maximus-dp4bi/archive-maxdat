----------------------------
1. DB SCRIPTS SECTION
----------------------------

	-- Run these SQL scripts below in the Oracle database as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])


	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TXEB/DB_PATCH_CONTACT_CENTER_20131118_Cecil_v0.1.4.zip
	
	Unzip and run the following SQL scripts on the MAXDAT database.
	
	0.1.4/001_ALTER_CALL_DETAIL.sql
	0.1.4/002_Increase_Precision.sql
	0.1.4/003_CREATE_CC_S_TMP_AGENT_SKILL_GROUP.sql
	0.1.4/004_CREATE_TARGET_VIEWS.sql
	0.1.4/005_UPDATE_CISCO_LANDING_TABLES.sql
	0.1.4/101_CC_C_FILTER__INSERT_MISSING_QUEUES.sql
	0.1.4/102_CC_C_CONTACT_QUEUE__INSERT_UPDATE_MISSING_QUEUES.sql
	0.1.4/103_CC_C_UNIT_OF_WORK__INSERT_NEW_UoWs.sql
	0.1.4/104_INSERT_CC_A_ADHOC_JOB.sql
	0.1.4/105_UPDATE_EBA_AGENT_LOGIN_ID.sql
	0.1.4/016_DUPLICATED_AGENT_RECORD_CLEANUP.sql

----------------------------
2. KETTLE FILES SECTION
----------------------------

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TXEB/

	Upload application server deployment bundle, AS_PATCH_CONTACT_CENTER_20131118_Cecil_v0.1.4.zip


	# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
	unzip -o AS_PATCH_CONTACT_CENTER_20131118_Cecil_v0.1.4.zip -d $MAXDAT_ETL_PATH/ContactCenter

	# MAKE SCRIPTS EXECUTABLE
	chmod 755 $MAXDAT_ETL_PATH/ContactCenter/main/bin/*.sh

----------------------------
3. DISABLE CRON JOB
----------------------------
	-- Disable cron job for Contact Center ETL so that the scheduled jobs do not run concurrently with the adhoc job.
	
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
	--Execute manage_adhoc_load_contact_center.sh which will populate data for TXEB for the days missing CC_F_AGENT_BY_DATE data [10/31, 11/06-11/22]
	
	nohup $MAXDAT_ETL_PATH/ContactCenter/main/bin/manage_adhoc_load_contact_center.sh &
	
	--Note:  this job will likely take up to 10 hours to complete as it is loading over a week's worth of data.

----------------------------
5. SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
----------------------------
	-- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.

----------------------------
6. ENABLE CRON JOB
----------------------------
	-- Enable cron job for Contact Center ETL

