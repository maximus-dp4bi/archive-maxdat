create index NYHOPT.LETTER_REQUEST_IDX8 on NYHOPT.LETTER_REQUEST(CREATE_TS)
 tablespace NYHOPT_INDEX
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


create index NYHOPT.INCIDENT_HEADER_IDX3 on NYHOPT.INCIDENT_HEADER(INCIDENT_HEADER_TYPE_CD)
 tablespace NYHOPT_INDEX
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

create index NYHOPT.INCIDENT_HDR_STATHIST_IDX01 on NYHOPT.INCIDENT_HEADER_STAT_HIST(INCIDENT_HEADER_ID)
 tablespace NYHOPT_INDEX
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

create index NYHOPT.STEP_INSTANCE_IND24 on NYHOPT.STEP_INSTANCE(CREATE_TS)
 tablespace NYHOPT_INDEX
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

