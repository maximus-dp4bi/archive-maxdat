--alter session set current_schema=maxdat;
create or replace view qc_review_score_hist_sv as 
select /*+ parallel(10) */
 st.survey_template_category_cd Department
, sr.survey_header_info_id
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
, schist.survey_score_hist_id section_1_id
, schist.survey_score section_1_score
, schist.sort_order section_1_sort_order
, schist.group_text section_1_group_text
, ssh.update_ts section_1_score_update_dt
, ssh.updated_by section_1_score_updated_by
, qcsc.first_name || ' '|| nvl(qcsc.middle_name,'') ||' '|| qcsc.last_name section_1_updated_name
, schist2.survey_score_hist_id section_2_id
, schist2.survey_score section_2_score
, schist.sort_order section_2_sort_order
, schist.group_text section_2_group_text
, ssh.update_ts section_2_score_update_dt
, ssh.updated_by section_2_score_updated_by
, qcsc.first_name || ' '|| nvl(qcsc.middle_name,'') ||' '|| qcsc.last_name section_2_updated_name
, schist3.survey_score_hist_id section_3_id
, schist3.survey_score section_3_score
, schist.sort_order section_3_sort_order
, schist.group_text section_3_group_text
, ssh.update_ts section_3_score_update_dt
, ssh.updated_by section_3_score_updated_by
, qcsc.first_name || ' '|| nvl(qcsc.middle_name,'') ||' '|| qcsc.last_name section_3_updated_name
, schist4.survey_score_hist_id section_4_id
, schist4.survey_score section_4_score
, schist.sort_order section_4_sort_order
, schist.group_text section_4_group_text
, ssh.update_ts section_4_score_update_dt
, ssh.updated_by section_4_score_updated_by
, qcsc.first_name || ' '|| nvl(qcsc.middle_name,'') ||' '|| qcsc.last_name section_4_updated_name
, schist5.survey_score_hist_id section_5_id
, schist5.survey_score section_5_score
, schist.sort_order section_5_sort_order
, schist.group_text section_5_group_text
, ssh.update_ts section_5_score_update_dt
, ssh.updated_by section_5_score_updated_by
, qcsc.first_name || ' '|| nvl(qcsc.middle_name,'') ||' '|| qcsc.last_name section_5_updated_name
from survey_header_info sr
join survey s on s.survey_id = sr.survey_id
join survey_template st on st.survey_template_id = s.survey_template_id
join enum_survey_template_category estc on estc.value = st.survey_template_category_cd
left join (select ssh1.survey_id, trunc(ssh1.create_ts,'MI') update_ts, ssh1.created_by updated_by 
      from maxdat.survey_score_hist ssh1
      group by ssh1.survey_id, trunc(ssh1.create_ts,'MI'), ssh1.created_by) ssh on ssh.survey_id = s.survey_id
left join qc_staff sup on sup.staff_id = sr.supervisor_id
left join qc_staff ag on ag.ext_staff_number = to_char(sr.agent_id)
left join qc_staff qcst on qcst.staff_id = s.created_by
left join qc_staff qcup on qcup.staff_id = s.updated_by
left join qc_staff qcsc on qcsc.staff_id = ssh.updated_by
left join maxdat.survey_template_context stc on stc.survey_template_id = st.survey_template_id
left join (
     select sshr2.*, dense_rank() over (partition by sshr2.survey_id order by sshr2.sort_order ) rowsort
            from (
            select sshr1.survey_id
            , stgr1.survey_template_id
            , stgr1.survey_template_group_id
            , sshr1.survey_score_hist_id
            , stgtr1.group_text
            , stgtr1.language_cd
            , stgr1.sort_order
            , sshr1.survey_score
            , sshr1.created_by 
            , trunc(sshr1.create_ts,'MI') create_ts
            , row_number() over (partition by sshr1.survey_id, stgr1.survey_template_id, stgr1.survey_template_group_id, trunc(sshr1.create_ts,'MI') order by trunc(sshr1.create_ts,'MI') asc) rown
            from maxdat.survey_score_hist sshr1
            join maxdat.survey_template_group stgr1 on stgr1.survey_template_group_id = sshr1.survey_template_group_id
            join maxdat.svey_tmpl_group_text stgtr1 on stgtr1.survey_template_group_id = stgr1.survey_template_group_id
            left join maxdat.qc_staff_sv qcstr1 on qcstr1.staff_id = sshr1.created_by
            ) sshr2
          where rown = 1
          ) schist on schist.survey_id = s.survey_id and schist.survey_templatE_id = s.survey_template_id and schist.rowsort = 1 and schist.create_ts = ssh.update_ts
