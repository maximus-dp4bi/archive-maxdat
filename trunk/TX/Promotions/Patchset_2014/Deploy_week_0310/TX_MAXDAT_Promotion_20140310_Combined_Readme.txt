***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 03/10/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/03/05 A. Antonio          916-832-8644  Performance improvement for Client Outreach.
2014/03/06 A. Antonio          916-832-8644  Load all addresses from EB.  Load missing selection transactions.

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

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;	


       *******************************************************************************************	
        Arlene Antonio (Client Outreach)
        ------------------------------------------------------------------------------------
	** Unzip DB_ClientOutreach_20140305_Arlene_5.zip
        ** Run in the order specified below.

        1. ETL_CLIENT_OUTREACH_PKG.sql
	        
        ------------------------------------------------------------------------------------
       *******************************************************************************************


	*******************************************************************************************	
        A. Antonio (EMRS)
        ------------------------------------------------------------------------------------
	** Unzip DB_EMRS_20140306_ARLENE_27.zip
        ** Run in the order specified below.

	20140304_1500_EMRS_S_ADDRESS_STG_ADHOC.sql
	20140307_1212_Create_SlctTrans_Indexes.sql
	20140307_1212_Create_SlctMI_Indexes.sql	        
        ------------------------------------------------------------------------------------
       *******************************************************************************************


execute MAXDAT_ADMIN.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

      *******************************************************************************************	
         Arlene Antonio (Client Outreach)
	--------------------------------------------------------------------
	Download AS_ClientOutreach_20140305_Arlene_10.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

	Client_Outreach_copy_TEMP.ktr
	Client_Outreach_UPD1.ktr
	Client_Outreach_UPD4.ktr
	Client_Outreach_UPD_BPM_Main.ktr
	Client_Outreach_MainJob_completed.ktr
	Client_Outreach_get_OLTP_Human_Task.ktr
	Client_Outreach_INS1.ktr
	Client_Outreach_INS2.ktr
	Client_Outreach_EVENTS_UPD.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

	*******************************************************************************************	
        A. Antonio (EMRS)
	--------------------------------------------------------------------
	Download AS_EMRS_20140306_ARLENE_44.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS  

	
	STG_Load_S_Address_Adhoc.ktr
	DIM_Load_SELECTION_MISSING_INFO.ktr
	DIM_Load_SELECTION_TRANSACTION_HISTORY.ktr
	DIM_Load_SELECTION_MISSING_INFO_ADHOC.ktr
	--------------------------------------------------------------------
       *******************************************************************************************
   
	   
-----------------------
3. UNIX SCRIPT SECTION
-----------------------

	*******************************************************************************************	
        Clay Rowland (Contact Center)
	--------------------------------------------------------------------
	Download AS_ContactCenter_20140313_Clay_1.zip
	Deploy the follow files to the appropriate path

	UAT      DEPLOY TO PATH /dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin
	ProdSupp DEPLOY TO PATH /ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin
	PROD     DEPLOY TO PATH /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin

	run_load_contact_center_forecast.sh 

	Run dos2unix for the following List 
		run_load_contact_center_forecast.sh 
		
	chmod 755 run_load_contact_center_forecast.sh 
	--------------------------------------------------------------------
       *******************************************************************************************

	   
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------

	*******************************************************************************************	
	A. Antonio (EMRS)
	--------------------------------------------------------------------
       DOwnload AS_EMRS_20140306_ARLENE_45.zip 

	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

		tx_emrs_load_address_adhoc.sh


	Run dos2unix for the following List 
		tx_emrs_load_address_adhoc.sh

	chmod 755 tx_emrs_load_address_adhoc.sh



	--Execute tx_emrs_load_selections_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_selections_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_selections_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_selections_adhoc.sh &


	--Execute tx_emrs_load_address_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_address_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_address_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_address_adhoc.sh &


	--Execute tx_emrs_load_enrl_adhoc_chip.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_enrl_adhoc_chip.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_enrl_adhoc_chip.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_enrl_adhoc_chip.sh &
	
	--------------------------------------------------------------------
       *******************************************************************************************


	  	   
----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
	 
	-- Create Contact Center forecast job directories	
	UAT      
		mkdir /dtxe4t/3rdparty/maxdat/files/forecasts/Inbound 
		mkdir /dtxe4t/3rdparty/maxdat/files/forecasts/Processing 
		mkdir /dtxe4t/3rdparty/maxdat/files/forecasts/Error 
		mkdir /dtxe4t/3rdparty/maxdat/files/forecasts/Completed  

	ProdSupp 
		mkdir /ttxe4t/3rdparty/maxdat/files/forecasts/Inbound 
		mkdir /ttxe4t/3rdparty/maxdat/files/forecasts/Processing 
		mkdir /ttxe4t/3rdparty/maxdat/files/forecasts/Error 
		mkdir /ttxe4t/3rdparty/maxdat/files/forecasts/Completed  
	
	PROD     
		mkdir /ptxe4t/3rdparty/maxdat/files/forecasts/Inbound 
		mkdir /ptxe4t/3rdparty/maxdat/files/forecasts/Processing 
		mkdir /ptxe4t/3rdparty/maxdat/files/forecasts/Error 
		mkdir /ptxe4t/3rdparty/maxdat/files/forecasts/Completed  

	-- Copy kettle.properties file to .kettle directory in kettle home
	svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/config/.kettle/<system>_kettle.properties Rename to kettle.properties

	-- Schedule contact center forecast cron job
	-- Download AS_ContactCenter_20140313_Clay_1.zip
	
	Schedule cron_tx_run_contcent_forecast.sh per cronsetup.txt

	-- Load forecast files into the Inbound directory
	-- Download MAXDAT_forecast_20140303.zip
	
	UAT
		unzip MAXDAT_forecast_20140303.zip -d /dtxe4t/3rdparty/maxdat/files/forecasts/Inbound 
	
	ProdSupp
		unzip MAXDAT_forecast_20140303.zip -d /ttxe4t/3rdparty/maxdat/files/forecasts/Inbound 
		
	PROD
		unzip MAXDAT_forecast_20140303.zip -d /ptxe4t/3rdparty/maxdat/files/forecasts/Inbound 

	--  Run load contact center forecast job
	
	UAT
		nohup /dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_load_contact_center_forecast.sh & 
	
	ProdSupp
		nohup /ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_load_contact_center_forecast.sh & 
	
	PROD
		nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/run_load_contact_center_forecast.sh & 
		
		
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
			cron_tx_run_contcent_forecast.sh
