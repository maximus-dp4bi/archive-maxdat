insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPDOCDATA_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_doc_data.create_ts from the previous run. create_ts of the most recent app_doc_data record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('APPDOCDATA_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the app_doc_data.update_ts from the previous run. update_ts of the most recent app_doc_data record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('DMSDOCUMENT_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the dms.documents.creation_date from the previous run. creation_date of the most recent documents record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('DMSDOCUMENT_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the dms.documents.last_update_date from the previous run. Last_update_date of the most recent documents record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('DMSBATCHES_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the dms.batches.creation_date from the previous run. creation_date of the most recent batches record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('DMSBATCHES_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the dms.batches.last_update_date from the previous run. Last_update_date of the most recent batches record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('DMSACTIVITY_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the dms.activities.creation_date from the previous run. creation_date of the most recent activities record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('DMSACTIVITY_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the dms.activities.last_update_date from the previous run. Last_update_date of the most recent activities record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('DMSACTIVITYDTL_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the dms.activity_details.creation_date from the previous run. creation_date of the most recent activity_details record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('DMSACTIVITYDTL_LAST_UPDATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the dms.activity_details.last_update_date from the previous run. Last_update_date of the most recent activity_details record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('KOFAXREPORTING_LAST_CREATE_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the kofax.maxdatreporting.BatchCreateDate from the previous run. Creation Date of the most recent maxdatreporting record from the previous run.',sysdate,sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('KOFAXREPORTING_LAST_EXPORT_DATE','D',to_char(TRUNC(SYSDATE-360),'yyyy/mm/dd hh24:mi:ss'),'This is the timestamp of the kofax.maxdatreporting.BatchExportDate from the previous run. Export Date of the most recent maxdatreporting record from the previous run.',sysdate,sysdate);

commit;