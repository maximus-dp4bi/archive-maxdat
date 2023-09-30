***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2013/11/04 A.Antonio - Creation.

******************************************************************************************************

1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- -- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/EMRS/patch
	-- or DB_EMRS_20131104_ARLENE_18.zip

	20131030_1519_TX_add_fpil_enrl_fact.sql
	20131106_0944_plan_subprogram_views.sql
	20131104_1122_TX_populate_FPL.sql

NOTE : The second script might take a while to execute since it will update all CHIP records
   in the enrollment fact table	

-----------------------
2. KETTLE FILES SECTION
-----------------------

Download AS_EMRS_20131104_ARLENE_26.zip
Files from svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS and
Files from svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/EnrollmentDataEMRS

Deploy the follow files to the appropriate path
UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 


DIM_Load_PLANS.ktr
DIM_Load_SUB_PROGRAMS.ktr
FACT_Upd_ENROLL_COST_SHARE.ktr
STG_Load_S_ENROLLMENTS.ktr
STG_Load_S_COST_SHARE.ktr
FACT_Compare_ENROLLMENTS.ktr
FACT_Load_ENROLLMENTS.ktr