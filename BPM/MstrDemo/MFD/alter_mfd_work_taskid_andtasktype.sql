ALTER TABLE d_mfd_current
ADD(task_id NUMBER, task_type VARCHAR2(256));

MERGE INTO d_mfd_current d
USING (SELECT d.nyhix_mfd_bi_id
              ,t.task_id
              ,t.task_name
       FROM d_mfd_current d
         JOIN (SELECT * 
               FROM (SELECT t.*, RANK() OVER (PARTITION BY source_reference_id ORDER BY task_id DESC) rnk
                FROM stg_mfd_tasks t)
               WHERE rnk = 1) t ON t.source_reference_id = d.app_doc_tracker_id) tmp ON (d.nyhix_mfd_bi_id = tmp.nyhix_mfd_bi_id)
WHEN MATCHED THEN 
UPDATE 
SET task_id = tmp.task_id
    ,task_type = tmp.task_name;
    
MERGE INTO d_mfd_current d
USING (SELECT d.nyhix_mfd_bi_id
              ,t.task_id
              ,t.task_name
       FROM d_mfd_current d
         JOIN (SELECT * 
               FROM (SELECT t.*, RANK() OVER (PARTITION BY source_reference_id ORDER BY task_id DESC) rnk
                FROM stg_mfd_tasks t)
               WHERE rnk = 1) t ON t.source_reference_id = d.app_doc_data_id) tmp ON (d.nyhix_mfd_bi_id = tmp.nyhix_mfd_bi_id)
WHEN MATCHED THEN 
UPDATE 
SET task_id = tmp.task_id
    ,task_type = tmp.task_name;    

commit; 