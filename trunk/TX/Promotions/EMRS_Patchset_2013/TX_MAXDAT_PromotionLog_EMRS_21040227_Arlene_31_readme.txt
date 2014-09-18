***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB EMRS
----------------
2014/02/27 A.Antonio - Creation.

Removed the ktr that populates the notifications bridge table.
Moved the notifications load at the end in the main job.

******************************************************************************************************


-----------------------
1. KETTLE FILES SECTION
-----------------------

*******************************************************************************************	
        A. Antonio (EMRS)
	--------------------------------------------------------------------
	Download AS_EMRS_20140227_ARLENE_41.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS  

	
	ETL_Enrollment.kjb
	ETL_Load_Enrollment_Notification.kjb
	STG_Load_S_PROVIDERS.ktr	
	--------------------------------------------------------------------
       *******************************************************************************************

