***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 02/03/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------

2014/01/30 Raj A.              361-228-5588    Deploy performance improved ktrs and some bug fixes.
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh

-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

       *******************************************************************************************

       Raj A. (Process Incidents)
	--------------------------------------------------------------------
	Download AS_TXEB_PI_20140130_RAJ.zip
	OR
	Fetch files from svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ProcessIncidents

	and Deploy the following files to the appropriate path
	UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessIncidents
	ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessIncidents
	PRD      DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessIncidents

	1.1 ProcessInc_Get_LastIncID_CntrlVariable.ktr
	1.2 Process_Incidents_RUN_ALL.kjb


	Download AS_TXEB_PI_20140130_RAJ.zip
	OR
	Fetch files from svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/scripts/ProcessIncidents


	and Deploy the following files to the appropriate path
	UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessIncidents
	ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessIncidents
	PRD      DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessIncidents

	1.3 ProcessInc_CaptureNewInc_OLTP_TX.ktr
	1.4 Get_Updates_From_OLTP_TX.ktr
	--------------------------------------------------------------------
       *******************************************************************************************