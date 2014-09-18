***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 02/03/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/01/22 Brian Thai,          210.722.3895 MW status order. Set staff name with spaces.
           M. Bhalekar          201-328-5695 Job Statistics and Temporary solution to Manage Work	

2014/01/29 A. Antonio           916-832-8644   Increased length of case_cin for cases. Bring in missing data for Providers and selections mi.
					       Truncate and reload EMRS notifications table.
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

execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;

*******************************************************************************************	
        Brian Thai (Manage Work)
        ------------------------------------------------------------------------------------
	** Unzip DB_ManageWork_20140123_Mayuresh_1.zip
        ** Run in the order specified below.

        ** Make sure script #2 (20140203_1311_chk_MW_bpm_queue.sql) returns no records before proceeding.

1. 20140203_1634_MW_disable_queue_triggers.sql
2. 20140203_1311_chk_MW_bpm_queue.sql
3. CORP_ETL_STAGE_pkg.sql
4. 20140115_1337_MW_alter_objects.sql
5. insert_MW_list_lkup_status_order.sql
6. CORP_ETL_MANAGE_WORK_pkg.sql
7. create_ETL_initialize_triggers.sql
8. 20140115_1408_update_status_order.sql
9. 20140128_1411_upd_MW_etl_stage_and_dimensional.sql
10.20140128_0938_upd_MW_bpm_lkup_and_event_attr.sql
11.201430_0641_MW_enable_queue_triggers.sql

Note: Script #8 might take few minutes to complete. Script #10 will take many minutes to complete.

execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
        
        ------------------------------------------------------------------------------------
*******************************************************************************************

	*******************************************************************************************	
        A. Antonio (EMRS)
        ------------------------------------------------------------------------------------
	** Unzip DB_EMRS_20140128_ARLENE_25.zip
        ** Run in the order specified below.

	20140127_1817_cleanup_TX_EMRS_notif_data.sql 
	20140124_1555_alter_emrs_tables.sql
	20140130_0922_EMRS_S_ENROLLMENT_STG_CHIP.sql
	20140131_1154_ins_corp_etl_control_max_834_id.sql	        
        ------------------------------------------------------------------------------------
       *******************************************************************************************

        
-----------------------
2. KETTLE FILES SECTION
-----------------------

    
	    Brian Thai (Manage Work)
	--------------------------------------------------------------------
		Download AS_ManageWork_20140123_Mayuresh_1.zip
		Deploy the follow files to the appropriate path
		  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ManageWork
		  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ManageWork 
		  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ManageWork
	
ManageWork_Insert.ktr
ManageWork_MainJob_completed.ktr
ManageWork_Move_updates.ktr
ManageWork_RUNALL.kjb
ManageWork_Save_Variables.ktr
ManageWork_Upd_Txn_pkg.ktr
ManageWork_Update2.ktr
	
	---------------------------------------------------------------------

*******************************************************************************************	
        A. Antonio (EMRS)
	--------------------------------------------------------------------
	Download AS_EMRS_20140128_ARLENE_37.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS  

	DIM_Load_PLANS.ktr 
	DIM_Load_NOTIFICATIONS.ktr
	DIM_Load_NOTIFICATIONS_HIST.ktr 
	DIM_Load_NOTIFICATIONS_CHIP.ktr 
	DIM_Load_NOTIFICATIONS_CHIP_ONETIME.ktr
	STG_Load_S_PROVIDERS.ktr 
	DIM_Load_CARE_SERV_DELIV_AREAS.ktr
	DIM_Load_ENROLLMENT_NOTIF_ONETIME.ktr 
	DIM_Load_ENROLLMENT_NOTIFICATION.ktr
	STG_Load_S_CHIP_PROVIDERS_ADHOC.ktr

	DIM_Load_CHIP_PROVIDER_REF_ADHOC.ktr
	DIM_Load_CHIP_PROVIDERS_ADHOC.ktr
	DIM_Upd_PROVIDERS_ADHOC.ktr
	ETL_Load_CHIP_PROVIDERS_ADHOC.kjb
	ETL_Load_Notifications_OneTime.kjb
	DIM_Load_CASES.ktr
	DIM_Load_SELECTION_MISSING_INFO.ktr
	DIM_Load_SELECTION_MISSING_INFO_ADHOC.ktr
	DIM_Load_SELECTION_MISSING_INFO_ONETIMERUN.ktr
	ETL_Load_Enrollment_Notification.kjb
	DIM_Load_NOTIFICATIONS_PERI.ktr
	STG_Load_S_ENROLLMENTS_CHIP_adhoc.ktr
	EMRS_get_last_med_notif_id.ktr
	EMRS_set_max_med_notif_id.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

-----------------------
3. UNIX SCRIPT SECTION
-----------------------
       *******************************************************************************************	
No changes
	
       *******************************************************************************************			
                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
  

	*******************************************************************************************	
	A. Antonio (EMRS)

	--------------------------------------------------------------------
       DOwnload AS_EMRS_20140128_ARLENE_38.zip 

	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

		tx_emrs_load_selectionsmi_adhoc.sh
		tx_emrs_load_chip_provider_adhoc.sh
		tx_emrs_load_notifications_adhoc.sh


	Run dos2unix for the following List 
		tx_emrs_load_selectionsmi_adhoc.sh
		tx_emrs_load_chip_provider_adhoc.sh
		tx_emrs_load_notifications_adhoc.sh

	chmod 755 tx_emrs_load_selectionsmi_adhoc.sh
	chmod 755 tx_emrs_load_chip_provider_adhoc.sh
	chmod 755 tx_emrs_load_notifications_adhoc.sh

	--Execute tx_emrs_load_selectionsmi_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_selectionsmi_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_selectionsmi_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_selectionsmi_adhoc.sh &


	--Execute tx_emrs_load_chip_provider_adhoc.sh
	UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_provider_adhoc.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_provider_adhoc.sh &
	PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_chip_provider_adhoc.sh &

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

