create table TS_QUEST_ANSWER_DETAIL
(
    audit_question_answer_id    number not null,
    question_detail_id          number not null,
    qa_question_id              number not null,    
    question_answer_detail_chk  number(1) not null,
    create_by                   VARCHAR2(10) not null,
    create_datetime             DATE not null,
    last_updated_by             VARCHAR2(10) not null,
    last_updated_datetime       DATE not null
);
alter table TS_QUEST_ANSWER_DETAIL add primary key (audit_question_answer_id,question_detail_id, qa_question_id);
alter table TS_QUEST_ANSWER_DETAIL add constraint FK_QUEST_ANS_DET_QUEST_ANS foreign key(audit_question_answer_id) references TS_AUDIT_QUESTION_ANSWER(audit_question_answer_id);
alter table TS_QUEST_ANSWER_DETAIL add constraint FK_QUEST_ANS_DET_QUEST_DET foreign key(question_detail_id, qa_question_id) references TS_QUESTION_DETAIL(question_detail_id, qa_question_id);

create table AIU_TS_QUEST_ANSWER_DETAIL
(
    Record_type                 varchar(10) not null,              
    Record_action               varchar(10) not null, 
    Transaction_Date            date not null,
    audit_question_answer_id    number not null,
    question_detail_id          number not null,
    qa_question_id              number not null,    
    question_answer_detail_chk  number(1) not null,
    create_by                   VARCHAR2(10) not null,
    create_datetime             DATE not null,
    last_updated_by             VARCHAR2(10) not null,
    last_updated_datetime       DATE not null
);

create table TS_QA_SUPERVISOR
(
    qa_supervisor_id             number not null,
    qa_supervisor_login_id       nvarchar2(100) not null,
    qa_supervisor_first_name     varchar2(255) not null,
    qa_supervisor_middle_initial varchar2(100),
    qa_supervisor_last_name      varchar2(255) not null,
    qa_supervisor_active         number(1) not null,
    create_by                    VARCHAR2(10) not null,
    create_datetime              DATE not null,
    last_updated_by              VARCHAR2(10) not null,
    last_updated_datetime        DATE not null
);
alter table TS_QA_SUPERVISOR add primary key (qa_supervisor_id);

create table AIU_TS_QA_SUPERVISOR
(
    Record_type                 varchar(10) not null,              
    Record_action               varchar(10) not null, 
    Transaction_Date            date not null,
    qa_supervisor_id             number not null,
    qa_supervisor_login_id       nvarchar2(100) not null,
    qa_supervisor_first_name     varchar2(255) not null,
    qa_supervisor_middle_initial varchar2(100),
    qa_supervisor_last_name      varchar2(255) not null,
    qa_supervisor_active         number(1) not null,
    create_by                    VARCHAR2(10) not null,
    create_datetime              DATE not null,
    last_updated_by              VARCHAR2(10) not null,
    last_updated_datetime        DATE not null
);





