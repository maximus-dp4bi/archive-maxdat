DROP VIEW F_MW_V2_TASKS_BY_DAY;

CREATE OR REPLACE VIEW F_MW_V2_BY_DATE_SV AS 
SELECT        d.MW_BI_ID,
              bdd.D_DATE,
              CASE WHEN bdd.D_DATE = TRUNC(d.CREATE_DATE) THEN 1 ELSE 0 END AS CREATION_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(d.COMPLETE_DATE) OR bdd.D_DATE = TRUNC(d.CANCEL_WORK_DATE)) THEN 0 ELSE 1 END AS INVENTORY_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(d.COMPLETE_DATE) THEN 1 ELSE 0 END AS COMPLETION_COUNT,
              CASE WHEN bdd.D_DATE = TRUNC(d.CANCEL_WORK_DATE) THEN 1 ELSE 0 END AS CANCELLATION_COUNT,
              CASE WHEN (bdd.D_DATE = TRUNC(d.COMPLETE_DATE) OR bdd.D_DATE = TRUNC(d.CANCEL_WORK_DATE)) THEN 1 ELSE 0 END AS TERMINATION_COUNT              
  FROM D_DATES bdd 
  JOIN D_MW_V2_CURRENT d ON (bdd.D_DATE >= TRUNC(d.INSTANCE_START_DATE) AND (bdd.D_DATE <= d.INSTANCE_END_DATE OR d.INSTANCE_END_DATE IS NULL))
                                          OR bdd.D_DATE = TRUNC(d.INSTANCE_START_DATE)
                                          OR bdd.D_DATE = TRUNC(d.INSTANCE_END_DATE);


RENAME F_MW_V2_BY_DATE_SV TO F_MW_V2_TASKS_BY_DAY;

GRANT SELECT ON F_MW_V2_TASKS_BY_DAY TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW F_MW_V2_TASK_TYPES_BY_DAY
AS
SELECT d_date
       ,task_type_id
       ,SUM(creation_count) creation_count
       ,SUM(inventory_count) inventory_count
       ,SUM(completion_count) completion_count
       ,SUM(cancellation_count) cancellation_count
       ,SUM(completion_count) + SUM(cancellation_count) termination_count
FROM (
  SELECT TRUNC(create_date) d_date, task_type_id, COUNT(1) creation_count, 0 inventory_count, 0 completion_count, 0 cancellation_count
  FROM d_mw_v2_current
  GROUP BY TRUNC(create_date), task_type_id
  UNION ALL
  SELECT TRUNC(complete_date) d_date, task_type_id, 0 creation_count, 0 inventory_count, COUNT(1) completion_count,0 cancellation_count
  FROM d_mw_v2_current
  WHERE complete_date IS NOT NULL
  GROUP BY TRUNC(complete_date), task_type_id
  UNION ALL 
  SELECT TRUNC(cancel_work_date) d_date, task_type_id, 0 creation_count, 0 inventory_count, 0 completion_count, COUNT(1) cancellation_count
  FROM d_mw_v2_current
  WHERE cancel_work_date IS NOT NULL
  GROUP BY TRUNC(cancel_work_date), task_type_id
  UNION ALL 
  SELECT d_date, task_type_id, 0 creation_count, COUNT(1) inventory_count, 0 completion_count, 0 cancellation_count
  FROM d_mw_v2_current
    JOIN d_dates bdd
      ON  bdd.D_DATE >= TRUNC(instance_start_date)
     AND (bdd.D_DATE < TRUNC(instance_end_date)  OR instance_end_date IS NULL)
  GROUP BY d_date, task_type_id
  UNION ALL 
  SELECT d_date,task_type_id,0 creation_count,0 inventory_count,0 completion_count,0 cancellation_count     
  FROM d_task_types
    CROSS JOIN d_dates ) mw
GROUP BY d_date,task_type_id;

GRANT SELECT ON F_MW_V2_TASK_TYPES_BY_DAY TO MAXDAT_READ_ONLY;
