CREATE OR REPLACE sequence coverva_dmas.seq_file_id;
CREATE OR REPLACE sequence coverva_dmas.seq_errlog_id;

CREATE TABLE coverva_dmas.dmas_file_log(
    File_Id NUMBER DEFAULT coverva_dmas.seq_file_id.nextval,
    Filename_Prefix VARCHAR,
    Filename VARCHAR, 
    Row_Count NUMBER, 
    File_Date TIMESTAMP_NTZ, 
    Load_Date TIMESTAMP_NTZ DEFAULT current_timestamp(),
    Load_Status VARCHAR);

ALTER TABLE coverva_dmas.dmas_file_log ADD PRIMARY KEY(File_Id);

CREATE TABLE coverva_dmas.dmas_file_error_log(
    Error_Log_Id NUMBER DEFAULT coverva_dmas.seq_errlog_id.nextval,
    File_Id NUMBER,
    Filename VARCHAR, 
    Error_Log_Date TIMESTAMP_NTZ DEFAULT current_date(),
    Error_Message VARCHAR);

ALTER TABLE coverva_dmas.dmas_file_error_log ADD PRIMARY KEY(Error_Log_Id);    

CREATE TABLE COVERVA_DMAS.APP_METRIC_FULL_LOAD(
       App_Number VARCHAR NOT NULL,
       Locality VARCHAR NULL,
       App_Received_Date TIMESTAMP_NTZ NULL,
       FFM_Transfer_Date TIMESTAMP_NTZ NULL,
       FFM_Application_Type VARCHAR NULL,
       Case_Number NUMBER NULL,
       Application_Status VARCHAR NULL,
       Application_Source VARCHAR NULL,
       Worker_ID VARCHAR NULL,
       Worker_Name VARCHAR NULL,
       Stage VARCHAR NULL,
       Range VARCHAR NULL,
       Pending_due_to_VCL VARCHAR NULL,
       VCL_Due_Date TIMESTAMP_NTZ NULL,
       Applicant_Last_Name VARCHAR NULL,
       Applicant_First_Name VARCHAR NULL,
       Disability_Verification_Pending VARCHAR NULL,
       Application_ABD_Indicator VARCHAR NULL,
       Case_ABD_Indicator VARCHAR NULL,
       ABD VARCHAR NULL,
       Application_LTC_Indicator VARCHAR NULL,
       Case_LTC_Indicator VARCHAR NULL,
       LTC VARCHAR NULL,
       CPU_Assigned VARCHAR NULL,
       Filename VARCHAR NULL);

alter table COVERVA_DMAS.APP_METRIC_FULL_LOAD add primary key (App_Number,Filename);

CREATE TABLE COVERVA_DMAS.APP_METRIC_PW_FULL_LOAD(
       Application_Number VARCHAR NOT NULL,
       Locality VARCHAR NULL,
       Application_Received_Date TIMESTAMP_NTZ NULL,
       Worker VARCHAR NULL,
       Stage VARCHAR NULL,
       Range VARCHAR NULL,
       Application_Source VARCHAR NULL,
       Pending_due_to_VCL VARCHAR NULL,
       VCL_Due_Date TIMESTAMP_NTZ NULL,
       Applicant_Last_Name VARCHAR NULL,
       Applicant_First_Name VARCHAR NULL,
       Filename VARCHAR NULL);
       
alter table COVERVA_DMAS.APP_METRIC_PW_FULL_LOAD add primary key (Application_Number,Filename);

CREATE TABLE COVERVA_DMAS.CPU_DATA_FULL_LOAD(
       App_Received_Date TIMESTAMP_NTZ NULL,
       Tracking_Number VARCHAR NOT NULL,
       Preg_Switch VARCHAR,
       Disab_Switch VARCHAR,
       Doc_App_Switch VARCHAR,
       Application_Source VARCHAR,
       Cname VARCHAR,
       Processing_Unit VARCHAR,
       Assigned_To VARCHAR,
       Locality VARCHAR NULL,
       Status VARCHAR NULL,
       Filename VARCHAR NULL);

alter table COVERVA_DMAS.CPU_DATA_FULL_LOAD add primary key (Tracking_Number,Filename);

