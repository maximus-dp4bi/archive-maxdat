CREATE OR REPLACE VIEW EMRS_F_ENRL_START_CNT_SV
 AS
SELECT d.D_DATE AS MANAGED_CARE_START_DATE,
  f.PROGRAM_CODE,
  f.SUBPROGRAM_CODE,
  f.COUNTY_CODE,
  f.PLAN_ID,
  f.PLAN_TYPE,
  f.PLAN_ID_EXT,
  f.PRIOR_PLAN_ID,
  f.PRIOR_PLAN_ID_EXT,
  f.CHANGE_REASON_CODE,
  f.STATUS_CD,
  f.TRANSACTION_TYPE_CD,
  EXTRACT(YEAR FROM(d.D_DATE - f.dob) YEAR TO MONTH) AS AGE,
  f.SEX,
  COUNT(f.enrollment_id) AS enrollment_count
FROM MAXDAT_SUPPORT.D_DATES d
JOIN
  (SELECT ss.selection_segment_id enrollment_id
  , COALESCE(ss.program_type_cd, s.program_type_cd, '0') program_code
  , COALESCE(ac.subprogram_codes, '0') subprogram_code 
  , COALESCE(ss.county_cd, s.county,'0') county_code
  , COALESCE(ss.plan_id, s.plan_id, 0) plan_id
  , COALESCE(ss.plan_type_cd, s.plan_type_cd) plan_type
  , s.plan_id_ext 
  , COALESCE(s.prior_plan_id, 0) AS prior_plan_id
  , s.prior_plan_id_ext 
  , COALESCE(ss.disenroll_reason_cd_1,s.disenroll_reason_cd_1, '0') change_reason_code
  , s.status_cd
  , COALESCE(s.transaction_type_cd,'State_Facilitated_Enrollment') AS TRANSACTION_TYPE_CD
  , c.clnt_dob AS DOB 
  , c.clnt_gender_cd AS SEX
  , ss.start_date managed_care_start_date
  , ss.end_date managed_care_end_date 
  FROM eb.selection_segment ss
  JOIN client c                ON ss.client_id = c.clnt_client_id
  LEFT JOIN enum_aid_category ac    ON ss.client_aid_category_cd = ac.value
  LEFT JOIN eb.selection_txn s ON ss.selection_segment_id = s.selection_segment_id
  WHERE COALESCE(ss.end_date, TO_DATE('12-Dec-2050', 'dd-Mon-yyyy')) >= ADD_MONTHS(TRUNC(sysdate, 'mm'), -2)
  AND s.STATUS_CD = 'acceptedByState'
  ) f ON (d.D_DATE BETWEEN ADD_MONTHS(TRUNC(sysdate, 'mm'), -2) AND TRUNC(sysdate)
          AND d.D_DATE BETWEEN f.MANAGED_CARE_START_DATE AND COALESCE(f.MANAGED_CARE_END_DATE, TO_DATE('12-Dec-2050', 'dd-Mon-yyyy')))  
GROUP BY d.D_DATE,
  f.PROGRAM_CODE,
  f.SUBPROGRAM_CODE,
  f.COUNTY_CODE,
  f.PLAN_ID,
  f.PLAN_TYPE,
  f.PLAN_ID_EXT,
  f.PRIOR_PLAN_ID,
  f.PRIOR_PLAN_ID_EXT,
  f.CHANGE_REASON_CODE,
  f.STATUS_CD,
  f.TRANSACTION_TYPE_CD,
  EXTRACT(YEAR FROM(d.D_DATE - f.dob) YEAR TO MONTH),
  f.SEX;
 
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_F_ENRL_START_CNT_SV TO MAXDAT_REPORTS;    