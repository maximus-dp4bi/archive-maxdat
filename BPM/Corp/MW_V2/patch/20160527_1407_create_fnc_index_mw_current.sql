CREATE INDEX DMWCUR_V2_CREATEDT_FBIDX ON D_MW_V2_CURRENT(TRUNC(CREATE_DATE)) TABLESPACE MAXDAT_INDX;
CREATE INDEX DMWCUR_V2_COMPLETEDT_FBIDX ON D_MW_V2_CURRENT(TRUNC(COMPLETE_DATE)) TABLESPACE MAXDAT_INDX;
CREATE INDEX DMWCUR_V2_CANCELDT_FBIDX ON D_MW_V2_CURRENT(TRUNC(CANCEL_WORK_DATE)) TABLESPACE MAXDAT_INDX;
CREATE INDEX DMWCUR_V2_INSTANCESTDT_FBIDX ON D_MW_V2_CURRENT(TRUNC(INSTANCE_START_DATE)) TABLESPACE MAXDAT_INDX;