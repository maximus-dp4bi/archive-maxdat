***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 12/03/2013
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2013/12/03 Brian Thai          210-722-3895 Changed Mail Fax Doc -run scheduling
2013/12/03 Brian Thai          210-722-3895 Changed Proc Incidents- run scheduling and performance tuning
2013/12/03 Dave Dillion        512-757-4558 Changed Letters ????????
2013/12/03 A. Antonio	       916.832.8644  Promotion for EMRS - bring over enrollment records from EB
2013/12/04 Brian Thai          210-722-3895 (DEFECT FIXED) Changed AS_MFDOC_2013127_BRIAN_7.zip - vJobName for exception handling

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

execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;	


       *******************************************************************************************	
        B.Thai (MailFaxDoc)
        ------------------------------------------------------------------------------------
	** Unzip DB_MFDOC_2013127_BRIAN_7.zip
        ** Run in the order specified below.

        20131127_1032_MFD_ins_list_lkup.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	        


       *******************************************************************************************	
        B.Thai (Process Incidents)
        ------------------------------------------------------------------------------------
	** Unzip DB_ProcessIncidents_20131202_BRIAN_5.zip
        ** Run in the order specified below.

        20131126_1249_PI_ins_list_lkup.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	        

       *******************************************************************************************	
        A. Antonio (EMRS)
        ------------------------------------------------------------------------------------
	** Unzip DB_EMRS_20131203_ARLENE_21.zip
        ** Run in the order specified below.

        20131203_1324_EMRS_S_ENROLLMENT_STG_ADHOC.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************
execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;       
-----------------------
2. KETTLE FILES SECTION
-----------------------


       *******************************************************************************************	
        B.Thai (MailFaxDoc)
	--------------------------------------------------------------------
	Download AS_MFDOC_2013127_BRIAN_7.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc

	Process_mail_fax_doc_runall.kjb
	ProcessMailFax_Check_Schedule.ktr
        ProcessMailFax_Get_MAXe_work_tsk_Dtl.ktr
	
	--------------------------------------------------------------------
       *******************************************************************************************	

       *******************************************************************************************	
        B.Thai (Process Incidents)
	--------------------------------------------------------------------
	Download AS_ProcessIncidents_20131202_BRIAN_5.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessIncidents
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessIncidents
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessIncidents

	Process_Incidents_RUN_ALL.kjb
	ProcessInc_Check_Schedule.ktr
	Apply_UPD10_rules_and_load_to_PROCESS_INCIDENTS_WIP_BPM.ktr
	Process_Incidents_Final_Updates_From_WIP_STG_to_BPM.ktr
	Process_Incidents_Updates1_AND_2_From_OLTP_STG_to_WIP_STG.ktr
	Process_Incidents_Updates3_AND_4_From_OLTP_STG_to_WIP_STG.ktr
	Process_Incidents_Updates5_AND_6_AND_7_From_OLTP_STG_to_WIP_STG.ktr
	Process_Incidents_Updates8_AND_9_From_OLTP_STG_to_WIP_STG.ktr
	Get_Updates_From_OLTP_TX.ktr
        ProcessInc_CaptureNewInc_OLTP_TX.ktr

	--------------------------------------------------------------------
       *******************************************************************************************	

       *******************************************************************************************	
        D. Dillon (Process Letters)
	--------------------------------------------------------------------
	Download S_ProcessLetters_20131127_Dave_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessLetters
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessLetters
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessLetters

	Process_Letters_Filename_STG.kjb   
	Process_Letters_runall.kjb
	ProcessLetters_CaptureNewLetters.ktr
	ProcessLetters_Filename_JOBRUN_STG.ktr
	ProcessLetters_Filename_LETTER_OUT_STG.ktr
	ProcessLetters_Filename_MAILHOUSE_STG.ktr
	ProcessLetters_Filename_MAX_STG_var.ktr
	ProcessLetters_Get_OLTP_details.ktr
	ProcessLetters_update11.ktr


	--------------------------------------------------------------------
       *******************************************************************************************	


       *******************************************************************************************	
        A. Antonio (EMRS)
	--------------------------------------------------------------------
	Download AS_EMRS_20131203_ARLENE_29.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 

	STG_Load_S_ENROLLMENTS_MEDICAID_adhoc.ktr
	STG_Load_S_ENROLLMENTS_CHIP_adhoc.ktr
	
	--------------------------------------------------------------------
       *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
       *******************************************************************************************	
	A. Antonio (EMRS)
	--------------------------------------------------------------------
        Download AS_EMRS_20131203_ARLENE_30.zip 

	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

	tx_emrs_load_enrl_adhoc.sh

	Run dos2unix for the following List 
	  tx_emrs_load_enrl_adhoc.sh

	chmod 755 tx_emrs_load_enrl_adhoc.sh

       *******************************************************************************************			
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
       *******************************************************************************************	
	A. Antonio (EMRS)
	--------------------------------------------------------------------
	--Execute tx_emrs_load_enrl_adhoc.sh which will populate the enrollment staging table
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_enrl_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_enrl_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_enrl_adhoc.sh &
	--------------------------------------------------------------------
       *******************************************************************************************	

----------------------------
5. SPECIAL INSTRUCTIONS 
----------------------------
     SEND DB LOGS TO DEVELOPERS at maxdatsystem@maximus.com
     
  
----------------------------
6. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
Enable cron - cron_tx_run_contcent.sh
Enable cron - cron_tx_run_emrs.sh
