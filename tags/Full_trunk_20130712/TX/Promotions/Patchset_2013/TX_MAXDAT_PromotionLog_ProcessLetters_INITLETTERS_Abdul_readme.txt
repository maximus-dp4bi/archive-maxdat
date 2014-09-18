PROJECT_NAME -> TXEB -Process Letters
RELEASE_NUMBER -> 

ENVIRONMENT -> 10.11.134.1 or TXEBMXDA(UAT) 

DEPLOYMENT START_TIME_DATE -> Deploy After TXEB- Manage Jobs
DEPLOYMENT COMPLETE_BY_TIME ->
CONTACT_NAME: Abdul Farhan
CONTACT_NUMBER: (cell 646.464.3984)
SVN_URL -> See Below

This release consists of the following updates:
1.Y - ETL scripts
2.Y - SQL scripts
3.N - MicroStrategy Object
4.N - Configuration
5.Y - Special Instructions:

SPECIAL INSTRUCTIONS ->
If there are error in any one of the following scripts in steps 1 and 10
please stop and notify us otherwise it creates more clean up for all of us.


STEP BY STEP INSTRUCTIONS  - >
1. Turn off tx_run_bpm.sh cron job, then do the steps 1 - 10 in that order.


2. - Stop jobs on TXEBMXDA:
execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;


3. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DO_INITLETTERS_MAXDAT_ABDUL_1.zip
and run them in TXEBMXDA(UAT) in the same order as below.

LETTERS_STG_ddl.sql
CORP_ETL_PROC_LETTERS_DDL.sql
CORP_ETL_PROC_LETTERS_CHD_DDL.sql
CORP_ETL_PROC_LETTERS_OLTP_DDL.sql
CORP_ETL_PROC_LETTERS_WIP_BPM_DDL.sql
CORP_INSTANCE_CLEANUP_TABLE_ddl.sql
CORP_ETL_PROC_LETTERS_CHD_TMP_DDL.sql
SEQ_CORP_ETL_PROC_LETTERS.sql
SemanticModel_Process_Letters.sql
ALTER TABLESPACE PL.sql


4. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DB_INITLETTERS_MAXDAT_ABDUL_1.zip
and run them in TXEBMXDA(UAT) in the same order as below.

function_GET_INLIST_STR3.sql
TRG_CORP_ETL_PROC_LETTERS.sql
TRG_AI_CORP_ETL_PROC_LETTERS_Q.sql
TRG_AU_CORP_ETL_PROC_LETTERS_Q.sql
PROCESS_LETTERS_pkg.sql
BPM_EVENT_PROJECT_pkg_body.sql
BPM_SEMANTIC_PROJECT_pkg_body.sql


5.Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DG_INITLETTERS_MAXDAT_ABDUL_1.zip
and run them in TXEBMXDA in the same order as below.

GRANT_SYNONYM_TO_PROCESS_LETTERS.sql


6. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DS_INITLETTERS_MAXDAT_ABDUL_1.zip
and run them in TXEBMXDA in the same order as below.

CORP_ETL_PROC_LETTERS_Variables_ddl.sql
populate_lkup_tables.sql
populate_BPM_EVENT_MASTER.sql
populate_BPM_ATTRIBUTE_LKUP.sql
populate_BPM_ATTRIBUTE.sql
populate_BPM_ATTRIBUTE_STAGING_TABLE.sql


7. Create directory for kettle scripts as follows:
MAXDAT_ETL_PATH/ProcessLetters


8. Unzip the following zip file 
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_INITLETTERS_MAXDAT_ABDUL_1.zip
and deploy ALL kettle scripts(*.kjb, *.ktr)
TO: MAXDAT_ETL_PATH/ProcessLetters



9. Unzip the following kettle scripts and Shell script from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_RUNINITLETTERS_MAXDAT_ABDUL_1.zip
TO: MAXDAT_ETL_PATH

Run_Initialization.kjb
Letters_STG.kjb
3_CDC_Letters_stg.ktr
Set_letters_Last_Upd_Dt.ktr
tx_run_bpm.sh


10. Run dos2unix -k -o tx_run_bpm.sh

11. Start jobs on TXEBMXDA:
 execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

12.Turn on tx_run_bpm.sh cron job



