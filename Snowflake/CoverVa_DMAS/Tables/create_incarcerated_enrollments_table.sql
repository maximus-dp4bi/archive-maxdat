CREATE OR REPLACE sequence coverva_dmas.seq_dmas_inenroll_id;

delete from coverva_dmas.dmas_file_load_lkup
where filename_prefix = 'INCARCERATED_UNIT_ENROLLMENT';
INSERT INTO coverva_dmas.dmas_file_load_lkup(filename_prefix,full_load_table_name,full_load_table_schema,insert_fields,select_fields,where_clause,load_file,use_in_inventory,with_timestamp)
VALUES('INCARCERATED_UNIT_ENROLLMENT','INCARCERATED_ENROLLMENTS_FULL_LOAD','COVERVA_DMAS',
      'recipient_id,case_id,vacms_enrl_id,ind_code,cit_stat,case_rel,case_date_review,case_work,r_mon_id,last_name,first_name,r_addtl,r_street,r_city,r_state,r_zip9,eligibility_aid_category,elg_sequence,eligibility_begin_date,eligibility_end_date,canrs,filename'
      ,'recip_id,case_id,vacms_enrl_id,ind_code,cit_stat,case_rel,TRY_TO_DATE(case_d_review,''mm/dd/yyyy''),casework,r_mon_id,r_l_name,r_f_name,r_addtl,r_street,r_city,r_state,r_zip9,elig_aid,elgseq,TRY_TO_DATE(elgbeg,''mm/dd/yyyy''),TRY_TO_DATE(elgend,''mm/dd/yyyy''),canrs,filename'
      ,'WHERE 1=1','Y','N','Y');
      
CREATE TABLE coverva_dmas.incarcerated_enrollments_full_load
(in_enroll_id NUMBER NOT NULL DEFAULT coverva_dmas.seq_dmas_inenroll_id.nextval
,recipient_id VARCHAR
,case_id VARCHAR
,vacms_enrl_id NUMBER
,ind_code VARCHAR
,cit_stat VARCHAR
,case_rel NUMBER
,case_date_review DATE
,case_work VARCHAR
,r_mon_id VARCHAR
,last_name VARCHAR
,first_name VARCHAR
,r_addtl VARCHAR
,r_street VARCHAR
,r_city VARCHAR
,r_state VARCHAR
,r_zip9 VARCHAR
,eligibility_aid_category VARCHAR
,elg_sequence VARCHAR
,eligibility_begin_date DATE
,eligibility_end_date DATE
,canrs VARCHAR
,filename VARCHAR);

alter table COVERVA_DMAS.incarcerated_enrollments_full_load add primary key (in_enroll_id);

