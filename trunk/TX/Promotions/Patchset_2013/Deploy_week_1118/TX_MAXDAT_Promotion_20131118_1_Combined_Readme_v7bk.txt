***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 11/18/2013
----------------
2013/11/18 A.Antonio           - New EMRS dimension table and views
2013/11/14 Mayuresh Bhalekar   - Manage Enrollment Activity Added Job Statistics and fixed ORA-01722
2013/11/14 B.Thai-Mail Fax Doc – Add Job Statistics
2013/11/15 Dave Dillion        - Remove old logs and logs of zero (to improve readability if logs directory)
PULLED - 2013/11/15 Mayuresh Bhalekar   - Fix of Jira# MAXDAT-901.
Replaced DB zip 2013/11/18 Clay Contact Center – v0.1.4 
2013/11/19 A. Antonio          - Added instructions to run adhoc script for EMRS
2013/11/18 B.Thai              - Creation for MAXDAT-907 SCI. Insert ETL lookups for Event's manual action categories.
ADDED 2013/11/20 B.Thai- Add indexes on ETL tables for performance.

***** MODIFICATION HISTORY ****************************************************************************
-----------------------
1. DB SCRIPTS SECTION
-----------------------
-- SEND LOGS FOR ALL DB SCRIPTS 
- Run these SQL scripts below as the the Oracle user MAXDAT:  
- (or as a proxy login to MAXDAT - Example: rk50472[maxdat])
Disable cron that runs tx_run_bpm.sh
Disable cron that runs tx_run_emrs.sh
execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;	
	
        ----------------------------
	-- All files can be found at (see below) or DB_EMRS_20131118_ARLENE_19.zip

        NOTE : Please run in the order specified below.

        EMRS_D_AA_CLIENT.sql
        AA_CLIENT_PK.sql
        EMRS_D_AA_CLIENT_CONSTRAINT.sql
        20131111_1101_enrollment_fact_views.sql
	BIR_AA_CLIENT.sql
        BUR_AA_CLIENT.sql
        
        ----------------------------
	-- All files can be found IN DB_PATCH_CONTACT_CENTER_20131118_Cecil_v0.1.4.zip
	Unzip and run the following SQL scripts on the MAXDAT database.
	
	0.1.4/001_ALTER_CALL_DETAIL.sql
	0.1.4/002_Increase_Precision.sql
	0.1.4/003_CREATE_CC_S_TMP_AGENT_SKILL_GROUP.sql
	0.1.4/004_CREATE_TARGET_VIEWS.sql
	0.1.4/005_UPDATE_CISCO_LANDING_TABLES.sql
	0.1.4/101_CC_C_FILTER__INSERT_MISSING_QUEUES.sql
	0.1.4/102_CC_C_CONTACT_QUEUE__INSERT_UPDATE_MISSING_QUEUES.sql
	0.1.4/103_CC_C_UNIT_OF_WORK__INSERT_NEW_UoWs.sql
	0.1.4/104_INSERT_CC_A_ADHOC_JOB.sql
	0.1.4/105_UPDATE_EBA_AGENT_LOGIN_ID.sql
	0.1.4/016_DUPLICATED_AGENT_RECORD_CLEANUP.sql
	----------------------------
        Download DB_MFDOC_201311120_BRIAN_5.zip
	
	20131120_1337_MFD_add_etl_tab_indexes.sql

	----------------------------        
 
        All files found in DB_SCI_20131118_BRIAN_8.zip

        populate_CORP_SCI_ETL_MACTIONS_LKUP.sql

        -----------------------	

execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;
        
-----------------------
2. KETTLE FILES SECTION
-----------------------

Download AS_EMRS_20131118_ARLENE_27.zip
Deploy the follow files to the appropriate path
  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 
  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/EnrollmentDataEMRS 

STG_Load_S_ENROLLMENTS.ktr
FACT_Load_ENROLLMENTS.ktr
DIM_Load_AA_CLIENT_HIST.ktr
DIM_Load_AA_CLIENT.ktr
ETL_Load_AA_Dimensions.kjb

------------------------------

Download AS_MEA_KETTLE_CORP_20131114_MAYURESH_7.zip
Deploy the follow files to the appropriate path
  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity  
  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity  
  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ManageEnrollmentActivity 

ManageEnroll_Cancel_Dt_NEW_ENRL_PKT.ktr
ManageEnroll_Cancel_Dt_NO_LONGER_ELIG.ktr
ManageEnroll_MainJob_completed.ktr
ProcessManageEnroll_RUNALL.kjb
------------------------------

Download AS_MFDOC_20131001_BRIAN_4.zip
Deploy the follow files to the appropriate path
UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc
ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc
PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc
 
Process_mail_fax_doc_runall.kjb
ProcessMailFax_Job_Completes.ktr


-------------------------------------

