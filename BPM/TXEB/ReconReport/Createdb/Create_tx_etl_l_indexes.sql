create index TX_ETL_L_ELIGIBILITY_IDX1 on TX_ETL_L_ELIGIBILITY (cand_program1, cand_program2, coord_program1, coord_program2, coord_program3, coord_program4, coord_program5, coord_program6, coord_program7, coord_program8, coord_program9, coord_program10, coord_program11, coord_program12)
  nologging  ;

create index TX_ETL_L_ELIGIBILITY_IDX2 on TX_ETL_L_ELIGIBILITY (cand_program1, cand_coord_to1, cand_program2, cand_coord_to2, coord_program1, coord_to1, coord_program2, coord_to2, coord_program3, coord_to3, coord_program4, coord_to4 , coord_program5, coord_to5, coord_program6, coord_to6, coord_program7, coord_to7, coord_program8, coord_to8, coord_program9, coord_to9, coord_program10, coord_to10, coord_program11, coord_to11, coord_program12, coord_to12)
  nologging  ;

create index TX_ETL_L_ELIGIBILITY_IDX3 on TX_ETL_L_ELIGIBILITY (job_id, row_num)
  nologging  ;

create index maxdat.TX_ETL_CAPITATION_DATA_IX1 on MAXDAT.TX_ETL_CAPITATION_DATA (CLIENT_ID)
  nologging  ;

alter table MAXDAT.TX_ETL_CAPITATION_DATA
  add constraint TX_ETL_CAPITATION_DATA_UC unique (CLIENT_CIN, ELIGIBILITY_MONTH, PLAN_TYPE_CD)
  using index 
  tablespace MAXDAT_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

create index maxdat.TX_ETL_CAPITATION_DATA_IX3 on MAXDAT.TX_ETL_CAPITATION_DATA (ELIGIBILITY_MONTH, PLAN_TYPE_CD)
nologging;

create index MAXDAT.TX_ETL_P3435_IDX1 on MAXDAT.TX_ETL_P3435_DATA (JOB_ID, EVENT_TYPE_CD)
  tablespace MAXDAT_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )
  nologging;
