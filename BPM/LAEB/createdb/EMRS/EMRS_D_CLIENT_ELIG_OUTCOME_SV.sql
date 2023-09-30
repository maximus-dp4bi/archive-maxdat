DROP VIEW MAXDAT_SUPPORT.EMRS_D_CLIENT_ELIG_OUTCOME_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.EMRS_D_CLIENT_ELIG_OUTCOME_SV
AS
SELECT clnt.clnt_cin                   medicaid_id,
       CLNT.CLNT_LNAME                 last_name,
       clnt.clnt_fname                 first_name,
       CLNT.CLNT_SSN,
       CLNT.CLNT_DOB,
       ST.SELECTION_GENERIC_FIELD5_TXT linkage_type,
       'CHISHOLM'                      Eligibility_Outcome,
       esad.start_date                 ME_Start_Date,
       esad.end_date                   ME_End_Date,
       county.VALUE                    county_code,
       county.description              county_desc
  FROM client_elig_status cels
       INNER JOIN elig_segment_and_details esad
          ON     esad.client_id = cels.client_id
             AND ESAD.SEGMENT_TYPE_CD = 'ELIG'
             --first day of next month
             AND esad.end_date > LAST_DAY (ADD_MONTHS (SYSDATE, 0)) + 1
       INNER JOIN selection_txn st
          ON     st.client_id = cels.client_id
             AND ST.SELECTION_GENERIC_FIELD5_TXT = 'B'
             AND st.status_cd = 'acceptedByState'
             AND TRUNC (st.status_date) = TRUNC (SYSDATE - 1)
             AND cels.subprogram_type IN ('OPT_IN')
             AND cels.end_date IS NULL
       INNER JOIN client clnt ON clnt.clnt_client_id = st.client_id
       INNER JOIN case_client CSE_CLNT
          ON     CSE_CLNT.CSCL_CLNT_CLIENT_ID = st.client_id
             AND cse_clnt.cscl_status_cd = 'O'
       INNER JOIN address addr ON cse_clnt.cscl_res_addr_id = addr.addr_id
       INNER JOIN enum_county county ON county.VALUE = addr.addr_ctlk_id
       INNER JOIN elig_segment_and_details esad2
          ON     esad2.segment_type_cd = 'ME'
             AND esad2.client_id = st.client_id
             AND esad2.end_nd >= TO_CHAR (SYSDATE, 'YYYYMMDD')
             AND ESAD2.SEGMENT_DETAIL_VALUE_2 = '550'
       INNER JOIN elig_segment_and_details esad1
          ON     esad1.segment_type_cd = 'MI'
             AND esad1.client_id = st.client_id
             AND esad1.end_nd > esad1.start_nd
             AND ESAD1.start_nd = ST.START_ND
             AND ESAD1.SEGMENT_DETAIL_VALUE_2 = ST.PLAN_ID_EXT
             AND transaction_type_cd IN ('Transfer', 'NewEnrollment', 'DefaultEnroll')
UNION
SELECT clnt.clnt_cin      medicaid_id,
       CLNT.CLNT_LNAME    last_name,
       clnt.clnt_fname    first_name,
       CLNT.CLNT_SSN,
       CLNT.CLNT_DOB,
       ST.SELECTION_GENERIC_FIELD5_TXT,
       'MA/MB'            Eligibility_Outcome,
       esad.start_date    ME_Start_Date,
       esad.end_date      ME_End_Date,
       county.VALUE       county_code,
       county.description county_desc
  FROM client_elig_status cels
       INNER JOIN elig_segment_and_details esad
          ON     esad.client_id = cels.client_id
             AND ESAD.SEGMENT_TYPE_CD = 'OHC'
             AND esad.segment_detail_value_1 IN ('MA', 'MB')
             AND esad.end_nd = 20201231
       INNER JOIN selection_txn st
          ON     st.client_id = cels.client_id
             AND ST.SELECTION_GENERIC_FIELD5_TXT = 'B'
             AND st.status_cd = 'acceptedByState'
             AND TRUNC (st.status_date) = TRUNC (SYSDATE - 1)
             AND cels.subprogram_type IN ('BH_ONLY')
             AND cels.end_date IS NULL
       INNER JOIN client clnt ON clnt.clnt_client_id = st.client_id
       INNER JOIN case_client CSE_CLNT
          ON     CSE_CLNT.CSCL_CLNT_CLIENT_ID = st.client_id
             AND cse_clnt.cscl_status_cd = 'O'
       INNER JOIN address addr ON cse_clnt.cscl_res_addr_id = addr.addr_id
       INNER JOIN enum_county county ON county.VALUE = addr.addr_ctlk_id
       INNER JOIN elig_segment_and_details esad2
          ON     esad2.segment_type_cd = 'ME'
             AND esad2.client_id = st.client_id
             AND esad2.end_nd >= TO_CHAR (SYSDATE, 'YYYYMMDD')
             AND ESAD2.SEGMENT_DETAIL_VALUE_2 = '550'
       INNER JOIN elig_segment_and_details esad1
          ON     esad1.segment_type_cd = 'MI'
             AND esad1.client_id = st.client_id
             AND esad1.end_nd > esad1.start_nd
             AND ESAD1.start_nd = ST.START_ND
             AND ESAD1.SEGMENT_DETAIL_VALUE_2 = ST.PLAN_ID_EXT
             AND transaction_type_cd IN ('Transfer', 'NewEnrollment', 'DefaultEnroll')
