alter session set current_schema = MAXDAT;

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('TN_Load_Processing_Timeliness_START','V','020000','Start Time for App Timeliness ETL to run',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('TN_Load_Processing_Timeliness_END','V','183000','End Time for App Timeliness ETL to run',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('TN_Load_App_Billable_Outcomes_START','V','020000','Start Time for App Timeliness ETL to run',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('TN_Load_App_Billable_Outcomes_END','V','180000','End Time for App Timeliness ETL to run',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('TN_Populate_MFD_Job_START','V','020000','Start Time for App Timeliness ETL to run',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('TN_Populate_MFD_Job_END','V','180000','End Time for App Timeliness ETL to run',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('TN_CIR_GetIncremental_Data_START','V','020000','Start Time for App Timeliness ETL to run',SYSDATE,SYSDATE);

Insert into CORP_ETL_CONTROL (NAME,VALUE_TYPE,VALUE,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('TN_CIR_GetIncremental_Data_END','V','180000','End Time for App Timeliness ETL to run',SYSDATE,SYSDATE);

commit;