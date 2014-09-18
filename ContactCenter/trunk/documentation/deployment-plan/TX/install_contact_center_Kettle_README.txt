Instructions to install TX Kettle Scripts

********************************************************************************

Prerequisites: 
1. Deploy Contact Center database tables per instructions in install_contact_center_DB_README.txt

	svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TX/doc/install_contact_center_DB_README.txt

2. Install Core config files

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Config
	-- [ENV] should be replaced with the appropriate suffix for the appropriate destination environment, DEV/INT/PRD/UAT
	
	cp [ENV].profile ~/.profile
	cp [ENV]_kettle.properties $MAXDAT_KETTLE_DIR/.kettle/kettle.properties
	????? cp shared.xml /u01/maximus/maxdat-[ENV]/TX/config/.kettle/shared.xml
	
3. Verify Connectivity to Source Databases
	
	Verify that the network connectivity to the source databases has been opened with telnet.
	
	telnet 10.237.58.22 1433
	telnet auspfrmdb 1433
	
		
----------------------------
1. DEPLOY KETTLE SCRIPTS AND CONFIGURATION FILES
----------------------------

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TX/

	Upload application server deployment bundle, AS_INITIAL_LOAD_CONTACT_CENTER_20130923_Clay_v0.1.zip
	Upload install script, install_and_initialize_contact_center_20130923_v0.1.sh

	Run install_and_initialize_contact_center_20130923_v0.1.sh (contents below for review) in the same directory as AS_INITIAL_LOAD_CONTACT_CENTER_20130923_Clay_v0.1.zip.
	
	[
		#!/bin/sh
		. ~/.profile

		# CREATE CONTACT CENTER ETL DIRECTORIES
		mkdir $MAXDAT_ETL_PATH/scripts/ContactCenter
		mkdir $MAXDAT_ETL_PATH/logs/ContactCenter

		# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
		unzip AS_INITIAL_LOAD_CONTACT_CENTER_20130923_Clay_v0.1.zip $MAXDAT_ETL_PATH/ContactCenter

		# MAKE SCRIPTS EXECUTABLE
		chmod 755 $MAXDAT_ETL_PATH/ContactCenter/main/bin/*.sh

		# RUN CONTACT CENTER INITIALIZE JOB
		nohup $MAXDAT_ETL_PATH/ContactCenter/main/bin/run_initialize_contact_center.sh &
	]
	
	
-------------
3. SMOKE TEST
-------------

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TX/AS_INITIAL_LOAD_CONTACT_CENTER_20130923_Clay_v0.1.zip
	
	nohup $MAXDAT_ETL_PATH/ContactCenter/main/bin/run_smoke_test.sh &
	
-------------
4. SCHEDULE CRON JOB 
-------------
	
	Schedule the job to be run at 03:00 am.
	
	crontab -e
	0 3 * * * /ptxe4t/ETL_scripts/scripts/ContactCenter/main/bin/run_load_contact_center.sh




	