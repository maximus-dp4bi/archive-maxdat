CREATE OR REPLACE sequence coverva_dmas.seq_rp269_data_id;

CREATE TABLE COVERVA_DMAS.RP269_DATA_FULL_LOAD(
      rp269_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_rp269_data_id.nextval,
      Tracking_Number VARCHAR,
      Case_Number VARCHAR,
      VCL_Generation_Date DATE,            
      VCL_Status VARCHAR,
      Authorized_Representative VARCHAR,
      MA_Pregnancy_Indicator VARCHAR,
      Application_ABD_Indicator VARCHAR,      
      VCL_Print_Date DATE,
      Filename VARCHAR,
      Filename_Prefix VARCHAR);
      
ALTER TABLE COVERVA_DMAS.RP269_DATA_FULL_LOAD ADD PRIMARY KEY (rp269_data_id);  

DELETE FROM coverva_dmas.dmas_file_load_lkup
WHERE filename_prefix IN('RP269A','RP269B','RP269C');

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,use_in_v2_inventory,use_in_v3_inventory,file_day_received)
VALUES('RP269A','RP269_DATA_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Case_Number,VCL_Generation_Date,VCL_Status,Authorized_Representative,MA_Pregnancy_Indicator,Application_ABD_Indicator,VCL_Print_Date,Filename,Filename_Prefix' 
,'REGEXP_REPLACE(tracking_number,''[^A-Za-z0-9]'',''''),case_number,CAST(regexp_replace(VCL_generation_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS VCL_generation_date,vcl_status,authorized_representative,mapg_indicator,application_aged_blind_disabled_indicator,CAST(regexp_replace(VCL_print_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS VCL_print_date,filename,SUBSTR(filename,1,6) filename_prefix'
  ,'WHERE tracking_number IS NOT NULL','Y','N','Y','N','Y','SAME_DAY');
 
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,use_in_v2_inventory,use_in_v3_inventory,file_day_received)
VALUES('RP269B','RP269_DATA_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Case_Number,VCL_Generation_Date,VCL_Status,Authorized_Representative,MA_Pregnancy_Indicator,Application_ABD_Indicator,VCL_Print_Date,Filename,Filename_Prefix' 
,'REGEXP_REPLACE(tracking_number,''[^A-Za-z0-9]'',''''),case_number,CAST(regexp_replace(VCL_generation_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS VCL_generation_date,vcl_status,authorized_representative,mapg_indicator,application_aged_blind_disabled_indicator,CAST(regexp_replace(VCL_print_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS VCL_print_date,filename,SUBSTR(filename,1,6) filename_prefix'
  ,'WHERE tracking_number IS NOT NULL','Y','N','Y','N','Y','MONTHLY'); 

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,use_in_v2_inventory,use_in_v3_inventory,file_day_received)
VALUES('RP269C','RP269_DATA_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Case_Number,VCL_Generation_Date,VCL_Status,Authorized_Representative,MA_Pregnancy_Indicator,Application_ABD_Indicator,VCL_Print_Date,Filename,Filename_Prefix' 
,'REGEXP_REPLACE(tracking_number,''[^A-Za-z0-9]'',''''),case_number,CAST(regexp_replace(VCL_generation_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS VCL_generation_date,vcl_status,authorized_representative,mapg_indicator,application_aged_blind_disabled_indicator,CAST(regexp_replace(VCL_print_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS VCL_print_date,filename,SUBSTR(filename,1,6) filename_prefix'
  ,'WHERE tracking_number IS NOT NULL','Y','N','Y','N','Y','WEEKLY'); 
  
  
  
