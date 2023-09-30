Instructions to install HIHIX Kettle Scripts

********************************************************************************

Prerequisites: 
1. Deploy Contact Center database tables per instructions in install_contact_center_DB_README.txt

	svn://rcmxapp1d.maximus.com/maxdat/Contact Center/HIHIX/doc/install_contact_center_DB_README.txt

2. Install Core config files

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/trunk/HIHIX/Config
	-- [ENV] should be replaced with the appropriate suffix for the appropriate destination environment, DEV/INT/PRD/UAT
	
	cp .bash_profile_[ENV] /home/etladmin/.bash_profile
	cp kettle.properties_[ENV] /u01/maximus/maxdat-[ENV]/HCCHIX/config/.kettle/kettle.properties
	cp shared.xml /u01/maximus/maxdat-[ENV]/HCCHIX/config/.kettle/shared.xml
	
	Update MAXDAT username and password in /u01/maximus/maxdat-[ENV]/HCCHIX/config/.kettle/kettle.properties with the appropriate credentials for the environment.
	
3. Install Core environment variables script
	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/trunk/HIHIX/ETL/Scripts
	-- [ENV] should be replaced with the appropriate suffix for the appropriate destination environment, DEV/INT/PRD/UAT
	
	cp set_maxdat_env_variables_[ENV].sh $MAXDAT_ETL_PATH/set_maxdat_env_variables.sh
	
	
----------------------------
1. DEPLOY KETTLE SCRIPTS AND CONFIGURATION FILES
----------------------------

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/HIHIX/

	Upload application server deployment bundle, AS_INITIAL_LOAD_CONTACT_CENTER_20130912_Clay_v0.1.zip
	Upload install script, install_and_initialize_contact_center_20130912_v0.1.sh

	Run install_and_initialize_contact_center_20130912_v0.1.sh (contents below for review) in the same directory as AS_INITIAL_LOAD_CONTACT_CENTER_20130912_Clay_v0.1.zip.
	
	[
		#!/bin/sh
		. /home/etladmin/.bash_profile

		# CREATE CONTACT CENTER ETL DIRECTORIES
		mkdir $MAXDAT_ETL_PATH/scripts/ContactCenter
		mkdir $MAXDAT_ETL_PATH/logs/ContactCenter

		# CREATE CONTACT CENTER FILE PROCESSING DIRECTORIES
		mkdir $ECHOPASS_PATH
		mkdir $ECHOPASS_PATH/Error
		mkdir $ECHOPASS_PATH/Error/ACD
		mkdir $ECHOPASS_PATH/Error/IVR
		mkdir $ECHOPASS_PATH/Error/WFM
		mkdir $ECHOPASS_PATH/Inbound
		mkdir $ECHOPASS_PATH/Inbound/ACD
		mkdir $ECHOPASS_PATH/Inbound/IVR
		mkdir $ECHOPASS_PATH/Inbound/WFM
		mkdir $ECHOPASS_PATH/Inbound_archive
		mkdir $ECHOPASS_PATH/Inbound_archive/ACD
		mkdir $ECHOPASS_PATH/Inbound_archive/IVR
		mkdir $ECHOPASS_PATH/Inbound_archive/WFM
		mkdir $ECHOPASS_PATH/Processing
		mkdir $ECHOPASS_PATH/Processing/ACD
		mkdir $ECHOPASS_PATH/Processing/IVR
		mkdir $ECHOPASS_PATH/Processing/WFM

		# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
		unzip AS_INITIAL_LOAD_CONTACT_CENTER_20130912_Clay_v0.1.zip $MAXDAT_ETL_PATH/ContactCenter

		# MAKE SCRIPTS EXECUTABLE
		chmod 755 $MAXDAT_ETL_PATH/ContactCenter/implementation/HIHIX/bin/*.sh

		# RUN CONTACT CENTER INITIALIZE JOB
		nohup $MAXDAT_ETL_PATH/ContactCenter/implementation/HIHIX/bin/run_initialize_contact_center.sh &
	]
	
	
-------------
3. SMOKE TEST
-------------

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/HIHIX/AS_INITIAL_LOAD_CONTACT_CENTER_20130912_Clay_v0.1.zip
	
	nohup $MAXDAT_ETL_PATH/ContactCenter/implementation/HIHIX/bin/run_smoke_test.sh &
	
-------------
4. SCHEDULE CRON JOB 
-------------
	
	Schedule the job to be run on the hour.
	
	crontab -e
	0 */1 * * * /u01/maximus/maxdat-[ENV]/HCCHIX/ETL/scripts/ContactCenter/implementation/HIHIX/bin/run_load_contact_center.sh




	