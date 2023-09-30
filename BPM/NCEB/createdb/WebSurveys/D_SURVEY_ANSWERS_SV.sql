CREATE OR REPLACE VIEW D_SURVEY_ANSWERS_SV AS
select /*+ parallel(10) */ 
 sur.survey_id
, stq.survey_template_question_id survey_template_question_id
, stat.answer_text
, case when stq.question_type_cd = 'MULTI' and substr(stat.answer_text,1,1) = '1' then 1 
       when stq.question_type_cd = 'MULTI' and substr(stat.answer_text,1,1) = '2' then 2
        when stq.question_type_cd = 'MULTI' and substr(stat.answer_text,1,1) = '3' then 3
       when stq.question_type_cd = 'MULTI' and substr(stat.answer_text,1,1) = '4' then 4 
       when stq.question_type_cd = 'MULTI' and substr(stat.answer_text,1,1) = '5' then 5
       when stq.question_type_cd = 'YN' and substr(stat.answer_text,1,1) = 'Y' then 1 
       when stq.question_type_cd = 'YN' and substr(stat.answer_text,1,1) = 'N' then 2 
       else 0
       end survey_answer_value
, case when stq.question_type_cd = 'MULTI' and substr(stat.answer_text,1,1) = '1' then 1 
       when stq.question_type_cd = 'MULTI' and substr(stat.answer_text,1,1) = '2' then 2
        when stq.question_type_cd = 'MULTI' and substr(stat.answer_text,1,1) = '3' then 3
       when stq.question_type_cd = 'MULTI' and substr(stat.answer_text,1,1) = '4' then 4 
       when stq.question_type_cd = 'MULTI' and substr(stat.answer_text,1,1) = '5' then 5
       when stq.question_type_cd = 'YN' and substr(stat.answer_text,1,1) = 'Y' then 1 
       when stq.question_type_cd = 'YN' and substr(stat.answer_text,1,1) = 'N' then 0
       else 0
       end survey_answer_score
--, LISTAGG(nvl(sur.comments,''), '; ') WITHIN GROUP (ORDER BY stq.survey_template_question_id) AS survey_answer_Comments
, sur.created_by  survey_response_created_by
, sur.create_ts survey_response_create_ts
, sur.updated_by survey_response_updated_by
, sur.update_ts survey_response_update_ts
, sta.survey_template_answer_id survey_template_answer_id
from eb.survey_template st
join eb.enum_survey_template_category estc on estc.value = st.survey_template_category_cd
join eb.survey_template_group stg on stg.survey_template_id = st.survey_template_id
left join eb.survey_template_question stq on stq.survey_template_group_id = stg.survey_template_group_id
join eb.survey_response sur on sur.template_question_id = stq.survey_template_question_id
left join eb.survey_template_answer sta on sur.survey_template_answer_id = sta.survey_template_answer_id
left join eb.SVEY_TMPL_ANSWER_TEXT stat on stat.survey_template_answer_id = sta.survey_template_answer_id
left join eb.survey_template_context stc on stc.survey_template_id = st.survey_template_id
join eb.svey_tmpl_group_text stgt on stgt.survey_template_group_id = stg.survey_template_group_id
--where 1=1
--and st.title like '%QC%'
--and stc.ref_type = 'QCREVIEW'
and estc.value = 'SAT'
and upper(st.title) like 'ENROLL%SAT%'
and upper(stgt.group_text) like 'ENROLL%'
--group by sur.survey_id, stq.survey_template_question_id
;

GRANT SELECT ON MAXDAT_SUPPORT.D_SURVEY_ANSWERS_SV TO MAXDATSUPPORT_READ_ONLY;

  GRANT SELECT ON MAXDAT_SUPPORT.D_SURVEY_ANSWERS_SV TO MAXDAT_REPORTS;  





