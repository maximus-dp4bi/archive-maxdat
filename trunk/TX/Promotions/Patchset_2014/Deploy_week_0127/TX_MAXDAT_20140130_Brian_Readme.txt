***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 01/27/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/01/30 Brian Thai,          210.722.3895   Job Statistics and exception handling for Process Letters
***** MODIFICATION HISTORY ****************************************************************************


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

*******************************************************************************************	
        ------------------------------------------------------------------------------------
No Script     
        
        ------------------------------------------------------------------------------------
*******************************************************************************************
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

    
	    Brian Thai (Process Letters)
	--------------------------------------------------------------------
		Download AS_ProcessLetters_20140130_Brian_1.zip
		Deploy the follow files to the appropriate path
		  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessLetters
		  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessLetters 
		  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessLetters
	
        Process_Letters_Filename_STG.kjb
        Process_Letters_runall.kjb
        ProcessLetters_Filename_JOBRUN_STG.ktr
        ProcessLetters_Filename_LETTER_OUT_STG.ktr
        ProcessLetters_Filename_MAILHOUSE_STG.ktr
        ProcessLetters_set_MAX_LetterReqID.ktr	
        ProcessLetters_MainJob_completed.ktr
        ProcessLetters_copy_to_temp.ktr
	---------------------------------------------------------------------

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
       *******************************************************************************************	
No changes
	
       *******************************************************************************************			
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
	--------------------------------------------------------------------------------------------        
No Script     
	--------------------------------------------------------------------------------------------	
----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     

