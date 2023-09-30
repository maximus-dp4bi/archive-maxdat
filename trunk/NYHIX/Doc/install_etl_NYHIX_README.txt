***** MODIFICATION HISTORY ****************************************************************************
Instructions to install NYHIX Unix and Kettle Scripts
----------------
2013/07/31 S.Pagadrai  - Created
2013/08/09 Devin       - Modified for NYHIX (after Tx was completed, made it more uniform)
2013/09/09 Dave D      - Updated the Profile section (Section 1)
2013/09/28 S.Pagadrai  - Updated NYHIX Mail Fax Doc Project Files
2014/10/1 S.Pagadrai - Updated NYHIX Mail Fax Doc V2 Project Files
2014/10/22 S.Pagadrai - Updated Doc Notifications Project Files

******************************************************************************************************

Prerequisite Replace {sys} with the system  being created (dev, uat, or prd)
------------------------------
1. UNIX SCRIPTS SECTION
------------------------------
Deployed to scripts directory 

Add or update .bash_profile**

export STCODE='NYHIX'
export PENTAHO_JAVA_HOME='/u01/app/appadmin/product/java/jdk1.6.0_45'
export MAXDAT_KETTLE_DIR='/u01/app/appadmin/product/data-integration'
#
export ENV_CODE='dev'
#export ENV_CODE='uat'
#export ENV_CODE='prd'
#
export MAXDAT_ETL_PATH = /u01/maximus/maxdat-${ENV_CODE}/${STCODE}/ETL/scripts
export MAXDAT_ETL_LOGS = /u01/maximus/maxdat-${ENV_CODE}/${STCODE}/ETL/logs
export KETTLE_NYHIX_HOME = /u01/maximus/maxdat-${ENV_CODE}/${STCODE}/config
export PATH=$KETTLE_NYHIX_HOME/.kettle/kettle.properties:.:$MAXDAT_KETTLE_DIR:$PATH

**Note: Uncomment only the appropriate environment variable - dev/uat/prd - to match the environment and path of
       the system of deployment.  Also as this is a bash shell environment, do not leave uncommented blank lines.
-------------------------------------------------
NYHIX Maxdat Scripts Directories
 
$MAXDAT_ETL_PATH/ManageWork
$MAXDAT_ETL_PATH/ProcessMailFaxDoc
$MAXDAT_ETL_PATH/ProcessMailFaxBatch

Java memory stack should be set to 4 g


Copy from  svn://rcmxapp1d.maximus.com/maxdat/trunk/NYHIX/config/.kettle/
Deply to $MAXDAT_ETL_PATH/.kettle
	shared.xml
	${ENV_CODE}_kettle.properties
run dos2unix -o-k ${ENV_CODE}_kettle.properties 
Rename ${ENV_CODE}_kettle.properties to kettle.properties

change kettle.properties, Add conection information
#DMS
DB_DMS_NAME=
DB_DMS_HOSTNAME=
DB_DMS_PORT=
DB_DMS_USER=
DB_DMS_PASSWORD=

#OLTP Source
DB_OLTP_NAME=
DB_OLTP_HOSTNAME=
DB_OLTP_PORT=
DB_OLTP_USER=
DB_OLTP_PASSWORD=

#KOFAX ARS
DB_KOFAX_ARS_HOSTNAME=
DB_KOFAX_ARS_PORT=
DB_KOFAX_ARS_INSTANCE=
DB_KOFAX_ARS_DB=
DB_KOFAX_ARS_USER=
DB_KOFAX_ARS_PASSWORD=

#KOFAX REMOTE
DB_KOFAX_REMOTE_HOSTNAME=
DB_KOFAX_REMOTE_PORT=
DB_KOFAX_REMOTE_INSTANCE=
DB_KOFAX_REMOTE_DB=
DB_KOFAX_REMOTE_USER=
DB_KOFAX_REMOTE_PASSWORD=

#KOFAX CENTRAL
DB_KOFAX_CENTRAL_HOSTNAME=
DB_KOFAX_CENTRAL_PORT=
DB_KOFAX_CENTRAL_INSTANCE=
DB_KOFAX_CENTRAL_DB=
DB_KOFAX_CENTRAL_USER=
DB_KOFAX_CENTRAL_PASSWORD=


Copy  from svn://rcmxapp1d.maximus.com/maxdat/trunk/NYHIX/scripts
to $MAXDAT_ETL_PATH directory

run_kjb.sh
run_ktr.sh
nyhix_run_bpm.sh
run_upd_sla_task_group.sh

