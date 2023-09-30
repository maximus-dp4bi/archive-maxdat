-------------------------------
1. DB SCRIPTS SECTION
-------------------------------

-- Run these SQL scripts below in the Oracle database as the the Oracle user MAXDAT:  
-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])


-- All files can be found at:					
-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TXEB/DB_PATCH_CONTACT_CENTER_20131121_Cecil_v0.1.6.zip

Unzip and run the following SQL scripts on the MAXDAT database.

0.1.6/001_ALTER_CC_S_TMP_CISCO_C_T_INTERVAL.sql
0.1.6/002_ALTER_CC_S_ACD_INTERVAL.sql
0.1.6/003_ALTER_CC_F_ACTUALS_QUEUE_INTERVAL.sql
0.1.6/004_UPDATE_CC_A_SCHEDULED_JOB__CC_A_ADHOC_JOB.sql
0.1.6/005_CREATE_CC_A_SCHEDULE.sql
0.1.6/101_CC_C_FILTER_INSERT_MISSING_SKILLS.sql
0.1.6/102_UPDATE_EBA_AGENT_RECORD.sql
0.1.6/103_INSERT_CC_A_SCHEDULE.sql
0.1.6/104_CC_C_FILTER__INSERT_MISSING_QUEUES.sql
0.1.6/105_CC_C_CONTACT_QUEUE__INSERT_UPDATE_MISSING_QUEUES.sql

-------------------------------
2. KETTLE FILES SECTION
-------------------------------

-- All files can be found at:
-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TXEB/

Upload application server deployment bundle, AS_PATCH_CONTACT_CENTER_20131121_Cecil_v0.1.6.zip

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

-------------------------------
3. DISABLE EXISTING CRON JOB
-------------------------------
-- Remove existing cron job for Contact Center ETL as it will be replaced by a new cron job.
	
-------------------------------
4. ENABLE NEW CRON JOB
-------------------------------
-- Create new cron job for Scheduled execution of Contact Center ETL

--	
UAT
	15 * * * * /dtxe4t/ETL_scripts/scripts/ContactCenter/main/bin/manage_scheduled_contact_center_jobs.sh
--
ProdSupp
	15 * * * * /ttxe4t/ETL_scripts/scripts/ContactCenter/main/bin/manage_scheduled_contact_center_jobs.sh
--
PROD
	15 * * * * /ptxe4t/ETL_scripts/scripts/ContactCenter/main/bin/manage_scheduled_contact_center_jobs.sh