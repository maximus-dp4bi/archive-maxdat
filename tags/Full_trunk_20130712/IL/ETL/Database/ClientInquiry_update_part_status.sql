-- 6/3 Stamp participant status from semantic table
DECLARE
  v_cnt INTEGER := 0;
BEGIN
  FOR curr IN (SELECT contact_record_id, participant_status FROM d_sci_current)
  LOOP UPDATE corp_etl_client_inquiry
          SET participant_status = curr.participant_status
        WHERE contact_record_id = curr.contact_record_id;
       --
       v_cnt := v_cnt + 1;
       IF v_cnt = 500
       THEN COMMIT; v_cnt := 0;
       END IF;
  END LOOP;
  COMMIT;
END;
/