Run 
chmod 777 run_kjb.sh
chmod 777 run_ktr.sh
chmod 777 nyhix_run_bpm.sh
chmod 777 run_upd_sla_task_group.sh

Run 
dos2unix -o-k run_kjb.sh
dos2unix -o-k run_ktr.sh
dos2unix -o-k nyhix_run_bpm.sh
dos2unix -o-k run_upd_sla_task_group.sh

------------------------------
2. COMMON SCRIPTS SECTION
------------------------------

Copy from svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts
Deploy to $MAXDAT_ETL_PATH directory

Load_GRP_STEP_DEF.ktr
Load_GRP_STEP_DEF_DEFAULT.ktr
Load_Step_Instance_Stg.kjb
ManageWork_Capture_OLTP.ktr
step_instance_stg_dbl_chk.ktr
Setup_Job_Log.ktr
Update_Job_Log_Error.ktr
UPD_GROUPS_STG.ktr
UPD_HOLIDAYS_STG.ktr
UPD_STAFF_STG.ktr
UPD_STEPDEF_STG.ktr

Copy from svn://rcmxapp1d.maximus.com/maxdat/trunk/NYHIX/ETL/scripts
Deploy to $MAXDAT_ETL_PATH directory

bpm_Init_check.kjb
Load_OLTP_Lookups.kjb
ManageWork_Get_Variables.ktr
Run_Initialization.kjb
UPD_SLA_Task_Groups_v2.ktr


------------------------------
3. Manage Work SECTION
------------------------------
Prerequisite: Unix and Common sections have been deployed

Copy from svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ManageWork
Deploy to $MAXDAT_ETL_PATH/ManageWork directory

ManageWork_Insert.ktr
ManageWork_Move_updates.ktr
ManageWork_RUNALL.kjb
ManageWork_Save_Variables.ktr
ManageWork_Update2.ktr
ManageWork_Upd_Txn_pkg.ktr


------------------------------
4. Mail Fax Doc SECTION
------------------------------
Deployed to ProcessMailFaxDoc directory

Copy from svn://rcmxapp1d.maximus.com/maxdat/trunk/NYHIX/ETL/scripts/ProcessMailFaxDoc
Deploy to $MAXDAT_ETL_PATH/MailFaxDoc directory

chk_dms_connect.kjb
set_global_variables.ktr
ProcessMailFaxDoc_Setup_Job_Log.ktr
ProcessMailFaxDoc_Variables.kjb
ProcessMailFax_lookbackVariable.ktr
ProcessMailFax_get_doc_status.ktr
ProcessMailFax_get_complaint_task_id.ktr
ProcessMailFax_get_Appeal_task_id.ktr
ProcessMailFax_get_HSDE-QC_task_id.ktr
ProcessMailFax_get_Manual_task_id.ktr
ProcessMailFax_get_docsetlink_qc_task_id.ktr
ProcessMailFax_get_esc_task_id.ktr
ProcessMailFax_get_de_task_id.ktr
ProcessMailFax_get_maximus_qc_task_id.ktr
ProcessMailFax_get_esc_task_id2.ktr
ProcessMailFaxDoc_Insert.kjb
ProcessMailFax_CaptureNewDoc_DMS.ktr
ProcessMailFax_CaptureNewDoc_MAXe.ktr
ProcessMailFax_copy_to_tmp.ktr
ProcessMailFax_CDC_MAXe.ktr
ProcessMailFax_Set_look_back_days.ktr
ProcessMailFax_Update_Job_Error.ktr
ProcessMailFaxDoc_Step_lkup.kjb
ProcessMailFax_complaint_attributes.ktr
ProcessMailFax_appeal_attributes.ktr
ProcessMailFax_hsde_qc_attributes.ktr
ProcessMailFax_manual_link_attributes.ktr
ProcessMailFax_docsetlink_qc_qttributes.ktr
ProcessMailFax_esc_task_attributes.ktr
ProcessMailFax_de_task_attributes.ktr
ProcessMailFax_maximus_qc_attributes.ktr
ProcessMailFax_esc_task2_attributes.ktr
ProcessMailFaxDoc_Updates.kjb
ProcessMailFaxUpdates_update1.ktr
ProcessMailFaxUpdates_update2.ktr
ProcessMailFaxUpdates_update3.ktr
ProcessMailFaxUpdates_update4.ktr
ProcessMailFaxUpdates_update5.ktr
ProcessMailFaxUpdates_update6.ktr
ProcessMailFaxUpdates_update7.ktr
ProcessMailFaxUpdates_update8.ktr
ProcessMailFaxUpdates_update9.ktr
ProcessMailFaxUpdates_update10.ktr
ProcessMailFaxUpdates_update11.ktr
ProcessMailFaxUpdates_update12.ktr
ProcessMailFaxUpdates_update13.ktr
ProcessMailFaxUpdates_update14.ktr
ProcessMailFaxUpdates_update15.ktr
ProcessMailFaxUpdates_update16.ktr
ProcessMailFaxUpdates_update17.ktr
ProcessMailFaxUpdates_update18.ktr
ProcessMailFaxUpdates_update19.ktr
ProcessMailFax_Tmp_to_BPM_Update.ktr
ProcessMailFaxDoc_Update_job_Log.ktr



