DROP VIEW MAXDAT_SUPPORT.EMRS_D_TAILORED_PLAN_SURVEY_SV;
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_TAILORED_PLAN_SURVEY_SV" ("SURVEY_ID", "SURVEY_TEMPLATE_ID", "TITLE", "SURVEY_DATE", "SURVEY_TIME", "STATUS_CD2", "STAFF_ID", "CREATED_BY", "CLIENT_ID", "CLIENT_CIN", "CASE_ID", "CASE_CIN", "STATUS_DATE", "MVX", "MCS", "SUBPROGRAM_TYPE", "ANSWER_1", "ANSWER_2", "ANSWER_3", "ANSWER_4", "ANSWER_5", "TRANSACTION_TYPE_CD", "STATUS_CD", "PLAN_ID_EXT", "START_DATE", "SELECTION_TXN_ID", "Survey Completed Before Enrollment") AS 
  select x."SURVEY_ID",x."SURVEY_TEMPLATE_ID",x."TITLE",x."SURVEY_DATE",x."SURVEY_TIME",x."STATUS_CD2",x."STAFF_ID",x."CREATED_BY",x."CLIENT_ID",x."CLIENT_CIN",x."CASE_ID",x."CASE_CIN",x."STATUS_DATE",x."MVX",x."MCS",x."SUBPROGRAM_TYPE",x."ANSWER_1",x."ANSWER_2",x."ANSWER_3",x."ANSWER_4",x."ANSWER_5"
, t.transaction_type_cd , t.status_cd , t.plan_id_ext , t.start_date , t.selection_txn_id 
, case when t.selection_txn_id is null then null
       when x.status_date < t.create_ts then 'Yes' else 'No' end "Survey Completed Before Enrollment"
from (
select s.survey_id, st.survey_template_id, st.title, trunc(s.status_date) survey_date , to_char(s.status_date,'HH:MM AM') survey_time , s.status_cd status_cd2, st.staff_id , st.last_name||', '||st.first_name created_by
, sc1.ref_value client_id , i.client_cin , sc2.ref_value case_id , i.case_cin , s.status_date
, es.elig_status_cd mvx , es.reasons mcs , es.subprogram_type
, sq1.answer_text answer_1 , sq2.answer_text answer_2 , sq3.answer_text answer_3 , sq4.answer_text answer_4 , sq5.answer_text answer_5
from survey s
join survey_template st on st.survey_template_id = s.survey_template_id
and st.title IN('Tailored Plan Acknowledgement' ,'TP 2022 Acknowledgement','TP 2023 Acknowledgement')
join survey_context sc1 on sc1.survey_id = s.survey_id
join survey_template_context stc1 on stc1.survey_template_context_id = sc1.survey_template_context_id
and stc1.ref_type = 'CLIENT' 
join client_supplementary_info i on i.client_id = sc1.ref_value
join client_elig_status es on es.client_id = i.client_id
and es.end_date is null
join survey_context sc2 on sc2.survey_id = s.survey_id
join survey_template_context stc2 on stc2.survey_template_context_id = sc2.survey_template_context_id
and stc2.ref_type = 'CASE' 
join staff st on st.staff_id = s.created_by
-- question #1
left outer join ( select sr1.survey_id , at1.*
      from survey_response sr1 
      join survey_template_question q1 on q1.survey_template_question_id = sr1.template_question_id
       and q1.question_number = '1'
      join svey_tmpl_answer_text at1 on at1.survey_template_answer_id = sr1.survey_template_answer_id ) sq1 on sq1.survey_id = s.survey_id
-- question #2
left outer join ( select sr2.survey_id , at2.*
      from survey_response sr2 
      join survey_template_question q2 on q2.survey_template_question_id = sr2.template_question_id
       and q2.question_number = '2'
      join svey_tmpl_answer_text at2 on at2.survey_template_answer_id = sr2.survey_template_answer_id ) sq2 on sq2.survey_id = s.survey_id
-- question #3
left outer join ( select sr3.survey_id , at3.*
      from survey_response sr3 
      join survey_template_question q3 on q3.survey_template_question_id = sr3.template_question_id
       and q3.question_number = '3'
      join svey_tmpl_answer_text at3 on at3.survey_template_answer_id = sr3.survey_template_answer_id ) sq3 on sq3.survey_id = s.survey_id
-- question #4
left outer join ( select sr4.survey_id , at4.*
      from survey_response sr4 
      join survey_template_question q4 on q4.survey_template_question_id = sr4.template_question_id
       and q4.question_number = '4'
      join svey_tmpl_answer_text at4 on at4.survey_template_answer_id = sr4.survey_template_answer_id ) sq4 on sq4.survey_id = s.survey_id
-- question #5
left outer join ( select sr5.survey_id , at5.*
      from survey_response sr5 
      join survey_template_question q5 on q5.survey_template_question_id = sr5.template_question_id
       and q5.question_number = '5'
      join svey_tmpl_answer_text at5 on at5.survey_template_answer_id = sr5.survey_template_answer_id ) sq5 on sq5.survey_id = s.survey_id ) x
