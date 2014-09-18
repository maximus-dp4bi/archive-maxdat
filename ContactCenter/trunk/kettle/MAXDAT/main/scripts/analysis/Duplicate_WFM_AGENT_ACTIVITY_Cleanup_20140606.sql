
--Recalculate related F_AGENT_ACTIVITY_BY_DATE records sans duplicates
UPDATE CC_F_AGENT_ACTIVITY_BY_DATE faabd
SET ACTIVITY_MINUTES = 
    (SELECT (SUM(ACTIVITY_DURATION_SECONDS)/60)
        FROM CC_S_WFM_AGENT_ACTIVITY swaa
        INNER JOIN CC_D_DATES dd on swaa.ACTIVITY_DT = dd.D_DATE
        INNER JOIN CC_S_AGENT sa on swaa.AGENT_ID = sa.AGENT_ID
        INNER JOIN CC_D_AGENT da on sa.LOGIN_ID = da.LOGIN_ID
        INNER JOIN CC_C_ACTIVITY_TYPE sat on swaa.ACTIVITY_TYPE_ID = sat.ACTIVITY_TYPE_ID
        INNER JOIN CC_D_ACTIVITY_TYPE dat on sat.ACTIVITY_TYPE_NAME = dat.ACTIVITY_TYPE_NAME
        WHERE dd.D_DATE_ID = faabd.D_DATE_ID
          AND da.D_AGENT_ID = faabd.D_AGENT_ID
          AND dat.D_ACTIVITY_TYPE_ID = faabd.D_ACTIVITY_TYPE_ID
          AND swaa.WFM_AGENT_ACTIVITY_ID NOT IN
              (WITH 
              sub as (
                SELECT s.ACTIVITY_START_TIME, s.AGENT_ID, s.ACTIVITY_TYPE_ID, count(agent_id)
                FROM CC_S_WFM_AGENT_ACTIVITY s
                GROUP BY ACTIVITY_START_TIME, agent_id, s.activity_type_id
                HAVING count(agent_id) > 1
              ),
              sub2 as (SELECT AGENT_ID
                      , ACTIVITY_TYPE_ID
                      , ACTIVITY_START_TIME
                      , MAX(ACTIVITY_END_TIME) as MAX_ACTIVITY_END_TIME
                 FROM CC_S_WFM_AGENT_ACTIVITY 
                 GROUP BY ACTIVITY_START_TIME, agent_id, activity_type_id
                 HAVING count(agent_id) > 1)
              SELECT WFM_AGENT_ACTIVITY_ID
              FROM CC_S_WFM_AGENT_ACTIVITY s, sub, sub2
              WHERE s.ACTIVITY_START_TIME = sub.ACTIVITY_START_TIME
              AND s.ACTIVITY_START_TIME = sub2.ACTIVITY_START_TIME
              AND s.AGENT_ID = sub.AGENT_ID
              AND s.AGENT_ID = sub2.AGENT_ID
              AND s.ACTIVITY_TYPE_ID = sub.ACTIVITY_TYPE_ID
              AND s.ACTIVITY_TYPE_ID = sub2.ACTIVITY_TYPE_ID
              AND s.ACTIVITY_END_TIME != sub2.MAX_ACTIVITY_END_TIME
              ))
WHERE F_AGENT_ACTIVITY_BY_DATE_ID IN (
    SELECT DISTINCT(F_AGENT_ACTIVITY_BY_DATE_ID)
    FROM CC_F_AGENT_ACTIVITY_BY_DATE aabd 
    INNER JOIN CC_D_DATES dd on aabd.D_DATE_ID = dd.D_DATE_ID
    INNER JOIN CC_D_AGENT da on aabd.D_AGENT_ID = da.D_AGENT_ID
    INNER JOIN CC_D_ACTIVITY_TYPE dat on aabd.D_ACTIVITY_TYPE_ID = dat.D_ACTIVITY_TYPE_ID
    INNER JOIN (SELECT s.ACTIVITY_START_TIME, s.AGENT_ID, a.LOGIN_ID, s.ACTIVITY_TYPE_ID, at.ACTIVITY_TYPE_NAME
                FROM CC_S_WFM_AGENT_ACTIVITY s
                INNER JOIN CC_S_AGENT a on s.AGENT_ID = a.AGENT_ID
                INNER JOIN CC_C_ACTIVITY_TYPE at on s.ACTIVITY_TYPE_ID = at.ACTIVITY_TYPE_ID
                GROUP BY s.ACTIVITY_START_TIME, s.AGENT_ID, a.LOGIN_ID, s.ACTIVITY_TYPE_ID, at.ACTIVITY_TYPE_NAME
                HAVING count(s.agent_id) > 1
                )sub on ((dd.D_DATE = trunc(sub.ACTIVITY_START_TIME))
                         AND(da.LOGIN_ID = sub.LOGIN_ID)
                         AND(dat.ACTIVITY_TYPE_NAME = sub.ACTIVITY_TYPE_NAME))
    );

--Delete Duplicated WFM_AGENT_ACTIVITY records with earlier ACTIVITY_END_DATEs
DELETE 
FROM CC_S_WFM_AGENT_ACTIVITY
WHERE WFM_AGENT_ACTIVITY_ID IN
  (WITH 
  sub as (
    SELECT s.ACTIVITY_START_TIME, s.AGENT_ID, s.ACTIVITY_TYPE_ID, count(agent_id)
    FROM CC_S_WFM_AGENT_ACTIVITY s
    GROUP BY ACTIVITY_START_TIME, agent_id, s.activity_type_id
    HAVING count(agent_id) > 1
  ),
  sub2 as (SELECT AGENT_ID
          , ACTIVITY_TYPE_ID
          , ACTIVITY_START_TIME
          , MAX(ACTIVITY_END_TIME) as MAX_ACTIVITY_END_TIME
     FROM CC_S_WFM_AGENT_ACTIVITY 
     GROUP BY ACTIVITY_START_TIME, agent_id, activity_type_id
     HAVING count(agent_id) > 1)
  SELECT WFM_AGENT_ACTIVITY_ID
  FROM CC_S_WFM_AGENT_ACTIVITY s, sub, sub2
  WHERE s.ACTIVITY_START_TIME = sub.ACTIVITY_START_TIME
  AND s.ACTIVITY_START_TIME = sub2.ACTIVITY_START_TIME
  AND s.AGENT_ID = sub.AGENT_ID
  AND s.AGENT_ID = sub2.AGENT_ID
  AND s.ACTIVITY_TYPE_ID = sub.ACTIVITY_TYPE_ID
  AND s.ACTIVITY_TYPE_ID = sub2.ACTIVITY_TYPE_ID
  AND s.ACTIVITY_END_TIME != sub2.MAX_ACTIVITY_END_TIME
  );