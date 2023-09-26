--Disable Constraints for duration of cleanup script
ALTER TABLE CC_D_AGENT
DISABLE CONSTRAINT CC_D_AGENT__UN;

ALTER TABLE CC_D_AGENT
DISABLE CONSTRAINT CC_D_AGENT_REC_DATE_CK;

--Set duplicate records to an invalid effective date
MERGE INTO CC_D_AGENT a
using ( SELECT * 
	FROM 
	(SELECT
			D_AGENT_ID
	  , LOGIN_ID
	  , VERSION
	  , RECORD_EFF_DT
	  , RECORD_END_DT
	  , LEAD (RECORD_EFF_DT , 1, NULL) OVER (PARTITION BY LOGIN_ID ORDER BY LOGIN_ID, VERSION, RECORD_EFF_DT, RECORD_END_DT) as NEXT_EFF_DT
	  FROM CC_D_AGENT a
	  ORDER BY LOGIN_ID, VERSION, RECORD_EFF_DT, RECORD_END_DT
	  )sub 
	WHERE RECORD_END_DT > NEXT_EFF_DT
	ORDER BY LOGIN_ID, VERSION, RECORD_EFF_DT, RECORD_END_DT
) b
ON (a.D_AGENT_ID = b.D_AGENT_ID)
WHEN matched THEN UPDATE SET a.RECORD_EFF_DT = TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS');

--Update valid records to cover any gaps created by duplicate records
MERGE INTO CC_D_AGENT a
using ( SELECT * 
	FROM 
	(SELECT
			D_AGENT_ID
	  , LOGIN_ID
	  , VERSION
	  , RECORD_EFF_DT
	  , RECORD_END_DT
	  , LEAD (RECORD_EFF_DT , 1, NULL) OVER (PARTITION BY LOGIN_ID ORDER BY LOGIN_ID, VERSION, RECORD_EFF_DT, RECORD_END_DT) as NEXT_EFF_DT
	  FROM CC_D_AGENT a
	  ORDER BY LOGIN_ID, VERSION, RECORD_EFF_DT, RECORD_END_DT
	  )sub 
	WHERE RECORD_END_DT < NEXT_EFF_DT
    AND NEXT_EFF_DT != TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
	ORDER BY LOGIN_ID, VERSION, RECORD_EFF_DT, RECORD_END_DT
) b
ON (a.D_AGENT_ID = b.D_AGENT_ID)
WHEN matched THEN UPDATE SET a.RECORD_END_DT = b.NEXT_EFF_DT;


--Update Fact Tables records to valid D_AGENT record

MERGE INTO CC_F_AGENT_BY_DATE a
using (
  SELECT abd.F_AGENT_BY_DATE_ID
      ,  d.D_DATE
      ,  a.LOGIN_ID
  FROM CC_F_AGENT_BY_DATE abd
  INNER JOIN CC_D_DATES d on abd.D_DATE_ID = d.D_DATE_ID
  INNER JOIN CC_D_AGENT a on abd.D_AGENT_ID = a.D_AGENT_ID
  WHERE abd.D_AGENT_ID IN (
    SELECT sub.D_AGENT_ID
    FROM CC_D_AGENT sub
    WHERE sub.RECORD_EFF_DT = TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS'))
) b
ON (a.F_AGENT_BY_DATE_ID = b.F_AGENT_BY_DATE_ID)
WHEN matched THEN UPDATE SET a.D_AGENT_ID = (SELECT sub2.D_AGENT_ID from CC_D_AGENT sub2 WHERE (b.D_DATE BETWEEN sub2.RECORD_EFF_DT AND sub2.RECORD_END_DT) AND (sub2.LOGIN_ID = b.LOGIN_ID));


MERGE INTO CC_F_AGENT_ACTIVITY_BY_DATE a
using (
  SELECT abd.F_AGENT_ACTIVITY_BY_DATE_ID
      ,  d.D_DATE
      ,  a.LOGIN_ID
  FROM CC_F_AGENT_ACTIVITY_BY_DATE abd
  INNER JOIN CC_D_DATES d on abd.D_DATE_ID = d.D_DATE_ID
  INNER JOIN CC_D_AGENT a on abd.D_AGENT_ID = a.D_AGENT_ID
  WHERE abd.D_AGENT_ID IN (
    SELECT sub.D_AGENT_ID
    FROM CC_D_AGENT sub
    WHERE sub.RECORD_EFF_DT = TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS'))
) b
ON (a.F_AGENT_ACTIVITY_BY_DATE_ID = b.F_AGENT_ACTIVITY_BY_DATE_ID)
WHEN matched THEN UPDATE SET a.D_AGENT_ID = (SELECT sub2.D_AGENT_ID from CC_D_AGENT sub2 WHERE (b.D_DATE BETWEEN sub2.RECORD_EFF_DT AND sub2.RECORD_END_DT) AND (sub2.LOGIN_ID = b.LOGIN_ID));

--Delete duplicate Agent records
DELETE FROM CC_D_AGENT a 
WHERE a.RECORD_EFF_DT = TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS');

--Re-Enable Constraints
ALTER TABLE CC_D_AGENT
ENABLE CONSTRAINT CC_D_AGENT_REC_DATE_CK;

ALTER TABLE CC_D_AGENT
ENABLE CONSTRAINT CC_D_AGENT__UN;

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.1.4.1','101','101_DUPLICATED_AGENT_RECORD_CLEANUP');

COMMIT;