------------------------------
5. Mail Fax Doc Batch SECTION
------------------------------
Deployed to ProcessIncidents directory

MailFaxBatch_ARS_RUNALL.kjb                     MailFaxBatch_Stg_Remote_OLTP_BATCH.ktr
MailFaxBatch_Central_RUNALL.kjb                 MailFaxBatch_Stg_Remote_OLTP_FORM.ktr
MailFaxBatch_Insert_ARS.kjb                     MailFaxBatch_Stg_Remote_OLTP.kjb
MailFaxBatch_Insert_BATCH_EVENTS.ktr            MailFaxBatch_UPD10_010.ktr
MailFaxBatch_Insert_BATCH.ktr                   MailFaxBatch_UPD11_010.ktr
MailFaxBatch_Insert_DOCUMENT.ktr                MailFaxBatch_UPD11_020.ktr
MailFaxBatch_Insert_ENVELOPE.ktr                MailFaxBatch_UPD1_ARS_BATCH.ktr
MailFaxBatch_Insert_FORM.ktr                    MailFaxBatch_UPD1_BATCH_Docs_Created.ktr
MailFaxBatch_Insert.kjb                         MailFaxBatch_UPD1_BATCH_Docs_Deleted.ktr
MailFaxBatch_Move_Updates_ARS.kjb               MailFaxBatch_UPD1_BATCH_EVENTS.ktr
MailFaxBatch_MOVE_UPDATES_BATCH_EVENTS.ktr      MailFaxBatch_UPD1_BATCH.ktr
MailFaxBatch_MOVE_UPDATES_BATCH.ktr             MailFaxBatch_UPD1_BATCH_Pages_Deleted.ktr
MailFaxBatch_MOVE_UPDATES_DOCUMENT.ktr          MailFaxBatch_UPD1_BATCH_Pages_Replaced.ktr
MailFaxBatch_MOVE_UPDATES_ENVELOPE.ktr          MailFaxBatch_UPD1_BATCH_Pages_Scanned.ktr
MailFaxBatch_MOVE_UPDATES_FORM.ktr              MailFaxBatch_UPD1_DOCUMENT.ktr
MailFaxBatch_Move_Updates.kjb                   MailFaxBatch_UPD1_ENVELOPE.ktr
MailFaxBatch_Remote_RUNALL.kjb                  MailFaxBatch_UPD1_FORM.ktr
MailFaxBatch_RUNALL.kjb                         MailFaxBatch_UPD2_010.ktr
MailFaxBatch_RUNALL.sh                          MailFaxBatch_UPD3_010.ktr
MailFaxBatch_Setup_Job_Log_All.ktr              MailFaxBatch_UPD3_030.ktr
MailFaxBatch_Setup_Job_Log_ARS.ktr              MailFaxBatch_UPD4_010.ktr
MailFaxBatch_Setup_Job_Log_Central.ktr          MailFaxBatch_UPD5_010.ktr
MailFaxBatch_Setup_Job_Log_Remote.ktr           MailFaxBatch_UPD6_010.ktr
MailFaxBatch_Set_Variables.ktr                  MailFaxBatch_UPD7_010.ktr
MailFaxBatch_Stg_All.kjb                        MailFaxBatch_UPD8_010.ktr
MailFaxBatch_Stg_ARS_BATCH.ktr                  MailFaxBatch_UPD9_010.ktr
MailFaxBatch_Stg_ARS.kjb                        MailFaxBatch_Update_CORP_ETL_CONTROL_All.kjb
MailFaxBatch_Stg_ARS_OLTP_BATCH_COUNTS.ktr      MailFaxBatch_Update_CORP_ETL_CONTROL_ARS.ktr
MailFaxBatch_Stg_ARS_OLTP_DOCUMENT.ktr          MailFaxBatch_Update_CORP_ETL_CONTROL_Central.ktr
MailFaxBatch_Stg_ARS_OLTP_ENVELOPE.ktr          MailFaxBatch_Update_CORP_ETL_CONTROL_Remote.ktr
MailFaxBatch_Stg_ARS_OLTP.kjb                   MailFaxBatch_Update_Job_Error_All.ktr
MailFaxBatch_Stg_BATCH_EVENTS.ktr               MailFaxBatch_Update_Job_Error_ARS.ktr
MailFaxBatch_Stg_BATCH.ktr                      MailFaxBatch_Update_Job_Error_Remote_Central.ktr
MailFaxBatch_Stg_Central_OLTP_BATCH_EVENTS.ktr  MailFaxBatch_Update_Job_Log_All.kjb
MailFaxBatch_Stg_Central_OLTP_BATCH.ktr         MailFaxBatch_Update_Job_Log_BATCH_COUNTS.ktr
MailFaxBatch_Stg_Central_OLTP_FORM.ktr          MailFaxBatch_Update_Job_Log_BATCH_EVENTS.ktr
MailFaxBatch_Stg_Central_OLTP.kjb               MailFaxBatch_Update_Job_Log_BATCH.ktr
MailFaxBatch_Stg_DOCUMENT.ktr                   MailFaxBatch_Update_Job_Log_DOCUMENT.ktr
MailFaxBatch_Stg_ENVELOPE.ktr                   MailFaxBatch_Update_Job_Log_Envelope.ktr
MailFaxBatch_Stg_FORM.ktr                       MailFaxBatch_Update_Job_Log_Form.ktr
MailFaxBatch_Stg_OLTP_All.kjb                   MailFaxBatch_Updates_ARS.kjb
MailFaxBatch_Stg_Remote_OLTP_BATCH_EVENTS.ktr   MailFaxBatch_Updates.kjb


