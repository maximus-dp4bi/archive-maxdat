Create or replace VIEW D_SURVEY_QUESTIONS_SV as
select 
 st.survey_template_category_cd
--st.survey_template_category_cd || '_' || stg.sort_order QC_type
--, stq.question_number
, STG.SORT_ORDER *100 + stq.sort_order SORT_ORDER
, stqt.question_text
, stq.question_type_cd
, stq.answer_type_cd
--, stq.weightage
, stq.survey_template_question_id
, st.survey_template_id
--, st.survey_template_status_cd
--, st.effective_from_date
--, st.effective_thru_date
--, st.survey_template_type_cd
--, st.title
--, stg.sort_order group_sort_order
--, stgt.group_text
from eb.survey_template st
join enum_survey_template_category estc on estc.value = st.survey_template_category_cd
join eb.survey_template_group stg on stg.survey_template_id = st.survey_template_id
left join eb.survey_template_question stq on stq.survey_template_group_id = stg.survey_template_group_id
left join eb.SVEY_TMPL_QUESTION_TEXT stqt on stqt.survey_template_question_id = stq.survey_template_question_id
join eb.svey_tmpl_group_text stgt on stgt.survey_template_group_id = stg.survey_template_group_id
left join eb.survey_template_context stc on stc.survey_template_id = st.survey_template_id
where 1=1
--and st.title like '%QC%' 
and stq.sort_order is not null
--and stc.ref_type = 'SAT'
and st.survey_template_category_cd = 'SAT'
and upper(st.title) like 'ENROLL%SAT%'
and upper(stgt.group_text) like 'ENROLL%'
and st.survey_template_status_cd = 'ACTIVE'
and sysdate >= effective_from_date
and sysdate <= effective_thru_date
order by st.survey_template_id, stg.sort_order, to_number(regexp_replace(stq.question_number,'[^[:digit:]]+','')), stq.survey_template_question_id asc
;

GRANT SELECT ON MAXDAT_SUPPORT.D_SURVEY_QUESTIONS_SV TO MAXDATSUPPORT_READ_ONLY;

  GRANT SELECT ON MAXDAT_SUPPORT.D_SURVEY_QUESTIONS_SV TO MAXDAT_REPORTS;  

