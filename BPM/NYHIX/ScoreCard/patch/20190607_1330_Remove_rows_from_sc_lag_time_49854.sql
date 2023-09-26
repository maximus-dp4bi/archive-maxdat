-- NYHIX-47366
DECLARE

v_before_count NUMBER := 0;
v_delete_count NUMBER := 0;
v_after_count  NUMBER := 0;

BEGIN

  SELECT COUNT(0)  -- 12 records
  INTO   v_before_count
  FROM DP_SCORECARD.Sc_Lag_Time
  WHERE (AGENT_ID IN ('254554') AND TRUNC(LAG_DATE)in ('08-May-19'))
  OR (AGENT_ID = '123263' AND TRUNC(LAG_DATE) in ('09-May-19'))
  OR (AGENT_ID = '125047' AND TRUNC(LAG_DATE) in ('18-May-19'))
  OR (AGENT_ID = '86055' AND TRUNC(LAG_DATE) in ('10-May-19','13-May-19','14-May-19','16-May-19'))
  OR (AGENT_ID = '130310' AND TRUNC(LAG_DATE) in ('09-May-19','10-May-19','14-May-19','16-May-19'))
  OR (AGENT_ID = '248382' AND TRUNC(LAG_DATE) in ('03-May-19'))
  OR (AGENT_ID = '118022' AND TRUNC(LAG_DATE) in ('20-May-19'));

  dbms_output.put_line('Before record count: '||v_before_count);

  IF v_before_count > 0
  THEN

    DELETE FROM DP_SCORECARD.Sc_Lag_Time
    WHERE (AGENT_ID IN ('254554') AND TRUNC(LAG_DATE)in ('08-May-19'))
    OR (AGENT_ID = '123263' AND TRUNC(LAG_DATE) in ('09-May-19'))
    OR (AGENT_ID = '125047' AND TRUNC(LAG_DATE) in ('18-May-19'))
    OR (AGENT_ID = '86055' AND TRUNC(LAG_DATE) in ('10-May-19','13-May-19','14-May-19','16-May-19'))
    OR (AGENT_ID = '130310' AND TRUNC(LAG_DATE) in ('09-May-19','10-May-19','14-May-19','16-May-19'))
    OR (AGENT_ID = '248382' AND TRUNC(LAG_DATE) in ('03-May-19'))
    OR (AGENT_ID = '118022' AND TRUNC(LAG_DATE) in ('20-May-19'));

    v_delete_count := SQL%ROWCOUNT;

    dbms_output.put_line('Records deleted: '||v_delete_count);
  
    dbms_output.put_line('Do not commit unless the number of deleted records is equal to '||v_before_count);

  ELSE

    dbms_output.put_line('No records found, skip the delete');

  END IF;

  SELECT COUNT(0)  -- should be zero records
  INTO   v_after_count
  FROM DP_SCORECARD.Sc_Lag_Time
  WHERE (AGENT_ID IN ('254554') AND TRUNC(LAG_DATE)in ('08-May-19'))
  OR (AGENT_ID = '123263' AND TRUNC(LAG_DATE) in ('09-May-19'))
  OR (AGENT_ID = '125047' AND TRUNC(LAG_DATE) in ('18-May-19'))
  OR (AGENT_ID = '86055' AND TRUNC(LAG_DATE) in ('10-May-19','13-May-19','14-May-19','16-May-19'))
  OR (AGENT_ID = '130310' AND TRUNC(LAG_DATE) in ('09-May-19','10-May-19','14-May-19','16-May-19'))
  OR (AGENT_ID = '248382' AND TRUNC(LAG_DATE) in ('03-May-19'))
  OR (AGENT_ID = '118022' AND TRUNC(LAG_DATE) in ('20-May-19'));

  dbms_output.put_line('After record count (will be zero after the commit is performed): '||v_after_count);

END;
/
