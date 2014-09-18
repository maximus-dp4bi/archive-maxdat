***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2014/03/03 A.Antonio - Creation.

Adhoc script to extract missing selection transaction data

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------

	*******************************************************************************************	
        A. Antonio (EMRS)
        ------------------------------------------------------------------------------------
	** Unzip DB_EMRS_20140303_ARLENE_26.zip
        ** Run in the order specified below.

	20140303_1658_ins_emrs_run_date_control.sql
	        
        ------------------------------------------------------------------------------------
       *******************************************************************************************


-----------------------
2. KETTLE FILES SECTION
-----------------------

	*******************************************************************************************	
        A. Antonio (EMRS)
	--------------------------------------------------------------------
	Download AS_EMRS_20140303_ARLENE_42.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS  

	
	DIM_Load_SELECTION_MISSING_INFO_ADHOC.ktr
	DIM_Load_SELECTION_TRANSACTION_ADHOC.ktr
	DIM_Load_SELECTION_TRANSACTION_HIST_ADHOC.ktr	
	EMRS_set_adhoc_run_date.ktr
	ETL_Load_Selection_Transactions_Adhoc.kjb
	ETL_Load_Notifications_OneTime.kjb
	--------------------------------------------------------------------
       *******************************************************************************************

----------------------------
3. ADHOC SH SCRIPT SECTION
----------------------------

	*******************************************************************************************	
	A. Antonio (EMRS)
	--------------------------------------------------------------------
       DOwnload AS_EMRS_20140303_ARLENE_43.zip 

	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

		tx_emrs_load_selections_adhoc.sh


	Run dos2unix for the following List 
		tx_emrs_load_selections_adhoc.sh

	chmod 755 tx_emrs_load_selections_adhoc.sh


	--Execute tx_emrs_load_chip_provider_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_provider_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_provider_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_provider_adhoc.sh &

	--Execute tx_emrs_load_selections_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_selections_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_selections_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_selections_adhoc.sh &


	--Execute tx_emrs_load_notifications_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &

	--------------------------------------------------------------------
       *******************************************************************************************