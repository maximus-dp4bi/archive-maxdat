-- ILEB-3564 sub-task of ILEB-3508

create index IDX5_SELECTIONTRANS on EMRS_D_SELECTION_TRANSACTION (CURRENT_SELECTION_STATUS_ID,0)
  tablespace MAXDAT_INDX;
create index IDX6_SELECTIONTRANS on EMRS_D_SELECTION_TRANSACTION (SOURCE_PLAN_ID,0)
  tablespace MAXDAT_INDX;

create index IDX1_SLCTSTATUS on EMRS_D_SELECTION_STATUS (SELECTION_STATUS_CODE,0)
  tablespace MAXDAT_INDX;

create index IDX4_CLIENTCURRFLAG on EMRS_D_CLIENT (CURRENT_FLAG,0)
  tablespace MAXDAT_INDX;

create index IDX5_CLIENTZIP on EMRS_D_CLIENT (ZIP,0)
  tablespace MAXDAT_INDX;
