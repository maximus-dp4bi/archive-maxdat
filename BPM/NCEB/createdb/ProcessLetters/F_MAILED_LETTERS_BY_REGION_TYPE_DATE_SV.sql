DROP VIEW F_MAILED_LETTERS_BY_REGION_TYPE_DATE_SV;
CREATE OR REPLACE VIEW F_MAILED_LETTERS_BY_REGION_TYPE_DATE_SV
AS
SELECT /*+ parallel(10) */ dd.d_date mailed_date
      ,lr.letter_type_code
      ,lr.letter_type
      ,COALESCE(lr.county,'Undefined') county
      ,COALESCE(lr.region,'Undefined') region     
      ,SUM(CASE WHEN is_digital_ind = 0 AND mailed_date IS NOT NULL THEN 1 ELSE 0 END) mailed_letter_count
      ,SUM(CASE WHEN is_digital_ind = 1 AND mailed_date IS NOT NULL THEN 1 ELSE 0 END) digital_letter_count
      ,SUM(CASE WHEN mailed_date IS NOT NULL THEN 1 ELSE 0 END) letter_count
      ,SUM(CASE WHEN error_type = 'NCOA' AND reject_date IS NOT NULL THEN 1 ELSE 0 END) ncoa_error_letter_count
      ,SUM(CASE WHEN error_type = 'INTERNAL' AND reject_date IS NOT NULL THEN 1 ELSE 0 END) internal_error_letter_count      
      ,COALESCE(language_code,'EN') language_code
      ,COALESCE(language_description,'English') language_description
      ,lr.plan_type_indicator
      ,lr.health_plan_name      
FROM d_dates dd 
  JOIN MAXDAT_SUPPORT.CORP_ETL_LIST_LKUP LK ON LK.NAME = 'NUM_LOOKBACK_MONTHS'
  JOIN (SELECT /*+ parallel(10) */ * 
            FROM(SELECT lr.lmreq_id,lr.lmdef_id, rs.enroll_county , TRUNC(lr.mailed_date) mailed_date,is_digital_ind
                      , row_number() over(partition by lr.lmreq_id order by rs.addr_id) rown
                      ,TRUNC(reject_date) reject_date
                      ,lr.reject_reason_cd
                      ,lr.language_cd language_code
                      ,el.report_label language_description
                      ,CASE WHEN lr.reject_reason_cd IN('1001','1002','1003','1100','1101','3111','3112','3113','3211','3215','3216','3311','3313','3411','3419','3422') THEN 'NCOA' 
                            WHEN lr.reject_reason_cd IS NULL THEN NULL
                         ELSE 'INTERNAL' END error_type
                      ,ld.name letter_type_code
                      ,ld.description letter_type
                      ,rs.county
                      ,rs.region
                      ,CASE WHEN (ld.name LIKE 'TP%' OR ld.name LIKE 'IATP%' OR ld.name = 'IAS') THEN 'TP' ELSE 'SP' END plan_type_indicator
                      ,CASE WHEN (ld.name LIKE 'TP%' OR ld.name LIKE 'IATP%' OR ld.name = 'IAS') THEN COALESCE(hp.plan_name,'NC Medicaid Direct') ELSE NULL END health_plan_name
                 FROM eb.letter_request lr                
                    --JOIN eb.letter_request_link ll ON lr.lmreq_id = ll.lmreq_id                    
                    JOIN eb.cases cs ON lr.case_id = cs.case_id                  
                    JOIN eb.letter_definition ld ON lr.lmdef_id = ld.lmdef_id
                    LEFT JOIN eb.enum_language el ON lr.language_cd = el.value                    
                    LEFT JOIN (SELECT rs.addr_id, rs.addr_case_id,rs.addr_end_date,rs.addr_begin_date,COALESCE(ec.value,'UD') enroll_county, ec.report_label county,ed.report_label region
                              FROM eb.address rs 
                                 LEFT JOIN eb.enum_county ec ON rs.addr_ctlk_id = ec.value
                                 LEFT JOIN eb.enum_district ed ON ec.attrib_district_cd = ed.value
                               WHERE rs.addr_type_cd = 'RS' ) rs 
                       ON lr.case_id = rs.addr_case_id
                       AND lr.create_ts BETWEEN rs.addr_begin_date AND COALESCE(rs.addr_end_date,TO_DATE('12/31/2099','mm/dd/yyyy'))      
                    LEFT JOIN (SELECT *
                               FROM(SELECT h.create_ts reject_date
                                     ,lmreq_id                                     
                                     ,status_cd
                                     ,row_number() over(partition by h.lmreq_id order by h.create_ts desc) hrn
                                    FROM letter_req_status_history h
                                    WHERE status_cd = 'REJ')
                                WHERE hrn = 1 ) lh ON lr.lmreq_id = lh.lmreq_id 
                    LEFT JOIN(SELECT *
                               FROM(SELECT lrr.lmreq_id,lrr.plan_id_ext,plan_name, RANK() OVER(PARTITION BY lmreq_id ORDER BY letter_request_letter_data_id DESC) rnum
                               FROM letter_request_letter_data lrr
                                 JOIN eb.plans p ON lrr.plan_id_ext = p.plan_id_ext)
                            WHERE rnum = 1) hp ON hp.lmreq_id = lr.lmreq_id                                
                 WHERE (lr.mailed_date IS NOT NULL OR (lh.reject_date IS NOT NULL AND lr.reject_reason_cd IS NOT NULL))                                        
                 )
            WHERE rown = 1) lr  ON COALESCE(lr.mailed_date,lr.reject_date) = dd.d_date 
WHERE dd.d_date >=  GREATEST(TO_DATE('06/28/2019','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE,'MM'), COALESCE(-(lk.out_var),-13)))
AND dd.d_date <= TRUNC(sysdate)
GROUP BY dd.d_date
        ,lr.letter_type_code
        ,lr.letter_type
        ,COALESCE(lr.county,'Undefined')
        ,COALESCE(lr.region,'Undefined')
        ,COALESCE(language_code,'EN')
        ,COALESCE(language_description,'English') 
        ,lr.plan_type_indicator
        ,lr.health_plan_name;

GRANT SELECT ON MAXDAT_SUPPORT.F_MAILED_LETTERS_BY_REGION_TYPE_DATE_SV TO MAXDAT_REPORTS ;
GRANT SELECT ON MAXDAT_SUPPORT.F_MAILED_LETTERS_BY_REGION_TYPE_DATE_SV TO MAXDATSUPPORT_READ_ONLY ;
 
