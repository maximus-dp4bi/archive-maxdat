***** MODIFICATION HISTORY ****************************************************************************
Instructions for Emergency Deploy of Process incidents 01/31/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/01/30 Raj A.              361-228-5588    Deploy performance improved ktrs and some bug fixes.
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
NONE

-----------------------
1. DB SCRIPTS SECTION
-----------------------
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

        Raj A. (Process Incidents)
	--------------------------------------------------------------------
	Download AS_TXEB_PI_20140130_RAJ.zip
	OR
	Fetch files from svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ProcessIncidents

	and Deploy the following files to the appropriate path
	UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessIncidents
	ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessIncidents
	PRD      DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessIncidents

	ProcessInc_Get_LastIncID_CntrlVariable.ktr
	Process_Incidents_RUN_ALL.kjb
        ProcessInc_CaptureNewInc_OLTP_TX.ktr
        Get_Updates_From_OLTP_TX.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
       *******************************************************************************************	
No changes
	
       *******************************************************************************************			
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
 
No Changes

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     
----------------------------
6. Enable Cron Jobs 
----------------------------
NONE
