--Set duplicate records to an invalid effective date
MERGE INTO CC_D_ACD_AGENT_SUPERVISOR a
using (SELECT * 
FROM 
	(SELECT
		D_AGENT_SUPERVISOR_ID
	  , D_AGENT_ID
	  , AGENT_LOGIN_ID
	  , D_SUPERVISOR_ID
    ,SUPERVISOR_LOGIN_ID
	  , VERSION
	  , RECORD_EFF_DT
	  , RECORD_END_DT
	  , LEAD (RECORD_EFF_DT , 1, NULL) OVER (PARTITION BY AGENT_LOGIN_ID ORDER BY AGENT_LOGIN_ID, VERSION, RECORD_EFF_DT, RECORD_END_DT) as NEXT_EFF_DT
	  FROM CC_D_ACD_AGENT_SUPERVISOR a
	  ORDER BY AGENT_LOGIN_ID, VERSION, RECORD_EFF_DT, RECORD_END_DT
	  )sub 
WHERE RECORD_END_DT > NEXT_EFF_DT
ORDER BY AGENT_LOGIN_ID, VERSION, RECORD_EFF_DT, RECORD_END_DT
) b
ON (a.D_AGENT_SUPERVISOR_ID = b.D_AGENT_SUPERVISOR_ID)
WHEN matched THEN UPDATE SET a.RECORD_END_DT = TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS');


--Delete duplicate Agent records
DELETE FROM CC_D_ACD_AGENT_SUPERVISOR a 
WHERE a.RECORD_END_DT = TO_DATE('2999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS');

--Update valid records to cover any gaps created by duplicate records
MERGE INTO CC_D_ACD_AGENT_SUPERVISOR a
        using (SELECT * 
        FROM 
          (SELECT
            D_AGENT_SUPERVISOR_ID
            , D_AGENT_ID
            , AGENT_LOGIN_ID
            , D_SUPERVISOR_ID
            ,SUPERVISOR_LOGIN_ID
            , VERSION
            , RECORD_EFF_DT
            , RECORD_END_DT
            , LEAD (RECORD_EFF_DT , 1, NULL) OVER (PARTITION BY AGENT_LOGIN_ID ORDER BY AGENT_LOGIN_ID, VERSION, RECORD_EFF_DT, RECORD_END_DT) as NEXT_EFF_DT
            FROM CC_D_ACD_AGENT_SUPERVISOR a
            ORDER BY AGENT_LOGIN_ID, VERSION, RECORD_EFF_DT, RECORD_END_DT
            )sub 
            WHERE RECORD_END_DT < NEXT_EFF_DT
            ORDER BY AGENT_LOGIN_ID, VERSION, RECORD_EFF_DT, RECORD_END_DT
        ) b
ON (a.D_AGENT_SUPERVISOR_ID = b.D_AGENT_SUPERVISOR_ID)
WHEN matched THEN UPDATE SET a.RECORD_END_DT = b.NEXT_EFF_DT;

commit;