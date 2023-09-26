drop view F_PI_BY_DATE_SV;
CREATE OR REPLACE VIEW F_PI_BY_DATE_SV
AS
 SELECT d_date      
       ,SUM(creation_count) creation_count
       ,SUM(inventory_count) inventory_count
       ,SUM(completion_count) completion_count
       ,SUM(cancellation_count) cancellation_count
       ,SUM(completion_count) + SUM(cancellation_count) termination_count
FROM (
  SELECT TRUNC(create_ts) d_date, COUNT(1) creation_count, 0 inventory_count, 0 completion_count, 0 cancellation_count
  FROM eb.incident_header i
  WHERE incident_header_type_cd = 'COMPLAINT'
  AND (i.received_ts >=GREATEST(TO_DATE('&schemadatelimit','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))  OR i.status_cd not IN('CLOSED','STATE_COMPLETED'))
  GROUP BY TRUNC(create_ts)
  UNION ALL
  SELECT TRUNC(CASE WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN TRUNC(i.status_ts) ELSE NULL END) d_date, 0 creation_count, 0 inventory_count, COUNT(1) completion_count,0 cancellation_count
  FROM eb.incident_header i
  WHERE i.incident_header_type_cd = 'COMPLAINT' 
  AND (CASE WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN TRUNC(i.status_ts) ELSE NULL END) IS NOT NULL
  AND (i.received_ts >=GREATEST(TO_DATE('&schemadatelimit','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))  OR i.status_cd not IN('CLOSED','STATE_COMPLETED'))
  GROUP BY TRUNC(CASE WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN TRUNC(i.status_ts) ELSE NULL END)
  UNION ALL 
  SELECT d_date,  0 creation_count, COUNT(1) inventory_count, 0 completion_count, 0 cancellation_count
  FROM eb.incident_header i
    JOIN d_dates bdd
      ON  bdd.D_DATE >= TRUNC(create_ts)
     AND (bdd.D_DATE < TRUNC(CASE WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN TRUNC(i.status_ts) ELSE NULL END)  
       OR TRUNC(CASE WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN TRUNC(i.status_ts) ELSE NULL END) IS NULL)
  WHERE i.incident_header_type_cd = 'COMPLAINT'     
  AND (i.received_ts >=GREATEST(TO_DATE('&schemadatelimit','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13))  OR i.status_cd not IN('CLOSED','STATE_COMPLETED'))
  GROUP BY d_date
 ) pi
GROUP BY d_date
; 
 
  
  GRANT SELECT ON MAXDAT_SUPPORT.F_PI_BY_DATE_SV TO MAXDAT_REPORTS ;
  GRANT SELECT ON MAXDAT_SUPPORT.F_PI_BY_DATE_SV TO MAXDATSUPPORT_READ_ONLY ;
