***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2014/01/28 A.Antonio - Creation.

Promote EMRS changes - Increased length of case_cin for cases
		       Bring in missing data for Providers
		       Truncate and reload notifications

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------

	*******************************************************************************************	
        A. Antonio (EMRS)
        ------------------------------------------------------------------------------------
	** Unzip DB_EMRS_20140128_ARLENE_25.zip
        ** Run in the order specified below.

	20140127_1817_cleanup_TX_EMRS_notif_data.sql 
	20140124_1555_alter_emrs_tables.sql
	        
        ------------------------------------------------------------------------------------
       *******************************************************************************************


-----------------------
2. KETTLE FILES SECTION
-----------------------

*******************************************************************************************	
        A. Antonio (EMRS)
	--------------------------------------------------------------------
	Download AS_EMRS_20140128_ARLENE_37.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS  

	DIM_Load_PLANS.ktr 
	DIM_Load_NOTIFICATIONS.ktr
	DIM_Load_NOTIFICATIONS_HIST.ktr 
	DIM_Load_NOTIFICATIONS_CHIP.ktr 
	DIM_Load_NOTIFICATIONS_CHIP_ONETIME.ktr
	STG_Load_S_PROVIDERS.ktr 
	DIM_Load_CARE_SERV_DELIV_AREAS.ktr
	DIM_Load_ENROLLMENT_NOTIF_ONETIME.ktr 
	DIM_Load_ENROLLMENT_NOTIFICATION.ktr
	STG_Load_S_CHIP_PROVIDERS_ADHOC.ktr

	DIM_Load_CHIP_PROVIDER_REF_ADHOC.ktr
	DIM_Load_CHIP_PROVIDERS_ADHOC.ktr
	DIM_Upd_PROVIDERS_ADHOC.ktr
	ETL_Load_CHIP_PROVIDERS_ADHOC.kjb
	ETL_Load_Notifications_OneTime.kjb
	DIM_Load_CASES.ktr
	DIM_Load_SELECTION_MISSING_INFO.ktr
	DIM_Load_SELECTION_MISSING_INFO_ADHOC.ktr
	DIM_Load_SELECTION_MISSING_INFO_ONETIMERUN.ktr
	ETL_Load_Enrollment_Notification.kjb
	DIM_Load_NOTIFICATIONS_PERI.ktr
	EMRS_set_max_med_notif_id.ktr
	EMRS_get_last_med_notif_id.ktr
	STG_Load_S_ENROLLMENTS_CHIP_adhoc.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

-----------------------
3. ADHOC SH SCRIPT SECTION
-----------------------


	*******************************************************************************************	
	A. Antonio (EMRS)
	--------------------------------------------------------------------
       DOwnload AS_EMRS_20140128_ARLENE_38.zip 

	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

		tx_emrs_load_selectionsmi_adhoc.sh
		tx_emrs_load_chip_provider_adhoc.sh
		tx_emrs_load_notifications_adhoc.sh


	Run dos2unix for the following List 
		tx_emrs_load_selectionsmi_adhoc.sh
		tx_emrs_load_chip_provider_adhoc.sh
		tx_emrs_load_notifications_adhoc.sh

	chmod 755 tx_emrs_load_selectionsmi_adhoc.sh
	chmod 755 tx_emrs_load_chip_provider_adhoc.sh
	chmod 755 tx_emrs_load_notifications_adhoc.sh

	--Execute tx_emrs_load_selectionsmi_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_selectionsmi_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_selectionsmi_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_selectionsmi_adhoc.sh &


	--Execute tx_emrs_load_chip_provider_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_provider_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_provider_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_provider_adhoc.sh &

	--Execute tx_emrs_load_notifications_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &

	--------------------------------------------------------------------
       *******************************************************************************************