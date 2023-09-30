***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2013/12/03 A.Antonio - Creation.

******************************************************************************************************

1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- -- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/EMRS/patch
	-- or DB_EMRS_20131203_ARLENE_21.zip

	20131203_1324_EMRS_S_ENROLLMENT_STG_ADHOC.sql



-----------------------
2. KETTLE FILES SECTION
-----------------------

Download AS_EMRS_20131203_ARLENE_29.zip
Files from svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS

Deploy the follow files to the appropriate path
UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 


STG_Load_S_ENROLLMENTS_MEDICAID_adhoc.ktr
STG_Load_S_ENROLLMENTS_CHIP_adhoc.ktr

-----------------------
3. UNIX SCRIPT SECTION
-----------------------

DOwnload AS_EMRS_20131203_ARLENE_30.zip 
Files from svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts


Deploy the follow files to the appropriate path
UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts 
PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

tx_emrs_load_enrl_adhoc.sh

Run dos2unix for the following List 
	tx_emrs_load_enrl_adhoc.sh

chmod 755 tx_emrs_load_enrl_adhoc.sh
