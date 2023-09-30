create index EB.LETTER_REQUEST_IDX7 on EB.LETTER_REQUEST(CREATE_TS)
 tablespace EB_INDEX
 pctfree 10
 initrans 2
 maxtrans 255
 storage
 (
 initial 64K
 next 1M
 minextents 1
 maxextents unlimited
 )
ONLINE;


create index EB.INCIDENT_HEADER_IDX4 on EB.INCIDENT_HEADER(INCIDENT_HEADER_TYPE_CD)
 tablespace EB_INDEX
 pctfree 10
 initrans 2
 maxtrans 255
 storage
 (
 initial 64K
 next 1M
 minextents 1
 maxextents unlimited
 )
ONLINE;

create index EB.STEP_INSTANCE_IND21 on EB.STEP_INSTANCE(CASE_ID)
 tablespace EB_INDEX
 pctfree 10
 initrans 2
 maxtrans 255
 storage
 (
 initial 64K
 next 1M
 minextents 1
 maxextents unlimited
 )
ONLINE;

create index EB.INCIDENT_HDR_STATHIST_IDX01 on EB.INCIDENT_HEADER_STAT_HIST(INCIDENT_HEADER_ID)
 tablespace EB_INDEX
 pctfree 10
 initrans 2
 maxtrans 255
 storage
 (
 initial 64K
 next 1M
 minextents 1
 maxextents unlimited
 )
ONLINE;
