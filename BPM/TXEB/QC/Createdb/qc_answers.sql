drop table qc_answers;

create or replace view qc_answers_sv as
select 
 sur.survey_id
, nvl(stq.parent_template_question_id, stq.survey_template_question_id) survey_template_question_id
, LISTAGG(nvl(stat.answer_text,''), '; ') WITHIN GROUP (ORDER BY stq.survey_template_question_id) AS survey_answer_Text
, LISTAGG(nvl(sur.comments,''), '; ') WITHIN GROUP (ORDER BY stq.survey_template_question_id) AS survey_answer_Comments
, max(sur.created_by) survey_response_created_by
, max(sur.create_ts) survey_response_create_ts
, max(sur.updated_by) survey_response_updated_by
, max(sur.update_ts) survey_response_update_ts
, max(nvl(sta.score,0)) survey_answer_score
, min(sta.survey_template_answer_id) survey_template_answer_id
from survey_template st
join survey_template_group stg on stg.survey_template_id = st.survey_template_id
left join survey_template_question stq on stq.survey_template_group_id = stg.survey_template_group_id
join survey_response sur on sur.template_question_id = stq.survey_template_question_id
left join survey_template_answer sta on sur.survey_template_answer_id = sta.survey_template_answer_id
left join SVEY_TMPL_ANSWER_TEXT stat on stat.survey_template_answer_id = sta.survey_template_answer_id
left join survey_template_context stc on stc.survey_template_id = st.survey_template_id
where 1=1
--and st.title like '%QC%'
and stc.ref_type = 'QCREVIEW'
group by sur.survey_id, nvl(stq.parent_template_question_id, stq.survey_template_question_id)
;

grant select on QC_ANSWERS_SV to maxdat_read_only;
grant select on QC_ANSWERS_SV to maxdat_reports;
