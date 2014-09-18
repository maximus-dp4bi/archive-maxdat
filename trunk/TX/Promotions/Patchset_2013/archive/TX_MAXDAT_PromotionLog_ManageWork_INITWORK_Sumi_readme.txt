PROJECT_NAME -> TXEB - Manage Jobs
RELEASE_NUMBER -> 

ENVIRONMENT -> 10.11.134.1 or TXEBMXDU(UAT) 

DEPLOYMENT START_TIME_DATE -> 
DEPLOYMENT COMPLETE_BY_TIME -> 
CONTACT_NAME: 
CONTACT_NUMBER: 
SVN_URL -> See Below


SPECIAL INSTRUCTIONS ->
If there are error in any one of the following scripts in steps 1 and 13
please stop and notify us otherwise it creates more clean up for all of us.


STEP BY STEP INSTRUCTIONS  - >

1. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DO_INIT_MAXDAT_SUMI_1.zip
and run them in TXMAXDAT in the same order as below.

corp_etl_control_ddl.sql
corp_etl_list_lkup_ddl
corp_etl_list_lkup_hist_ddl.sql
groups_stg_ddl.sql
holidays_ddl.sql
staff_stg_ddl.sql
step_definition_stg_ddl.sql
step_instance_stg_ddl.sql
GRP_STEP_DEFINITION_STG_DDL.sql
GRP_STEP_DEFN_DFLT_STG_DDL.sql
corp_etl_error_log_ddl
CORP_INSTANCE_CLEANUP_TABLE_ddl.sql
SEQ_CICT_ID
SEQ_CEEL_ID
seq_cec.sql
SEQ_CELL_ID.sql
Seq_cemw_Id.sql
Seq_holiday_Id.sql
CELL_HISTORY_SEQ
STAFF_LKUP_VW.sql
MW_STEP_INSTANCE_VW.sql


2. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DB_INIT_MAXDAT_SUMI_1.zip
and run them in TXMAXDAT in the same order as below.

TRG_BIUR_CORP_ETL_ERROR_LOG.sql
TRG_BIU_R_HOLIDAYS.trg
TRG_cec.trg
TRG_R_AIUD_ETL_LIST_LKUP_HIST.trg
TRG_R_ETL_LIST_LKUP.trg
Trigger_Step_Instance_Stg.sql
TRG_R_CORP_INSTANCE_CLEANUP_TABLE.sql
Get_WeekDay.fnc
get_bus_date.fnc
function_GET_INLIST_STR3.sql
function_get_inlist_str2.sql
BUS_DAYS_BETWEEN.fnc


3.Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DO_INITWORK_MAXDAT_SUMI_1.zip
nd run them in TXMAXDAT in the same order as below.

corp_etl_manage_work_ddl.sql
corp_etl_manage_work_ddl.sql
seq_cemw_id.sql
TRG_R_CORP_ETL_MANAGE_WORK.trg
corp_etl_manage_work_pkg.pck
TRG_AI_CORP_ETL_MANAGE_WORK_Q.sql
TRG_AU_CORP_ETL_MANAGE_WORK_Q.sql
SemanticModel_Manage_Worksql
MANAGE_WORK_pkg.sql


4.Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DB_INITWORK_MAXDAT_SUMI_1.zip
and run them in TXMAXDAT in the same order as below.

TRG_R_CORP_ETL_MANAGE_WORK
corp_etl_manage_work_pkg
TRG_AI_CORP_ETL_MANAGE_WORK_Q.sql
TRG_AU_CORP_ETL_MANAGE_WORK_Q.sql
createdb/SemanticModel_Manage_Work.sql
MANAGE_WORK_pkg.sql


5. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DS_INIT_MAXDAT_SUMI_1.zip
and run them in TXMAXDAT in the same order as below.

INS_corp_etl_control_init
populate_lkup_tables.sql
populate_BPM_EVENT_MASTER.sql
populate_BPM_ATTRIBUTE_LKUP.sql
populate_BPM_ATTRIBUTE.sql
populate_BPM_ATTRIBUTE_STAGING_TABLE.sql


6. Unzip the following files from
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/DG_INIT_MAXDAT_SUMI_1.zip
and run them in TXMAXDAT in the same order as below.

DG_TXEB_MAXDAT605_SUMI_1

7. Create directory for kettle scripts as follows:
/u25/ETL_Scripts/UAT/scripts/ManageJobs

8.Unzip the following zip file 
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_INIT_MAXDAT_SUMI_1.zip
and deploy all kettle scripts(*.kjb, *.ktr)
TO: /u25/ETL_Scripts/UAT/scripts

9. Unzip the following zip file 
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/Promotions/Patchset_2013/AS_INITWORK_MAXDAT_SUMI_1.zip
and deploy all kettle scripts(*.kjb, *.ktr)
TO: /u25/ETL_Scripts/UAT/scripts/ManageWork


--Sumi,7/12/2013 - haven't changed tx_run_bpm.sh
--10. Download the UNIX Scripts(tx_run_bpm.sh) from 
--svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/tx_run_bpm.sh
--and deploy to: /u25/ETL_Scripts/UAT/scripts


11. Run dos2unix -k -o tx_run_bpm.sh

12. Start jobs on TXMAXDAT:
 execute PROCESS_BPM_QUEUE_JOB_CONTROL.STARTUP_JOBS;

13.Turn on tx_run_bpm.sh cron job


