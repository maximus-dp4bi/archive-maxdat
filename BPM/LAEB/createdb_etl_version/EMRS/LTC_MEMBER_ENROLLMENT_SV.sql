CREATE OR REPLACE VIEW LTC_MEMBER_ENROLLMENT_SV
AS
WITH ohc_esad AS(
SELECT *
FROM MAXDAT_LAEB.emrs_d_elig_segment_details_ohc esad 
WHERE ESAD.SEGMENT_TYPE_CD = 'OHC'
AND esad.segment_detail_value_1 IN ('MA', 'MB')
AND esad.end_nd = 20501231),
me_esad AS(
SELECT *
FROM MAXDAT_LAEB.emrs_d_elig_segment_details_me esad 
WHERE ESAD.SEGMENT_TYPE_CD = 'ME'
AND esad.segment_detail_value_1 IN ('17')
AND esad.segment_detail_value_2 IN ('095')
AND esad.end_nd = 20501231),
case_clnt AS(
SELECT cse_clnt.client_id,county.county_code,county.county_name
FROM MAXDAT_LAEB.emrs_d_case_client CSE_CLNT
  INNER JOIN MAXDAT_LAEB.emrs_d_address addr ON cse_clnt.cscl_res_addr_id = addr.addr_id
  INNER JOIN MAXDAT_LAEB.emrs_d_county county ON county.county_code = addr.addr_ctlk_id
WHERE cse_clnt.cscl_status_cd = 'O'),
me_esad1 AS(
SELECT * 
FROM MAXDAT_LAEB.emrs_d_elig_segment_details_me esad1 
WHERE esad1.segment_type_cd = 'ME'
AND esad1.end_nd >= TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMMDD'))
AND ESAD1.SEGMENT_DETAIL_VALUE_2 = '550'),
clnt_enroll AS(
SELECT * 
FROM MAXDAT_LAEB.emrs_d_client_enroll_status cens 
WHERE cens.enroll_status_cd = 'A+'
AND cens.end_date IS NULL),
clnt_elig AS (
SELECT * 
FROM MAXDAT_LAEB.emrs_d_client_eligibility cels
WHERE cels.Plan_type_cd ='MEDICAL'),
t1 AS(
SELECT DISTINCT clnt.clnt_cin medicaid_id,
  CLNT.CLNT_LNAME last_name,
  clnt.clnt_fname first_name,
  'MA/MB' MA_MB_17_095,
  esad.start_date Start_date,
  esad.end_date End_date,
  ESAD1.SEGMENT_DETAIL_VALUE_1 ||'-'|| ESAD1.SEGMENT_DETAIL_VALUE_2 ac_tc,
  esad1.start_date eligibility_start_date,
  esad1.end_date eligibility_end_date,
  TRUNC (CENS.START_DATE) ON_HOLD_START_DATE,
  cse_clnt.county_code county_code,
  cse_clnt.county_name county_name
FROM clnt_elig cels
  INNER JOIN ohc_esad esad ON esad.client_id = cels.client_id                           
  INNER JOIN emrs_d_client clnt ON clnt.client_id = cels.client_id
  INNER JOIN me_esad1 esad1 ON esad1.client_id = cels.client_id
  INNER JOIN clnt_enroll cens ON cens.client_id = cels.client_id
  INNER JOIN case_clnt CSE_CLNT ON CSE_CLNT.client_id = cels.client_id                      
UNION ALL
SELECT DISTINCT clnt.clnt_cin medicaid_id,
  CLNT.CLNT_LNAME last_name,
  clnt.clnt_fname first_name,
  '17-095' MA_MB_17_095,
  esad.start_date Start_date,
  esad.end_date End_date,
  ESAD1.SEGMENT_DETAIL_VALUE_1 ||'-'|| ESAD1.SEGMENT_DETAIL_VALUE_2 ac_tc,
  esad1.start_date eligibility_start_date,
  esad1.end_date eligibility_end_date,
  TRUNC (CENS.START_DATE) ON_HOLD_START_DATE,
  cse_clnt.county_code county_code,
  cse_clnt.county_name county_name
FROM clnt_elig cels
  INNER JOIN me_esad esad ON esad.client_id = cels.client_id                               
  INNER JOIN emrs_d_client clnt ON clnt.client_id = cels.client_id
  INNER JOIN me_esad1 esad1 ON esad1.client_id = cels.client_id                               
  INNER JOIN clnt_enroll cens ON cens.client_id = cels.client_id
  INNER JOIN case_clnt CSE_CLNT ON CSE_CLNT.client_id = cels.client_id
),
t2 AS(
SELECT *
FROM(SELECT t1.medicaid_id,
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
     FROM t1)
WHERE member_rank = 1)
SELECT  t2.medicaid_id,
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
FROM t2 
; 

grant select on LTC_MEMBER_ENROLLMENT_SV to MAXDAT_LAEB_READ_ONLY;