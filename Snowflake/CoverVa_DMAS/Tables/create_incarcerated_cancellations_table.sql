CREATE OR REPLACE sequence coverva_dmas.seq_dmas_incancel_id;

INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('INCARCERATED_CANCELLATIONS','INCARCERATED_CANCELLATIONS_FULL_LOAD','COVERVA_DMAS',
      'recipient_id,case_id,case_rel,case_date_review,case_work,r_mon_id,last_name,first_name,r_city,r_state,r_zip9,aid_category,status,sequence,begin_date,cancel_date,cancel_reason,add_aid_category,add_status,add_sequence,add_begin_date,add_end_date,add_cancel_date,add_cancel_reason,filename'
      ,'recip_id,case_id,case_rel,TRY_TO_DATE(case_d_review,''mm/dd/yyyy''),casework,r_mon_id,r_l_name,r_f_name,r_city,r_state,r_zip9,aid_cat,status,sequence,TRY_TO_DATE(begdt,''mm/dd/yyyy''),TRY_TO_DATE(candt,''mm/dd/yyyy''),can_reason,add_ac,add_status,add_seq,TRY_TO_DATE(add_begdt,''mm/dd/yyyy''),TRY_TO_DATE(add_enddt,''mm/dd/yyyy''),TRY_TO_DATE(add_candt,''mm/dd/yyyy''),add_can_reason,filename'
      ,'WHERE 1=1','Y','N','Y');
      
CREATE TABLE incarcerated_cancellations_full_load
(in_cancel_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_dmas_incancel_id.nextval
,recipient_id VARCHAR
,case_id VARCHAR
,case_rel NUMBER
,case_date_review DATE
,case_work VARCHAR
,r_mon_id VARCHAR
,last_name VARCHAR
,first_name VARCHAR
,r_city VARCHAR
,r_state VARCHAR
,r_zip9 VARCHAR
,aid_category VARCHAR
,status VARCHAR
,sequence NUMBER
,begin_date DATE
,cancel_date DATE
,cancel_reason VARCHAR
,add_aid_category VARCHAR
,add_status VARCHAR
,add_sequence NUMBER
,add_begin_date DATE
,add_end_date DATE
,add_cancel_date DATE
,add_cancel_reason VARCHAR
,reason VARCHAR
,filename VARCHAR);

alter table COVERVA_DMAS.incarcerated_cancellations_full_load add primary key (in_cancel_id);

