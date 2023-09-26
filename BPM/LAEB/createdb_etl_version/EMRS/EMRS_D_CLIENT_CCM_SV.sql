CREATE OR REPLACE VIEW EMRS_D_CLIENT_CCM_SV
AS
WITH esad AS
(SELECT *
FROM emrs_d_elig_segment_details_mi esad
WHERE esad.segment_type_cd = 'MI'           
AND esad.start_nd <= TO_NUMBER(TO_CHAR (TRUNC (TRUNC (SYSDATE, 'MM') - 1, 'MM'), 'YYYYMMDD'))
AND esad.end_nd >= TO_NUMBER(TO_CHAR (TRUNC (SYSDATE, 'MM') - 1, 'YYYYMMDD')) ),
temp AS(
SELECT cl.client_id Maximus_Client_id,
       cl.clnt_cin Medicaid_ID,
       TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 271, 8), '0')) CCM_Begin_Date,
       TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 279, 8), '0')) CCM_End_Date
FROM emrs_d_client cl
WHERE TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 279, 8), '0')) >= TO_NUMBER(TO_CHAR(TRUNC (TRUNC(SYSDATE, 'MM') - 1, 'MM'), 'YYYYMMDD'))
AND   TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 271, 8), '0')) <= TO_NUMBER(TO_CHAR (TRUNC (SYSDATE, 'MM') - 1, 'YYYYMMDD')) ),
esad2 AS(
SELECT *
FROM emrs_d_elig_segment_details_me esad2
WHERE esad2.segment_type_cd = 'ME'
AND esad2.start_date > SYSDATE
AND esad2.end_date > esad2.start_date
AND esad2.SEGMENT_DETAIL_VALUE_1 || '/'  || esad2.SEGMENT_DETAIL_VALUE_2 NOT IN  ('17/095'))

SELECT   temp.Medicaid_ID Medicaid_Member_Id,
         to_date(temp.ccm_begin_date,'YYYYMMDD') CCM_Begin_Date,
         (CASE WHEN (substr(temp.ccm_end_date,1,4) NOT IN ('2020','2024','2028','2032','2036') AND temp.ccm_end_date LIKE '%0229') THEN NULL ELSE to_date(temp.ccm_end_date,'YYYYMMDD') END) ccm_end_date,       
         esad.start_date Linkage_Start_Date,
         esad.end_date Linkage_End_Date,
         esad.segment_detail_value_1 Linkage_Type,
        CASE WHEN esad2.SEGMENT_DETAIL_VALUE_1 IS NOT NULL
             OR esad2.SEGMENT_DETAIL_VALUE_2 IS NOT NULL
             THEN esad2.SEGMENT_DETAIL_VALUE_1 || '/' || esad2.SEGMENT_DETAIL_VALUE_2
             ELSE NULL END AS FUTURE_AC_TC,
        CASE WHEN esad2.start_date > SYSDATE
             THEN esad2.start_date
             ELSE NULL END AS FUTURE_START_DATE,
esad.SEGMENT_DETAIL_VALUE_1 || '/' || esad.SEGMENT_DETAIL_VALUE_2 AS "CURRENT_AC_TC",
esad.SEGMENT_DETAIL_VALUE_2
FROM esad
INNER JOIN temp ON temp.maximus_client_id = esad.client_id
LEFT JOIN esad2 ON esad2.client_id = esad.client_id       
WHERE  (esad.start_nd BETWEEN temp.CCM_Begin_Date AND temp.CCM_End_Date)
  OR (esad.end_nd BETWEEN temp.CCM_Begin_Date AND temp.CCM_End_Date)
  OR (esad.start_nd <= temp.CCM_Begin_Date AND esad.end_nd >= temp.CCM_End_Date)
;

grant select on EMRS_D_CLIENT_CCM_SV to MAXDAT_LAEB_READ_ONLY;       
