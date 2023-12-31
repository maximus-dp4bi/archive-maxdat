--Disable Constraints for duration of cleanup script
ALTER TABLE CC_S_AGENT
DISABLE CONSTRAINT CC_S_AGENT_UN;

ALTER TABLE CC_S_AGENT
DISABLE CONSTRAINT CC_S_AGENT_REC_DATE_CK;

--Set duplicate records to an invalid effective date
MERGE INTO CC_S_AGENT a
using ( SELECT * 
	FROM 
	(SELECT
		AGENT_ID
	  , LOGIN_ID
	  , RECORD_EFF_DT
	  , RECORD_END_DT
	  , LEAD (RECORD_EFF_DT , 1, NULL) OVER (PARTITION BY LOGIN_ID ORDER BY LOGIN_ID, RECORD_EFF_DT, RECORD_END_DT) as NEXT_EFF_DT
	  FROM CC_S_AGENT a
	  ORDER BY LOGIN_ID, RECORD_EFF_DT, RECORD_END_DT
	  )sub 
	WHERE RECORD_END_DT > NEXT_EFF_DT
	ORDER BY LOGIN_ID, RECORD_EFF_DT, RECORD_END_DT
) b
ON (a.AGENT_ID = b.AGENT_ID)
WHEN matched THEN UPDATE SET a.RECORD_EFF_DT = TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS');

--Update Staging Tables records to valid D_AGENT record
MERGE INTO CC_S_ACD_AGENT_ACTIVITY a
using (
  SELECT aaa.ACD_AGENT_ACTIVITY_ID
      ,  a.LOGIN_ID
  FROM CC_S_ACD_AGENT_ACTIVITY aaa
  INNER JOIN CC_S_AGENT a on aaa.AGENT_ID = a.AGENT_ID
  WHERE aaa.AGENT_ID IN (
    SELECT sub.AGENT_ID
    FROM CC_S_AGENT sub
    WHERE sub.RECORD_EFF_DT = TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS'))
) b
ON (a.ACD_AGENT_ACTIVITY_ID = b.ACD_AGENT_ACTIVITY_ID)
WHEN matched THEN UPDATE SET a.AGENT_ID = (SELECT sub2.AGENT_ID from CC_S_AGENT sub2 WHERE(sub2.LOGIN_ID = b.LOGIN_ID) AND (sub2.RECORD_EFF_DT != TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS')));

MERGE INTO CC_S_AGENT_ABSENCE a
using (
  SELECT aa.AGENT_ABSENCE_ID
      ,  a.LOGIN_ID
  FROM CC_S_AGENT_ABSENCE aa
  INNER JOIN CC_S_AGENT a on aa.AGENT_ID = a.AGENT_ID
  WHERE aa.AGENT_ID IN (
    SELECT sub.AGENT_ID
    FROM CC_S_AGENT sub
    WHERE sub.RECORD_EFF_DT = TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS'))
) b
ON (a.AGENT_ABSENCE_ID = b.AGENT_ABSENCE_ID)
WHEN matched THEN UPDATE SET a.AGENT_ID = (SELECT sub2.AGENT_ID from CC_S_AGENT sub2 WHERE(sub2.LOGIN_ID = b.LOGIN_ID) AND (sub2.RECORD_EFF_DT != TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS')));

MERGE INTO CC_S_WFM_AGENT_ACTIVITY a
using (
  SELECT waa.WFM_AGENT_ACTIVITY_ID
      ,  a.LOGIN_ID
  FROM CC_S_WFM_AGENT_ACTIVITY waa
  INNER JOIN CC_S_AGENT a on waa.AGENT_ID = a.AGENT_ID
  WHERE waa.AGENT_ID IN (
    SELECT sub.AGENT_ID
    FROM CC_S_AGENT sub
    WHERE sub.RECORD_EFF_DT = TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS'))
) b
ON (a.WFM_AGENT_ACTIVITY_ID = b.WFM_AGENT_ACTIVITY_ID)
WHEN matched THEN UPDATE SET a.AGENT_ID = (SELECT sub2.AGENT_ID from CC_S_AGENT sub2 WHERE(sub2.LOGIN_ID = b.LOGIN_ID) AND (sub2.RECORD_EFF_DT != TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS')));

MERGE INTO CC_S_AGENT_WORK_DAY a
using (
  SELECT awd.AGENT_WORK_DAY_ID
      ,  a.LOGIN_ID
  FROM CC_S_AGENT_WORK_DAY awd
  INNER JOIN CC_S_AGENT a on awd.AGENT_ID = a.AGENT_ID
  WHERE awd.AGENT_ID IN (
    SELECT sub.AGENT_ID
    FROM CC_S_AGENT sub
    WHERE sub.RECORD_EFF_DT = TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS'))
) b
ON (a.AGENT_WORK_DAY_ID = b.AGENT_WORK_DAY_ID)
WHEN matched THEN UPDATE SET a.AGENT_ID = (SELECT sub2.AGENT_ID from CC_S_AGENT sub2 WHERE(sub2.LOGIN_ID = b.LOGIN_ID) AND (sub2.RECORD_EFF_DT != TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS')));

--Delete duplicate Agent records
DELETE FROM CC_S_AGENT a 
WHERE a.RECORD_EFF_DT = TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS');

--Re-Enable Constraints
ALTER TABLE CC_S_AGENT
ENABLE CONSTRAINT CC_S_AGENT_REC_DATE_CK;

ALTER TABLE CC_S_AGENT
ENABLE CONSTRAINT CC_S_AGENT_UN;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.3.1','200','200_DUPLICATED_S_AGENT_RECORD_CLEANUP');

COMMIT;