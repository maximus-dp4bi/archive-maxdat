***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2013/09/27 A.Antonio - Creation.

******************************************************************************************************


-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/patch
	-- or DB_EMRS_20130927_ARLENE_9.zip

	20130926_1056_prov_case_client_indexes.sql

	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/createdb

	EMRS_S_CASE_STG.sql
	EMRS_S_CLIENT_STG.sql
	EMRS_S_PROVIDER_STG.sql

-----------------------
2. KETTLE FILES SECTION
-----------------------

Download AS_EMRS_20130927_ARLENE_18.zip
and deploy to <MAXDAT_ETL_PATH> /EnrollmentDataEMRS directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/EnrollmentDataEMRS

DIM_Load_CASES.ktr
DIM_Load_CLIENTS.ktr
DIM_Load_DAILY_CASE_REF.ktr
DIM_Load_DAILY_CLIENT_REF.ktr
DIM_Load_DAILY_PROVIDER_REF.ktr
DIM_Load_PROVIDER_SPECIALTY.ktr
DIM_Load_PROVIDERS.ktr
DIM_Upd_CASES.ktr
DIM_Upd_CLIENTS.ktr
DIM_Upd_PREV_CASES.ktr
DIM_Upd_PREV_CLIENTS.ktr
DIM_Upd_PREV_PROVIDERS.ktr
DIM_Upd_PROVIDERS.ktr
ETL_Load_Cases.kjb
ETL_Load_Clients.kjb
ETL_Load_PROVIDERS.kjb
STG_Compare_CASES.ktr
STG_Compare_CLIENTS.ktr
STG_Compare_PROVIDERS.ktr
FACT_Compare_ENROLLMENTS.ktr
FACT_Load_ENROLLMENTS.ktr

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS

DIM_Load_PLANS.ktr
STG_Load_S_ENROLLMENTS.ktr
STG_Load_S_CLIENTS.ktr
STG_Load_S_CASES.ktr
STG_Load_S_PROVIDERS.ktr
DIM_Load_CLIENTS_HIST.ktr