left join (
     select sshr2.*, dense_rank() over (partition by sshr2.survey_id order by sshr2.sort_order ) rowsort
            from (
            select sshr1.survey_id
            , stgr1.survey_template_id
            , stgr1.survey_template_group_id
            , sshr1.survey_score_hist_id
            , stgtr1.group_text
            , stgtr1.language_cd
            , stgr1.sort_order
            , sshr1.survey_score
            , sshr1.created_by 
            , trunc(sshr1.create_ts,'MI') create_ts
            , row_number() over (partition by sshr1.survey_id, stgr1.survey_template_id, stgr1.survey_template_group_id, trunc(sshr1.create_ts,'MI') order by trunc(sshr1.create_ts,'MI') asc) rown
            from maxdat.survey_score_hist sshr1
            join maxdat.survey_template_group stgr1 on stgr1.survey_template_group_id = sshr1.survey_template_group_id
            join maxdat.svey_tmpl_group_text stgtr1 on stgtr1.survey_template_group_id = stgr1.survey_template_group_id
            left join maxdat.qc_staff_sv qcstr1 on qcstr1.staff_id = sshr1.created_by
            ) sshr2
          where rown = 1
          ) schist2 on schist2.survey_id = s.survey_id and schist2.survey_templatE_id = s.survey_template_id and schist2.rowsort = 1 and schist2.create_ts = ssh.update_ts
left join (
     select sshr2.*, dense_rank() over (partition by sshr2.survey_id order by sshr2.sort_order ) rowsort
            from (
            select sshr1.survey_id
            , stgr1.survey_template_id
            , stgr1.survey_template_group_id
            , sshr1.survey_score_hist_id
            , stgtr1.group_text
            , stgtr1.language_cd
            , stgr1.sort_order
            , sshr1.survey_score
            , sshr1.created_by 
            , trunc(sshr1.create_ts,'MI') create_ts
            , row_number() over (partition by sshr1.survey_id, stgr1.survey_template_id, stgr1.survey_template_group_id, trunc(sshr1.create_ts,'MI') order by trunc(sshr1.create_ts,'MI') asc) rown
            from maxdat.survey_score_hist sshr1
            join maxdat.survey_template_group stgr1 on stgr1.survey_template_group_id = sshr1.survey_template_group_id
            join maxdat.svey_tmpl_group_text stgtr1 on stgtr1.survey_template_group_id = stgr1.survey_template_group_id
            left join maxdat.qc_staff_sv qcstr1 on qcstr1.staff_id = sshr1.created_by
            ) sshr2
          where rown = 1
          ) schist3 on schist3.survey_id = s.survey_id and schist3.survey_templatE_id = s.survey_template_id and schist3.rowsort = 1 and schist3.create_ts = ssh.update_ts
left join (
     select sshr2.*, dense_rank() over (partition by sshr2.survey_id order by sshr2.sort_order ) rowsort
            from (
            select sshr1.survey_id
            , stgr1.survey_template_id
            , stgr1.survey_template_group_id
            , sshr1.survey_score_hist_id
            , stgtr1.group_text
            , stgtr1.language_cd
            , stgr1.sort_order
            , sshr1.survey_score
            , sshr1.created_by 
            , trunc(sshr1.create_ts,'MI') create_ts
            , row_number() over (partition by sshr1.survey_id, stgr1.survey_template_id, stgr1.survey_template_group_id, trunc(sshr1.create_ts,'MI') order by trunc(sshr1.create_ts,'MI') asc) rown
            from maxdat.survey_score_hist sshr1
            join maxdat.survey_template_group stgr1 on stgr1.survey_template_group_id = sshr1.survey_template_group_id
            join maxdat.svey_tmpl_group_text stgtr1 on stgtr1.survey_template_group_id = stgr1.survey_template_group_id
            left join maxdat.qc_staff_sv qcstr1 on qcstr1.staff_id = sshr1.created_by
            ) sshr2
          where rown = 1
          ) schist4 on schist4.survey_id = s.survey_id and schist4.survey_templatE_id = s.survey_template_id and schist4.rowsort = 1 and schist4.create_ts = ssh.update_ts
left join (
     select sshr2.*, dense_rank() over (partition by sshr2.survey_id order by sshr2.sort_order ) rowsort
            from (
            select sshr1.survey_id
            , stgr1.survey_template_id
            , stgr1.survey_template_group_id
            , sshr1.survey_score_hist_id
            , stgtr1.group_text
            , stgtr1.language_cd
            , stgr1.sort_order
            , sshr1.survey_score
            , sshr1.created_by 
            , trunc(sshr1.create_ts,'MI') create_ts
            , row_number() over (partition by sshr1.survey_id, stgr1.survey_template_id, stgr1.survey_template_group_id, trunc(sshr1.create_ts,'MI') order by trunc(sshr1.create_ts,'MI') asc) rown
            from maxdat.survey_score_hist sshr1
            join maxdat.survey_template_group stgr1 on stgr1.survey_template_group_id = sshr1.survey_template_group_id
            join maxdat.svey_tmpl_group_text stgtr1 on stgtr1.survey_template_group_id = stgr1.survey_template_group_id
            left join maxdat.qc_staff_sv qcstr1 on qcstr1.staff_id = sshr1.created_by
            ) sshr2
          where rown = 1
          ) schist5 on schist5.survey_id = s.survey_id and schist5.survey_templatE_id = s.survey_template_id and schist5.rowsort = 1 and schist5.create_ts = ssh.update_ts
where 1=1
--and s.survey_id = 743222
--and st.title like '%QC%'
--and stc.ref_type = 'QCREVIEW'
;

grant select on qc_review_score_hist_sv to maxdat_read_only;
grant select on qc_review_score_hist_sv to maxdat_reports;
