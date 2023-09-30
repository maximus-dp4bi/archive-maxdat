create sequence SEQ_MAAL_ID
  minvalue 0
  maxvalue 999999999999999999999999999
  start with 265
  increment by 1
  cache 20;

create table MAXDAT_ADMIN_AUDIT_LOGGING
  (MAAL_ID         number not null,
   USER_NAME       varchar2(30) not null,
   LOG_DATE        date not null,
   RUN_DATA_OBJECT varchar2(61),
   BSL_ID          number,
   MESSAGE	       clob)
tablespace &tablespace_name;

alter table MAXDAT_ADMIN_AUDIT_LOGGING add constraint MAXDAT_ADMIN_AUDIT_LOGGING_PK primary key (MAAL_ID);
alter index MAXDAT_ADMIN_AUDIT_LOGGING_PK rebuild tablespace &tablespace_name;

create index MAXDAT_ADMIN_AUDIT_LOGGING_IX1 on MAXDAT_ADMIN_AUDIT_LOGGING (LOG_DATE) online tablespace &tablespace_name compute statistics;

grant select on MAXDAT_ADMIN_AUDIT_LOGGING to &role_name;



