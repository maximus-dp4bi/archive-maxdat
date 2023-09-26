CREATE OR REPLACE VIEW maxdat_support.eligibility_assessment_bendex_sv
AS select drr.load_ts ds_load_ts, rep1.* from
( select concat(cl.clnt_fname, ' ', cl.clnt_lname) AS client_name,
    cl.clnt_ssn AS client_ssn,
    cl.clnt_dob AS client_dob,
    cl.clnt_generic_field8_txt AS client_hoh,
    c.case_generic_field3_num AS family_size,
    cl.clnt_cin AS dcn,
    c.case_generic_field4_num AS gross_income,
    cc.cscl_case_id AS case_id,
    ec.report_label AS citizenship_status,
    eg.report_label AS gender,
    cl.clnt_generic_field5_txt AS citizen_verified,
    ms.description AS marital_status,
    cl.clnt_generic_field6_txt AS alien_reg_nbr,
    cc.program_cd AS program_type,
    cc.cscl_adlk_id AS aid_category,
    c.anniversary_dt AS anniversary_date,
    cc.cscl_generic_field5_txt AS applicant_status,
    cc.cscl_generic_field1_date AS status_date,
    c.case_cin AS application_id,
    c.case_generic_field1_date AS app_due_date,
    de.elig_category_cd AS exception_category,
    ddr.data_payload AS reported_data,
    dee.type_cd AS death_match,
    dsb.date_of_birth AS dob,
    dsb.beneficiary_date_of_death AS dod,
    dee.type_cd AS source_out_of_state,
    concat(dsb.bgn_beneficiary_given_name, ' ', dsb.bmn_beneficiary_middle_name, ' ', dsb.bln_beneficiary_last_name) AS beneficiary,
    dsb.sex,
    dsb.ssn,
    dsb.can_ssn,
    dsb.bic AS old_bic,
    dsb.payee_name_and_address_line_1 AS payee_name_address_1,
    dsb.payee_name_and_address_line_2 AS payee_name_address_2,
    dsb.payee_name_and_address_line_3 AS payee_name_address_3,
    dsb.payee_name_and_address_line_4 AS payee_name_address_4,
    dsb.payee_name_and_address_line_5 AS payee_name_address_5,
    dsb.payee_name_and_address_line_6 AS payee_name_address_6,
    dsb.zip_code AS payee_zip_code,
    dsb.state_and_county_code AS payee_state_county,
    dsb.agency_code,
    dsb.source_code AS source_unearned_income,
    dsb.category_of_assistance_code AS assistance_category,
    dsb.state_control_data,
    di.amount AS reported_income,
    dsb.gross_amount_payable_mba AS gross_amount_payable,
    dsb.verified_boan,
    dsb.dual_entitlement_ssn AS dual_ssn,
    dsb.dual_entitlement_bic AS dual_bic,
    dsb.dual_entitlement_indicator AS dual_indicator,
    dsb.triple_entitlement_ssn AS triple_ssn,
    dsb.triple_entitlement_bic AS triple_bic,
    dsb.cross_reference_ssn AS cross_ref_ssn,
    dsb.cross_reference_bic AS cross_ref_bic,
    dsb.retro_payment_amount,
    dsb.doei_date_of_entitlement_initial AS date_of_enroll_initial,
    dsb.doec_date_of_entitlement_current AS date_of_enroll_current,
    dsb.ddo_date_of_disability_onset AS date_of_disability_onset,
    dsb.ending_date_for_op_ded AS end_date_op_ded,
    dsb.ssi_ent_term_date AS ssi_term_date,
    dsb.payment_status_code_laf AS payment_status_code,
    dsb.monthly_benefit_payable_mbp AS monthly_benefit_payable,
    dsb.net_monthly_benefit_amount_mbc AS net_benefit_amount,
    dsb.monthly_op_deduction_amt AS monthly_deduct_amt,
    dsb.garnishment_amount_withheld AS garnishment_amt,
	dsb.smi_premium_amount AS smi_premium_amount,
	dsb.ssi_overpayment_amt_withheld as ssi_overpayment_amt,
    dsb.first_hi_start_date as first_hi_start_date,
    dsb.first_hi_term_date as first_hi_term_date,
    dsb.hi_premium_amount as hi_premium_amount,
    dsb.first_smi_start_date,
    dsb.first_smi_term_date,
    dsb.variable_smi_premium,
    dsb.variable_smi_start_date,
    dsb.variable_smi_term_date,
    dsb.ssi_status_code,
    dsb.rr_claim_number AS rr_claim_nbr,
    dsb.rr_status_code,
	cast (ddr.data_payload as varchar) as Consumer_Reported_Data,
	cast (dsv.state_name as varchar) AS verified_source_reported_data,
	cast (dsv.file_date as varchar) AS verified_source_file_date,
	cast (ex.ds_type_cd as varchar) AS verified_source_name,
	ddr.ds_data_rec_id ref_ds_data_rec_id,
	de.client_id ref_client_id,
	ds_type_cd,
	ddr.case_id ref_case_id,
	de.elig_category_cd ref_elig_category_cd,
	ex.ds_type_cd ref_ds_type_cd
    from eb.ds_elig_eval_client_status              de
	LEFT OUTER JOIN eb.client cl ON de.client_id = cl.clnt_client_id
    LEFT OUTER JOIN eb.case_client cc ON cc.cscl_appl_client_id = de.client_id
    LEFT OUTER JOIN eb.cases c ON cc.cscl_case_id = c.case_id
    LEFT OUTER JOIN eb.ds_income di ON de.client_id = di.client_id AND di.type_cd::text = 'UNEARNED'::text
    LEFT OUTER JOIN eb.ds_data_rec                  ddr        on  de.ds_data_rec_id = ddr.ds_data_rec_id
    LEFT OUTER JOIN eb.elig_client_status_ds_xwalk  ex         on  de.elig_eval_client_status_id                 = ex.elig_eval_client_status_id
    LEFT OUTER JOIN eb.ds_data_rec_bendex           dsb        on  dsb.ds_data_rec_bendex_id                     = ex.ds_id and ex.ds_type_cd = 'BENDEX'
    LEFT OUTER JOIN eb.ds_data_rec_dept_correction  dsd        on  dsd.ds_data_rec_dept_correction_id            = ex.ds_id and ex.ds_type_cd = 'DEPTCORRECTION'      
    LEFT OUTER JOIN eb.ds_data_rec_paris_fed        dsf        on  dsf.ds_data_rec_paris_fed_id                  = ex.ds_id and ex.ds_type_cd = 'PARISFED'
    LEFT OUTER JOIN eb.ds_data_rec_paris_inter      dsi        on  dsi.ds_data_rec_paris_inter_id                = ex.ds_id and ex.ds_type_cd = 'PARISINTER'
    LEFT OUTER JOIN eb.ds_data_rec_paris_va         dsv        on  dsv.ds_data_rec_paris_va_id                   = ex.ds_id and ex.ds_type_cd = 'PARISVA'
    LEFT OUTER JOIN eb.ds_data_rec_vital_record     dsr        on  dsr.ds_data_rec_vital_record_id               = ex.ds_id and ex.ds_type_cd = 'VITALRECORD'
	LEFT OUTER JOIN eb.enum_citizen ec ON cl.clnt_citizen::text = ec.value::text
    LEFT OUTER JOIN eb.enum_gender eg ON cl.clnt_gender_cd::text = eg.value::text
    LEFT OUTER JOIN eb.enum_marital_status ms ON cl.clnt_marital_cd::text = ms.value::text
    LEFT OUTER JOIN eb.ds_elig_eval_status dee ON c.case_id = dee.case_id
    where ddr.ds_data_rec_id in (
              select q1.ds_data_rec_id from 
              (select dd.ds_data_rec_id,  rank() over (partition by dd.case_id order by dd.create_ts desc) 
              from eb.ds_data_rec dd
              inner join eb.data_request dr on dd.data_request_id = dr.data_request_id
              where dr.status_cd = 'RECEIVED') q1
              where q1.rank = 1
       )
) rep1
left outer join 
(      select distinct drri.load_ts, drri.ds_data_rec_id, drri.client_id, drri.ds_id 
       from eb.data_request_respstatus drri
       where drri.match_status_cd = 'MATCHED'
) drr on  rep1.ref_ds_data_rec_id = drr.ds_data_rec_id and rep1.ref_client_id = drr.client_id and rep1.ds_type_cd = drr.ds_id
order by rep1.ref_case_id, rep1.ref_client_id, rep1.ref_elig_category_cd, rep1.ref_ds_type_cd;

GRANT ALL ON TABLE  eligibility_assessment_bendex_sv to maxdat_reports;
