create table GATHER_STATS_TABLE_CONFIG
  (TABLE_NAME                varchar2(30) not null,
   GATHER_STATS_PERIODICALLY Varchar2(1) not null);

alter table GATHER_STATS_TABLE_CONFIG
  add constraint GATHER_STATS_PER_CHECK
  check (GATHER_STATS_PERIODICALLY in ('Y','N'));
  
grant select on GATHER_STATS_TABLE_CONFIG to MAXDAT_READ_ONLY;
