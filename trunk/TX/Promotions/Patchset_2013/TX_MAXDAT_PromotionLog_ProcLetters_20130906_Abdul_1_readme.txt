***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/09/06 Abdul Farhan - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
	-- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ProcessLetters/patch
	-- or DB_ProcLetters_20130906_ABDUL_1.zip

        20130906_1800_ALTER_COLUMNSIZE.sql
        20130906_1800_TRUNCATE_ProcLetters_Semantic.sql  
       

        -- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ProcessLetters/createdb
	-- or DB_ProcLetters_20130906_ABDUL_2.zip

        create_ETL_ProcessLetters_triggers.sql
       



-----------------------
2. KETTLE FILES SECTION
-----------------------
Download AS_ProcLetters_20130906_ABDUL_1.zip
and deploy to <MAXDAT_ETL_PATH> 

        -- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts

         
         3_CDC_Letters_stg.ktr
         