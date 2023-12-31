CREATE OR REPLACE VIEW maxdat_support.eligibility_assessment_paris_inter_sv
AS SELECT drr.load_ts AS ds_load_ts,
    rep1.cust_name,
    rep1.client_ssn,
    rep1.client_dob,
    rep1.client_hoh,
    rep1.family_size,
    rep1.dcn,
    rep1.gross_income,
    rep1.case_id,
    rep1.citizenship_status,
    rep1.gender,
    rep1.citizen_verified,
    rep1.marital_status,
    rep1.alien_reg_nbr,
    rep1.program_type,
    rep1.aid_category,
    rep1.anniversary_date,
    rep1.applicant_status,
    rep1.status_date,
    rep1.application_id,
    rep1.app_due_date,
    rep1.exception_category,
    rep1.verified_source_reported_data,
    rep1.verified_source_file_date,
    rep1.verified_source_name,
    rep1.file_date,
    rep1.record_processing_date,
    rep1.client_name,
    rep1.date_of_birth,
    rep1.sex,
    rep1.ssn,
    rep1.state_name,
    rep1.address_line_1,
    rep1.address_line_2,
    rep1.address_city,
    rep1.address_state,
    rep1.address_zip_code,
    rep1.contact_supported_phone,
    rep1.contact_supported_fax,
    rep1.contact_supported_email,
    rep1.contact_person_phone_number,
    rep1.contact_person_phone_number_extension,
    rep1.contact_person_fax_number,
    rep1.contact_person_email_address,
    rep1.ref_ds_data_rec_id,
    rep1.ref_client_id,
    rep1.ds_type_cd,
    rep1.ref_case_id,
    rep1.ref_elig_category_cd,
    rep1.ref_ds_type_cd,
    rep1.case_number,
    rep1.tanf_months_eligibility,
    rep1.tanf_indicator,
    rep1.general_assistance_indicator,
    rep1.food_stamp_indicator,
    rep1.medicaid_indicator,
    rep1.child_care_indicator,
    rep1.workers_comp_indicator,
    rep1.tanf_elig_start_date,
    rep1.tanf_elig_end_date,
    rep1.medicaid_elig_start_date,
    rep1.medicaid_elig_end_date,
    rep1.food_stamps_eligibility_start_date,
    rep1.food_stamps_eligibility_end_date,
    rep1.child_care_elig_start_date,
    rep1.child_care_elig_end_date,
    rep1.workers_comp_elig_start_date,
    rep1.workers_comp_elig_end_date,
    rep1.workers_comp_pay_amount,
    rep1.ma_contact_person_information,
    rep1.gross_mthly_hh_income,
    rep1.aid_category_desc,
    rep1.case_id_ext,
    rep1.decedent_ssn,
    rep1.decedent_name,
    rep1.decedent_date_of_birth,
    rep1.decedent_date_of_death,
    rep1.decedent_recorded_state_code,
    rep1.decedent_residence_county,
    rep1.disburse_alloc_age_type,
    rep1.disburse_alloc_debt_type_code,
    rep1.disburse_date_disbursed,
    rep1.oblig_debt_type,
    rep1.disbursement_amount,
    rep1.member_effective_date,
    rep1.header_iv_d_case_id,
    rep1.header_iv_d_case_type,
    rep1.member_1_dcn,
    rep1.member_1_first_name,
    rep1.member_1_last_name,
    rep1.member_1_middle_name,
    rep1.member_1_participation_code,
    rep1.member_2_dcn,
    rep1.member_2_first_name,
    rep1.member_2_last_name,
    rep1.member_2_middle_name,
    rep1.member_2_participation_code,
    rep1.member_3_dcn,
    rep1.member_3_first_name,
    rep1.member_3_last_name,
    rep1.member_3_middle_name,
    rep1.member_3_participation_code,
    rep1.oblig_member_covered_dcn,
    rep1.oblig_member_covered_first_name,
    rep1.oblig_member_covered_last_name,
    rep1.oblig_member_covered_mid_name,
    rep1.header_multiple_iv_a_case_sw,
    rep1.header_multiple_iv_d_case_sw,
    rep1.oblig_payment_recip_dcn,
    rep1.oblig_payment_recip_first_name,
    rep1.oblig_payment_recip_last_name,
    rep1.oblig_payment_recip_middle_name,
    rep1.obligation_amount,
    rep1.obligation_arrears_balance,
    rep1.obligation_effective_date,
    rep1.obligation_end_date,
    rep1.obligation_payment_due_date,
    rep1.obligation_payment_frequency,
    rep1.disburse_recipient_dcn_no,
    rep1.disburse_recipient_first_name,
    rep1.disburse_recipient_last_name,
    rep1.disburse_recipient_mid_name,
    rep1.support_order_date_established,
    rep1.support_order_date_modified,
    rep1.support_order_number
   FROM ( SELECT concat_ws(' '::text, cl.clnt_fname::text, cl.clnt_lname::text) AS cust_name,
            cl.clnt_ssn AS client_ssn,
            cl.clnt_dob::date AS client_dob,
            cl.clnt_generic_field8_txt AS client_hoh,
            c.case_generic_field3_num AS family_size,
            cl.clnt_cin AS dcn,
            c.case_generic_field4_num AS gross_income,
            c.case_cin AS case_id,
            ec.report_label AS citizenship_status,
            eg.report_label AS gender,
            cl.clnt_generic_field5_txt AS citizen_verified,
            ms.description AS marital_status,
            cl.clnt_generic_field6_txt AS alien_reg_nbr,
            cc.program_cd AS program_type,
            cc.cscl_adlk_id AS aid_category,
            c.anniversary_dt::date AS anniversary_date,
            ers.description AS applicant_status,
            cc.cscl_generic_field1_date::character varying AS status_date,
            c.case_generic_field6_txt AS application_id,
            c.case_generic_field1_date::date AS app_due_date,
            ddr.elig_category_cd AS exception_category,
            dsi.state_name AS verified_source_reported_data,
            concat_ws('/'::character varying::text, "substring"(dsi.file_date::text, 5, 2), "substring"(dsi.file_date::text, 1, 4)) AS verified_source_file_date,
            ddr.ds_type_cd AS verified_source_name,
            dsi.file_date,
            ddr.create_ts::date AS record_processing_date,
            concat_ws(' '::text, dsi.client_first_name::text, dsi.client_surname::text) AS client_name,
            dsi.client_date_of_birth::character varying AS date_of_birth,
            eg.report_label AS sex,
            dsi.client_ssn::character varying AS ssn,
            dsi.state_name,
            dsi.address_line1 AS address_line_1,
            dsi.address_line2 AS address_line_2,
            dsi.address_city,
            dsi.address_state,
            dsi.address_zip_code,
            dsi.contact_supported_phone,
            dsi.contact_supported_fax,
            dsi.contact_supported_email,
            dsi.contact_person_phone_number,
            dsi.contact_person_phone_number_extension,
            dsi.contact_person_fax_number,
            dsi.contact_person_email_address,
            ddr.ds_data_rec_id AS ref_ds_data_rec_id,
            ddr.client_id AS ref_client_id,
            ddr.ds_type_cd,
            ddr.case_id AS ref_case_id,
            ddr.elig_category_cd AS ref_elig_category_cd,
            ddr.ds_type_cd AS ref_ds_type_cd,
            dsi.case_number,
            dsi.tanf_months_eligibility,
            dsi.tanf_indicator,
            dsi.general_assistance_indicator,
            dsi.food_stamp_indicator,
            dsi.medicaid_indicator,
            dsi.child_care_indicator,
            dsi.workers_comp_indicator,
            dsi.tanf_elig_start_date,
            dsi.tanf_elig_end_date,
            dsi.medicaid_elig_start_date,
            dsi.medicaid_elig_end_date,
            dsi.food_stamps_eligibility_start_date,
            dsi.food_stamps_eligibility_end_date,
            dsi.child_care_elig_start_date,
            dsi.child_care_elig_end_date,
            dsi.workers_comp_elig_start_date,
            dsi.workers_comp_elig_end_date,
            dsi.workers_comp_pay_amount,
            dsi.ma_contact_person_information,
            ddr.gross_mthly_hh_income,
            concat_ws('-'::text, ac.value::text, ac.report_label::text) AS aid_category_desc,
            c.case_generic_field5_txt AS case_id_ext,
            vr.decedent_ssn,
            concat_ws(' '::text, vr.decedent_first_name, vr.decedent_last_name, vr.decedent_name_suffix) AS decedent_name,
            vr.decedent_date_of_birth,
            vr.decedent_date_of_death,
            vr.decedent_recorded_state_code,
            vr.decedent_residence_county,
            cs.disburse_alloc_age_type,
            cs.disburse_alloc_debt_type_code,
            cs.disburse_date_disbursed,
            cs.oblig_debt_type,
            cs.disbursement_amount,
            cs.member_effective_date,
            cs.header_iv_d_case_id,
            cs.header_iv_d_case_type,
            cs.member_1_dcn,
            cs.member_1_first_name,
            cs.member_1_last_name,
            cs.member_1_middle_name,
            cs.member_1_participation_code,
            cs.member_2_dcn,
            cs.member_2_first_name,
            cs.member_2_last_name,
            cs.member_2_middle_name,
            cs.member_2_participation_code,
            cs.member_3_dcn,
            cs.member_3_first_name,
            cs.member_3_last_name,
            cs.member_3_middle_name,
            cs.member_3_participation_code,
            cs.oblig_member_covered_dcn,
            cs.oblig_member_covered_first_name,
            cs.oblig_member_covered_last_name,
            cs.oblig_member_covered_mid_name,
            cs.header_multiple_iv_a_case_sw,
            cs.header_multiple_iv_d_case_sw,
            cs.oblig_payment_recip_dcn,
            cs.oblig_payment_recip_first_name,
            cs.oblig_payment_recip_last_name,
            cs.oblig_payment_recip_middle_name,
            cs.obligation_amount,
            cs.obligation_arrears_balance,
            cs.obligation_effective_date,
            cs.obligation_end_date,
            cs.obligation_payment_due_date,
            cs.obligation_payment_frequency,
            cs.disburse_recipient_dcn_no,
            cs.disburse_recipient_first_name,
            cs.disburse_recipient_last_name,
            cs.disburse_recipient_mid_name,
            cs.support_order_date_established,
            cs.support_order_date_modified,
            cs.support_order_number
           FROM ( SELECT q1.ddr_id,
                    q1.case_id,
                    q1.elig_eval_client_status_id,
                    q1.elig_category_cd,
                    q1.elig_eval_status_id,
                    q1.client_id,
                    q1.ds_data_rec_id,
                    q1.status_data,
                    q1.status_generic_field1_txt,
                    q1.status_generic_field2_txt,
                    q1.create_ts,
                    q1.created_by,
                    q1.update_ts,
                    q1.updated_by,
                    q1.process_ind,
                    q1.process_ts,
                    q1.report_filename,
                    q1.ds_type_cd,
                    q1.ds_id,
                    q1.gross_mthly_hh_income,
                    q1.rank
                   FROM ( SELECT dd.ds_data_rec_id AS ddr_id,
                            dd.case_id,
                            de.elig_eval_client_status_id,
                            de.elig_category_cd,
                            de.elig_eval_status_id,
                            de.client_id,
                            de.ds_data_rec_id,
                            de.status_data,
                            de.status_generic_field1_txt,
                            de.status_generic_field2_txt,
                            de.create_ts,
                            de.created_by,
                            de.update_ts,
                            de.updated_by,
                            de.process_ind,
                            de.process_ts,
                            de.report_filename,
                            ex.ds_type_cd,
                            ex.ds_id,
                            dee.gross_mthly_hh_income,
                            rank() OVER (PARTITION BY dd.case_id ORDER BY dd.create_ts DESC) AS rank
                           FROM eb.ds_data_rec dd
                             JOIN eb.data_request dr ON dd.data_request_id = dr.data_request_id
                             JOIN eb.ds_elig_eval_client_status de ON dd.ds_data_rec_id = de.ds_data_rec_id
                             JOIN eb.elig_client_status_ds_xwalk ex 
							   ON de.elig_eval_client_status_id = ex.elig_eval_client_status_id
                             LEFT JOIN eb.ds_elig_eval_status dee ON de.elig_eval_status_id = dee.elig_eval_status_id
                          WHERE dr.status_cd::text = 'RECEIVED'::text 
						  AND (ex.ds_type_cd::text = ANY (ARRAY['PARISINTER'::text, 'VITALRECORD'::text]))) q1
                  WHERE q1.rank = 1) ddr
             LEFT JOIN eb.client cl ON ddr.client_id = cl.clnt_client_id
             LEFT JOIN eb.cases c ON ddr.case_id = c.case_id
             JOIN eb.case_client cc ON cc.cscl_clnt_client_id = ddr.client_id 
			  AND cc.cscl_case_id = ddr.case_id AND cc.cscl_status_cd::text = 'O'::text
             LEFT JOIN eb.ds_data_rec_paris_inter dsi ON dsi.ds_data_rec_paris_inter_id = ddr.ds_id
             LEFT JOIN eb.ds_data_rec_vital_record vr ON vr.ds_data_rec_vital_record_id = ddr.ds_id
             LEFT JOIN eb.ds_data_rec_childsupport cs ON cs.ds_data_rec_childsupport_id = ddr.ds_id
             LEFT JOIN eb.enum_citizen ec ON cl.clnt_citizen::text = ec.value::text
             LEFT JOIN eb.enum_gender eg ON dsi.gender::text = eg.value::text
             LEFT JOIN eb.enum_marital_status ms ON cl.clnt_marital_cd::text = ms.value::text
             LEFT JOIN eb.enum_recipient_status ers ON cc.cscl_generic_field5_txt::text = ers.value::text
             LEFT JOIN eb.enum_aid_category ac ON ac.value::text = cc.cscl_adlk_id::text
          WHERE cc.cscl_status_end_date IS NULL) rep1
     LEFT JOIN ( SELECT DISTINCT drri.load_ts,
            drri.ds_data_rec_id,
            drri.client_id,
            drri.ds_id
           FROM eb.data_request_respstatus drri
          WHERE drri.match_status_cd::text = 'MATCHED'::text) drr ON rep1.ref_ds_data_rec_id = drr.ds_data_rec_id AND rep1.ref_client_id = drr.client_id AND rep1.ds_type_cd::text = drr.ds_id::text;

-- Permissions

ALTER TABLE maxdat_support.eligibility_assessment_paris_inter_sv OWNER TO maxdat_support;
GRANT ALL ON TABLE maxdat_support.eligibility_assessment_paris_inter_sv TO maxdat_support;
GRANT ALL ON TABLE maxdat_support.eligibility_assessment_paris_inter_sv TO maxdat_reports;
