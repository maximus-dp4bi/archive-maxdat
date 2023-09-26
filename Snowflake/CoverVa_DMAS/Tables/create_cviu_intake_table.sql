CREATE OR REPLACE sequence coverva_dmas.seq_dmas_cviu_intake_id;

delete from coverva_dmas.dmas_file_load_lkup
where filename_prefix = 'INTAKE';
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('INTAKE','CVIU_INTAKE_DATA_FULL_LOAD','COVERVA_DMAS',
      'offender_id,offender_location_type,medicaid_number,filename'
      ,'offenderid,offenderlocationtype,medicaidnumber,filename'
      ,'WHERE 1=1','Y','N','N');


--DROP TABLE coverva_dmas.cviu_intake_data_full_load;
CREATE TABLE coverva_dmas.cviu_intake_data_full_load
(cviu_intake_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_dmas_cviu_intake_id.nextval
,offender_id NUMBER
,offender_location_type VARCHAR
,medicaid_number VARCHAR
,filename VARCHAR);

alter table COVERVA_DMAS.cviu_intake_data_full_load add primary key (cviu_intake_id);

CREATE TABLE coverva_dmas.cviu_intake_history
(dr_file_dmonth VARCHAR,
 dr_file_dyearmon NUMBER,
 dr_file_date DATE,
 intake_record_count NUMBER,
 intake_process_count NUMBER,
 doc_intake_record_count NUMBER,
 scb_intake_record_count NUMBER,
 doc_intake_process_count NUMBER,
 scb_intake_process_count NUMBER);
 
 alter table COVERVA_DMAS.cviu_intake_history add primary key (dr_file_dyearmon);
 
 INSERT INTO coverva_dmas.cviu_intake_history (dr_file_dmonth, dr_file_dyearmon, dr_file_date, intake_record_count, intake_process_count, doc_intake_record_count, scb_intake_record_count, doc_intake_process_count, scb_intake_process_count)
 SELECT dr_file_dmonth,
 dr_file_dyearmon,
 dr_file_date,
 intake_record_count,
 intake_process_count,
 doc_intake_record_count,
 scb_intake_record_count,
 doc_intake_process_count,
 scb_intake_process_count
 FROM coverva_dmas.intake_history_ytd_20220531;