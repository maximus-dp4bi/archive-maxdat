***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 12/16/2013
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2013/12/18 A. Antonio          916-832-8644  Added new fields in CASE/FPIL view, added indexes to notifications tables
					     Dropped emrs_s_client_stg_adhoc table
                                             Performance tuning for CHIP notifications ktrs.
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_emrs.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

      *******************************************************************************************	
        A. Antonio (EMRS)
        ------------------------------------------------------------------------------------
	** Unzip DB_EMRS_20131218_ARLENE_23.zip
        ** Run in the order specified below.

        20131217_1257_emrs_d_case_fpil_sv.sql
	20131217_1654_alter_emrs_tabs.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************
-----------------------
2. KETTLE FILES SECTION
-----------------------

 	*******************************************************************************************	
        A. Antonio (EMRS)
	--------------------------------------------------------------------
	Download AS_EMRS_20131218_ARLENE_34.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 

	DIM_Load_NOTIFICATIONS_CHIP_ONETIME.ktr
	DIM_Load_NOTIFICATIONS_CHIP.ktr	
	--------------------------------------------------------------------
       *******************************************************************************************


-----------------------
3. UNIX SCRIPT SECTION
-----------------------
no scripts

                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

       *******************************************************************************************	
	A. Antonio (EMRS)
	--------------------------------------------------------------------

	--Execute tx_emrs_load_enrl_adhoc.sh which will populate the notifications dimension
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_notif_onetime.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_notif_onetime.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_notif_onetime.sh &

	--------------------------------------------------------------------
       *******************************************************************************************


----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
    

----------------------------
6. Enable Cron Jobs 
----------------------------
Enable cron - cron_tx_run_emrs.sh
