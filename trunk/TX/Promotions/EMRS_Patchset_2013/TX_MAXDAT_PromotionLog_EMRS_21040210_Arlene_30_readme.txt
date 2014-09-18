***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2014/02/10 A.Antonio - Creation.

Promote EMRS changes - Load CHIP and PERI notifications

******************************************************************************************************


-----------------------
1. KETTLE FILES SECTION
-----------------------

*******************************************************************************************	
        A. Antonio (EMRS)
	--------------------------------------------------------------------
	Download AS_EMRS_20140210_ARLENE_39.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS  

	
	DIM_Load_NOTIFICATIONS_CHIP_ONETIME.ktr
	DIM_Load_NOTIFICATIONS_PERI_ONETIME.ktr
	ETL_Load_Notifications_OneTime.kjb
	DIM_Load_NOTIFICATIONS_PERI.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

-----------------------
3. ADHOC SH SCRIPT SECTION
-----------------------


	*******************************************************************************************	
	A. Antonio (EMRS)
	--------------------------------------------------------------------

	--Execute tx_emrs_load_notifications_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &

	--------------------------------------------------------------------
       *******************************************************************************************