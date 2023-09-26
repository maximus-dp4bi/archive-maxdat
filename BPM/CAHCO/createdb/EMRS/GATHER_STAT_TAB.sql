create table MAXDAT.GATHER_STATS_TABLE_CONFIG
(
  table_name                VARCHAR2(30) not null,
  gather_stats_periodically VARCHAR2(1) not null
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate check constraints 
alter table MAXDAT.GATHER_STATS_TABLE_CONFIG
  add constraint GATHER_STATS_PER_CHECK
  check (GATHER_STATS_PERIODICALLY in ('Y','N'));
  
grant select, insert, update on MAXDAT.GATHER_STATS_TABLE_CONFIG to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.GATHER_STATS_TABLE_CONFIG to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.GATHER_STATS_TABLE_CONFIG to MAXDAT_READ_ONLY;  
