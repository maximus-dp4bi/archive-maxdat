***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 03/17/2014

----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/03/17 M.Bhalekar        201.328.5695    Process Letters - Upd1 DB script added. 
                                             Manage Jobs - Fixed Invalid Number Error and attached corp pkg copy.
2014/03/17 C.Rowland         843.408.1358    Contact Center - Turn on Forecast job cron and upload initial forecast files.
2014/03/17 A. Antonio        916.832-8644    Client outreach performance tuning
2014/03/17 Raj A.            361-228-5588    Manage Enrollment Activity ETL package creation as part of performance tuning.


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

execute MAXDAT_ADMIN.SHUTDOWN_JOBS;

        *******************************************************************************************	
        M.Bhalekar (Process Letters)
        ------------------------------------------------------------------------------------
	** Unzip DB_ProcessLetters_20140317_Mayuresh_1.zip
        ** Run in the order specified below.

        
        ETL_PROCESS_LETTER_UPD_PKG.sql

        ------------------------------------------------------------------------------------
       *******************************************************************************************


        *******************************************************************************************	
        M.Bhalekar (Manage Jobs)
        ------------------------------------------------------------------------------------
	** Unzip DB_ManageJobs_20140317_Mayuresh_1.zip
        ** Run in the order specified below.

        
        MANAGE_JOBS_pkg.sql

        ------------------------------------------------------------------------------------
       *******************************************************************************************
       
       *******************************************************************************************	
               Saraswathi Konidena (Contact Center)
        ------------------------------------------------------------------------------------
       	** Unzip DB_ContactCenter_20140317_Sara_1.zip
               ** Run in the order specified below.
       
               
               CC_C_FILTER_added.sql
       
       ------------------------------------------------------------------------------------
       *******************************************************************************************

       
       *******************************************************************************************	
               Raj A. (Manage Enrollment Activity)
        ------------------------------------------------------------------------------------
       	** Unzip DB_MEA_20140317_RAJ_6.zip
               ** Run in the order specified below.
       
               
        20140317_1205_DML_Global_Controls.sql
        20140317_1205_Update_TXEB_MEA_Events_Semantic.sql
        ETL_MANAGE_ENROLLMENT_PKG.sql
        20140317_1749_MEA_Index_WIP_tab.sql
       
       ------------------------------------------------------------------------------------
       *******************************************************************************************

