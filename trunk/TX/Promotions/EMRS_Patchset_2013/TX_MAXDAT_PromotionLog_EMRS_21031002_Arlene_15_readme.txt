***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2013/10/02 A.Antonio - Creation.

******************************************************************************************************


-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/patch
	-- or DB_EMRS_20131002_ARLENE_12.zip

	20131001_1404_cleanup_dup_enrl_fact.sql

	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/createdb
	
	EMRS_S_COST_SHARE_STG.sql

-----------------------
2. KETTLE FILES SECTION
-----------------------

Download AS_EMRS_20131002_ARLENE_21.zip
and deploy to <MAXDAT_ETL_PATH> /EnrollmentDataEMRS directory


svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/EnrollmentDataEMRS

ETL_Load_Clients.kjb

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS

ETL_Enrollment.kjb
ETL_Load_Enrollment_Fact.kjb
FACT_Upd_ENROLL_COST_SHARE.ktr
STG_Load_S_COST_SHARE.ktr
STG_Load_S_ENROLLMENTS.ktr