create table MAXDAT.BPM_D_HOURS
  (D_HOUR int not null,
   constraint BPM_D_HOURS_PK primary key clustered (D_HOUR));
go

grant select on MAXDAT.BPM_D_HOURS to MAXDAT_READ_ONLY;
go


create table MAXDAT.BPM_LOGGING
  (BL_ID           int not null,
   LOG_DATE        datetime not null,
   LOG_LEVEL       varchar(7) not null,
   PBQJ_ID         int,
   RUN_DATA_OBJECT varchar(61),
   BSL_ID          int,
   BIL_ID          int,
   IDENTIFIER      varchar(100), 
   BI_ID           int,
   MESSAGE	       varchar(MAX),
   ERROR_NUMBER    int,
   BACKTRACE       varchar(MAX));

alter table MAXDAT.BPM_LOGGING add constraint BPM_LOGGING_PK primary key (BL_ID);

create index BPM_LOGGING_LX1 on MAXDAT.BPM_LOGGING (LOG_DATE);
create index BPM_LOGGING_LX2 on MAXDAT.BPM_LOGGING (BSL_ID);

alter table  MAXDAT.BPM_LOGGING add constraint BPM_LOGGING_LOG_LEVEL_CK 
check (LOG_LEVEL in ('SEVERE','WARNING','INFO','CONFIG','FINE','FINER','FINEST'));
go

grant select on MAXDAT.BPM_LOGGING to MAXDAT_READ_ONLY;
go

 