execute MAXDAT_ADMIN.STARTUP_JOBS;

        
-----------------------
2. KETTLE FILES SECTION
-----------------------

        *******************************************************************************************	
        M.Bhalekar (Process Letters)
	--------------------------------------------------------------------
	Download AS_ProcessLetters_20140317_Mayuresh_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessLetters
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessLetters 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessLetters 

	Process_Letters_updates.ktr
	ProcessLetters_upd1.ktr
	
	--------------------------------------------------------------------
       *******************************************************************************************


        *******************************************************************************************	
        M.Bhalekar (Manage Jobs)
	--------------------------------------------------------------------
	Download AS_ManageJobs_20140317_Mayuresh_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ManageJobs
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ManageJobs 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ManageJobs 

	ManageJob_CaptureNewJob.ktr
	ManageJob_Get_OLTP_Details.ktr
	
	--------------------------------------------------------------------
       *******************************************************************************************	

	*******************************************************************************************	
        Clay Rowland (ContactCenter)
	--------------------------------------------------------------------
	Download AS_ContactCenter_20140317_Clay_v0.3.zip
	Deploy the follow files to the appropriate path
	  UAT      
		unzip -o AS_ContactCenter_20140317_Clay_v0.3.zip -d dtxe4t/ETL_Scripts/scripts/ContactCenter
  	  ProdSupp 
		unzip -o AS_ContactCenter_20140317_Clay_v0.3.zip -d ttxe4t/ETL_Scripts/scripts/ContactCenter 
	  PROD     
		unzip -o AS_ContactCenter_20140317_Clay_v0.3.zip -d ptxe4t/ETL_Scripts/scripts/ContactCenter  

	--------------------------------------------------------------------
   *******************************************************************************************

       *******************************************************************************************	
         Arlene Antonio (Client Outreach)
	--------------------------------------------------------------------
	Download AS_ClientOutreach_20140317_Arlene_11.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

	Client_Outreach_EVENTS_UPD.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

       *******************************************************************************************	
         Raj A. (Manage Enrollment Activity)
	--------------------------------------------------------------------
	Download AS_MEA_20140317_RAJ_6.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity

	ProcessManageEnroll_RUNALL.kjb
	ManageEnroll_WIP_to_BPM_StageTable.ktr
	ManageEnroll_Update_Enrollment_Status.ktr
	ManageEnroll_UPD9.ktr
	ManageEnroll_UPD8.ktr
	ManageEnroll_UPD7.ktr
	ManageEnroll_UPD6.ktr
	ManageEnroll_UPD5.ktr
	ManageEnroll_UPD4.ktr
	ManageEnroll_UPD3.ktr
	ManageEnroll_UPD2.ktr
	ManageEnroll_UPD19.ktr
	ManageEnroll_UPD18.ktr
	ManageEnroll_UPD16.ktr
	ManageEnroll_UPD15.ktr
	ManageEnroll_UPD13.ktr
	ManageEnroll_UPD12.ktr
	ManageEnroll_UPD11.ktr
	ManageEnroll_UPD10.ktr
	ManageEnroll_UPD1.ktr
	ManageEnroll_STATS_WIP_Stage.ktr
	ManageEnroll_STATS_tables.ktr
	ManageEnroll_STATS_OLTP_Stage.ktr
	ManageEnroll_STATS_All_STG_tables.ktr
	ManageEnroll_SLCT_AUTO_PROC.ktr
	ManageEnroll_Set_Env_Var.ktr
	ManageEnroll_Plan_Selection.ktr
	ManageEnroll_Insert_Instances.ktr
	ManageEnroll_Fetch_Second_FU_TX.ktr
	ManageEnroll_Fetch_HPC_Letters.ktr
	ManageEnroll_Fetch_First_FU_TX.ktr
	ManageEnroll_Fetch_Fee.ktr
	ManageEnroll_Fetch_Enrl_packets.ktr
	ManageEnroll_Fetch_EMI_Letters.ktr
	ManageEnroll_copy_to_interm_stage_tables.ktr
	ManageEnroll_Cancel_Dt_NO_LONGER_ELIG.ktr
	ManageEnroll_Cancel_Dt_NEW_ENRL_PKT.ktr
	ManageEnroll_Calc_Age.ktr
	ManageEnroll_AA_Due_Dt.ktr
	--------------------------------------------------------------------
       *******************************************************************************************
	   

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
 *******************************************************************************************	
         Raj A. (Manage Enrollment Activity)
	--------------------------------------------------------------------
	Download AS_MEA_20140317_RAJ_6.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

	tx_run_bpm.sh
	
	**Run dos2unix for the following List
	tx_run_bpm.sh
	
	** chmod 755
	chmod 755 tx_run_bpm.sh
	--------------------------------------------------------------------
       *******************************************************************************************			
                
				
	*******************************************************************************************	
        Clay Rowland (Contact Center)
	--------------------------------------------------------------------
	
	Run dos2unix and chmod on .sh scripts
	
	UAT
		find /dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin -type f -name "*.sh" -exec dos2unix '{}' \; 
		find /dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin -type f -name "*.sh" -exec chmod 755 '{}' \; 		
	
	ProdSupp
		find /ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin -type f -name "*.sh" -exec dos2unix '{}' \; 
		find /ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin -type f -name "*.sh" -exec chmod 755 '{}' \; 		

	PROD
		find /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin -type f -name "*.sh" -exec dos2unix '{}' \; 
		find /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin -type f -name "*.sh" -exec chmod 755 '{}' \; 		

	
	--------------------------------------------------------------------
       *******************************************************************************************
				
				
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
none
----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.
	 
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
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_contcent_forecast.sh
Enable cron - cron_tx_run_emrs.sh


