CREATE OR REPLACE VIEW d_pa_assessment_questions_sv
AS
  SELECT a.assessment_id
    ,MAX(CASE WHEN q.QUESTION = 'NEED_INTERPRETER' THEN ANSWER ELSE NULL END) AS NEED_INTERPRETER
    ,MAX(CASE WHEN q.QUESTION = 'INTERPRETER_LANG' THEN ANSWER ELSE NULL END) AS INTERPRETER_LANG
    ,MAX(CASE WHEN q.QUESTION = 'INTERPRETER_LANG' THEN l.REPORT_LABEL ELSE NULL END) AS INTERPRETER_LANG_DESC
    ,MAX(CASE WHEN q.QUESTION = 'DATE_CONDUCTED' THEN ANSWER ELSE NULL END) AS DATE_CONDUCTED
    ,MAX(CASE WHEN q.QUESTION = 'CONDUCTED_START_TIME' THEN ANSWER ELSE NULL END) AS CONDUCTED_START_TIME
    ,MAX(CASE WHEN q.QUESTION = 'CONDUCTED_END_TIME' THEN ANSWER ELSE NULL END) AS CONDUCTED_END_TIME
    ,MAX(CASE WHEN q.QUESTION = 'INTERPRETER_USED' THEN ANSWER ELSE NULL END) AS INTERPRETER_USED
    ,MAX(CASE WHEN q.QUESTION = 'JUDGE_PRESIDING' THEN ANSWER ELSE NULL END) AS JUDGE_PRESIDING
    ,MAX(CASE WHEN q.QUESTION = 'LOCATION_OF_HEARING' THEN ANSWER ELSE NULL END) AS LOCATION_OF_HEARING
    ,MAX(CASE WHEN q.QUESTION = 'ADDITIONAL_ATTENDEES' THEN ANSWER ELSE NULL END) AS ADDITIONAL_ATTENDEES
    ,MAX(CASE WHEN q.QUESTION = 'CAO_REP' THEN ANSWER ELSE NULL END) AS CAO_REP
    ,MAX(CASE WHEN q.QUESTION = 'PHYSICIAN' THEN ANSWER ELSE NULL END) AS PHYSICIAN
    ,MAX(CASE WHEN q.QUESTION = 'AAA_REP' THEN ANSWER ELSE NULL END) AS AAA_REP
    ,MAX(CASE WHEN q.QUESTION = 'OLTL_REP' THEN ANSWER ELSE NULL END) AS OLTL_REP
    ,MAX(CASE WHEN q.QUESTION = 'APPLICANT_REP' THEN ANSWER ELSE NULL END) AS APPLICANT_REP
    ,MAX(CASE WHEN q.QUESTION = 'ATTORNEY' THEN ANSWER ELSE NULL END) AS ATTORNEY
  FROM ats.assessment a
  LEFT JOIN ats.assessment_ques q ON (a.assessment_id = q.assessment_id)
  LEFT JOIN enum_language l ON (q.QUESTION = 'INTERPRETER_LANG' AND q.ANSWER = l.VALUE)
  GROUP BY a.assessment_id;

GRANT SELECT ON d_pa_assessment_questions_sv TO MAXDAT_REPORTS;
