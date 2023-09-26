CREATE OR REPLACE VIEW F_MW_TASK_INSTANCE_BY_DATE_SV
AS
WITH tasks AS (
SELECT a.task_type_id, a.MW_BI_ID, a.task_id, b.entity_id FROM D_MW_TASK_INSTANCE a JOIN d_bpm_task_type_entity b ON a.TASK_TYPE_ID = b.TASK_TYPE_ID
), processes AS (
SELECT e.process_instance_id,t.mw_bi_id FROM D_BPM_ENTITY_INSTANCE e JOIN tasks t ON t.task_id = e.entity_instance_id
)
SELECT        d.MW_BI_ID,
              bdd.D_DATE,
              p.Process_instance_id,
              CASE WHEN bdd.D_DATE = TRUNC(d.CREATE_DATE) THEN 1 ELSE 0 END AS CREATION_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(d.COMPLETE_DATE) OR bdd.D_DATE = TRUNC(d.CANCEL_WORK_DATE)) THEN 0 ELSE 1 END AS INVENTORY_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(d.COMPLETE_DATE) THEN 1 ELSE 0 END AS COMPLETION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(d.CANCEL_WORK_DATE) THEN 1 ELSE 0 END AS CANCELLATION_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(d.COMPLETE_DATE) OR bdd.D_DATE = TRUNC(d.CANCEL_WORK_DATE)) THEN 1 ELSE 0 END AS TERMINATION_COUNT,               
              Bus_days_between(TRUNC(d.CREATE_DATE), bdd.d_date) AGE_IN_BUS_DAYS,             
              CASE WHEN (bdd.D_DATE = TRUNC(d.COMPLETE_DATE) OR bdd.D_DATE = TRUNC(d.CANCEL_WORK_DATE)) THEN 0 ELSE CASE WHEN jeopardy_flag = 'Y' THEN 1 ELSE 0 END END AS INVENTORY_JEOPARDY_COUNT
  FROM D_DATES bdd 
  JOIN D_MW_TASK_INSTANCE d ON (bdd.D_DATE >= TRUNC(d.INSTANCE_START_DATE) AND (bdd.D_DATE <= d.INSTANCE_END_DATE OR d.INSTANCE_END_DATE IS NULL))
                                          OR bdd.D_DATE = TRUNC(d.INSTANCE_START_DATE)
                                          OR bdd.D_DATE = TRUNC(d.INSTANCE_END_DATE)
  LEFT JOIN processes p
      ON d.MW_BI_ID = p.mw_bi_id;