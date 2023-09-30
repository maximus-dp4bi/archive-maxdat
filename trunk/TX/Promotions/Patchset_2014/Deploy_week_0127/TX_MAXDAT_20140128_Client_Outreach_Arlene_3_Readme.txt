***** MODIFICATION HISTORY ****************************************************************************
Instructions for Client Outreach initial deployment and adhoc run
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/01/28 A. Antonio   916-832-8644   	     Modified queries for the update rules to see if the process will go through


***** MODIFICATION HISTORY ****************************************************************************
        
-----------------------
1. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
         Mayuresh Bhalekar (Client Outreach)
	--------------------------------------------------------------------
	Download AS_ClientOutreach_20140122_Arlene_2.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

	Client_Outreach_UPD21.ktr
	
	--------------------------------------------------------------------
       *******************************************************************************************

----------------------------
2. ADHOC SH SCRIPT SECTION
----------------------------
       *******************************************************************************************	
       
        --Execute tx_run_bpm_ClnO.sh which will populate the Client outreach ETL staging
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_run_bpm_ClnO.sh &
	--------------------------------------------------------------------------------------------
       *******************************************************************************************	
