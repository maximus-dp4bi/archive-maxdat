--drop table qc_questions;

---create or replace view qc_questions_Sv as select * from qc_questions;

create or replace view qc_questions_sv as
select st.survey_template_category_cd || '_' || stg.sort_order QC_type
, stq.question_number
, stq.sort_order
, stqt.question_text
, stq.question_type_cd
, stq.answer_type_cd
, stq.weightage
, stq.survey_template_question_id
, st.survey_template_id
, st.survey_template_status_cd
, st.effective_from_date
, st.effective_thru_date
, st.survey_template_type_cd
, st.title
, stgt.group_text
, st.survey_template_category_cd
from maxdat.survey_template st
join enum_survey_template_category estc on estc.value = st.survey_template_category_cd
join maxdat.survey_template_group stg on stg.survey_template_id = st.survey_template_id
left join maxdat.survey_template_question stq on stq.survey_template_group_id = stg.survey_template_group_id
left join maxdat.SVEY_TMPL_QUESTION_TEXT stqt on stqt.survey_template_question_id = stq.survey_template_question_id
left join maxdat.svey_tmpl_group_text stgt on stgt.survey_template_group_id = stg.survey_template_group_id
left join maxdat.survey_template_context stc on stc.survey_template_id = st.survey_template_id
where 1=1
--and st.title like '%QC%' 
and stq.sort_order is not null
--and stc.ref_type = 'QCREVIEW'
order by st.survey_template_id, stg.sort_order, to_number(regexp_replace(stq.question_number,'[^[:digit:]]+','')), stq.survey_template_question_id asc
;

grant select on QC_QUESTIONS_sv to maxdat_read_only;
grant select on QC_QUESTIONS_sv to maxdat_reports;


--select * from maxdat.svey_tmpl_group_text 
