***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB Unix and Kettle Scripts
----------------
2013/07/30 Devin  - Created
2013/07/30 B.Thai - TXEB Client Inquiry initial deployment.
2013/08/01 Devin  - TEXB MANAGE Work
2013/08/01 Abdul  - TXEB Process Letters
2013/08/01 Mayuresh - TXEB Manage Jobs

******************************************************************************************************

------------------------------
1. UNIX SCRIPTS SECTION
------------------------------
Deployed to scripts directory

Add file call .profile to the home directoy, select or update the directories according to the environment being deployed. These varaibles need to be avaliable when admin and cron attempt to run an etl:
MAXDAT_ETL_PATH = ???  Any Mounted files system and Directory Path for Maxdat etl scripts
MAXDAT_ETL_LOGS = ???  Any Mounted files system and Directory Path for Maxdat etl Logs
MAXDAT_KETTLE_DIR= Location of kettle Data Integration
STCODE=TX

-------------------------------------------------
Texas Maxdat Scripts Directories
 
MAXDAT_ETL_PATH /ManageJobs
MAXDAT_ETL_PATH /ManageWork
MAXDAT_ETL_PATH /ProcessIncidents
MAXDAT_ETL_PATH /ProcessLetters
MAXDAT_ETL_PATH /ProcessMailFaxDoc
MAXDAT_ETL_PATH /EnrollmentDataEMRS
MAXDAT_ETL_PATH /SupportClientInquiry
MAXDAT_ETL_PATH /ManageEnrollmentActivity
MAXDAT_ETL_PATH /ClientOutreach
MAXDAT_ETL_PATH /CommunityOutreach

Java memory stack should be set to 4 g

- Copy kettle.properties file to .Kettle directory in kettle home
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/config/.kettle/<system>_kettle.properties Rename to kettle.properties
svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/config/.kettle/shared.xml

Create  connections in jdbc.propteries to match environment, it if deploying to IPT goes to IPT, PRD goes to PRD
# MAXDAT SCHEMA
MAXDAT_Schema/type=javax.sql.DataSource
MAXDAT_Schema/driver=oracle.jdbc.driver.OracleDriver
MAXDAT_Schema/url=jdbc:oracle:thin:@10.11.135.2:1545:TXMAXDAT
MAXDAT_Schema/user=
MAXDAT_Schema/password=

#EB SCHEMA
EBSchema/type=javax.sql.DataSource
EBSchema/driver=oracle.jdbc.driver.OracleDriver
EBSchema/url=jdbc:oracle:thin:@10.200.147.8:1550:EBTRN1
EBSchema/user=
EBSchema/password=


DOwnload AS_INITIAL_SECT1_KETTLE_TXEB_SCRIPTS_1.zip and
to <MAXDAT_ETL_PATH> directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/
tx_emrs_init_load.sh
tx_run_emrs.sh
run_emrs_kjb.sh
run_emrs_ktr.sh
run_kjb.sh
run_ktr.sh
tx_run_bpm.sh
run_upd_sla_task_group.sh

Run dos2unix for the following List 
	(all *.sh scripts)

chmod 755 tx_emrs_init_load.sh
chmod 755 tx_run_emrs.sh
chmod 755 run_emrs_kjb.sh
chmod 755 run_emrs_ktr.sh
chmod 755 run_kjb.sh
chmod 755 run_ktr.sh
chmod 755 tx_run_bpm.sh
chmod 755 run_upd_sla_task_group.sh


------------------------------
2. COMMON SCRIPTS SECTION
------------------------------
Download AS_INITIAL_SECT2_KETTLE_CORP_SCRIPTS_1.zip, 
and deploy to <MAXDAT_ETL_PATH> directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/
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

Download AS_INITIAL_SECT2_KETTLE_TXEB_SCRIPTS_1.zip, 
and deploy to <MAXDAT_ETL_PATH> directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/
3_CDC_Letters_stg.ktr
bpm_Init_check.kjb
emrs_Init_check.kjb
Letters_STG.kjb
Load_OLTP_Lookups.kjb
ManageWork_Get_Variables.ktr
MW_Initial_load1.ktr
MW_Initial_load2.ktr
Run_Initialization.kjb
Set_letters_Last_Upd_Dt.ktr
UPD_SLA_Task_Groups_v2.ktr


------------------------------
3. Manage Work SECTION
------------------------------
Prerequisite: Unix and Common sections have been deployed

Download AS_INITIAL_SECT3_KETTLE_CORP_MANAGEWORK_1
and deploy to <MAXDAT_ETL_PATH> /ManageWork directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ManageWork
ManageWork_Insert.ktr
ManageWork_Move_updates.ktr
ManageWork_RUNALL.kjb
ManageWork_Save_Variables.ktr
ManageWork_Update2.ktr
ManageWork_Upd_Txn_pkg.ktr

Download AS_INITIAL_SECT3_KETTLE_TXEB_MANAGEWORK_1
and deploy to  <MAXDAT_ETL_LOG>

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/Miscellaneous
TXEB_Task_Type_Groups_v1.2.xls

and
Run, nohup run_upd_sla_task_group.sh 


------------------------------
4. Mail Fax Doc SECTION
------------------------------
Download AS_INITIAL_SECT4_KETTLE_TXEB_MAILFAXDOC_1
and deploy to <MAXDAT_ETL_PATH> /ProcessMailFaxDoc directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/ProcessMailFaxDoc/
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


