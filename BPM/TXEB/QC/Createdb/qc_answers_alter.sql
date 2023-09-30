
create or replace view qc_answers_sv as
select /*+ parallel(10) */ 
 sur.survey_id
, nvl(stq.parent_template_question_id, stq.survey_template_question_id) survey_template_question_id
, LISTAGG(nvl(stat.answer_text,''), '; ') WITHIN GROUP (ORDER BY stq.survey_template_question_id) AS survey_answer_Text
, LISTAGG(nvl(sur.comments,''), '; ') WITHIN GROUP (ORDER BY stq.survey_template_question_id) AS survey_answer_Comments
, max(sur.created_by) survey_response_created_by
, max(sur.create_ts) survey_response_create_ts
, max(sur.updated_by) survey_response_updated_by
, max(sur.update_ts) survey_response_update_ts
, max(surh.challenge_reason) challenge_reason
, max(surh.challenge_reason_comment) challenge_reason_comment
, max(surh.challenge_outcome) challenge_outcome
, max(surh.challenge_findings) challenge_findings
, max(surh.challenge_this_question) challenge_this_question
, max(nvl(sta.score,0)) survey_answer_score
, min(sta.survey_template_answer_id) survey_template_answer_id
from maxdat.survey_template st
join maxdat.enum_survey_template_category estc on estc.value = st.survey_template_category_cd
join maxdat.survey_template_group stg on stg.survey_template_id = st.survey_template_id
left join maxdat.survey_template_question stq on stq.survey_template_group_id = stg.survey_template_group_id
join maxdat.survey_response sur on sur.template_question_id = stq.survey_template_question_id
left join (select * from (
select survey_id, template_question_id, survey_template_answer_id, challenge_reason, challenge_reason_comment, challenge_outcome, challenge_findings, challenge_this_question
, row_number() over(partition by survey_id, template_question_id, survey_template_answer_id order by create_ts desc) rown
from maxdat.survey_response_hist
) where rown = 1) surh on (surh.survey_id = sur.survey_id and surh.template_question_id = sur.template_question_id and surh.survey_template_answer_id = sur.survey_template_answer_id)
left join maxdat.survey_template_answer sta on sur.survey_template_answer_id = sta.survey_template_answer_id
left join maxdat.SVEY_TMPL_ANSWER_TEXT stat on stat.survey_template_answer_id = sta.survey_template_answer_id
left join maxdat.survey_template_context stc on stc.survey_template_id = st.survey_template_id
--where 1=1
--and st.title like '%QC%'
--and stc.ref_type = 'QCREVIEW'
group by sur.survey_id, nvl(stq.parent_template_question_id, stq.survey_template_question_id)
;

grant select on QC_ANSWERS_SV to maxdat_read_only;
grant select on QC_ANSWERS_SV to maxdat_reports;



