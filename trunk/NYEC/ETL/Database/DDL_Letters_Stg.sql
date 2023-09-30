/*
Description:
This is the Process MI Change Data Capture stage table and hold all the letters associated to the 
Applications (both in-process and completed apps in the past 31 days).
*/
create table LETTERS_STG
(
  LETTER_ID           NUMBER(18) not null,
  LETTER_REQUESTED_ON DATE,
  LETTER_STATUS_CD    VARCHAR2(32),
  LETTER_STATUS_REPORT_LABEL VARCHAR2 (64),
  LETTER_CREATE_TS    DATE,
  LETTER_UPDATE_TS    DATE,
  LETTER_SENT_ON      DATE,
  LETTER_MAILED_DATE  DATE,
  LETTER_APP_ID       NUMBER(18),
  LETTER_CASE_ID      NUMBER(18),
  LETTER_PARENT_LMREQ_ID     NUMBER (18),
  LETTER_REF_TYPE     VARCHAR2(40),
  LETTER_TYPE_CD      VARCHAR2(40),
  LETTER_TYPE         VARCHAR2(4000),
  LETTER_REQUEST_TYPE VARCHAR2(2),
  LETTER_LANG_CD      VARCHAR2 (32),   
  LETTER_DRIVER_TYPE  VARCHAR2 (4),
  LET_MATERIAL_REQUEST_ID  NUMBER (18),
  MW_PROCESSED varchar2(1) default 'N',
  AP_PROCESSED varchar2(1) default 'N',
  MIB_PROCESSED varchar2(1) default 'N',
  MI_PROCESSED varchar2(1) default 'N',
  SR_PROCESSED varchar2(1) default 'N',
  TP_PROCESSED varchar2(1) default 'N',
  IR_PROCESSED varchar2(1) default 'N',
  ALL_PROC_DONE_DATE DATE
);


CREATE INDEX Letters_STG_idx
   ON Letters_STG (LETTER_TYPE_CD, LETTER_APP_ID, LETTER_ID);
   
CREATE INDEX Letters_APP_ID_STG_idx
   ON Letters_STG (LETTER_APP_ID);
   
CREATE INDEX Letters_TYPE_CD_STG_idx
   ON Letters_STG (LETTER_TYPE_CD);

CREATE INDEX Letters_ID_STG_idx
   ON Letters_STG (LETTER_ID);

CREATE INDEX Letters_REQUEST_TYPE_STG_idx
   ON Letters_STG (LETTER_REQUEST_TYPE);

CREATE INDEX Letters_SENT_ON_STG_idx
   ON Letters_STG (LETTER_SENT_ON);
   
insert into corp_etl_control
(
name,
value_type,
value,
description,
created_ts,
updated_ts
)
values
(
'LETTERS_LAST_UPDATE_DATE',
'D',
to_char(to_date('2012/7/31 01:00:00','yyyy/mm/dd hh24:mi:ss'),'yyyy/mm/dd hh24:mi:ss'),
'Change Data Capture of letters.This is the timestamp of the letter_request.update_ts from the previous run. update_ts of the most recent letter record from the previous run.',
sysdate,
sysdate
);

insert into corp_etl_control
(
name,
value_type,
value,
description,
created_ts,
updated_ts
)
values
(
'LETTERS_CDC_APPS_DAYS_BACK',
'N',
31,
'This global control value is used to fetch all letters on completed Applications going back these many days. This is used by CDC transformations.',
sysdate,
sysdate
);
commit;