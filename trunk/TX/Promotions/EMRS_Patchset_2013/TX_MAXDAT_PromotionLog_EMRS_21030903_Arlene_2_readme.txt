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
	-- or DB_EMRS_20130903_ARLENE_2.zip

	EMRS_S_CLIENT_ELIGIBILITY_STG.sql
	EMRS_S_CLIENT_STATUS_STG.sql

	--svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/patch
	20130903_1754_create_stagetabs_syns_grants.sql

-----------------------
2. KETTLE FILES SECTION
-----------------------
Download AS_EMRS_20130903_ARLENE_2.zip
and deploy to <MAXDAT_ETL_PATH> /EnrollmentDataEMRS directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/EnrollmentDataEMRS/
DIM_Load_CLIENT_ENRL_STATUS.ktr
DIM_Upd_PREV_CLIENT_ENRL_STATUS.ktr
STG_Load_S_CLIENT_STATUS.ktr
DIM_Upd_PREV_CLIENT_ELIGIBILITY.ktr
ETL_Load_Client_Enroll_Status.kjb
ETL_Load_Client_Eligibility.kjb


svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS
DIM_Load_CLIENT_ELIGIBILITY.ktr
STG_Load_S_CLIENT_ELIGIBILITY.ktr




