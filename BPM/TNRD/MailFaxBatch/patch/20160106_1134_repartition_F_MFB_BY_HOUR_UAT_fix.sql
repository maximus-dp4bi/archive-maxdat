drop index FMFBBH_IXL3;
drop index FMFBBH_IXL4;

create index FMFBBH_IXL4 on F_MFB_BY_HOUR (CREATION_COUNT) online tablespace MAXDAT_INDX parallel compute statistics;
