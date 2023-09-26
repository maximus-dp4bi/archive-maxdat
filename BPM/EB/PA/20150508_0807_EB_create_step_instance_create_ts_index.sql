create index EB.STEP_INSTANCE_IND22 on EB.STEP_INSTANCE(CREATE_TS)
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
