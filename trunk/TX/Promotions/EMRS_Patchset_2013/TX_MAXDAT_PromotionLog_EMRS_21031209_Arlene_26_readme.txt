***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2013/12/09 A.Antonio - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- -- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/EMRS/patch
	-- or DB_EMRS_20131209_ARLENE_22.zip

	20131209_1107_EMRS_S_CLIENT_STG_ADHOC.sql

-----------------------
2. KETTLE FILES SECTION
-----------------------

Download AS_EMRS_20131209_ARLENE_31.zip
Files from svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS
Files from svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/EnrollmentDataEMRS

Deploy the follow files to the appropriate path
UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 

DIM_Load_NOTIFICATIONS_CHIP_ONETIME.ktr
DIM_Load_NOTIFICATIONS_CHIP.ktr
STG_Load_S_CASES.ktr
ETL_Load_Enrollment_Notification.kjb
DIM_Upd_CASES.ktr
DIM_Upd_CLIENTS.ktr
ETL_Load_Clients_GENREV_ADHOC.kjb
DIM_Upd_CLIENTS_GENREV_ONETIME.ktr
STG_Load_S_CLIENTS_ONETIME.ktr
STG_Load_S_CLIENTS.ktr

-----------------------
3. UNIX SCRIPT SECTION
-----------------------

DOwnload AS_EMRS_20131209_ARLENE_32.zip 
Files from svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts


Deploy the follow files to the appropriate path
UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts 
PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

tx_emrs_load_client_genrev_onetime.sh
tx_emrs_load_chip_notif_onetime.sh

Run dos2unix for the following List 
	tx_emrs_load_client_genrev_onetime.sh
	tx_emrs_load_chip_notif_onetime.sh

chmod 755 tx_emrs_load_client_genrev_onetime.sh
chmod 755 tx_emrs_load_chip_notif_onetime.sh

--Execute tx_emrs_load_enrl_adhoc.sh which will populate the adhoc client stage table
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_client_genrev_onetime.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_client_genrev_onetime.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_client_genrev_onetime.sh &

--Execute tx_emrs_load_enrl_adhoc.sh which will populate the notifications dimension
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_notif_onetime.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_notif_onetime.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_notif_onetime.sh &