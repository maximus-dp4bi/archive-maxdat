ALTER TABLE MAXDAT.BPM_CIN_SNAPSHOT
DROP
(
  rfe_status_cd,
  rfe_status_date,
  case_reason_eligible,
  ma_reason_eligible,
  first_iteration_await_mi_ts,
  sde_fpbp_task_create_ts
);


ALTER TABLE MAXDAT.BPM_CIN_SNAPSHOT
ADD
(
OFFICE_ID  NUMBER(18),
PE_ELIG_DOC_FLAG   VARCHAR2(1),
FPBP_DOC_FLAG  VARCHAR2(1),
FIRST_PE_CHECKPOINT_DATE DATE,
ELIGIBLE_FLAG  VARCHAR2(1)
);

COMMIT;

/
