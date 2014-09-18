

-----------------------
1. DB SCRIPTS SECTION
-----------------------

	-- Run these SQL scripts below in your new database as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])


	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/HIHIX/DB_PATCH_CONTACT_CENTER_20130925_Clay_v0.1.1.zip
	
	Unzip and run the following SQL scripts on the MAXDAT database.
	
	0.1.1/000_CREATE_CC_L_PATCH_LOG.sql
	0.1.1/001_ALTER_CC_S_CALL_DETAIL.sql
	0.1.1/002_CREATE_SEQ_CC_S_IVR_SS_USAGE.sql
	0.1.1/003_CREATE_SEQ_CC_S_IVR_SELF_SERVICE_PATH.sql
	0.1.1/004_CREATE_CC_S_CALL_DETAIL_SV.sql
	0.1.1/005_ALTER_CC_D_IVR_SELF_SERVICE_PATH_VERSION.sql
	0.1.1/006_CREATE_BIU_CC_C_CONTACT_QUEUE.sql
	0.1.1/007_INSERT_IVR_CC_D_UNIT_OF_WORK.sql
	0.1.1/008_ALTER_CC_S_SELF_SERVICE_NODE__UN.sql
	0.1.1/009_ALTER_CC_D_SELF_SERVICE_NODE__UN.sql
	0.1.1/010_ALTER_CC_F_AGENT_BY_DATE_PRECISION.sql
	0.1.1/011_ALTER_CC_S_ACD_AGENT_ACTIVITY_PRECISION.sql
	0.1.1/012_INSERT_CC_L_PATCH.sql
	
-----------------------
2. KETTLE FILES SECTION
-----------------------


	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/HIHIX/

	Upload application server deployment bundle, AS_PATCH_CONTACT_CENTER_20130925_Clay_v0.1.1.zip


	# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
	unzip -o AS_PATCH_CONTACT_CENTER_20130925_Clay_v0.1.1.zip -d $MAXDAT_ETL_PATH/ContactCenter

	# MAKE SCRIPTS EXECUTABLE
	chmod 755 $MAXDAT_ETL_PATH/ContactCenter/implementation/HIHIX/bin/*.sh
	
	