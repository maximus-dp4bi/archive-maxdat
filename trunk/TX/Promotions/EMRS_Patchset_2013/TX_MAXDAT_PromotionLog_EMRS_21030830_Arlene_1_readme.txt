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
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/patch
	-- or DB_EMRS_20130830_ARLENE_1.zip

        20130830_1311_create_index_client_stat_tables.sql

-----------------------
2. KETTLE FILES SECTION
-----------------------
Download AS_EMRS_20130830_ARLENE_1.zip
and deploy to <MAXDAT_ETL_PATH> /EnrollmentDataEMRS directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/EnrollmentDataEMRS/
DIM_Load_CLIENT_ENRL_STATUS.ktr

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS
DIM_Load_CLIENT_ELIGIBILITY.ktr



