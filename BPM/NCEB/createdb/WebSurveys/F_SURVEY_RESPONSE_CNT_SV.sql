CREATE OR REPLACE VIEW F_SURVEY_RESPONSE_CNT_SV 
AS
SELECT record_date
      ,record_month
      ,survey_template_id  survey_template_id
      ,survey_template_category_cd survey_template_category_cd
      ,survey_template_question_id survey_template_question_id
    --  ,question_text
      ,COALESCE(survey_answer_1,0) survey_answer_1_cnt
      ,COALESCE(survey_answer_2,0) survey_answer_2_cnt
      ,COALESCE(survey_answer_3,0) survey_answer_3_cnt
      ,COALESCE(survey_answer_4,0) survey_answer_4_cnt
      ,COALESCE(survey_answer_5,0) survey_answer_5_cnt
      ,COALESCE((survey_answer_1 + survey_answer_2 + survey_answer_3 + survey_answer_4 + survey_answer_5),0) survey_question_attempt_cnt
      ,COALESCE(((survey_answer_1*1) + (survey_answer_2*2) + (survey_answer_3*3) + (survey_answer_4*4) + (survey_answer_5*5)),0) survey_answer_value
      ,COALESCE((survey_answer_1 + survey_answer_2 + survey_answer_3 + survey_answer_4 + survey_answer_5) *5*4,0) survey_answer_possible_points
      ,COALESCE((survey_answer_1*1*4 + survey_answer_2*2*4 + survey_answer_3*3*4 + survey_answer_4*4*4 + survey_answer_5*5*4),0) survey_answer_actual_points
      ,COALESCE(survey_answer_Y,0) survey_answer_Y_cnt
      ,COALESCE(survey_answer_N,0) survey_answer_N_cnt
FROM  (      
  SELECT st.survey_template_id
       ,st.survey_template_category_cd    
       ,st.survey_template_question_id
      -- ,st.question_text
     --  ,st.survey_template_answer_id
    --   ,st.answer_text
       ,dd.d_date record_date
       ,LAST_DAY(dd.d_date) record_month
       ,COUNT(DISTINCT CASE WHEN st.survey_answer_score = '1' THEN sr.survey_id ELSE NULL END) survey_answer_1
       ,COUNT(DISTINCT CASE WHEN st.survey_answer_score = '2' THEN sr.survey_id ELSE NULL END) survey_answer_2
       ,COUNT(DISTINCT CASE WHEN st.survey_answer_score = '3' THEN sr.survey_id ELSE NULL END) survey_answer_3
       ,COUNT(DISTINCT CASE WHEN st.survey_answer_score = '4' THEN sr.survey_id ELSE NULL END) survey_answer_4
       ,COUNT(DISTINCT CASE WHEN st.survey_answer_score = '5' THEN sr.survey_id ELSE NULL END) survey_answer_5
       ,COUNT(DISTINCT CASE WHEN st.survey_answer_score = 'Y' THEN sr.survey_id ELSE NULL END) survey_answer_Y
       ,COUNT(DISTINCT CASE WHEN st.survey_answer_score = 'N' THEN sr.survey_id ELSE NULL END) survey_answer_N
FROM bpm_d_dates dd
  CROSS JOIN (SELECT st.survey_template_id
       ,estc.value survey_template_category_cd 
       ,stqt.survey_template_question_id
       ,sta.survey_template_answer_id
       ,stat.answer_text
       ,stqt.question_text
      ,case when stq.question_type_cd = 'MULTI' and substr(stat.answer_text,1,1) = '1' then '1' 
       when stq.question_type_cd = 'MULTI' and substr(stat.answer_text,1,1) = '2' then '2'
        when stq.question_type_cd = 'MULTI' and substr(stat.answer_text,1,1) = '3' then '3'
       when stq.question_type_cd = 'MULTI' and substr(stat.answer_text,1,1) = '4' then '4' 
       when stq.question_type_cd = 'MULTI' and substr(stat.answer_text,1,1) = '5' then '5'
       when stq.question_type_cd = 'YN' and substr(stat.answer_text,1,1) = 'Y' then 'Y' 
       when stq.question_type_cd = 'YN' and substr(stat.answer_text,1,1) = 'N' then 'N'
       else '0'
       end survey_answer_score
       FROM eb.survey_template st 
         JOIN eb.enum_survey_template_category estc ON estc.value = st.survey_template_category_cd
         JOIN eb.survey_template_group stg ON stg.survey_template_id = st.survey_template_id
         LEFT JOIN eb.survey_template_question stq ON stq.survey_template_group_id = stg.survey_template_group_id
         LEFT JOIN eb.SVEY_TMPL_QUESTION_TEXT stqt ON stqt.survey_template_question_id = stq.survey_template_question_id
         LEFT JOIN eb.survey_template_answer sta ON stqt.survey_template_question_id = sta.survey_template_question_id
         LEFT JOIN eb.svey_tmpl_answer_text stat ON stat.survey_template_answer_id = sta.survey_template_answer_id
        JOIN eb.svey_tmpl_group_text stgt ON stgt.survey_template_group_id = stg.survey_template_group_id
        LEFT JOIN eb.survey_template_context stc ON stc.survey_template_id = st.survey_template_id
       WHERE st.survey_template_status_cd = 'ACTIVE'
       AND UPPER(st.title) LIKE 'ENROLL%SAT%'
       AND st.survey_template_category_cd = 'SAT' ) st       
  LEFT JOIN eb.survey s
   ON s.survey_template_id = st.survey_template_id AND TRUNC(s.status_date) = dd.d_date
  LEFT JOIN eb.survey_response sr ON s.survey_id = sr.survey_id AND sr.template_question_id = st.survey_template_question_id AND sr.survey_template_answer_id = st.survey_template_answer_id
--where s.survey_id = 4921  
WHERE d_date BETWEEN GREATEST(TO_DATE('&schemadatelimit','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13)) AND TRUNC(sysdate)     
GROUP BY st.survey_template_id
       ,st.survey_template_category_cd 
       ,st.survey_template_question_id
       ,dd.d_date
       ,LAST_DAY(dd.d_date)
       ,st.question_text
--       ,st.survey_template_answer_id
--       ,st.answer_text
   ) s 
;


GRANT SELECT ON MAXDAT_SUPPORT.F_SURVEY_RESPONSE_CNT_SV TO MAXDAT_REPORTS ;
GRANT SELECT ON MAXDAT_SUPPORT.F_SURVEY_RESPONSE_CNT_SV TO MAXDATSUPPORT_READ_ONLY;  
