-- NYHIX-54743
DECLARE

v_before_count NUMBER := 0;
v_delete_count NUMBER := 0;
v_after_count  NUMBER := 0;

BEGIN

  SELECT COUNT(0)    INTO   v_before_count  FROM DP_SCORECARD.Sc_Lag_Time  WHERE (AGENT_ID IN ('256938') AND TRUNC(LAG_DATE) in ('11-NOV-19'));
  dbms_output.put_line('Before record count: '||v_before_count);

  IF v_before_count > 0
  THEN

    DELETE FROM DP_SCORECARD.Sc_Lag_Time WHERE (AGENT_ID IN ('256938') AND TRUNC(LAG_DATE) in ('11-NOV-19'));

    v_delete_count := SQL%ROWCOUNT;
    dbms_output.put_line('Records deleted: '||v_delete_count);
  
    dbms_output.put_line('Do not commit unless the number of deleted records is equal to '||v_before_count);

  ELSE

    dbms_output.put_line('No records found, skip the delete');

  END IF;

  SELECT COUNT(0)  -- should be zero records
  INTO   v_after_count   FROM DP_SCORECARD.Sc_Lag_Time WHERE (AGENT_ID IN ('256938') AND TRUNC(LAG_DATE) in ('11-NOV-19'));
  

  dbms_output.put_line('After record count (will be zero after the commit is performed): '||v_after_count);

END;
/
