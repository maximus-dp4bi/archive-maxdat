CREATE INDEX DMFBCUR_IX1 ON D_MFB_CURRENT (BATCH_CLASS) online tablespace MAXDAT_INDX parallel compute statistics;
CREATE INDEX DMFBCUR_IX2 ON D_MFB_CURRENT (BATCH_TYPE) online tablespace MAXDAT_INDX parallel compute statistics;
CREATE INDEX DMFBCUR_IX3 ON D_MFB_CURRENT (BATCH_COMPLETE_DT) online tablespace MAXDAT_INDX parallel compute statistics;


