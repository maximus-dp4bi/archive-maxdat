create or replace view SVEY_TMPL_GROUP_TEXT_sv as select * from SVEY_TMPL_GROUP_TEXT;
grant select on SVEY_TMPL_GROUP_TEXT_sv to MAXDAT_READ_ONLY;
grant select on SVEY_TMPL_GROUP_TEXT_sv to maxdat_reports;

create or replace view SVEY_TMPL_QUESTION_TEXT_sv as select * from SVEY_TMPL_QUESTION_TEXT;
grant select on SVEY_TMPL_QUESTION_TEXT_sv to MAXDAT_READ_ONLY;
grant select on SVEY_TMPL_QUESTION_TEXT_sv to maxdat_reports;

create or replace view SVEY_TMPL_ANSWER_TEXT_sv as select * from SVEY_TMPL_ANSWER_TEXT;
grant select on SVEY_TMPL_ANSWER_TEXT_sv to MAXDAT_READ_ONLY;
grant select on SVEY_TMPL_ANSWER_TEXT_sv to maxdat_reports;

create or replace view survey_template_sv as select * from survey_template;
grant select on survey_template_sv to MAXDAT_READ_ONLY;
grant select on survey_template_sv to maxdat_reports;

create or replace view SURVEY_TEMPLATE_ANSWER_sv as select * from SURVEY_TEMPLATE_ANSWER;
grant select on SURVEY_TEMPLATE_ANSWER_sv to MAXDAT_READ_ONLY;
grant select on SURVEY_TEMPLATE_ANSWER_sv to maxdat_reports;

create or replace view ENUM_SURVEY_REFUSE_REASON_sv as select * from ENUM_SURVEY_REFUSE_REASON;
grant select on ENUM_SURVEY_REFUSE_REASON_sv to MAXDAT_READ_ONLY;
grant select on ENUM_SURVEY_REFUSE_REASON_sv to maxdat_reports;

create or replace view ENUM_SURVEY_STATUS_sv as select * from ENUM_SURVEY_STATUS;
grant select on ENUM_SURVEY_STATUS_sv to MAXDAT_READ_ONLY;
grant select on ENUM_SURVEY_STATUS_sv to maxdat_reports;

create or replace view SURVEY_TEMPLATE_GROUP_sv as select * from SURVEY_TEMPLATE_GROUP;
grant select on SURVEY_TEMPLATE_GROUP_sv to MAXDAT_READ_ONLY;
grant select on SURVEY_TEMPLATE_GROUP_sv to maxdat_reports;

create or replace view SURVEY_TEMPLATE_QUESTION_sv as select * from SURVEY_TEMPLATE_QUESTION;
grant select on SURVEY_TEMPLATE_QUESTION_sv to MAXDAT_READ_ONLY;
grant select on SURVEY_TEMPLATE_QUESTION_sv to maxdat_reports;

create or replace view QC_STAFF_sv as select * from QC_STAFF;
grant select on QC_STAFF_sv to MAXDAT_READ_ONLY;
grant select on QC_STAFF_sv to maxdat_reports;

create or replace view SURVEY_sv as select * from SURVEY;
grant select on SURVEY_sv to MAXDAT_READ_ONLY;
grant select on SURVEY_sv to maxdat_reports;

create or replace view SURVEY_HEADER_INFO_sv as select * from SURVEY_HEADER_INFO;
grant select on SURVEY_HEADER_INFO_sv to MAXDAT_READ_ONLY;
grant select on SURVEY_HEADER_INFO_sv to maxdat_reports;

create or replace view SURVEY_HEADER_INFO_HIST_sv as select * from SURVEY_HEADER_INFO_HIST;
grant select on SURVEY_HEADER_INFO_HIST_sv to MAXDAT_READ_ONLY;
grant select on SURVEY_HEADER_INFO_HIST_sv to maxdat_reports;

create or replace view SURVEY_SCORE_sv as select * from SURVEY_SCORE;
grant select on SURVEY_SCORE_sv to MAXDAT_READ_ONLY;
grant select on SURVEY_SCORE_sv to maxdat_reports;

create or replace view SURVEY_SCORE_HIST_sv as select * from SURVEY_SCORE_HIST;
grant select on SURVEY_SCORE_HIST_sv to MAXDAT_READ_ONLY;
grant select on SURVEY_SCORE_HIST_sv to maxdat_reports;

create or replace view SURVEY_RESPONSE_sv as select * from SURVEY_RESPONSE;
grant select on SURVEY_RESPONSE_sv to MAXDAT_READ_ONLY;
grant select on SURVEY_RESPONSE_sv to maxdat_reports;

create or replace view SURVEY_RESPONSE_HIST_sv as select * from SURVEY_RESPONSE_HIST;
grant select on SURVEY_RESPONSE_HIST_sv to MAXDAT_READ_ONLY;
grant select on SURVEY_RESPONSE_HIST_sv to maxdat_reports;

create or replace view SURVEY_STATUS_HISTORY_sv as select * from SURVEY_STATUS_HISTORY;
grant select on SURVEY_STATUS_HISTORY_sv to MAXDAT_READ_ONLY;
grant select on SURVEY_STATUS_HISTORY_sv to maxdat_reports;
