CREATE OR REPLACE VIEW MAXDAT.QC_REVIEWS_SV
AS select 
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
, sr.CONTACT_LANGUAGE
, sr.DCN
, sr.REVIEW_TYPE
, sr.ENTRY_DATE
, sr.MEDICAID_CHIP_ID
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
left join survey_template_context stc on stc.survey_template_id = st.survey_template_id;

GRANT SELECT ON MAXDAT.QC_REVIEWS_SV TO maxdat_read_only;
GRANT SELECT ON MAXDAT.QC_REVIEWS_SV TO maxdat_reports;
