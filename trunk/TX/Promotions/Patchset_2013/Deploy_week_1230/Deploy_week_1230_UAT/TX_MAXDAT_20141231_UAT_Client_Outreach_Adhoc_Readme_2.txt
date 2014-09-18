***** MODIFICATION HISTORY ****************************************************************************
Instructions for Client Outreach initial deployment and adhoc run
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2013/12/31 Mayuresh Bhalekar   201-328-5695  Load 100k records


***** MODIFICATION HISTORY ****************************************************************************

       
-----------------------
1. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
         Mayuresh Bhalekar (Client Outreach)
	--------------------------------------------------------------------
	Download AS_ClientOutreach_20131231_Mayuresh_4.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
	
	Client_Outreach_INS1.ktr
	Client_Outreach_INS2.ktr
	
-	--------------------------------------------------------------------
       *******************************************************************************************

----------------------------
2. ADHOC SH SCRIPT SECTION
----------------------------

       *******************************************************************************************	
       
        --Execute tx_run_bpm_ClnO.sh which will populate the Client outreach ETL staging
        UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_run_bpm_ClnO.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_run_bpm_ClnO.sh &
	
	--------------------------------------------------------------------------------------------
       *******************************************************************************************	

