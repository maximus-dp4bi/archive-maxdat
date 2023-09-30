

create index DMECUR_IX1 on D_ME_CURRENT (COMPLETE_DATE,0) online tablespace MAXDAT_INDX parallel compute statistics;
create index DMECUR_IX2 on D_ME_CURRENT (CANCEL_ENROLL_ACTIVITY_DATE,0) online tablespace MAXDAT_INDX parallel compute statistics;

execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','D_ME_CURRENT',8);

create index DOBCCUR_IX1 on D_OBC_CURRENT (COMPLETE_DATE,0) online tablespace MAXDAT_INDX parallel compute statistics;
create index DOBCCUR_IX2 on D_OBC_CURRENT (CANCEL_DATE,0) online tablespace MAXDAT_INDX parallel compute statistics;

execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','D_OBC_CURRENT',8);

create index DPLCUR_IX1 on D_PL_CURRENT (COMPLETE_DATE,0) online tablespace MAXDAT_INDX parallel compute statistics;
create index DPLCUR_IX2 on D_PL_CURRENT (CANCEL_DATE,0) online tablespace MAXDAT_INDX parallel compute statistics;

execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','D_PL_CURRENT',8);