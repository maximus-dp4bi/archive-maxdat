CREATE OR REPLACE sequence coverva_dmas.seq_auto_closure_case_id;

CREATE TABLE COVERVA_DMAS.AUTO_CLOSURE_CASES_FULL_LOAD(
       auto_closure_case_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_auto_closure_case_id.nextval,
       locality VARCHAR NULL,
       worker VARCHAR NULL,
       unit VARCHAR NULL,
       status VARCHAR NULL,
       case_number VARCHAR NULL,
       client_id VARCHAR NULL,
       mmis_enrollee_id VARCHAR NULL,
       client_name VARCHAR NULL,
       universe_criteria VARCHAR NULL,
       error_number VARCHAR NULL,
       error_description VARCHAR NULL,
       processing_unit VARCHAR NULL,
       filename VARCHAR NULL);       

ALTER TABLE COVERVA_DMAS.AUTO_CLOSURE_CASES_FULL_LOAD ADD PRIMARY KEY(auto_closure_case_id);

DELETE FROM coverva_dmas.dmas_file_load_lkup
WHERE filename_prefix = 'AUTO_CLOSURE_REPORT';
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,file_day_received,use_in_v2_inventory)
VALUES('AUTO_CLOSURE_REPORT','AUTO_CLOSURE_CASES_FULL_LOAD','COVERVA_DMAS','locality,worker,unit,status,case_number,client_id,mmis_enrollee_id,client_name,universe_criteria,error_number,error_description,processing_unit,filename'
      ,'locality,worker,unit,status,case_number,client_id,mmis_enrollee_id,client_name,universe_criteria,error_number,error_description,processing_unit,filename'
      ,'WHERE 1=1','Y','N','Y','MONTHLY','N');
