CREATE OR REPLACE VIEW EMRS_D_CLIENT_ELIGIBILITY_SV
AS
WITH esad1 AS(
SELECT client_id,start_date,start_nd,end_nd,segment_type_cd
FROM MAXDAT_LAEB.emrs_d_elig_segment_details_ltc esad1
WHERE  esad1.segment_type_cd = 'LTC'
AND esad1.start_nd < TO_CHAR (SYSDATE - 30, 'YYYYMMDD')
AND esad1.end_nd > TO_CHAR (LAST_DAY (SYSDATE), 'YYYYMMDD')
),
ces AS(
SELECT ces.client_id
FROM MAXDAT_LAEB.EMRS_D_CLIENT_ELIGIBILITY ces
WHERE CES.ELIG_STATUS_CD IN('M','V')
AND CES.END_DATE IS NULL
AND CES.MVX_CORE_REASON LIKE 'X29%'),
esad2 AS(
SELECT client_id
FROM MAXDAT_LAEB.emrs_d_elig_segment_details_mi esad2
WHERE  esad2.segment_type_cd = 'MI'
AND esad2.end_nd = 20501231
AND esad2.SEGMENT_DETAIL_VALUE_1 = 'B'),
esad AS(
SELECT client_id
FROM MAXDAT_LAEB.emrs_d_elig_segment_details_me esad
 JOIN(SELECT AID_Category || '-' || TYPE_CASE aid_type_case
      FROM MAXDAT_LAEB.D_MVX_XWALK
      WHERE     ACUTE_MVX IN ('M', 'V - Opt-In')
      AND EFFECTIVE_END_DATE IS NULL ) aid ON aid.aid_type_case = ESAD.SEGMENT_DETAIL_VALUE_1|| '-'|| ESAD.SEGMENT_DETAIL_VALUE_2 
WHERE ESAD.SEGMENT_TYPE_CD = 'ME'
 AND ESAD.END_ND > TO_NUMBER(TO_CHAR (LAST_DAY (SYSDATE), 'YYYYMMDD')) )
SELECT CSI.CLIENT_CIN Medicaid_ID,
         CSI.LAST_NAME  LAST_NAME,
         CSI.FIRST_NAME FIRST_NAME,
         'LTC'          SEGMENT_TYPE_CD,
         esad1.start_date LTC_START_DATE
FROM ces
  INNER JOIN emrs_d_client_supplementary_info csi ON ces.client_id = CSI.CLIENT_ID
  INNER JOIN esad1 ON     esad1.client_id = ces.client_id
WHERE EXISTS(SELECT 1 FROM esad2 WHERE esad2.client_id = ces.client_id)
AND EXISTS(SELECT 1 FROM esad WHERE esad.client_id = ces.client_id)
                         
;

GRANT SELECT ON EMRS_D_CLIENT_ELIGIBILITY_SV TO MAXDAT_LAEB_READ_ONLY;

