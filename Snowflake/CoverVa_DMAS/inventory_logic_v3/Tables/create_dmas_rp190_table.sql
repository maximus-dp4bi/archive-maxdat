CREATE OR REPLACE sequence coverva_dmas.seq_rp190_data_id;

CREATE TABLE COVERVA_DMAS.RP190_DATA_FULL_LOAD(
      rp190_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_rp190_data_id.nextval,
      Tracking_Number VARCHAR NOT NULL,
      Date_Received DATE,      
      Source VARCHAR,
      Name VARCHAR,
      Locality VARCHAR,
      Processing_Status VARCHAR,
      Incarcerated_Indicator VARCHAR,
      MA_Pregnancy_Indicator VARCHAR,
      ABD_Indicator VARCHAR,            
      Filename VARCHAR,
      Filename_Prefix VARCHAR);
      
ALTER TABLE COVERVA_DMAS.RP190_DATA_FULL_LOAD ADD PRIMARY KEY (rp190_data_id);  

DELETE FROM coverva_dmas.dmas_file_load_lkup
WHERE filename_prefix IN('RP190');

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,use_in_v2_inventory,use_in_v3_inventory,file_day_received)
VALUES('RP190','RP190_DATA_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Date_Received,Source,Name,Locality,Processing_Status,Incarcerated_Indicator,MA_Pregnancy_Indicator,ABD_Indicator,Filename,Filename_Prefix' 
  ,'REGEXP_REPLACE(tracking_,''[^A-Za-z0-9]'',''''),CASE WHEN REGEXP_INSTR(date_received,''/'') = 0 THEN DATEADD(DAYS, date_received,CAST(''12/30/1899'' AS DATE)) ELSE TRY_CAST(date_received AS DATE) END AS app_date_received,source,name,locality,processing_status,incarcerated_indicator,ma_pregnancy_indicator,aged_blind_disabled_indicator,filename,SUBSTR(filename,1,5) filename_prefix'
  ,'WHERE tracking_ IS NOT NULL','Y','N','Y','N','Y','SAME_DAY');
 

  
  
  