CREATE TABLE COVERVA_DMAS.PPIT_DATA_FULL_LOAD(
      T_Number VARCHAR NULL,
      Case_Number VARCHAR NULL,
      Applicant VARCHAR NULL,
      App_Received_Date TIMESTAMP_NTZ NULL,
      Worker_LDSS VARCHAR NULL,
      Locality VARCHAR NULL,
      Program VARCHAR NULL,
      Delay VARCHAR NULL,
      Number_of_Days_Pending NUMBER,
      Worker_ID VARCHAR NULL,
      Filename VARCHAR NULL);

alter table COVERVA_DMAS.PPIT_DATA_FULL_LOAD add primary key (T_Number,Filename);

CREATE TABLE COVERVA_DMAS.MMS_LDAP_FULL_LOAD(
      Last_Name VARCHAR NULL,
      First_Name VARCHAR NULL,
      LDAP VARCHAR NULL,      
      Filename VARCHAR NULL);

alter table COVERVA_DMAS.MMS_LDAP_FULL_LOAD add primary key (LDAP,Filename);

CREATE TABLE COVERVA_DMAS.CPU_INCARCERATED_FULL_LOAD(
      Date_Received TIMESTAMP_NTZ NULL,
      T_Number VARCHAR NULL,
      Switch  VARCHAR NULL,
      Source  VARCHAR NULL,
      Applicant_Name VARCHAR NULL,
      Processing_Unit VARCHAR NULL,
      Program VARCHAR NULL,      
      Assigned_To VARCHAR NULL,
      Locality VARCHAR NULL,
      Processing_Status VARCHAR NULL,
      Filename VARCHAR NULL);

alter table COVERVA_DMAS.CPU_INCARCERATED_FULL_LOAD add primary key (T_Number,Filename);

CREATE TABLE COVERVA_DMAS.CVIU_DATA_FULL_LOAD(
      Date_Received TIMESTAMP_NTZ NULL,
      T_Number VARCHAR NULL,
      Switch  VARCHAR NULL,
      Source  VARCHAR NULL,
      Applicant_Name VARCHAR NULL,
      Processing_Unit VARCHAR NULL,
      Program VARCHAR NULL,      
      Assigned_To VARCHAR NULL,
      Locality VARCHAR NULL,
      Processing_Status VARCHAR NULL,
      Filename VARCHAR NULL);

alter table COVERVA_DMAS.CVIU_DATA_FULL_LOAD add primary key (T_Number,Filename);

CREATE TABLE COVERVA_DMAS.CM044_DATA_FULL_LOAD(
      Tracking_Number VARCHAR NOT NULL,
      Case_Number VARCHAR NULL,
      Source  VARCHAR NULL,
      Locality VARCHAR NULL,
      Status VARCHAR NULL,
      Application_Date TIMESTAMP_NTZ NULL,
      Authorized_Date TIMESTAMP_NTZ NULL,
      Potential_Pregnancy VARCHAR NULL,
      Number_of_Days NUMBER,
      Authorized_Worker_ID VARCHAR NULL,
      Authorized_Office VARCHAR NULL,
      Processing_Unit VARCHAR NULL,
      Filename VARCHAR NULL);

alter table COVERVA_DMAS.CM044_DATA_FULL_LOAD add primary key (Tracking_Number,Filename);

CREATE TABLE COVERVA_DMAS.APPLICATION_OVERRIDE_FULL_LOAD(
      Tracking_Number VARCHAR NOT NULL,      
      Source  VARCHAR NULL,
      App_Received_Date TIMESTAMP_NTZ NULL,
      Processing_Unit VARCHAR NULL,
      Type VARCHAR NULL,
      In_CP VARCHAR NULL,
      Current_State VARCHAR NULL,
      Initial_Review_Complete_Date TIMESTAMP_NTZ NULL,
      End_Date TIMESTAMP_NTZ NULL,
      Last_Employee VARCHAR NULL,      
      Filename VARCHAR NULL);

alter table COVERVA_DMAS.APPLICATION_OVERRIDE_FULL_LOAD add primary key (Tracking_Number,Filename);

CREATE TABLE COVERVA_DMAS.MIGRATED_APPLICATION_FULL_LOAD(
      Application_Number VARCHAR NOT NULL,      
      Source  VARCHAR NULL,      
      Filename VARCHAR NULL);

alter table COVERVA_DMAS.MIGRATED_APPLICATION_FULL_LOAD add primary key (Application_Number,Filename);

