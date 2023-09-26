CREATE OR REPLACE sequence coverva_dmas.seq_rp265_data_id;

CREATE TABLE COVERVA_DMAS.RP265_DATA_FULL_LOAD(
      rp265_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_rp265_data_id.nextval,
      Tracking_Number VARCHAR NOT NULL,
      Case_Number VARCHAR,
      Applicant_Name VARCHAR,
      Application_Type VARCHAR,      
      Application_Date DATE,      
      Days_Pending NUMBER,
      Status VARCHAR,
      Transfer_Date DATE,
      Sending_Agency VARCHAR,
      Receiving_Agency VARCHAR,
      Transferring_Worker_Name VARCHAR,
      Transferring_Worker_Locality VARCHAR,
      Transferring_Worker_LDAP_ID VARCHAR,
      Receiving_Worker_Name VARCHAR,
      Receiving_Worker_Locality VARCHAR,
      Receiving_Worker_LDAP_ID VARCHAR,      
      Incarcerated_Indicator VARCHAR,
      MA_Pregnancy_Indicator VARCHAR,
      Filename VARCHAR,
      Filename_Prefix VARCHAR);
      
ALTER TABLE COVERVA_DMAS.RP265_DATA_FULL_LOAD ADD PRIMARY KEY (rp265_data_id);  

DELETE FROM coverva_dmas.dmas_file_load_lkup
WHERE filename_prefix IN('RP265A');

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,use_in_v2_inventory,use_in_v3_inventory,file_day_received)
VALUES('RP265A','RP265_DATA_FULL_LOAD','COVERVA_DMAS','Tracking_Number,Case_Number,Applicant_Name,Application_Type,Application_Date,Days_Pending,Status,Transfer_Date,Sending_Agency,Receiving_Agency,
Transferring_Worker_Name,Transferring_Worker_Locality,Transferring_Worker_LDAP_ID,Receiving_Worker_Name,Receiving_Worker_Locality,Receiving_Worker_LDAP_ID,Incarcerated_Indicator,MA_Pregnancy_Indicator,Filename,Filename_Prefix' 
,'REGEXP_REPLACE(tracking_number,''[^A-Za-z0-9]'',''''),case_number,applicant_name,application_type,CAST(regexp_replace(application_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS application_date,regexp_replace(days_pending,''[^0-9]'','''') days_pending,
status,CAST(regexp_replace(transfer_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS transfer_date,sending_agency,receiving_agency,transferring_worker_name,transferring_worker_locality,transferring_worker_ldap_id,
receiving_worker_name,receiving_worker_locality,receiving_worker_ldap_id,incarcerated_indicator,mapg_indicator,filename,SUBSTR(filename,1,6) filename_prefix'
  ,'WHERE tracking_number IS NOT NULL','Y','N','Y','N','Y','SAME_DAY');
 

  
  
  
