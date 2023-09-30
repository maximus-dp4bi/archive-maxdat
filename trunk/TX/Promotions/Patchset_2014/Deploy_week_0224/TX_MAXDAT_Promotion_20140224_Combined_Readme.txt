***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 02/24/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/02/24  M.Bhalekar        201.328.5695   Modify Err Handling, fix PKG and alter datatype for Manage Jobs  
2014/02/24  A.Antonio         916.832.8644   EMRS - Load remaining CHIP notifications
2014/02/24  A.Antonio         916.832.8644   Client Outreach - Added script for gathering stats
2014/02/24  B.Thai            210.722.3895   MailFaxDoc- Prevent deadlocks and gather stats
2014/02/25  Raj A.            361-228-5588   Deploy performance improved ktr and added error logging to the step (Database join 2) where it is erroring out.

***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh
Disable cron - cron_tx_run_emrs.sh


-----------------------
1. DB SCRIPTS SECTION
-----------------------
**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT


execute MAXDAT_ADMIN.SHUTDOWN_JOBS;	

       *******************************************************************************************	
         M.Bhalekar(Manage Jobs)
        ------------------------------------------------------------------------------------
	** Unzip DB_MJ_20140220_MAYURESH_5.zip
        ** Run in the order specified below.

        20140218_2123_alter_col_datatype.sql
        MANAGE_JOBS_pkg.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	


execute MAXDAT_ADMIN.STARTUP_JOBS;
   
     
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        M.Bhalekar(Manage Jobs)
	--------------------------------------------------------------------
	Download AS_MJ_20140220_MAYURESH_2.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ManageJobs 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ManageJobs 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ManageJobs 

	ManageJob_CaptureNewJob.ktr
	ManageJob_Copy_to_temp.ktr
	ManageJob_Get_LastJobID_cntrlvar.ktr
	ManageJob_Get_OLTP_Details.ktr
	ManageJob_set_Max_JobID.ktr
	ManageJob_temp_to_BPMupdate.ktr
	ManageJob_Update1.ktr
	ManageJob_Update2.ktr
	ManageJob_Update3.ktr
	ManageJob_Update4.ktr
	ManageJob_Update5.ktr
	ManageJob_Update6.ktr
	ManageJob_Update7.ktr
	ManageJob_Update8.ktr
	ManageJobs_MainJob_completed.ktr
	ManageJobs_RunAll.kjb
	--------------------------------------------------------------------
       *******************************************************************************************

        *******************************************************************************************	
        A. Antonio (EMRS)
	--------------------------------------------------------------------
	Download AS_EMRS_20140224_ARLENE_40.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS  

	
	DIM_Load_NOTIFICATIONS_CHIP_ONETIME.ktr
	ETL_Load_Notifications_OneTime.kjb	
	--------------------------------------------------------------------
       *******************************************************************************************


       *******************************************************************************************	
         Arlene Antonio (Client Outreach)
	--------------------------------------------------------------------
	Download AS_ClientOutreach_20140224_Arlene_8.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

	Client_Outreach_gather_stats.ktr
	ClientOutreach_OLTP_details.kjb
	--------------------------------------------------------------------
       *******************************************************************************************

       *******************************************************************************************	
        Brian Thai (Mail Fax Doc)
	--------------------------------------------------------------------
	Download AS_MailFaxDoc_20140224_Brian_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc

        ProcessMailFax_copy_to_tmp.ktr
        ProcessMailFax_Get_MAXe_IA_tsk_Dtl.ktr
        ProcessMailFax_Get_MAXe_manual_tsk_Dtl.ktr
	--------------------------------------------------------------------
       *******************************************************************************************


       *******************************************************************************************	
        Raj A (Process Incidents)
	--------------------------------------------------------------------
	Download AS_TXEB_PI_20140218_RAJ.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessIncidents
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessIncidents
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessIncidents

        Get_Updates_From_OLTP_TX.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
None                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
  
	*******************************************************************************************	
	A. Antonio (EMRS)
	--------------------------------------------------------------------

	--Execute tx_emrs_load_notifications_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_notifications_adhoc.sh &

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
Enable cron - cron_tx_run_emrs.sh
