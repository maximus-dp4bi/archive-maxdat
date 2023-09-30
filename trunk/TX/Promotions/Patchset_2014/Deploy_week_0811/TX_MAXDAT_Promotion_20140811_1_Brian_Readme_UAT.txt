***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 08/11/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/08/08 B.Thai              210.722.3895 TXEB-3161  Fix INS1_20 service area value.
2014/08/11 B.Thai              210.722.3895 TXEB-3151  Fix UPD2 performance issue.
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
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        B. Thai (SCI fix INS1_20)
	--------------------------------------------------------------------
	Download AS_SCI_20140811_Brian_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/SupportClientInquiry 

	ClientInquiry_Child_Insert_INS1_20_TX.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

       *******************************************************************************************	
        B. Thai (MFD UPD2 performance issue)
	--------------------------------------------------------------------
	Download AS_MFD_20140811_Brian_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc 

	ProcessMailFaxUpdates_update2.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

       *******************************************************************************************	
       B. Thai (Client Inquiry adhoc)
        --------------------------------------------------------------------------------------------
        --Execute one-time SCI update
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/Run_onetime_ClientInquiry_Region_Update.sh &
	--------------------------------------------------------------------------------------------
       *******************************************************************************************	

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.


----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
Enable cron - cron_tx_run_emrs_medenrl.sh
