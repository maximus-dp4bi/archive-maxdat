***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2013/09/20 A.Antonio - Creation.

******************************************************************************************************


-----------------------
1. DB SCRIPTS SECTION
-----------------------
	Please follow the instructions in  svn://rcmxapp1d.maximus.com/maxdat/BPM/Corp/EMRS/doc/corp_truncate_EMRS.txt

-----------------------
2. KETTLE FILES SECTION
-----------------------

Download AS_EMRS_20130920_ARLENE_11.zip
and deploy to <MAXDAT_ETL_PATH> /EnrollmentDataEMRS directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/EnrollmentDataEMRS
DIM_Load_CLIENT_ENRL_STATUS.ktr
DIM_Load_CLIENT_ENRL_STATUS_HIST.ktr

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/EnrollmentDataEMRS

DIM_Load_CLIENT_ELIGIBILITY.ktr
DIM_Load_CLIENT_ELIGIBILITY_HIST.ktr
DIM_Load_CLIENTS.ktr
DIM_Load_PROVIDERS_HIST.ktr
STG_Load_S_ENROLLMENTS_MEDICAID_HIST.ktr
DIM_Load_CLIENTS_HIST.ktr

-----------------------
3. UNIX SCRIPT SECTION
-----------------------

DOwnload AS_EMRS_20130920_ARLENE_12.zip and
to <MAXDAT_ETL_PATH> directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/
tx_emrs_init_load1_provider_case.sh
tx_emrs_init_load2_clients.sh
tx_emrs_init_load3_client_elig.sh
tx_emrs_init_load4_client_enroll.sh
tx_emrs_init_load5_notif_chipenrl.sh
tx_emrs_init_load6_medenrl.sh
tx_emrs_init_load7_enrlnotif_trans.sh
tx_emrs_init_load8_address.sh

Run dos2unix for the following List 
	tx_emrs_init_load1_provider_case.sh
	tx_emrs_init_load2_clients.sh
	tx_emrs_init_load3_client_elig.sh
	tx_emrs_init_load4_client_enroll.sh
	tx_emrs_init_load5_notif_chipenrl.sh
	tx_emrs_init_load6_medenrl.sh
	tx_emrs_init_load7_enrlnotif_trans.sh
	tx_emrs_init_load8_address.sh

chmod 755 tx_emrs_init_load1_provider_case.sh
chmod 755 tx_emrs_init_load2_clients.sh
chmod 755 tx_emrs_init_load3_client_elig.sh
chmod 755 tx_emrs_init_load4_client_enroll.sh
chmod 755 tx_emrs_init_load5_notif_chipenrl.sh
chmod 755 tx_emrs_init_load6_medenrl.sh
chmod 755 tx_emrs_init_load7_enrlnotif_trans.sh
chmod 755 tx_emrs_init_load8_address.sh

NOTE: The scripts need to be run in this order

	tx_emrs_init_load1_provider_case.sh
	tx_emrs_init_load2_clients.sh
	tx_emrs_init_load3_client_elig.sh
	tx_emrs_init_load4_client_enroll.sh
	tx_emrs_init_load5_notif_chipenrl.sh
	tx_emrs_init_load6_medenrl.sh
	tx_emrs_init_load7_enrlnotif_trans.sh
	tx_emrs_init_load8_address.sh