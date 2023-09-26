CREATE OR REPLACE SEQUENCE seq_exparte_run_id;

CREATE OR REPLACE TABLE EXPARTE_RUN_FULL_LOAD (
county VARCHAR,
filename VARCHAR,
case_number VARCHAR,
client_name VARCHAR,
primary_worker_id VARCHAR,
automated_ex_parte_renewal_attempted VARCHAR,
renewal_successful VARCHAR,
exception_reason VARCHAR,
ex_parte_process VARCHAR,
aid_category_prior_to_ex_parte VARCHAR,
aid_category_post_ex_parte VARCHAR,
automated_renewal_packet_generation VARCHAR,
current_renewal_date DATE,
new_renewal_date DATE,
exparte_run_id NUMBER(38,0) NOT NULL DEFAULT COVERVA_DMAS.seq_exparte_run_id.nextval,
	primary key (exparte_run_id)
 );       

  INSERT INTO DMAS_FILE_LOAD_LKUP (FILENAME_PREFIX,FULL_LOAD_TABLE_NAME,FULL_LOAD_TABLE_SCHEMA,INSERT_FIELDS,SELECT_FIELDS,WHERE_CLAUSE,LOAD_FILE,USE_IN_INVENTORY,WITH_TIMESTAMP,FILE_DAY_RECEIVED,USE_IN_V2_INVENTORY,USE_IN_V3_INVENTORY) VALUES
	 ('EXPARTE_RUN','EXPARTE_RUN_FULL_LOAD','COVERVA_DMAS','county ,case_number,client_name ,primary_worker_id ,automated_ex_parte_renewal_attempted ,renewal_successful ,exception_reason ,ex_parte_process ,aid_category_prior_to_ex_parte ,aid_category_post_ex_parte ,automated_renewal_packet_generation ,current_renewal_date ,new_renewal_date ,filename','county ,case_,client_name ,primary_worker_id ,automated_ex_parte_renewal_attempted ,renewal_successful ,exception_reason ,ex_parte_process ,aid_category_prior_to_ex_parte ,aid_category_post_ex_parte ,automated_renewal_packet_generation ,TO_DATE(current_renewal_date ,''DD-MON-YY'') current_renewal_date
,TO_DATE(new_renewal_date  ,''DD-MON-YY'') new_renewal_date ,filename','WHERE 1=1','Y','N','N',NULL,'N','N');