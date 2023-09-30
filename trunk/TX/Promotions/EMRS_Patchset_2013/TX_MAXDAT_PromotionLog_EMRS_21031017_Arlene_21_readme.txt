***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2013/10/17 A.Antonio - Creation.

******************************************************************************************************

1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/patch
	-- or DB_EMRS_20131017_ARLENE_17.zip

	20131017_1001_alter_county_tab.sql
	

-----------------------
2. KETTLE FILES SECTION
-----------------------

Download AS_EMRS_20131017_ARLENE_25.zip


DEPLOY TO <MAXDAT_ETL_PATH> /EnrollmentDataEMRS directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS

DIM_Load_COUNTIES.ktr
STG_Load_S_ENROLLMENTS.ktr