CREATE TABLE COVERVA_DMAS.MANUAL_CVIU_TRACKING(
      Completion_Time VARCHAR NULL,
      Comm_Form  VARCHAR NULL,
      Worker_Supervisor  VARCHAR NULL,
      Research_Sent_To_Supervisor  VARCHAR NULL,
      Filename  VARCHAR NULL,
      DMAS_Action_Needed  VARCHAR NULL,
      Business_Days  VARCHAR NULL,
      Status  VARCHAR NULL,
      Action_Age  VARCHAR NULL,
      Coverage_Correction_Needed  VARCHAR NULL,
      Pregnant_Woman_Application  VARCHAR NULL,
      Manual_VCL  VARCHAR NULL,
      NOA  VARCHAR NULL,
      Start_Time  VARCHAR NULL,
      Application_Number  VARCHAR NULL,
      Activity_Date  VARCHAR NULL,
      Email  VARCHAR NULL,
      EW  VARCHAR NULL,
      MWS_Date  VARCHAR NULL,
      Source  VARCHAR NULL,
      VCL  VARCHAR NULL,
      Sent_To_LDSS  VARCHAR NULL,
      Allocation  VARCHAR NULL,
      Case_Number  VARCHAR NULL);

alter table COVERVA_DMAS.MANUAL_CVIU_TRACKING add primary key (Application_Number,Activity_Date);

CREATE TABLE COVERVA_DMAS.MANUAL_CPU_TRACKING(Activity_Date VARCHAR NULL,
Comments VARCHAR NULL,
Approved VARCHAR NULL,
Known_Pair VARCHAR NULL,
VCL VARCHAR NULL,
Close_Sup VARCHAR NULL,
Filename VARCHAR NULL,
Sent_To_LDSS VARCHAR NULL,
Supervisor VARCHAR NULL,
Column1 VARCHAR NULL,
Denied VARCHAR NULL,
Business_Days VARCHAR NULL,
Close_W VARCHAR NULL,
EW VARCHAR NULL,
MWS_Date VARCHAR NULL,
Research_Sent_To_Supervisor VARCHAR NULL,
Source VARCHAR NULL,
Application_Number VARCHAR NULL,
Action_Age VARCHAR NULL,
Allocation VARCHAR NULL,
DMAS_Action_Needed VARCHAR NULL,
NOA VARCHAR NULL,
Timestamp_Ind VARCHAR NULL);

alter table COVERVA_DMAS.MANUAL_CPU_TRACKING add primary key (Application_Number,Activity_Date);

--table already created by streamsets load
alter table COVERVA_DMAS.COVERVA_HOLIDAYS add primary key (date);
alter table COVERVA_DMAS.CP_CHANNEL_TO_SOURCE_LKUP add primary key (source,cp_channel);
alter table COVERVA_DMAS.CP_TYPE_LKUP add primary key (type,cp_type);
alter table COVERVA_DMAS.CP_STATUS_LKUP add primary key (status,cp_status);

CREATE TABLE coverva_dmas.DMAS_Application(
Application_ID VARCHAR NOT NULL,
Source VARCHAR NULL,
App_Received_Date TIMESTAMP_NTZ NULL,
Processing_Unit VARCHAR NULL,
Application_Type VARCHAR NULL, 
Current_State VARCHAR NULL,
Initial_Review_Complete_Date TIMESTAMP_NTZ NULL,
Application_Processing_End_Date TIMESTAMP_NTZ NULL,
Last_Employee VARCHAR NULL,
Applicant_Name VARCHAR NULL,  
Case_Number VARCHAR NULL, 
Ignore_Application_Indicator VARCHAR NULL,
Ignore_Application_Reason VARCHAR NULL,
Override_Value_Indicator VARCHAR NULL,
File_Processing_State VARCHAR NULL,
FP_Create_Dt TIMESTAMP_NTZ NULL, 
FP_Update_Dt TIMESTAMP_NTZ NULL,
First_File_ID VARCHAR NULL,
In_CP_Indicator VARCHAR NULL,
Migrated_App_Indicator VARCHAR NULL,
Initial_Review_DT_Null_Reason VARCHAR NULL,
Last_Employee_Null_Reason VARCHAR NULL,
End_Date_Null_Reason VARCHAR NULL);

alter table COVERVA_DMAS.DMAS_Application add primary key (Application_ID);

CREATE TABLE coverva_dmas.dmas_file_load_lkup(
    Filename_Prefix VARCHAR,
    Full_Load_Table_Name VARCHAR, 
    Full_Load_Table_Schema VARCHAR,
    Insert_Fields VARCHAR, 
    Select_Fields VARCHAR,
    Where_Clause VARCHAR,
    Load_File VARCHAR);

