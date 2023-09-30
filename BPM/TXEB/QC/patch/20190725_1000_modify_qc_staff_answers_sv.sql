CREATE OR REPLACE VIEW MAXDAT.QC_STAFF_ANSWERS_SV
AS with y1 as (
select sy.survey_id, sy.survey_template_id, sy.created_by, sy.create_ts, sy.updated_by, sy.update_ts, sy.status_cd
, sh.id_num, sh.supervisor_id, sh.agent_id, sh.review_date, sh.date_of_call, stf.first_name||' '||stf.last_name as supervisor_name, stf2.first_name||' '||stf2.last_name as agent_name
, stf3.first_name||' '||stf3.last_name as reviewer_name, sr.template_question_id, sr.survey_template_answer_id, qt.question_text, aw.answer_text, sh.contact_language, sh.dcn, sh.review_type, sh.entry_date, sh.medicaid_chip_id
, gtt.group_text, tq.parent_template_question_id
, sr.comments
, case when ((upper(aw.answer_text) like 'NO%') or (upper(aw.answer_text) like 'DID NOT%')) then 1 else 0 end answer_is_no
from maxdat.SURVEY sy
LEFT OUTER JOIN maxdat.SURVEY_HEADER_INFO sh                  ON sy.survey_id = sh.survey_id
LEFT OUTER JOIN maxdat.SURVEY_RESPONSE sr                     ON sy.survey_id = sr.survey_id
LEFT OUTER JOIN maxdat.SVEY_TMPL_QUESTION_TEXT qt             ON sr.template_question_id = qt.survey_template_question_id
LEFT OUTER JOIN maxdat.SVEY_TMPL_ANSWER_TEXT aw               ON sr.survey_template_answer_id = aw.survey_template_answer_id
left JOIN maxdat.QC_STAFF stf                                      ON sh.supervisor_id = stf.staff_id
left JOIN maxdat.qc_staff stf2                                     ON to_char(sh.agent_id) = stf2.ext_staff_number
left JOIN maxdat.qc_staff stf3                                     ON sh.created_by = stf3.staff_id
LEFT OUTER JOIN maxdat.SURVEY_TEMPLATE_QUESTION tq            ON sr.template_question_id = tq.survey_template_question_id
LEFT OUTER JOIN maxdat.SVEY_TMPL_GROUP_TEXT gtt               ON tq.survey_template_group_id = gtt.survey_template_group_id
--where 1=1
--and sh.date_of_call between '01-aug-2018' and '31-aug-2018'
--and sy.status_cd IN ('COMPLETED','MODIFIED')
--and ((upper(aw.answer_text) like 'NO%') or (upper(aw.answer_text) like 'DID NOT%'))
--order by sy.survey_id, sr.template_question_id
)
, c2 as (
select sy.survey_id, tq.parent_template_question_id, sr.template_question_id as child_question_id--, y1.survey_template_answer_id as child_answer_id--, y1.question_text
, listagg(aw.answer_text, ';') within group (order by aw.answer_text) as child_answer
, listagg(sr.comments, ';') within group (order by sr.survey_template_answer_id) as child_comments
from maxdat.SURVEY sy
LEFT OUTER JOIN maxdat.SURVEY_HEADER_INFO sh                  ON sy.survey_id = sh.survey_id
LEFT OUTER JOIN maxdat.SURVEY_RESPONSE sr                     ON sy.survey_id = sr.survey_id
LEFT OUTER JOIN maxdat.SVEY_TMPL_QUESTION_TEXT qt             ON sr.template_question_id = qt.survey_template_question_id
LEFT OUTER JOIN maxdat.SVEY_TMPL_ANSWER_TEXT aw               ON sr.survey_template_answer_id = aw.survey_template_answer_id
LEFT OUTER JOIN maxdat.SURVEY_TEMPLATE_QUESTION tq            ON sr.template_question_id = tq.survey_template_question_id
LEFT OUTER JOIN maxdat.SVEY_TMPL_GROUP_TEXT gtt               ON tq.survey_template_group_id = gtt.survey_template_group_id
where 1=1
--and sy.status_cd IN ('COMPLETED','MODIFIED')
--and ((upper(aw.answer_text) like 'NO%') or (upper(aw.answer_text) like 'DID NOT%'))
and tq.parent_template_question_id is not null
group by sy.survey_id, tq.parent_template_question_id, sr.template_question_id, sr.survey_template_answer_id
)
select y1.survey_id, y1.survey_template_id, y1.created_by, y1.create_ts, y1.updated_by, y1.update_ts, y1.status_cd, y1.id_num, y1.supervisor_id, y1.agent_id, y1.review_date, y1.date_of_call
, y1.supervisor_name, y1.agent_name, y1.reviewer_name, y1.template_question_id, y1.survey_template_answer_id, y1.question_text,y1.group_text, y1.answer_text
, y1.answer_text||'; '||c2.child_answer as combined_answer
, y1.comments||case when c2.child_comments is not null then '; '|| c2.child_comments else c2.child_comments end as combined_comments
,y1.contact_language, y1.dcn, y1.review_type, y1.entry_date, y1.medicaid_chip_id
from y1
LEFT OUTER JOIN c2
ON (y1.survey_id = c2.survey_id
and y1.template_question_id = c2.parent_template_question_id)
where 1=1
and y1.parent_template_question_id is null;

GRANT SELECT ON MAXDAT.QC_STAFF_ANSWERS_SV TO maxdat_read_only;
GRANT SELECT ON MAXDAT.QC_STAFF_ANSWERS_SV TO maxdat_reports;