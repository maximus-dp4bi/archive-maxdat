CREATE OR REPLACE VIEW PUBLIC.dmas_incarcerated_cancellations_sv
AS
SELECT recipient_id
,case_id
,case_rel
,case_date_review
,case_work
,r_mon_id
,last_name
,first_name
,r_city
,r_state
,r_zip9
,aid_category
,status
,sequence
,begin_date
,cancel_date
,cancel_reason
,add_aid_category
,add_status
,add_sequence
,add_begin_date
,add_end_date
,add_cancel_date
,add_cancel_reason
,filename
FROM COVERVA_DMAS.incarcerated_cancellations_full_load;