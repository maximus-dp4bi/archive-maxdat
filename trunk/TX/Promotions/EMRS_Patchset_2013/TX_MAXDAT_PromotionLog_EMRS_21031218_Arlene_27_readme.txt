***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2013/12/18 A.Antonio - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- -- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/EMRS/patch
	-- or DB_EMRS_20131218_ARLENE_23.zip

	20131217_1257_emrs_d_case_fpil_sv.sql
	20131217_1654_alter_emrs_tabs.sql

-----------------------
2. KETTLE FILES SECTION
-----------------------

Download AS_EMRS_20131209_ARLENE_31.zip
Files from svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS


Deploy the follow files to the appropriate path
UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 

DIM_Load_NOTIFICATIONS_CHIP_ONETIME.ktr
DIM_Load_NOTIFICATIONS_CHIP.ktr


-----------------------
3. UNIX SCRIPT SECTION
-----------------------


--Execute tx_emrs_load_enrl_adhoc.sh which will populate the notifications dimension
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_notif_onetime.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_notif_onetime.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_notif_onetime.sh &