CREATE OR REPLACE SEQUENCE coverva_dmas.seq_rp274_data_id;

CREATE OR REPLACE TABLE RP274_DATA_FULL_LOAD(
rp274_data_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_rp274_data_id.nextval,
case_number VARCHAR,
worker_id VARCHAR,
worker_name VARCHAR,
renewal_due_date DATE,
renewal_completion_date DATE,
current_fips VARCHAR,
edg VARCHAR,
previous_aid_category VARCHAR,
new_aid_category VARCHAR,
originating_fips VARCHAR,
originating_worker_id VARCHAR,
date_assigned_to_coverva TIMESTAMP_NTZ(9),
reassigned_to_new_locality_flag VARCHAR,
date_transferred_to_ldss DATE,
num_days_assign_to_transfer NUMBER,
filename VARCHAR);

ALTER TABLE RP274_DATA_FULL_LOAD ADD PRIMARY KEY(rp274_data_id);

DELETE FROM coverva_dmas.dmas_file_load_lkup
WHERE filename_prefix = 'RP274';
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp,file_day_received,use_in_v2_inventory)
VALUES('RP274','RP274_DATA_FULL_LOAD','COVERVA_DMAS','case_number,worker_id,worker_name,renewal_due_date,renewal_completion_date,current_fips,edg,previous_aid_category,new_aid_category,originating_fips,originating_worker_id,
date_assigned_to_coverva,reassigned_to_new_locality_flag,date_transferred_to_ldss,num_days_assign_to_transfer,filename'
,'case_number,worker_id,worker_name,CAST(regexp_replace(renewal_due_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE) ,CAST(regexp_replace(renewal_completion_date,''[^A-Za-z0-9 -:/*]'','''') AS DATE),current_fips,edg,previous_aid_category,
  new_aid_category,originating_fips,originating_worker_id,CAST(regexp_replace(date_assigned_to_coverva,''[^A-Za-z0-9 -:/*]'','''') AS DATE),reassigned_to_new_locality_flag,CAST(regexp_replace(date_transferred_to_ldss,''[^A-Za-z0-9 -:/*]'','''') AS DATE),
  TRY_CAST(number_of_days_from_assignment_to_transfer AS NUMBER),filename'
,'WHERE case_number IS NOT NULL','Y','N','Y','MONTHLY','Y');