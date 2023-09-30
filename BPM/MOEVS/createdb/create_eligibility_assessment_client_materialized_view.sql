
----drop materialized view maxdat_support.eligibility_assessment_client_sv_old;
ALTER TABLE maxdat_support.eligibility_assessment_client_sv OWNER TO DBA;
ALTER MATERIALIZED view maxdat_support.eligibility_assessment_client_sv rename to eligibility_assessment_client_sv_old;


CREATE MATERIALIZED VIEW maxdat_support.eligibility_assessment_client_sv
AS 
SELECT dense_rank() OVER (PARTITION BY DATE_TRUNC('month'::text, uclient.record_processing_date) ORDER BY DATE_TRUNC('month'::text, uclient.record_processing_date), (
        CASE uclient.program_type
            WHEN 'PT26301'::text THEN 'FAM'::character varying
            WHEN 'PT26302'::text THEN 'KID'::character varying
            ELSE uclient.program_type
        END), (abs('now'::text::date - LEAST(COALESCE(uclient.anniversary_date::date, uclient.app_due_date::date), COALESCE(uclient.app_due_date::date, uclient.anniversary_date::date)))), uclient.case_id, uclient.client_ssn,uclient.dcn) AS sequence,
    uclient.client_name,
    uclient.client_ssn,
    uclient.client_dob,
    uclient.dcn,
    uclient.ref_case_id,
    uclient.ref_client_id,
    uclient.gender,
    uclient.marital_status,
    uclient.client_hoh,
    uclient.family_size,
    uclient.gross_income,
    uclient.citizenship_status,
    uclient.citizen_verified,
    uclient.alien_reg_nbr,
    uclient.program_type,
    uclient.aid_category,
    uclient.case_id,
    uclient.anniversary_date,
    uclient.applicant_status,
    uclient.status_date,
    uclient.application_id,
    uclient.app_due_date,
    uclient.record_processing_date,
	abs(CURRENT_DATE - LEAST(COALESCE(uclient.anniversary_date::date, uclient.app_due_date::date), COALESCE(uclient.app_due_date::date, uclient.anniversary_date::date))) AS sort_index,
        CASE
            WHEN uclient.anniversary_date IS NOT NULL AND uclient.app_due_date IS NOT NULL THEN
            CASE
                WHEN  abs(CURRENT_DATE - uclient.anniversary_date::date) < 
				abs(CURRENT_DATE - uclient.app_due_date::date) THEN uclient.anniversary_date
                ELSE uclient.app_due_date
            END
            WHEN uclient.anniversary_date IS NULL THEN uclient.app_due_date
            WHEN uclient.app_due_date IS NULL THEN uclient.anniversary_date
            ELSE NULL::date
        END AS sort_date,
    uclient.ds_load_ts,
    uclient.case_id_ext,
    uclient.decedent_ssn,
    uclient.decedent_name,
    uclient.decedent_date_of_birth,
    uclient.decedent_date_of_death,
    uclient.decedent_recorded_state_code,
    uclient.decedent_residence_county,
	uclient.support_order_date_established,
	uclient.support_order_date_modified,
	uclient.support_order_number
   FROM ( SELECT eligibility_assessment_paris_inter_sv.cust_name AS client_name,
            eligibility_assessment_paris_inter_sv.client_ssn,
            eligibility_assessment_paris_inter_sv.client_dob,
            eligibility_assessment_paris_inter_sv.dcn,
            eligibility_assessment_paris_inter_sv.ref_case_id,
            eligibility_assessment_paris_inter_sv.ref_client_id,
            eligibility_assessment_paris_inter_sv.gender,
            eligibility_assessment_paris_inter_sv.marital_status,
            eligibility_assessment_paris_inter_sv.client_hoh,
            eligibility_assessment_paris_inter_sv.family_size,
            eligibility_assessment_paris_inter_sv.gross_income,
            eligibility_assessment_paris_inter_sv.citizenship_status,
            eligibility_assessment_paris_inter_sv.citizen_verified,
            eligibility_assessment_paris_inter_sv.alien_reg_nbr,
            eligibility_assessment_paris_inter_sv.program_type,
            eligibility_assessment_paris_inter_sv.aid_category,
            eligibility_assessment_paris_inter_sv.case_id,
            eligibility_assessment_paris_inter_sv.anniversary_date,
            eligibility_assessment_paris_inter_sv.applicant_status,
            eligibility_assessment_paris_inter_sv.status_date,
            eligibility_assessment_paris_inter_sv.application_id,
            eligibility_assessment_paris_inter_sv.app_due_date,
            eligibility_assessment_paris_inter_sv.record_processing_date,
            date_trunc('day'::text, eligibility_assessment_paris_inter_sv.ds_load_ts) AS ds_load_ts,
            date_trunc('month'::text, eligibility_assessment_paris_inter_sv.ds_load_ts) AS ds_load_ts_month,
            eligibility_assessment_paris_inter_sv.case_id_ext,
            eligibility_assessment_paris_inter_sv.decedent_ssn,
            eligibility_assessment_paris_inter_sv.decedent_name,
            eligibility_assessment_paris_inter_sv.decedent_date_of_birth,
            eligibility_assessment_paris_inter_sv.decedent_date_of_death,
            eligibility_assessment_paris_inter_sv.decedent_recorded_state_code,
            eligibility_assessment_paris_inter_sv.decedent_residence_county,
			eligibility_assessment_paris_inter_sv.support_order_date_established,
			eligibility_assessment_paris_inter_sv.support_order_date_modified,
			eligibility_assessment_paris_inter_sv.support_order_number
           FROM maxdat_support.eligibility_assessment_paris_inter_sv
        UNION
         SELECT eligibility_assessment_paris_va_sv.cust_name AS client_name,
            eligibility_assessment_paris_va_sv.client_ssn,
            eligibility_assessment_paris_va_sv.client_dob,
            eligibility_assessment_paris_va_sv.dcn,
            eligibility_assessment_paris_va_sv.ref_case_id,
            eligibility_assessment_paris_va_sv.ref_client_id,
            eligibility_assessment_paris_va_sv.gender,
            eligibility_assessment_paris_va_sv.marital_status,
            eligibility_assessment_paris_va_sv.client_hoh,
            eligibility_assessment_paris_va_sv.family_size,
            eligibility_assessment_paris_va_sv.gross_income,
            eligibility_assessment_paris_va_sv.citizenship_status,
            eligibility_assessment_paris_va_sv.citizen_verified,
            eligibility_assessment_paris_va_sv.alien_reg_nbr,
            eligibility_assessment_paris_va_sv.program_type,
            eligibility_assessment_paris_va_sv.aid_category,
            eligibility_assessment_paris_va_sv.case_id,
            eligibility_assessment_paris_va_sv.anniversary_date,
            eligibility_assessment_paris_va_sv.applicant_status,
            eligibility_assessment_paris_va_sv.status_date,
            eligibility_assessment_paris_va_sv.application_id,
            eligibility_assessment_paris_va_sv.app_due_date,
            eligibility_assessment_paris_va_sv.record_processing_date,
            date_trunc('day'::text, eligibility_assessment_paris_va_sv.ds_load_ts) AS ds_load_ts,
            date_trunc('month'::text, eligibility_assessment_paris_va_sv.ds_load_ts) AS ds_load_ts_month,
            eligibility_assessment_paris_va_sv.case_id_ext,
            eligibility_assessment_paris_va_sv.decedent_ssn,
            eligibility_assessment_paris_va_sv.decedent_name,
            eligibility_assessment_paris_va_sv.decedent_date_of_birth,
            eligibility_assessment_paris_va_sv.decedent_date_of_death,
            eligibility_assessment_paris_va_sv.decedent_recorded_state_code,
            eligibility_assessment_paris_va_sv.decedent_residence_county,
			eligibility_assessment_paris_va_sv.support_order_date_established,
			eligibility_assessment_paris_va_sv.support_order_date_modified,
			eligibility_assessment_paris_va_sv.support_order_number
           FROM maxdat_support.eligibility_assessment_paris_va_sv) uclient
with no data;



REFRESH MATERIALIZED view maxdat_support.eligibility_assessment_client_sv;
CREATE INDEX eligibility_assessment_client_sv_record_processing_date_idx ON maxdat_support.eligibility_assessment_client_sv (record_processing_date);


GRANT ALL ON TABLE maxdat_support.eligibility_assessment_client_sv TO maxdat_support;
GRANT ALL ON TABLE maxdat_support.eligibility_assessment_client_sv TO maxdat_reports;

ALTER TABLE maxdat_support.eligibility_assessment_client_sv OWNER TO maxdat_support;





