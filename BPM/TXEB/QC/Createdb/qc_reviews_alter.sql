--drop table qc_reviews_;

create or replace view qc_reviews_sv as
select /*+ parallel(10) */
sr.survey_header_info_id
, sr.survey_id
, sr.supervisor_id
, cisco_agent_id           
, sr.client_program           
, sr.call_type                
, sr.call_duration            
, sr.calibration              
, sr.brief_call_summary       
, sr.error_comment            
, sr.supporting_documentation 
, sr.challenge_type           
, sup.first_name sup_first_name
, sup.last_name sup_last_name
, sup.middle_name sup_middle_name
, sup.first_name || ' ' ||nvl(sup.middle_name,'') ||' '|| sup.last_name sup_display_name
, sr.agent_id
, ag.ext_staff_number
, ag.first_name ag_first_name
, ag.last_name ag_last_name
, ag.middle_name ag_middle_name
, ag.first_name || ' ' || nvl(ag.middle_name,'') || ' '|| ag.last_name ag_display_name
, ag.title ag_title
, qcst.first_name || ' '|| nvl(qcst.middle_name,'') ||' '|| qcst.last_name qcst_display_name
, sr.review_date
, trunc(sr.review_date,'IW') review_week_dt
, sr.created_by
, sr.create_ts
, sr.updated_by
, sr.update_ts
, sr.id_num
, sr.date_of_call
, trunc(sr.date_of_call,'IW') date_of_call_week_dt
, s.client_id
, s.case_id
, s.comments survey_comments
, s.status_cd survey_status_cd
, s.survey_template_id
, s.language_cd survey_language_cd
, st.title
, st.survey_template_category_cd
from survey_header_info sr
join survey s on s.survey_id = sr.survey_id
join survey_template st on st.survey_template_id = s.survey_template_id
join enum_survey_template_category estc on estc.value = st.survey_template_category_cd
left join qc_staff sup on sup.staff_id = sr.supervisor_id
left join qc_staff ag on ag.ext_staff_number = to_char(sr.agent_id)
left join qc_staff qcst on qcst.staff_id = s.created_by
left join survey_template_context stc on stc.survey_template_id = st.survey_template_id
--where 1=1
--and st.title like '%QC%'
--and stc.ref_type = 'QCREVIEW'
;

grant select on QC_REVIEWS_sv to maxdat_read_only;
grant select on QC_REVIEWS_sv to maxdat_reports;

Create or replace view qc_scores_sv as
select * 
from (
select 
ss.*
, stg.sort_order
, stgt.group_text
, row_number() over(partition by ss.survey_id, ss.survey_template_group_id order by ss.update_ts desc) rown
 from survey_score ss
join survey_template_group stg on stg.survey_template_group_id = ss.survey_template_group_id
left join maxdat.svey_tmpl_group_text stgt on stgt.survey_template_group_id = stg.survey_template_group_id
)
where rown = 1
;

grant select on qc_scores_sv to maxdat_read_only;
grant select on qc_scores_sv to maxdat_reports;
