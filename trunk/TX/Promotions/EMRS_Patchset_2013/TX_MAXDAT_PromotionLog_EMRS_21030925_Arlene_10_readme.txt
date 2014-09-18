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
	-- or DB_EMRS_20130925_ARLENE_8.zip

  20130925_1347_cleanup_clients_enrl_fact.sql


-----------------------
2. KETTLE FILES SECTION
-----------------------

Download AS_EMRS_20130925_ARLENE_15.zip
and deploy to <MAXDAT_ETL_PATH> /EnrollmentDataEMRS directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/EnrollmentDataEMRS
FACT_Compare_ENROLLMENTS.ktr
FACT_Load_ENROLLMENTS.ktr

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS

DIM_Load_CLIENTS.ktr
DIM_Load_CLIENTS_HIST.ktr
STG_Load_S_ENROLLMENTS.ktr
DIM_Load_CASES.ktr
DIM_Load_PLANS.ktr

-----------------------
3. UNIX SCRIPT SECTION
-----------------------

DOwnload AS_EMRS_20130925_ARLENE_16.zip and
to <MAXDAT_ETL_PATH> directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/

tx_emrs_init_load11_adhoc.sh


Run dos2unix for the following List 
	tx_emrs_init_load11_adhoc.sh

chmod 755 tx_emrs_init_load11_adhoc.sh