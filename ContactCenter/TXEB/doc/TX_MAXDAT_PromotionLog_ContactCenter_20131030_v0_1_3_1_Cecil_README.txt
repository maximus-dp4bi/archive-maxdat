----------------------------
1. DB SCRIPTS SECTION
----------------------------

	-- Run these SQL scripts below in the Oracle database as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])


	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TXEB/DB_PATCH_CONTACT_CENTER_20131031_Cecil_v0.1.3.1.zip
	
	Unzip and run the following SQL scripts on the MAXDAT database.
	
	0.1.3.1/000_INSERT_CC_A_ADHOC_JOB.sql
	0.1.3.1/001_CREATE_REPLACE_CC_F_ACTUALS_QUEUE_INTERVAL_SV.sql

----------------------------
2. KETTLE FILES SECTION
----------------------------

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TXEB/

	Upload application server deployment bundle, AS_PATCH_CONTACT_CENTER_20131031_Cecil_v0.1.3.1.zip


	# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
	unzip -o AS_PATCH_CONTACT_CENTER_20131031_Cecil_v0.1.3.1.zip -d $MAXDAT_ETL_PATH/ContactCenter

	# MAKE SCRIPTS EXECUTABLE
	chmod 755 $MAXDAT_ETL_PATH/ContactCenter/main/bin/*.sh

	# FIX WINDOWS EOL CHARACTERS
	dos2unix $MAXDAT_ETL_PATH/ContactCenter/main/bin/manage_adhoc_load_contact_center.sh
	
----------------------------
3. ADHOC SH SCRIPT SECTION
----------------------------
	--Execute manage_adhoc_load_contact_center.sh which will populate data for TXEB for the missed days [10/19-10/30]
	
	nohup $MAXDAT_ETL_PATH/ContactCenter/main/bin/manage_adhoc_load_contact_center.sh &