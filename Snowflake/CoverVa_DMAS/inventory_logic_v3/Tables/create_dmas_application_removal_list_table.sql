CREATE OR REPLACE sequence coverva_dmas.seq_app_rm_id;

CREATE TABLE COVERVA_DMAS.APPLICATION_REMOVAL_LIST_FULL_LOAD(
      app_rm_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_app_rm_id.nextval,
      Tracking_Number VARCHAR NOT NULL,
      Date_Added DATE,
      Removal_Reason VARCHAR,
      Filename VARCHAR,
      Filename_Prefix VARCHAR,
      remove_from_inventory VARCHAR);
      
ALTER TABLE COVERVA_DMAS.APPLICATION_REMOVAL_LIST_FULL_LOAD ADD PRIMARY KEY (app_rm_id);  

DELETE FROM coverva_dmas.dmas_file_load_lkup
WHERE filename_prefix = 'T_REMOVAL_LIST';

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,use_in_v2_inventory,use_in_v3_inventory,file_day_received)
VALUES('T_REMOVAL_LIST','APPLICATION_REMOVAL_LIST_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Date_Added,Removal_Reason,Filename,Filename_Prefix' 
  ,'REGEXP_REPLACE(t,''[^A-Za-z0-9]'',''''),CAST(regexp_replace(date_added,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS date_added,reason,filename,SUBSTR(filename,1,6) filename_prefix'
  ,'WHERE 1=1','Y','N','Y','N','Y','MONTHLY');
  

  
  
  
