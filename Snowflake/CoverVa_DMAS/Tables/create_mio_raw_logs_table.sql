CREATE TABLE coverva_mio.mio_raw_logs(
LOG_CREATED_ON TIMESTAMP_NTZ(9),
TYPE VARCHAR,
"TABLE" VARCHAR,
"DATABASE" VARCHAR,
"OFFSET" VARCHAR,
"TABLE_NAME" VARCHAR,
"DATA" VARCHAR,
MIO_RAW_LOG_ID VARCHAR,
SF_PROCESSED NUMBER);

ALTER TABLE coverva_mio.mio_raw_logs ADD PRIMARY KEY(mio_raw_log_id);

-- drop table coverva_mio.ctl_mio_sf_count_compare;
CREATE TABLE coverva_mio.ctl_mio_sf_count_compare
(table_schema varchar,
 table_name varchar,
 log_created_on timestamp_ntz(9),
 timestamp timestamp_ntz(9),
 mio_count number,
 sf_count number);
 
 ALTER TABLE coverva_mio.ctl_mio_sf_count_compare ADD PRIMARY KEY (log_created_on,table_name);