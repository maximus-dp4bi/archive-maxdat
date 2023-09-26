CREATE OR REPLACE sequence coverva_dmas.seq_cviu_liaison_id;

CREATE OR REPLACE TABLE COVERVA_DMAS.CVIU_LIAISON_DATA_FULL_LOAD(
      cviu_liaison_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_cviu_liaison_id.nextval,
      Tracking_Number VARCHAR NULL,
      Row_Id NUMBER,
      Date_Received DATE,
      Date_Received_Char VARCHAR,
      Case_Number VARCHAR,
      Task_Id VARCHAR,
      Paper_Application VARCHAR,
      Completed VARCHAR,
      Request_Type VARCHAR,
      Date_Completed DATE,
      Liaison_Worker VARCHAR,
      Filename VARCHAR,
      Filename_Prefix VARCHAR);
      
ALTER TABLE COVERVA_DMAS.CVIU_LIAISON_DATA_FULL_LOAD ADD PRIMARY KEY (cviu_liaison_id);  

DELETE FROM coverva_dmas.dmas_file_load_lkup
WHERE filename_prefix = 'CVIU_LIAISON_SMARTSHEET';

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,use_in_v2_inventory,use_in_v3_inventory,file_day_received)
VALUES('CVIU_LIAISON_SMARTSHEET','CVIU_LIAISON_DATA_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Row_Id,Date_Received,Date_Received_Char,Case_Number,Task_Id,Paper_Application,Completed,Request_Type,Date_Completed,Liaison_Worker,Filename,Filename_Prefix' 
  ,'SUBSTR(REGEXP_REPLACE(tnumber,''[^A-Za-z0-9]'',''''),1,9),TO_NUMBER(row_id) AS row_id,TRY_CAST(regexp_replace(date_received,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS date_received,date_received AS date_received_char,
  case_number,task_id,paper_application,completed,request_type,TRY_CAST(regexp_replace(date_completed,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS date_completed,liaison_worker,filename,SUBSTR(filename,1,22) filename_prefix'
  ,'WHERE 1=1','Y','N','Y','N','Y','SAME_DAY');
  

  
  
  