Upload application server deployment bundle, AS_PATCH_CONTACT_CENTER_20131118_Cecil_v0.1.4.zip
--
UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ContactCenter 
 # UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
   unzip -o AS_PATCH_CONTACT_CENTER_20131118_Cecil_v0.1.4.zip -d dtxe4t/ETL_Scripts/scripts/ContactCenter 
 # MAKE SCRIPTS EXECUTABLE
   chmod 755 dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/*.sh
--
ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ContactCenter 
 # UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
   unzip -o AS_PATCH_CONTACT_CENTER_20131118_Cecil_v0.1.4.zip -d ttxe4t/ETL_Scripts/scripts/ContactCenter 
 # MAKE SCRIPTS EXECUTABLE
   chmod 755 ttxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/*.sh
--
PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ContactCenter 
 # UNZIP CONTACT CENTER DEPLOYMENT BUNDLE
   unzip -o AS_PATCH_CONTACT_CENTER_20131118_Cecil_v0.1.4.zip -d ptxe4t/ETL_Scripts/scripts/ContactCenter 
 # MAKE SCRIPTS EXECUTABLE
   chmod 755 ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/*.sh


-----------------------
3. UNIX SCRIPT SECTION
-----------------------

Download AS_EMRS_20131118_ARLENE_28.zip 
Deploy the follow files to the appropriate path
  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts 
  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts 
  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts 

        tx_emrs_load_aaclient_onetime.sh

Run dos2unix for the following List 
	tx_emrs_load_aaclient_onetime.sh

chmod 755 tx_emrs_load_aaclient_onetime.sh      



--------------------------
Download AS_UTILITY_20131115_DAVE_1.zip

Perform the following commands based on target environment:
UAT
	1) DEPLOY the following files TO PATH: /dtxe4t/ETL_Scripts/scripts/
		purge_logs.sh
		tx_set_env_uat.txt
	2) Execute: dos2unix tx_set_env_uat.txt .set_env
	3) Execute: dos2unix purge_logs.sh tx_purge_logs.sh
	4) Execute: chmod +x tx_purge_logs.sh
	5) Execute: rm tx_set_env_uat.txt purge_logs.sh

ProdSupport 
	1) DEPLOY the following files TO PATH: /ttxe4t/3rdparty/ETL_Scripts/scripts/
		purge_logs.sh
		tx_set_env_fix.txt
	2) Execute: dos2unix tx_set_env_fix.txt .set_env
	3) Execute: dos2unix purge_logs.sh tx_purge_logs.sh
	4) Execute: chmod +x tx_purge_logs.sh
	5) Execute: rm tx_set_env_fix.txt purge_logs.sh
	6) Execute: /ptxe4t/ETL_Scripts/scripts/tx_purge_logs.sh
	7) To validate, run this command which should return a list of logs who's date will not be more than 30 days old:
		find /ttxe4t/3rdparty/ETL_Logs/logs \( -ctime +28 -o -size 0 \) -exec ls -l '{}' \; 

PRODUCTION 
	1) DEPLOY the following files TO PATH: /ptxe4t/ETL_Scripts/scripts/
		purge_logs.sh
		tx_set_env_prd.txt
	2) Execute: dos2unix tx_set_env_prd.txt .set_env
	3) Execute: dos2unix purge_logs.sh tx_purge_logs.sh
	4) Execute: chmod +x tx_purge_logs.sh
	5) Execute: rm tx_set_env_prd.txt purge_logs.sh
	6) create the following cron job
		00 06 * * * /ptxe4t/ETL_Scripts/scripts/tx_purge_logs.sh
		
------------------------------

Download AS_SCI_20131118_BRIAN_8.zip
Deploy the following files to the appropriate path
  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts
  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts
  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts

Run_onetime_ClientInquiry_Manual_Events.ktr
Run_onetime_CLIENT_INQUIRY_20131118.sh

Format shell script for Unix
chmod 777 Run_onetime_CLIENT_INQUIRY_20131118.sh
dos2unix -k -o Run_onetime_CLIENT_INQUIRY_20131118.sh

-------------------------------------		
		
----------------------------
4. DISABLE CRON JOB
----------------------------
                -- Disable cron job for Contact Center ETL so that the scheduled jobs do not run concurrently with the adhoc job.
                
                
----------------------------
5. ADHOC SH SCRIPT SECTION
----------------------------

		--Execute tx_emrs_load_aaclient_onetime.sh which will populate the new EMRS AA_CLIENt table

UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_emrs_load_aaclient_onetime.sh &
DO NOT RUN IN PROD SUPP 
PROD            nohup /ptxe4t/ETL_Scripts/scripts/tx_emrs_load_aaclient_onetime.sh &

Continue, no need to wait for jobe to complete
  
UAT             nohup /dtxe4t/ETL_Scripts/scripts/Run_onetime_CLIENT_INQUIRY_20131118.sh &
DO NOT RUN IN PROD SUPP 
PROD            nohup /ptxe4t/ETL_Scripts/scripts/Run_onetime_CLIENT_INQUIRY_20131118.sh &

Continue, no need to wait for jobe to complete

                --Execute manage_adhoc_load_contact_center.sh which will populate data for TXEB for the days missing CC_F_AGENT_BY_DATE data [10/31, 11/06-11/22]
                
UAT             nohup /dtxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_load_contact_center.sh &
DO NOT RUN IN PROD SUPP 
PROD            nohup /ptxe4t/ETL_Scripts/scripts/ContactCenter/main/bin/manage_adhoc_load_contact_center.sh &
                
                --Note:  this job will likely take up to 10 hours to complete as it is loading over a week's worth of data.

----------------------------
6. SEND NOTICE TO CONTACT CENTER TEAM TO REVIEW ADHOC JOB RESULTS
----------------------------
                -- Send an email to MAXDATContactCenter@maximus.com when adhoc job is complete for review before proceeding to step 5.

----------------------------
7. ENABLE CRON JOB (When all jobs have completed)
----------------------------
                -- Enable cron job for Contact Center ETL
		-- enable cron that runs tx_run_bpm.sh
		-- enable cron that runs tx_run_emrs.sh