drop index DMFDBD_UIX1;

create unique index DMFDBD_UIX1 on D_NYHIX_MFD_HISTORY_V2 (NYHIX_MFD_BI_ID,LAST_EVENT_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

create index DMFDBD_IX1 on D_NYHIX_MFD_HISTORY_V2 (DOC_STATUS_DT) online tablespace MAXDAT_INDX parallel compute statistics; 
create index DMFDBD_IX2 on D_NYHIX_MFD_HISTORY_V2 (ENV_STATUS_DT) online tablespace MAXDAT_INDX parallel compute statistics; 

