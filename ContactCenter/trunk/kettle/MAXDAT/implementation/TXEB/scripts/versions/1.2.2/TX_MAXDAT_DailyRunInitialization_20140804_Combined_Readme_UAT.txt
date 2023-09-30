ee***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 08/04/2014
----------------
Date       Developer           PHONE         Jira       Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/07/31 M.Bhalekar          201.328.5695 TXEB-3065 MAXDAT - Decoupling Client Outreach process from hourly run, adding into Daily run and Grouping daily process together. 
2014/08/01 Brian               210.722.3895 TXEB-2576 SCI new attributes.
2014/08/04 Austin Baker		   843-259-1955	TXEB-3076 MAXDAT - adjust programs to account for cross-trained agents

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_contcent.sh
Disable cron - cron_tx_run_emrs.sh
Disable cron - cron_tx_run_emrs_medenrl.sh
Disable cron - cron_run_bpm_Let.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;	

       *******************************************************************************************	
        (Developer create this block for each DB zip)
        ------------------------------------------------------------------------------------
	** Unzip DB_{SYSTEM}_{YYMMDD}20131118_{DEVELOPER_NAME}_{NUM}.zip
        ** Run in the order specified below.

        File1.sql
        File2.sql
        File3.sql
        etc
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	        

       *******************************************************************************************	
        B. Thai (SCI new County, Service Area, and Region attributes)
        ------------------------------------------------------------------------------------
	** Unzip DB_SCI_20140804_Brian_1.zip
        ** Run in the order specified below.

        20140623_0733_Clnt_Supp_Info_add_index.sql
        20140616_1004_SCI_alter_dtl_tab.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	      

	   *******************************************************************************************	
        Austin Baker (add 'Muliple - EB/THS/CHIP' entry to CC data mart)
        ------------------------------------------------------------------------------------
	    ** Unzip DB_ContactCenter_20140804_Austin_1.zip
        ** Run in the order specified below.

        001_UPDATE_TX_PROGRAMS.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	 	 	   


execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        (Developer create this block for each AS zip)
	--------------------------------------------------------------------
	Download AS_{SYSTEM}_{YYMMDD}20131118_{DEVELOPER_NAME}_{NUM}.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/{Your Direcortory} 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/{Your Direcortory} 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/{Your Direcortory} 

	file1.ktr
	file2.kjb
	file3.ktr
	etc
	--------------------------------------------------------------------
       *******************************************************************************************	

       *******************************************************************************************	
        B. Thai (SCI new County, Service Area, and Region attributes)
	--------------------------------------------------------------------
	Download AS_SCI_20140804_Brian_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/SupportClientInquiry 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/SupportClientInquiry 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/SupportClientInquiry 

	ClientInquiry_Child_Insert_INS1_20_TX.ktr
	ClientInquiry_Child_Update_UPD1_20_TX.ktr
	ClientInquiry_Child_Update_BPM.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

       *******************************************************************************************	
        B. Thai (SCI new attributes adhoc)
	--------------------------------------------------------------------
	Download AS_SCI_20140804_Brian_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/

	Onetime_ClientInquiry_Region_Update.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
       *******************************************************************************************	
        (Developer create this block for each AS zip)
        --------------------------------------------------------------------
	Download AS_{SYSTEM}_{YYMMDD}20131118_{DEVELOPER_NAME}_{NUM}.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

	file1.sh
	file2.sh
	file3.sh
	etc
	
	**Run dos2unix for the following List
	dos2unix file1.sh
	dos2unix file2.sh
	dos2unix file3.sh
	etc
	
	** chmod 755
	chmod 755 file1.sh
	chmod 755 file2.sh
	chmod 755 file3.sh
	etc
	--------------------------------------------------------------------
       *******************************************************************************************	

	*******************************************************************************************	
        M.Bhalekar(Daily Run Initialization)
        --------------------------------------------------------------------
	Download AS_DailyRunInitialization_20140804_Mayuresh_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

	tx_run_bpm.sh
	tx_run_bpm_daily.sh
	
	
	**Run dos2unix for the following List
	dos2unix tx_run_bpm.sh
	dos2unix tx_run_bpm_daily.sh
	
	
	** chmod 755
	chmod 755 tx_run_bpm.sh
	chmod 755 tx_run_bpm_daily.sh

	
	--------------------------------------------------------------------
       *******************************************************************************************			
                
       *******************************************************************************************	
        B. Thai (SCI Adhoc shell)
        --------------------------------------------------------------------
	Download AS_SCI_20140804_Brian_2.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

	Run_onetime_ClientInquiry_Region_Update.sh
	
	**Run dos2unix for the following List
	dos2unix Run_onetime_ClientInquiry_Region_Update.sh
	
	** chmod 755
	chmod 755 Run_onetime_ClientInquiry_Region_Update.sh
	--------------------------------------------------------------------
       *******************************************************************************************			
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
       *******************************************************************************************	
       (Developer create this block AS NEEDED)
        --------------------------------------------------------------------------------------------
        --Execute tx_emrs_load_aaclient_onetime.sh which will populate the new EMRS AA_CLIENt table
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_aaclient_onetime.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_aaclient_onetime.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_aaclient_onetime.sh &
	--------------------------------------------------------------------------------------------
       *******************************************************************************************	

       *******************************************************************************************	
       B. Thai (Client Inquiry adhoc)
        --------------------------------------------------------------------------------------------
        --Execute tx_emrs_load_aaclient_onetime.sh which will populate the new EMRS AA_CLIENt table
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/Run_onetime_ClientInquiry_Region_Update.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/Run_onetime_ClientInquiry_Region_Update.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/Run_onetime_ClientInquiry_Region_Update.sh &
	--------------------------------------------------------------------------------------------
       *******************************************************************************************	

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
     SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
     -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.

	*******************************************************************************************	
	M.Bhalekar (Daily Jobs)
	--------------------------------------------------------------------

	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/3rdparty/cron_files 
	  ProdSupp DEPLOY TO PATH ttxe4t/3rdparty/cron_files 
	  PROD     DEPLOY TO PATH ptxe4t/3rdparty/cron_files 
	
	 cron_run_bpm_daily.sh


	**Run dos2unix for the following List 
	dos2unix cron_run_bpm_daily.sh

	** chmod 755	
	chmod 755 cron_run_bpm_daily.sh

 -- Update crontab per cronsetup_UAT.txt
       
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
Enable cron - cron_tx_run_emrs_medenrl.sh
Enable cron - cron_run_bpm_daily.sh
