use schema paieb_dev;
ALTER TABLE _PAIEB_TABLE_LIST ADD(TABLE_PRIMARY_KEY VARCHAR);

UPDATE _PAIEB_TABLE_LIST 
SET table_primary_key = 'VALUE'
WHERE table_name like 'ENUM%';

UPDATE _PAIEB_TABLE_LIST 
SET table_primary_key = 'STEP_DEFINITION_ID'
WHERE table_name = 'STEP_DEFINITION';

UPDATE _PAIEB_TABLE_LIST 
SET table_primary_key = 'STAFF_ID'
WHERE table_name = 'STAFF';

UPDATE _PAIEB_TABLE_LIST 
SET table_primary_key = 'GROUP_ID'
WHERE table_name = 'GROUPS';

UPDATE _PAIEB_TABLE_LIST 
SET table_primary_key = 'PLAN_ID'
WHERE table_name = 'PLANS';

UPDATE _PAIEB_TABLE_LIST 
SET table_primary_key = 'HOLIDAY_ID'
WHERE table_name = 'HOLIDAYS';

UPDATE _PAIEB_TABLE_LIST 
SET table_primary_key = 'LMDEF_ID'
WHERE table_name = 'LETTER_DEFINITION';

UPDATE _paieb_table_list
SET table_primary_key = 'APP_STATUS_CODE'
WHERE table_name = 'D_APP_STATUS';

UPDATE _paieb_table_list
SET table_primary_key = 'D_DATE'
WHERE table_name = 'D_DATES';

UPDATE _paieb_table_list
SET table_primary_key = 'D_DATE'
WHERE table_name = 'BPM_D_DATES';

UPDATE _paieb_table_list
SET table_primary_key = 'TASK_TYPE_ID'
WHERE table_name = 'D_TASK_TYPES';

UPDATE _paieb_table_list
SET table_primary_key = 'D_YEAR'
WHERE table_name = 'D_YEARS';

UPDATE _paieb_table_list
SET table_primary_key = 'D_MONTH'
WHERE table_name = 'D_MONTHS';

UPDATE _paieb_table_list
SET table_primary_key = 'D_WEEK'
WHERE table_name = 'D_WEEKS';

UPDATE _paieb_table_list
SET table_primary_key = 'D_QUARTER'
WHERE table_name = 'D_QUARTERS';

show primary keys in schema maxeb_dp4bi_paieb_dev.paieb_dev; --replace with correct db/schema

create table cfg_paieb_table_primary_keys_bk
as
(select * from table(result_scan(last_query_id())));

select * from cfg_paieb_table_primary_keys_bk;

CREATE OR REPLACE sequence control.seq_paieb_tablepk_id;
CREATE OR REPLACE sequence control.seq_paieb_synchlog_id;

CREATE TABLE control.cfg_paieb_table_primary_keys(tablepk_id NUMBER DEFAULT control.seq_paieb_tablepk_id.nextval,
pk_created_on timestamp_ntz(9),
pk_database_name varchar,
pk_schema_name varchar,
pk_table_name varchar,
pk_column_name varchar,
pk_key_sequence number,
pk_data_type varchar,
pk_constraint_name varchar);

INSERT INTO control.cfg_paieb_table_primary_keys(pk_created_on,pk_database_name,pk_schema_name,pk_table_name,pk_column_name,pk_key_sequence,pk_data_type,pk_constraint_name)
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
FROM cfg_paieb_table_primary_keys_bk
WHERE "table_name" IN(SELECT table_name FROM _PAIEB_TABLE_LIST) ;

ALTER TABLE control.cfg_paieb_table_primary_keys ADD PRIMARY KEY(tablepk_id);

drop table cfg_paieb_table_primary_keys_bk;

CREATE TABLE control.paieb_synchronize_table_log(synch_log_id NUMBER DEFAULT control.seq_paieb_synchlog_id.nextval, 
synch_table_name VARCHAR,
synch_status VARCHAR,
status_date TIMESTAMP_NTZ(9),
num_rows_inserted NUMBER,
num_rows_updated NUMBER,
job_id NUMBER);
ALTER TABLE  control.paieb_synchronize_table_log ADD PRIMARY KEY(synch_log_id);