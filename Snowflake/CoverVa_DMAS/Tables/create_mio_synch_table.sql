show primary keys in schema mars_dp4bi_dev.coverva_mio;

create table coverva_mio.cfg_mio_table_primary_keys_bk
as
(select * from table(result_scan(last_query_id())));

select * from coverva_mio.cfg_mio_table_primary_keys_bk;

CREATE OR REPLACE sequence coverva_dmas.seq_mio_tablepk_id;
CREATE OR REPLACE sequence coverva_dmas.seq_mio_synchlog_id;

CREATE TABLE coverva_mio.cfg_mio_table_primary_keys(mio_tablepk_id NUMBER DEFAULT coverva_dmas.seq_mio_tablepk_id.nextval,
pk_created_on timestamp_ntz(9),
pk_database_name varchar,
pk_schema_name varchar,
pk_table_name varchar,
pk_column_name varchar,
pk_key_sequence number,
pk_data_type varchar,
pk_constraint_name varchar);

INSERT INTO coverva_mio.cfg_mio_table_primary_keys(pk_created_on,pk_database_name,pk_schema_name,pk_table_name,pk_column_name,pk_key_sequence,pk_data_type,pk_constraint_name)
SELECT "created_on"
,"database_name"
,"schema_name"
,"table_name"
,"column_name"
,"key_sequence"
,CASE WHEN "column_name" LIKE '%ID' THEN 'NUMBER'
  WHEN "column_name" LIKE '%DATE' THEN 'TIMESTAMP_NTZ'
  WHEN "column_name" = 'LOG_CREATED_ON' THEN 'TIMESTAMP_NTZ'
  ELSE 'VARCHAR' END
,CONCAT("table_name","column_name","key_sequence") constraint_name
FROM coverva_mio.cfg_mio_table_primary_keys_bk;

ALTER TABLE coverva_mio.cfg_mio_table_primary_keys ADD PRIMARY KEY(mio_tablepk_id);

drop table coverva_mio.cfg_mio_table_primary_keys_bk;

CREATE TABLE coverva_mio.mio_synchronize_table_log(synch_log_id NUMBER DEFAULT coverva_dmas.seq_mio_synchlog_id.nextval, synch_table_name VARCHAR,synch_status VARCHAR,status_date TIMESTAMP_NTZ(9),num_rows_inserted NUMBER,num_rows_updated NUMBER);
ALTER TABLE  coverva_mio.mio_synchronize_table_log ADD PRIMARY KEY(synch_log_id);