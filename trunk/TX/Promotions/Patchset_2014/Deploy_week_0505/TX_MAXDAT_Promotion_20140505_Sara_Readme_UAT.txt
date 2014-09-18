***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 04/28/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/05/05 Sara                571-294-6487  TXEB-2611 Forecasts load failure


***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron -cron_tx_run_contcent_forecast.sh



-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT



     *******************************************************************************************	
       ( )
        ------------------------------------------------------------------------------------

        
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************
 
        
-----------------------
2. KETTLE FILES SECTION
-----------------------


     ****Download AS_ContactCenter_20140505_Sara_2.1.zip
       	Deploy the following files to the appropriate path****
       	
  -- Forecasts job
  
  UAT      dtxe4t/ETL_Scripts/scripts/ContactCenter/main/transforms/staging/Forecasts/load_CC_S_FCST_INTERVAL.ktr
  
 
        
-----------------------
3. UNIX SCRIPT SECTION
-----------------------
*******************************************************************************************	
               Sara (Contact Center)
       	--------------------------------------------------------------------
       	Download AS_ContactCenter_20140505_Sara_2.1.zip
       	Deploy the follow files to the appropriate path
       
       	UAT      DEPLOY TO PATH /dtxe4t/3rdparty/cron_files
       	
       	cron_tx_run_contcent_forecast.sh
       	
       	--------------------------------------------------------------------
       *******************************************************************************************	
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

       *******************************************************************************************	

       *******************************************************************************************

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
  ---   Load forecast files into the Inbound directory
     
         ****Download MAXDAT_forecast_20140428.zip
       	Deploy the following files to the appropriate path****


  UAT     /dtxe4t/3rdparty/maxdat/files/forecasts/Inbound    
  
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_contcent_forecast.sh

