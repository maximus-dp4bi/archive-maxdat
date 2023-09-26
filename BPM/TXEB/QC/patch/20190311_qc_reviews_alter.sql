
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
, qcup.first_name || ' '|| nvl(qcup.middle_name,'') ||' '|| qcup.last_name updated_by_display_name
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
, CASE WHEN sr.call_duration IS NULL THEN NULL
   ELSE TO_CHAR(TRUNC(sr.call_duration/3600),'FM9900') || ':' ||TO_CHAR(TRUNC(MOD(sr.call_duration,3600)/60),'FM00') || ':' ||TO_CHAR(MOD(sr.call_duration,60),'FM00') END call_duration_hhmiss
, sr.tracking_date   
, rsup.reviewer_supervisor_id
, rsup.reviewer_supervisor_name
, trunc(sr.date_of_call,'IW')-1 date_of_call_week_start
, (trunc(sr.date_of_call,'IW')-1) +6 date_of_call_week_end
, trunc(sr.review_date,'IW')-1 review_week_start
, (trunc(sr.review_date,'IW')-1)+6 review_week_end
from survey_header_info sr
join survey s on s.survey_id = sr.survey_id
join survey_template st on st.survey_template_id = s.survey_template_id
join enum_survey_template_category estc on estc.value = st.survey_template_category_cd
join (select DISTINCT s.staff_id,rsup.staff_id reviewer_supervisor_id, rsup.first_name||CASE WHEN rsup.middle_name IS NULL THEN ' ' ELSE ' '||rsup.middle_name||' ' END||rsup.last_name reviewer_supervisor_name
      from d_staff s
       join group_staff_stg gs on s.default_group_id = gs.group_id
       join groups_stg g on g.group_id = s.default_group_id
       join d_staff rsup on rsup.staff_id = g.supervisor_staff_id) rsup ON TO_CHAR(rsup.staff_id) = sr.created_by 
left join qc_staff sup on sup.staff_id = sr.supervisor_id
left join qc_staff ag on ag.ext_staff_number = to_char(sr.agent_id)
left join qc_staff qcst on qcst.staff_id = s.created_by
left join qc_staff qcup on qcup.staff_id = s.updated_by
left join survey_template_context stc on stc.survey_template_id = st.survey_template_id
--where 1=1
--and st.title like '%QC%'
--and stc.ref_type = 'QCREVIEW'
;


grant select on QC_REVIEWS_sv to maxdat_read_only;
grant select on QC_REVIEWS_sv to maxdat_reports;
