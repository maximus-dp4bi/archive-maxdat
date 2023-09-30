-- NYHIX-47407
DECLARE

v_before_count NUMBER := 0;
v_delete_count NUMBER := 0;
v_after_count  NUMBER := 0;

BEGIN

  SELECT COUNT(0)  -- 3 records
  INTO   v_before_count
  FROM   DP_SCORECARD.SC_AUDIT_LWOP
  WHERE  (staff_staff_id in ('16791','11311') and TRUNC(LWOP_OCCURRENCE_DATE) = '25-JAN-19')
  OR     (staff_staff_id in ('17277') and TRUNC(LWOP_OCCURRENCE_DATE) = '26-JAN-19');

  dbms_output.put_line('Before record count: '||v_before_count);

  IF v_before_count > 0
  THEN

    DELETE FROM DP_SCORECARD.SC_AUDIT_LWOP
    WHERE  (staff_staff_id in ('16791','11311') and TRUNC(LWOP_OCCURRENCE_DATE) = '25-JAN-19')
    OR     (staff_staff_id in ('17277') and TRUNC(LWOP_OCCURRENCE_DATE) = '26-JAN-19');

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

    dbms_output.put_line('Do not commit unless the number of deleted records is equal to 3');

  ELSE

    dbms_output.put_line('No records found, skip the delete');

  END IF;

  SELECT COUNT(0)  -- should be zero records
  INTO   v_after_count
  FROM DP_SCORECARD.SC_AUDIT_LWOP
  WHERE  (staff_staff_id in ('16791','11311') and TRUNC(LWOP_OCCURRENCE_DATE) = '25-JAN-19')
  OR     (staff_staff_id in ('17277') and TRUNC(LWOP_OCCURRENCE_DATE) = '26-JAN-19');

  dbms_output.put_line('After record count (will be zero after the commit is performed): '||v_after_count);

END;
/
