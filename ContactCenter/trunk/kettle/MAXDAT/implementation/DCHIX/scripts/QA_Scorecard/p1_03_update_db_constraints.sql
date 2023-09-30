alter table TS_QA_QUESTION modify score_type_id number not null;
alter table TS_QA_QUESTION add constraint FK_TS_QA_QUESTION_SCORE_TYPE foreign key(score_type_id) references TS_SCORE_TYPE_LKUP(score_type_id);

ALTER TABLE TS_AUDIT add constraint UK_TS_AUDIT_CSL UNIQUE (audit_csl);