***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2013/09/09 A.Antonio - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/patch
	-- or DB_EMRS_20130909_ARLENE_4.zip

	20130906_2208_cleanup_enrollment_fact.sql
	

-----------------------
2. KETTLE FILES SECTION
-----------------------
Download AS_EMRS_20130909_ARLENE_5.zip
and deploy to <MAXDAT_ETL_PATH> /EnrollmentDataEMRS directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/EnrollmentDataEMRS/
DIM_Upd_PREV_CLIENT_ELIGIBILITY.ktr
DIM_Upd_PREV_CLIENT_ENRL_STATUS.ktr


svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS
DIM_Load_PLANS.ktr
STG_Load_S_ENROLLMENTS.ktr
STG_Load_S_ENROLLMENTS_CHIP_HIST.ktr
STG_Load_S_ENROLLMENTS_MEDICAID_HIST.ktr

-----------------------
3. UNIX SCRIPT SECTION
-----------------------

DOwnload AS_EMRS_20130909_ARLENE_6.zip and
to <MAXDAT_ETL_PATH> directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/
tx_emrs_init_load_enrlfact.sh

Run dos2unix for the following List 
	tx_emrs_init_load_enrlfact.sh

chmod 755 tx_emrs_init_load_enrlfact.sh


