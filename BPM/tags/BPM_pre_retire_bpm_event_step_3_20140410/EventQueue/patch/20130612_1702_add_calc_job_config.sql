alter table PROCESS_BPM_QUEUE_JOB_CONFIG parallel 1;


create sequence SEQ_PBCJC_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1;

create table PROCESS_BPM_CALC_JOB_CONFIG
  (PBCJC_ID number not null,
   PACKAGE_NAME varchar2(30) not null,
   PROCEDURE_NAME varchar2(30) not null,
   PROCESS_ENABLED varchar2(1) not null)
tablespace MAXDAT_DATA;

alter table PROCESS_BPM_CALC_JOB_CONFIG add constraint PBCJC_PK primary key (PBCJC_ID);
alter index PBCJC_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index PBCJC_UX1 on PROCESS_BPM_CALC_JOB_CONFIG (PACKAGE_NAME,PROCEDURE_NAME) tablespace MAXDAT_INDX parallel;