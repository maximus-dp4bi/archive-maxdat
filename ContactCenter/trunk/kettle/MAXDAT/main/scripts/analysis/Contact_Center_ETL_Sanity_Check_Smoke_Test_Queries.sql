---------Contact Center ETL Sanity-Check Smoke Test Queries----------

--Ensure that all facts are populating for the run dates
SELECT DISTINCT(d.D_DATE) 
FROM CC_F_AGENT_BY_DATE abd
INNER JOIN CC_D_DATES d on abd.D_DATE_ID = d.D_DATE_ID
ORDER BY d.D_DATE desc;

SELECT DISTINCT(d.D_DATE) 
FROM CC_F_AGENT_ACTIVITY_BY_DATE aabd
INNER JOIN CC_D_DATES d on aabd.D_DATE_ID = d.D_DATE_ID
ORDER BY d.D_DATE desc;

SELECT DISTINCT(d.D_DATE) 
FROM CC_F_ACTUALS_QUEUE_INTERVAL faqi
INNER JOIN CC_D_DATES d on faqi.D_DATE_ID = d.D_DATE_ID
ORDER BY d.D_DATE desc;

--Ensure that there are no duplicated records in CC_F_AGENT_BY_DATE [Should return no records]
SELECT d.D_DATE
      ,a.LOGIN_ID
      ,COUNT(a.LOGIN_ID)
FROM CC_F_AGENT_BY_DATE abd
INNER JOIN CC_D_DATES d on abd.D_DATE_ID = d.D_DATE_ID
INNER JOIN CC_D_AGENT a on abd.D_AGENT_ID = a.D_AGENT_ID
GROUP BY d.D_DATE, a.LOGIN_ID
HAVING COUNT(a.LOGIN_ID) > 1
ORDER BY a.LOGIN_ID, d.D_DATE;

--Ensure that there are no duplicated records in CC_F_AGENT_ACTIVITY_BY_DATE [Should return no records]
SELECT d.D_DATE
      ,a.LOGIN_ID
      ,at.ACTIVITY_TYPE_NAME
      ,COUNT(at.ACTIVITY_TYPE_NAME)
FROM CC_F_AGENT_ACTIVITY_BY_DATE abd
INNER JOIN CC_D_DATES d on abd.D_DATE_ID = d.D_DATE_ID
INNER JOIN CC_D_AGENT a on abd.D_AGENT_ID = a.D_AGENT_ID
INNER JOIN CC_D_ACTIVITY_TYPE at on abd.D_ACTIVITY_TYPE_ID = at.D_ACTIVITY_TYPE_ID
GROUP BY d.D_DATE, a.LOGIN_ID, at.ACTIVITY_TYPE_NAME
HAVING COUNT(at.ACTIVITY_TYPE_NAME) > 1
ORDER BY a.LOGIN_ID, d.D_DATE, at.ACTIVITY_TYPE_NAME;

--Ensure that there are no duplicated records in CC_F_ACTUALS_QUEUE_INTERVAL [Should return no records]
SELECT d.D_DATE
      ,i.INTERVAL_START_DATE
      ,a.LOGIN_ID
      ,COUNT(a.LOGIN_ID)
FROM CC_F_ACTUALS_QUEUE_INTERVAL abd
INNER JOIN CC_D_DATES d on abd.D_DATE_ID = d.D_DATE_ID
INNER JOIN CC_D_INTERVAL i on abd.D_INTERVAL_ID = i.D_INTERVAL_ID
INNER JOIN CC_D_AGENT a on abd.D_AGENT_ID = a.D_AGENT_ID
WHERE LOGIN_ID != 0
GROUP BY d.D_DATE, i.INTERVAL_START_DATE, a.LOGIN_ID
HAVING COUNT(a.LOGIN_ID) > 1
ORDER BY a.LOGIN_ID, d.D_DATE, i.INTERVAL_START_DATE;

--Ensure that all agents in CC_S_AGENT are accounted for in CC_D_AGENT [Should return no records]
SELECT *
FROM CC_D_AGENT a
WHERE a.LOGIN_ID NOT IN
  (SELECT LOGIN_ID
    FROM CC_S_AGENT sa
  )
ORDER BY a.LOGIN_ID;

--Ensure that no duplicates are being created in CC_D_AGENT [Should return no records]
SELECT a.LOGIN_ID,
       a.VERSION,
       a.RECORD_END_DT,
       COUNT(a.LOGIN_ID)
FROM CC_D_AGENT a
GROUP BY a.LOGIN_ID, a.VERSION, a.RECORD_END_DT
HAVING COUNT(a.LOGIN_ID) > 1
ORDER BY a.LOGIN_ID;

--Ensure that no duplicates are being created in CC_D_CONTACT_QUEUE [Should return no records]
SELECT ccq.QUEUE_NUMBER,
       ccq.VERSION,
       ccq.RECORD_END_DT,
       COUNT(ccq.QUEUE_NUMBER)
FROM CC_D_CONTACT_QUEUE ccq
GROUP BY ccq.QUEUE_NUMBER, ccq.VERSION, ccq.RECORD_END_DT
HAVING COUNT(ccq.QUEUE_NUMBER) > 1
ORDER BY ccq.QUEUE_NUMBER;

--Check that there is no queue in CC_D_CONTACT_QUEUE that is not also in CC_C_CONTACT_QUEUE and CC_C_FILTER [Should return no records?] 
SELECT d_cq.QUEUE_NUMBER as DIM_QUEUE_NUM,
       c_cq.QUEUE_NUMBER as CFG_QUEUE_NUM,
       filter.value as FILTER_QUEUE_NUM
FROM CC_D_CONTACT_QUEUE d_cq
LEFT OUTER JOIN CC_C_CONTACT_QUEUE c_cq on d_cq.QUEUE_NUMBER = c_cq.QUEUE_NUMBER
LEFT OUTER JOIN CC_C_FILTER filter on d_cq.QUEUE_NUMBER = filter.value
WHERE filter.FILTER_TYPE = 'ACD_CALL_TYPE_ID_INC'
AND ((c_cq.QUEUE_NUMBER IS NULL) OR (filter.value IS NULL))
ORDER BY d_cq.QUEUE_NUMBER;

--CC_L_ERROR ??
--CC_L_TRANSFORMATION ??