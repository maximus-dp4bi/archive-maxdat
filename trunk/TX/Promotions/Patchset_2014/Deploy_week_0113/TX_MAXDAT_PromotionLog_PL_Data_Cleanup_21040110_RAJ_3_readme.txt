******************************************** MODIFICATION HISTORY ***********************************************************************************
Instructions to install TXEB 
-----------------------------
2014/01/10 Raj A. 
1. Deploy performance improved ktr, ProcessLetters_temp_to_WIP_T.ktr
******************************************** MODIFICATION HISTORY ***********************************************************************************

---------------------
1. DISABLE CRON Jobs
---------------------
Disable the Process Letters cron job, i.e., tx_run_bpm_let.sh


-----------------------
2. KETTLE FILES SECTION
-----------------------
Download AS_PL_CODE_TUNING_20140110_RAJ_3
OR
Fetch files from svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ProcessLetters


and Deploy the following files to the appropriate path
UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessLetters
ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessLetters
PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessLetters

2.1.ProcessLetters_temp_to_WIP_T.ktr

---------------------
3. ENABLE CRON Jobs
---------------------
Enable the Process Letters cron job, i.e., tx_run_bpm_let.sh