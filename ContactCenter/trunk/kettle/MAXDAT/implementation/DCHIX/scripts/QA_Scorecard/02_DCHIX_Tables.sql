create table TS_QUESTION_TYPE_LKUP
(
    question_type_id        number not null,
    question_type_desc      varchar2(1000) not null
);
alter table TS_QUESTION_TYPE_LKUP add primary key (question_type_id);

create table TS_CALL_TYPE_LKUP
(
    call_type_id            number not null,
    call_type_desc          varchar2(1000) not null
);
alter table TS_CALL_TYPE_LKUP add primary key (call_type_id);

create table TS_QUESTION_DETAIL_TYPE_LKUP
(
    question_detail_type_id              number not null,
    question_detail_type_desc            varchar2(1000) not null
);
alter table TS_QUESTION_DETAIL_TYPE_LKUP add primary key (question_detail_type_id);

create table TS_SCORE_TYPE_LKUP
(
    score_type_id            number not null,
    score_type_desc          varchar2(1000) not null
);
alter table TS_SCORE_TYPE_LKUP add primary key (score_type_id);

create table TS_QA_AGENT
(
    agent_id                   number not null,
    agent_hire_date            date,
    agent_active               number(1),
    create_by                  VARCHAR2(10) not null,
    create_datetime            DATE not null,
    last_updated_by            VARCHAR2(10) not null,
    last_updated_datetime      DATE not null
);
alter table TS_QA_AGENT add primary key (agent_id);

create table AIU_TS_QA_AGENT
(
    Record_type             varchar(10) not null,              
    Record_action           varchar(10) not null, 
    Transaction_Date        date not null,
    agent_id                number not null,
    agent_hire_date         date,
    agent_active            number(1),
    create_by                  VARCHAR2(10) not null,
    create_datetime            DATE not null,
    last_updated_by            VARCHAR2(10) not null,
    last_updated_datetime      DATE not null
);

create table TS_QA_ANALYST
(
    qa_analyst_id              varchar2(10) not null,
    qa_analyst_name            VARCHAR2(100) not null
);
alter table TS_QA_ANALYST add primary key (qa_analyst_id);

create table TS_QA_QUESTION
(
    qa_question_id                 number not null,
    qa_question_number             number not null,
    qa_question_desc               varchar2(1000) not null,
    question_type_id               number not null,
    question_detail_type_id        number not null,
    qa_question_start_date         date not null,
    qa_question_end_date           date,
    qa_question_max_score          number(10,2) not null,
    qa_question_control            number(1) not null,
    score_type_id                  number not null,
    create_by                      VARCHAR2(10) not null,
    create_datetime                DATE not null,
    last_updated_by                VARCHAR2(10) not null,
    last_updated_datetime          DATE not null
);
alter table TS_QA_QUESTION add primary key (qa_question_id);
alter table TS_QA_QUESTION add constraint FK_TS_QA_QUESTION_TYPE foreign key(question_type_id) references TS_QUESTION_TYPE_LKUP(question_type_id);
alter table TS_QA_QUESTION add constraint FK_TS_QA_QUESTION_DETAIL_TYPE foreign key(question_detail_type_id) references TS_QUESTION_DETAIL_TYPE_LKUP(question_detail_type_id);
alter table TS_QA_QUESTION add constraint FK_TS_QA_QUESTION_SCORE_TYPE foreign key(score_type_id) references TS_SCORE_TYPE_LKUP(score_type_id);

create table AIU_TS_QA_QUESTION
(
    Record_type                    varchar(10) not null,              
    Record_action                  varchar(10) not null, 
    Transaction_Date               date not null,
    qa_question_id                 number not null,
    qa_question_number             number not null,
    qa_question_desc               varchar2(1000) not null,
    question_type_id               number not null,
    question_detail_type_id        number not null,
    qa_question_start_date         date not null,
    qa_question_end_date           date,
    qa_question_max_score          number(10,2) not null,
    qa_question_control            number(1) not null,
    score_type_id                  number not null,
    create_by                      VARCHAR2(10) not null,
    create_datetime                DATE not null,
    last_updated_by                VARCHAR2(10) not null,
    last_updated_datetime          DATE not null
);

