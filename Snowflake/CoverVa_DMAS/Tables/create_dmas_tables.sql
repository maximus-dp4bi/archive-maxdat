CREATE OR REPLACE sequence coverva_dmas.seq_file_id;
CREATE OR REPLACE sequence coverva_dmas.seq_errlog_id;
CREATE OR REPLACE sequence coverva_dmas.seq_dmas_application_id;
CREATE OR REPLACE sequence coverva_dmas.seq_dmas_current_app_id;
CREATE OR REPLACE sequence coverva_dmas.seq_dmas_excluded_appid;

CREATE OR REPLACE sequence coverva_dmas.seq_cviu_data_id;
create or replace sequence coverva_dmas.seq_cpu_incarcerated_id;
create or replace sequence coverva_dmas.seq_cm043_data_id;
create or replace sequence coverva_dmas.seq_cm044_data_id;
create or replace sequence coverva_dmas.seq_cpu_data_id;
create or replace sequence coverva_dmas.seq_ppit_data_id;
create or replace sequence coverva_dmas.seq_appmetric_data_id;
create or replace sequence coverva_dmas.seq_appmetric_pw_data_id;
create or replace sequence coverva_dmas.seq_app_override_id;

CREATE TABLE coverva_dmas.dmas_file_log(
    File_Id NUMBER DEFAULT coverva_dmas.seq_file_id.nextval,
    Filename_Prefix VARCHAR,
    Filename VARCHAR, 
    Row_Count NUMBER, 
    File_Date TIMESTAMP_NTZ, 
    Load_Date TIMESTAMP_NTZ DEFAULT current_timestamp(),
    Load_Status VARCHAR,
    Cdc_Processed VARCHAR,
    cdc_processed_date TIMESTAMP_NTZ);

ALTER TABLE coverva_dmas.dmas_file_log ADD PRIMARY KEY(File_Id);

CREATE TABLE coverva_dmas.dmas_file_error_log(
    Error_Log_Id NUMBER DEFAULT coverva_dmas.seq_errlog_id.nextval,
    File_Id NUMBER,
    Filename VARCHAR, 
    Error_Log_Date TIMESTAMP_NTZ DEFAULT current_date(),
    Error_Message VARCHAR);

ALTER TABLE coverva_dmas.dmas_file_error_log ADD PRIMARY KEY(Error_Log_Id);    

