drop index maxdat.TX_ETL_L_ELIGIBILITY_IDX1;

drop index maxdat.TX_ETL_L_ELIGIBILITY_IDX2;

drop index maxdat.TX_ETL_L_ELIGIBILITY_IDX3;

drop index maxdat.TX_ETL_CAPITATION_DATA_IX1;

alter table MAXDAT.TX_ETL_CAPITATION_DATA drop constraint TX_ETL_CAPITATION_DATA_UC;

drop index maxdat.TX_ETL_CAPITATION_DATA_IX3;

drop index maxdat.TX_ETL_P3435_IDX1;


