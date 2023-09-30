CREATE OR REPLACE VIEW EMRS_F_ENROLLMENT_SV
AS
  SELECT COALESCE(ss.network_id,
    (SELECT MAX(network_id)
    FROM eb.network n,
      eb.provider p
    WHERE n.provider_id = p.provider_id AND p.provider_id_ext = ss.provider_id_ext
    ),0) provider_number,
    NULL AS MEDICAID_BUY_IN_FEE,
    NULL AS MEDICAID_BUY_IN_FEE_DATE,
    NULL AS MEDICAID_RECERTIFICATION_DATE,
    1 AS NUMBER_COUNT,
    ss.create_ts AS DATE_CREATED,
    ss.created_by AS CREATED_BY,
    ss.updated_by AS UPDATED_BY,
    NULL AS MET_COST_SHARE_CAP_DATE,
    NULL AS COST_SHARE_START_DATE,
    NULL AS COST_SHARE_END_DATE,
    NULL AS ENROLLMENT_FEE_FREQUENCY,
    NULL AS CHIP_ANNUAL_ENROLL_DATE,
    NULL AS SELECTION_SOURCE_ID,
    NULL AS SELECTION_REASON_ID,
    NULL AS AID_CATEGORY_ID,
    NULL AS CITIZENSHIP_ID,
    ss.selection_segment_id AS ENROLLMENT_GROUP_ID,
    ss.selection_segment_id AS SOURCE_RECORD_ID,
    NULL AS PEOPLE_IN_FAMILY,
    NULL AS ENROLLMENT_FEE_ASSESSED,
    NULL AS ENROLLMENT_FEE_ASSESSED_DATE,
    NULL AS ENROLLMENT_FEE_PAID,
    NULL AS ENROLLMENT_FEE_PAID_DATE,
    NULL AS CO_PAY_AMOUNT,
    'SELECTION_SEGMENT' AS SOURCE_TABLE_NAME,
    (SELECT LEAST(start_date,create_ts) eligibility_receipt_date
    FROM eb.elig_segment_and_details
    WHERE client_id = ss.client_id AND segment_type_cd = 'ME' AND ss.end_nd BETWEEN start_nd AND end_nd
    ) AS ELIGIBILITY_RECEIPT_DATE,
    COALESCE(
    (SELECT case_id
    FROM eb.client_supplementary_info cs
    WHERE cs.client_id = ss.client_id AND cs.program_cd = ss.program_type_cd
    ),0) AS CASE_NUMBER,
    ss.client_id AS CLIENT_NUMBER,
    ss.selection_segment_id AS ENROLLMENT_ID,
    NULL AS CHANGE_REASON_ID,
    NULL AS COMMUNICATION_TYPE_ID,
    NULL AS COUNTY_ID,
    NULL AS COVERAGE_CATEGORY_ID,
    NULL AS CSDA_ID,
    NULL AS DATE_PERIOD_ID,
    NULL AS ENROLLMENT_ACTION_STATUS_ID,
    NULL AS FPL_ID,
    NULL AS LANGUAGE_CODE_ID,
    NULL AS PLAN_ID,
    NULL AS PROGRAM_ID,
    NULL AS PROVIDER_TYPE_ID,
    NULL AS RACE_ID,
    NULL AS REJECTION_ERROR_REASON_ID,
    NULL AS RISK_GROUP_ID,
    NULL AS STAT_IN_GRP_ID,
    NULL AS SUB_PROGRAM_ID,
    NULL AS TERM_REASON_CODE_ID,
    NULL AS TIME_PERIOD_ID,
    NULL AS CERTIFICATION_DATE,
    NULL AS CSDA_CHANGE_DATE,
    ss.status_date AS ENROLLMENT_STATUS_CHANGE_DATE,
    NULL AS JYEAR_OF_LAST_ENROLLMENT_FORM,
    ss.end_date AS MANAGED_CARE_END_DATE,
    ss.start_date AS MANAGED_CARE_START_DATE,
    NULL AS PLAN_TYPE_ID,
    COALESCE(
    (SELECT clnt_citizen
    FROM eb.client cl
    WHERE cl.clnt_client_id = ss.client_id
    ),'0') citizenship_code,
    COALESCE(
    (SELECT client_language
    FROM eb.client cl
    WHERE cl.clnt_client_id = ss.client_id
    ),'0') language_code,
    COALESCE(
    (SELECT clnt_race FROM eb.client cl WHERE cl.clnt_client_id = ss.client_id
    ),'0') race_code,
    COALESCE(
    (SELECT addr_county
    FROM eb.client_supplementary_info cs
    WHERE cs.client_id = ss.client_id AND cs.program_cd = ss.program_type_cd
    ),'0') county_code,
    '0' csda_code,
    ss.program_type_cd program_code,
    ss.plan_type_cd plan_type,
    COALESCE(
    (SELECT p.plan_code FROM eb.plans p WHERE p.plan_id = ss.plan_id
    ),'0') plan_code,
    COALESCE(ss.disenroll_reason_cd_1,'0') change_reason_code,
    '0' selection_source_code,
    ss.choice_reason_cd selection_reason_code,
    '0' enrollment_action_status_code,
    (SELECT plan_service_type_cd
    FROM eb.contract ct
    WHERE ct.contract_id = ss.contract_id
    ) sub_program_code,
    --,COALESCE(tmp_provider.provider_type_code,'0') provider_code
    COALESCE(
    (SELECT type_cd
    FROM eb.provider p
    WHERE p.provider_id_ext = ss.provider_id_ext
    ),'0') provider_code,
    '0' status_in_group_code,
    '0' risk_group_code,
    '0' coverage_category_code,
    '0' aid_category_code,
    '0' reason_code, --term reason code
    '0' rejection_code
  FROM eb.selection_segment ss
  WHERE ss.create_ts >= add_months(TRUNC(sysdate,'mm'),-2); 
  
  GRANT SELECT ON MAXDAT_LOOKUP.EMRS_F_ENROLLMENT_SV TO EB_MAXDAT_REPORTS;  