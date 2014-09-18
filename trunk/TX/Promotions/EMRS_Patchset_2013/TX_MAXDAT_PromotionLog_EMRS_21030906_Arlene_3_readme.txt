***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2013/08/30 A.Antonio - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/createdb
	-- or DB_EMRS_20130906_ARLENE_3.zip

	BIR_CLIENT_PLAN_ELIGIBILITY.sql
	BIR_CLIENT_PLAN_ENRL_STATUS.sql

	--svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/patch
	20130906_2208_cleanup_enrollment_fact.sql
 	
	SPECIAL INSTRUCTIONS:  WAIT FOR approval before running 20130906_2208_cleanup_enrollment_fact.sql.  This will truncate
				data from EMRS_F_ENROLLMENT table.
	

-----------------------
2. KETTLE FILES SECTION
-----------------------
Download AS_EMRS_20130906_ARLENE_3.zip
and deploy to <MAXDAT_ETL_PATH> /EnrollmentDataEMRS directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/EnrollmentDataEMRS/
FACT_Compare_ENROLLMENTS.ktr
FACT_Load_ENROLLMENTS.ktr
FACT_Load_ENROLLMENTS_HIST.ktr


svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS
DIM_Load_CARE_SERV_DELIV_AREAS.ktr
STG_Load_S_ENROLLMENTS.ktr
STG_Load_S_ENROLLMENTS_CHIP_HIST.ktr

-----------------------
3. UNIX SCRIPT SECTION
-----------------------

DOwnload AS_EMRS_20130906_ARLENE_4.zip and
to <MAXDAT_ETL_PATH> directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/
tx_emrs_init_load_enrlfact.sh

Run dos2unix for the following List 
	tx_emrs_init_load_enrlfact.sh

chmod 755 tx_emrs_init_load_enrlfact.sh


