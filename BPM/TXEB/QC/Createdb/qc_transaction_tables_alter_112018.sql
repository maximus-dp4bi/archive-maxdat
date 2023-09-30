alter table maxdat.SURVEY_RESPONSE_HIST
add  (
  challenge_reason          VARCHAR2(80),
  challenge_reason_comment  VARCHAR2(4000),
  challenge_outcome         VARCHAR2(80),
  challenge_findings        VARCHAR2(4000),
  challenge_this_question   VARCHAR2(1)
);

alter table maxdat.SURVEY_HEADER_INFO_HIST
add  (
  cisco_agent_id             VARCHAR2(80),
  client_program             VARCHAR2(80),
  call_type                  VARCHAR2(80),
  call_duration              NUMBER(8),
  calibration                VARCHAR2(1),
  brief_call_summary         VARCHAR2(4000),
  error_comment              VARCHAR2(4000),
  supporting_documentation   VARCHAR2(4000),
  challenge_type             VARCHAR2(80)
);

alter table maxdat.survey_header_info
add  (
  cisco_agent_id           VARCHAR2(80),
  client_program           VARCHAR2(80),
  call_type                VARCHAR2(80),
  call_duration            NUMBER(8),
  calibration              VARCHAR2(1),
  brief_call_summary       VARCHAR2(4000),
  error_comment            VARCHAR2(4000),
  supporting_documentation VARCHAR2(4000),
  challenge_type           VARCHAR2(80)
);

create table ENUM_SURVEY_CALL_TYPE
(
  value                VARCHAR2(32),
  description          VARCHAR2(256),
  report_label         VARCHAR2(128),
  order_by_default     NUMBER(10),
  scope                VARCHAR2(128),
  effective_start_date DATE,
  effective_end_date   DATE,
  created_by           VARCHAR2(80),
  create_ts            DATE,
  updated_by           VARCHAR2(80),
  update_ts            DATE
)
tablespace maxdat_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Grant/Revoke object privileges 
grant select on ENUM_SURVEY_CALL_TYPE to maxdat_read_only;
grant select on ENUM_SURVEY_CALL_TYPE to maxdat_reports;

create view ENUM_SURVEY_CALL_TYPE_sv as select * from ENUM_SURVEY_CALL_TYPE;
grant select on ENUM_SURVEY_CALL_TYPE_sv to maxdat_read_only;
grant select on ENUM_SURVEY_CALL_TYPE_sv to maxdat_reports;

