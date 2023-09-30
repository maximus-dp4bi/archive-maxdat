DROP VIEW MAXDAT_SUPPORT.LTC_MEMBER_ENROLLMENT_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.LTC_MEMBER_ENROLLMENT_SV
AS
SELECT
t2.medicaid_id,
                         t2.last_name,
                         t2.first_name,
                         t2.MA_MB_17_095,
                         t2.Start_date,
                         t2.End_date,
                         t2.ac_tc,
                         t2.eligibility_start_date,
                         t2.eligibility_end_date,
                         t2.ON_HOLD_START_DATE,
                         t2.county_code,
                         t2.county_name,
t2.member_rank
FROM
(
SELECT
t1.medicaid_id,
                         t1.last_name,
                         t1.first_name,
                         t1.MA_MB_17_095,
                         t1.Start_date,
                         t1.End_date,
                         t1.ac_tc,
                         t1.eligibility_start_date,
                         t1.eligibility_end_date,
                         t1.ON_HOLD_START_DATE,
                         t1.county_code,
                         t1.county_name,
      RANK () OVER (PARTITION BY t1.medicaid_id ORDER BY t1.start_date) member_rank
            FROM (SELECT DISTINCT
                         clnt.clnt_cin medicaid_id,
                         CLNT.CLNT_LNAME last_name,
                         clnt.clnt_fname first_name,
                         'MA/MB' MA_MB_17_095,
                         esad.start_date Start_date,
                         esad.end_date End_date,
                         ESAD1.SEGMENT_DETAIL_VALUE_1 ||'-'|| ESAD1.SEGMENT_DETAIL_VALUE_2 ac_tc,
                         esad1.start_date eligibility_start_date,
                         esad1.end_date eligibility_end_date,
                         TRUNC (CENS.START_DATE) ON_HOLD_START_DATE,
                         county.VALUE county_code,
                         county.Description county_name
                    FROM client_elig_status cels
                         INNER JOIN elig_segment_and_details esad
                         ON esad.client_id = cels.client_id
                               AND ESAD.SEGMENT_TYPE_CD = 'OHC'
                               AND esad.segment_detail_value_1 IN ('MA', 'MB')
                               AND esad.end_nd = 20501231
                         INNER JOIN client clnt ON clnt.clnt_client_id = cels.client_id
                         INNER JOIN elig_segment_and_details esad1 ON esad1.segment_type_cd = 'ME'
                               AND esad1.client_id = cels.client_id
                               AND esad1.end_nd >= TO_CHAR (SYSDATE, 'YYYYMMDD')
                               AND ESAD1.SEGMENT_DETAIL_VALUE_2 = '550'
                         INNER JOIN client_enroll_status cens ON cens.enroll_status_cd = 'A+'
                               AND cens.end_date IS NULL
                               AND cens.client_id = cels.client_id
                         INNER JOIN case_client CSE_CLNT ON CSE_CLNT.CSCL_CLNT_CLIENT_ID = cels.client_id
                               AND cse_clnt.cscl_status_cd = 'O'
                         INNER JOIN address addr ON cse_clnt.cscl_res_addr_id = addr.addr_id
                         INNER JOIN enum_county county ON county.VALUE = addr.addr_ctlk_id
                  UNION
                  SELECT DISTINCT
                         clnt.clnt_cin medicaid_id,
                         CLNT.CLNT_LNAME last_name,
                         clnt.clnt_fname first_name,
                         '17-095' MA_MB_17_095,
                         esad.start_date Start_date,
                         esad.end_date End_date,
                         ESAD1.SEGMENT_DETAIL_VALUE_1 ||'-'|| ESAD1.SEGMENT_DETAIL_VALUE_2 ac_tc,
                         esad1.start_date eligibility_start_date,
                         esad1.end_date eligibility_end_date,
                         TRUNC (CENS.START_DATE) ON_HOLD_START_DATE,
                         county.VALUE county_code,
                          county.Description county_name
                    FROM client_elig_status cels
                         INNER JOIN elig_segment_and_details esad ON esad.client_id = cels.client_id
                               AND ESAD.SEGMENT_TYPE_CD = 'ME'
                               AND esad.segment_detail_value_1 IN ('17')
                               AND esad.segment_detail_value_2 IN ('095')
                               AND esad.end_nd = 20501231
                         INNER JOIN client clnt ON clnt.clnt_client_id = cels.client_id
                         INNER JOIN elig_segment_and_details esad1 ON esad1.segment_type_cd = 'ME'
                               AND esad1.client_id = cels.client_id
                               AND esad1.end_nd >= TO_CHAR (SYSDATE, 'YYYYMMDD')
                               AND ESAD1.SEGMENT_DETAIL_VALUE_2 = '550'
                         INNER JOIN client_enroll_status cens ON cens.enroll_status_cd = 'A+'
                               AND cens.end_date IS NULL
                               AND cens.client_id = cels.client_id
                         INNER JOIN case_client CSE_CLNT ON CSE_CLNT.CSCL_CLNT_CLIENT_ID = cels.client_id
                               AND cse_clnt.cscl_status_cd = 'O'
                         INNER JOIN address addr ON cse_clnt.cscl_res_addr_id = addr.addr_id
                         INNER JOIN enum_county county ON county.VALUE = addr.addr_ctlk_id
) t1
) t2
WHERE t2.member_rank = 1
ORDER BY 1;

GRANT SELECT ON MAXDAT_SUPPORT.LTC_MEMBER_ENROLLMENT_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.LTC_MEMBER_ENROLLMENT_SV TO MAXDAT_SUPPORT_READ_ONLY;
