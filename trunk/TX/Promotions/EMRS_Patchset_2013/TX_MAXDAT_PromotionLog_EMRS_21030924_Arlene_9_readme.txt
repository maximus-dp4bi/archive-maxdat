***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2013/09/24 A.Antonio - Creation.

******************************************************************************************************


-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/patch
	-- or DB_EMRS_20130924_ARLENE_7.zip

	20130920_1629_alter_EMRS_tables.sql
	20130921_1108_cleanup_TX_EMRS_data.sql
	20130906_2208_cleanup_enrollment_fact.sql

Note : Only 20130920_1629_alter_EMRS_tables.sql needs to go to UAT

-----------------------
2. KETTLE FILES SECTION
-----------------------

Download AS_EMRS_20130924_ARLENE_13.zip
and deploy to <MAXDAT_ETL_PATH> /EnrollmentDataEMRS directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/EnrollmentDataEMRS
FACT_Load_ENROLLMENTS.ktr
FACT_Load_ENROLLMENTS_HIST.ktr
DIM_Load_ADDRESS.ktr

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS

DIM_Load_PLANS.ktr
DIM_Load_PROVIDERS.ktr
ETL_Load_Cases_Clients_Adhoc.kjb
FACT_Load_ENROLLMENTS_HIST_ADHOC.ktr

-----------------------
3. UNIX SCRIPT SECTION
-----------------------

DOwnload AS_EMRS_20130924_ARLENE_14.zip and
to <MAXDAT_ETL_PATH> directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/

tx_emrs_init_load9_adhoc.sh
tx_emrs_init_load10_adhoc.sh

Run dos2unix for the following List 
	tx_emrs_init_load9_adhoc.sh
	tx_emrs_init_load10_adhoc.sh

chmod 755 tx_emrs_init_load9_adhoc.sh
chmod 755 tx_emrs_init_load10_adhoc.sh


NOTE: The scripts need to be run in this order

	tx_emrs_init_load9_adhoc.sh
	tx_emrs_init_load10_adhoc.sh -- can be repeated if rollback segment issue occurs
	tx_emrs_init_load5_notif_chipenrl.sh
	tx_emrs_init_load7_enrlnotif_trans.sh
	tx_emrs_init_load8_address.sh