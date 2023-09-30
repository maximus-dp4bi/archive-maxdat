create or replace view ts_question_type_lkup_sv as
SELECT
    question_type_id,
    question_type_desc
FROM
    ts_question_type_lkup;

create or replace view ts_call_type_lkup_sv as
SELECT
    call_type_id,
    call_type_desc
FROM
    ts_call_type_lkup;

create or replace view ts_quest_det_type_lkup_sv as
SELECT
    question_detail_type_id,
    question_detail_type_desc
FROM
    ts_question_detail_type_lkup;
    
create or replace view ts_score_type_lkup_sv as
SELECT
    score_type_id,
    score_type_desc
FROM
    ts_score_type_lkup;

create or replace view ts_qa_agent_sv as
SELECT
    agent_id,
    agent_hire_date,
    agent_active
FROM
    ts_qa_agent;

create or replace view ts_qa_analyst_sv as
SELECT
    qa_analyst_id,
    qa_analyst_name
FROM
    ts_qa_analyst;

create or replace view ts_qa_question_sv as
SELECT
    qa_question_id,
    rownum as qa_question_number,
    qa_question_desc,
    question_type_id,
    question_detail_type_id,
    qa_question_start_date,
    qa_question_end_date,
    qa_question_max_score,
    qa_question_control,
    score_type_id,
    case when qa_question_start_date <= sysdate and (qa_question_end_date is null or qa_question_end_date >= sysdate) then 'Enabled' else 'Disabled' end as qa_question_status
FROM
    (select * from ts_qa_question order by QA_QUESTION_CONTROL, qa_question_id) qa_question;

create or replace view ts_question_detail_sv as
SELECT
    question_detail_id,
    qa_question_id,
    question_detail_desc,
    question_detail_enable
FROM
    ts_question_detail;
	
create or replace view ts_audit_sv as
SELECT
    audit_id,
    audit_call_date_id,
    audit_call_date,
    audit_call_hour,
    audit_call_minute,
    call_type_id,
    audit_call_duration,
    audit_call_language,
    agent_id,
    qa_analyst_id,
    qa_analyst_id as qa_analyst,    
    audit_answered,
    audit_date_id,
    audit_date,
    audit_date_day_name,
    audit_date_week_number,
    case when
        to_char(trunc(audit_date, 'IW'), 'MMYYYY') <> to_char(audit_date, 'MMYYYY')
    then 
        to_date('01' || to_char(audit_date, 'MMYYYY'),'DDMMYYYY')
    else 
        trunc(audit_date, 'IW') 
    end as audit_date_week_start_date,
    case when 
        to_char(trunc(audit_date, 'IW')+6, 'MMYYYY') <> to_char(audit_date, 'MMYYYY')
    then 
        to_date('01' || to_char(trunc(audit_date,'IW') + 6, 'MMYYYY'),'DDMMYYYY') - 1
    else
        trunc(audit_date,'IW') + 6
    end as audit_date_week_end_date,
    audit_date_month_number,
    audit_date_month_abv,
    audit_date_month_name,
    audit_date_year,
    audit_call_date_day_name,
    audit_call_date_week_number,
    case when 
        to_char(trunc(audit_call_date, 'IW'), 'MMYYYY') <> to_char(audit_call_date, 'MMYYYY')
    then 
        to_date('01' || to_char(audit_call_date, 'MMYYYY'),'DDMMYYYY')
    else
        trunc(audit_call_date, 'IW') 
    end as audit_call_date_w_start_date,
    case when 
        to_char(trunc(audit_call_date, 'IW')+6, 'MMYYYY') <> to_char(audit_call_date, 'MMYYYY')
    then 
        to_date('01' || to_char(trunc(audit_call_date,'IW') + 6, 'MMYYYY'),'DDMMYYYY') - 1
    else
        trunc(audit_call_date,'IW') + 6
    end as audit_call_date_w_end_date,
    audit_call_date_month_number,
    audit_call_date_month_abv,
    audit_call_date_month_name,
    audit_call_date_year,
    audit_csl,
    audit_escalated,
    audit_appeal,
    audit_revised,
    audit_comments,    
    audit_call_result,
	audit_customer_name
FROM
    ts_audit a;

create or replace view ts_audit_question_sv as
SELECT
    audit_question_id,
    audit_question_number,
    audit_question_desc,
    audit_id,
    qa_question_id,
    question_type_id,    
    question_detail_type_id,
    audit_question_max_score,
    DECODE(audit_question_control, 1, 'Yes', 'No') as audit_question_control,
    (select case when audit_question_answer_score is not null then 'Yes' else 'No' end from ts_audit_question_answer aqa where aq.audit_question_id = aqa.audit_question_id) as audit_question_answered    
FROM
    ts_audit_question aq;

create or replace view ts_audit_question_answer_sv as
SELECT
    audit_question_answer_id,
    audit_question_answer_yn,
    audit_question_answer_pf,
    audit_question_answer_date,
    audit_question_answer_numeric,
    audit_question_answer_other,
    audit_question_answer_score,
    audit_quest_answer_max_score,
    aqa.question_detail_id,
    aqa.qa_question_id,
    audit_question_detail_comment,
    audit_question_detail_date,
    audit_question_answer_comment,
    aqa.audit_question_id,
    aq.audit_id,
    decode(a.audit_call_result, 'Passed', 1, 0) as audit_call_result_id,
    case when aqa.AUDIT_QUESTION_DETAIL_COMMENT is not null then aqa.AUDIT_QUESTION_DETAIL_COMMENT when aqa.AUDIT_QUESTION_DETAIL_DATE is not null then to_char(aqa.AUDIT_QUESTION_DETAIL_DATE,'MM/DD/YYYY') when aqa.QUESTION_DETAIL_ID is not null and aqa.QA_QUESTION_ID is not null then (SELECT question_detail_desc FROM ts_question_detail_sv qd where qd.question_detail_id = aqa.QUESTION_DETAIL_ID and qd.qa_question_id = aqa.QA_QUESTION_ID) end as audit_quest_answer_det_display
FROM
    ts_audit_question_answer aqa join ts_audit_question aq on aqa.audit_question_id = aq.audit_question_id
    join ts_audit a on aq.audit_id = a.audit_id;

CREATE OR REPLACE VIEW CC_D_AGENT_SV AS 
  SELECT
    d_agent_id,
    login_id,
    first_name,
    middle_initial,
    last_name,
    job_title,
    language,
    site_name,
    hourly_rate,
    rate_currency,
    hire_date,
    termination_date,
    version,
    record_eff_dt,
    record_end_dt
FROM
    maxdat_dchix.cc_d_agent_temp_dchix;
    
create or replace view ts_audit_date_sv as
SELECT DISTINCT
    audit_date,
    audit_date_day_name,
    audit_date_week_number,
    (select max(audit_date) from ts_audit ai where ai.audit_date_week_number = a.audit_date_week_number and ai.audit_date_month_number = a.audit_date_month_number and ai.audit_date_year = a.audit_date_year) as audit_date_week_end_date,
    audit_date_month_number,
    audit_date_month_abv,
    audit_date_month_name,
    audit_date_year    
FROM
    ts_audit a;
    
create or replace view ts_audit_date_month_sv as
SELECT DISTINCT
    audit_date_month_number,
    audit_date_month_abv,
    audit_date_month_name,
    audit_date_year    
FROM
    ts_audit a;
    
create or replace view ts_audit_date_year_sv as
SELECT DISTINCT   
    audit_date_year    
FROM
    ts_audit a;