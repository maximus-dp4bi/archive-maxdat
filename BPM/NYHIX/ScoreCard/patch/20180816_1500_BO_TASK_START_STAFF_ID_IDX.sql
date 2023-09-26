CREATE INDEX DP_SCORECARD.BO_TASK_START_STAFF_ID_IDX ON DP_SCORECARD.PP_WFM_TASK_BO
(TRUNC("TASK_START"), STAFF_ID)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );