CREATE OR REPLACE sequence coverva_dmas.seq_cm_pt_data_id;

CREATE TABLE COVERVA_DMAS.CM_PROCESSING_TIME_FULL_LOAD(
      cm_pt_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_cm_pt_data_id.nextval,
      Tracking_Number VARCHAR NOT NULL,
      Case_Number VARCHAR,
      Source  VARCHAR,
      Locality VARCHAR,
      Status VARCHAR,
      Denial_Closure_Reason VARCHAR,
      Aid_Category VARCHAR,
      Application_Date TIMESTAMP_NTZ,
      Authorized_Date TIMESTAMP_NTZ,      
      Number_of_Days NUMBER,      
      Authorized_Worker_ID VARCHAR,
      MA_Pregnancy_Indicator VARCHAR,
      Processing_Unit VARCHAR,      
      Authorized_Office VARCHAR,
      Filename VARCHAR,
      Filename_Prefix VARCHAR);
      
ALTER TABLE COVERVA_DMAS.CM_PROCESSING_TIME_FULL_LOAD ADD PRIMARY KEY (cm_pt_data_id);  

DELETE FROM coverva_dmas.dmas_file_load_lkup
WHERE filename_prefix IN('CM_044','CM_045','CM_046');

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,use_in_v2_inventory,use_in_v3_inventory,file_day_received)
VALUES('CM_044','CM_PROCESSING_TIME_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Case_Number,Source,Locality,Status,Denial_Closure_Reason,Aid_Category,Application_Date,Authorized_Date,Number_of_Days,Authorized_Worker_ID,MA_Pregnancy_Indicator,Processing_Unit,Filename,Filename_Prefix' 
  ,'REGEXP_REPLACE(tracking_,''[^A-Za-z0-9]'',''''),case_,source,locality,status,denialclosure_reason,aid_category,CASE WHEN REGEXP_INSTR(application_date,''/'') = 0 THEN DATEADD(DAYS, application_date,CAST(''12/30/1899'' AS DATE)) ELSE TRY_CAST(regexp_replace(application_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) END AS application_date, CASE WHEN REGEXP_INSTR(authorized_date,''/'') = 0 THEN DATEADD(DAYS, authorized_date,CAST(''12/30/1899'' AS DATE)) ELSE TRY_CAST(regexp_replace(authorized_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) END AS authorized_date,TRY_CAST(number_of_days AS NUMBER),authorized_worker_id,ma_pregnancy_indicator,processing_unit,filename,SUBSTR(filename,1,6) filename_prefix'
  ,'WHERE tracking_ IS NOT NULL','Y','N','Y','N','Y','PREVIOUS_BUSINESS_DAY');
  
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,use_in_v2_inventory,use_in_v3_inventory,file_day_received)
VALUES('CM_045','CM_PROCESSING_TIME_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Case_Number,Source,Locality,Status,Denial_Closure_Reason,Aid_Category,Application_Date,Authorized_Date,Number_of_Days,Authorized_Worker_ID,MA_Pregnancy_Indicator,Processing_Unit,Filename,Filename_Prefix' 
  ,'REGEXP_REPLACE(tracking_,''[^A-Za-z0-9]'',''''),case_,source,case_locality,status,denialclosure_reason,aid_category,CASE WHEN REGEXP_INSTR(application_date,''/'') = 0 THEN DATEADD(DAYS, application_date,CAST(''12/30/1899'' AS DATE)) ELSE TRY_CAST(regexp_replace(application_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) END AS application_date, CASE WHEN REGEXP_INSTR(authorized_date,''/'') = 0 THEN DATEADD(DAYS, authorized_date,CAST(''12/30/1899'' AS DATE)) ELSE TRY_CAST(regexp_replace(authorized_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) END AS authorized_date,TRY_CAST(numberof_days AS NUMBER),authorized_worker_id,ma_pregnancy_indicator,processing_unit,filename,SUBSTR(filename,1,6) filename_prefix'
  ,'WHERE tracking_ IS NOT NULL','Y','N','Y','N','Y','WEEKLY');
  
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,use_in_v2_inventory,use_in_v3_inventory,file_day_received)
VALUES('CM_046','CM_PROCESSING_TIME_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Case_Number,Source,Locality,Status,Denial_Closure_Reason,Aid_Category,Application_Date,Authorized_Date,Number_of_Days,Authorized_Worker_ID,MA_Pregnancy_Indicator,Processing_Unit,Filename,Filename_Prefix' 
  ,'REGEXP_REPLACE(tracking_,''[^A-Za-z0-9]'',''''),case_,source,case_locality,status,denialclosure_reason,aid_category,CASE WHEN REGEXP_INSTR(application_date,''/'') = 0 THEN DATEADD(DAYS, application_date,CAST(''12/30/1899'' AS DATE)) ELSE TRY_CAST(regexp_replace(application_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) END AS application_date, CASE WHEN REGEXP_INSTR(authorized_date,''/'') = 0 THEN DATEADD(DAYS, authorized_date,CAST(''12/30/1899'' AS DATE)) ELSE TRY_CAST(regexp_replace(authorized_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) END AS authorized_date,TRY_CAST(number_of__days AS NUMBER),authorized_worker_id,ma_pregnancy_indicator,processing_unit,filename,SUBSTR(filename,1,6) filename_prefix'
  ,'WHERE tracking_ IS NOT NULL','Y','N','Y','N','Y','MONTHLY');  


  
  
 
 
 
