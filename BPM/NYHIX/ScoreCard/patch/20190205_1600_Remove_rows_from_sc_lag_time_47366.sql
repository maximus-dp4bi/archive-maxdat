-- NYHIX-47366
DECLARE

v_before_count NUMBER := 0;
v_delete_count NUMBER := 0;
v_after_count  NUMBER := 0;

BEGIN

  SELECT COUNT(0)  -- 11 records
  INTO   v_before_count
  FROM DP_SCORECARD.Sc_Lag_Time
  WHERE (AGENT_ID ='140508' AND TRUNC(LAG_DATE) =  '10-JAN-19')
  OR (AGENT_ID = '247444' AND TRUNC(LAG_DATE) in ('03-JAN-19', '04-JAN-19', '07-JAN-19'))
  OR (AGENT_ID = '247297' AND TRUNC(LAG_DATE) IN ('04-JAN-19','07-JAN-19','09-JAN-19','10-JAN-19','11-JAN-19','15-JAN-19'));

  dbms_output.put_line('Before record count: '||v_before_count);

  IF v_before_count > 0
  THEN

    DELETE FROM DP_SCORECARD.Sc_Lag_Time
    WHERE (AGENT_ID ='140508' AND TRUNC(LAG_DATE) =  '10-JAN-19')
    OR (AGENT_ID = '247444' AND TRUNC(LAG_DATE) in ('03-JAN-19', '04-JAN-19', '07-JAN-19'))
    OR (AGENT_ID = '247297' AND TRUNC(LAG_DATE) IN ('04-JAN-19','07-JAN-19','09-JAN-19','10-JAN-19','11-JAN-19','15-JAN-19'));

    v_delete_count := SQL%ROWCOUNT;

    dbms_output.put_line('Records deleted: '||v_delete_count);
  
--    IF v_delete_count = v_before_count
--    THEN
--      COMMIT;
--      dbms_output.put_line('Delete committed');
--    ELSE
--      ROLLBACK;
--      dbms_output.put_line('Deletes records rolled back');
--    END IF;

    dbms_output.put_line('Do not commit unless the number of deleted records is equal to 11');

  ELSE

    dbms_output.put_line('No records found, skip the delete');

  END IF;

  SELECT COUNT(0)  -- should be zero records
  INTO   v_after_count
  FROM DP_SCORECARD.Sc_Lag_Time
  WHERE (AGENT_ID ='140508' AND TRUNC(LAG_DATE) =  '10-JAN-19')
  OR (AGENT_ID = '247444' AND TRUNC(LAG_DATE) in ('03-JAN-19', '04-JAN-19', '07-JAN-19'))
  OR (AGENT_ID = '247297' AND TRUNC(LAG_DATE) IN ('04-JAN-19','07-JAN-19','09-JAN-19','10-JAN-19','11-JAN-19','15-JAN-19'));

  dbms_output.put_line('After record count (will be zero after the commit is performed): '||v_after_count);

END;
/
