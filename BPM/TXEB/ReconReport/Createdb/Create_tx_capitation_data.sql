-- Create table

create table TX_ETL_CAPITATION_DATA
(
  capitation_data_id NUMBER(18) not null,
  client_id          NUMBER,
  case_id            NUMBER,
  client_cin         VARCHAR2(9),
  case_cin           VARCHAR2(9),
  client_name        VARCHAR2(30),
  client_gender      VARCHAR2(2),
  client_race        VARCHAR2(2),
  client_dob         DATE,
  client_age         NUMBER(8,2),
  status_in_group    VARCHAR2(2),
  alias_flag         VARCHAR2(2),
  transitional_hold  VARCHAR2(2),
  eligibility_month  VARCHAR2(8),
  risk_group_id      VARCHAR2(8),
  mco_id             VARCHAR2(8),
  plan_id            VARCHAR2(2),
  county_id          VARCHAR2(3),
  provider_id        VARCHAR2(9),
  term_reason        VARCHAR2(2),
  med_category       VARCHAR2(2),
  med_coverage_code  VARCHAR2(2),
  type_program       VARCHAR2(2),
  pure_rate          NUMBER(8,4),
  admin_rate         NUMBER(8,4),
  mc_start_date      DATE,
  mc_end_date        DATE,
  voucher_page       VARCHAR2(3),
  risk_group_page    VARCHAR2(5),
  job_id             NUMBER(18) not null,
  ns_id              VARCHAR2(10),
  plan_type_cd       VARCHAR2(20)
)
partition by range (ELIGIBILITY_MONTH)
(
  partition P201610 values less than ('201610'),
  partition P201611 values less than ('201611'),
  partition P201612 values less than ('201612'),
  partition P201701 values less than ('201701'),
  partition P201702 values less than ('201702'),
  partition P201703 values less than ('201703'),
  partition P201704 values less than ('201704'),
  partition P201705 values less than ('201705'),
  partition P201706 values less than ('201706'),
  partition P201707 values less than ('201707'),
  partition P201708 values less than ('201708'),
  partition P201709 values less than ('201709'),
  partition P201710 values less than ('201710'),
  partition P201711 values less than ('201711'),
  partition P201712 values less than ('201712'),
  partition P9999 values less than (MAXVALUE)
)
    tablespace MAXDAT_DATA
    pctfree 10
    initrans 1
    maxtrans 255
    storage
    (
      initial 3M
      next 1M
      minextents 1
      maxextents unlimited
      freelists 3
    )
    nologging
    ;



grant select on TX_ETL_CAPITATION_DATA to MAXDAT_READ_ONLY;
