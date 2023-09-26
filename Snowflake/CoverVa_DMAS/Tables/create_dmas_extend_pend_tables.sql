CREATE OR REPLACE sequence coverva_dmas.seq_extend_pend_id;

CREATE TABLE coverva_dmas.EXTEND_PEND_LETTERS_FULL_LOAD(
    Extend_Pend_id NUMBER DEFAULT coverva_dmas.seq_extend_pend_id.nextval,    
    Filename VARCHAR,
    Date_Sent TIMESTAMP_NTZ,     
    Tracking_Number VARCHAR );
    
ALTER TABLE coverva_dmas.EXTEND_PEND_LETTERS_FULL_LOAD ADD PRIMARY KEY(Extend_Pend_id);

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('EXTEND_PENDS','EXTEND_PEND_LETTERS_FULL_LOAD','COVERVA_DMAS','date_sent,tracking_number,filename'
      ,'TO_DATE(regexp_replace(date_sent,''[^A-Za-z0-9 -:/*]'',''''),''mm/dd/yyyy'') date_sent,t_number,filename','WHERE 1=1','Y','N','N');    

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('EXTEND_PENDS_OVER_45','EXTEND_PEND_LETTERS_FULL_LOAD','COVERVA_DMAS','date_sent,tracking_number,filename'
      ,'TO_DATE(regexp_replace(date_sent,''[^A-Za-z0-9 -:/*]'',''''),''mm/dd/yyyy'') date_sent,t_number,filename','WHERE 1=1','Y','N','N');          


CREATE OR REPLACE VIEW PUBLIC.DMAS_EXTEND_PEND_LETTER_SV
AS
SELECT extend_pend_id
  ,date_sent
  ,tracking_number
  ,filename
FROM coverva_dmas.extend_pend_letters_full_load;