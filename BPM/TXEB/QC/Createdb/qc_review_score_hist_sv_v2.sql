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
, shi.brief_call_summary       
, sr.error_comment            
, sr.supporting_documentation 
, shi.challenge_type           
, sup.first_name sup_first_name
, sup.last_name sup_last_name
, sup.middle_name sup_middle_name
, sup.first_name || ' ' ||nvl(sup.middle_name,'') ||' '|| sup.last_name sup_display_name
, CASE WHEN LENGTH(sr.agent_id) >= 5 THEN TO_CHAR(sr.agent_id) ELSE LPAD(to_char(sr.agent_id),5,'0') END agent_id
, CASE WHEN LENGTH(ag.ext_staff_number) >= 5 THEN ag.ext_staff_number ELSE LPAD(ag.ext_staff_number,5,'0') END ext_staff_number
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
, COALESCE(hs.status_cd,s.status_cd) survey_status_cd
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
, schist2.sort_order section_2_sort_order
, schist2.group_text section_2_group_text
, ssh.update_ts section_2_score_update_dt
, ssh.updated_by section_2_score_updated_by
, qcsc.first_name || ' '|| nvl(qcsc.middle_name,'') ||' '|| qcsc.last_name section_2_updated_name
, schist3.survey_score_hist_id section_3_id
, schist3.survey_score section_3_score
, case when schist3.survey_score_hist_id is null then null else schist3.sort_order end section_3_sort_order
, case when schist3.survey_score_hist_id is null then null else schist3.group_text end section_3_group_text
, case when schist3.survey_score_hist_id is null then null else ssh.update_ts end section_3_score_update_dt
, case when schist3.survey_score_hist_id is null then null else ssh.updated_by end section_3_score_updated_by
, case when schist3.survey_score_hist_id is null then null else qcsc.first_name || ' '|| nvl(qcsc.middle_name,'') ||' '|| qcsc.last_name end section_3_updated_name
, schist4.survey_score_hist_id section_4_id
, schist4.survey_score section_4_score
, case when schist4.survey_score_hist_id is null then null else schist4.sort_order end section_4_sort_order
, case when schist4.survey_score_hist_id is null then null else schist4.group_text end section_4_group_text
, case when schist4.survey_score_hist_id is null then null else ssh.update_ts end section_4_score_update_dt
, case when schist4.survey_score_hist_id is null then null else ssh.updated_by end section_4_score_updated_by
, case when schist4.survey_score_hist_id is null then null else qcsc.first_name || ' '|| nvl(qcsc.middle_name,'') ||' '|| qcsc.last_name end section_4_updated_name
, schist5.survey_score_hist_id section_5_id
, schist5.survey_score section_5_score
, case when schist5.survey_score_hist_id is null then null else schist5.sort_order end section_5_sort_order
, case when schist5.survey_score_hist_id is null then null else schist5.group_text end section_5_group_text
, case when schist5.survey_score_hist_id is null then null else ssh.update_ts end section_5_score_update_dt
, case when schist5.survey_score_hist_id is null then null else ssh.updated_by end section_5_score_updated_by
, case when schist5.survey_score_hist_id is null then null else qcsc.first_name || ' '|| nvl(qcsc.middle_name,'') ||' '|| qcsc.last_name end section_5_updated_name
, CASE WHEN sr.call_duration IS NULL THEN NULL
   ELSE TO_CHAR(TRUNC(sr.call_duration/3600),'FM9900') || ':' ||TO_CHAR(TRUNC(MOD(sr.call_duration,3600)/60),'FM00') || ':' ||TO_CHAR(MOD(sr.call_duration,60),'FM00') END call_duration_hhmiss
,shi.tracking_date
,rsup.reviewer_supervisor_id
,rsup.reviewer_supervisor_name
, trunc(sr.date_of_call,'IW')-1 date_of_call_week_start
, (trunc(sr.date_of_call,'IW')-1) +6 date_of_call_week_end
, trunc(sr.review_date,'IW')-1 review_week_start
, (trunc(sr.review_date,'IW')-1)+6 review_week_end
from survey_header_info sr
join survey s on s.survey_id = sr.survey_id
join survey_template st on st.survey_template_id = s.survey_template_id
join enum_survey_template_category estc on estc.value = st.survey_template_category_cd
left join (select * from (
      select DISTINCT s.staff_id,rsup.staff_id reviewer_supervisor_id, rsup.first_name||CASE WHEN rsup.middle_name IS NULL THEN ' ' ELSE ' '||rsup.middle_name||' ' END||rsup.last_name reviewer_supervisor_name,
          RANK() OVER (PARTITION BY CASE WHEN LENGTH(rsup.ext_staff_number) >= 5 THEN rsup.ext_staff_number ELSE LPAD(rsup.ext_staff_number,5,'0') END ORDER BY rsup.end_date DESC NULLS FIRST) rn
      from qc_staff s       
      join qc_staff rsup on rsup.ext_staff_number = s.supervisor_empid)
      where rn = 1) rsup ON TO_CHAR(rsup.staff_id) = sr.created_by 
