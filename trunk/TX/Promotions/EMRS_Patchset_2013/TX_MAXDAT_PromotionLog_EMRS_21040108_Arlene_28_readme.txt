***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2014/01/08 A.Antonio - Creation.

Promote EMRS changes - Addition of prov_status_code to Provider table
		       New table for ALERT
		       Modified EMRS_D_CASE_FPIL_SV to get only the latest record per case

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------

	*******************************************************************************************	
        A. Antonio (EMRS)
        ------------------------------------------------------------------------------------
	** Unzip DB_EMRS_20140108_ARLENE_24.zip
        ** Run in the order specified below.

	20131212_0415_EMRS_S_PROVIDER_STG_ADHOC.sql 
	20131212_1328_add_prov_status.sql
	EMRS_D_ALERT.sql 
	20131230_1736_alert_objects.sql

	BIR_ALERTS.sql
	20140103_1156_emrs_d_case_fpil_sv.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************


-----------------------
2. KETTLE FILES SECTION
-----------------------

*******************************************************************************************	
        A. Antonio (EMRS)
	--------------------------------------------------------------------
	Download AS_EMRS_20140108_ARLENE_35.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS  

	DIM_Load_PROVIDERS.ktr 
	STG_Compare_PROVIDERS.ktr 
	ETL_Load_Address.kjb 
	DIM_Load_ALERTS.ktr 
	DIM_Load_ALERTS_ONETIME.ktr 
	STG_Load_S_PROVIDERS_ADHOC.ktr 
	ETL_Load_PROVIDERS_ADHOC.kjb 
	DIM_Upd_PROVIDERS_STATUS_CD.ktr 
	STG_Load_S_PROVIDERS.ktr

	--------------------------------------------------------------------
       *******************************************************************************************

-----------------------
3. ADHOC SH SCRIPT SECTION
-----------------------


	*******************************************************************************************	
	A. Antonio (EMRS)
	--------------------------------------------------------------------
       DOwnload AS_EMRS_20140108_ARLENE_36.zip 

	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

		tx_emrs_load_provider_alert_adhoc.sh

	Run dos2unix for the following List 
		tx_emrs_load_provider_alert_adhoc.sh

	chmod 755 tx_emrs_load_provider_alert_adhoc.sh

	--Execute tx_emrs_load_provider_alert_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_provider_alert_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_provider_alert_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_provider_alert_adhoc.sh &

	--------------------------------------------------------------------
       *******************************************************************************************