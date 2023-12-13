CREATE OR REPLACE SEQUENCE seq_exparte_data_id;

CREATE OR REPLACE TABLE EXPARTE_DATA_FULL_LOAD (
renewal_month VARCHAR,
case_number VARCHAR,
client_name VARCHAR,
county VARCHAR,
primary_worker_id VARCHAR,
case_entered_exparte_flow VARCHAR,
renewal_successful_for_case VARCHAR,
exception_reason_for_case VARCHAR,
ex_parte_process VARCHAR,
automated_ex_parte_renewal_attempted_client VARCHAR,
renewal_successful_for_client VARCHAR,
exception_reason_for_client VARCHAR,
aid_category_prior_to_ex_parte VARCHAR,
aid_category_post_ex_parte VARCHAR,
automated_renewal_packet_gen_for_case VARCHAR,
current_renewal_date DATE,
new_renewal_date DATE,
filename VARCHAR,
exparte_data_id NUMBER(38,0) NOT NULL DEFAULT COVERVA_DMAS.seq_exparte_data_id.nextval,
primary key (exparte_data_id)
);

UPDATE DMAS_FILE_LOAD_LKUP
SET filename_prefix = 'EXPARTE_RUN_OLD'
  ,load_file = 'N'
WHERE filename_prefix = 'EXPARTE_RUN';

INSERT INTO DMAS_FILE_LOAD_LKUP (FILENAME_PREFIX,FULL_LOAD_TABLE_NAME,FULL_LOAD_TABLE_SCHEMA,INSERT_FIELDS,SELECT_FIELDS,WHERE_CLAUSE,LOAD_FILE,USE_IN_INVENTORY,WITH_TIMESTAMP,FILE_DAY_RECEIVED,USE_IN_V2_INVENTORY,USE_IN_V3_INVENTORY) VALUES
	 ('EXPARTE_RUN','EXPARTE_DATA_FULL_LOAD','COVERVA_DMAS',
     'renewal_month,case_number,client_name,county,primary_worker_id,case_entered_exparte_flow,renewal_successful_for_case,exception_reason_for_case,ex_parte_process,automated_ex_parte_renewal_attempted_client,renewal_successful_for_client,exception_reason_for_client,aid_category_prior_to_ex_parte,aid_category_post_ex_parte,automated_renewal_packet_gen_for_case,current_renewal_date,new_renewal_date,filename',
     'renewal_month,case_,client_name,county,primary_worker_id,case_entered_an_exparte_flow,renewal_successful_for_case,exception_reason_for_case,ex_parte_process,automated_exparte_renewal_attempted_for_client,renewal_successful_for_client_,exception_reason_for_client,aid_category_prior_to_ex_parte,aid_category_post_ex_parte,automated_renewal_packet_generation_for_case____,TO_DATE(current_renewal_date ,''MM/DD/YYYY'') current_renewal_date
,TO_DATE(new_renewal_date,''MM/DD/YYYY'') new_renewal_date ,filename','WHERE 1=1','Y','N','N',NULL,'N','N');