select /*+ parallel(10) */
  s.survey_id
, st.survey_template_id
, stq.survey_template_group_id
, stq.survey_template_question_id
, s.status_cd survey_status_cd
, s.status_date survey_status_date
, ssh.completed_date
, ssh.complete_flag
, stq.sort_order
, st.survey_template_category_cd || '_' || stg.sort_order QC_type
, stqt.svey_tmpl_question_text_id
, stqt.question_text
, stq.comment_enabled_ind
, stq.parent_template_question_id
, stq.conditional_answer_id
, st.survey_template_status_cd
, st.title
, stgt.group_text
, st.survey_template_category_cd
, sresp.survey_answer_text         
, sresp.survey_answer_comments     
, sresp.survey_response_created_by 
, sresp.survey_response_create_ts  
, sresp.survey_response_updated_by 
, sresp.survey_response_update_ts  
, sresp.challenge_reason           
, sresp.challenge_reason_comment   
, sresp.challenge_outcome          
, sresp.challenge_findings         
, sresp.challenge_this_question    
, sresp.survey_answer_score        
, sresp.survey_template_answer_id 
from eb.survey s
join eb.survey_template st on st.survey_template_id = s.survey_template_id
join eb.enum_survey_template_category estc on estc.value = st.survey_template_category_cd
join eb.survey_template_group stg on stg.survey_template_id = st.survey_template_id
left join (select ssh1.survey_id, max(ssh1.creation_date) completed_date, 1 complete_flag from eb.survey_status_history ssh1 where ssh1.status_cd = 'COMPLETED' group by ssh1.survey_id) ssh on ssh.survey_id = s.survey_id
left join eb.survey_template_question stq on stq.survey_template_group_id = stg.survey_template_group_id
left join eb.SVEY_TMPL_QUESTION_TEXT stqt on stqt.survey_template_question_id = stq.survey_template_question_id
left join eb.svey_tmpl_group_text stgt on stgt.survey_template_group_id = stg.survey_template_group_id
left join eb.survey_template_context stc on stc.survey_template_id = st.survey_template_id
left join eb.survey_response sur on sur.survey_id = s.survey_id and sur.template_question_id = stq.survey_template_question_id
left join (select survey_id, template_question_id, LISTAGG(nvl(sur1.comments,''), '; ') WITHIN GROUP (ORDER BY sur1.template_question_id) AS survey_Comments
 from eb.survey_response sur1
group by sur1.survey_id, sur1.template_question_id) surlist on surlist.survey_id = sur.survey_id and surlist.template_question_id = sur.template_question_id
left join (select * from (
select survey_id, template_question_id, survey_template_answer_id, challenge_reason, challenge_reason_comment, challenge_outcome, challenge_findings, challenge_this_question
, row_number() over(partition by survey_id, template_question_id, survey_template_answer_id order by create_ts desc) rown
from eb.survey_response_hist
) where rown = 1) surh on (surh.survey_id = sur.survey_id and surh.template_question_id = sur.template_question_id and surh.survey_template_answer_id = sur.survey_template_answer_id)
left join (
select /*+ parallel(10) */ 
 sur.survey_id response_survey_id
, st.survey_template_id resp_survey_template_id
, stg.survey_template_group_id resp_survey_template_group_id
, nvl(stq.parent_template_question_id, stq.survey_template_question_id) response_template_question_id
, LISTAGG(nvl(stat.answer_text,''), '; ') WITHIN GROUP (ORDER BY stq.survey_template_question_id) AS survey_answer_Text
--, LISTAGG(nvl(sur.comments,''), '; ') WITHIN GROUP (ORDER BY stq.survey_template_question_id) AS survey_answer_Comments
, max(surlist.survey_Comments) survey_answer_Comments
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
from eb.survey_template st
join eb.enum_survey_template_category estc on estc.value = st.survey_template_category_cd
join eb.survey_template_group stg on stg.survey_template_id = st.survey_template_id
left join eb.survey_template_question stq on stq.survey_template_group_id = stg.survey_template_group_id
join eb.survey_response sur on sur.template_question_id = stq.survey_template_question_id
join (select survey_id, template_question_id, LISTAGG(nvl(sur1.comments,''), '; ') WITHIN GROUP (ORDER BY sur1.template_question_id) AS survey_Comments
 from eb.survey_response sur1
group by sur1.survey_id, sur1.template_question_id) surlist on surlist.survey_id = sur.survey_id and surlist.template_question_id = sur.template_question_id
left join (select * from (
select survey_id, template_question_id, survey_template_answer_id, challenge_reason, challenge_reason_comment, challenge_outcome, challenge_findings, challenge_this_question
, row_number() over(partition by survey_id, template_question_id, survey_template_answer_id order by create_ts desc) rown
from eb.survey_response_hist
) where rown = 1) surh on (surh.survey_id = sur.survey_id and surh.template_question_id = sur.template_question_id and surh.survey_template_answer_id = sur.survey_template_answer_id)
left join eb.survey_template_answer sta on sur.survey_template_answer_id = sta.survey_template_answer_id
left join eb.SVEY_TMPL_ANSWER_TEXT stat on stat.survey_template_answer_id = sta.survey_template_answer_id
left join eb.survey_template_context stc on stc.survey_template_id = st.survey_template_id
where 1=1
and estc.value in ${TCAT}
group by sur.survey_id, st.survey_template_id,stg.survey_template_group_id,  nvl(stq.parent_template_question_id, stq.survey_template_question_id)
) sresp on sresp.response_survey_id = s.survey_id and sresp.resp_survey_template_id = st.survey_template_id and  sresp.resp_survey_template_group_id = stq.survey_template_group_id and sresp.response_template_question_id = stq.survey_template_question_id
where 1=1

and stq.sort_order is not null
and estc.value in ${TCAT}
and (
   (s.create_ts >= trunc(sysdate-450) and s.status_cd <> 'COMPLETED') 
   or (s.status_cd = 'COMPLETED' and s.status_date > trunc(sysdate-50)) 
   or ${QC_RQA_TRAN_ALL} = 1
--  or 1 = 1
--   or s.survey_id = 680737 
   )

