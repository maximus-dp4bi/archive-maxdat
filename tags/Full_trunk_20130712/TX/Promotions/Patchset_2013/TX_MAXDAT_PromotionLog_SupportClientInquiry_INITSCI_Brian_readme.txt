PROJECT_NAME -> MAXDAT - TXEB Support Client Inquiry
RELEASE_NUMBER -> N/A

ENVIRONMENT -> TXEBMXDA and APT server

DEPLOYMENT START_TIME_DATE ->
DEPLOYMENT COMPLETE_BY_TIME ->
CONTACT_NAME: Brian Thai
CONTACT_NUMBER: (210.722.3895)
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

2. - Stop jobs on TXMAXDAT:
execute PROCESS_BPM_QUEUE_JOB_CONTROL.SHUTDOWN_JOBS;


3. DO_TXEB_SCI_INIT_MAXDAT_BRIAN_1.zip patchset
Download the following files and run them in TXMAXDAT in the same order as below.

CORP_ETL_CLIENT_INQUIRY_DDL.sql
CORP_ETL_CLIENT_INQUIRY_WIP_DDL.sql
CORP_ETL_CLIENT_INQUIRY_OLTP_DDL.sql
CORP_ETL_CLIENT_INQUIRY_DTL_DDL.sql
CORP_ETL_CLIENT_INQUIRY_DTL_WIP_DDL.sql
CORP_ETL_CLIENT_INQUIRY_DTL_OLTP_DDL.sql
CORP_ETL_CLIENT_INQUIRY_EVENT_DDL.sql
CORP_ETL_CLIENT_INQUIRY_EVENT_WIP_DDL.sql
CORP_ETL_CLIENT_INQUIRY_EVENT_OLTP_DDL.sql
svn://rcmxapp1d.maximus.com/maxdat/BPM/TXEB/SupportClientInquiry/createdb/SemanticModel_Support_Client_Inquiry.sql


4. DB_TXEB_SCI_INIT_MAXDAT_BRIAN_1.zip patchset
Download the following files and run them in TXMAXDAT in the same order as below.

CLIENT_INQUIRY_pkg.sql
BPM_EVENT_PROJECT_pkg_body.sql
BPM_SEMANTIC_PROJECT_pkg_body.sql
TRG_CORP_ETL_CLIENT_INQUIRY.sql
TRG_AI_CORP_ETL_CLIENT_INQUIRY_Q.sql
TRG_AU_CORP_ETL_CLIENT_INQUIRY_Q.sql


5. DG_TXEB_SCI_INIT_MAXDAT_BRIAN_1.zip patchset
Download the following files and run them in TXMAXDAT in the same order as below.

DG_CORP_ETL_CLIENT_INQUIRY.sql


6. DS_TXEB_SCI_INIT_MAXDAT_BRIAN_1.zip patchset
Download the following files and run them in TXMAXDAT in the same order as below.

INSERT_CORP_ETL_CONTROL.sql
INSERT_CORP_SCI_ETL_CTYPES_LKUP.sql
INSERT_CORP_SCI_ETL_CACTIONS_LKUP.sql
INSERT_CORP_SCI_ETL_MACTIONS_LKUP.sql
populate_BPM_EVENT_MASTER.sql
populate_BPM_ATTRIBUTE_LKUP.sql
populate_BPM_ATTRIBUTE.sql
populate_BPM_ATTRIBUTE_STAGING_TABLE.sql

7. Create  Directory on App Server
Create directory for kettle scripts as follows:
MAXDAT_ETL_PATH/SupportClientInquiry


8. AS_TXEB_SCI_INIT_MAXDAT_BRIAN_1.zip patchset
Deploy Kettle files
TO: MAXDAT_ETL_PATH/SupportClientInquiry

ClientInquiry_Child_Calc_Parent_Attr.kjb
ClientInquiry_Child_Insert_INS1_20.ktr
ClientInquiry_Child_Insert_INS1_30.ktr
ClientInquiry_Child_Inserts.kjb
ClientInquiry_Child_RUNALL.kjb
ClientInquiry_Child_Update_BPM.ktr
ClientInquiry_Child_Update_Contact.ktr
ClientInquiry_Child_Update_Participant_Status.ktr
ClientInquiry_Child_Update_Translation_Req.ktr
ClientInquiry_Child_Update_UPD1_20.ktr
ClientInquiry_Child_Update_UPD1_30.ktr
ClientInquiry_Child_Update_UPD1_35.ktr
ClientInquiry_Child_Update_UPD1_40.ktr
ClientInquiry_Child_Update_UPD2_10.ktr
ClientInquiry_Child_Update_UPD2_20.ktr
ClientInquiry_Child_Updates.kjb
ClientInquiry_Main_Get_Active_Contacts.ktr
ClientInquiry_Main_Insert_Rules.ktr
ClientInquiry_Main_RUNALL.kjb
ClientInquiry_Main_Set_Env_Variables.ktr
ClientInquiry_Main_Update_BPM.ktr
ClientInquiry_Main_Update_Rules.kjb
ClientInquiry_Main_Update_UPD1_10.ktr
ClientInquiry_Main_Update_UPD1_40.ktr
ClientInquiry_Main_Update_Variables.ktr

9. Deploy UNIX Script
Copy files from AS_TXEB_SCI_INIT_MAXDAT_BRIAN_1.zip patchset
TO: MAXDAT_ETL_PATH
tx_run_bpm.sh

10. Convert Unix Script from Dos to Unix
Run dos2unix -k -o tx_run_bpm.sh

11. Start jobs on TXMAXDAT:
  CLIENT_INQUIRY.CREATE_CALC_DCICUR_JOB;
  PROCESS_BPM_QUEUE_JOB_CONTROL.CREATE_CONTROL_JOB;

12.Turn on tx_run_bpm.sh cron job
Note: initial run may take more than a couple of hours