------------------------------
5. Process Incidents SECTION
------------------------------
Download AS_INITIAL_SECT5_KETTLE_CORP_PROCESSINCIDENTS_1
and deploy to <MAXDAT_ETL_PATH> /ProcessIncidents directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ProcessIncidents
Set_global_variables.ktr
Set_Status_Variables.ktr
ProcessInc_STG_Insert.ktr
ProcessInc_Set_LastIncID_CntrlVariable.ktr
ProcessInc_Set_Inc_look_back_days.ktr
ProcessInc_Get_LastIncID_CntrlVariable.ktr
Process_Incidents_Updates8_AND_9_From_OLTP_STG_to_WIP_STG.ktr
Process_Incidents_Updates1_AND_2_From_OLTP_STG_to_WIP_STG.ktr
Process_Incidents_RUN_ALL.ktr
Process_Incidents_Job_Completed.ktr
Process_Incidents_Final_Updates_From_WIP_STG_to_BPM.ktr
Apply_UPD10_rules_and_load_to_PROCESS_INCIDENTS_WIP_BPM.ktr
Set_Prj_Control_Variable.ktr

Download AS_INITIAL_SECT5_KETTLE_TXEB_PROCESSINCIDENTS_1
and deploy to <MAXDAT_ETL_PATH> /ProcessIncidents directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/ProcessIncidents
Get_Updates_From_OLTP_TX.ktr
Process_Incidents_Updates3_AND_4_From_OLTP_STG_to_WIP_STG_TX.ktr
Process_Incidents_Updates5_AND_6_AND_7_From_OLTP_STG_to_WIP_STG_TX.ktr
ProcessInc_CaptureNewInc_OLTP_TX.ktr


------------------------------
6. Manage Jobs SECTION
------------------------------
Prerequisite: Unix and Common sections have been deployed

Download AS_INITIAL_SECT6_KETTLE_CORP_MANAGEJOBS_1
and deploy to <MAXDAT_ETL_PATH> /ManageJobs directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ManageJobs
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


------------------------------
7. Process Letters SECTION
------------------------------

Prerequisite: Unix and Common sections have been deployed

Download AS_INITIAL_SECT7_KETTLE_TXEB_PROCESSLETTERS_1
and deploy to <MAXDAT_ETL_PATH> //ProcessLetters directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/ProcessLetters
Process_Letters_runall.kjb
ProcessLetters_CaptureChildTable.kjb
ProcessLetters_CaptureChildTable.ktr
ProcessLetters_CaptureChildTable_Main.ktr
ProcessLetters_CaptureNewLetters.ktr
ProcessLetters_copy_to_temp.ktr
ProcessLetters_Get_ LastLetterReqID_CntrlVariable.ktr
ProcessLetters_Get_OLTP_details.ktr
ProcessLetters_MainJob_completed.ktr
ProcessLetters_Set_Env_var.ktr
ProcessLetters_set_MAX_LetterReqID.ktr
ProcessLetters_tmp_to_BPM_update.ktr
ProcessLetters_update1.ktr
ProcessLetters_update2.ktr
ProcessLetters_update5.ktr
ProcessLetters_update6.ktr
ProcessLetters_update7.ktr
ProcessLetters_update8.ktr
ProcessLetters_update9.ktr
ProcessLetters_update10.ktr
ProcessLetters_update11.ktr


------------------------------
8. Support Client Inquiry SECTION
------------------------------
Download AS_INITIAL_SECT8_KETTLE_CORP_SUPPORTCLIENTINQUIRY_1
and deploy to <MAXDAT_ETL_PATH> /SupportClientInquiry directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/SupportClientInquiry/
ClientInquiry_Child_Calc_Parent_Attr.kjb
ClientInquiry_Child_Insert_INS1_30.ktr
ClientInquiry_Child_Inserts.kjb
ClientInquiry_Child_Job_Completed.ktr
ClientInquiry_Child_RUNALL.kjb
ClientInquiry_Child_Update_BPM.ktr
ClientInquiry_Child_Update_Contact.ktr
ClientInquiry_Child_Update_Participant_Status.ktr
ClientInquiry_Child_Update_Translation_Req.ktr
ClientInquiry_Child_Update_UPD1_30.ktr
ClientInquiry_Child_Update_UPD1_35.ktr
ClientInquiry_Child_Update_UPD1_40.ktr
ClientInquiry_Child_Update_UPD2_10.ktr
ClientInquiry_Child_Update_UPD2_20.ktr
ClientInquiry_Child_Updates.kjb
ClientInquiry_Main_Get_Active_Contacts.ktr
ClientInquiry_Main_Job_Completed.ktr
ClientInquiry_Main_RUNALL.kjb
ClientInquiry_Main_Set_Env_Variables.ktr
ClientInquiry_Main_Update_BPM.ktr
ClientInquiry_Main_Update_Rules.kjb
ClientInquiry_Main_Update_Variables.ktr


Download AS_INITIAL_SECT8_KETTLE_TXEB_SUPPORTCLIENTINQUIRY_1
and deploy to <MAXDAT_ETL_PATH> /SupportClientInquiry directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/TX/ETL/scripts/SupportClientInquiry/
ClientInquiry_Child_Insert_INS1_20_TX.ktr
ClientInquiry_Child_Update_UPD1_20_TX.ktr
ClientInquiry_Main_Insert_Rules_TX.ktr
ClientInquiry_Main_Update_UPD1_10_TX.ktr



















