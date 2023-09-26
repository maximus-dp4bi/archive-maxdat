CREATE OR REPLACE sequence coverva_dmas.seq_rp267_data_id;

CREATE TABLE COVERVA_DMAS.RP267_DATA_FULL_LOAD(
      rp267_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_rp267_data_id.nextval,
      Tracking_Number VARCHAR,
      Case_Number VARCHAR,
      NOA_Generation_Date DATE,            
      NOA_Status VARCHAR,
      Authorized_Representative VARCHAR,
      MA_Pregnancy_Indicator VARCHAR,
      NOA_Print_Date DATE,
      Filename VARCHAR,
      Filename_Prefix VARCHAR);
      
ALTER TABLE COVERVA_DMAS.RP267_DATA_FULL_LOAD ADD PRIMARY KEY (rp267_data_id);  

DELETE FROM coverva_dmas.dmas_file_load_lkup
WHERE filename_prefix IN('RP267A','RP267B','RP267C');

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,use_in_v2_inventory,use_in_v3_inventory,file_day_received)
VALUES('RP267A','RP267_DATA_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Case_Number,NOA_Generation_Date,NOA_Status,Authorized_Representative,MA_Pregnancy_Indicator,NOA_Print_Date,Filename,Filename_Prefix' 
,'REGEXP_REPLACE(tracking_number,''[^A-Za-z0-9]'',''''),case_number,CAST(regexp_replace(NOA_generation_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS NOA_generation_date,noa_status,authorized_representative,mapg_indicator,CAST(regexp_replace(NOA_print_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS NOA_print_date,filename,SUBSTR(filename,1,6) filename_prefix'
  ,'WHERE tracking_number IS NOT NULL','Y','N','Y','N','Y','SAME_DAY');
 
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,use_in_v2_inventory,use_in_v3_inventory,file_day_received)
VALUES('RP267B','RP267_DATA_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Case_Number,NOA_Generation_Date,NOA_Status,Authorized_Representative,MA_Pregnancy_Indicator,NOA_Print_Date,Filename,Filename_Prefix' 
,'REGEXP_REPLACE(tracking_number,''[^A-Za-z0-9]'',''''),case_number,CAST(regexp_replace(NOA_generation_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS NOA_generation_date,noa_status,authorized_representative,mapg_indicator,CAST(regexp_replace(NOA_print_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS NOA_print_date,filename,SUBSTR(filename,1,6) filename_prefix'
  ,'WHERE tracking_number IS NOT NULL','Y','N','Y','N','Y','WEEKLY'); 
  
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,use_in_v2_inventory,use_in_v3_inventory,file_day_received)
VALUES('RP267C','RP267_DATA_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Case_Number,NOA_Generation_Date,NOA_Status,Authorized_Representative,MA_Pregnancy_Indicator,NOA_Print_Date,Filename,Filename_Prefix' 
,'REGEXP_REPLACE(tracking_number,''[^A-Za-z0-9]'',''''),case_number,CAST(regexp_replace(NOA_generation_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS NOA_generation_date,noa_status,authorized_representative,mapg_indicator,CAST(regexp_replace(NOA_print_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS NOA_print_date,filename,SUBSTR(filename,1,6) filename_prefix'
  ,'WHERE tracking_number IS NOT NULL','Y','N','Y','N','Y','MONTHLY');   

  
  
  
