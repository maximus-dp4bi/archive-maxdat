CREATE OR REPLACE VIEW EMRS_F_ENRL_START_CNT_SV
 AS
SELECT DISTINCT 
  m.D_MONTH as MANAGED_CARE_MONTH,
  f.PROGRAM_CODE,
  f.SUBPROGRAM_CODE,
  f.AID_CATEGORY_CODE,
  f.COUNTY_CODE,
  f.IS_CSC,
  f.PLAN_ID,
  f.PLAN_TYPE,
  f.PLAN_ID_EXT,
  EXTRACT(YEAR FROM(m.D_MONTH_START - f.dob) YEAR TO MONTH) AS AGE,
  f.SEX,
  COUNT(f.enrollment_id) OVER(PARTITION BY  m.D_MONTH,
                                            f.PROGRAM_CODE,
                                            f.SUBPROGRAM_CODE,
                                            f.aid_category_code,
                                            f.COUNTY_CODE,
                                            f.IS_CSC,
                                            f.PLAN_ID,
                                            f.PLAN_TYPE,
                                            f.PLAN_ID_EXT,
                                            EXTRACT(YEAR FROM(m.D_MONTH_START - f.dob) YEAR TO MONTH),
                                            f.SEX
                                            ) AS enrollment_count_month    
FROM MAXDAT_SUPPORT.D_MONTHS m
JOIN
  (SELECT ss.ELIG_SEGMENT_AND_DETAILS_ID enrollment_id
  , ss.PROGRAM_CD program_code
  , '0' subprogram_code   
  , COALESCE(ss.AID_CATEGORY, '0') aid_category_code
  , CASE WHEN ec.attrib_district_cd <> COALESCE(TRIM(p.comments), '0') THEN 'OA' ELSE COALESCE(ss.county_cd,'0') END as county_code 
  , CASE WHEN csc.client_id IS NOT NULL THEN 1 ELSE 0 END as is_csc
  , p.plan_id plan_id
  , p.plan_type_cd plan_type
  , ss.plan_id_ext 
  , c.clnt_dob AS DOB 
  , c.clnt_gender_cd AS SEX
  , to_date(ss.start_nd, 'yyyymmdd') managed_care_start_date
  , to_date(ss.end_nd, 'yyyymmdd') managed_care_end_date
  , ss.start_nd
  , ss.end_nd
  FROM maxdat_support.PAEAP_CUR_ENROLLEES ss
  JOIN eb.client c ON (ss.client_id = c.clnt_client_id)
  JOIN eb.plans p ON (ss.plan_id_ext = p.plan_id_ext)
  LEFT JOIN eb.enum_aid_category ac    ON (ss.AID_CATEGORY = ac.value)
  LEFT JOIN MAXDAT_SUPPORT.CSC csc ON (c.clnt_client_id = csc.client_id)
  LEFT JOIN eb.enum_county ec ON (COALESCE(ss.county_cd,'0') = ec.value)
  WHERE  ss.start_nd <= to_number(to_char(LAST_DAY(sysdate), 'yyyymmdd'))
  AND ss.end_nd >= to_number(to_char(ADD_MONTHS(TRUNC(sysdate, 'mm'), -4), 'yyyymmdd'))
  AND ss.end_nd > ss.start_nd 
  ) f ON (m.d_month_start BETWEEN ADD_MONTHS(TRUNC(sysdate, 'mm'), -4) AND TRUNC(sysdate, 'mm')
          AND f.start_nd <= to_number(to_char(m.d_month_start, 'yyyymmdd'))
          AND f.end_nd >= to_number(to_char(m.d_month_start, 'yyyymmdd'))
          AND f.end_nd > f.start_nd);
 
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENRL_START_CNT_SV TO EB_MAXDAT_REPORTS;    