ALTER TABLE coverva_dmas.dmas_file_load_lkup ADD PRIMARY KEY(Filename_Prefix);    
    
DELETE FROM coverva_dmas.dmas_file_Load_lkup;

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file)
VALUES('CPUREPORT','CPU_DATA_FULL_LOAD','COVERVA_DMAS','App_Received_Date,Tracking_Number,Preg_Switch,Doc_App_Switch,Application_Source,Cname,Processing_Unit,Assigned_To,Locality,Status,Filename'
      ,'TO_TIMESTAMP(regexp_replace(apprecvdate,''[^A-Za-z0-9 -:/*]'',''''),''DD-MON-YY HH24:MI:SS'') rcvd_date,trackingnum,preg_switch,doc_app_switch,source,cname,prcoessingunit,assigned_to,locality,status,filename'
      ,'WHERE 1=1','Y');                
 
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file)
VALUES('APPMETRIC_PW','APP_METRIC_PW_FULL_LOAD','COVERVA_DMAS','Application_Number,Locality,Application_Received_Date,Worker,Stage,Range,Application_Source,Pending_due_to_VCL,VCL_Due_Date,Applicant_Last_Name,Applicant_First_Name,Filename'
       ,'application_number,locality,CAST(regexp_replace(application_received_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS application_received_date,worker,stage,range,application_source ,pending_due_to_vcl ,CAST(regexp_replace(vcl_due_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS vcl_due_date,applicant_last_name,applicant_first_name,filename'
       ,'WHERE 1=1','Y');                
       
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file)
VALUES('APPMETRIC','APP_METRIC_FULL_LOAD','COVERVA_DMAS','App_Number,Locality,App_Received_Date,FFM_Transfer_Date,FFM_Application_Type,Case_Number,Application_Status,Application_Source,Worker_ID,Worker_Name,Stage,Range,Pending_due_to_VCL,VCL_Due_Date,Applicant_Last_Name,Applicant_First_Name,Disability_Verification_Pending,Application_ABD_Indicator,Case_ABD_Indicator,ABD,Application_LTC_Indicator,Case_LTC_Indicator,LTC,CPU_Assigned,Filename'
       ,'app_number,locality,CAST(regexp_replace(app_received_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS application_received_date,ffm_transfer_date,ffm_application_type,case_number,application_status,application_source,worker_id,worker_name,stage,range,pending_due_to_vcl,CAST(regexp_replace(vcl_due_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS vcl_due_date,applicant_last_name,applicant_first_name,disability_verification_pending,application_abd_indicator,case_abd_indicator,abd,application_ltc_indicator,case_ltc_indicator,ltc,cpu_assigned,filename'
      ,'WHERE 1=1','Y'); 
       
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file)
VALUES('PPIT','PPIT_DATA_FULL_LOAD','COVERVA_DMAS','T_Number,Case_Number,Applicant,App_Received_Date,Worker_LDSS,Locality,Program,Delay,Number_of_Days_Pending,Worker_ID,Filename'
       ,'t_number,case_,applicant,CAST(regexp_replace(app_received_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS application_received_date,worker_ldss,locality,program,delay,no_of_days_pending,worker_id,filename'
       ,'WHERE 1=1','Y'); 
       
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file)
VALUES('STAFF','MMS_LDAP_FULL_LOAD','COVERVA_DMAS','Last_Name,First_Name,LDAP,Filename' ,'last_name,first_name,LDAP,filename','WHERE 1=1','Y'); 

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file)
VALUES('CPU_I_INVENTORY','CPU_INCARCERATED_FULL_LOAD','COVERVA_DMAS','Date_Received,T_Number,Switch,Source,Applicant_Name,Processing_Unit,Program,Assigned_To,Locality,Processing_Status,Filename' 
  ,'CAST(regexp_replace(date_received,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS date_received,t_number,switch,source,name,processing_unit,program,assigned_to,locality,processing_status,filename','WHERE 1=1','Y'); 

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file)
VALUES('CVIU_INVENTORY','CVIU_DATA_FULL_LOAD','COVERVA_DMAS','Date_Received,T_Number,Switch,Source,Applicant_Name,Processing_Unit,Program,Assigned_To,Locality,Processing_Status,Filename' 
  ,'CAST(regexp_replace(date_received,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS date_received,t_number,switch,source,name,processing_unit,program,assigned_to,locality,processing_status,filename','WHERE 1=1','Y');          
  
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file)
VALUES('CM_044','CM044_DATA_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Case_Number,Source,Locality,Status,Application_Date,Authorized_Date,Potential_Pregnancy,Number_of_Days,Authorized_Worker_ID,Authorized_Office,Processing_Unit,Filename' 
  ,'tracking_,case_,source,locality,status,CAST(regexp_replace(application_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS application_date, CAST(regexp_replace(authorized_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS authorized_date,potential_pregnancy,_of_days,authorized_worker_id,authorized_office,processing_unit,filename'
  ,'WHERE 1=1','Y'); 

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file)
VALUES('RUNNING_MASTER_OVERRIDE','APPLICATION_OVERRIDE_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Source,App_Received_Date,Processing_Unit,Type,In_CP,Current_State,Initial_Review_Complete_Date,End_Date,Last_Employee,Recent_Submission_date,Submitter,Filename' 
  ,'t,source,CAST(regexp_replace(app_received_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS app_received_date,unit,type,in_cp,current_state,CAST(regexp_replace(initial_review_complete_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS initrvwdt,CAST(regexp_replace(end_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS end_date,last_employee,CAST(regexp_replace(recent_submission_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS recent_submission_date,submitter,filename'
  ,'WHERE 1=1','Y');    

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file)
VALUES('MIGRATEDAPPS','MIGRATED_APPLICATION_FULL_LOAD','COVERVA_DMAS','Application_Number,Source,Filename','Application_ID,Source,filename','WHERE 1=1','Y'); 

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file)
VALUES('RUNNING_MANUAL_CVIU_TRACKING','MANUAL_CVIU_TRACKING','COVERVA_DMAS','Completion_Time,Comm_Form,Worker_Supervisor,Research_Sent_To_Supervisor,Filename,DMAS_Action_Needed,Business_Days,Status,Action_Age,Coverage_Correction_Needed,Pregnant_Woman_Application,Manual_VCL,NOA,Start_Time,Application_Number,Activity_Date,Email,EW,MWS_Date,Source,VCL,Sent_To_LDSS,Allocation,Case_Number'
,'Completion_Time,Comm_Form_1yes_0no,My_Supervisor_Is,ResearchSent_To_Supervisor,Filename,Dmas_Action_Neededsent_To_Supervisor_1yes_0no,Business_Days,Status,Action_Age,Coverage_Correction_Needed_1yes_0no,Is_This_Application_For_A_Pregnant_Woman_1yes_0no,Manual_Vcl_1yes_0no,Noa_1yes_0no,Start_Time,T,Activity_Date,Email,Ew,Mws_Date,Source,Vcl_1yes_0no,Sent_To_Ldss_1yes_0no,Allocation,Case_Number'
,'WHERE NOT EXISTS(SELECT 1 FROM COVERVA_DMAS.manual_cviu_tracking ct WHERE coverva_dmas.running_manual_cviu_tracking.t = ct.application_number AND coverva_dmas.running_manual_cviu_tracking.activity_date = ct.activity_date)'
,'Y');                                

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file)
VALUES('RUNNING_MANUAL_CPU_TRACKING','MANUAL_CPU_TRACKING','COVERVA_DMAS','Activity_Date,Comments,Approved,Known_Pair,VCL,Close_Sup,Filename,Sent_To_LDSS,Supervisor,Column1,Denied,Business_Days,Close_W,EW,MWS_Date,Research_Sent_To_Supervisor,Source,Application_Number,Action_Age,Allocation,DMAS_Action_Needed,NOA,Timestamp_Ind'
,'Activity_Date,Comments,Approved,Known_Pair,Vcl,Close_Sup,Filename,Sent_To_Ldss,Supervisor,Column1,Denied,Business_Days,Close_W,Ew,Mws_Date,Researchsent_To_Supervisor,Source,T,Action_Age,Allocation,Dmas_Action_Neededsent_To_Supervisor,Noa,Timestamp'
,'WHERE NOT EXISTS(SELECT 1 FROM COVERVA_DMAS.manual_cpu_tracking ct WHERE coverva_dmas.running_manual_cpu_tracking.t = ct.application_number AND coverva_dmas.running_manual_cpu_tracking.activity_date = ct.activity_date)'
,'Y');                

COMMIT;
