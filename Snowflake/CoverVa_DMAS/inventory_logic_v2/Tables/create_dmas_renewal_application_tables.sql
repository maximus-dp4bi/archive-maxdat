CREATE OR REPLACE sequence coverva_dmas.seq_renewal_data_id;

CREATE TABLE COVERVA_DMAS.RENEWAL_DATA_FULL_LOAD(
       renewal_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_renewal_data_id.nextval,
       received_date TIMESTAMP_NTZ(9) NULL,
       tracking_number VARCHAR NOT NULL,
       application_source VARCHAR NULL,
       case_number VARCHAR NULL,
       case_name VARCHAR NULL,
       processing_unit VARCHAR NULL,
       programs VARCHAR NULL,
       worker_id VARCHAR NULL,
       locality VARCHAR NULL,
       processing_status VARCHAR NULL,
       potential_disability VARCHAR NULL,       
       incarcerated VARCHAR NULL,
       potential_pregnancy VARCHAR NULL,
       filename VARCHAR NULL);

ALTER TABLE COVERVA_DMAS.RENEWAL_DATA_FULL_LOAD ADD PRIMARY KEY(renewal_data_id);

DELETE FROM coverva_dmas.dmas_file_load_lkup
WHERE filename_prefix = 'RENEWALS';
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,file_day_received,use_in_v2_inventory)
VALUES('RENEWALS','RENEWAL_DATA_FULL_LOAD','COVERVA_DMAS','received_date,tracking_number,application_source,case_number,case_name,processing_unit,programs,worker_id,locality,processing_status,potential_disability,incarcerated,potential_pregnancy,filename'
      ,'CAST(regexp_replace(date_received,''[^A-Za-z0-9 -:/*]'','''') AS DATE) AS received_date,REGEXP_REPLACE(tracking_,''[^A-Za-z0-9]'',''''),source,case_,case_name,processing_unit,programs,worker_id,locality,processing_status,potential_disability,incarcerated,potential_pregnancy,filename'
      ,'WHERE 1=1','Y','Y','Y','SAME_DAY','Y');
