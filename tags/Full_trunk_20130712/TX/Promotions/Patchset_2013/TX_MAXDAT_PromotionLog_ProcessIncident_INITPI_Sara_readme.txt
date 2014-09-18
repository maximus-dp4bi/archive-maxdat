PROJECT_NAME -> TXEB - Process Incidents
RELEASE_NUMBER -> 

ENVIRONMENT -> 10.11.134.1 or TXEBMXDA(UAT) 

DEPLOYMENT START_TIME_DATE -> 
DEPLOYMENT COMPLETE_BY_TIME -> 
CONTACT_NAME: Saraswathi Konidena
CONTACT_NUMBER: (cell 571.294.6487)
SVN_URL -> See Below

This release consists of the following updates:
1.Y - ETL scripts
2.Y - SQL scripts
3.N - MicroStrategy Object
4.Y - Configuration
5.Y - Special Instructions:

SPECIAL INSTRUCTIONS ->
If there are error in any one of the following scripts in steps 1 and 10
please stop and notify us otherwise it creates more clean up for all of us.


STEP BY STEP INSTRUCTIONS  - >
1. Turn off tx_run_bpm.sh cron job, then do the steps 1 - 10 in that order.


2. - Stop jobs on TXEBMXDA:
execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;



3. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DO_TEXB_PI_INIT_MAXDAT_SARA_1.zip
and run them in TXEBMXDA in the same order as below.

CORP_ETL_PROCESS_INCIDENTS_DDL.sql
SEQ_CORP_ETL_PROCESS_INCIDENTS.sql
TRG_CORP_ETL_PROCESS_INCIDENTS.sql
PROCESS_INCIDENTS_OLTP_DDL.sql
PROCESS_INCIDENTS_WIP_BPM_DDL.sql
SemanticModel_DPY_ProcessIncidents.sql


4. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DB_TEXB_PI_INIT_MAXDAT_SARA_1.zip
and run them in TXEBMXDA in the same order as below.

TRG_AI_CORP_ETL_PROC_INCDNTS_Q.sql
TRG_AU_CORP_ETL_PROC_INCDNTS_Q.sql
DPY_PROCESS_INCIDENTS_pkg.sql
BPM_EVENT_PROJECT_pkg_body.sql
BPM_SEMANTIC_PROJECT_pkg_body.sql



5. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DG_TEXB_PI_INIT_MAXDAT_SARA_1.zip
and run them in TXEBMXDA in the same order as below.

GRANT_SYNONYM_PROCESS_INCIDENT.sql


6. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DS_TEXB_PI_INIT_MAXDAT_SARA_1.zip
and run them in TXEBMXDA in the same order as below.

INSERT_to_CORP_ETL_CONTROL.sql
corp_etl_list_lkup.sql
populate_lkup_tables.sql
populate_BPM_ATTRIBUTE_LKUP.sql
populate_BPM_ATTRIBUTE.sql
populate_BPM_ATTRIBUTE_STAGING_TABLE.sql


7. Create directory for kettle scripts as follows:
MAXDAT_ETL_PATH/ProcessIncidents


8. Unzip the following zip file 
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_TEXB_PI_INIT_MAXDAT_SARA_1.zip
and deploy ALL kettle scripts(*.kjb, *.ktr). Except tx_run_bpm.sh 
TO: MAXDAT_ETL_PATH/ProcessIncidents

*Note*: Please do not download tx_run_bpm.sh 


9. Unzip the UNIX Scripts(tx_run_bpm.sh) from 
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_TEXB_PI_INIT_MAXDAT_SARA_1.zip
and deploy to: MAXDAT_ETL_PATH

tx_run_bpm.sh


10. Run dos2unix -k -o tx_run_bpm.sh

11. Start jobs on TXEBMXDA:
 execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

12.Turn on tx_run_bpm.sh cron job


