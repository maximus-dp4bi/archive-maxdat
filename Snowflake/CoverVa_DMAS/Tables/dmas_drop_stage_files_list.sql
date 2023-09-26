CREATE OR REPLACE sequence coverva_dmas.seq_dmas_stagefile_id;

CREATE TABLE coverva_dmas.dmas_drop_stage_files_list
(stage_file_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_dmas_stagefile_id.nextval
,stage_table_name VARCHAR
,is_dropped VARCHAR(2)
,comments VARCHAR
,create_dt TIMESTAMP_NTZ(9) DEFAULT current_timestamp()
,update_dt TIMESTAMP_NTZ(9) DEFAULT current_timestamp());

ALTER TABLE coverva_dmas.dmas_drop_stage_files_list ADD primary key(stage_file_id);