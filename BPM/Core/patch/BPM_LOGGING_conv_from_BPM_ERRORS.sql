-- Create table.
create table BPM_LOGGING
  (BL_ID           number,
   LOG_DATE        date not null,
   LOG_LEVEL       varchar2(7) not null,
   PBQJ_ID         number,
   RUN_DATA_OBJECT varchar2(61),
   BSL_ID          number,
   BIL_ID          number,
   IDENTIFIER      varchar2(100), 
   BI_ID           number,
   BA_ID           number,
   MESSAGE	       clob,
   ERROR_NUMBER    number,
   BACKTRACE       clob)
storage (initial 64K)
partition by range (LOG_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BL_LOG_DATE_LT_2012 values less than (to_date('20120101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;


-- Load data.
insert into BPM_LOGGING
  (BL_ID,
   LOG_DATE,
   LOG_LEVEL,
   PBQJ_ID,
   RUN_DATA_OBJECT,
   BSL_ID,
   BIL_ID,
   IDENTIFIER,
   BI_ID,
   BA_ID,
   MESSAGE,
   ERROR_NUMBER,
   BACKTRACE)
select
  BE_ID,
  ERROR_DATE,
  'SEVERE',
  null,
  RUN_DATA_OBJECT,
  null,
  null,
  SOURCE_ID,
  BI_ID,
  BIA_ID,
  ERROR_MESSAGE,
  ERROR_NUMBER,
  BACKTRACE
from BPM_ERRORS;

commit;


-- Sequence
declare
  v_max_bl_id number := null;
begin

  select max(BL_ID)
  into v_max_bl_id
  from BPM_LOGGING;

  execute immediate 
    'create sequence SEQ_BL_ID
       minvalue 0
       maxvalue 999999999999999999999999999
       start with '  || to_char(v_max_bl_id + 1) ||
       'increment by 1
       cache 20';
       
end;
/


-- Indexes
alter table BPM_LOGGING add constraint BPM_LOGGING_PK primary key (BL_ID);
alter index BPM_LOGGING_PK rebuild tablespace MAXDAT_INDX parallel;

create index BPM_LOGGING_LX1 on BPM_LOGGING (LOG_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

alter table BPM_LOGGING add constraint BPM_LOGGING_LOG_LEVEL_CK 
check (LOG_LEVEL in ('SEVERE','WARNING','INFO','CONFIG','FINE','FINER','FINEST'));

-- Set levels.
update BPM_LOGGING
set LOG_LEVEL = 'INFO'
where dbms_lob.substr(MESSAGE,0,5) = 'INFO:';

commit;

update BPM_LOGGING
set LOG_LEVEL = 'WARNING'
where dbms_lob.substr(MESSAGE,0,14) = 'Stopped job ID';

commit;

update BPM_LOGGING
set LOG_LEVEL = 'WARNING'
where dbms_lob.substr(MESSAGE,0,30) = 'Exception when stopping job ID';

commit;

update BPM_LOGGING
set LOG_LEVEL = 'WARNING'
where dbms_lob.substr(MESSAGE,0,50) = 'Unable to get lock to reserve queue rows.  Timeout';

commit;
