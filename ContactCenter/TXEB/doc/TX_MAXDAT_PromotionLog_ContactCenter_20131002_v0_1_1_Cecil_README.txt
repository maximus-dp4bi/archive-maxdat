


-----------------------
1. DB SCRIPTS SECTION
-----------------------

	-- Run these SQL scripts below in your new database as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])


	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TXEB/DB_PATCH_CONTACT_CENTER_20131002_Cecil_v0.1.1.zip
	
	Unzip and run the following SQL scripts on the MAXDAT database.
	

	000_CREATE_CC_L_PATCH_LOG.sql
	004_CREATE_CC_S_CALL_DETAIL_SV.sql
	010_ALTER_CC_F_AGENT_BY_DATE_PRECISION.sql
	011_ALTER_CC_S_ACD_AGENT_ACTIVITY_PRECISION.sql
	012_INSERT_CC_L_PATCH.sql
	013_INSERT_CC_C_LOOKUP.sql
	014_UPDATE_TMP_ACTUALEVENTTIMELINE_PK.sql	

-----------------------
2. KETTLE FILES SECTION
-----------------------


	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TXEB/

	Upload application server deployment bundle, AS_PATCH_CONTACT_CENTER_20131002_Cecil_v0.1.1.zip


	# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
	unzip -o AS_PATCH_CONTACT_CENTER_20131002_Cecil_v0.1.1.zip -d $MAXDAT_ETL_PATH/ContactCenter

	# MAKE SCRIPTS EXECUTABLE
	chmod 755 $MAXDAT_ETL_PATH/ContactCenter/implementation/HIHIX/bin/*.sh
	
	nohup /ptxe4t/ETL_scripts/scripts/ContactCenter/main/bin/run_load_contact_center.sh &

	Please send the log file for our review, which should be found at the following path:
	
	$MAXDAT_ETL_LOGS/ContactCenter/load_Contact_Center201310DD_HHMMSS.log
	
	where DD_HHMMSS is the day and time that the script was run.
	
	