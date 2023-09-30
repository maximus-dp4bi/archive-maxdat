***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 05/12/2014
----------------
Date       Developer           PHONE         Jira      Reason/Description
---------- ------------------- ------------- --------- ---------------------------------------------
2014/05/12 Brian Thai          210-722-3895  TXEB-2633 Manage Work- Discontinue use of STATUS_ORDER. Package
                                                       no longer update MW_PROCESSED.
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh

-----------------------
1. DB SCRIPTS SECTION
-----------------------
using sys admin - (We are removing the EMRS Schema)
DROP SCHEMA EMRS CASCADE;

**SEND LOGS FOR ALL DB SCRIPTS **
** Run these SQL scripts below as the the Oracle user MAXDAT

execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;	

       *******************************************************************************************	
        B. Thai (Manage Work)
        ------------------------------------------------------------------------------------
	** Unzip DB_ManageWork_20140512_Brian_1.zip
        ** Run in the order specified below.

        20140305_1659_create_d_staff_table.sql
        20140514_0904_syn_grant_d_staff.sql
        CORP_ETL_MANAGE_WORK_pkg.sql
        20140501_0834_MW_upd_task_status.sql
        20140502_1048_MW_upd_stage_done_date.sql
        
        ------------------------------------------------------------------------------------
       *******************************************************************************************	        




execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
        B. Thai (Manage Work)
	--------------------------------------------------------------------
	Download AS_ManageWork_20140512_Brian_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ 

	UPD_STAFF_STG.ktr

	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ManageWork 
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ManageWork
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ManageWork 

	ManageWork_Save_Variables.ktr
	--------------------------------------------------------------------
       *******************************************************************************************	

-----------------------
3. UNIX SCRIPT SECTION
----------------------

   None		

                
----------------------------
4. ADHOC SH SCRIPT SECTION
----------------------------
  None

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
