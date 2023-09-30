CREATE OR REPLACE VIEW maxdat_support.eligibility_assessment_paris_va_sv
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
    rep1.ssn,
    rep1.date_of_birth,
    rep1.state_name,
    rep1.beneficiary_name,
    rep1.beneficiary_ssn,
    rep1.address_type_indicator,
    rep1.address_name_fid,
    rep1.address_fid_type,
    rep1.address_name_beneficiary,
    rep1.corporate_format_address_1,
    rep1.corporate_format_address_2,
    rep1.corporate_format_address_3,
    rep1.corporate_format_city_name,
    rep1.corporate_format_state_name,
    rep1.corporate_format_zip_code_prefix,
    rep1.corporate_format_zip_suffix,
    rep1.corporate_format_country_type_name,
    rep1.corporate_format_foreign_postal_code,
    rep1.corporate_format_province_name,
    rep1.corporate_format_territory_name,
    rep1.corporate_format_military_postal_type,
    rep1.corporate_format_military_post_office,
    rep1.ref_ds_data_rec_id,
    rep1.ref_client_id,
    rep1.ds_type_cd,
    rep1.ref_case_id,
    rep1.ref_elig_category_cd,
    rep1.ref_ds_type_cd,
    rep1.award_type_code,
    rep1.award_line_type_code,
    rep1.award_status_code,
    rep1.gross_amount,
    rep1.payment_amount,
    rep1.last_paid_date,
    rep1.effective_date,
    rep1.frequency_pay_type_code,
    rep1.beneficiary_annual_csr_amount,
    rep1.beneficiary_annual_mlty_amount,
    rep1.beneficiary_annual_rrb_amount,
    rep1.beneficiary_annual_bl_amount,
    rep1.spouse_annual_csr_amount,
    rep1.spouse_annual_mlty_amount,
    rep1.spouse_annual_rrb_amount,
    rep1.spouse_annual_bl_amount,
    rep1.gross_mthly_hh_income,
    rep1.income_guideline,
    rep1.reported_household_size,
    rep1.fsd_total_reported_household_income,
    rep1.reportable_income_threshold,
    rep1.min_income_threshold,
    rep1.remainder_amount,
    rep1.reportable_remainder_threshold,
    rep1.income_amount,
    rep1.added_monthly_amount,
    rep1.income_frequency,
    rep1.payee_type_code,
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
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN ddr.gross_mthly_hh_income::character varying
                    WHEN ddr.elig_category_cd::text = 'DEATH'::text 
					THEN concat_ws('/'::character varying::text, "substring"(vr.decedent_date_of_death::text, 1, 2),"substring"(vr.decedent_date_of_death::text, 3, 2), "substring"(vr.decedent_date_of_death::text, 5, 4))::character varying 
                    ELSE dsv.corporate_format_state_name
                END AS verified_source_reported_data,
			---- MMDDYYYY
            concat_ws('/'::character varying::text, "substring"(dsv.file_date::text, 5, 2), "substring"(dsv.file_date::text, 1, 4)) AS verified_source_file_date,
            ddr.ds_type_cd AS verified_source_name,
            dsv.file_date,
            ddr.create_ts::date AS record_processing_date,
            concat_ws(' '::text, dsv.client_first_name::text, dsv.client_surname::text) AS client_name,
            dsv.client_ssn AS ssn,
            dsv.client_date_of_birth AS date_of_birth,
            dsv.state_name,
            concat_ws(' '::text, dsv.first_name::text, dsv.middle_name::text, dsv.last_name::text) AS beneficiary_name,
            dsv.beneficiary_ssn,
            dsv.address_type_indicator,
            dsv.address_name_fid,
            dsv.address_fid_type,
            dsv.address_name_beneficiary,
            dsv.corporate_format_address_line_one AS corporate_format_address_1,
            dsv.corporate_format_address_line_two AS corporate_format_address_2,
            dsv.corporate_format_address_line_three AS corporate_format_address_3,
            dsv.corporate_format_city_name,
            dsv.corporate_format_state_name,
            dsv.corporate_format_zip_code_prefix,
            dsv.corporate_format_zip_suffix,
            dsv.corporate_format_country_type_name,
            dsv.corporate_format_foreign_postal_code,
            dsv.corporate_format_province_name,
            dsv.corporate_format_territory_name,
            dsv.corporate_format_military_postal_type,
            dsv.corporate_format_military_post_office,
            ddr.ds_data_rec_id AS ref_ds_data_rec_id,
            ddr.client_id AS ref_client_id,
            ddr.ds_type_cd,
            ddr.case_id AS ref_case_id,
            ddr.elig_category_cd AS ref_elig_category_cd,
            ddr.ds_type_cd AS ref_ds_type_cd,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.award_type_code
                    ELSE NULL::character varying
                END AS award_type_code,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.award_line_type_code
                    ELSE NULL::character varying
                END AS award_line_type_code,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.award_status_code
                    ELSE NULL::character varying
                END AS award_status_code,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.gross_amount
                    ELSE NULL::numeric
                END AS gross_amount,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.payment_amount
                    ELSE NULL::numeric
                END AS payment_amount,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.last_paid_date
                    ELSE NULL::character varying
                END AS last_paid_date,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.effective_date
                    ELSE NULL::character varying
                END AS effective_date,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.frequency_pay_type_code
                    ELSE NULL::character varying
                END AS frequency_pay_type_code,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.beneficiary_annual_csr_amount
                    ELSE NULL::numeric
                END AS beneficiary_annual_csr_amount,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.beneficiary_annual_mlty_amount
                    ELSE NULL::numeric
                END AS beneficiary_annual_mlty_amount,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.beneficiary_annual_rrb_amount
                    ELSE NULL::numeric
                END AS beneficiary_annual_rrb_amount,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.beneficiary_annual_bl_amount
                    ELSE NULL::numeric
                END AS beneficiary_annual_bl_amount,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.spouse_annual_csr_amount
                    ELSE NULL::numeric
                END AS spouse_annual_csr_amount,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.spouse_annual_mlty_amount
                    ELSE NULL::numeric
                END AS spouse_annual_mlty_amount,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.spouse_annual_rrb_amount
                    ELSE NULL::numeric
                END AS spouse_annual_rrb_amount,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN dsv.spouse_annual_bl_amount
                    ELSE NULL::numeric
                END AS spouse_annual_bl_amount,
            ddr.gross_mthly_hh_income,
                CASE
                    WHEN ddr.elig_category_cd::text = 'INCOME'::text THEN
                    CASE
                        WHEN cc.program_cd::text = ANY (ARRAY['TA'::character varying, 'FS'::character varying, 'CC'::character varying]::text[]) THEN cc.program_cd
                        WHEN cc.cscl_adlk_id::text ~~ '%SMB2'::text THEN 'SLMB2'::character varying
                        WHEN cc.cscl_adlk_id::text ~~ '%SMB1'::text THEN 'SLMB1'::character varying
                        WHEN cc.cscl_adlk_id::text ~~ '%QMB'::text THEN 'QMB'::character varying
                        ELSE ac.scope
                    END
                    ELSE NULL::character varying
                END AS income_guideline,
            ddr.fsd_hh_size AS reported_household_size,
            ddr.fsd_total_hh_income_adm AS fsd_total_reported_household_income,
            ddr.reportable_income_threshold,
            ddr.min_income_threshold_adm AS min_income_threshold,
            ddr.remainder_amt_adm AS remainder_amount,
            ddr.reportable_remainder_threshold_adm AS reportable_remainder_threshold,
            ddr.income_amount,
            ddr.mthly_amount AS added_monthly_amount,
            ddr.income_frequency,
            dsv.payee_type_code,
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
                    q1.ds_data_rec_id,
                    q1.ds_type_cd,
                    q1.ds_id,
                    q1.elig_category_cd,
                    q1.client_id,
                    q1.gross_mthly_hh_income,
                    q1.fsd_hh_size,
                    q1.fsd_total_hh_income_adm,
                    q1.reportable_income_threshold,
                    q1.min_income_threshold_adm,
                    q1.remainder_amt_adm,
                    q1.reportable_remainder_threshold_adm,
                    q1.income_amount,
                    q1.mthly_amount,
                    q1.income_frequency,
                    q1.create_ts,
                    q1.rank
                   FROM ( SELECT dd.ds_data_rec_id AS ddr_id,
                            dd.case_id,
                            de.ds_data_rec_id,
                            de.ds_type_cd,
                            de.ds_id,
                            de.elig_category_cd,
                            de.client_id,
                            de.gross_mthly_hh_income,
                            de.fsd_hh_size,
                            de.fsd_total_hh_income_adm,
                            de.reportable_income_threshold,
                            de.min_income_threshold_adm,
                            de.remainder_amt_adm,
                            de.reportable_remainder_threshold_adm,
                            de.income_amount,
                            de.mthly_amount,
                            de.income_frequency,
                            de.create_ts,
                            rank() OVER (PARTITION BY dd.case_id ORDER BY dd.create_ts DESC) AS rank
                           FROM eb.ds_data_rec dd
                             JOIN eb.data_request dr ON dd.data_request_id = dr.data_request_id
                             JOIN ( SELECT dee.ds_data_rec_id,
                                    din.source_cd AS ds_type_cd,
                                    din.ds_id,
                                    'INCOME'::character varying AS elig_category_cd,
                                    din.client_id,
                                    dee.gross_mthly_hh_income,
                                    dee.fsd_hh_size,
                                    dee.fsd_total_hh_income_adm,
                                    dee.reportable_income_threshold,
                                    dee.min_income_threshold_adm,
                                    dee.remainder_amt_adm,
                                    dee.reportable_remainder_threshold_adm,
                                    din.amount AS income_amount,
                                    din.mthly_amount,
                                    eif.description AS income_frequency,
                                    dee.create_ts
                                   FROM eb.ds_elig_eval_status dee
                                     JOIN eb.ds_income din ON din.ds_data_rec_id = dee.ds_data_rec_id
                                     LEFT JOIN eb.enum_ds_income_frequency eif 
									   ON eif.value::text = din.frequency_cd::text
									 left join eb.ds_data_rec_childsupport cs1 
									   on cs1.ds_data_rec_childsupport_id = din.ds_id
                                  WHERE (din.source_cd::text = 
								    ANY (ARRAY['PARISVA'::character varying,'CHILDSUPPORT'::character varying, 'VITALRECORD'::character varying]::text[])) 
								  AND (dee.reason_cd::text ~~ '%INCOME_OVER_LIMIT%'::text 
								    OR dee.reason_cd::text ~~ '%CLIENT_DECEASED%'::text) 
								   AND dee.history_ind = false
                               UNION
                                 SELECT de_1.ds_data_rec_id,
                                    ex.ds_type_cd,
                                    ex.ds_id,
                                    de_1.elig_category_cd,
                                    de_1.client_id,
                                    NULL::numeric AS gross_mthly_hh_income,
                                    NULL::numeric AS fsd_hh_size,
                                    NULL::numeric AS fsd_total_hh_income_adm,
                                    NULL::numeric AS reportable_income_threshold,
                                    NULL::numeric AS min_income_threshold_adm,
                                    NULL::numeric AS remainder_amt_adm,
                                    NULL::numeric AS reportable_remainder_threshold_adm,
                                    NULL::numeric AS income_amount,
                                    NULL::numeric AS mthly_amount,
                                    NULL::character varying AS income_frequency,
                                    de_1.create_ts
                                   FROM eb.ds_elig_eval_client_status de_1
                                     JOIN eb.elig_client_status_ds_xwalk ex ON de_1.elig_eval_client_status_id = ex.elig_eval_client_status_id
                                  WHERE ex.ds_type_cd::text = ANY (ARRAY['PARISVA'::character varying, 'VITALRECORD'::character varying]::text[])) de ON dd.ds_data_rec_id = de.ds_data_rec_id
                          WHERE dr.status_cd::text = 'RECEIVED'::text) q1
                  WHERE q1.rank = 1) ddr
             JOIN eb.case_client cc ON cc.cscl_clnt_client_id = ddr.client_id AND cc.cscl_case_id = ddr.case_id 
			 AND cc.cscl_status_cd::text = 'O'::text
             LEFT JOIN eb.client cl ON ddr.client_id = cl.clnt_client_id
             LEFT JOIN eb.cases c ON ddr.case_id = c.case_id
             LEFT JOIN eb.ds_data_rec_paris_va dsv ON dsv.ds_data_rec_paris_va_id = ddr.ds_id
             LEFT JOIN eb.ds_data_rec_vital_record vr ON vr.ds_data_rec_vital_record_id = ddr.ds_id
             LEFT JOIN eb.ds_data_rec_childsupport cs ON cs.ds_data_rec_childsupport_id = ddr.ds_id 
             LEFT JOIN eb.enum_citizen ec ON cl.clnt_citizen::text = ec.value::text
             LEFT JOIN eb.enum_gender eg ON dsv.gender_code::text = eg.value::text
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

ALTER TABLE maxdat_support.eligibility_assessment_paris_va_sv OWNER TO maxdat_support;
GRANT ALL ON TABLE maxdat_support.eligibility_assessment_paris_va_sv TO maxdat_support;
GRANT ALL ON TABLE maxdat_support.eligibility_assessment_paris_va_sv TO maxdat_reports;