create table TS_QUESTION_DETAIL
(
    question_detail_id          number not null,
    qa_question_id              number not null,
    question_detail_desc        varchar2(1000) not null,
    question_detail_enable      number(1) not null,
    create_by                   VARCHAR2(10) not null,
    create_datetime             DATE not null,
    last_updated_by             VARCHAR2(10) not null,
    last_updated_datetime       DATE not null
);
alter table TS_QUESTION_DETAIL add primary key (question_detail_id, qa_question_id);
alter table TS_QUESTION_DETAIL add constraint FK_TS_QUEST_DET_QA_QUEST foreign key(qa_question_id) references TS_QA_QUESTION(qa_question_id);

create table AIU_TS_QUESTION_DETAIL
(
    Record_type                 varchar(10) not null,              
    Record_action               varchar(10) not null, 
    Transaction_Date            date not null,
    question_detail_id          number not null,
    qa_question_id              number not null,
    question_detail_desc        varchar2(1000) not null,
    question_detail_enable      number(1) not null,
    create_by                   VARCHAR2(10) not null,
    create_datetime             DATE not null,
    last_updated_by             VARCHAR2(10) not null,
    last_updated_datetime       DATE not null
);

create table TS_AUDIT
(
    audit_id                        number not null,
    audit_call_date_id              number(19),
    audit_call_date                 date not null,
    audit_call_date_day_name        varchar2(20) not null,
    audit_call_date_week_number     number not null,    
    audit_call_date_month_number    varchar2(2) not null,
    audit_call_date_month_abv       varchar2(3) not null,
    audit_call_date_month_name      varchar2(20) not null,
    audit_call_date_year            varchar(4) not null,
    audit_call_hour                 number(2) not null,
    audit_call_minute               number(2) not null,
    call_type_id                    number not null,
    audit_call_duration             number not null,
	audit_call_duration_ss          number(2),
	audit_call_duration_mm          number(2),
	audit_call_duration_hh          number(2),
    audit_call_language             varchar2(100) not null,
    agent_id                        number not null,
    qa_analyst_id                   varchar2(10),
    audit_date_id                   number(19),
    audit_date                      date not null,
    audit_date_day_name             varchar2(20) not null,
    audit_date_week_number          number not null,    
    audit_date_month_number         varchar2(2) not null,
    audit_date_month_abv            varchar2(3) not null,
    audit_date_month_name           varchar2(20) not null,
    audit_date_year                 varchar2(4) not null,    
    audit_csl                       varchar2(255),
    audit_escalated                 number(1) not null,
    audit_appeal                    number(1) not null,
    audit_revised                   number(1) not null,
    audit_comments                  varchar2(4000),
    audit_answered                  varchar2(3),
    audit_call_result               varchar2(6),
    create_by                       VARCHAR2(10),
    create_datetime                 DATE not null,
    last_updated_by                 VARCHAR2(10),
    last_updated_datetime           DATE not null
);
alter table TS_AUDIT add primary key (audit_id);
alter table TS_AUDIT add constraint FK_TS_AUDIT_CALL_TYPE_ID foreign key(call_type_id) references TS_CALL_TYPE_LKUP(call_type_id);
ALTER TABLE TS_AUDIT add constraint UK_TS_AUDIT_CSL UNIQUE (audit_csl);

create table AIU_TS_AUDIT
(
    Record_type                     varchar(10) not null,              
    Record_action                   varchar(10) not null, 
    Transaction_Date                date not null,
    audit_id                        number not null,
    audit_call_date_id              number(19),
    audit_call_date                 date not null,
    audit_call_date_day_name        varchar2(20) not null,
    audit_call_date_week_number     number not null,    
    audit_call_date_month_number    varchar2(2) not null,
    audit_call_date_month_abv       varchar2(3) not null,
    audit_call_date_month_name      varchar2(20) not null,
    audit_call_date_year            varchar2(4) not null,
    audit_call_hour                 number(2) not null,
    audit_call_minute               number(2) not null,
    call_type_id                    number not null,
    audit_call_duration             number not null,
	audit_call_duration_ss          number(2),
	audit_call_duration_mm          number(2),
	audit_call_duration_hh          number(2),
    audit_call_language             varchar2(100) not null,
    agent_id                        number not null,
    qa_analyst_id                   varchar2(10),
    audit_date_id                   number(19),
    audit_date                      date not null,
    audit_date_day_name             varchar2(20) not null,
    audit_date_week_number          number not null,    
    audit_date_month_number         varchar2(2) not null,
    audit_date_month_abv            varchar2(3) not null,
    audit_date_month_name           varchar2(20) not null,
    audit_date_year                 varchar2(4) not null,
    audit_csl                       varchar2(255),
    audit_escalated                 number(1) not null,
    audit_appeal                    number(1) not null,
    audit_revised                   number(1) not null,
    audit_comments                  varchar2(4000),
    audit_answered                  varchar2(3),
    audit_call_result               varchar2(6),
    create_by                       VARCHAR2(10),
    create_datetime                 DATE not null,
    last_updated_by                 VARCHAR2(10),
    last_updated_datetime           DATE not null
);

