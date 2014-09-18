CREATE UNIQUE INDEX nyec_etl_monitor_ren_pk_idx ON nyec_etl_monitor_renewal
(CEMR_ID)
LOGGING
TABLESPACE MAXDAT_INDX
NOPARALLEL;
