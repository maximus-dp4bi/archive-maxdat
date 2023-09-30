***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2013/11/18 A.Antonio - Creation.

******************************************************************************************************

1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at (see below) or DB_EMRS_20131118_ARLENE_19.zip

NOTE : Please run in the order specified below.

        svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/createdb/EMRS_D_AA_CLIENT.sql
        svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/createdb/AA_CLIENT_PK.sql
        svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/createdb/EMRS_D_AA_CLIENT_CONSTRAINT.sql

        svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/EMRS/patch/20131111_1101_enrollment_fact_views.sql

        svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/createdb/BIR_AA_CLIENT.sql
        svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/createdb/BUR_AA_CLIENT.sql



-----------------------
2. KETTLE FILES SECTION
-----------------------

Download AS_EMRS_20131118_ARLENE_27.zip
Files from svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS and
Files from svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/EnrollmentDataEMRS

Deploy the follow files to the appropriate path
UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 


STG_Load_S_ENROLLMENTS.ktr
FACT_Load_ENROLLMENTS.ktr
DIM_Load_AA_CLIENT_HIST.ktr
DIM_Load_AA_CLIENT.ktr
ETL_Load_AA_Dimensions.kjb

-----------------------
3. UNIX SCRIPT SECTION
-----------------------

DOwnload AS_EMRS_20131118_ARLENE_28.zip 
Files from svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts


Deploy the follow files to the appropriate path
UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts 
PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

tx_emrs_load_aaclient_onetime.sh

Run dos2unix for the following List 
	tx_emrs_load_aaclient_onetime.sh

chmod 755 tx_emrs_load_aaclient_onetime.sh


