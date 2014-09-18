Instructions to install HIHIX Kettle Scripts

********************************************************************************

Prerequisites: 
1. Deploy Contact Center database modifications per instructions in HI_MAXDAT_PromotionLog_DB_20130925_v0_1_1_README.txt

	svn://rcmxapp1d.maximus.com/maxdat/Contact Center/HIHIX/doc/HI_MAXDAT_PromotionLog_DB_20130925_v0_1_1_README.txt

	
----------------------------
1. DEPLOY KETTLE SCRIPTS AND CONFIGURATION FILES
----------------------------

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/HIHIX/

	Upload application server deployment bundle, AS_PATCH_CONTACT_CENTER_20130925_Clay_v0.1.1.zip


	# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
	unzip -o AS_PATCH_CONTACT_CENTER_20130925_Clay_v0.1.1.zip -d $MAXDAT_ETL_PATH/ContactCenter

	# MAKE SCRIPTS EXECUTABLE
	chmod 755 $MAXDAT_ETL_PATH/ContactCenter/implementation/HIHIX/bin/*.sh

