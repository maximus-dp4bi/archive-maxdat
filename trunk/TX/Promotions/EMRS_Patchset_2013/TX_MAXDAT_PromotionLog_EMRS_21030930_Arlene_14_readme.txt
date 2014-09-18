***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2013/09/30 A.Antonio - Creation.

******************************************************************************************************


-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/patch
	-- or DB_EMRS_20130930_ARLENE_11.zip

	20130930_0941_alter_case_client_stg.sql

-----------------------
2. KETTLE FILES SECTION
-----------------------

Download AS_EMRS_20130930_ARLENE_20.zip
and deploy to <MAXDAT_ETL_PATH> /EnrollmentDataEMRS directory


svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/EnrollmentDataEMRS
DIM_Load_DAILY_CASE_REF.ktr
DIM_Load_DAILY_CLIENT_REF.ktr
DIM_Load_DAILY_PROVIDER_REF.ktr
STG_Load_S_CLIENT_STATUS.ktr

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS

STG_Load_S_PROVIDERS.ktr
STG_Load_S_CLIENTS.ktr
STG_Load_S_CLIENT_ELIGIBILITY.ktr

