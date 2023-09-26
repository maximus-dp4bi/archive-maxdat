CREATE OR REPLACE VIEW PUBLIC.dmas_incarcerated_enrollments_sv
AS
SELECT 
recipient_id
,case_id
,vacms_enrl_id
,ind_code
,cit_stat
,case_rel
,case_date_review
,case_work
,r_mon_id
,last_name
,first_name
,r_addtl
,r_street
,r_city
,r_state
,r_zip9
,eligibility_aid_category
,elg_sequence
,eligibility_begin_date
,eligibility_end_date
,canrs
,filename
FROM COVERVA_DMAS.incarcerated_enrollments_full_load;