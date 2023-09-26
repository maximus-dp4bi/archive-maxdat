
CREATE OR REPLACE VIEW F_SURVEY_CNT_SV
AS
SELECT dd.d_date record_date
       ,LAST_DAY(dd.d_date) record_month
       ,st.survey_template_id
       ,st.survey_template_category_cd       
       ,COUNT(DISTINCT selection_txn_id ) offered_cnt
       ,COUNT(DISTINCT CASE WHEN s.status_cd IN('COMPLETED') THEN survey_id ELSE NULL END ) completed_cnt
FROM bpm_d_dates dd
CROSS JOIN (SELECT st.survey_template_id
       ,estc.value survey_template_category_cd 
       FROM eb.survey_template st 
         JOIN eb.enum_survey_template_category estc ON estc.value = st.survey_template_category_cd
         JOIN eb.survey_template_group stg ON stg.survey_template_id = st.survey_template_id
      --   LEFT JOIN eb.survey_template_question stq ON stq.survey_template_group_id = stg.survey_template_group_id
      --   LEFT JOIN eb.SVEY_TMPL_QUESTION_TEXT stqt ON stqt.survey_template_question_id = stq.survey_template_question_id
      --  JOIN eb.svey_tmpl_group_text stgt ON stgt.survey_template_group_id = stg.survey_template_group_id
      --  LEFT JOIN eb.survey_template_context stc ON stc.survey_template_id = st.survey_template_id
       WHERE st.survey_template_status_cd = 'ACTIVE'
       AND UPPER(st.title) LIKE 'ENROLL%SAT%'
       AND st.survey_template_category_cd = 'SAT' ) st       
  LEFT JOIN eb.survey s
   ON s.survey_template_id = st.survey_template_id 
   AND TRUNC(s.status_date) = dd.d_date
  LEFT JOIN (SELECT selection_txn_id,TRUNC(create_ts) txn_record_date
             FROM selection_txn 
             WHERE selection_source_cd = 'W') txn ON d_date = txn_record_date
WHERE d_date BETWEEN GREATEST(TO_DATE('&schemadatelimit','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13)) AND TRUNC(sysdate)   
GROUP BY dd.d_date
       ,LAST_DAY(dd.d_date)
       ,st.survey_template_id
       ,st.survey_template_category_cd   ;

GRANT SELECT ON MAXDAT_SUPPORT.F_SURVEY_CNT_SV TO MAXDAT_REPORTS ;
 GRANT SELECT ON MAXDAT_SUPPORT.F_SURVEY_CNT_SV TO MAXDATSUPPORT_READ_ONLY;  
