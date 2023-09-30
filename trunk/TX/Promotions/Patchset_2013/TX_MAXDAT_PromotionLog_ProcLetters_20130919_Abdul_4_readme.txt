***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/09/19 Abdul Farhan - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
	
       -- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ProcessLetters/patch
	-- or DB_ProcLetters_20130919_ABDUL_4.zip

       insert_CORP_INSTANCE_CLEANUP_TABLE.sql
        
       

        


-----------------------
2. KETTLE FILES SECTION
-----------------------
Download AS_ProcLetters_20130919_ABDUL_4.zip
and deploy to <MAXDAT_ETL_PATH> 

        -- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/ProcessLetters

         

Process_Letters_runall.kjb
ProcessLetters_update11.ktr
ProcessLetters_Cleanup.ktr