------------------------------
6. Mail Fax Doc V2 SECTION
------------------------------

set_global_variables.ktr
ProcessMailFaxDoc_Variables.kjb
ProcessMailFaxDoc_Updates.kjb
ProcessMailFaxDoc_Update_Job_Log.ktr
ProcessMailFaxDoc_Update_Job_Error.ktr
ProcessMailFaxDoc_Update_Control.ktr
ProcessMailFaxDoc_Update3.ktr
ProcessMailFaxDoc_Update2.ktr
ProcessMailFaxDoc_Update1.ktr
ProcessMailFaxDoc_Setup_Job_Log.ktr
ProcessMailFaxDoc_Runall.Kjb
ProcessMailFaxDoc_MoveUpdates.ktr
ProcessMailFaxDoc_lookbackVariable.ktr
ProcessMailFaxDoc_Insert_MAXe.ktr
ProcessMailFaxDoc_Insert_DMS.ktr
ProcessMailFaxDoc_Insert.kjb
ProcessMailFaxDoc_Copy_to_WIP.ktr
ProcessMailFaxDoc_Copy_to_Temp.ktr
ProcessMailFaxDoc_CheckConnections.kjb
ProcessMailFaxDoc_CDC_MAXe5.ktr
ProcessMailFaxDoc_CDC_MAXe4.ktr
ProcessMailFaxDoc_CDC_MAXe3.ktr
ProcessMailFaxDoc_CDC_MAXe2.ktr
ProcessMailFaxDoc_CDC_MAXe.ktr
ProcessMailFaxDoc_CDC.kjb
ProcessMailFaxDoc_Capture_indv.ktr
ProcessMailFaxDoc_Capture_CSC_Errors.ktr


------------------------------
7. Doc Notification SECTION
------------------------------

set_global_variables.ktr
ProcessDocNotifications_Variables.kjb
ProcessDocNotifications_Updates.kjb
ProcessDocNotifications_Update_Job_Log.ktr
ProcessDocNotifications_Update_Job_Error.ktr
ProcessDocNotifications_Update_Control.ktr
ProcessDocNotifications_Update3.ktr
ProcessDocNotifications_Update2.ktr
ProcessDocNotifications_Update1.ktr
ProcessDocNotifications_Setup_Job_Log.ktr
ProcessDocNotifications_Runall.Kjb
ProcessDocNotifications_MoveUpdates.ktr
ProcessDocNotifications_lookbackVariable.ktr
ProcessDocNotifications_Insert_DocNotif.ktr
ProcessDocNotifications_Insert.kjb
ProcessDocNotifications_Copy_to_WIP.ktr
ProcessDocNotifications_Copy_to_Temp.ktr
ProcessDocNotifications_CheckConnections.kjb
ProcessDocNotifications_CDC_STAFF.ktr
ProcessDocNotifications_CDC_MAXe.ktr
ProcessDocNotifications_CDC.kjb