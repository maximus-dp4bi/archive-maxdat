create table ENUM_SURVEY_TEMPLATE_CATEGORY
(
  value                VARCHAR2(64) not null,
  description          VARCHAR2(256),
  report_label         VARCHAR2(64)
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

grant select on   SURVEY_TEMPLATE to MAXDAT_READ_ONLY;
grant select on   SURVEY_TEMPLATE to MAXDAT_REPORTS;

begin
  insert into enum_Survey_template_category (value, description, report_label) values ('SEU', 'QC Review Survey', 'QC Review');
insert into enum_survey_template_category (value, description, report_label) values ('CC', 'Call Center QC Review Survey', 'Call Center QC');
commit;
end;