left outer join ( select tx.* , rank() over ( partition by tx.client_id order by tx.selection_txn_id desc ) ranking 
                   from selection_txn tx
                  where tx.status_cd <> 'invalid' ) t on t.client_id = x.client_id
and t.ranking = 1
--where x.status_date like sysdate - 1
WHERE TRUNC(T.CREATE_TS) > TO_DATE('3/01/2021','MM/DD/YYYY')
UNION all
select x."SURVEY_ID",x."SURVEY_TEMPLATE_ID",x."TITLE",x."SURVEY_DATE",x."SURVEY_TIME",x."STATUS_CD2",x."STAFF_ID",x."CREATED_BY",x."CLIENT_ID",x."CLIENT_CIN",x."CASE_ID",x."CASE_CIN",x."STATUS_DATE",x."MVX",x."MCS",x."SUBPROGRAM_TYPE",x."ANSWER_1",x."ANSWER_2",x."ANSWER_3",x."ANSWER_4",x."ANSWER_5"
, t.transaction_type_cd , t.status_cd , t.plan_id_ext , t.start_date , t.selection_txn_id 
, case when t.selection_txn_id is null then null
       when x.status_date < t.create_ts then 'No' else 'Yes' end "Survey Completed After Enrollment"
from (
select s.survey_id , st.survey_template_id, st.title, trunc(s.status_date) survey_date , to_char(s.status_date,'HH:MM AM') survey_time , s.status_cd status_cd2, st.staff_id , st.last_name||', '||st.first_name created_by
, sc1.ref_value client_id , i.client_cin , sc2.ref_value case_id , i.case_cin , s.status_date
, es.elig_status_cd mvx , es.reasons mcs , es.subprogram_type
, sq1.answer_text answer_1 , sq2.answer_text answer_2 , sq3.answer_text answer_3 , sq4.answer_text answer_4 , sq5.answer_text answer_5
from survey s
join survey_template st on st.survey_template_id = s.survey_template_id
and st.title like 'Enrollment Confirmation%'
join survey_context sc1 on sc1.survey_id = s.survey_id
join survey_template_context stc1 on stc1.survey_template_context_id = sc1.survey_template_context_id
and stc1.ref_type = 'CLIENT' 
join client_supplementary_info i on i.client_id = sc1.ref_value
join client_elig_status es on es.client_id = i.client_id
and es.end_date is null
join survey_context sc2 on sc2.survey_id = s.survey_id
join survey_template_context stc2 on stc2.survey_template_context_id = sc2.survey_template_context_id
and stc2.ref_type = 'CASE' 
join staff st on st.staff_id = s.created_by
-- question #1
left outer join ( select sr1.survey_id , at1.*
      from survey_response sr1 
      join survey_template_question q1 on q1.survey_template_question_id = sr1.template_question_id
       and q1.question_number = '1'
      join svey_tmpl_answer_text at1 on at1.survey_template_answer_id = sr1.survey_template_answer_id ) sq1 on sq1.survey_id = s.survey_id
-- question #2
left outer join ( select sr2.survey_id , at2.*
      from survey_response sr2 
      join survey_template_question q2 on q2.survey_template_question_id = sr2.template_question_id
       and q2.question_number = '2'
      join svey_tmpl_answer_text at2 on at2.survey_template_answer_id = sr2.survey_template_answer_id ) sq2 on sq2.survey_id = s.survey_id
-- question #3
left outer join ( select sr3.survey_id , at3.*
      from survey_response sr3 
      join survey_template_question q3 on q3.survey_template_question_id = sr3.template_question_id
       and q3.question_number = '3'
      join svey_tmpl_answer_text at3 on at3.survey_template_answer_id = sr3.survey_template_answer_id ) sq3 on sq3.survey_id = s.survey_id
-- question #4
left outer join ( select sr4.survey_id , at4.*
      from survey_response sr4 
      join survey_template_question q4 on q4.survey_template_question_id = sr4.template_question_id
       and q4.question_number = '4'
      join svey_tmpl_answer_text at4 on at4.survey_template_answer_id = sr4.survey_template_answer_id ) sq4 on sq4.survey_id = s.survey_id
-- question #5
left outer join ( select sr5.survey_id , at5.*
      from survey_response sr5 
      join survey_template_question q5 on q5.survey_template_question_id = sr5.template_question_id
       and q5.question_number = '5'
      join svey_tmpl_answer_text at5 on at5.survey_template_answer_id = sr5.survey_template_answer_id ) sq5 on sq5.survey_id = s.survey_id ) x
