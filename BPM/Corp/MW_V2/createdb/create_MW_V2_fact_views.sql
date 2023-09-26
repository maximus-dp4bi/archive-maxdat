
CREATE OR REPLACE VIEW F_MW_V2_TASK_TYPES_BY_DAY_SV
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
GROUP BY d_date,task_type_id
;                                         

GRANT SELECT ON F_MW_V2_TASK_TYPES_BY_DAY_SV TO MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW F_MW_V2_TASK_TYPES_BY_WEEK_SV 
AS 
SELECT TO_NUMBER(CASE WHEN TO_CHAR(d_date,'iw') = 1 THEN TO_CHAR(TRUNC(d_date,'iw')+6,'YYYY')
      ELSE TO_CHAR(TRUNC(d_date,'iw'),'YYYY')END ||TO_CHAR(d_date,'iw')) d_week
    ,task_type_id
    ,SUM(creation_count) creation_count
    ,SUM(completion_count) completion_count
    ,SUM(cancellation_count) cancellation_count
    ,SUM(termination_count) termination_count  
FROM (    
  SELECT create_date d_date  
         ,task_type_id
         ,1 creation_count       
         ,0 completion_count
         ,0 cancellation_count
         ,0 termination_count
  FROM d_mw_v2_current
  UNION ALL
  SELECT COALESCE(complete_date, cancel_work_date) d_date
         ,task_type_id
         ,0 creation_count
         ,CASE WHEN complete_date IS NOT NULL THEN 1 ELSE 0 END completion_count
         ,CASE WHEN cancel_work_date IS NOT NULL THEN 1 ELSE 0 END cancellation_count
         ,CASE WHEN complete_date IS NOT NULL OR cancel_work_date IS NOT NULL THEN 1 ELSE 0 END termination_count      
  FROM d_mw_v2_current
  WHERE complete_date IS NOT NULL OR cancel_work_date IS NOT NULL  
  UNION ALL
  SELECT d_date
       ,task_type_id
       ,0 creation_count
       ,0 completion_count
       ,0 cancellation_count
       ,0 termination_count
   FROM d_task_types
    CROSS JOIN d_dates  ) mw_tmp
GROUP BY  TO_NUMBER(CASE WHEN TO_CHAR(d_date,'iw') = 1 THEN TO_CHAR(TRUNC(d_date,'iw')+6,'YYYY')
      ELSE TO_CHAR(TRUNC(d_date,'iw'),'YYYY')END ||TO_CHAR(d_date,'iw')),task_type_id;


GRANT SELECT ON F_MW_V2_TASK_TYPES_BY_WEEK_SV TO MAXDAT_READ_ONLY;      

CREATE OR REPLACE VIEW F_MW_V2_TASK_TYPES_BY_MONTH_SV
AS
SELECT TO_NUMBER(TO_CHAR(d_date,'yyyy')||TO_CHAR(d_date,'mm')) d_month
    ,task_type_id
    ,SUM(creation_count) creation_count
    ,SUM(completion_count) completion_count
    ,SUM(cancellation_count) cancellation_count
    ,SUM(termination_count) termination_count  
FROM (    
  SELECT create_date d_date  
         ,task_type_id
         ,1 creation_count       
         ,0 completion_count
         ,0 cancellation_count
         ,0 termination_count
  FROM d_mw_v2_current
  UNION ALL
  SELECT COALESCE(complete_date, cancel_work_date) d_date
         ,task_type_id
         ,0 creation_count
         ,CASE WHEN complete_date IS NOT NULL THEN 1 ELSE 0 END completion_count
         ,CASE WHEN cancel_work_date IS NOT NULL THEN 1 ELSE 0 END cancellation_count
         ,CASE WHEN complete_date IS NOT NULL OR cancel_work_date IS NOT NULL THEN 1 ELSE 0 END termination_count      
  FROM d_mw_v2_current
  WHERE complete_date IS NOT NULL OR cancel_work_date IS NOT NULL
  UNION ALL
  SELECT d_date
       ,task_type_id
       ,0 creation_count
       ,0 completion_count
       ,0 cancellation_count
       ,0 termination_count
   FROM d_task_types
    CROSS JOIN d_dates) mw_tmp
GROUP BY TO_NUMBER(TO_CHAR(d_date,'yyyy')||TO_CHAR(d_date,'mm')), task_type_id;


GRANT SELECT ON F_MW_V2_TASK_TYPES_BY_MONTH_SV TO MAXDAT_READ_ONLY; 

--by year
CREATE OR REPLACE VIEW F_MW_V2_TASK_TYPES_BY_YEAR_SV
AS
SELECT TO_CHAR(d_date,'yyyy') d_year  
    ,task_type_id
    ,SUM(creation_count) creation_count
    ,SUM(completion_count) completion_count
    ,SUM(cancellation_count) cancellation_count
    ,SUM(termination_count) termination_count  
FROM (    
  SELECT create_date d_date       
         ,task_type_id
         ,1 creation_count       
         ,0 completion_count
         ,0 cancellation_count
         ,0 termination_count
  FROM d_mw_v2_current
  UNION ALL
  SELECT COALESCE(complete_date, cancel_work_date) d_date
         ,task_type_id
         ,0 creation_count
         ,CASE WHEN complete_date IS NOT NULL THEN 1 ELSE 0 END completion_count
         ,CASE WHEN cancel_work_date IS NOT NULL THEN 1 ELSE 0 END cancellation_count
         ,CASE WHEN complete_date IS NOT NULL OR cancel_work_date IS NOT NULL THEN 1 ELSE 0 END termination_count      
  FROM d_mw_v2_current
  WHERE complete_date IS NOT NULL OR cancel_work_date IS NOT NULL
  UNION ALL
  SELECT d_date
       ,task_type_id
       ,0 creation_count
       ,0 completion_count
       ,0 cancellation_count
       ,0 termination_count
   FROM d_task_types
    CROSS JOIN d_dates) mw_tmp
