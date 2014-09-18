--BPM_ATTRIBUTE
create sequence SEQ_BA_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create sequence SEQ_BE_ID
  minvalue 1
  maxvalue 999999999999999999999999999
  start with 265
  increment by 1
  cache 20;

--BPM_INSTANCE
create sequence SEQ_BI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

--BPM_INSTANCE_ATTRIBUTE
create sequence SEQ_BIA_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

--BPM_UPDATE_EVENT
create sequence SEQ_BUE_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

--BPM_ACTIVITY_EVENTS
create sequence SEQ_BACE_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;
/