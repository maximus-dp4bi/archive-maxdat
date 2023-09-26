CREATE OR REPLACE VIEW EMRS_D_CLIENT_CCM_SV AS
SELECT   cl.clnt_cin  MEDICAID_MEMBER_ID,
        to_date(TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 271, 8), '0')),'YYYYMMDD') CCM_BEGIN_DATE,
        to_date(TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 279, 8), '0')),'YYYYMMDD') CCM_END_DATE,
        esad.start_date LINKAGE_START_DATE,
        esad.end_date LINKAGE_END_DATE,
        esad.segment_detail_value_1 LINKAGE_TYPE,
        esad.SEGMENT_DETAIL_VALUE_1 || '/' || esad.SEGMENT_DETAIL_VALUE_2 CURRENT_AC_TC,
CASE WHEN esad2.SEGMENT_DETAIL_VALUE_1 IS NOT NULL
            OR esad2.SEGMENT_DETAIL_VALUE_2 IS NOT NULL
            THEN esad2.SEGMENT_DETAIL_VALUE_1 || '/' || esad2.SEGMENT_DETAIL_VALUE_2
            ELSE NULL END AS FUTURE_AID_CATEGORY_TYPE_CASE,
       CASE WHEN esad2.start_date > SYSDATE
            THEN esad2.start_date
            ELSE NULL END AS FUTURE_START_DATE,
            esad.start_nd select_start,
            esad.end_nd SELECT_end
FROM elig_segment_and_details esad
INNER JOIN client cl ON (cl.clnt_client_id = esad.client_id)
     LEFT JOIN elig_segment_and_details esad2
        ON esad2.segment_type_cd = 'ME'
       AND esad2.client_id = esad.client_id
       AND esad2.start_date > SYSDATE
       AND esad2.end_date > esad2.start_date
       AND esad2.SEGMENT_DETAIL_VALUE_1 || '/'  || esad2.SEGMENT_DETAIL_VALUE_2 NOT IN  ('17/095')
   WHERE esad.segment_type_cd = 'MI'
           AND (
              (esad.start_nd BETWEEN TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 271, 8), '0')) AND TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 279, 8), '0')))
              OR (esad.end_nd BETWEEN TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 271, 8), '0')) AND TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 279, 8), '0')))
              OR (esad.start_nd <= TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 271, 8), '0')) AND esad.end_nd >= TO_NUMBER (NVL (SUBSTR (cl.comparable_key, 279, 8), '0')))
            )
ORDER BY 1;
/

 GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_CCM_SV TO MAXDAT_REPORTS; 
 GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLIENT_CCM_SV TO gt83345;
 