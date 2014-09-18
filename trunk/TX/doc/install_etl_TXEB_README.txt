 ***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB Unix and Kettle Scripts
----------------
2013/07/30 Devin  - Created
2013/07/30 B.Thai - TXEB Client Inquiry initial deployment.
2013/08/01 Devin  - TEXB MANAGE Work
2013/08/01 Abdul  - TXEB Process Letters
2013/08/01 Mayuresh - TXEB Manage Jobs
2013/08/29 Raj A. - TXEB Manage Enrollment Activity
2013/09/11 D.Dillon  - Checked against TX Prod


******************************************************************************************************

------------------------------
1. UNIX SCRIPTS SECTION
------------------------------
Deployed to scripts directory

Add to the file .profile in the home directoy. Update the directory paths according to the environment being deployed. These
   varaibles need to be avaliable when admin and cron attempt to run an etl:

SHELL=/bin/ksh
export SHELL
MAIL=/usr/mail/${LOGNAME:?}

# Setting Location Vars
MAXDAT_ETL_PATH= Set to the location of the directory "ETL_Scripts/scripts"
MAXDAT_ETL_LOGS= Set to the location of the directory "ETL_Logs/logs"
MAXDAT_KETTLE_DIR= Set to the location of the directory "data-integration" inside the kettle installation
STCODE=TX
ENV_CODE=XXX (Where XXX=DEV for Development, UAT for UAT and PRD for Production)

export MAXDAT_ETL_PATH
export MAXDAT_ETL_LOGS
export MAXDAT_KETTLE_DIR
export STCODE
export ENV_CODE

PATH=$MAXDAT_KETTLE_DIR:/usr/bin::/usr/X11/lib:/usr/X11/bin/:/usr/local/bin:/usr
/local/git/bin:/usr/local/sbin:/dtxe4t/3rdparty:/usr/X/bin
export PATH;


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
chmod 755 Run_onetime_RUN_INIT_KJB.sh
chmod 755 tx_run_bpm.sh
chmod 755 Run_onetime_ManageEnrl.sh


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
UPD_ENUM_ENROLL_TRANS_SOURCE.ktr
Load_OLTP_Lookups.kjb
CDC_CLIENT_ENROLL_STATUS_1.ktr
CDC_CLIENT_ENROLL_STATUS_2.ktr
Client_Enroll_Status_STG.kjb
CDC_SELECTION_TXN_1.ktr
CDC_SELECTION_TXN_2.ktr
Selection_txn_STG.kjb
CDC_CLIENT_ELIG_STATUS_1.ktr
CDC_CLIENT_ELIG_STATUS_2.ktr
Client_Enroll_Status_STG.kjb
CDC_COST_SHARE_DTLS_1.ktr
CDC_COST_SHARE_DTLS_2.ktr
Cost_Share_Details_STG.kjb
Run_Initialization.kjb
ManageEnrl_Run_Initialization.kjb


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



------------------------------
9. Client Outreach SECTION
------------------------------
Download 
and deploy to <MAXDAT_ETL_PATH> /ClientOutreach directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ClientOutreach/

ClientOutreach_runall.kjb
Setup_Job_Log.ktr
Client_Outreach_env_var.ktr
Client_Outreach_Get_CntrlVariable.ktr
Client_Outreach_INS1.ktr
Client_Outreach_INS2.ktr
Client_Outreach_updMAX_Event_id_ctrlVariable.ktr
ClientOutreach_OLTP_details.kjb
Client_Outreach_copy_TEMP.ktr
Client_Outreach_get_OLTP.ktr
Client_Outreach_get_OLTP_Validation.ktr
Client_Outreach_GetOLTP_SUBPROG.kjb
Client_Outreach_GetOLTP_SUBPROG_TMP.ktr
Client_Outreach_GetOLTP_SUBPROG.ktr
Client_Outreach_get_OLTP_Surveys.ktr
ClientOutreach_Updates.kjb
Client_Outreach_UPD1.ktr
Client_Outreach_UPD2.ktr
Client_Outreach_UPD3.ktr
Client_Outreach_ActivityLKUP.ktr
Client_Outreach_UPD4.ktr
Client_Outreach_UPD5.ktr
Client_Outreach_UPD6.ktr
Client_Outreach_UPD7.ktr
Client_Outreach_UPD8.ktr
Client_Outreach_UPD9.ktr
Client_Outreach_UPD10.ktr
Client_Outreach_UPD11.ktr
Client_Outreach_UPD12.ktr
Client_Outreach_UPD13.ktr
Client_Outreach_UPD14.ktr
Client_Outreach_UPD15.ktr
Client_Outreach_UPD16.ktr
Client_Outreach_UPD17.ktr
Client_Outreach_UPD18.ktr
Client_Outreach_UPD19.ktr
Client_Outreach_UPD20.ktr
Client_Outreach_UPD21.ktr
Client_Outreach_UPD24.ktr
Client_Outreach_UPD25.ktr
Client_Outreach_UPD_BPM_Main.ktr
Client_Outreach_updMAX_ctrlVariable.ktr
Client_Outreach_MainJob_completed.ktr