left join (select ssh1.survey_id, trunc(ssh1.create_ts,'MI') update_ts, ssh1.created_by updated_by 
      from maxdat.survey_score_hist ssh1
      group by ssh1.survey_id, trunc(ssh1.create_ts,'MI'), ssh1.created_by) ssh on ssh.survey_id = s.survey_id
left join (select shi1.survey_id, trunc(shi1.create_ts,'MI') update_ts, shi1.created_by updated_by ,challenge_type,brief_call_summary,tracking_date
           from maxdat.survey_header_info_hist shi1     
           group by shi1.survey_id, trunc(shi1.create_ts,'MI'), shi1.created_by,challenge_type,brief_call_summary,tracking_date )shi ON shi.survey_id = s.survey_id AND shi.update_ts = ssh.update_ts     
left join (select hs.survey_id, trunc(hs.creation_date,'MI') update_ts, hs.created_by updated_by,hs.status_cd
           from maxdat.survey_status_history hs     
           group by hs.survey_id, trunc(hs.creation_date,'MI'), hs.created_by,hs.status_cd )hs ON hs.survey_id = s.survey_id AND hs.update_ts = ssh.update_ts                
left join (select *
           from(select sup.last_name
                      ,sup.first_name
                      ,sup.middle_name
                      ,sup.ext_staff_number
                      ,sup.staff_id
                      ,CASE WHEN LENGTH(sup.ext_staff_number) >= 5 THEN sup.ext_staff_number ELSE LPAD(sup.ext_staff_number,5,'0') END ext_staff_number_drv
                      ,RANK() OVER (PARTITION BY CASE WHEN LENGTH(sup.ext_staff_number) >= 5 THEN sup.ext_staff_number ELSE LPAD(sup.ext_staff_number,5,'0') END ORDER BY sup.end_date DESC NULLS FIRST) rn
                from qc_staff sup)
           where rn = 1) sup on sup.ext_staff_number_drv = (CASE WHEN LENGTH(sr.supervisor_id) >= 5 THEN TO_CHAR(sr.supervisor_id) ELSE LPAD(TO_CHAR(sr.supervisor_id),5,'0') END)
left join (select *
           from(select ag.last_name
                      ,ag.first_name
                      ,ag.middle_name
                      ,ag.staff_id
                      ,ag.ext_staff_number
                      ,ag.title
                      ,RANK() OVER (PARTITION BY CASE WHEN LENGTH(ag.ext_staff_number) >= 5 THEN ag.ext_staff_number ELSE LPAD(ag.ext_staff_number,5,'0') END ORDER BY ag.end_date DESC NULLS FIRST) rn
                      ,CASE WHEN LENGTH(ag.ext_staff_number) >= 5 THEN ag.ext_staff_number ELSE LPAD(ag.ext_staff_number,5,'0') END ext_staff_number_drv
                from qc_staff ag)
           where rn = 1) ag on ag.ext_staff_number_drv = (CASE WHEN LENGTH(sr.agent_id) >= 5 THEN TO_CHAR(sr.agent_id) ELSE LPAD(TO_CHAR(sr.agent_id),5,'0') END)
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
          ) schist2 on schist2.survey_id = s.survey_id and schist2.survey_templatE_id = s.survey_template_id and schist2.rowsort = 2 and schist2.create_ts = ssh.update_ts
left join (
     select sshr32.*, dense_rank() over (partition by sshr32.survey_id order by sshr32.sort_order ) rowsort
            from (
            select sshr3.survey_id
            , stgr3.survey_template_id
            , stgr3.survey_template_group_id
            , sshr3.survey_score_hist_id
            , stgtr3.group_text
            , stgtr3.language_cd
            , stgr3.sort_order
            , sshr3.survey_score
            , sshr3.created_by 
            , trunc(sshr3.create_ts,'MI') create_ts
            , row_number() over (partition by sshr3.survey_id, stgr3.survey_template_id, stgr3.survey_template_group_id, trunc(sshr3.create_ts,'MI') order by trunc(sshr3.create_ts,'MI') asc) rown
            from maxdat.survey_score_hist sshr3
            join maxdat.survey_template_group stgr3 on stgr3.survey_template_group_id = sshr3.survey_template_group_id
            join maxdat.svey_tmpl_group_text stgtr3 on stgtr3.survey_template_group_id = stgr3.survey_template_group_id
            left join maxdat.qc_staff_sv qcstr3 on qcstr3.staff_id = sshr3.created_by
            ) sshr32
          where rown = 1
          ) schist3 on schist3.survey_id = s.survey_id and schist3.survey_templatE_id = s.survey_template_id and schist3.rowsort = 3 and schist3.create_ts = ssh.update_ts
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
          ) schist4 on schist4.survey_id = s.survey_id and schist4.survey_templatE_id = s.survey_template_id and schist4.rowsort = 4 and schist4.create_ts = ssh.update_ts
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
          ) schist5 on schist5.survey_id = s.survey_id and schist5.survey_templatE_id = s.survey_template_id and schist5.rowsort = 5 and schist5.create_ts = ssh.update_ts
where 1=1
--and s.survey_id = 743222
--and st.title like '%QC%'
--and stc.ref_type = 'QCREVIEW'
;

grant select on qc_review_score_hist_sv to maxdat_read_only;
grant select on qc_review_score_hist_sv to maxdat_reports;
