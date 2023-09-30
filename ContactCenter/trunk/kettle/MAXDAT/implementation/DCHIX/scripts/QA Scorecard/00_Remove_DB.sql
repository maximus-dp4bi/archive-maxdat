------ DROP AUDIT QUESTION ANSWER
drop sequence SEQ_TS_AUDIT_QUESTION_ANSWER;

drop TRIGGER dp_scorecard_dchix.TRG_AIU_TS_AUDIT_QUESTION_ANSWER;

drop procedure TS_AUDIT_QUESTION_ANSWER_UPDATE;

drop view ts_audit_question_answer_sv;

drop table TS_AUDIT_QUESTION_ANSWER;

drop table AIU_TS_AUDIT_QUESTION_ANSWER;


------ DROP AUDIT QUESTION
drop sequence SEQ_TS_AUDIT_QUESTION;

drop view ts_audit_question_sv;

drop table TS_AUDIT_QUESTION;


------ DROP AUDIT
drop sequence SEQ_TS_AUDIT;

drop TRIGGER dp_scorecard_dchix.TRG_AIU_TS_AUDIT;

drop procedure TS_AUDIT_INSERT;

drop procedure TS_AUDIT_UPDATE;

drop view ts_audit_sv;

drop table TS_AUDIT;

drop table AIU_TS_AUDIT;


------ DROP QUESTION DETAIL
drop sequence SEQ_TS_QUESTION_DETAIL;

drop TRIGGER dp_scorecard_dchix.TRG_AIU_TS_QUESTION_DETAIL;

drop procedure TS_QUESTION_DETAIL_INSERT;

drop view ts_question_detail_sv;

drop table TS_QUESTION_DETAIL;

drop table AIU_TS_QUESTION_DETAIL;


------ DROP QA QUESTION
drop sequence SEQ_TS_QA_QUESTION;

drop TRIGGER dp_scorecard_dchix.TRG_AIU_TS_QA_QUESTION;

drop procedure TS_QA_QUESTION_INSERT_UPDATE;

drop view ts_qa_question_sv;

drop table TS_QA_QUESTION;

drop table AIU_TS_QA_QUESTION;


------ DROP QA ANALYST
drop procedure TS_QA_ANALYST_INSERT_UPDATE;

drop view ts_qa_analyst_sv;

drop table TS_QA_ANALYST;


------ DROP QA AGENT
drop TRIGGER dp_scorecard_dchix.TRG_AIU_TS_QA_AGENT ;

drop procedure TS_QA_AGENT_INSERT_UPDATE;

drop view ts_qa_agent_sv;

drop table TS_QA_AGENT;

drop table AIU_TS_QA_AGENT;


------ DROP QUESTION DETAIL TYPE LKUP
drop view ts_question_detail_type_lkup_sv;

drop table TS_QUESTION_DETAIL_TYPE_LKUP;


------ DROP CALL TYPE LKUP
drop view ts_call_type_lkup_sv;

drop table TS_CALL_TYPE_LKUP;


------ DROP QUESTION TYPE LKUP
drop view ts_question_type_lkup_sv;

drop table TS_QUESTION_TYPE_LKUP;


------ DROP CC_D_AGENT_SV
drop view cc_d_agent_sv;
/