------------------------------
10. Community Outreach SECTION
------------------------------
Download 
and deploy to <MAXDAT_ETL_PATH> /CommunityOutreach directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/CommunityOutreach/

Community_Outreach_Get_LastSessionID_cntrlvar.ktr
CommunityOutreach_Child_temp_to_update.ktr
CommunityOutreach_temp_to_BPMupdate.ktr
CommunityOutreach_CaptureChildTable.ktr
CommunityOutreach_CaptureChildTable_INS2.ktr
CommunityOutreach_CaptureNewJob.ktr
CommunityOutreach_CaptureNewJob_test.ktr
CommunityOutreach_Child_Copy_to_temp.ktr
CommunityOutreach_Child_RunAll.kjb
CommunityOutreach_Child_Update1.ktr
CommunityOutreach_Copy_to_temp.ktr
CommunityOutreach_Env.ktr
CommunityOutreach_MainJob_completed.ktr
CommunityOutreach_RunAll.kjb
CommunityOutreach_Update1.ktr
CommunityOutreach_Update2.ktr
CommunityOutreach_Update3.ktr
CommunityOutreach_Update6.ktr
CommunityOutreach_Update7.ktr
CommunityOutreach_Update8.ktr
CommunityOutreach_Update9.ktr
CommunityOutreach_updMAX_ctrlVariable.ktr

------------------------------
11. Manage Enrollment Activity
------------------------------
Download 
and deploy to <MAXDAT_ETL_PATH> /ManageEnrollmentActivity directory

svn://rcmxapp1d.maximus.com/maxdat/trunk/corp/scripts/ManageEnrollmentActivity/

1.ManageEnroll_Set_Env_Var.ktr
2.ManageEnroll_Insert_Instances.ktr
3.ManageEnroll_Newborn_Flag.ktr
4.ManageEnroll_Subprogram.ktr
5.ManageEnroll_Fetch_Client_Address.ktr
6.ManageEnroll_Fetch_Fee_AA_due_date	
7.ManageEnroll_copy_to_interm_stage_tables.ktr
8.ManageEnroll_Fetch_Enrl_packets.ktr
9.ManageEnroll_Cancel_Dt_NO_LONGER_ELIG.ktr
10.ManageEnroll_Cancel_Dt_NEW_ENRL_PKT.ktr
11.ManageEnroll_Plan_Selection.ktr
12.ManageEnroll_SLCT_AUTO_PROC.ktr
13.ManageEnroll_Update_Enrollment_Status.ktr
14.ManageEnroll_Calc_Age.ktr
15.ManageEnroll_Apply_UPD_Rules_to_WIP.ktr
16.ManageEnroll_NULL_Columns_ONE_TIME.ktr
17.ManageEnroll_WIP_to_BPM_StageTable.ktr
18.ManageEnroll_set_MAX_Clnt_enl_stat_ID.ktr
19.ManageEnroll_set_MAX_Update_TS
20.ProcessManageEnroll_RUNALL.kjb
21.ManageEnroll_STATS_tables.ktr
22.ManageEnroll_STATS_All_STG_tables.ktr
23.ProcessManageEnroll_RUNALL_INTIAL_RUN.kjb
24.ManageEnroll_Fetch_First_FU_TX.ktr
25.ManageEnroll_Fetch_Second_FU_TX.ktr
