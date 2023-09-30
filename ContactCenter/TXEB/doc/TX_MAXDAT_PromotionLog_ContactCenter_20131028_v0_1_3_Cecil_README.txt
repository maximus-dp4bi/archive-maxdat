
----------------------------
1. UPDATE kettle.properties
----------------------------
	--The TX prd_kettle.properties has been updated to add a missing Contact Center attribute. 
	-- Please update the current kettle.properties in production with svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/config/.kettle/prd_kettle.properties	

----------------------------
2. DB SCRIPTS SECTION
----------------------------

	-- Run these SQL scripts below in the Oracle database as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])


	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TXEB/DB_PATCH_CONTACT_CENTER_20131028_Cecil_v0.1.3.zip
	
	Unzip and run the following SQL scripts on the MAXDAT database.
	
	0.1.2/014_CREATE_CC_S_AGENT_SV.sql
	0.1.3/000_ALTER_CC_C_PATCH_LOG__UNv1.sql
	0.1.3/001_ALTER_CC_D_DATES__DROP_CC_D_DATES_UNV1.sql
	0.1.3/002_UPDATE_CC_D_DATES__D_WEEK_OF_YEAR.sql
	0.1.3/003_Add_CC_A_ADHOC_JOB_table.sql
	0.1.3/004_Add_CC_A_SCHEDULED_JOB_table.sql
	0.1.3/005_CREATE_REPLACE_CC_S_TMP_IVR_STEP_SV.sql
	0.1.3/006_DROP_ADD_CC_S_TMP_CISCO_C_T_INTERVAL.sql
	0.1.3/007_MODIFY_CC_S_ACD_INTERVAL.sql
	0.1.3/008_ALTER_CC_F_ACTUALS_QUEUE_INTERVAL.sql

----------------------------
3. KETTLE FILES SECTION
----------------------------


	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TXEB/

	Upload application server deployment bundle, AS_PATCH_CONTACT_CENTER_20131028_Cecil_v0.1.3.zip


	# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
	unzip -o AS_PATCH_CONTACT_CENTER_20131028_Cecil_v0.1.3.zip -d $MAXDAT_ETL_PATH/ContactCenter

	# MAKE SCRIPTS EXECUTABLE
	chmod 755 $MAXDAT_ETL_PATH/ContactCenter/main/bin/*.sh