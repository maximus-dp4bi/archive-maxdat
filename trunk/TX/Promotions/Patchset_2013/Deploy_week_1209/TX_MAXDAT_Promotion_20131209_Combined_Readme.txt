***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 12/09/2013
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2013/11/23 Devin Heimbuch      916.8844.5812 Sample 

2103/12/10 Clay Rowland		   843.425.9769	 	- Add functionality to add previously unknown activity types from Blue Pumpkin
												- Refactor calculation for actual shift minutes => ACTUAL_SHIFT_MINUTES = the sum of the duration of all paid activities not equal to “No Activity” in ACTUALEVENTTIMELINE for a given day.
												- Add new Blue Pumpkin activity types to activity type tables and update the is_paid_flag on existing activity types.
2013/12/10 Arlene Antonio      916.832.8644   For EMRS
						-Modified Client ktr to get the general revenue and state fund flag correctly
						-Modified Cases ktr to get only the current program type for a case
						-Created new ktr for extracting CHIP notifications
						-One-time load of CHIP notifications
						-Adhoc script to update revenue and state fund flags in Client dimension

2013/12/11 Sumi			916 425 6258  For task group upload
						-UPD_SLA_Task_Groups_v2.ktr
						-TXEB_Task_Type_Groups_v1.3.xls
						-run_upd_sla_task_group.sh

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
       
	------------------------------------------------------------------------------------
		Clay Rowland - Alter activity type name;  Insert new and update existing activity types;
	--------------------------------------------------------------------
	For TXEB UAT, Prod and Prod Fix dbs.
	Unzip DB_PATCH_CONTACT_CENTER_20131121_Clay_v0.1.7.zip
	Run in the order specified below.

	1_ALTER_ACTIVITY_TYPE_NAME.sql
	100_UPDATE_INSERT_ACTIVITY_TYPES.sql
	   

      *******************************************************************************************	
        A. Antonio (EMRS)
        ------------------------------------------------------------------------------------
	** Unzip DB_EMRS_20131209_ARLENE_22.zip
        ** Run in the order specified below.

        20131209_1107_EMRS_S_CLIENT_STG_ADHOC.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************
       	   

execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
	------------------------------------------------------------------------------------
		Clay Rowland - Refactor actual_shift_minutes calculation;  Add functionality to add previously unknown activity types from Blue Pumpkin
	--------------------------------------------------------------------

	Download AS_PATCH_CONTACT_CENTER_20131210_Clay_v0.1.7.zip

	UAT
	
		# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
		unzip -o AS_PATCH_CONTACT_CENTER_20131210_Clay_v0.1.7.zip -d /dtxe4t/ETL_Scripts/scripts/ContactCenter

		# MAKE SCRIPTS EXECUTABLE
		chmod 755 /dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/*.sh
	
	PROD SUPP
	
		# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
		unzip -o AS_PATCH_CONTACT_CENTER_20131210_Clay_v0.1.7.zip -d /ttxe4t/ETL_Scripts/scripts/ContactCenter

		# MAKE SCRIPTS EXECUTABLE
		chmod 755 /ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/*.sh		

	PROD
	
		# UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
		unzip -o AS_PATCH_CONTACT_CENTER_20131210_Clay_v0.1.7.zip -d /ptxe4t/ETL_Scripts/scripts/ContactCenter

		# MAKE SCRIPTS EXECUTABLE
		chmod 755 /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/*.sh				



	*******************************************************************************************	
        A. Antonio (EMRS)
	--------------------------------------------------------------------
	Download AS_EMRS_20131209_ARLENE_31.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 

	DIM_Load_NOTIFICATIONS_CHIP_ONETIME.ktr
	DIM_Load_NOTIFICATIONS_CHIP.ktr
	STG_Load_S_CASES.ktr
	ETL_Load_Enrollment_Notification.kjb
	DIM_Upd_CASES.ktr
	DIM_Upd_CLIENTS.ktr
	ETL_Load_Clients_GENREV_ADHOC.kjb
	DIM_Upd_CLIENTS_GENREV_ONETIME.ktr
	STG_Load_S_CLIENTS_ONETIME.ktr
	STG_Load_S_CLIENTS.ktr
	
	--------------------------------------------------------------------
       *******************************************************************************************	 

        B.Sumi (Task Groups)
	--------------------------------------------------------------------
	1.Download AS_task_group_20131211_SUMI.zip
	  Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

	UPD_SLA_Task_Groups_v2.ktr
	
	2.Download AS_task_group_20131211_SUMI.zip
	  Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Logs/logs
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Logs/logs
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Logs/logs 

	TXEB_Task_Type_Groups_v1.3.xls
	
	--------------------------------------------------------------------
       *******************************************************************************************  
	   
-----------------------
3. UNIX SCRIPT SECTION
-----------------------

       *******************************************************************************************	
	B. Sumi (Task Groups)
	--------------------------------------------------------------------
        Download AS_task_group_20131211_SUMI.zip 

	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

	run_upd_sla_task_group.sh

	Run dos2unix for the following List 
	  run_upd_sla_task_group.sh

	chmod 755 run_upd_sla_task_group.sh

       *******************************************************************************************
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
   
       *******************************************************************************************	
	A. Antonio (EMRS)
	--------------------------------------------------------------------
       DOwnload AS_EMRS_20131209_ARLENE_32.zip 

	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

		tx_emrs_load_client_genrev_onetime.sh
		tx_emrs_load_chip_notif_onetime.sh

	Run dos2unix for the following List 
		tx_emrs_load_client_genrev_onetime.sh
		tx_emrs_load_chip_notif_onetime.sh

	chmod 755 tx_emrs_load_client_genrev_onetime.sh
	chmod 755 tx_emrs_load_chip_notif_onetime.sh

	--Execute tx_emrs_load_enrl_adhoc.sh which will populate the adhoc client stage table
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_client_genrev_onetime.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_client_genrev_onetime.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_client_genrev_onetime.sh &

	--Execute tx_emrs_load_enrl_adhoc.sh which will populate the notifications dimension
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_notif_onetime.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_notif_onetime.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_notif_onetime.sh &
	--------------------------------------------------------------------
       *******************************************************************************************	


  *******************************************************************************************	
	B. Sumi (Task Groups)
	--------------------------------------------------------------------
	--Execute run_upd_sla_task_group.sh which will populate corp_etl_list_lkup
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/run_upd_sla_task_group.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/run_upd_sla_task_group.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/run_upd_sla_task_group.sh &
	--------------------------------------------------------------------
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
