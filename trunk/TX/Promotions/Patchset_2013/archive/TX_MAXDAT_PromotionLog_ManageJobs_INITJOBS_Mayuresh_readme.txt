PROJECT_NAME -> TXEB - Manage Jobs
RELEASE_NUMBER -> 

ENVIRONMENT -> MAXDAT  Databases and App Servers
Here we will specify the app server and DBs to deploy to


DEPLOYMENT START_TIME_DATE -> 
DEPLOYMENT COMPLETE_BY_TIME -> 
CONTACT_NAME: Mayuresh Bhalekar
CONTACT_NUMBER: (201.328.5695)
SVN_URL -> See Below


SPECIAL INSTRUCTIONS ->
If there are error in any one of the following scripts in steps 1 and 10
please stop and notify us otherwise it creates more clean up for all of us.


STEP BY STEP INSTRUCTIONS  - >
1. (For APT Environemt and above) Turn off tx_run_bpm.sh cron job, then do the steps 1 - 10 in that order.


2. - Stop jobs on MAXDAT DB:
execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;



3. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DO_INITJOBS_MAXDAT_MAYURESH_1.zip
and run them in MAXDAT DB in the same order as below.

CORP_ETL_MANAGE_JOBS_DDL.sql
CORP_ETL_MANAGE_JOBS_OLTP_DDL.sql
CORP_ETL_MANAGE_JOBS_WIP_BPM_DDL.sql
CORP_MJ_ETL_FILE_LKUP_DDL.sql
CORP_MJ_FILE_CAL_LKUP_DDL.sql
SEQ_CORP_ETL_MANAGE_JOBS.sql
SemanticModel_ILEB_Manage_Jobs.sql


4. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DB_INITJOBS_MAXDAT_MAYURESH_1.zip
and run them in MAXDAT DB in the same order as below.

TRG_CORP_ETL_MANAGE_JOBS.sql
TRG_AI_CORP_ETL_MANAGE_JOBS_Q.sql
TRG_AU_CORP_ETL_MANAGE_JOBS_Q.sql
MANAGE_JOBS_pkg.sql
BPM_EVENT_PROJECT_pkg_body.sql
BPM_SEMANTIC_PROJECT_pkg_body.sql


5. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DG_INITJOBS_MAXDAT_MAYURESH_1.zip
and run them in MAXDAT DB in the same order as below.

GRANT_PUB_SYNONYM_MANAGE_JOBS.sql


6. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DS_INITJOBS_MAXDAT_MAYURESH_1.zip
and run them in MAXDAT DB in the same order as below.

INSERT_CORP_MJ_ETL_FILE_LKUP.sql
INSERT_CORP_MJ_FILE_CAL_LKUP.sql
INSERT_CORP_ETL_CONTROL.sql
populate_lkup_tables.sql
populate_BPM_EVENT_MASTER.sql
populate_BPM_ATTRIBUTE_LKUP.sql
populate_BPM_ATTRIBUTE.sql
populate_BPM_ATTRIBUTE_STAGING_TABLE.sql


7. Create directory for kettle scripts as follows (Where MAXDAT_ETL_PATH = the Maxdat Scripts Directory ):
MAXDAT_ETL_PATH/ManageJobs


8. Unzip the following zip file 
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_INITJOBS_MAXDAT_MAYURESH_1.zip
and deploy ALL kettle scripts(*.kjb, *.ktr). Except tx_run_bpm.sh 
TO: MAXDAT_ETL_PATH/ManageJobs
ManageJobs_RunAll.kjb
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


9. Unzip the UNIX Scripts(tx_run_bpm.sh) from 
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_INITJOBS_MAXDAT_MAYURESH_1.zip
and deploy to: MAXDAT_ETL_PATH
tx_run_bpm.sh


10. Run dos2unix -k -o tx_run_bpm.sh

11. Start jobs on MAXDAT DB:
 execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

12.Turn on tx_run_bpm.sh cron job (For APT Environemt and above)


