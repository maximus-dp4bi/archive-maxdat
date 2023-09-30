Instructions to install TX Kettle Scripts

********************************************************************************

Prerequisites: 
1. Deploy Contact Center database tables per instructions in install_contact_center_DB_README.txt

	svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TXEB/doc/install_contact_center_DB_README.txt

2. Install Core config files

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Config
	-- [ENV] should be replaced with the appropriate suffix for the appropriate destination environment, DEV/INT/PRD/UAT
	
	cp [ENV].profile ~/.profile
	cp [ENV]_kettle.properties $MAXDAT_KETTLE_DIR/.kettle/kettle.properties
	
3. Verify Connectivity to Source Databases
	
	Verify that the network connectivity to the source databases has been opened with telnet.
	
	telnet 10.237.58.22 1433
	telnet auspfrmdb 1433
	
		
----------------------------
1. DEPLOY KETTLE SCRIPTS AND CONFIGURATION FILES
----------------------------

	-- All files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TXEB/

	#Run the following commands
	mkdir $MAXDAT_ETL_PATH/ContactCenter
	mkdir $MAXDAT_ETL_LOGS/ContactCenter

	Deploy all files and subdirectories from AS_INITIAL_LOAD_CONTACT_CENTER_20130923_Clay_v0.1.zip
	   to $MAXDAT_ETL_PATH/ContactCenter

	#Run dos2unix on the folloing files in $MAXDAT_ETL_PATH/ContactCenter/main/bin
	run_initialize_contact_center.sh
	run_load_contact_center.sh
	run_smoke_test.sh

	#Run chmod +x on the folloing files in $MAXDAT_ETL_PATH/ContactCenter/main/bin
	run_initialize_contact_center.sh
	run_load_contact_center.sh
	run_smoke_test.sh

	#Add the following to the jdbc.properties file

#  CONTACT CENTER DATA SOURCES
#BLUE PUMPKIN WFM SCHEMA
BluePumpkin/type=javax.sql.DataSource
BluePumpkin/driver=net.sourceforce.jtds.jdbc.Driver
BluePumpkin/url=jdbc:jtds:sqlserver://165.184.69.35/BPMAINDB
BluePumpkin/user=reports1
BluePumpkin/password=[INSERT PASSWORD]

#EB HDS ACD SCHEMA
EBHDS/type=javax.sql.DataSource
EBHDS/driver=net.sourceforge.jtds.jdbc.Driver
EBHDS/url=jdbc:jtds:sqlserver://165.184.69.33
EBHDS/user=WFM
EBHDS/password=[INSERT PASSWORD]


	#Add the following to the shared.xml file
 #<connection>
    #<name>JNDI_ACD_SOURCE</name>
    #<server/>
    #<type>ORACLE</type>
    #<access>JNDI</access>
    #<database>EBHDS</database>
    #<port>-1</port>
    #<username/>
    #<password>Encrypted </password>
    #<servername/>
    #<data_tablespace/>
    #<index_tablespace/>
    #<attributes>
      #<attribute><code>PORT_NUMBER</code><attribute>-1</attribute></attribute>
    #</attributes>
  #</connection>

  #<connection>
    #<name>JNDI_WFM_SOURCE</name>
    #<server/>
    #<type>SQLSERVER</type>
    #<access>JNDI</access>
    #<database>BluePumpkin</database>
    #<port>-1</port>
    #<username/>
    #<password>Encrypted </password>
    #<servername/>
    #<data_tablespace/>
    #<index_tablespace/>
    #<attributes>
      #<attribute><code>PORT_NUMBER</code><attribute>-1</attribute></attribute>
    #</attributes>
  #</connection>




-------------
3. SMOKE TEST
-------------

	-- Files can be found at:
	-- svn://rcmxapp1d.maximus.com/maxdat/Contact Center/TXEB/AS_INITIAL_LOAD_CONTACT_CENTER_20130923_Clay_v0.1.zip
	
	nohup ksh -x $MAXDAT_ETL_PATH/ContactCenter/main/bin/run_smoke_test.sh > $MAXDAT_ETL_LOGS/ContactCenter/run_smoke_test.out &
	
-------------
4. SCHEDULE CRON JOB 
-------------
	
	Schedule the job to be run at 03:00 am.
	
	crontab -e
	0 3 * * * /ptxe4t/ETL_scripts/scripts/ContactCenter/main/bin/run_load_contact_center.sh




	