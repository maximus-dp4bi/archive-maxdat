***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB 
----------------
2013/09/17 Abdul Farhan - Creation.

******************************************************************************************************

-----------------------
1. DB SCRIPTS SECTION
-----------------------
	
       -- Run these SQL scripts below as the the Oracle user MAXDAT:  
	-- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])

	-- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/ProcessLetters/patch
	-- or DB_ProcLetters_20130917_ABDUL_3.zip

       20130917_1130_ADD_NEW_TABLES.sql
        
       

        


-----------------------
2. KETTLE FILES SECTION
-----------------------
Download AS_ProcLetters_20130917_ABDUL_3.zip
and deploy to <MAXDAT_ETL_PATH> 

        -- All files can be found at:					
	-- svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/ProcessLetters

         
ProcessLetters_gather_stats.ktr
ProcessLetters_gather_stats_ALL.ktr
ProcessLetters_temp_to_OLTP_T.ktr
ProcessLetters_temp_to_WIP_T.ktr
Process_Letters_runall.kjb
Process_Letters_updates.kjb
ProcessLetters_CaptureChildTable.kjb
ProcessLetters_CaptureChildTable.ktr
ProcessLetters_CaptureChildTable_Main.ktr
ProcessLetters_CaptureNewLetters.ktr
ProcessLetters_copy_to_temp.ktr
ProcessLetters_Get_LastLetterReqID_CntrlVariable.ktr
ProcessLetters_Get_OLTP_details.ktr
ProcessLetters_ProcessLetters_Set_Env_var.ktr
ProcessLetters_set_MAX_LetterReqID.ktr
ProcessLetters_tmp_to_BPM_update.ktr
ProcessLetters_update1.ktr
ProcessLetters_update2.ktr
ProcessLetters_update5.ktr
ProcessLetters_update6.ktr
ProcessLetters_update7.ktr
ProcessLetters_update8.ktr
ProcessLetters_update9.ktr
ProcessLetters_update10.ktr
ProcessLetters_update11.ktr
ProcessLetters_MainJob_completed.ktr