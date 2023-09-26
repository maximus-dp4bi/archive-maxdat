use schema ineo;
CREATE OR REPLACE VIEW INEO_D_COMPLETED_TASKS_BY_DAY_SV
AS
SELECT t.*,c.work_category,sr.employee_id,sr.region,sr.region_supporting,sr.time_zone
FROM ineo.ineo_completed_task_by_day t
  LEFT JOIN ineo.ineo_task_category c 
    ON REGEXP_REPLACE(TRIM(UPPER(t.task_name)),'[^A-Za-z0-9]') = REGEXP_REPLACE(TRIM(UPPER(c.task_name)),'[^A-Za-z0-9]')
    AND UPPER(TRIM(c.queue)) = UPPER(TRIM(t.work_queue_name))
  LEFT JOIN (SELECT employee_id,fssa_id,region,region_supporting,time_zone
             FROM ineo_all_staff_roster
             WHERE fssa_id IS NOT NULL
             QUALIFY ROW_NUMBER() OVER(PARTITION BY UPPER(fssa_id) ORDER BY employee_id, DECODE(employee_status,'Active',1,2),employee_id DESC) = 1) sr 
    ON UPPER(SUBSTR(sr.fssa_id,6)) = UPPER(TRIM(REGEXP_REPLACE(t.user_id,'fssa.','')));

CREATE OR REPLACE VIEW INEO_D_COMPLETED_TASKS_BY_DAY_HISTORY_SV
AS
SELECT h.*,c.work_category,sr.employee_id,sr.region,sr.region_supporting,sr.time_zone
FROM ineo.ineo_completed_task_by_day_history h
  LEFT JOIN ineo.ineo_task_category c 
    ON REGEXP_REPLACE(TRIM(UPPER(h.task_name)),'[^A-Za-z0-9]') = REGEXP_REPLACE(TRIM(UPPER(c.task_name)),'[^A-Za-z0-9]')
    AND UPPER(TRIM(c.queue)) = UPPER(TRIM(h.work_queue_name))
  LEFT JOIN (SELECT employee_id,fssa_id,region,region_supporting,time_zone
             FROM ineo_all_staff_roster
             WHERE fssa_id IS NOT NULL
             QUALIFY ROW_NUMBER() OVER(PARTITION BY UPPER(fssa_id) ORDER BY employee_id, DECODE(employee_status,'Active',1,2),employee_id DESC) = 1) sr 
    ON UPPER(SUBSTR(sr.fssa_id,6)) = UPPER(TRIM(REGEXP_REPLACE(h.user_id,'fssa.','')));
    
CREATE OR REPLACE VIEW INEO_D_TASK_CATEGORY_SV
AS
SELECT * FROM ineo.ineo_task_category;