CREATE TABLE COVERVA_DMAS.APP_METRIC_FULL_LOAD(
       appmetric_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_appmetric_data_id.nextval,
       Tracking_Number VARCHAR NOT NULL,
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

alter table COVERVA_DMAS.APP_METRIC_FULL_LOAD add primary key (appmetric_data_id);

CREATE TABLE COVERVA_DMAS.APP_METRIC_PW_FULL_LOAD(
       appmetric_pw_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_appmetric_pw_data_id.nextval,
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
       
alter table COVERVA_DMAS.APP_METRIC_PW_FULL_LOAD add primary key (appmetric_pw_data_id);

CREATE TABLE COVERVA_DMAS.CPU_DATA_FULL_LOAD(
       cpu_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_cpu_data_id.nextval,
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
       Filename VARCHAR NULL,
       RunDate TIMESTAMP_NTZ NULL,
       TrnFerDate TIMESTAMP_NTZ NULL);

alter table COVERVA_DMAS.CPU_DATA_FULL_LOAD add primary key (cpu_data_id);

CREATE TABLE COVERVA_DMAS.PPIT_DATA_FULL_LOAD(
      ppit_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_ppit_data_id.nextval,
      Tracking_Number VARCHAR NULL,
      Case_Number VARCHAR NULL,
      Applicant VARCHAR NULL,
      App_Received_Date TIMESTAMP_NTZ NULL,
      Worker_LDSS VARCHAR NULL,
      Locality VARCHAR NULL,
      Program VARCHAR NULL,
      Delay VARCHAR NULL,
      Number_of_Days_Pending NUMBER,
      Worker_ID VARCHAR NULL,
      Filename VARCHAR NULL,
      interview_held_date VARCHAR,
      worker_name VARCHAR,
      stage VARCHAR,
      application_source VARCHAR,
      vcl_due_date DATE,
      num_days_app_held_before_transfer NUMBER,
      transfer_app_entity VARCHAR,
      indicator VARCHAR,
      minimal_information VARCHAR,
      extend_pend_performed VARCHAR,
      expedited_snap VARCHAR,
      resource_assessment_only VARCHAR,
      snap_expedited_ppv_application VARCHAR,
      snap_expedited_ppv_case VARCHAR,
      ppv_overdue_non_expedited VARCHAR);

alter table COVERVA_DMAS.PPIT_DATA_FULL_LOAD add primary key (ppit_data_id);

CREATE TABLE COVERVA_DMAS.MMS_LDAP_FULL_LOAD(
      Last_Name VARCHAR NULL,
      First_Name VARCHAR NULL,
      LDAP VARCHAR NULL,      
      Filename VARCHAR NULL);

alter table COVERVA_DMAS.MMS_LDAP_FULL_LOAD add primary key (LDAP,Filename);

CREATE TABLE COVERVA_DMAS.CPU_INCARCERATED_FULL_LOAD(
      cpu_incarcerated_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_cpu_incarcerated_id.nextval,
      Date_Received TIMESTAMP_NTZ NULL,
      Tracking_Number VARCHAR NULL,
      Switch  VARCHAR NULL,
      Source  VARCHAR NULL,
      Applicant_Name VARCHAR NULL,
      Processing_Unit VARCHAR NULL,
      Program VARCHAR NULL,      
      Assigned_To VARCHAR NULL,
      Locality VARCHAR NULL,
      Processing_Status VARCHAR NULL,
      Filename VARCHAR NULL);

alter table COVERVA_DMAS.CPU_INCARCERATED_FULL_LOAD add primary key (cpu_incarcerated_id);

CREATE TABLE COVERVA_DMAS.CVIU_DATA_FULL_LOAD(
      cviu_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_cviu_data_id.nextval,
      Date_Received TIMESTAMP_NTZ NULL,
      Tracking_Number VARCHAR NULL,
      Switch  VARCHAR NULL,
      Source  VARCHAR NULL,
      Applicant_Name VARCHAR NULL,
      Processing_Unit VARCHAR NULL,
      Program VARCHAR NULL,      
      Assigned_To VARCHAR NULL,
      Locality VARCHAR NULL,
      Processing_Status VARCHAR NULL,
      Filename VARCHAR NULL);

alter table COVERVA_DMAS.CVIU_DATA_FULL_LOAD add primary key (cviu_data_id);

CREATE TABLE COVERVA_DMAS.CM044_DATA_FULL_LOAD(
      cm044_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_cm044_data_id.nextval,
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

alter table COVERVA_DMAS.CM044_DATA_FULL_LOAD add primary key (cm044_data_id);

CREATE TABLE COVERVA_DMAS.APPLICATION_OVERRIDE_FULL_LOAD(
      app_override_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_app_override_id.nextval,
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
      Recent_Submission_Date TIMESTAMP_NTZ NULL,
      Submitter VARCHAR NULL,
      Filename VARCHAR NULL);

alter table COVERVA_DMAS.APPLICATION_OVERRIDE_FULL_LOAD add primary key (app_override_id);

CREATE TABLE coverva_dmas.DMAS_Application(
DMAS_Application_ID NUMBER NOT NULL DEFAULT coverva_dmas.seq_dmas_application_id.nextval,
Tracking_Number VARCHAR NOT NULL,
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
Override_Value_Indicator VARCHAR NULL,
FP_Create_Dt TIMESTAMP_NTZ NULL, 
FP_Update_Dt TIMESTAMP_NTZ NULL,
File_ID VARCHAR NULL,
In_CP_Indicator VARCHAR NULL,
Migrated_App_Indicator VARCHAR NULL,
Initial_Review_DT_Null_Reason VARCHAR NULL,
Last_Employee_Null_Reason VARCHAR NULL,
End_Date_Null_Reason VARCHAR NULL,
VCL_Due_Date TIMESTAMP_NTZ NULL,
Intake_Date TIMESTAMP_NTZ NULL,
Complete_Date TIMESTAMP_NTZ NULL,
File_Inventory_Date TIMESTAMP_NTZ NULL,
maximus_source_date TIMESTAMP_NTZ);

--alter table COVERVA_DMAS.DMAS_Application add primary key (Application_ID,File_Inventory_Date);
alter table COVERVA_DMAS.DMAS_Application add primary key (DMAS_Application_ID);

CREATE TABLE coverva_dmas.DMAS_Excluded_Application(
DMAS_Excluded_Application_ID NUMBER NOT NULL DEFAULT coverva_dmas.seq_dmas_excluded_appid.nextval,
Application_ID VARCHAR NOT NULL,
Ignore_Application_Reason VARCHAR NULL,
File_ID VARCHAR NULL,
File_Inventory_Date TIMESTAMP_NTZ NULL,
FP_Create_Dt TIMESTAMP_NTZ NULL, 
FP_Update_Dt TIMESTAMP_NTZ NULL
);

--alter table COVERVA_DMAS.DMAS_Excluded_Application add primary key (Application_ID,File_Inventory_Date);
alter table COVERVA_DMAS.DMAS_Excluded_Application add primary key (DMAS_Excluded_Application_ID);

CREATE TABLE coverva_dmas.dmas_file_load_lkup(
    Filename_Prefix VARCHAR,
    Full_Load_Table_Name VARCHAR, 
    Full_Load_Table_Schema VARCHAR,
    Insert_Fields VARCHAR, 
    Select_Fields VARCHAR,
    Where_Clause VARCHAR,
    Load_File VARCHAR,
    Use_In_Inventory VARCHAR,
    with_timestamp VARCHAR,
    file_day_received VARCHAR);

ALTER TABLE coverva_dmas.dmas_file_load_lkup ADD PRIMARY KEY(Filename_Prefix);    

CREATE TABLE coverva_dmas.dmas_config_control(
  config_name VARCHAR NOT NULL
  ,config_value VARCHAR
  ,config_value_type VARCHAR
  ,create_dt TIMESTAMP_NTZ
  ,update_dt TIMESTAMP_NTZ);

ALTER TABLE coverva_dmas.dmas_config_control ADD PRIMARY KEY (config_name);

CREATE TABLE COVERVA_DMAS.CM043_DATA_FULL_LOAD(
      cm043_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_cm043_data_id.nextval ,
      Tracking_Number VARCHAR NOT NULL,      
      Source  VARCHAR NULL,
      Name  VARCHAR NULL,
      DOB TIMESTAMP_NTZ NULL,
      SSN VARCHAR NULL,
      Address VARCHAR NULL,
      Locality VARCHAR NULL,      
      Date_Received TIMESTAMP_NTZ NULL,
      processing_status VARCHAR NULL,
      Filename VARCHAR NULL);

alter table COVERVA_DMAS.CM043_DATA_FULL_LOAD add primary key (cm043_data_id);

CREATE TABLE coverva_dmas.dmas_review_threshold_lkup (processing_unit VARCHAR NOT NULL
,application_type VARCHAR NOT NULL
,review_due_days NUMBER
,processed_due_days NUMBER);

ALTER TABLE coverva_dmas.dmas_review_threshold_lkup ADD PRIMARY KEY (processing_unit,application_type);
    
DELETE FROM coverva_dmas.dmas_file_Load_lkup;

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('CPUREPORT','CPU_DATA_FULL_LOAD','COVERVA_DMAS','App_Received_Date,Tracking_Number,Preg_Switch,Doc_App_Switch,Application_Source,Cname,Processing_Unit,Assigned_To,Locality,Status,Filename'
      ,'TO_TIMESTAMP(regexp_replace(apprecvdate,''[^A-Za-z0-9 -:/*]'',''''),''DD-MON-YY HH24:MI:SS'') rcvd_date,REGEXP_REPLACE(trackingnum,''[^A-Za-z0-9]'',''''),preg_switch,doc_app_switch,source,cname,prcoessingunit,assigned_to,locality,status,filename'
      ,'WHERE 1=1','Y','Y','Y');                
 
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('APPMETRIC_PW','APP_METRIC_PW_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Locality,Application_Received_Date,Worker,Stage,Range,Application_Source,Pending_due_to_VCL,VCL_Due_Date,Applicant_Last_Name,Applicant_First_Name,Filename'
       ,'REGEXP_REPLACE(application_number,''[^A-Za-z0-9]'',''''),locality,CAST(regexp_replace(application_received_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS application_received_date,worker,stage,range,application_source ,pending_due_to_vcl ,CAST(regexp_replace(vcl_due_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS vcl_due_date,applicant_last_name,applicant_first_name,filename'
       ,'WHERE 1=1','Y','Y','Y');              
       
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('APPMETRIC','APP_METRIC_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Locality,App_Received_Date,FFM_Transfer_Date,FFM_Application_Type,Case_Number,Application_Status,Application_Source,Worker_ID,Worker_Name,Stage,Range,Pending_due_to_VCL,VCL_Due_Date,Applicant_Last_Name,Applicant_First_Name,Disability_Verification_Pending,Application_ABD_Indicator,Case_ABD_Indicator,ABD,Application_LTC_Indicator,Case_LTC_Indicator,LTC,CPU_Assigned,Filename'
       ,'REGEXP_REPLACE(app_number,''[^A-Za-z0-9]'',''''),locality,CAST(regexp_replace(app_received_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS application_received_date,ffm_transfer_date,ffm_application_type,case_number,application_status,application_source,worker_id,worker_name,stage,range,pending_due_to_vcl,CAST(regexp_replace(vcl_due_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS vcl_due_date,applicant_last_name,applicant_first_name,disability_verification_pending,application_abd_indicator,case_abd_indicator,abd,application_ltc_indicator,case_ltc_indicator,ltc,cpu_assigned,filename'
      ,'WHERE 1=1','Y','Y','Y');
       
INSERT INTO coverva_dmas.dmas_filINSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,file_day_received)
VALUES('PPIT','PPIT_DATA_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Case_Number,Applicant,App_Received_Date,Worker_LDSS,Locality,Program,Delay,Number_of_Days_Pending,Worker_ID,Filename,interview_held_date,worker_name,stage,application_source,vcl_due_date,num_days_app_held_before_transfer,transfer_app_entity,indicator,minimal_information,extend_pend_performed,expedited_snap,resource_assessment_only,snap_expedited_ppv_application,snap_expedited_ppv_case,ppv_overdue_non_expedited'
       ,'REGEXP_REPLACE(application_,''[^A-Za-z0-9]'',''''),case_,applicant,CAST(regexp_replace(application_receivedscreening_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS application_received_date,worker_processing_unit,locality,programs,delay,no_of_days_pending,worker_id,filename,interview_held_date,worker_name,stage,application_source,CAST(regexp_replace(vcl_due_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS vcl_due_date,_of_days_app_held_before_transfer,entity_that_transferred_app,indicator,minimal_information,extend_pend_performed,expedited_snap,resource_assessment_only,snap_expedited_ppv_application,snap_expedited_ppv_case,ppv_overdue__nonexpedited'
       ,'WHERE 1=1','Y','Y','Y','SAME_DAY');
       
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('MMS_LDAP','MMS_LDAP_FULL_LOAD','COVERVA_DMAS','Last_Name,First_Name,LDAP,Filename' ,'last_name,first_name,LDAP,filename','WHERE 1=1','Y','N','Y');

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('CPU_I_INVENTORY','CPU_INCARCERATED_FULL_LOAD','COVERVA_DMAS','Date_Received,Tracking_Number,Switch,Source,Applicant_Name,Processing_Unit,Program,Assigned_To,Locality,Processing_Status,Filename' 
  ,'CAST(regexp_replace(date_received,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS date_received,TRIM(CASE WHEN LENGTH(t_number) > 10 THEN SUBSTR(REGEXP_REPLACE(t_number,''[^A-Za-z0-9]'',''''),1,REGEXP_INSTR(t_number,''[^A-Za-z0-9]'')-1) ELSE REGEXP_REPLACE(t_number,''[^A-Za-z0-9]'','''') END) t_number,TRIM(COALESCE(CASE WHEN LENGTH(t_number) > 10  THEN SUBSTR(t_number,REGEXP_INSTR(t_number,''[^A-Za-z0-9]'')) ELSE NULL END,switch)) switch,source,name,processing_unit,program,assigned_to,locality,processing_status,filename'
  ,'WHERE 1=1','Y','Y','Y');

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('CVIU_INVENTORY','CVIU_DATA_FULL_LOAD','COVERVA_DMAS','Date_Received,Tracking_Number,Switch,Source,Applicant_Name,Processing_Unit,Program,Assigned_To,Locality,Processing_Status,Filename' 
  ,'CAST(regexp_replace(date_received,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS date_received,TRIM(CASE WHEN LENGTH(t_number) > 10 THEN SUBSTR(REGEXP_REPLACE(t_number,''[^A-Za-z0-9]'',''''),1,REGEXP_INSTR(t_number,''[^A-Za-z0-9]'')-1) ELSE REGEXP_REPLACE(t_number,''[^A-Za-z0-9]'','''') END) t_number,TRIM(COALESCE(CASE WHEN LENGTH(t_number) > 10  THEN SUBSTR(t_number,REGEXP_INSTR(t_number,''[^A-Za-z0-9]'')) ELSE NULL END,switch)) switch,source,name,processing_unit,program,assigned_to,locality,processing_status,filename'
  ,'WHERE 1=1','Y','Y','Y');      
  
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('CM_044','CM044_DATA_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Case_Number,Source,Locality,Status,Application_Date,Authorized_Date,Potential_Pregnancy,Number_of_Days,Authorized_Worker_ID,Authorized_Office,Processing_Unit,Filename' 
  ,'REGEXP_REPLACE(tracking_,''[^A-Za-z0-9]'',''''),case_,source,locality,status,CAST(regexp_replace(application_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS application_date, CAST(regexp_replace(authorized_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS authorized_date,potential_pregnancy,_of_days,authorized_worker_id,authorized_office,processing_unit,filename'
  ,'WHERE 1=1','Y','Y','Y');

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('RUNNING_MASTER_OVERRIDE','APPLICATION_OVERRIDE_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Source,App_Received_Date,Processing_Unit,Type,In_CP,Current_State,Initial_Review_Complete_Date,End_Date,Last_Employee,Recent_Submission_date,Submitter,Filename' 
  ,'REGEXP_REPLACE(t,''[^A-Za-z0-9]'',''''),source,CASE WHEN LENGTH(app_received_date) > 8 THEN TRY_TO_DATE(app_received_date,''mm/dd/yyyy'') ELSE TRY_TO_DATE(app_received_date,''mm/dd/yy'') END AS app_received_date,unit,type,in_cp,current_state, CASE WHEN LENGTH(initial_review_complete_date) > 8 THEN TRY_TO_DATE(initial_review_complete_date,''mm/dd/yyyy'') ELSE TRY_TO_DATE(initial_review_complete_date,''mm/dd/yy'') END AS initrvwdt,CASE WHEN LENGTH(end_date) > 8 THEN TRY_TO_DATE(end_date,''mm/dd/yyyy'') ELSE TRY_TO_DATE(end_date,''mm/dd/yy'') END AS end_date,last_employee,CASE WHEN LENGTH(recent_submission_date) > 8 THEN TRY_TO_DATE(recent_submission_date,''mm/dd/yyyy'') ELSE TRY_TO_DATE(recent_submission_date,''mm/dd/yy'') END AS recent_submission_date,submitter,filename'
  ,'WHERE t IS NOT NULL AND t NOT LIKE ''Paper%''','Y','Y','Y');

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('RUNNING_CPU','CPU_DATA_FULL_LOAD','COVERVA_DMAS','App_Received_Date,Tracking_Number,Preg_Switch,Doc_App_Switch,Application_Source,Cname,Processing_Unit,Assigned_To,Locality,Status,Filename,Disab_Switch,RunDate'
      ,'TO_TIMESTAMP(regexp_replace(apprecvdate,''[^A-Za-z0-9 -:/*]'',''''),''DD-MON-YY HH24:MI:SS'') rcvd_date,trackingnum,preg_switch,doc_app_switch,source,cname,prcoessingunit,assigned_to,locality,status,filename,disab_switch,run'
      ,'WHERE 1=1','Y','Y','Y'); 
      
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('CPUREPORT_YESTERDAY','CPU_DATA_FULL_LOAD','COVERVA_DMAS','App_Received_Date,Tracking_Number,Preg_Switch,Doc_App_Switch,Application_Source,Cname,Processing_Unit,Assigned_To,Locality,Status,Filename,Disab_Switch'
      ,'TO_TIMESTAMP(regexp_replace(apprecvdate,''[^A-Za-z0-9 -:/*]'',''''),''DD-MON-YY HH24:MI:SS'') rcvd_date,REGEXP_REPLACE(trackingnum,''[^A-Za-z0-9]'',''''),preg_switch,doc_app_switch,source,cname,prcoessingunit,assigned_to,locality,status,filename,disab_switch'
      ,'WHERE 1=1','Y','Y','Y'); 

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('CPUREPORT_TRNS_YESTERDAY','CPU_DATA_FULL_LOAD','COVERVA_DMAS','App_Received_Date,Tracking_Number,Preg_Switch,Doc_App_Switch,Application_Source,Cname,Processing_Unit,Assigned_To,Locality,Status,Filename,Disab_Switch,TrnFerDate'
      ,'TO_TIMESTAMP(replace(regexp_replace(apprecvdate,'[^A-Za-z0-9 -:/*]',''),'.0',''),'YYYY-MM-DD HH24:MI:SS') rcvd_date,REGEXP_REPLACE(trknum,'[^A-Za-z0-9]',''),preg_switch,doc_app_switch,source,cname,prcoessingunit,assigned_to,locality,status,filename,disab_switch,trnferdt'
      ,'WHERE 1=1','Y','Y','Y'); 

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('CM_043','CM043_DATA_FULL_LOAD','COVERVA_DMAS','source,name,address,locality,filename,date_received,processing_status,tracking_number'
      ,'source,name,address,locality,filename,CASE WHEN LENGTH(date_received) > 8 THEN TRY_TO_DATE(date_received,''mm/dd/yyyy'') ELSE TRY_TO_DATE(date_received,''mm/dd/yy'') END AS date_received,processing_status,REGEXP_REPLACE(tracking_,''[^A-Za-z0-9]'','''')'
      ,'WHERE 1=1','Y','Y','Y');       
                  
      
DELETE FROM coverva_dmas.dmas_config_control;

INSERT INTO coverva_dmas.dmas_config_control(config_name,config_value,config_value_type,create_dt,update_dt)
VALUES('INVENTORY_FILE_DATE','06/01/2021','D',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_config_control(config_name,config_value,config_value_type,create_dt,update_dt)
VALUES('INVENTORY_NUMBER_OF_FILES','8','N',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_config_control(config_name,config_value,config_value_type,create_dt,update_dt)
VALUES('INVENTORY_DAYS_TO_PROCESS','2','N',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_config_control(config_name,config_value,config_value_type,create_dt,update_dt)
VALUES('INVENTORY_CDC_TIME','18:30:00','V',current_timestamp(),current_timestamp());

INSERT INTO coverva_dmas.dmas_config_control(config_name,config_value,config_value_type,create_dt,update_dt)
VALUES('INVENTORY_CDC_START_TIME','01:30:00','D',current_timestamp(),current_timestamp());

DELETE FROM coverva_dmas.dmas_review_threshold_lkup;

INSERT INTO coverva_dmas.dmas_review_threshold_lkup(processing_unit,application_type,review_due_days,processed_due_days) VALUES('CPU','non-PW',8,45);
INSERT INTO coverva_dmas.dmas_review_threshold_lkup(processing_unit,application_type,review_due_days) VALUES('CPU','PW',5);
INSERT INTO coverva_dmas.dmas_review_threshold_lkup(processing_unit,application_type,review_due_days) VALUES('CVIU','non-PW',5);
INSERT INTO coverva_dmas.dmas_review_threshold_lkup(processing_unit,application_type,review_due_days) VALUES('CVIU','PW',5);

COMMIT;

grant select on all tables in schema mars_dp4bi_prod.coverva_dmas to role MARS_DP4BI_PROD_READ;