create table TS_AUDIT_QUESTION
(
    audit_question_id           number not null,
    audit_question_number       number not null,
    audit_question_desc         varchar2(1000) not null,
    audit_id                    number not null,
    qa_question_id              number not null,
    question_type_id            number not null,
    question_detail_type_id     number not null,
    audit_question_max_score    number(10,2) not null,
    audit_question_control      number(1) not null,
    create_by                   VARCHAR2(10),
    create_datetime             DATE not null,
    last_updated_by             VARCHAR2(10),
    last_updated_datetime       DATE not null
);
alter table TS_AUDIT_QUESTION add primary key (audit_question_id);
alter table TS_AUDIT_QUESTION add constraint FK_TS_AUDIT_QUESTION_TYPE foreign key(question_type_id) references TS_QUESTION_TYPE_LKUP(question_type_id);
alter table TS_AUDIT_QUESTION add constraint FK_AUDIT_ID foreign key(audit_id) references TS_AUDIT(audit_id);
alter table TS_AUDIT_QUESTION add constraint FK_TS_AUDIT_QUEST_QA_QUEST foreign key(qa_question_id) references TS_QA_QUESTION(qa_question_id);
alter table TS_AUDIT_QUESTION add constraint FK_TS_AUDIT_QUEST_DET_TP foreign key(question_detail_type_id) references TS_QUESTION_DETAIL_TYPE_LKUP(question_detail_type_id);

create table TS_AUDIT_QUESTION_ANSWER
(
    audit_question_answer_id        number not null,
    audit_question_answer_yn        number(1),
    audit_question_answer_pf        number(1),
    audit_question_answer_date      date,
    audit_question_answer_numeric   number,
    audit_question_answer_other     varchar2(1000),
    audit_question_answer_max_score number(10,2) not null,
    audit_question_answer_score     number,
    question_detail_id              number,
    qa_question_id                  number,
    audit_question_detail_comment   varchar2(1000),
    audit_question_detail_date      date,
    audit_question_answer_comment   varchar2(1000),
    audit_question_id               number not null,    
    create_by                       VARCHAR2(10),
    create_datetime                 DATE not null,
    last_updated_by                 VARCHAR2(10),
    last_updated_datetime           DATE not null
);
alter table TS_AUDIT_QUESTION_ANSWER add primary key (audit_question_answer_id);
alter table TS_AUDIT_QUESTION_ANSWER add constraint FK_TS_AUDIT_QUEST_ANSWER_DET foreign key(question_detail_id, qa_question_id) references TS_QUESTION_DETAIL (question_detail_id, qa_question_id);
alter table TS_AUDIT_QUESTION_ANSWER add constraint FK_TS_AUDIT_QUEST_ANSWER_AUD foreign key(audit_question_id) references TS_AUDIT_QUESTION (audit_question_id);

create table AIU_TS_AUDIT_QUESTION_ANSWER
(
    Record_type                     varchar(10) not null,              
    Record_action                   varchar(10) not null, 
    Transaction_Date                date not null,
    audit_question_answer_id        number not null,
    audit_question_answer_yn        number(1),
    audit_question_answer_pf        number(1),
    audit_question_answer_date      date,
    audit_question_answer_numeric   number,
    audit_question_answer_other     varchar2(1000),
    audit_question_answer_max_score number(10,2) not null,
    audit_question_answer_score     number,
    question_detail_id              number,
    qa_question_id                  number,
    audit_question_detail_comment   varchar2(1000),
    audit_question_detail_date      date,
    audit_question_answer_comment   varchar2(1000),
    audit_question_id               number not null,    
    create_by                       VARCHAR2(10),
    create_datetime                 DATE not null,
    last_updated_by                 VARCHAR2(10),
    last_updated_datetime           DATE not null
);