left outer join ( select tx.* , rank() over ( partition by tx.client_id order by tx.selection_txn_id desc ) ranking 
                   from selection_txn tx
                  where tx.status_cd <> 'invalid' ) t on t.client_id = x.client_id
and t.ranking = 1
WHERE TRUNC(T.CREATE_TS) > TO_DATE('3/01/2021','MM/DD/YYYY');

GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_TAILORED_PLAN_SURVEY_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_TAILORED_PLAN_SURVEY_SV TO MAXDAT_REPORTS;

DROP VIEW MAXDAT_SUPPORT.EMRS_D_TAILORED_PLAN_TRANS_SV;
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_TAILORED_PLAN_TRANS_SV"  AS 
  select x.CLIENT_ID, x.client_cin, x.CASE_ID, x.case_cin, x.STAFF_ID, x.trans_date, x.trans_time, x.selection_source_cd, x.transaction_type_cd 
, x.mvx, x.mcs, x.plan_id_ext, x.start_date, x.status_cd
, case when COALESCE(x.ack_ct,0) = 0 then 'No' else 'Yes' end "Acknowledgment Exists"
, case when COALESCE(x.conf_ct,0) = 0 then 'No' else 'Yes' end "Confirmation Exists"
, x.created_by,x.plan_service_type_cd,x.subprogram_type
from (
select i.CLIENT_ID, I.CASE_ID, i.case_cin , i.client_cin , st.STAFF_ID, trunc(t.create_ts) trans_date , to_char(t.create_ts,'MI:HH AM') trans_time
, st.last_name||', '||st.first_name created_by , t.transaction_type_cd , es.elig_status_cd mvx, es.reasons mcs, t.selection_source_cd , t.plan_id_ext , t.start_date
, t.status_cd,t.plan_service_type_cd  
, (select count(1) from survey s1
      join survey_template st1 on st1.survey_template_id = s1.survey_template_id             
      join survey_context sc1 on sc1.survey_id = s1.survey_id
      join survey_template_context stc1 on stc1.survey_template_context_id = sc1.survey_template_context_id
       and stc1.ref_type = 'CLIENT' 
     where st1.title IN('Tailored Plan Acknowledgement' ,'TP 2022 Acknowledgement','TP 2023 Acknowledgement')
     and sc1.ref_value = t.client_id 
     and trunc(s1.status_date) BETWEEN trunc(t.create_ts) AND trunc(t.create_ts) + 7
     and s1.status_cd = 'COMPLETED') ack_ct
, ( select count(1) from survey s2
      join survey_template st2 on st2.survey_template_id = s2.survey_template_id      
      join survey_context sc2 on sc2.survey_id = s2.survey_id
      join survey_template_context stc2 on stc2.survey_template_context_id = sc2.survey_template_context_id
       and stc2.ref_type = 'CLIENT' 
     where st2.title like 'Enrollment Confirmation%' 
     and sc2.ref_value = t.client_id 
     and trunc(s2.status_date) BETWEEN trunc(t.create_ts) AND trunc(t.create_ts) + 7
     and s2.status_cd = 'COMPLETED') conf_ct
,es.subprogram_type     
from (SELECT t.*,ct.plan_service_type_cd FROM selection_txn t
       LEFT JOIN contract ct ON t.contract_id = ct.contract_id
      WHERE LENGTH(TRIM(TRANSLATE(t.created_by, ' +-.0123456789',' '))) IS NULL) t -- verify created_by contains only numeric data
join client_supplementary_info i on i.client_id = t.client_id
join client_elig_status es on es.client_id = t.client_id
and es.end_date is null
and es.elig_status_cd = 'V'
and es.reasons in ('MCS005','MCS027','MCS035')
join staff st on st.staff_id = t.created_by
WHERE TRUNC(T.CREATE_TS) > TO_DATE('3/01/2021','MM/DD/YYYY') 
and t.status_cd <> 'invalid' ) x
--order by x.case_cin , x.client_cin
;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_TAILORED_PLAN_TRANS_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_TAILORED_PLAN_TRANS_SV TO MAXDAT_REPORTS;


