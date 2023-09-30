PROJECT_NAME -> TXEB - Process Mail Fax
RELEASE_NUMBER -> 

ENVIRONMENT -> MAXDAT  Databases and App Servers
Here we will specify the app server and DBs to deploy to


DEPLOYMENT START_TIME_DATE -> 
DEPLOYMENT COMPLETE_BY_TIME -> 
CONTACT_NAME: Mousumi Chattaraj
CONTACT_NUMBER: (cell 916.425.6258)
SVN_URL -> See Below


SPECIAL INSTRUCTIONS ->
If there are error in any one of the following scripts in steps 1 and 10
please stop and notify us otherwise it creates more clean up for all of us.


STEP BY STEP INSTRUCTIONS  - >
1. (For APT Environemt and above) Turn off tx_run_bpm.sh cron job, then do the steps 1 - 10 in that order.


2. - Stop jobs on MAXDAT DB:
execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;



3. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DO_INITMF_MAXDAT_MOUSUMI_1.zip
and run them in MAXDAT DB in the same order as below.

CORP_ETL_MAILFAXDOC_DDL.sql
CORP_ETL_MAILFAXDOC_OLTP_DDL.sql
CORP_ETL_MAILFAXDOC_WIP_BPM_DDL.sql
create_indexes_mailfaxdoc.sql
SEQ_CEMFD_ID.sql
SemanticModel_Manage_Mail_Fax_Doc.sql



4. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DB_INITMF_MAXDAT_MOUSUMI_1.zip
and run them in MAXDAT DB in the same order as below.

TRG_R_corp_etl_mailfaxdoc.sql
TRG_AI_CORP_ETL_MAILFAXDOC_Q.sql
TRG_AU_CORP_ETL_MAILFAXDOC_Q.sql
MANAGE_MAIL_FAX_DOC_pkg.sql
BPM_EVENT_PROJECT_pkg_body.sql
BPM_SEMANTIC_PROJECT_pkg_body.sql



5. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DG_INITMF_MAXDAT_MOUSUMI_1.zip
and run them in MAXDAT DB in the same order as below.

DG_mail_fax_doc.sql


6. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DS_INITMF_MAXDAT_MOUSUMI_1.zip
and run them in MAXDAT DB in the same order as below.

corp_etl_list_lkup_final_wrk_tsk.sql
corp_etl_list_lkup_jeopardy_wrk_tsk.sql
corp_etl_lkup_insert_script.sql
insert_MAILFAX_CLEANUP.sql
populate_lkup_tables.sql
populate_BPM_EVENT_MASTER.sql
populate_BPM_ATTRIBUTE_LKUP.sql
populate_BPM_ATTRIBUTE.sql
populate_BPM_ATTRIBUTE_STAGING_TABLE.sql



7. Create directory for kettle scripts as follows (Where MAXDAT_ETL_PATH = the Maxdat Scripts Directory ):
MAXDAT_ETL_PATH/ProcessMailFaxDoc


8. Unzip the following zip file 
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_INITMF_MAXDAT_MOUSUMI_1.zip
and deploy ALL kettle scripts(*.kjb, *.ktr). Except tx_run_bpm.sh 
TO: MAXDAT_ETL_PATH/ProcessMailFaxDoc

Process_mail_fax_doc_runall.kjb
ProcessMailFax_CaptureNewDoc_create.ktr
ProcessMailFax_Cleanup.ktr
ProcessMailFax_copy_to_tmp.ktr
ProcessMailFax_Get_ LastDocID_CntrlVariable.ktr
ProcessMailFax_Get_gwf_work_identified.ktr
ProcessMailFax_Get_MAXe_autolink_Dtl.ktr
ProcessMailFax_Get_MAXe_classify_tsk_Dtl.ktr
ProcessMailFax_Get_MAXe_IA_tsk_Dtl.ktr
ProcessMailFax_Get_MAXe_manual_tsk_Dtl.ktr
ProcessMailFax_Get_MAXe_work_tsk_Dtl.ktr
ProcessMailFax_Set_Env_Var.ktr
ProcessMailFax_set_MAX_DCN.ktr
ProcessMailFax_Tmp_to_BPM_Update.ktr
ProcessMailFaxUpdates_from_STG_to_TMP.ktr
ProcessMailFaxUpdates_update1.ktr
ProcessMailFaxUpdates_update2.ktr
ProcessMailFaxUpdates_update3.ktr
ProcessMailFaxUpdates_update4.ktr
ProcessMailFaxUpdates_update5.ktr
ProcessMailFaxUpdates_update6.ktr
ProcessMailFaxUpdates_update7.ktr
ProcessMailFaxUpdates_update8.ktr



9. Unzip the UNIX Scripts(tx_run_bpm.sh) from 
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_INITMF_MAXDAT_MOUSUMI_1.zip
and deploy to: MAXDAT_ETL_PATH
tx_run_bpm.sh


10. Run dos2unix -k -o tx_run_bpm.sh

11. Start jobs on MAXDAT DB:
 execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

12.Turn on tx_run_bpm.sh cron job (For APT Environemt and above)


