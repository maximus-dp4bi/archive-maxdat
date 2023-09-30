PROJECT_NAME -> TXEB - Process Incidents
RELEASE_NUMBER -> 

ENVIRONMENT -> MAXDAT  Databases and App Servers
Here we will specify the app server and DBs to deploy to

DEPLOYMENT START_TIME_DATE -> 
DEPLOYMENT COMPLETE_BY_TIME -> 
CONTACT_NAME: Saraswathi Konidena
CONTACT_NUMBER: (cell 571.294.6487)
SVN_URL -> See Below


SPECIAL INSTRUCTIONS ->
If there are error in any one of the following scripts in steps 1 and 12
please stop and notify us otherwise it creates more clean up for all of us.


STEP BY STEP INSTRUCTIONS  - >
1. (For APT Environemt and above) Turn off tx_run_bpm.sh cron job, then do the steps 1 - 12 in that order.


2. - Stop jobs on MAXDAT DB:
execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;



3. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DO_INITPI_MAXDAT_SARA_1.zip
and run them in MAXDAT DB in the same order as below.

CORP_ETL_PROCESS_INCIDENTS_DDL.sql
SEQ_CORP_ETL_PROCESS_INCIDENTS.sql
TRG_CORP_ETL_PROCESS_INCIDENTS.sql
PROCESS_INCIDENTS_OLTP_DDL.sql
PROCESS_INCIDENTS_WIP_BPM_DDL.sql
SemanticModel_DPY_ProcessIncidents.sql


4. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DB_INITPI_MAXDAT_SARA_1.zip
and run them in MAXDAT DB in the same order as below.

TRG_AI_CORP_ETL_PROC_INCDNTS_Q.sql
TRG_AU_CORP_ETL_PROC_INCDNTS_Q.sql
DPY_PROCESS_INCIDENTS_pkg.sql
BPM_EVENT_PROJECT_pkg_body.sql
BPM_SEMANTIC_PROJECT_pkg_body.sql



5. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DG_INITPI_MAXDAT_SARA_1.zip
and run them in MAXDAT DB in the same order as below.

GRANT_SYNONYM_PROCESS_INCIDENT.sql


6. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DS_INITPI_MAXDAT_SARA_1.zip
and run them in MAXDAT DB in the same order as below.

INSERT_to_CORP_ETL_CONTROL.sql
corp_etl_list_lkup.sql
populate_lkup_tables.sql
populate_BPM_ATTRIBUTE_LKUP.sql
populate_BPM_ATTRIBUTE.sql
populate_BPM_ATTRIBUTE_STAGING_TABLE.sql


7. Create directory for kettle scripts as follows(Where MAXDAT_ETL_PATH = the Maxdat Scripts Directory ):
MAXDAT_ETL_PATH/ProcessIncidents


8. Unzip the following zip file 
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_INITPI_MAXDAT_SARA_1.zip
and deploy ALL kettle scripts(*.kjb, *.ktr). Except tx_run_bpm.sh 
TO: MAXDAT_ETL_PATH/ProcessIncidents

Apply_UPD10_rules_and_load_to_PROCESS_INCIDENTS_WIP_BPM.ktr
Changed_data_capture.ktr
Get_Updates_From_OLTP.ktr
Get_Updates_From_OLTP2.ktr
Process_Incidents_Final_Updates_From_WIP_STG_to_BPM.ktr
Process_Incidents_RUN_ALL.kjb
Process_Incidents_updates_from_OLTP_to_STG.kjb
Process_Incidents_Updates1_AND_2_From_OLTP_STG_to_WIP_STG.ktr
Process_Incidents_Updates3_AND_4_From_OLTP_STG_to_WIP_STG.ktr
Process_Incidents_Updates5_AND_6_AND_7_From_OLTP_STG_to_WIP_STG.ktr
Process_Incidents_Updates8_AND_9_From_OLTP_STG_to_WIP_STG.ktr
ProcessInc_CaptureNewInc_OLTP.ktr
ProcessInc_Get_LastCDCtime.ktr
ProcessInc_Get_LastIncID_CntrlVariable.ktr
ProcessInc_InsertChangeDataCapture.kjb
ProcessInc_Set_CDC_Start_time.ktr
ProcessInc_Set_Inc_look_back_days.ktr
ProcessInc_Set_LastIncID_CntrlVariable.ktr
ProcessInc_STG_Insert.ktr
Set_global_variables.ktr
Set_Status_Variables.ktr
Update_Closed_Incidents.ktr



9. Unzip the UNIX Scripts(tx_run_bpm.sh) from 
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_INITPI_MAXDAT_SARA_1.zip
and deploy to: MAXDAT_ETL_PATH

tx_run_bpm.sh


10. Run dos2unix -k -o tx_run_bpm.sh

11. Start jobs on TXEBMXDA:
 execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

12.Turn on tx_run_bpm.sh cron job (For APT Environemt and above)


