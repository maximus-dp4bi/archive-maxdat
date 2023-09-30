***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 09/08/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/09/03 Brian Thai          210-722-3895  TXEB-2649 Client Outreach one-time update and UPD25
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_contcent.sh
Disable cron - cron_tx_run_emrs.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------

-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        B.Thai (Client Outreach Update Rule 25)
        --------------------------------------------------------------------
	Download AS_20140908_CO_Brian_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach

        Client_Outreach_UPD25.ktr

	--------------------------------------------------------------------
       *******************************************************************************************	

       *******************************************************************************************	
        B.Thai (Client Outreach one-time shell)
        --------------------------------------------------------------------
	Download AS_20140908_CO_Brian_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts

        Onetime_ClientOutreach_CPW_Call_Update.ktr

	--------------------------------------------------------------------
       *******************************************************************************************	


-----------------------
3. UNIX SCRIPT SECTION
-----------------------

                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
       *******************************************************************************************	
       B.Thai (Client Outreach one-time shell)
        --------------------------------------------------------------------------------------------
        --Execute Onetime_ClientOutreach_CPW_Call_Update.sh which updated CLient Outreach new attribute values
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/Onetime_ClientOutreach_CPW_Call_Update.sh &
	--------------------------------------------------------------------------------------------
       *******************************************************************************************	

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.


     Schedule EMRS Load Medicaid Selection segments cron job
        -- cron_tx_run_emrs_medenrl.sh is in AS_EMRS_20140410_ARLENE_48.zip
	
	-- Schedule cron_tx_run_emrs_medenrl.sh per cronsetup.txt

----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
Enable cron - cron_tx_run_emrs_medenrl.sh