GROUP BY TO_CHAR(d_date,'yyyy'),task_type_id
;

GRANT SELECT ON F_MW_V2_TASK_TYPES_BY_YEAR_SV TO MAXDAT_READ_ONLY; 

CREATE OR REPLACE VIEW F_MW_V2_BY_DAY_SV
AS
SELECT d_date      
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
 ) mw
GROUP BY d_date
;                                         

GRANT SELECT ON F_MW_V2_BY_DAY_SV TO MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW F_MW_V2_BY_WEEK_SV 
AS 
SELECT TO_NUMBER(CASE WHEN TO_CHAR(d_date,'iw') = 1 THEN TO_CHAR(TRUNC(d_date,'iw')+6,'YYYY')
      ELSE TO_CHAR(TRUNC(d_date,'iw'),'YYYY')END ||TO_CHAR(d_date,'iw')) d_week    
    ,SUM(creation_count) creation_count
    ,SUM(completion_count) completion_count
    ,SUM(cancellation_count) cancellation_count
    ,SUM(termination_count) termination_count  
FROM (    
  SELECT create_date d_date          
         ,1 creation_count       
         ,0 completion_count
         ,0 cancellation_count
         ,0 termination_count
  FROM d_mw_v2_current
  UNION ALL
  SELECT COALESCE(complete_date, cancel_work_date) d_date         
         ,0 creation_count
         ,CASE WHEN complete_date IS NOT NULL THEN 1 ELSE 0 END completion_count
         ,CASE WHEN cancel_work_date IS NOT NULL THEN 1 ELSE 0 END cancellation_count
         ,CASE WHEN complete_date IS NOT NULL OR cancel_work_date IS NOT NULL THEN 1 ELSE 0 END termination_count      
  FROM d_mw_v2_current
  WHERE complete_date IS NOT NULL OR cancel_work_date IS NOT NULL ) mw_tmp
GROUP BY  TO_NUMBER(CASE WHEN TO_CHAR(d_date,'iw') = 1 THEN TO_CHAR(TRUNC(d_date,'iw')+6,'YYYY')
      ELSE TO_CHAR(TRUNC(d_date,'iw'),'YYYY')END ||TO_CHAR(d_date,'iw'));


GRANT SELECT ON F_MW_V2_BY_WEEK_SV TO MAXDAT_READ_ONLY;      

CREATE OR REPLACE VIEW F_MW_V2_BY_MONTH_SV
AS
SELECT TO_NUMBER(TO_CHAR(d_date,'yyyy')||TO_CHAR(d_date,'mm')) d_month    
    ,SUM(creation_count) creation_count
    ,SUM(completion_count) completion_count
    ,SUM(cancellation_count) cancellation_count
    ,SUM(termination_count) termination_count  
FROM (    
  SELECT create_date d_date          
         ,1 creation_count       
         ,0 completion_count
         ,0 cancellation_count
         ,0 termination_count
  FROM d_mw_v2_current
  UNION ALL
  SELECT COALESCE(complete_date, cancel_work_date) d_date         
         ,0 creation_count
         ,CASE WHEN complete_date IS NOT NULL THEN 1 ELSE 0 END completion_count
         ,CASE WHEN cancel_work_date IS NOT NULL THEN 1 ELSE 0 END cancellation_count
         ,CASE WHEN complete_date IS NOT NULL OR cancel_work_date IS NOT NULL THEN 1 ELSE 0 END termination_count      
  FROM d_mw_v2_current
  WHERE complete_date IS NOT NULL OR cancel_work_date IS NOT NULL) mw_tmp
GROUP BY TO_NUMBER(TO_CHAR(d_date,'yyyy')||TO_CHAR(d_date,'mm'));


GRANT SELECT ON F_MW_V2_BY_MONTH_SV TO MAXDAT_READ_ONLY; 

--by year
CREATE OR REPLACE VIEW F_MW_V2_BY_YEAR_SV
AS
SELECT TO_CHAR(d_date,'yyyy') d_year     
    ,SUM(creation_count) creation_count
    ,SUM(completion_count) completion_count
    ,SUM(cancellation_count) cancellation_count
    ,SUM(termination_count) termination_count  
FROM (    
  SELECT create_date d_date              
         ,1 creation_count       
         ,0 completion_count
         ,0 cancellation_count
         ,0 termination_count
  FROM d_mw_v2_current
  UNION ALL
  SELECT COALESCE(complete_date, cancel_work_date) d_date        
         ,0 creation_count
         ,CASE WHEN complete_date IS NOT NULL THEN 1 ELSE 0 END completion_count
         ,CASE WHEN cancel_work_date IS NOT NULL THEN 1 ELSE 0 END cancellation_count
         ,CASE WHEN complete_date IS NOT NULL OR cancel_work_date IS NOT NULL THEN 1 ELSE 0 END termination_count      
  FROM d_mw_v2_current
  WHERE complete_date IS NOT NULL OR cancel_work_date IS NOT NULL ) mw_tmp
GROUP BY TO_CHAR(d_date,'yyyy')
;

GRANT SELECT ON F_MW_V2_BY_YEAR_SV TO MAXDAT_READ_ONLY; 
