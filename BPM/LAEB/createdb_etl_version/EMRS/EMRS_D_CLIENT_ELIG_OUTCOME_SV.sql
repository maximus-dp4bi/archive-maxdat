CREATE OR REPLACE VIEW EMRS_D_CLIENT_ELIG_OUTCOME_SV
AS
WITH cels AS(
SELECT * FROM emrs_d_client_eligibility cels       
        WHERE cels.subprogram_type IN ('BH_ONLY')
        AND cels.end_date IS NULL),
st AS(
SELECT * FROM emrs_d_selection_txn st
WHERE ST.SELECTION_GENERIC_FIELD5_TXT = 'B'
AND st.status_cd = 'acceptedByState'
AND transaction_type_cd IN ('Transfer', 'NewEnrollment', 'DefaultEnroll')
AND TRUNC (st.status_date) = TRUNC (SYSDATE - 1) ),
clnt AS(
SELECT clnt.client_id,
       clnt.clnt_cin ,  
       CLNT.CLNT_LNAME, 
       clnt.clnt_fname,
       CLNT.CLNT_SSN,
       CLNT.CLNT_DOB,
       county.county_code,
       county.county_name
FROM MAXDAT_LAEB.emrs_d_client clnt
 INNER JOIN MAXDAT_LAEB.emrs_d_case_client CSE_CLNT  ON CSE_CLNT.client_id = clnt.client_id AND cse_clnt.cscl_status_cd = 'O'
 INNER JOIN MAXDAT_LAEB.emrs_d_address addr ON cse_clnt.cscl_res_addr_id = addr.addr_id
 INNER JOIN MAXDAT_LAEB.emrs_d_county county ON county.county_code = addr.addr_ctlk_id),
esad2 AS(
SELECT *
FROM MAXDAT_LAEB.emrs_d_elig_segment_details_me esad2
WHERE esad2.segment_type_cd = 'ME'
AND esad2.end_nd >= TO_NUMBER(TO_CHAR (SYSDATE, 'YYYYMMDD'))
AND ESAD2.SEGMENT_DETAIL_VALUE_2 = '550'),
esad1 AS(
SELECT *
FROM MAXDAT_LAEB.emrs_d_elig_segment_details_mi esad1
WHERE esad1.segment_type_cd = 'MI'
AND esad1.end_nd > esad1.start_nd),
esad_elig AS(
SELECT client_id,
  'CHISHOLM'          Eligibility_Outcome,
  esad.start_date    ME_Start_Date,
  esad.end_date      ME_End_Date
FROM   emrs_d_elig_segment_details_elig esad          
WHERE esad.segment_type_cd = 'ELIG'
AND esad.end_date > LAST_DAY (ADD_MONTHS (SYSDATE, 0)) + 1 ),
esad_ohc AS(
SELECT client_id,
  'MA/MB'            Eligibility_Outcome,
  esad.start_date    ME_Start_Date,
  esad.end_date      ME_End_Date
FROM emrs_d_elig_segment_details_ohc esad 
WHERE  esad.segment_type_cd = 'OHC'
AND esad.segment_detail_value_1 IN ('MA', 'MB')
AND esad.end_nd = 20501231),
esad_ltc AS(
SELECT client_id,
  'LTC'              Eligibility_Outcome,
  esad.start_date    ME_Start_Date,
  esad.end_date      ME_End_Date
FROM  emrs_d_elig_segment_details_ltc esad 
WHERE  esad.segment_type_cd ='LTC'
AND (esad.end_date IS NULL OR TRUNC(esad.end_date) = '31-DEC-2050') ),
esad_me AS(
SELECT client_id,
  '17/095 Medicare'  Eligibility_Outcome,
  esad.start_date   ME_Start_Date,
  esad.end_date     ME_End_Date
FROM  emrs_d_elig_segment_details_me esad 
WHERE  esad.segment_type_cd ='ME'
AND esad.end_nd >= TO_CHAR (SYSDATE, 'YYYYMMDD')
AND esad.segment_detail_value_2 = '095' )
SELECT clnt.clnt_cin      medicaid_id,
       CLNT.CLNT_LNAME    last_name,
       clnt.clnt_fname    first_name,
       CLNT.CLNT_SSN,
       CLNT.CLNT_DOB,  
       ST.SELECTION_GENERIC_FIELD5_TXT,    
       esad.eligibility_outcome,
       esad.me_start_date,
       esad.me_end_date,
       clnt.county_code county_code,
       clnt.county_name county_desc
  FROM cels
     INNER JOIN st ON st.client_id = cels.client_id
     INNER JOIN clnt ON clnt.client_id = st.client_id     
     INNER JOIN esad2 ON esad2.client_id = st.client_id       
     INNER JOIN esad1 ON esad1.client_id = st.client_id AND ESAD1.start_nd = ST.START_ND AND ESAD1.SEGMENT_DETAIL_VALUE_2 = ST.PLAN_ID_EXT       
     INNER JOIN ( SELECT *
                  FROM esad_elig esad                            
                  UNION
                  SELECT *
                  FROM esad_ohc esad                   
                  UNION
                  SELECT *
                  FROM  esad_ltc esad                   
                  UNION
                  SELECT *
                  FROM esad_me esad) esad ON esad.client_id = cels.client_id;	



grant select on EMRS_D_CLIENT_ELIG_OUTCOME_SV to MAXDAT_LAEB_READ_ONLY;