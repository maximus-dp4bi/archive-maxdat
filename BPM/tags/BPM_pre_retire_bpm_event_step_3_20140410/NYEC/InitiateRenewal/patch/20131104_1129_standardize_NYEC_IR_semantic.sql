alter table D_NYEC_IR_CLOCKDOWN_IND noparallel;

drop index FNIRBD_UIX1;
drop index FNIRBD_UIX2;

create unique index FNIRBD_UIX1 on F_NYEC_IR_BY_DATE (NYEC_IR_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create unique index FNIRBD_UIX2 on F_NYEC_IR_BY_DATE (NYEC_IR_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FNIRBD_IX1 on F_NYEC_IR_BY_DATE ("Authorization End Date") online tablespace MAXDAT_INDX parallel compute statistics;

create index FNIRBD_IXL3 on F_NYEC_IR_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;