UNION
SELECT clnt.clnt_cin      medicaid_id,
       CLNT.CLNT_LNAME    last_name,
       clnt.clnt_fname    first_name,
       CLNT.CLNT_SSN,
       CLNT.CLNT_DOB,
       ST.SELECTION_GENERIC_FIELD5_TXT,
       'LTC'              Eligibility_Outcome,
       esad.start_date    ME_Start_Date,
       esad.end_date      ME_End_Date,
       county.VALUE       county_code,
       county.description county_desc
  FROM client_elig_status cels
       INNER JOIN elig_segment_and_details esad
          ON     esad.client_id = cels.client_id
             AND ESAD.SEGMENT_TYPE_CD = 'LTC'
             AND (esad.end_date IS NULL OR TRUNC(esad.end_date) = '31-DEC-2020')
       INNER JOIN selection_txn st
          ON     st.client_id = cels.client_id
             AND ST.SELECTION_GENERIC_FIELD5_TXT = 'B'
             AND st.status_cd = 'acceptedByState'
             AND TRUNC (st.status_date) = TRUNC (SYSDATE - 1)
             AND cels.subprogram_type IN ('BH_ONLY')
             AND cels.end_date IS NULL
       INNER JOIN client clnt ON clnt.clnt_client_id = st.client_id
       INNER JOIN case_client CSE_CLNT
          ON     CSE_CLNT.CSCL_CLNT_CLIENT_ID = st.client_id
             AND cse_clnt.cscl_status_cd = 'O'
       INNER JOIN address addr ON cse_clnt.cscl_res_addr_id = addr.addr_id
       INNER JOIN enum_county county ON county.VALUE = addr.addr_ctlk_id
       INNER JOIN elig_segment_and_details esad2
          ON     esad2.segment_type_cd = 'ME'
             AND esad2.client_id = st.client_id
             AND esad2.end_nd >= TO_CHAR (SYSDATE, 'YYYYMMDD')
             AND ESAD2.SEGMENT_DETAIL_VALUE_2 = '550'
       INNER JOIN elig_segment_and_details esad1
          ON     esad1.segment_type_cd = 'MI'
             AND esad1.client_id = st.client_id
             AND esad1.end_nd > esad1.start_nd
             AND ESAD1.start_nd = ST.START_ND
             AND ESAD1.SEGMENT_DETAIL_VALUE_2 = ST.PLAN_ID_EXT
             AND transaction_type_cd IN ('Transfer', 'NewEnrollment', 'DefaultEnroll')
UNION
SELECT clnt.clnt_cin      medicaid_id,
       CLNT.CLNT_LNAME    last_name,
       clnt.clnt_fname    first_name,
       CLNT.CLNT_SSN,
       CLNT.CLNT_DOB,
       ST.SELECTION_GENERIC_FIELD5_TXT,
       '17/095 Medicare'  Eligibility_Outcome,
       esad3.start_date   ME_Start_Date,
       esad3.end_date     ME_End_Date,
       county.VALUE       county_code,
       county.description county_desc
  FROM client_elig_status cels
       INNER JOIN elig_segment_and_details esad3
          ON     esad3.client_id = cels.client_id
             AND esad3.segment_type_cd = 'ME'
             AND esad3.end_nd >= TO_CHAR (SYSDATE, 'YYYYMMDD')
             AND ESAD3.SEGMENT_DETAIL_VALUE_2 = '095'
       INNER JOIN selection_txn st
          ON     st.client_id = cels.client_id
             AND ST.SELECTION_GENERIC_FIELD5_TXT = 'B'
             AND st.status_cd = 'acceptedByState'
             AND TRUNC (st.status_date) = TRUNC (SYSDATE - 1)
             AND cels.subprogram_type IN ('BH_ONLY')
             AND cels.end_date IS NULL
       INNER JOIN client clnt ON clnt.clnt_client_id = st.client_id
       INNER JOIN case_client CSE_CLNT
          ON     CSE_CLNT.CSCL_CLNT_CLIENT_ID = st.client_id
             AND cse_clnt.cscl_status_cd = 'O'
       INNER JOIN address addr ON cse_clnt.cscl_res_addr_id = addr.addr_id
       INNER JOIN enum_county county ON county.VALUE = addr.addr_ctlk_id
       INNER JOIN elig_segment_and_details esad2
          ON     esad2.segment_type_cd = 'ME'
             AND esad2.client_id = st.client_id
             AND esad2.end_nd >= TO_CHAR (SYSDATE, 'YYYYMMDD')
             AND ESAD2.SEGMENT_DETAIL_VALUE_2 = '550'
       INNER JOIN elig_segment_and_details esad1
          ON     esad1.segment_type_cd = 'MI'
             AND esad1.client_id = st.client_id
             AND esad1.end_nd > esad1.start_nd
             AND ESAD1.start_nd = ST.START_ND
             AND ESAD1.SEGMENT_DETAIL_VALUE_2 = ST.PLAN_ID_EXT
             AND transaction_type_cd IN ('Transfer', 'NewEnrollment', 'DefaultEnroll')
ORDER BY 1;

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_ELIG_OUTCOME_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_ELIG_OUTCOME_SV TO MAXDAT_SUPPORT_READ_ONLY;
